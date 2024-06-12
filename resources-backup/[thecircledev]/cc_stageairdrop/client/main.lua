ESX = nil
local saveEntity = {}
local helpNotify,helpNotifyLoot = true,true
local joinAirdrop = false
local airdropStart = false
local playerColor, playerChoice
local playerPeopleStage, playerGangStage, playerFamilyStage
local lastStandPosition = nil
local startRadius = 200.0
local endRadius = 9.0
local duration = 5 * 60 -- 10 minutes in seconds
local currentRadius = startRadius
local ongoingfreeze = false

local npcPosition = {
	-- circlePeople = {
	-- 	position = vector3(-417.507690, 1222.008790, 325.634400),
	-- 	airdropType = "people",
	-- 	heading = 153.070878,
	-- 	hashPed = "s_m_y_swat_01",
	-- 	helpNotify = "เข้าร่วม Airdrop ปชช"
	-- },
}

local positionPeopleSpawn = {
	black = {
		vector3(-553.832946, -5671.556152, 1135.577392)
	},
	red = {
		vector3(-583.424194, -5651.367188, 1135.577392)
	},
	green = {
		vector3(-568.523072, -5671.714356, 1135.577392)
	},
	blue = {
		vector3(-540.989014, -5656.878906, 1135.577392)
	},
	white = {
		vector3(-544.496704, -5635.859375, 1135.577392)
	},
}

local positionGangStage = {
	vector3(-3226.668212, -2884.377930, 753.389648),
	vector3(-3226.945068, -2852.333984, 753.389648),
	vector3(-3258.224122, -2852.848388, 753.389648),
	vector3(-3258.197754, -2883.745118, 753.389648)
}

local positionFamilyStage = {
	vector3(-3732.0400390625, 281.6099853515625, 1234.8900146484375),
	vector3(-3731.56005859375, 311.4700012207031, 1234.8900146484375),
	vector3(-3761.330078125, 311.1700134277344, 1234.8900146484375),
	vector3(-3761.2900390625, 281.8999938964844, 1234.8900146484375)
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	PlayerData = ESX.GetPlayerData()
end)

--เริ่มตรงนี้
function DrawCircleMarker(center, radius, zOffset, r, g, b, a)
	DrawMarker(1, center.x, center.y, center.z + zOffset, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, radius*2, radius*2, 40.0, r, g, b, a, false, true, 2, nil, nil, false)
end

-- Citizen.CreateThread(function()
-- 	for _,v in pairs(npcPosition) do
-- 		local npcHash = GetHashKey(v.hashPed) -- NPC model (can be any valid ped model)
-- 		RequestModel(npcHash)
-- 		while not HasModelLoaded(npcHash) do
-- 			Wait(1)
-- 		end
-- 		local npcPed = CreatePed(4, npcHash,  v.position.x,v.position.y,v.position.z,v.heading, false, true)
-- 		SetEntityAsMissionEntity(npcPed, true, true)
-- 		SetBlockingOfNonTemporaryEvents(npcPed, true)
-- 		PlaceObjectOnGroundProperly(npcPed)
-- 		FreezeEntityPosition(npcPed, true)
-- 		SetEntityInvincible(npcPed, true)
-- 	end
-- end)
-------------------------------------------------------------------------------
function spawnAirdrop()
	local position
	local requestTypes = {
		gang = "position-g",
		people = "position-p",
		family = "position-f",
	}

	local requestType = requestTypes[playerChoice]

	if not requestType then
		return
	end

	while not position do
		Wait(2000)
		ESX.TriggerServerCallback('cc_stageairdrop:requestData', function(status, getCoords)
			if status then
				position = getCoords
			end
		end, requestType)
	end

	initAirDrop(position,requestType)
	initLootRadius(position,requestType)
	initDecreaseHP()
	initCalculateRadius(position)
	initCircleMarker(position)
