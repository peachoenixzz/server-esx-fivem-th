

ESX.RegisterUsableItem('weapon_box', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("weapon_box")
    if xItem.count > 0 then
        TriggerClientEvent('useAllBox', source, "weapon_box")
    end
end)

ESX.RegisterUsableItem('box_cement', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("box_cement")
    if xItem.count > 0 then
        TriggerClientEvent('useAllBox', source, "box_cement")
    end
end)

ESX.RegisterUsableItem('box_diamond', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("box_diamond")
    if xItem.count > 0 then
        TriggerClientEvent('useAllBox', source, "box_diamond")
    end
end)

ESX.RegisterUsableItem('box_ruby', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("box_ruby")
    if xItem.count > 0 then
        TriggerClientEvent('useAllBox', source, "box_ruby")
    end
end)

ESX.RegisterUsableItem('box_wood', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("box_wood")
    if xItem.count > 0 then
        TriggerClientEvent('useAllBox', source, "box_wood")
    end
end)

ESX.RegisterUsableItem('box_copper', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("box_copper")
    if xItem.count > 0 then
        TriggerClientEvent('useAllBox', source, "box_copper")
    end
end)

ESX.RegisterUsableItem('box_steel', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("box_steel")
    if xItem.count > 0 then
        TriggerClientEvent('useAllBox', source, "box_steel")
    end
end)

ESX.RegisterUsableItem('box_gold', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("box_gold")
    if xItem.count > 0 then
        TriggerClientEvent('useAllBox', source, "box_gold")
    end
end)

ESX.RegisterUsableItem('fight_pack', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("fight_pack")
    if xItem.count > 0 then
        TriggerClientEvent('useAllBox', source, "fight_pack")
    end
end)

RegisterServerEvent('spawnItemsAllBox')
AddEventHandler('spawnItemsAllBox', function(useitemName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem(useitemName)
    for _,v in pairs(Config.ItemAllBox) do
        if xItem.name == v.name then
            if xItem.count > 0 then
                local numBoxesToRemove = math.min(xItem.count, v.maxuse)
                xPlayer.removeInventoryItem(xItem.name, numBoxesToRemove)
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'RemoveAllUseBoxItem',
                        content = ('%s ได้สูญเสีย %s จำนวน %s ชิ้น เหลือ %s ในกระเป๋าจำนวน %s ชิ้น'):format(xPlayer.name, xItem.name, numBoxesToRemove, xItem.name, xPlayer.getInventoryItem(useitemName).count),
                        source = xPlayer.source,
                     })
                end) -- End log
                giveitemallbox(numBoxesToRemove, useitemName)
                calculatebonusallBOX(numBoxesToRemove, useitemName)
            end
        end
    end
end) 

function giveitemallbox(boxCount, useitemName)
    local xPlayer	= ESX.GetPlayerFromId(source)
    for _,v in pairs(Config.ItemAllBox) do
        if useitemName == v.name then
            if v.getItem ~= nil then
                for i = 1, boxCount do
                    for _, v in pairs(v.getItem) do
                        if v.type == 'item' then
                            if v.itemName == 'money' or v.itemName == 'black_money' then
                                xPlayer.addAccountMoney(v.itemName, v.quantity)
                                pcall(function() -- Start log
                                    exports['azael_dc-serverlogs']:insertData({
                                        event = 'ReceivedMoneyFromOpenBox',
                                        content = ('%s ได้รับ %s จำนวน $%s จากการเปิด %s'):format(xPlayer.name, v.itemName, v.quantity, useitemName),
                                        source = xPlayer.source,
                                     })
                                end) -- End log
                            else
                                xPlayer.addInventoryItem(v.itemName, v.quantity)
                                pcall(function() -- Start log
                                    exports['azael_dc-serverlogs']:insertData({
                                        event = 'ReceivedItemFromOpenBox',
                                        content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการเปิด %s'):format(xPlayer.name, v.itemName, v.quantity, useitemName),
                                        source = xPlayer.source,
                                     })
                                end) -- End log
                            end
                        end
                        if v.type == 'weapon' then
                            if xPlayer.hasWeapon(v.itemName) then
                                xPlayer.addWeaponAmmo(v.itemName, 250)
                            end
                            if not xPlayer.hasWeapon(v.itemName) then
                                xPlayer.addWeapon(v.itemName, v.quantity)
                                pcall(function() -- Start log
                                    exports['azael_dc-serverlogs']:insertData({
                                        event = 'ReceivedWeaponFromOpenBox',
                                        content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการเปิด %s'):format(xPlayer.name, v.itemName, v.quantity, useitemName),
                                        source = xPlayer.source,
                                    })
                                end) -- End log
                            end
                        end
                    end
                end
            end  
        end  
    end
end

function calculatebonusallBOX(boxCount, useitemName)
    local xPlayer	= ESX.GetPlayerFromId(source)
    for _,v in pairs(Config.ItemAllBox) do
        if useitemName == v.name then
            if v.getItemBonus ~= nil then
                for i = 1, boxCount do
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
                        if randomItem.type == 'item' then
                            if randomItem.itemName == 'money' or randomItem.itemName == 'black_money' then
                                xPlayer.addAccountMoney(randomItem.itemName, randomItem.quantity)
                                pcall(function() -- Start log
                                    exports['azael_dc-serverlogs']:insertData({
                                        event = 'ReceivedBonusMoneyFromOpenBox',
                                        content = ('%s ได้รับ %s จำนวน $%s จากการเปิด %s'):format(xPlayer.name, randomItem.itemName, randomItem.quantity, useitemName),
                                        source = xPlayer.source,
                                     })
                                end) -- End log
                            else
                                xPlayer.addInventoryItem(randomItem.itemName, randomItem.quantity)
                                pcall(function() -- Start log
                                    exports['azael_dc-serverlogs']:insertData({
                                        event = 'ReceivedBonusItemFromOpenBox',
                                        content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการเปิด %s'):format(xPlayer.name, randomItem.itemName, randomItem.quantity, useitemName),
                                        source = xPlayer.source,
                                     })
                                end) -- End log
                            end
                        end
                        if randomItem.type == 'weapon' then
                            --print("test naja wa ma mhai")
                            if xPlayer.hasWeapon(randomItem.itemName) then
                                xPlayer.addWeaponAmmo(randomItem.itemName, 250)
                            end
                            if not xPlayer.hasWeapon(randomItem.itemName) then
                                xPlayer.addWeapon(randomItem.itemName, randomItem.quantity)
                                pcall(function() -- Start log
                                    exports['azael_dc-serverlogs']:insertData({
                                        event = 'ReceivedBonusWeaponFromOpenBox',
                                        content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการเปิด %s'):format(xPlayer.name, randomItem.itemName, randomItem.quantity, useitemName),
                                        source = xPlayer.source,
                                    })
                                end) -- End log
                            end
                        end
                    end

                end
            end
        end
    end
end