ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('giveStaticItem')
AddEventHandler('giveStaticItem', function(currentJobZone)
    calculateStatickItem(currentJobZone)
end)

function calculateStatickItem(currentJobZone)
    for _,v in pairs(Config.JobInfoServer) do
		if v.polyname == currentJobZone then
            local xPlayer	= ESX.GetPlayerFromId(source)
            local coreEffectMultiply = 1
            if v.coreEffect == true then
                local ecoCal = exports.cc_coreeffect:coreEffectCalculateEcoNormal(xPlayer)
                if ecoCal ~= 1 then
                    coreEffectMultiply = ecoCal
                end
            end

            if v.coreEffectMining == true then
                local ecoCal = exports.cc_coreeffect:coreEffectCalculateMiningNormal(xPlayer)
                if ecoCal ~= 1 then
                    coreEffectMultiply = ecoCal
                end
            end
            --print(coreEffectMultiply)
            
            local xItemCount = math.random(v.getItemCount[1], v.getItemCount[2]) * coreEffectMultiply
            local tbl = v.getItemName
            itemBaseRand = tbl[math.random(1, #tbl)]
            local xItem = xPlayer.getInventoryItem(itemBaseRand)
            local xItemBonusRate = math.random(1, 100000)/100000
            --print('BonusRate  '..xItemBonusRate)

            if v.getItemBonusSecond ~= nil then
                --print(v.getItemBonusSecond)
                xItemBonusSecondRate = math.random(1, 100000)/100000
                tblSecond = v.getItemBonusSecond
                itemBonusSecondRand = tblSecond[math.random(1, #tblSecond)]
                xItemBonusSecond = xPlayer.getInventoryItem(itemBonusSecondRand)
                --print('BonusSecondRate  '..xItemBonusSecondRate)
            end
          

            if v.useItem == true then
                local countUseItem = xPlayer.getInventoryItem(v.useItemName)
                local userRandbrokenRate = math.random(1, 100000)/100000
                --print('BronkenRate  '..userRandbrokenRate)
                if countUseItem.count > 0 then
                    --give all items in array
                    if type(v.giveAllItems) == "nil"  then
                        if xPlayer.canCarryItem(xItem.name, xItemCount) then
                            xPlayer.addInventoryItem(xItem.name, xItemCount)
                            pcall(function() -- Start log
                                exports['azael_dc-serverlogs']:insertData({
                                    event = 'RecivedWorkToolsItem',
                                    content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการทำงาน %s เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, xItem.name, xItemCount, xItem.name, v.useItemName, countUseItem.count),
                                    source = xPlayer.source,
                                })
                            end) -- End log
                        else
                            --print("over weight")
                            onOverWeight(xPlayer.source)
                            pcall(function() -- Start log
                                exports['azael_dc-serverlogs']:insertData({
                                    event = 'OverWeightWorkTools',
                                    content = ('%s ไม่สามารถได้รับ %s จำนวน %s ชิ้น จากการทำงาน %s ได้เนื่องจากน้ำหนักกระเป๋าเต็ม'):format(xPlayer.name, xItem.name, xItemCount, xItem.name),
                                    source = xPlayer.source,
                                })
                            end) -- End log
                        end
                    end

                    if type(v.giveAllItems) ~= "nil" then
                        if v.giveAllItems and #tbl > 1 then
                        for _,item in pairs(tbl) do
                                if xPlayer.canCarryItem(item, xItemCount) then
                                    xPlayer.addInventoryItem(item, xItemCount)
                                    pcall(function() -- Start log
                                        exports['azael_dc-serverlogs']:insertData({
                                            event = 'RecivedWorkToolsBothItem',
                                            content = ('%s ได้รับ %s จำนวน %s ชิ้น เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, item, xItemCount, v.useItemName, countUseItem.count),
                                            source = xPlayer.source,
                                        })
                                    end) -- End log
                                else
                                    --print("over weight")
                                    onOverWeight(xPlayer.source)
                                    pcall(function() -- Start log
                                        exports['azael_dc-serverlogs']:insertData({
                                            event = 'OverWeightWorkToolsBoth',
                                            content = ('%s ไม่สามารถได้รับ %s จำนวน %s ชิ้น ได้เนื่องจากน้ำหนักกระเป๋าเต็ม'):format(xPlayer.name, item, xItemCount),
                                            source = xPlayer.source,
                                        })
                                    end) -- End log
                                end
                            end
                        end
                    end

                    if v.getItemBonus ~= nil then
                        local matchingItems = {}
                        local minMatchingPercent = 1.0
            
                        for _, v in pairs(v.getItemBonus) do
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
                            if xPlayer.canCarryItem(randomItem.itemName, 1) then
                                xPlayer.addInventoryItem(randomItem.itemName, 1)
                                pcall(function() -- Start log
                                    exports['azael_dc-serverlogs']:insertData({
                                        event = 'RecivedWorkToolsItemBonus',
                                        content = ('%s ได้รับ %s จำนวน 1 ชิ้น จากการทำงาน %s เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, randomItem.itemName, xItem.name, v.useItemName, countUseItem.count),
                                        source = xPlayer.source,
                                    })
                                end) -- End log
    
                            end
                        end
                    end

                    if v.getItemBonusSecond ~= nil then
                        if xItemBonusSecondRate <= v.getItemBonusSecondPercent then
                            xPlayer.addInventoryItem(xItemBonusSecond.name, 1)
                            pcall(function() -- Start log
                                exports['azael_dc-serverlogs']:insertData({
                                    event = 'RecivedWorkToolsItemBonusSecond',
                                    content = ('%s ได้รับ %s จำนวน 1 ชิ้น จากการทำงาน %s เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, xItemBonusSecond.name, xItem.name, v.useItemName, countUseItem.count),
                                    source = xPlayer.source,
                                })
                            end) -- End log
                        end
                    end

                    if userRandbrokenRate <= v.itemBrokenRate then
                        xPlayer.removeInventoryItem(v.useItemName, 1)
                        TriggerClientEvent('brokenItemLoseHealth', xPlayer.source)
                        pcall(function() -- Start log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'WorkToolsBroken',
                                content = ('%s ได้สูญเสีย %s จำนวน 1 ชิ้น จากการล่า %s เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, v.useItemName, xItem.name, countUseItem.name, xPlayer.getInventoryItem(v.useItemName).count),
                                source = xPlayer.source,
                            })
                        end) -- End log 
                    end
                else
                    --print("no tool")
                    onNoToolsForWork(xPlayer.source)
                    pcall(function() -- Start log
                        exports['azael_dc-serverlogs']:insertData({
                            event = 'NoToolsToWork',
                            content = ('%s ได้พยายามทำการทำงาน %s แต่ไม่มี %s ในกระเป๋า'):format(xPlayer.name, xItem.name, v.useItemName),
                            source = xPlayer.source,
                        })
                    end) -- End log 
                end
            end

            if v.useItem == false then
                if xPlayer.canCarryItem(xItem.name, xItemCount) then
                    xPlayer.addInventoryItem(xItem.name, xItemCount)
                    pcall(function() -- Start log
                        exports['azael_dc-serverlogs']:insertData({
                            event = 'RecivedWorkNoToolItem',
                            content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการทำงาน %s'):format(xPlayer.name, xItem.name, xItemCount, xItem.name),
                            source = xPlayer.source,
                        })
                    end) -- End log
                else
                    --print("over weight")
                    onOverWeight(xPlayer.source)
                    pcall(function() -- Start log
                        exports['azael_dc-serverlogs']:insertData({
                            event = 'OverWeightWorkNoTool',
                            content = ('%s ไม่สามารถได้รับ %s จำนวน %s ชิ้น จากการทำงาน %s ได้เนื่องจากน้ำหนักกระเป๋าเต็ม'):format(xPlayer.name, xItem.name, xItemCount, xItem.name),
                            source = xPlayer.source,
                        })
                    end) -- End log
                end

                if v.getItemBonus ~= nil then
                    local matchingItems = {}
                    local minMatchingPercent = 1.0
        
                    for _, v in pairs(v.getItemBonus) do
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
                        if xPlayer.canCarryItem(randomItem.itemName, 1) then
                            xPlayer.addInventoryItem(randomItem.itemName, 1)
                            pcall(function() -- Start log
                                exports['azael_dc-serverlogs']:insertData({
                                    event = 'RecivedWorkNoToolItemBonus',
                                    content = ('%s ได้รับ %s จำนวน 1 ชิ้น จากการทำงาน %s เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, randomItem.itemName, xItem.name, v.useItemName, countUseItem.count),
                                    source = xPlayer.source,
                                })
                            end) -- End log
                        end
                    end
                end

                if v.getItemBonusSecond ~= nil then
                    if xItemBonusSecondRate <= v.getItemBonusSecondPercent then
                        xPlayer.addInventoryItem(xItemBonusSecond.name, 1)
                        pcall(function() -- Start log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'RecivedWorkNoToolItemBonusSecond',
                                content = ('%s ได้รับ %s จำนวน 1 ชิ้น จากการทำงาน %s เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, xItemBonusSecond.name, xItem.name, v.useItemName, countUseItem.count),
                                source = xPlayer.source,
                            })
                        end) -- End log
                    end
                end

            end
        end
    end
end


ESX.RegisterServerCallback('cc_pick_staticprop:checkCard', function(source, cb, currentJobZone ,picktimeStatic)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("card_nplayer")
    for _,v in pairs(Config.JobInfoServer) do
        if v.polyname == currentJobZone then
            if v.jobBuff == true then
                local calculatePicktime = exports.cc_corejob:coreJobCalculatepickTime(xPlayer, picktimeStatic)
                --print(calculatePicktime)
                cb(calculatePicktime)
                return
            end
        end
    end
    cb(picktimeStatic)
end)


function onNoToolsForWork(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, 
        title = 'ระบบเช็คไอเทม',
        description = 'คุณไม่มีอุปกรณ์ที่ใช้ทำงาน',
        type = 'warning',
        position = 'top',
        direction = 'right',
        priority = 'medium',
        icon = 'no_item',
        duration = 3000 
    })
end    

function onOverWeight(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, 
        title = 'ระบบน้ำหนัก',
        description = 'น้ำหนักกระเป๋าของคุณไม่เพียงพอ',
        type = 'warning',
        position = 'top',
        direction = 'right',
        priority = 'medium',
        icon = 'inventory_max',
        duration = 3000
    })
end    