end
---------------------------------------------------------------------------------------
-- function initClothes()
-- 	TriggerEvent('skinchanger:getSkin', function(skin)
-- 		Citizen.Wait(1500)
-- 		if skin.sex == 0 then
-- 			TriggerEvent('skinchanger:loadClothes', skin, cfg.Clothes[playerColor].male)
-- 		end
-- 		if skin.sex ~= 0 then
-- 			TriggerEvent('skinchanger:loadClothes', skin, cfg.Clothes[playerColor].female)
-- 		end
-- 	end)
-- end

-------------------------------------------------------------------------------------------
function initDecreaseHP()
	Citizen.CreateThread(function()
		local startTime = GetGameTimer()
		while airdropStart do
			Citizen.Wait(0)
			local elapsedTime = (GetGameTimer() - startTime) / 1000.0
			local progress = math.min(elapsedTime / duration, 1.0)
			currentRadius = startRadius + (endRadius - startRadius) * progress
		end
	end)
end
---------------------------------------------------------------------------------------------
function initCalculateRadius(position)
	Citizen.CreateThread(function()
		while airdropStart do
			Citizen.Wait(1000) -- Check every second
			local playerPos = GetEntityCoords(PlayerPedId())
			local distanceToCenter = #(playerPos - position)

			if distanceToCenter > currentRadius then
				-- Player is outside the circle, apply damage or any other logic
				SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - 5) -- Example damage
			end
		end
	end)
end
--------------------------------------------------------------------------------------------------------
function initCircleMarker(position)
	Citizen.CreateThread(function()
		while airdropStart do
			Citizen.Wait(0)
			DrawCircleMarker(position, currentRadius, -20.0, 255, 204, 0, 100)  -- Red semi-transparent circle
		end
	end)
end
--------------------------------------------------------------------------------------------------------
function DrawCircleMarker(center, radius, zOffset, r, g, b, a)
	DrawMarker(1, center.x, center.y, center.z + zOffset, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, radius*2, radius*2, 100.0, r, g, b, a, false, true, 2, nil, nil, false)
end
---------------------------------------------------------------------------------------------------------
function initLootRadius(position,requestType)
	Citizen.CreateThread(function()
		local sleep = 1500
		while airdropStart do
			Citizen.Wait(sleep)
			local ped = GetPlayerPed(-1)
			local pos = GetEntityCoords(ped)
			local dist = GetDistanceBetweenCoords(pos,position)
			if dist <= 2.0 then
				if helpNotifyLoot then
					exports.helpnotify:showHelpNotification("กด","E","เพื่อเก็บ")
					helpNotifyLoot = false
				end
				if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
					ESX.TriggerServerCallback('cc_stageairdrop:checkGetAirdrop', function(status,lastTeamAlive)
						if status then
							lootAirdropItem(lastTeamAlive)
							pcall(function() -- Start Log
								exports['azael_dc-serverlogs']:insertData({
									event = 'PlayerLootedStageAirDrop',
									content = ('ผู้เล่นได้ทำการกด E เพื่อเก็บ Air Drop'):format(),
								})
							end) -- End Log
						end
					end,requestType)
				end
				sleep = 0
				goto endState
			end
			sleep = 1500
			if not helpNotifyLoot then
				exports.helpnotify:hideHelpNotification()
				helpNotifyLoot = true
			end
			::endState::
		end
	end)
end
---------------------------------------------------------------------------------------------
function lootAirdropItem(lastTeamAlive)
	local time = 30000
	if playerChoice == "people" then
		time = 150000
	end
	TriggerEvent("mythic_progbar:client:progress",{
		name = "MiniAirDrop",
		duration = time,
		label = "เก็บแอร์ดรอป",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", -- ท่าทางเวลาขุด
			anim = "machinic_loop_mechandplayer",		-- ท่าทางเวลาขุด
			flags = 49,
		},
	}, function(status)
		if not status then
			ESX.TriggerServerCallback('cc_stageairdrop:confirmLoot', function(statusSv)
				if statusSv then
					--TODO
				end
			end, playerChoice,lastTeamAlive)
		end
	end)
