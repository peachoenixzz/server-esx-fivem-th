local Checkservercar = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('cc_customCar:checkMoney', function(source, cb)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    cb(xPlayer.getMoney())
end)

RegisterServerEvent('mechanic:sv:removeCash')
AddEventHandler('mechanic:sv:removeCash', function(amount)
	local src = source

    print(amount)
    amount = tonumber(amount)
    if (not amount or amount <= 0) then return end
    
    local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer.getMoney() >= amount then
            xPlayer.removeMoney(amount)
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                     event = 'PayCustomCarFee',
                     content = ('%s ได้ทำการจ่ายเงินแต่งรถจำนวน $%s เหลือเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, amount, ESX.Math.GroupDigits(xPlayer.getMoney())),
                     source = xPlayer.source,
                 })
             end) -- End log
            return
        end

        if xPlayer.getMoney() <= amount then

        end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local balanceBank = xPlayer.getAccount('bank').money
    local balanceMoney = xPlayer.getAccount('money').money
    TriggerClientEvent('currentbalance1', source, balanceBank,balanceMoney)
end)


AddEventHandler('playerDropped', function(reason)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if xPlayer then
        if Checkservercar[xPlayer.source] == nil or Checkservercar[xPlayer.source] == false then

        else
            TriggerClientEvent('Dv_Hunter_Customshop:cl:Deleallcar', -1, Checkservercar[xPlayer.source])
        end

		Checkservercar[xPlayer.source] = nil
	end
end)

RegisterServerEvent('Dv_Hunter_Customshop:sv:CheckDeleted')
AddEventHandler('Dv_Hunter_Customshop:sv:CheckDeleted', function(checkcar)
    local xPlayer = ESX.GetPlayerFromId(source)
	Checkservercar[xPlayer.source] = checkcar
    --print(checkcar)
end)


RegisterServerEvent('Dv_Hunter_Customshop:sv:Deleallcar')
AddEventHandler('Dv_Hunter_Customshop:sv:Deleallcar', function(checkcar)
    local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('Dv_Hunter_Customshop:cl:Deleallcar', -1, checkcar)
    local sendToDiscord = '' .. xPlayer.name .. ' ได้ทำการออกจาก การแต่งรถผิดวิธี โปรหรือป่าวน้าาาา'
	TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'แต่งรถผิดวิธี', sendToDiscord, xPlayer.source, '^2')
    --print(checkcar)
end)
