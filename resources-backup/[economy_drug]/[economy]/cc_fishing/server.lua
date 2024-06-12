ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('checkRodBait', function(source, cb, currentfishingzone)
    local xPlayer = ESX.GetPlayerFromId(source)
    for _,v in pairs(Config.FishingInfoServer) do
        if v.name == currentfishingzone then
            local xItemRod = xPlayer.getInventoryItem(v.useItemRod.itemName)
            local xItemBait = xPlayer.getInventoryItem(v.useItemBait.itemName)
            if xItemRod.count < v.useItemRod.itemCount then
                --print("no rod")
                cb(false)
                onNoItemtoUse(xPlayer.source)
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'CheckFishingRod',
                        content = ('%s มี %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, xItemRod.name, xItemRod.count),
                        source = xPlayer.source,
                    })
                 end) -- End log
                return
            end

            if xItemBait.count < v.useItemBait.itemCount then
                --print("no bait")
                cb(false)
                onNoItemtoUse(xPlayer.source)
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'CheckFishingBait',
                        content = ('%s มี %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, xItemBait.name, xItemBait.count),
                        source = xPlayer.source,
                    })
                 end) -- End log
                return
            end

            if v.useitemSpecial.enable == true then
                local xItemSpecial = xPlayer.getInventoryItem(v.useitemSpecial.itemName)
                if xItemSpecial.count < v.useitemSpecial.itemCount then
                    --print("no special")
                    cb(false)
                    onNoItemtoUse(xPlayer.source)
                    pcall(function() -- Start log
                        exports['azael_dc-serverlogs']:insertData({
                            event = 'CheckLightBlub',
                            content = ('%s มี %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, xItemSpecial.name, xItemSpecial.count),
                            source = xPlayer.source,
                        })
                     end) -- End log
                    return
                end
            end
            cb(true)
            return
        end
    end
    cb(false)
end)

