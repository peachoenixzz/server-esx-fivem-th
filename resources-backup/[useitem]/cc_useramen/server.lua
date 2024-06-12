ESX.RegisterUsableItem('noodle', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("noodle")
    if xItem.count > 0 then
        TriggerClientEvent('useRamen', source)
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PlayerEatNoodle',
                content = ('%s ได้ทำการกิน %s และมี %s ในกระเป๋าจำนวน %s ชาม'):format(xPlayer.name, xItem.name, xItem.name, xItem.count),
                source = xPlayer.source,
            })
        end) -- End Log
        return
    end
end)

ESX.RegisterServerCallback('cc_useramen:checkramen', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem =   xPlayer.getInventoryItem("noodle")
    if xItem.count >= 1 then
        xPlayer.removeInventoryItem("noodle", 1)
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PlayerAteNoodle',
                content = ('%s ได้สูญเสีย %s จำนวน 1 ชาม จากการกิน %s เหลือ %s จำนวน %s ชาม'):format(xPlayer.name, xItem.name, xItem.name, xItem.name, xPlayer.getInventoryItem("noodle").count),
                source = xPlayer.source,
            })
        end) -- End Log
        cb(true) 
        return
    end
    cb(false)
end)