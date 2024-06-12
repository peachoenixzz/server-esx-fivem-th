ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local coolDown = {}
ESX.RegisterServerCallback('cc_houserobberry:checkkeyCard', function(source, cb, name)
    local xPlayer = ESX.GetPlayerFromId(source)

    --bad validate
    for _, cooldown in ipairs(coolDown) do
        if cooldown.name == name then
            TriggerClientEvent('cc_houseRobbery:updateConfigEntrance', -1, cooldown.name, true)
            cb(false,false)
            return
        end
    end

    for _,v in pairs(Config.keycard) do
        local keycardhave = xPlayer.getInventoryItem(v.itemName)
        if keycardhave.count > 0 then
            --print(keycardhave.name)
            cb(true,true)
            return
        end
    end
    cb(false,true)
end)

ESX.RegisterServerCallback('cc_houserobberry:statrobminigameSussces', function(source, cb, name)
    local xPlayer = ESX.GetPlayerFromId(source)
    for _,v in pairs(Config.keycard) do
        local keycardhave = xPlayer.getInventoryItem(v.itemName)
        if keycardhave.count > 0 then
            onCoolDown(name,function(res)
                if not res then
                    cb(res)
                    return
                end
                xPlayer.removeInventoryItem(keycardhave.name, 1)
                pcall(function()-- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'RemoveHouseKeyCard',
                        content = ('%s ได้สูญเสีย %s จำนวน 1 ใบจากการเข้างัดบ้านเหลือ %s ในกระเป๋าจำนวน %s ใบ'):format(xPlayer.name, keycardhave.name, keycardhave.name, xPlayer.getInventoryItem(v.itemName).count),
                        source = xPlayer.source,
                    })
                end)-- End Log
                xPlayer.addInventoryItem(v.getkeyName, 1)
                pcall(function()-- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'ReceivedSafeKey',
                        content = ('%s ได้สูญเสีย %s จำนวน 1 ชิ้นจากการเข้างัดบ้านเหลือ %s ในกระเป๋าจำนวน %s ชิ้น'):format(xPlayer.name, v.getkeyName, v.getkeyName, xPlayer.getInventoryItem(v.getkeyName).count),
                        source = xPlayer.source,
                    })
                end)-- End Log
                exports.cc_coreeffect:createDebuff(xPlayer, "house_rob_time", 300000, "house_rob_time" ,'show')
                TriggerClientEvent('cc_houseRobbery:updateConfigEntrance', -1, name, true)
                cb(res)
                return
            end)
        end
    end
end)

local isCoolDownLoopRunning = false
function onCoolDown(name ,cb)
    -- Adding a new cooldown
    for _, cooldown in ipairs(coolDown) do
        if cooldown.name == name then
            TriggerClientEvent('cc_houseRobbery:updateConfigEntrance', -1, cooldown.name, true)
            cb(false)
            return
        end
    end

    -- If name doesn't exist in the table, add a new cooldown
    local result = {
        time = 3600000, -- 1 hours in milliseconds
        name = name,
    }
    table.insert(coolDown, result)

    cb(true)
    -- Check if loop is already running
    if not isCoolDownLoopRunning then
        isCoolDownLoopRunning = true

        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(60000)
                for i, cooldown in ipairs(coolDown) do
                    if cooldown.time > 0 then
                        cooldown.time = cooldown.time - 60000
                    else
                        TriggerClientEvent('cc_houseRobbery:updateConfigEntrance', -1, cooldown.name, false)
                        table.remove(coolDown, i)
                    end
                end

                if #coolDown == 0 then
                    isCoolDownLoopRunning = false
                    break -- Exit the loop
                end
            end
        end)
    end
end