end
-----------------------------------------------------------------------------------------------
function initAirDrop(position)
	local model = GetHashKey("xm_prop_rsply_crate04b")
	RequestModel(model)
	while (not HasModelLoaded(model)) do
		Wait(1)
	end
	Citizen.CreateThread(function()
		while airdropStart do
			local ped = GetPlayerPed(-1)
			local pos = GetEntityCoords(ped)
			local dist = GetDistanceBetweenCoords(pos,position)
			if dist <= 300.0 then
				if #saveEntity > 0 then
					for _,ent in pairs(saveEntity) do
						if DoesEntityExist(ent) and #saveEntity > 1 then
							DeleteEntity(ent)
							saveEntity = {}
						end
						if not DoesEntityExist(ent) then
							DeleteEntity(ent)
							saveEntity = {}
						end
					end
				end

				if  #saveEntity == 0 then
					local entity = CreateObjectNoOffset(model,position,0.0,false,false,false)
					Wait(300)
					table.insert(saveEntity, entity)
				end

				for _,ent in pairs(saveEntity) do
					SetEntityHeading(ent , 0.0)
					SetEntityCoordsNoOffset(ent, position, false, false, false)
					PlaceObjectOnGroundProperly(ent)
					SetModelAsNoLongerNeeded(ent)
					SetEntityAsMissionEntity(ent)
					FreezeEntityPosition(ent, true)
				end
			end
			Citizen.Wait(1500)
		end
	end)
end
-----------------------------------------------------------------------------------------------
function SecondsToClock(seconds)
	seconds = tonumber(seconds)
	if seconds <= 0 then
		return "00:00";
	end
	if seconds > 0 then
		local mins = string.format("%02.f", math.floor(seconds / 60 - (math.floor(seconds / 3600) * 60)));
		local secs = string.format("%02.f", math.floor(seconds - math.floor(seconds / 3600) * 3600 - mins * 60));
		return mins .. ":" .. secs
	end
end
-----------------------------------------------------------------------------------------------
function playSoundAirDrop(soundType)
	soundType = nil or soundType
	if soundType then
		SendNUIMessage(
				{
					Type = "playSound",
					File = soundType..".mp3",
					Volume = 0.2
				}
		)
	end
end
-----------------------------------------------------------------------------------------------
local function freezePlayer(id, freeze)
	local player = id
	SetPlayerControl(player, not freeze, false)
	local ped = GetPlayerPed(player)
	if not freeze then
		-- if not IsEntityVisible(ped) then
		-- 	SetEntityVisible(ped, true)
		-- end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		--SetCharNeverTargetted(ped, false)
		SetPlayerInvincible(player, false)
	else
		-- if IsEntityVisible(ped) then
		-- 	SetEntityVisible(ped, false)
		-- end

		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		--SetCharNeverTargetted(ped, true)
		SetPlayerInvincible(player, true)
		--RemovePtfxFromPed(ped)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end
