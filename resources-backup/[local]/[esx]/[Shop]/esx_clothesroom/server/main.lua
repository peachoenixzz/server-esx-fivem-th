


RegisterServerEvent('esx_clothesroom:renameOutfit')
AddEventHandler('esx_clothesroom:renameOutfit', function(label, id)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE meeta_accessory_inventory SET label = @label WHERE id = @id AND owner = @owner', {
		['@label'] = label,
		['@id'] = id,
		['@owner'] = xPlayer.identifier
	})

	TriggerClientEvent("esx_inventoryhud:getOwnerAccessories", source)
end)

RegisterServerEvent('esx_clothesroom:deleteOutfit')
AddEventHandler('esx_clothesroom:deleteOutfit', function(id)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('DELETE FROM meeta_accessory_inventory WHERE id = @id AND owner = @owner', {
		['@id'] = id,
		['@owner'] = xPlayer.identifier
	})
	
	TriggerClientEvent("esx_inventoryhud:getOwnerAccessories", source)
end)

ESX.RegisterServerCallback('esx_clothesroom:getPlayerOutfit', function(source, cb, type)
	
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = type
	}, function(result)
		cb(result)
	end)
end)

ESX.RegisterServerCallback('esx_clothesroom:checkMoney', function(source, cb, money)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' then
		cb(true)
	else
		if xPlayer.getMoney('money') >= money then
			xPlayer.removeMoney(money)
			cb(true)
		else
			cb(false)
		end
	end
	
end)