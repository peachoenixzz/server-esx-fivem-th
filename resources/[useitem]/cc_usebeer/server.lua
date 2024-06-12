ESX.RegisterUsableItem('beer', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("beer")
    if xItem.count > 0 then
        TriggerClientEvent('useBeer', source)
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PlayerEatBeer',
                content = ('%s ได้ทำการกิน %s และมี %s ในกระเป๋าจำนวน %s ขวด'):format(xPlayer.name, xItem.name, xItem.name, xItem.count),
                source = xPlayer.source,
            })
        end) -- End Log
        return
    end
end)

ESX.RegisterServerCallback('cc_usebeer:checkbeer', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem =   xPlayer.getInventoryItem("beer")
    if xItem.count >= 1 then
        xPlayer.removeInventoryItem("beer", 1)
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PlayerAteBeer',
                content = ('%s ได้สูญเสีย %s จำนวน 1 ขวด จากการกิน %s เหลือ %s จำนวน %s ขวด'):format(xPlayer.name, xItem.name, xItem.name, xItem.name, xPlayer.getInventoryItem("beer").count),
                source = xPlayer.source,
            })
        end) -- End Log
        cb(true) 
        return
    end
    cb(false)
end)