-----------------------------------------------------------------------------------------------
function teleportToMap(place,color)
	local playerPed = GetPlayerPed(-1)
	local ped = PlayerPedId()
	if lastStandPosition == nil then
		lastStandPosition = GetEntityCoords(playerPed)
	end
	if place == "gang" then
		local coords = positionGangStage[math.random(1,#positionGangStage)]
		SwitchOutPlayer(ped,0,1)
		Citizen.Wait(1000)
		freezePlayer(PlayerId(), true)
		RequestCollisionAtCoord(coords.x, coords.y, coords.z)
		local armor = GetPedArmour(ped)
		SetEntityCoordsNoOffset(ped, coords.x+math.random(1,2), coords.y+math.random(1,2), coords.z+0.4, false, false, false, true)
		NetworkResurrectLocalPlayer(coords.x+math.random(1,2), coords.y+math.random(1,2), coords.z, 0.0, true, true, false)
		SetGameplayCamRelativeHeading(0.0)
		SetEntityHeading(ped, 0.0)
		ClearPedBloodDamage(ped)
		Citizen.Wait(1000)
		SetPedArmour(ped, armor)
		local time = GetGameTimer()
		while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 30000) do
			RequestCollisionAtCoord(coords.x, coords.y, coords.z)
			Citizen.Wait(0)
		end
		Citizen.Wait(1000)
		SwitchInPlayer(ped)
		ongoingfreeze = true
		unFreeze()
		-- Citizen.Wait(5000)
		-- freezePlayer(PlayerId(), false)
	end
	if place == "family" then
		local coords = positionFamilyStage[math.random(1,#positionFamilyStage)]
		SwitchOutPlayer(ped,0,1)
		Citizen.Wait(1000)
		freezePlayer(PlayerId(), true)
		RequestCollisionAtCoord(coords.x, coords.y, coords.z)
		local armor = GetPedArmour(ped)
		SetEntityCoordsNoOffset(ped, coords.x+math.random(1,2), coords.y+math.random(1,2), coords.z+0.4, false, false, false, true)
		NetworkResurrectLocalPlayer(coords.x+math.random(1,2), coords.y+math.random(1,2), coords.z, 0.0, true, true, false)
		SetGameplayCamRelativeHeading(0.0)
		SetEntityHeading(ped, 0.0)
		ClearPedBloodDamage(ped)
		Citizen.Wait(1000)
		SetPedArmour(ped, armor)
		local time = GetGameTimer()
		while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 30000) do
			RequestCollisionAtCoord(coords.x, coords.y, coords.z)
			Citizen.Wait(0)
		end
		Citizen.Wait(1000)
		SwitchInPlayer(ped)
		ongoingfreeze = true
		unFreeze()
		-- Citizen.Wait(5000)
		-- freezePlayer(PlayerId(), false)
	end
	if place == "people" then
		local coords = positionPeopleSpawn[color][math.random(1,#positionPeopleSpawn[color])]
		SwitchOutPlayer(ped,0,1)
		Citizen.Wait(1000)
		freezePlayer(PlayerId(), true)
		RequestCollisionAtCoord(coords.x, coords.y, coords.z)
		SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z+0.4, false, false, false, true)
		local armor = GetPedArmour(ped)
		NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, 0.0, true, true, false)
		SetGameplayCamRelativeHeading(0.0)
		SetEntityHeading(ped, 0.0)
		ClearPedBloodDamage(ped)
		Citizen.Wait(1000)
		SetPedArmour(ped, armor)
		local time = GetGameTimer()
		while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 30000) do
			RequestCollisionAtCoord(coords.x, coords.y, coords.z)
			Citizen.Wait(0)
		end
		Citizen.Wait(1000)
		SwitchInPlayer(ped)
		ongoingfreeze = true
		unFreeze()
		-- Citizen.Wait(5000)
		-- freezePlayer(PlayerId(), false)
	end
	if place == "home" and not IsEntityDead(playerPed) then
		local coords = lastStandPosition
		SwitchOutPlayer(ped,0,1)
		Citizen.Wait(1000)
		freezePlayer(PlayerId(), true)
		RequestCollisionAtCoord(coords.x, coords.y, coords.z)
		SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z+0.4, false, false, false, true)
		local armor = GetPedArmour(ped)
		NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, 0.0, true, true, false)
		SetGameplayCamRelativeHeading(0.0)
		SetEntityHeading(ped, 0.0)
		ClearPedBloodDamage(ped)
		Citizen.Wait(1000)
		SetPedArmour(ped, armor)
		local time = GetGameTimer()
		while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 30000) do
			RequestCollisionAtCoord(coords.x, coords.y, coords.z)
			Citizen.Wait(0)
		end
		Citizen.Wait(1000)
		SwitchInPlayer(ped)
		ongoingfreeze = true
		unFreeze()
		-- Citizen.Wait(5000)
		-- freezePlayer(PlayerId(), false)
	end

	if place == "home" and IsEntityDead(playerPed) then
		local coords = lastStandPosition
		SwitchOutPlayer(ped,0,1)
		Citizen.Wait(1000)
		freezePlayer(PlayerId(), true)
		RequestCollisionAtCoord(coords.x, coords.y, coords.z)
		SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z+0.4, false, false, false, true)
		NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, 0.0, true, true, false)
		SetGameplayCamRelativeHeading(0.0)
		SetEntityHeading(ped, 0.0)
		ClearPedBloodDamage(ped)
		Citizen.Wait(1000)
		local time = GetGameTimer()
		while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 30000) do
			RequestCollisionAtCoord(coords.x, coords.y, coords.z)
			Citizen.Wait(0)
		end
		Citizen.Wait(1000)
		SwitchInPlayer(ped)
		ongoingfreeze = true
		unFreeze()
		-- Citizen.Wait(5000)
		-- freezePlayer(PlayerId(), false)
	end