RegisterServerEvent('succesMiniGame')
AddEventHandler('succesMiniGame', function(currentfishingzone)
    local countSpecial = 0
    for _,v in pairs(Config.FishingInfoServer) do
        if v.name == currentfishingzone then
            local xPlayer	= ESX.GetPlayerFromId(source)
            local brokenRodRate = math.random(1, 100000)/100000
            --print(brokenRodRate.." success rod rate")

            local useRod = xPlayer.getInventoryItem(v.useItemRod.itemName)
            local useBait = xPlayer.getInventoryItem(v.useItemBait.itemName)
            if v.useitemSpecial.enable == true then
                local usespecial = xPlayer.getInventoryItem(v.useitemSpecial.itemName)
                countSpecial = usespecial.count
            end

            if v.useitemSpecial.enable == false then
                countSpecial = 1
            end
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'PlayMiniGameSuccess',
                    content = ('%s ได้เล่น Mini Game สำเร็จ'):format(xPlayer.name),
                    source = xPlayer.source,
                })
             end) -- End log
            if useRod.count > 0 and useBait.count > 0 and countSpecial > 0 then
                if brokenRodRate <= v.useItemRod.brokenRate  then
                    xPlayer.removeInventoryItem(v.useItemRod.itemName, v.useItemRod.itemCount)
                    pcall(function() -- Start log
                        exports['azael_dc-serverlogs']:insertData({
                            event = 'FishingRodBroken',
                            content = ('%s ได้สูญเสีย %s จำนวน %s ชิ้น เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, v.useItemRod.itemName, v.useItemRod.itemCount, useRod.name ,xPlayer.getInventoryItem(v.useItemRod.itemName).count),
                            source = xPlayer.source,
                        })
                     end) -- End log
                    TriggerClientEvent('cc_fishing:BrokenRod', source)
                end

                xPlayer.removeInventoryItem(v.useItemBait.itemName, v.useItemBait.itemCount)
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'RemoveFishingBait',
                        content = ('%s ได้สูญเสีย %s จำนวน %s ชิ้น เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, v.useItemBait.itemName, v.useItemBait.itemCount, useBait.name , xPlayer.getInventoryItem(v.useItemBait.itemName).count),
                        source = xPlayer.source,
                    })
                 end) -- End log

                if v.useitemSpecial.enable == true then
                    local brokenSpecialRate = math.random(1, 100000)/100000
                    --print(brokenSpecialRate.." success special rate")
                    if brokenSpecialRate <= v.useitemSpecial.brokenRate then
                        xPlayer.removeInventoryItem(v.useitemSpecial.itemName, v.useitemSpecial.itemCount)
                        pcall(function() -- Start log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'LightBulbBroken',
                                content = ('%s ได้สูญเสีย %s จำนวน %s ชิ้น เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, v.useitemSpecial.itemName, v.useitemSpecial.itemCount, usespecial.name , xPlayer.getInventoryItem(v.useitemSpecial.itemName).count),
                                source = xPlayer.source,
                            })
                         end) -- End log
                    end
                end
                
                if v.getItem ~= nil then
                    local xItemRate = math.random(1, 100000)/100000
                    --print(xItemRate)
                    local matchingItems = {}
                    local minMatchingPercent = 1.0
        
                    for _, v in pairs(v.getItem) do
                        if xItemRate <= v.percent then
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
                        local addItemCount = math.random(randomItem.quantity[1], randomItem.quantity[2])
                        if xPlayer.canCarryItem(randomItem.itemName, addItemCount) then
                            xPlayer.addInventoryItem(randomItem.itemName, addItemCount)
                            pcall(function() -- Start log
                                exports['azael_dc-serverlogs']:insertData({
                                    event = 'ReceivedFishingItem',
                                    content = ('%s ได้รับ %s จำนวน 1 ชิ้น'):format(xPlayer.name, randomItem.itemName),
                                    source = xPlayer.source,
                                })
                             end) -- End log
                        else
                            onMaxInventory(xPlayer.source)
                            pcall(function() -- Start log
                                exports['azael_dc-serverlogs']:insertData({
                                    event = 'OverWeightFishing',
                                    content = ('%s ไม่สามารถได้รับ %s จำนวน 1 ชิ้น เนื่องจากน้ำหนักกระเป๋าเต็ม'):format(xPlayer.name, randomItem.itemName),
                                    source = xPlayer.source,
                                })
                             end) -- End log
                        end
                    end
                end

                if v.getItemBonus ~= nil then
                    local xItemBonusRate = math.random(1, 100000)/100000
                    --print(xItemBonusRate)
                    local matchingBonusItems = {}
                    local minMatchingBonusPercent = 1.0
        
                    for _, v in pairs(v.getItemBonus) do
                        if xItemBonusRate <= v.percent then
                            table.insert(matchingBonusItems, v)
                            if v.percent < minMatchingBonusPercent then
                                minMatchingBonusPercent = v.percent
                            end
                        end
                    end
        
                    local finalMatchingBonusItems = {}
                    for _, v in pairs(matchingBonusItems) do
                        if v.percent == minMatchingBonusPercent then
                            table.insert(finalMatchingBonusItems, v)
                        end
                    end
        
        
                    if #finalMatchingBonusItems > 0 then
                        local randomBonusIndex = math.random(1, #finalMatchingBonusItems)
                        local randomBonusItem = finalMatchingBonusItems[randomBonusIndex]
                        local addItemCount = math.random(randomBonusItem.quantity[1], randomBonusItem.quantity[2])
                        if xPlayer.canCarryItem(randomBonusItem.itemName, addItemCount) then
                            xPlayer.addInventoryItem(randomBonusItem.itemName, addItemCount)    
                        else
                            onMaxInventory(xPlayer.source)
                        end
                    end
                end
            end
        end
    end
end)

