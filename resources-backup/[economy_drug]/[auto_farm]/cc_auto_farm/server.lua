ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local selectedItems = {}

RegisterServerEvent('doneAutoFarm')
AddEventHandler('doneAutoFarm', function(currentAutoFarm)
    local xPlayer = ESX.GetPlayerFromId(source)
    doneAutoFarmHandler(currentAutoFarm, xPlayer)
end)

function doneAutoFarmHandler(currentAutoFarm,xPlayer)
    if type(selectedItems[xPlayer.source]) == "nil" then
        initUI(xPlayer,currentAutoFarm)
    end

    if exports.cc_coreeffect:coreEffectCheckTime(xPlayer,'auto_farm') <= 0 then
        clearState(xPlayer.source)
        expireTimeItem(xPlayer.source)
        xPlayer.triggerEvent('preparestopAutoFarm')
        return
    end

    local statusBonus = calculateBonus(xPlayer,currentAutoFarm)
    if not statusBonus then
        baseItem(xPlayer, currentAutoFarm)
    end
    xPlayer.triggerEvent('ongoingAutoFarm')
    pcall(function()-- Start Log
        exports['azael_dc-serverlogs']:insertData({
            event = 'DoneAutoFarm',
            content = ('%s ได้ทำการเก็บ Auto Farm %s สำเร็จ'):format(xPlayer.name, currentAutoFarm),
            source = xPlayer.source,
        })
    end)-- End Log
end

function clearState(source)
    selectedItems[source] = nil
end

ESX.RegisterServerCallback('checkExpireItem', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if exports.cc_coreeffect:coreEffectCheckTime(xPlayer,'auto_farm') <= 0 then
        expireTimeItem(xPlayer.source)
        cb(false)
        return
    end
    cb(true)
end)

function initUI(xPlayer,currentAutoFarm)
    -- init ui
    if type(selectedItems[xPlayer.source]) == "nil" then
        selectedItems[xPlayer.source] = {}
        --print("before currentfarm")
        for _, v in pairs(Config.AutoFarmInfoServer) do
            if currentAutoFarm == v.name then
                --print("true currentfarm")
                local itemNames = v.getItemName
                for _, itemName in ipairs(itemNames) do
                    local xItem = xPlayer.getInventoryItem(itemName)
                    selectedItems[xPlayer.source][itemName] = {}
                    selectedItems[xPlayer.source][itemName].quantity = 0
                    selectedItems[xPlayer.source][itemName].name = itemName
                    selectedItems[xPlayer.source][itemName].label = xItem.label
                    --print(selectedItems[xPlayer.source][itemName].quantity)
                    --print(selectedItems[xPlayer.source][itemName].name)
                    --print(selectedItems[xPlayer.source][itemName].label)
                end

                local getItemBonus = v.getItemBonus
                if getItemBonus ~= nil then
                    for _, bonusItemName in ipairs(getItemBonus) do
                        local xItem = xPlayer.getInventoryItem(bonusItemName.itemName)
                        selectedItems[xPlayer.source][bonusItemName.itemName] = {}
                        selectedItems[xPlayer.source][bonusItemName.itemName].quantity = 0
                        selectedItems[xPlayer.source][bonusItemName.itemName].name = bonusItemName.itemName
                        selectedItems[xPlayer.source][bonusItemName.itemName].label = xItem.label
                        --print(selectedItems[xPlayer.source][bonusItemName.itemName].quantity)
                        --print(selectedItems[xPlayer.source][bonusItemName.itemName].name)
                        --print(selectedItems[xPlayer.source][bonusItemName.itemName].label)
                    end
                end

                local getItemBonusSecond = v.getItemBonusSecond
                if getItemBonusSecond ~= nil then
                    for _, bonusItemNameSecond in ipairs(getItemBonusSecond) do
                        local xItem = xPlayer.getInventoryItem(bonusItemNameSecond)
                        selectedItems[xPlayer.source][bonusItemNameSecond] = {}
                        selectedItems[xPlayer.source][bonusItemNameSecond].quantity = 0
                        selectedItems[xPlayer.source][bonusItemNameSecond].name = bonusItemNameSecond
                        selectedItems[xPlayer.source][bonusItemNameSecond].label = xItem.label
                        --print(selectedItems[xPlayer.source][bonusItemName.itemName].quantity)
                        --print(selectedItems[xPlayer.source][bonusItemName.itemName].name)
                        --print(selectedItems[xPlayer.source][bonusItemName.itemName].label)
                    end
                end
                xPlayer.triggerEvent('cc_auto_farm:initUI', selectedItems[xPlayer.source])
            end
        end
    end
end