end
-----------------------------------------------------------------------------------------------------------
function unFreeze()
	Citizen.Wait(5000)
	exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิกแช่แข็ง")
	if ongoingfreeze then
		Citizen.CreateThread(function()
			while ongoingfreeze do
				Citizen.Wait(0)
				if IsControlJustReleased(0, 73) then
					exports.helpnotify:hideHelpNotification()
					freezePlayer(PlayerId(), false)
					ongoingfreeze = false
				end
			end
		end)
	end
end
-----------------------------------------------------------------------------------------------------------
function handleTeam(airdropType,teamColor)
	if airdropType == "gang" then
		joinAirdrop = true
		ESX.TriggerServerCallback('cc_stageairdrop:initPlayerTeam', function(status,gangData)
			if status then
				playerColor,playerChoice = teamColor,"gang"
				playerGangStage = gangData
				Wait(100)
				teleportToMap(airdropType,teamColor)
				Wait(500)
				--initClothes()
				--handleMarker()
				handleOnFight()
				pcall(function() -- Start Log
					exports['azael_dc-serverlogs']:insertData({
						event = 'JoinStageAirDropTeamGang',
						content = ('ผู้เล่นได้ทำการเข้าร่วมทีมสี %s ใน Air Drop %s'):format(teamColor, airdropType),
					})
				end) -- End Log
			end
			if not status then
				airdropStart = false
				joinAirdrop = false
			end
			--TODO
		end,airdropType,teamColor)
	end

	if airdropType == "family" then
		joinAirdrop = true
		ESX.TriggerServerCallback('cc_stageairdrop:initPlayerTeam', function(status,familyData)
			if status then
				playerColor,playerChoice = teamColor,"family"
				playerFamilyStage = familyData
				Wait(100)
				teleportToMap(airdropType,teamColor)
				Wait(500)
				--initClothes()
				--handleMarker()
				handleOnFight()
				pcall(function() -- Start Log
					exports['azael_dc-serverlogs']:insertData({
						event = 'JoinStageAirDropTeamGang',
						content = ('ผู้เล่นได้ทำการเข้าร่วมทีมสี %s ใน Air Drop %s'):format(teamColor, airdropType),
					})
				end) -- End Log
			end
			if not status then
				airdropStart = false
				joinAirdrop = false
			end
			--TODO
		end,airdropType,teamColor)
	end

	if airdropType == "people" then
		joinAirdrop = true
		ESX.TriggerServerCallback('cc_stageairdrop:initPlayerTeam', function(status,peopleData)
			if status then
				playerColor,playerChoice = teamColor,"people"
				playerPeopleStage = peopleData
				Wait(100)
				teleportToMap(airdropType,teamColor)
				Wait(500)
				--initClothes()
				--handleMarker()
				handleOnFight()
				pcall(function() -- Start Log
					exports['azael_dc-serverlogs']:insertData({
						event = 'JoinStageAirDropTeamPeople',
						content = ('ผู้เล่นได้ทำการเข้าร่วมทีมสี %s ใน Air Drop %s'):format(teamColor, airdropType),
					})
				end) -- End Log
			end
			if not status then
				airdropStart = false
				joinAirdrop = false
			end
			--TODO
		end,airdropType,teamColor)
	end
