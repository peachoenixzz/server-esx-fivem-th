ESX.RegisterUsableItem('meal_1', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("meal_1")
    if xItem.count > 0 then
        TriggerClientEvent('useMeal', source, xItem.name)
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PlayerEatCurryRice',
                content = ('%s ได้ทำการกิน %s และมี %s ในกระเป๋าจำนวน %s ชิ้น'):format(xPlayer.name, xItem.name, xItem.name, xItem.count),
                source = xPlayer.source,
            })
        end) -- End Log
        return
    end
end)

ESX.RegisterUsableItem('meal_2', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("meal_2")
    if xItem.count > 0 then
        TriggerClientEvent('useMeal', source, xItem.name)
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PlayerEatFriedBasil',
                content = ('%s ได้ทำการกิน %s และมี %s ในกระเป๋าจำนวน %s ชิ้น'):format(xPlayer.name, xItem.name, xItem.name, xItem.count),
                source = xPlayer.source,
            })
        end) -- End Log
        return
    end
end)

ESX.RegisterUsableItem('meal_3', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("meal_3")
    if xItem.count > 0 then
        TriggerClientEvent('useMeal', source, xItem.name)
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PlayerEatMilk',
                content = ('%s ได้ทำการกิน %s และมี %s ในกระเป๋าจำนวน %s ชิ้น'):format(xPlayer.name, xItem.name, xItem.name, xItem.count),
                source = xPlayer.source,
            })
        end) -- End Log
        return
    end
end)


ESX.RegisterUsableItem('meal_mre', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("meal_mre")
    if xItem.count > 0 then
        TriggerClientEvent('useMeal', source, xItem.name)
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PlayerEatMre',
                content = ('%s ได้ทำการกิน %s และมี %s ในกระเป๋าจำนวน %s ชิ้น'):format(xPlayer.name, xItem.name, xItem.name, xItem.count),
                source = xPlayer.source,
            })
        end) -- End Log
        return
    end
end)

ESX.RegisterServerCallback('cc_useallmeal:checkitem', function(source, cb, itemName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem =   xPlayer.getInventoryItem(itemName)
    if xItem.count >= 1 then
        xPlayer.removeInventoryItem(itemName, 1)
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PlayerAteMeal',
                content = ('%s ได้สูญเสีย %s จำนวน 1 ชิ้น จากการกิน %s เหลือ %s จำนวน %s ชิ้น'):format(xPlayer.name, xItem.name, xItem.name, xItem.name, xPlayer.getInventoryItem(itemName).count),
                source = xPlayer.source,
            })
        end) -- End Log
        cb(true) 
        return
    end
    cb(false)
end)


