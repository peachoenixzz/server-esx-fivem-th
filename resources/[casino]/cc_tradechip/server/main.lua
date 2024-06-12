TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('casinoTradeChip:moneytochip')
AddEventHandler('casinoTradeChip:moneytochip', function(quantity)
    if quantity >= 100 then
        local source = source
        local xPlayer =  ESX.GetPlayerFromId(source)
        local currentAccount = xPlayer.getAccount("money")
        if currentAccount.money >= quantity then  
            xPlayer.removeAccountMoney("money", quantity)   
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'ExchangeMoneyToChip',
                    content = ('%s ได้ทำการแลกเงินจำนวน $%s เป็นชิป สูญเสียเงินจำนวน $%s เหลือเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, quantity, quantity, ESX.Math.GroupDigits(xPlayer.getMoney())),
                    source = xPlayer.source,
                })
            end) -- End log
            xPlayer.addInventoryItem("casino_chip", quantity)
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'ReceivedCasinoChip',
                    content = ('%s ได้รับ %s จำนวน %s เหรียญจากการแลกชิปและมี %s ในกระเป๋าจำนวน %s เหรียญ'):format(xPlayer.name, xPlayer.getInventoryItem("casino_chip").name, quantity, xPlayer.getInventoryItem("casino_chip").name, xPlayer.getInventoryItem("casino_chip").count),
                    source = xPlayer.source,
                })
            end) -- End log
        end  
    end
end)

RegisterServerEvent('casinoTradeChip:chiptomoney')
AddEventHandler('casinoTradeChip:chiptomoney', function(quantity)
    if quantity >= 100  then
        local source = source
        local xPlayer =  ESX.GetPlayerFromId(source)
        local xItem = xPlayer.getInventoryItem("casino_chip")
        local playergetMoney = quantity - (quantity*0.03)
        if xItem.count >= quantity then
            xPlayer.addAccountMoney("money", playergetMoney)
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'ExchangeChipToMoney',
                    content = ('%s ได้รับเงินจำนวน $%s จากการแลก %s จำนวน %s เหรียญเสียค่าธรรมเนียมจำนวน $%s มีเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, tonumber(playergetMoney), xItem.name, quantity, tonumber(quantity*0.03), ESX.Math.GroupDigits(xPlayer.getMoney())),
                    source = xPlayer.source,
                })
            end) -- End log   
            xPlayer.removeInventoryItem("casino_chip", quantity)
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'RemoveCasinoChip',
                    content = ('%s ได้สูญเสีย %s จำนวน %s เหรียญจากการแลกชิปเหลือ %s ในกระเป๋าจำนวน %s เหรียญ'):format(xPlayer.name, xItem.name, quantity, xItem.name, xPlayer.getInventoryItem("casino_chip").count),
                    source = xPlayer.source,
                })
            end) -- End log
        end
    end
end)