RegisterServerEvent('cc_houserobberry:statrobminigameFail')
AddEventHandler('cc_houserobberry:statrobminigameFail', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    for _,v in pairs(Config.keycard) do
        local keycardhave = xPlayer.getInventoryItem(v.itemName)
        if keycardhave.count > 0 then
            local brokenKeyCard = math.random(1, 100000)/100000
            --print(brokenKeyCard)
            if brokenKeyCard < 0.30 then
                xPlayer.removeInventoryItem(keycardhave.name, 1)
                pcall(function()-- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'RemoveHouseRequireItemFailMiniGame',
                        content = ('%s สูญเสีย %s จำนวน 1 ชิ้น จากการเล่นมินิเกมส์พลาด เหลือ %s ในกระเป๋าจำนวน %s ชิ้น และ โอกาสในการแตก คือ %s < 30'):format(xPlayer.name,  keycardhave.name,  keycardhave.name, xPlayer.getInventoryItem(v.itemName).count, brokenKeyCard),
                        source = xPlayer.source,
                    })
                end)-- End Log
                return
            end
            return
        end
    end
end)

RegisterServerEvent('cc_houserobberry:exitHouse')
AddEventHandler('cc_houserobberry:exitHouse', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local robTime = exports.cc_coreeffect:coreEffectCheckTimeRealTime(xPlayer,'house_rob_time')
    local forceExitTime = exports.cc_coreeffect:coreEffectCheckTimeRealTime(xPlayer,'house_rob_forceexit')

    if robTime > 0 then
        exports.cc_coreeffect:deleteEffectByESXPlayer(xPlayer,'house_rob_time')
    end

    if forceExitTime > 0 then
        exports.cc_coreeffect:deleteEffectByESXPlayer(xPlayer,'house_rob_forceexit')
    end

    for _,v in pairs(Config.keycard) do
        local keyhave = xPlayer.getInventoryItem(v.getkeyName)
        if keyhave.count > 0 then
            xPlayer.removeInventoryItem(keyhave.name, keyhave.count)
            pcall(function()-- Start Log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'RemoveHouseRequireItemForExit',
                    content = ('%s ได้ทำการออกจากบ้านและไอเทมถูกลบ ไอเทมที่ถูกลบคือ %s จำนวน %s ชิ้น '):format(xPlayer.name, keyhave.name, keyhave.count),
                    source = xPlayer.source,
                })
            end)-- End Log
        end
    end
end)

ESX.RegisterServerCallback('cc_houserobberry:giveitemHouseRobSearch', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    calculateHouseRobSearch(xPlayer)
    cb(true)
end)

function calculateHouseRobSearch(xPlayer)
    local count = math.random(3, 5)
    local selectedNames = {}
    local insertedItems = {}
    local matchingItems = {}
    local minMatchingPercent = 1.0
    
    for i = 1, 100 do
        if count == 0 then
            break
        end
        local xItemBonusRate = math.random(1, 100000)/100000
        for _, v in pairs(Config.HouseRobSearch) do
            if xItemBonusRate <= v.percent then
                table.insert(matchingItems, v)
                if v.percent < minMatchingPercent then
                    minMatchingPercent = v.percent
                end
            end
        end
                
        local finalMatchingItems = {}
        for _, v in pairs(matchingItems) do
            if v.percent == minMatchingPercent then
                table.insert(finalMatchingItems, v)
            end
        end
                    
        if #finalMatchingItems > 0 then
            local randomIndex = math.random(1, #finalMatchingItems)
            local randomItem = finalMatchingItems[randomIndex]
            if not insertedItems[randomItem.itemName] then
                table.insert(selectedNames, randomItem)
                insertedItems[randomItem.itemName] = true
                count = count - 1
            end
        end
    end

    for _, v in pairs(selectedNames) do
        xQuantity = math.random(v.quantity[1], v.quantity[2])
        if v.itemName == "black_money" or v.itemName == "money" then
            xPlayer.addAccountMoney(v.itemName, xQuantity)
        else
            if xPlayer.canCarryItem(v.itemName, xQuantity) then
                xPlayer.addInventoryItem(v.itemName, xQuantity)
                pcall(function()-- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'ReceivedItemHouseRobSearch',
                        content = ('%s ได้รับไอเทมจากการค้นหาของในบ้าน คือ %s จำนวน %s ชิ้น'):format(xPlayer.name, v.itemName, xQuantity),
                        source = xPlayer.source,
                    })
                end)-- End Log
            end
            if not xPlayer.canCarryItem(v.itemName, xQuantity) then
                pcall(function()-- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'OverWeightItemHouseRobSearch',
                        content = ('%s ได้ทำการเล่นค้นหาของในบ้านแต่น้ำหนักกระเป๋าเต็มไอเทมที่ไม่สามารถได้รับ คือ %s จำนวน %s ชิ้น'):format(xPlayer.name, v.itemName, xQuantity),
                        source = xPlayer.source,
                    })
                end)-- End Log
            end
        end
    end
