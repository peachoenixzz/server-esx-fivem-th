
local trackedPlayers = {}  -- List to track players in a bodybag state.
local isBlipUpdaterActive = false
local isPlayerCheckerActive = false

RegisterServerEvent('cc_prisongps:outPrison')
AddEventHandler('cc_prisongps:outPrison', function()
    local xPlayer =  ESX.GetPlayerFromId(source)
    initCoreEffectGPS(xPlayer, source)
end)

function initCoreEffectGPS(xPlayer)
    local jailtime = exports.cc_coreeffect:coreEffectCheckTimeRealTime(xPlayer,'in_jail')
    if jailtime > 0  then
        local gpstime = exports.cc_coreeffect:coreEffectCheckTimeRealTime(xPlayer,'escape_prison_gps')
        local disruptortime = exports.cc_coreeffect:coreEffectCheckTimeRealTime(xPlayer,'anonymous_gps')
        if gpstime <= 0 and disruptortime <= 0 then
            --print("initGpsTime : "..jailtime)
            exports.cc_coreeffect:createDebuff(xPlayer,'escape_prison_gps',jailtime+60000,'escape_prison_gps','show')
            onOutJailZone(xPlayer.source)
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'PlayerStartPrisonBreak',
                    content = ('%s ได้ทำการแหกคุกและมีสัญญาณ GPS ติดตัว'):format(xPlayer.name),
                    source = xPlayer.source,
                 })
            end) -- End log
            Citizen.Wait(1500)
            table.insert(trackedPlayers, xPlayer.source)
            startBlipUpdater()
        end
    end
end


ESX.RegisterServerCallback('cc_prisongps:checkPrisonJailCoreEffect', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local jailtime = exports.cc_coreeffect:coreEffectCheckTimeRealTime(xPlayer,'in_jail')
    if jailtime > 0  then
        cb(true)
        return
    end
    cb(false)
end)

--===============================================================================================================================================================================================
--===============================================================================================================================================================================================
--===============================================================================================================================================================================================
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(player, xPlayer)
    local gpstime = exports.cc_coreeffect:coreEffectCheckTimeRealTime(xPlayer,'escape_prison_gps')
    if gpstime > 0 then
        Citizen.Wait(1500)
        table.insert(trackedPlayers, xPlayer.source)
        startBlipUpdater()
    end
end)

ESX.RegisterUsableItem('disruptor', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("disruptor")
    if xItem.count > 0 then
        TriggerClientEvent('cc_prisongps:checkPlayerClosest', source)
    end
end)

ESX.RegisterServerCallback('cc_prisongps:checkPrisonGpsCoreEffect', function(source, cb, target)
    local xTarget  = ESX.GetPlayerFromId(target)
    local targetGpsTime = exports.cc_coreeffect:coreEffectCheckTimeRealTime(xTarget,'escape_prison_gps')
    if targetGpsTime > 0  then
        cb(true)
        return
    end
    cb(false)
end)

RegisterServerEvent('cc_prisongps:checkCutPrisonGps')
AddEventHandler('cc_prisongps:checkCutPrisonGps', function(target, playerheading, playerCoords, playerlocation)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget  = ESX.GetPlayerFromId(target)
    local playerped = GetPlayerPed(source)
	local playerCoordsSv = GetEntityCoords(playerped)
    local targetGpsTime = exports.cc_coreeffect:coreEffectCheckTimeRealTime(xTarget,'escape_prison_gps')
    if targetGpsTime > 0  then
        exports.cc_coreeffect:createDebuff(xTarget,'anonymous_gps',targetGpsTime,'anonymous_gps','show')
        exports.cc_coreeffect:deleteEffectByESXPlayer(xTarget,'escape_prison_gps')
        xPlayer.removeInventoryItem("disruptor", 1)
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'UseDisruptorItem',
                content = ('%s ได้ใช้ disruptor กับ %s เพื่อตัดสัญญาณ GPS'):format(xPlayer.name, xTarget.name),
                source = xPlayer.source,
             })
        end) -- End log
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'DisableGps',
                content = ('สัญญาณ GPS ของ %s ได้ตัดเรียบร้อยแล้ว | ผู้ตัดสัญญาณ %s'):format(xTarget.name, xPlayer.name),
                source = xTarget.source,
             })
        end) -- End log
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'RemoveDisruptorItem',
                content = ('%s ได้สูญเสีย disruptor จำนวน 1 ชิ้น เหลือ disruptor ในกระเป๋าจำนวน %s ชิ้น'):format(xPlayer.name, xPlayer.getInventoryItem("disruptor").count),
                source = xPlayer.source,
             })
        end) -- End log
        TriggerClientEvent('cc_prisongps:getDisruptor', target, playerheading, playerCoordsSv, playerlocation)
        TriggerClientEvent('cc_prisongps:doDisruptor', source)
        untrackBlipPrisonGps(target)
        onUntrackGps(xPlayer.source)
        onUntrackGps(xTarget.source)
    end
