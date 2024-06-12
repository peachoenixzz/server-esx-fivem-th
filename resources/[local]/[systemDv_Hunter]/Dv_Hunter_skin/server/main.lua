ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('ped', function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' then
	local id = args[1]
	local skin = args[2]

	if(GetPlayerName(tonumber(args[1])) == nil)then
		RconPrint("Player not Online\n")
		CancelEvent()
		return
	else
		if args[2] == nil or args[2] == "" then
			RconPrint("Please Input Skin\n")
			CancelEvent()
		else
			TriggerClientEvent('Bose_skin:addskin', id, skin)
			TriggerClientEvent('Bose_skin:addskins', id, skin)
		end
		
	end

	end
end)

RegisterServerEvent('Bose_skin:saveskin')
AddEventHandler('Bose_skin:saveskin', function(skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET user_skin = @skin WHERE identifier = @identifier', {
		['@skin'] = skin,
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterServerEvent('Bose_skin:addskins')
AddEventHandler('Bose_skin:addskins', function(skin)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.execute('INSERT INTO user_skin (identifier, skin) VALUES (@identifier,@skin)', {
		['@skin'] = skin,
		['@identifier'] = xPlayer.identifier
	})
end)

ESX.RegisterServerCallback('Bose_skin:getskin', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchAll('SELECT user_skin FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(users)
	local user = users[1]
	cb(user.user_skin)
end)
end)

ESX.RegisterServerCallback('Bose_skin:getPlayerSkinList', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchAll('SELECT * FROM user_skin WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
	local data = {}
	for i=1, #result, 1 do
		table.insert(data, {
			skin   = result[i].skin
		})
	end
	cb(data)
end)
end)

ESX.RegisterServerCallback('Bose_skin:checkPlayerHaveSkin', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchAll('SELECT * FROM user_skin WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
	local data = 0
	for i=1, #result, 1 do
		data = data + 1
	end
	cb(data)
end)
end)
