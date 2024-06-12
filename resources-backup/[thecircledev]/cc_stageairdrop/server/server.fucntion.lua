function calculateitemStageAirdrop(airdropType, xPlayer)
    for _,v in pairs(Config.ItemStageAirdrop) do
        if airdropType == v.airdropType then
            if v.getItem ~= nil then
                for _, v in pairs(v.getItem) do
                    local getitemCount = math.random(v.quantity[1], v.quantity[2])
                    if v.itemName == 'money' or v.itemName == 'black_money' then
                        xPlayer.addAccountMoney(v.itemName, getitemCount)
                        pcall(function() -- Start Log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'ReceivedStageAirDropMoney',
                                content = ('%s ได้รับ %s จำนวน $%s จากการเก็บ Air Drop %s'):format(xPlayer.name, v.itemName, getitemCount, airdropType),
                                source = xPlayer.source,
                            })
                        end) -- End Log
                    else
                        xPlayer.addInventoryItem(v.itemName, getitemCount)
                        pcall(function() -- Start Log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'ReceivedStageAirDropItem',
                                content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการเก็บ Air Drop %s'):format(xPlayer.name, v.itemName, getitemCount, airdropType),
                                source = xPlayer.source,
                            })
                        end) -- End Log
                    end
                end
            end  
        end
    end
end

function calculateitemBonusStageAirdrop(airdropType, xPlayer)
    for _,v in pairs(Config.ItemStageAirdrop) do
        if airdropType == v.airdropType then
            if v.getItemBonus ~= nil then
                local xItemBonusRate = math.random(1, 100000)/100000
                --print(xItemBonusRate)
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
                    local getitemCount = math.random(randomItem.quantity[1], randomItem.quantity[2])
                    if randomItem.itemName == 'money' or randomItem.itemName == 'black_money' then
                        xPlayer.addAccountMoney(randomItem.itemName, getitemCount)
                        pcall(function() -- Start Log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'ReceivedStageAirDropBonusMoney',
                                content = ('%s ได้รับ %s จำนวน $%s จากการเก็บ Air Drop %s'):format(xPlayer.name, randomItem.itemName, getitemCount, airdropType),
                                source = xPlayer.source,
                            })
                        end) -- End Log
                    else
                        xPlayer.addInventoryItem(randomItem.itemName, getitemCount)
                        pcall(function() -- Start Log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'ReceivedStageAirDropBonusItem',
                                content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการเก็บ Air Drop %s'):format(xPlayer.name, randomItem.itemName, getitemCount, airdropType),
                                source = xPlayer.source,
                            })
                        end) -- End Log
                    end
                end

            end
        end
    end
end