end

---------------------------------------------------------------------------------------------------------------

-- function handleMarker()
-- 	Citizen.CreateThread(function()
-- 		local colors = {
-- 			black = {0, 0, 0, 100},
-- 			red = {255, 0, 0, 100},
-- 			green = {0, 255, 0, 100},
-- 			white = {255, 255, 255, 100},
-- 			blue = {0, 255, 0, 100},
-- 			a = {0,0,0,100},
-- 			b = {255,0,0,100},
-- 			c = {0,0,255,100},
-- 			d = {0,255,200,100},
-- 			e = {255,255,255,100},
-- 		}

-- 		local function drawPlayerMarker(playerID, color)
-- 			local idx = GetPlayerPed(GetPlayerFromServerId(playerID))
-- 			if not IsEntityDead(idx) then
-- 				local coords = GetOffsetFromEntityInWorldCoords(idx, 0.0, 0.0, 1.0)
-- 				local markerColor = colors[color]
-- 				DrawMarker(20, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.3, 0.3, 0.3, markerColor[1], markerColor[2], markerColor[3], markerColor[4], 0, 1, 2, 0, 0)
-- 			end
-- 		end

-- 		while joinAirdrop do
-- 			Wait(0)
-- 			local stages = {playerPeopleStage, playerGangStage}
-- 			for _, stage in pairs(stages) do
-- 				if stage and type(playerPeopleStage) ~= "nil" then
-- 					for color, players in pairs(stage) do
-- 						if players and colors[color] then
-- 							for _, v in pairs(players) do
-- 								drawPlayerMarker(v.source, color)
-- 							end
-- 						end
-- 					end
-- 				end

-- 				if stage and type(playerGangStage) ~= "nil" then
-- 					for color, players in pairs(stage) do
-- 						if players and colors[color] then
-- 							for _, v in pairs(players.slot) do
-- 								drawPlayerMarker(v.source, color)
-- 							end
-- 						end
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end)
-- end
----------------------------------------------------------------------------------------------------------------------------
function handleOnFight()
	Citizen.CreateThread(function()
		local weaponHash = GetHashKey("WEAPON_UNARMED")
		while not airdropStart do
			Citizen.Wait(0)
			DisablePlayerFiring(PlayerPedId(), true)
			DisableControlAction(0, 140, true)
			DisableControlAction(0, 263, true)
			DisableControlAction(0, 264, true)
			DisableControlAction(0, 141, true)
			if GetSelectedPedWeapon(GetPlayerPed(-1)) ~= weaponHash then
				SetCurrentPedWeapon(PlayerPedId(), weaponHash, true)
			end
		end
	end)
end
----------------------------------------------------------------------------------------------------------------------------
function handleSelectUI(airdropType)
	ESX.TriggerServerCallback('cc_stageairdrop:getPlayerInTeam', function(status,dataPlayer,blackCount,redCount,greenCount,whiteCount,blueCount)
		if status and airdropType == "gang" then
			exports.cc_uiairdrop:openSelectUI(airdropType,blackCount,redCount,greenCount,whiteCount,blueCount)
		end
		if status and airdropType == "people" then
			handleTeam("people","black")
		end
	end,airdropType)
end
----------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("openSelectUIAirdrop", function(data,cb)
	handleTeam(data.airdropType,data.color)
	Wait(1000)
	cb(joinAirdrop)
end)
----------------------------------------------------------------------------------------------------------------------------
function resetFlow()
	airdropStart = false
	Wait(500)
	for _,ent in pairs(saveEntity) do
		if DoesEntityExist(ent) then
			DeleteEntity(ent)
		end
	end
	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	TriggerEvent('playerSpawned')
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
	TriggerEvent("esx_status:set" ,  "hunger" , 3000000)
	TriggerEvent("esx_status:set" ,  "stress" , 0)
	TriggerEvent("esx_status:set" ,  "thirst" , 3000000)
	exports.helpnotify:hideHelpNotification()
	TriggerEvent("mythic_progbar:client:cancel")
	teleportToMap(playerChoice,playerColor)
	--handleMarker()
	handleOnFight()
