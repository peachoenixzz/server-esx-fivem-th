
ESX.RegisterServerCallback('cc_changesurname:updateSurname', function(source, cb, newSurname,type)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if type == "money" then
            if xPlayer.getMoney() >= 50000 then
                xPlayer.removeMoney(50000)
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'PayUpdateSurnameFee',
                        content = ('%s ได้สูญเสียเงินจำนวน $50000 ในการเปลี่ยนนามสกุล เหลือเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, ESX.Math.GroupDigits(xPlayer.getMoney())),
                        source = xPlayer.source,
                    })
                end) -- End log
                xPlayer.set('lastname', newSurname)
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'UpdateSurname',
                        content = ('%s ได้ทำการเปลี่ยนนามสกุลเป็น %s'):format(xPlayer.name, newSurname),
                        source = xPlayer.source,
                    })
                end) -- End log
                MySQL.update.await(
                        'UPDATE users SET lastname = ? WHERE identifier = ?',
                        {newSurname, xPlayer.identifier})
                cb(true) -- Callback with success status
                return
            end
            cb(false)
            return
        end

        if type == "rename_card" then
            local xItem =   xPlayer.getInventoryItem("card_lastname")
            if xItem.count >= 1 then
                xPlayer.removeInventoryItem('card_lastname', 1)
                xPlayer.set('lastname', newSurname)
                MySQL.update.await(
                        'UPDATE users SET lastname = ? WHERE identifier = ?',
                        {newSurname, xPlayer.identifier})
                cb(true) -- Callback with success status
                return
            end
            cb(false)
            return
        end
        cb(false)
        return
    end
    cb(false)
end)

ESX.RegisterUsableItem('card_lastname', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("card_lastname")
    if xItem.count > 0 then
        TriggerClientEvent('cc_changesurname:usecard', source)
        return
    end
end)