end

ESX.RegisterServerCallback('cc_houserobberry:checkkeyKeytoRob', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    for _,v in pairs(Config.keycard) do
        local keyhave = xPlayer.getInventoryItem(v.getkeyName)
        if keyhave.count > 0 then
            cb(true)
            return
        end
    end
    cb(false)
end)

ESX.RegisterServerCallback('cc_houserobberry:giveitemHouseRobSafeCracker', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    calculteHouseRobSafafeCracker(xPlayer)
    cb(true)
end)

function calculteHouseRobSafafeCracker(xPlayer)
    for _,v in pairs(Config.HouseRobSafe) do
        local keyhave = xPlayer.getInventoryItem(v.keyName)
        if keyhave.count > 0 then

            xPlayer.removeInventoryItem(keyhave.name, 1)

            for _,v in pairs(v.getItem) do
                xQuantity = math.random(v.quantity[1], v.quantity[2])
                if v.itemName == "black_money" or v.itemName == "money" then
                    xPlayer.addAccountMoney(v.itemName, xQuantity)
                else
                    if xPlayer.canCarryItem(v.itemName, xQuantity) then
                        pcall(function()-- Start Log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'ReceivedItemHouseRobSafe',
                                content = ('%s ได้รับไอเทมจากการเล่นเปิดตู้เซฟ คือ %s จำนวน %s ชิ้น'):format(xPlayer.name, v.itemName, xQuantity),
                                source = xPlayer.source,
                            })
                        end)-- End Log
                        xPlayer.addInventoryItem(v.itemName, xQuantity)
                    end
                    if not xPlayer.canCarryItem(v.itemName, xQuantity) then
                        pcall(function()-- Start Log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'OverWeightItemHouseRobSafe',
                                content = ('%s ได้ทำการเล่นเปิดตู้เซฟแต่น้ำหนักกระเป๋าเต็มไอเทมที่ไม่สามารถได้รับ คือ %s จำนวน %s ชิ้น'):format(xPlayer.name, v.itemName, xQuantity),
                                source = xPlayer.source,
                            })
                        end)-- End Log
                    end
                end
            end

            for _,v in pairs(v.randomItem) do
                local xItemBonusRate = math.random(1, 100000)/100000
                --print(xItemBonusRate)
                if xItemBonusRate <= v.percent then
                    if v.itemName == "black_money" or v.itemName == "money" then
                        xPlayer.addAccountMoney(v.itemName, xQuantity)
                    else
                        if xPlayer.canCarryItem(v.itemName, xQuantity) then
                            xPlayer.addInventoryItem(v.itemName, 1)
                            pcall(function()-- Start Log
                                exports['azael_dc-serverlogs']:insertData({
                                    event = 'ReceivedItemHouseRobSafeBonus',
                                    content = ('%s ได้รับไอเทมจากการเล่นเปิดตู้เซฟ คือ %s จำนวน %s ชิ้น'):format(xPlayer.name, v.itemName, xQuantity),
                                    source = xPlayer.source,
                                })
                            end)-- End Log
                        end
                        if not xPlayer.canCarryItem(v.itemName, xQuantity) then
                            pcall(function()-- Start Log
                                exports['azael_dc-serverlogs']:insertData({
                                    event = 'OverWeightItemHouseRobSafeBonus',
                                    content = ('%s ได้ทำการเล่นเปิดตู้เซฟแต่น้ำหนักกระเป๋าเต็มไอเทมที่ไม่สามารถได้รับ คือ %s จำนวน %s ชิ้น'):format(xPlayer.name, v.itemName, xQuantity),
                                    source = xPlayer.source,
                                })
                            end)-- End Log
                        end
                    end
                end
            end
            return
        end
    end
end