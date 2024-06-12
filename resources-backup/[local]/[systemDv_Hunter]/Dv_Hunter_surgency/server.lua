ESX.RegisterUsableItem('surgency', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('esx_skin:openSaveableMenu', source)
	xPlayer.removeInventoryItem("surgency", 1)
end)