end)

RegisterServerEvent('cc_prisongps:failMiniGameCutGps')
AddEventHandler('cc_prisongps:failMiniGameCutGps', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem("disruptor", 1)
end)

local function getPlayerCoords(playerId)
    local playerPed = GetPlayerPed(playerId)
    if playerPed then
        return GetEntityCoords(playerPed)
    end
    return nil
end

-- Modify the update function to send coordinates along with player IDs
function startBlipUpdater()
    --print("in fucstionstartBlip")
    if isBlipUpdaterActive then
        return
    end
    isBlipUpdaterActive = true
    Citizen.CreateThread(function()
        while isBlipUpdaterActive do
            Citizen.Wait(1000)
            local playersData = {}
            for _, playerId in ipairs(trackedPlayers) do
                local coords = getPlayerCoords(playerId)
                if coords then
                    table.insert(playersData, {
                        id = playerId,
                        coords = coords
                    })
                end
            end
            local Police = ESX.GetExtendedPlayers("job", "police")
            for _, xPlayer in pairs(Police) do
                if xPlayer.job.name == 'police' then
                    xPlayer.triggerEvent('cc_prisongps:updateprisonGpsBlips', playersData)
                end
            end
            if #trackedPlayers == 0 then
                isBlipUpdaterActive = false
            end
        end
    end)
end

RegisterServerEvent('cc_prisongps:untrackprisonGpsBlip')
AddEventHandler('cc_prisongps:untrackprisonGpsBlip', function()
    untrackBlipPrisonGps(source)
end)

RegisterServerEvent('cc_prisongps:untrackprisonGpsBlipFormUnjail')
AddEventHandler('cc_prisongps:untrackprisonGpsBlipFormUnjail', function(identifier)
    local xTarget = ESX.GetPlayerFromIdentifier(identifier)
    untrackBlipPrisonGps(xTarget.source)
end)

function untrackBlipPrisonGps(target)
    for i = #trackedPlayers, 1, -1 do
        if target == trackedPlayers[i] then
            table.remove(trackedPlayers, i)
        end
    end

    local playersData = {}
    for _, playerId in ipairs(trackedPlayers) do
        local coords = getPlayerCoords(playerId)
        if coords then
            table.insert(playersData, {
                id = playerId,
                coords = coords
            })
        end
    end

    local Police = ESX.GetExtendedPlayers("job", "police")
    for _, xPlayer in pairs(Police) do
        if xPlayer.job.name == 'police' then
            xPlayer.triggerEvent('cc_prisongps:updateprisonGpsBlips', playersData)
        end
    end
end

AddEventHandler('esx:playerDropped', function(playerId)
    untrackBlipPrisonGps(playerId)
end)



function onOutJailZone(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบแหกคุก', -- หัวเรื่อง
        description = 'คุณทำการแหกคุกตำรวจจะมาในไม่ช้า', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'unjail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function onUntrackGps(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบแหกคุก', -- หัวเรื่อง
        description = 'ปลดสัญญาณ GPS เรียบร้อยแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'unjail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end
