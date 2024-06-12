ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Dv_Hunter_tackle:tryTackle')
AddEventHandler('Dv_Hunter_tackle:tryTackle', function(target)
	local targetPlayer = ESX.GetPlayerFromId(target)
	TriggerClientEvent('Dv_Hunter_tackle:getTackled', targetPlayer.source, source)
	TriggerClientEvent('Dv_Hunter_tackle:playTackle', source)
end)