end
----------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	local sleep = 1500
-- 	while true do
-- 		Citizen.Wait(sleep)
-- 		for _,v in pairs(npcPosition) do
-- 			local coords = GetEntityCoords(PlayerPedId())
-- 			if(GetDistanceBetweenCoords(coords, v.position.x, v.position.y, v.position.z, true) < 3) then
-- 				if helpNotify  then
-- 					exports.helpnotify:showHelpNotification("กด","E",v.helpNotify)
-- 					helpNotify = false
-- 				end
-- 				if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
-- 					ESX.TriggerServerCallback('cc_stageairdrop:validatePermission', function(status,airdropType)
-- 						if status and airdropType == "gang" then
-- 							handleSelectUIGang(airdropType)
-- 							pcall(function() -- Start Log
-- 								exports['azael_dc-serverlogs']:insertData({
-- 									event = 'OpenGangStangeAirDropTeamMenu',
-- 									content = ('ผู้เล่นได้ทำการกด E เพื่อเปิดเมนูเลือกทีมของ Air Drop %s'):format(airdropType),
-- 								})
-- 							end) -- End Log
-- 						end
-- 						if status and airdropType == "people" then
-- 							handleSelectUI(airdropType)
-- 							pcall(function() -- Start Log
-- 								exports['azael_dc-serverlogs']:insertData({
-- 									event = 'OpenPeopleGangStangeAirDropTeamMenu',
-- 									content = ('ผู้เล่นได้ทำการกด E เพื่อเปิดเมนูเลือกทีมของ Air Drop %s'):format(airdropType),
-- 								})
-- 							end) -- End Log
-- 						end
-- 					end,v.airdropType)
-- 				end
-- 				sleep = 0
-- 				goto endState
-- 			end
-- 		end
-- 		sleep = 1500
-- 		if not helpNotify then
-- 			exports.helpnotify:hideHelpNotification()
-- 			helpNotify = true
-- 		end
-- 		::endState::
-- 	end
-- end)
----------------------------------------------------------------------------------------------------------------------------
function handleSelectUIGang(airdropType)
	ESX.TriggerServerCallback('cc_stageairdrop:getPlayerInTeam', function(status,dataPlayer,blackCount,redCount,greenCount,whiteCount,blueCount)
		if status and airdropType == "gang" then
			exports["cc_uiairdrop_gang"]:openSelectUI(airdropType,dataPlayer)
		end
		if status and airdropType == "people" then
			exports["cc_uiairdrop"]:openSelectUI(airdropType,blackCount,redCount,greenCount,whiteCount,blueCount)
		end
	end,airdropType)
end

function handleSelectUIFamily(airdropType)
	ESX.TriggerServerCallback('cc_stageairdrop:getPlayerInTeam', function(status,dataPlayer,blackCount,redCount,greenCount,whiteCount,blueCount)
		if status and airdropType == "family" then
			exports["cc_uiairdrop_gang"]:openSelectUI(airdropType,dataPlayer)
		end
		if status and airdropType == "people" then
			exports["cc_uiairdrop"]:openSelectUI(airdropType,blackCount,redCount,greenCount,whiteCount,blueCount)
		end
	end,airdropType)
end