ESX.RegisterServerCallback('checkWeight', function(source, cb,currentAutoFarm)
    local xPlayer = ESX.GetPlayerFromId(source)
    for _,v in pairs(Config.AutoFarmInfoServer) do
        if v.name == currentAutoFarm then
            local xItemCount = math.random(v.getItemCount[1], v.getItemCount[2])
            local tbl = v.getItemName
            local itemBaseRand = tbl[math.random(1, #tbl)]
            local xItem = xPlayer.getInventoryItem(itemBaseRand)
            if xPlayer.canCarryItem(xItem.name, xItemCount) or exports.cc_coreeffect:coreEffectCheckTime(xPlayer,'auto_farm') > 0  then
                initUI(xPlayer,currentAutoFarm)
                cb(true)
                return
            end
            onMaxWeight(xPlayer.source)
            cb(false)
            return
        end
    end
    cb(false)
end)


function calculateBonus(xPlayer,currentAutoFarm)
    local getBonus = false
    for _,v in pairs(Config.AutoFarmInfoServer) do
		if v.name == currentAutoFarm then
            if v.getItemBonus ~= nil then
                local xItemBonusRate = math.random(1, 100000)/100000
                --print("1st Bonus : "..xItemBonusRate)
                for _,v in pairs(v.getItemBonus) do
                    if xItemBonusRate <= v.percent then
                        local xItemBonus = xPlayer.getInventoryItem(v.itemName)
                        givebonusitem(xPlayer, xItemBonus)
                        getBonus = true
                        break 
                    end
                end
            end

            if v.getItemBonusSecond ~= nil then
                local xItemBonusSecondRate = math.random(1, 100000)/100000
                local tblSecond = v.getItemBonusSecond
                local itemBonusSecondRand = tblSecond[math.random(1, #tblSecond)]
                --print('2rd Bonus : '..xItemBonusSecondRate)
                if xItemBonusSecondRate <= v.getItemBonusSecondPercent then
                    local xItemBonusSecond = xPlayer.getInventoryItem(itemBonusSecondRand)
                    givebonusitem(xPlayer, xItemBonusSecond)
                    getBonus = true
                end
            end
            return getBonus
        end
    end
    return getBonus
end

function givebonusitem(xPlayer, currentBonus)
    if xPlayer.canCarryItem(currentBonus.name, 1) or exports.cc_coreeffect:coreEffectCheckTime(xPlayer,'auto_farm') > 0 then
        xPlayer.addInventoryItem(currentBonus.name, 1)
        pcall(function()-- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'ReceivedAutoFarmBounsItem',
                content = ('%s ได้รับ %s จำนวน 1 ชิ้นจากการนั่งณาน'):format(xPlayer.name, currentBonus.name),
                source = xPlayer.source,
            })
        end)-- End Log
        selectedItems[xPlayer.source][currentBonus.name].quantity = 1 + selectedItems[xPlayer.source][currentBonus.name].quantity
        xPlayer.triggerEvent('cc_auto_farm:updateUI',selectedItems[xPlayer.source])
    else
        onMaxWeight(xPlayer.source)
        xPlayer.triggerEvent('preparestopAutoFarm')  
    end
end

function baseItem(xPlayer, currentAutoFarm)
    for _,v in pairs(Config.AutoFarmInfoServer) do
        if v.name == currentAutoFarm then
            local xItemCount = math.random(v.getItemCount[1], v.getItemCount[2]) 
            local tbl = v.getItemName
            local itemBaseRand = tbl[math.random(1, #tbl)]
            local xItem = xPlayer.getInventoryItem(itemBaseRand)
            if xPlayer.canCarryItem(xItem.name, xItemCount) or exports.cc_coreeffect:coreEffectCheckTime(xPlayer,'auto_farm') > 0  then
                xPlayer.addInventoryItem(xItem.name, xItemCount)
                pcall(function()-- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'ReceivedAutoFarmItem',
                        content = ('%s ได้รับ %s จำนวน %s ชิ้นจากการนั่งณาน'):format(xPlayer.name, xItem.name, xItemCount),
                        source = xPlayer.source,
                    })
                end)-- End Log
                selectedItems[xPlayer.source][xItem.name].quantity = xItemCount + selectedItems[xPlayer.source][xItem.name].quantity
                xPlayer.triggerEvent('cc_auto_farm:updateUI',selectedItems[xPlayer.source])
            else
                onMaxWeight(xPlayer.source)
                xPlayer.triggerEvent('preparestopAutoFarm')
            end
        end
    end
end

function onMaxWeight(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบ Auto Farm', -- หัวเรื่อง
        description = 'น้ำหนักกระเป๋าเต็ม', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'error',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'inventory_max', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function expireTimeItem(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบ Auto Farm', -- หัวเรื่อง
        description = 'คุณไม่มีไอเทมที่กำหนดไว้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

RegisterServerEvent('cc_auto_farm:cancelFromClient')
AddEventHandler('cc_auto_farm:cancelFromClient', function()
    local xPlayer	= ESX.GetPlayerFromId(source)
    clearState(xPlayer.source)
end)

AddEventHandler('playerDropped', function()
    local playerId = source
    if playerId then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then
            clearState(xPlayer.source)
        end
        collectgarbage()
    end
end)