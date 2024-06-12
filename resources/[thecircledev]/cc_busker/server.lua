local playerBusker = {}
local alreadyAction = {}
ESX.RegisterUsableItem('busker', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    --print(xPlayer.source)
    local xItem = xPlayer.getInventoryItem("busker")
    initBusker(xPlayer,xItem)
end)

function initBusker(xPlayer,xItem)
    local playerCoords = GetEntityCoords(GetPlayerPed(xPlayer.source))
    if playerBusker[xPlayer.source] ~= nil then return end
    if xItem.count > 0 then
        ESX.OneSync.SpawnObject('prop_busker_hat_01', vector3(playerCoords.x, playerCoords.y, playerCoords.z-0.9), 0, function(Object)
            TriggerClientEvent("cc_busker:animation", xPlayer.source)
            Wait(400)
            --print("before"..xPlayer.source)
            playerBusker[xPlayer.source] = {
                money = 0,
                id = xPlayer.source,
                position = playerCoords,
                entity = NetworkGetEntityFromNetworkId(Object),
                netId = Object,
            }
            Wait(400)
            --print("after"..playerBusker[xPlayer.source].id)
            TriggerClientEvent("cc_busker:syncBusker", -1, playerBusker)
        end)
    end
end

ESX.RegisterServerCallback('cc_busker:getBuskerBack', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

     if alreadyAction[source] == true then
        --doing log check macro phase
        exports.nc_notify:PushNotification(source,{
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบเปิดหมวก', -- หัวเรื่อง
            description = 'ระบบกำลังปกป้องตนเอง', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'danger', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'default', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 5000 -- ระยะเวลาการแสดง Notify
        })
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'MacroSpam',
                content = ('%s ได้ทำการกดการกระทำ %s จำนวนหลายครั้งภายในเวลาอันสั้น'):format(xPlayer.name, items.name),
                source = xPlayer.source,
            })
        end) -- End log
        cb(false)
        return
    end
    alreadyAction[source] = true

    if type(playerBusker[source]) ~= "nil" then
        local entity = playerBusker[xPlayer.source].entity
        if tonumber(playerBusker[xPlayer.source].money) > 0 then
            xPlayer.addMoney(tonumber(playerBusker[xPlayer.source].money))
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'ReceivedMoneyFromBusker',
                    content = ('%s ได้รับเงินจำนวน $%s จากการเก็บหมวกนักร้อง'):format(xPlayer.name, tonumber(playerBusker[xPlayer.source].money)),
                    source = xPlayer.source,
                })
            end) -- End log
        end
        Citizen.CreateThread(function()
            while DoesEntityExist(entity) do
                Citizen.Wait(7)
                if DoesEntityExist(entity) then
                    DeleteEntity(entity)
                end
            end
            Citizen.Wait(400)
            playerBusker[xPlayer.source] = nil
            Citizen.Wait(400)
            playerBusker[xPlayer.source] = nil
            Citizen.Wait(400)
            TriggerClientEvent("cc_busker:syncBusker", -1, playerBusker)
            alreadyAction[source] = false
        end)
    end
    cb(true)
end)



ESX.RegisterServerCallback('cc_busker:giveMoney', function(source, cb, money,targetID)
    local xPlayer = ESX.GetPlayerFromId(source)
    money = tonumber(money)
    if xPlayer.getMoney() >= money then
        -- print(money)
        -- print(targetID)
        xPlayer.removeMoney(money)
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'GiveMoneyToBusker',
                content = ('%s ได้ทำการใส่เงินจำนวน $%s ในหมวกของนักร้อง %s สูญเสียเงินจำนวน $%s เหลือเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, money, GetPlayerName(targetID), money, ESX.Math.GroupDigits(xPlayer.getMoney())),
                source = xPlayer.source,
            })
        end) -- End log
        Wait(400)
        if type(playerBusker[targetID]) ~= "nil" then
            playerBusker[targetID].money = playerBusker[targetID].money + money
        end
        TriggerClientEvent("cc_busker:syncBusker", -1, playerBusker)
        cb(true)
    end
    cb(false)
end)



AddEventHandler("playerDropped", function()
    if type(playerBusker[source]) ~= "nil" then
        local source = source
        local entity = playerBusker[source].entity
        Citizen.CreateThread(function()
            while DoesEntityExist(entity) do
                Citizen.Wait(7)
                if DoesEntityExist(entity) then
                    DeleteEntity(entity)
                end
            end
            playerBusker[source] = nil
            Wait(300)
            TriggerClientEvent("cc_busker:syncBusker", -1, playerBusker)
        end)
    end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
    playerId = tonumber(playerId)
    if type(playerBusker[playerId]) ~= "nil" then
        local entity = playerBusker[playerId].entity
        Citizen.CreateThread(function()
            while DoesEntityExist(entity) do
                Citizen.Wait(7)
                if DoesEntityExist(entity) then
                    DeleteEntity(entity)
                end
            end
            playerBusker[playerId] = nil
            Wait(300)
            TriggerClientEvent("cc_busker:syncBusker", -1, playerBusker)
        end)
    end
end)

AddEventHandler('esx:playerLogout', function(source)
    source = tonumber(source)
    local entity = playerBusker[playerId].entity
    Citizen.CreateThread(function()
        while DoesEntityExist(entity) do
            Citizen.Wait(7)
            if DoesEntityExist(entity) then
                DeleteEntity(entity)
            end
        end
        playerBusker[source] = nil
        Wait(300)
        TriggerClientEvent("cc_busker:syncBusker", -1, playerBusker)
    end)
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        for _,v in pairs(playerBusker) do
            DeleteEntity(v.entity)
        end
    end
end)