----------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("General:getDataAirdrop")
AddEventHandler("General:getDataAirdrop", function(airdropType)
	if not joinAirdrop then return end
	if playerChoice ~= airdropType then
		return
	end
	ESX.TriggerServerCallback('cc_stageairdrop:requestData', function(status,getData)
		if status then
			if airdropType == "gang" then
				playerGangStage = getData
			end

			if airdropType == "family" then
				playerFamilyStage = getData
			end

			if airdropType == "people" then
				playerPeopleStage = getData
			end
		end
	end,airdropType)
end)
----------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("General:spawnAfterLoot")
AddEventHandler("General:spawnAfterLoot", function(lastTeamAlive)
	local sound = "team_"..lastTeamAlive
	resetFlow()
	playSoundAirDrop(sound)
end)
----------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("General:stopAirDrop")
AddEventHandler("General:stopAirDrop", function()
	SendNUIMessage({ShowMenu = "stopall",})
end)
----------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("General:spawnAirDrop")
AddEventHandler("General:spawnAirDrop", function(_times)
	if _times == 350 then
		playSoundAirDrop("stageairdrop_alert")
	end
	if _times == 130 then
		playSoundAirDrop("stageairdrop_alert")
	end

	local timetext = ''..SecondsToClock(_times)..''
		SendNUIMessage({
		ShowMenu = "startall",
		timegang = timetext,
		timefamily = timetext,
		timepeople = timetext
	})

	if _times == 0 then
		airdropStart = true
		SendNUIMessage({ShowMenu = "stopall",})
		spawnAirdrop()
	end
end)
----------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("General:prepareAirdrop")
AddEventHandler("General:prepareAirdrop", function(_times,airdropType)
	if playerChoice ~= airdropType then return end
	if  _times == 20 then
		playSoundAirDrop("next_stage")
	end
	local timetext = ''..SecondsToClock(_times)..''
	SendNUIMessage({
		ShowMenu = playerChoice,
		time = timetext,
	})
	if _times == 0 then
		airdropStart = true
		SendNUIMessage({hideMenu = playerChoice,})
		spawnAirdrop()
	end
end)
----------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("General:openMenu")
AddEventHandler("General:openMenu", function(status,airdropType)
	if status then
		if airdropType == "gang" then
			handleSelectUIGang(airdropType)
		end
		if airdropType == "family" then
			handleSelectUIFamily(airdropType)
		end
		if airdropType == "people" then
			handleSelectUI(airdropType)
		end
	end
end)
----------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("General:backToHome")
AddEventHandler("General:backToHome", function(lastTeamAlive)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
		local sound = "team_"..lastTeamAlive
		playSoundAirDrop(sound)
		Wait(1000)
		airdropStart = false
		joinAirdrop = false
		playerChoice = nil
		playerColor = nil
		playerPeopleStage = {}
		playerGangStage = {}
		playerFamilyStage = {}
		--teleportToMap("home",nil)
		for _,ent in pairs(saveEntity) do
			if DoesEntityExist(ent) then
				DeleteEntity(ent)
			end
		end
		TriggerServerEvent('esx:onPlayerSpawn')
		TriggerEvent('esx:onPlayerSpawn')
		TriggerEvent('playerSpawned')
		TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
		TriggerEvent("esx_status:set" ,  "hunger" , 3000000)
		TriggerEvent("esx_status:set" ,  "stress" , 0)
		TriggerEvent("esx_status:set" ,  "thirst" , 3000000)
		exports.helpnotify:hideHelpNotification()
		TriggerEvent("mythic_progbar:client:cancel")
		collectgarbage("collect")
		teleportToMap("home",nil)
	end)
end)
----------------------------------------------------------------------------------------------------------------------------
AddEventHandler('esx:onPlayerDeath', function()
	if playerChoice ~= nil then -- bad state but its ok
		exports.helpnotify:hideHelpNotification()
		TriggerEvent("mythic_progbar:client:cancel")
		helpNotify = true
	end
end)
----------------------------------------------------------------------------------------------------------------------------

AddEventHandler('esx:onPlayerSpawn', function()
	if playerChoice ~= nil then
		if playerChoice ~= "gang" then
			--initClothes()
		end
	end
end)
----------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStop", function(resource)
	if resource == GetCurrentResourceName() then
		for _,ent in pairs(saveEntity) do
			if DoesEntityExist(ent) then
				DeleteEntity(ent)
			end
		end
	end
end)