RegisterServerEvent('failMiniGame')
AddEventHandler('failMiniGame', function(currentfishingzone)
    local countSpecial = 0
    for _,v in pairs(Config.FishingInfoServer) do
        if v.name == currentfishingzone then
            local xPlayer	= ESX.GetPlayerFromId(source)
            local brokenRodRate = math.random(1, 100000)/100000
            --print(brokenRodRate.." fail rod rate")

            local useRod = xPlayer.getInventoryItem(v.useItemRod.itemName)
            local useBait = xPlayer.getInventoryItem(v.useItemBait.itemName)
            if v.useitemSpecial.enable == true then
                local usespecial = xPlayer.getInventoryItem(v.useitemSpecial.itemName)
                countSpecial = usespecial.count
            end

            if v.useitemSpecial.enable == false then
                countSpecial = 1
            end
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'PlayMiniGameFail',
                    content = ('%s ได้เล่น Mini Game ล้มเหลว'):format(xPlayer.name),
                    source = xPlayer.source,
                })
             end) -- End log
            if useRod.count > 0 and useBait.count > 0 and countSpecial > 0 then
                if brokenRodRate <= v.useItemRod.brokenRateFail  then
                    xPlayer.removeInventoryItem(v.useItemRod.itemName, v.useItemRod.itemCount)
                    pcall(function() -- Start log
                        exports['azael_dc-serverlogs']:insertData({
                            event = 'FishingRodBroken',
                            content = ('%s ได้สูญเสีย %s จำนวน %s ชิ้น เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, v.useItemRod.itemName, v.useItemRod.itemCount, useRod.name ,xPlayer.getInventoryItem(v.useItemRod.itemName).count),
                            source = xPlayer.source,
                        })
                     end) -- End log
                    TriggerClientEvent('cc_fishing:BrokenRod', source)
                end

                xPlayer.removeInventoryItem(v.useItemBait.itemName, v.useItemBait.itemCount)
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'RemoveFishingBait',
                        content = ('%s ได้สูญเสีย %s จำนวน %s ชิ้น เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, v.useItemBait.itemName, v.useItemBait.itemCount, useBait.name , xPlayer.getInventoryItem(v.useItemBait.itemName).count),
                        source = xPlayer.source,
                    })
                 end) -- End log

                if v.useitemSpecial.enable == true then
                    local brokenSpecialRate = math.random(1, 100000)/100000
                    --print(brokenSpecialRate.." fail special rate")
                    if brokenSpecialRate <= v.useitemSpecial.brokenRateFail then
                        xPlayer.removeInventoryItem(v.useitemSpecial.itemName, v.useitemSpecial.itemCount)
                        pcall(function() -- Start log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'LightBulbBroken',
                                content = ('%s ได้สูญเสีย %s จำนวน %s ชิ้น เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, v.useitemSpecial.itemName, v.useitemSpecial.itemCount, usespecial.name , xPlayer.getInventoryItem(v.useitemSpecial.itemName).count),
                                source = xPlayer.source,
                            })
                         end) -- End log
                    end
                end  
            end
        end
    end
end)

ESX.RegisterServerCallback('cc_fishing:checkCardFinshing', function(source, cb, currentfishingzone ,fishingTime)
    local xPlayer = ESX.GetPlayerFromId(source)
    for _,v in pairs(Config.FishingInfoServer) do
        if v.name == currentfishingzone then
            if v.jobBuff == true then
                local calculateFishingtime = exports.cc_corejob:coreJobCalculatefishingTime(xPlayer, fishingTime)
                --print(calculatePicktime)
                cb(calculateFishingtime)
                return
            end
        end
    end
    cb(picktimeStatic)
end)


function onNoItemtoUse(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบตกปลา', -- หัวเรื่อง
        description = 'คุณไม่มีไอเทมที่กำหนด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function onMaxInventory(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบน้ำหนัก', -- หัวเรื่อง
        description = 'น้ำหนักกระเป๋าไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'inventory_max', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end