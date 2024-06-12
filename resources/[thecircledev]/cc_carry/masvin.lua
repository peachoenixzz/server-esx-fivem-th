local DragSource = {}
local DeathStatus = {}



RegisterServerEvent('carry_cc:lyfter')
AddEventHandler('carry_cc:lyfter', function(target)
	local targetPlayer = ESX.GetPlayerFromId(target)

	TriggerClientEvent('carry_cc:upplyft', targetPlayer.source, source)
end)


--targetSrc คือผู้ที่อุ้ม
RegisterServerEvent('carry_cc:sync')
AddEventHandler('carry_cc:sync', function(targetSrc, animation, isadmin)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local department = false
	local Department = {
		['admin'] = true,
		['police'] = true,
		['ambulance'] = true,
	}

	if Department[xPlayer.job.name] then
		department = true
	end

	TriggerClientEvent('carry_cc:syncTarget', targetSrc, source, animation, department, isadmin)
end)

RegisterServerEvent('carry_cc:syncownewr')
AddEventHandler('carry_cc:syncownewr', function(targetSrc, animation)
	local source = source
	TriggerClientEvent('carry_cc:syncMe', targetSrc, animation, source)
	local ped = GetPlayerPed(source)
	Entity(ped).state.dragesource = targetSrc
	DragSource[source] = targetSrc
end)

RegisterServerEvent('carry_cc:stop')
AddEventHandler('carry_cc:stop', function(targetSrc, setdeath)
	print("source ",targetSrc .. " cancel drag by ", source)
	TriggerClientEvent('carry_cc:cl_stop', targetSrc, setdeath)
	local ped = GetPlayerPed(targetSrc)
	--local playerCoords = GetEntityCoords(ped)
	Entity(ped).state.dragesource = nil
	DragSource[targetSrc] = nil
end)

AddEventHandler('esx:playerDropped', function(playerId)
	playerId = tonumber(playerId)
	if DragSource[playerId] then
		local ped = GetPlayerPed(playerId)
		Entity(ped).state.dragesource = nil
		DragSource[playerId] = nil
	end
end)

AddEventHandler('playerDropped', function()
	local playerId = tonumber(source)
	if DragSource[playerId] then
		local ped = GetPlayerPed(playerId)
		Entity(ped).state.dragesource = nil
		DragSource[playerId] = nil
	end
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function()
	local source = source
	local playerPed = GetPlayerPed(source)
	Entity(playerPed).state.isDead = true
	DeathStatus[source] = true
end)


RegisterServerEvent('carry_cc:setdeathstatus')
AddEventHandler('carry_cc:setdeathstatus', function(status)
	local source = source
	local playerPed = GetPlayerPed(source)
	Entity(playerPed).state.isDead = status
	DeathStatus[source] = status
end)

ESX.RegisterServerCallback('carry_cc:checkPlayerAlive', function(source, cb,id)
	--print("lastSource",id)
	--print("sender",source)
	local xPlayer = ESX.GetPlayerFromId(id)
	--print(xPlayer.getJob().name == "police")
	if xPlayer then
		cb(xPlayer.getJob().name == "police")
		return
	end
	cb(true)
end)

ESX.RegisterServerCallback('carry_cc:getdeathstatus', function (source, cb, target)
	local ped = GetPlayerPed(target)
	Entity(ped).state.isDead = DeathStatus[target]
	print("[CALLBACK GETDEATH] Playerid: ".. target .. " DeathStatus: ".. json.encode(DeathStatus[target]))
	cb(DeathStatus[target])
end)

ESX.RegisterServerCallback('carry_cc:getdragsource', function (source, cb, target)
	local ped = GetPlayerPed(target)
	Entity(ped).state.dragesource = DragSource[target]
	print("[CALLBACK GETDRAGSOURCE] Playerid: ".. target .. " DragSource: ".. json.encode(DragSource[target]))
	cb(DragSource[target])
end)