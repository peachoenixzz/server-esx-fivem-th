ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('giveDynamicItem')
AddEventHandler('giveDynamicItem', function(currentJobZone)
    calculateDynamicItem(currentJobZone)    
end)

function calculateDynamicItem(currentJobZone)
    for _,v in pairs(Config.JobDynamicInfoServer) do
		if v.polyname == currentJobZone then
            local xPlayer	= ESX.GetPlayerFromId(source)
            local coreEffectMultiplyDynamic = 1
            local ecoCal = 1
            if v.coreEffect == true then
                ecoCal = exports.cc_coreeffect:coreEffectCalculateEcoNormal(xPlayer)
                if ecoCal ~= 1 then
                    coreEffectMultiplyDynamic = ecoCal
                end
            end
            --print(coreEffectMultiplyDynamic)

            local xItemCount = math.random(v.getItemCount[1], v.getItemCount[2]) * coreEffectMultiplyDynamic
            tbl = v.getItemName
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
                    if xPlayer.canCarryItem(xItem.name, xItemCount) then
                        xPlayer.addInventoryItem(xItem.name, xItemCount)
                        pcall(function() -- Start log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'ButheringAnimal',
                                content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการล่า %s เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, xItem.name, xItemCount, xItem.name, v.useItemName, countUseItem.count),
                                source = xPlayer.source,
                            })
                        end) -- End log
                    else
                        exports.nc_notify:PushNotification(xPlayer.source,{
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
                        pcall(function() -- Start log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'OverWeightButheringAnimal',
                                content = ('%s ไม่สามารถได้รับ %s จำนวน %s ชิ้น จากการล่า %s ได้เนื่องจากน้ำหนักกระเป๋าเต็ม'):format(xPlayer.name, xItem.name, xItemCount, xItem.name),
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
                                        event = 'ButheringAnimalBonus',
                                        content = ('%s ได้รับ %s จำนวน 1 ชิ้น จากการล่า %s เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, randomItem.itemName, xItem.name, v.useItemName, countUseItem.count),
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
                                    event = 'ButheringAnimalBonusSecond',
                                    content = ('%s ได้รับ %s จำนวน 1 ชิ้น จากการล่า %s เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, xItemBonusSecond.name, xItem.name, v.useItemName, countUseItem.count),
                                    source = xPlayer.source,
                                })
                            end) -- End log    
                        end
                    end

                    if userRandbrokenRate <= v.itemBrokenRate then
                        xPlayer.removeInventoryItem(v.useItemName, 1)
                        TriggerClientEvent('brokenItemLoseHealthDynamic', xPlayer.source)
                        pcall(function() -- Start log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'ButheringToolsBroken',
                                content = ('%s ได้สูญเสีย %s จำนวน 1 ชิ้น จากการล่า %s เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, v.useItemName, xItem.name, countUseItem.name, xPlayer.getInventoryItem(v.useItemName).count),
                                source = xPlayer.source,
                            })
                        end) -- End log 
                    end
                else
                    exports.nc_notify:PushNotification(xPlayer.source,{
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
                    pcall(function() -- Start log
                        exports['azael_dc-serverlogs']:insertData({
                            event = 'NoToolsToButhering',
                            content = ('%s ได้พยายามทำการล่า %s แต่ไม่มี %s ในกระเป๋า'):format(xPlayer.name, xItem.name, v.useItemName),
                            source = xPlayer.source,
                        })
                    end) -- End log 
                end
            end
        end
    end
end

ESX.RegisterServerCallback('cc_pick_dynamicprop:checkCard', function(source, cb, currentJobZone ,picktimeDynamic)
    local xPlayer = ESX.GetPlayerFromId(source)
    for _,v in pairs(Config.JobDynamicInfoServer) do
        if v.polyname == currentJobZone then
            if v.jobBuff == true then
                local calculatePicktime = exports.cc_corejob:coreJobCalculatepickTime(xPlayer, picktimeDynamic)
                --print(calculatePicktime)
                cb(calculatePicktime)
                return
            end
        end
    end
    cb(picktimeDynamic)
end)