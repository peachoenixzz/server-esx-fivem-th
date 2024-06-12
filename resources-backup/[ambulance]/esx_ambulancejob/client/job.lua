local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local deadPlayers, deadPlayerBlips, isOnDuty = {}, {}, false
isInShopMenu = false
isBusy = false
isUseItemHeal = false
onProcess = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)


function OpenAmbulanceActionsMenu()
	local elements = {
		{ unselectable = true, icon = "fas fa-shirt", title = "Ambulance Actions" },
		{ icon = "fas fa-shirt", title = TranslateCap('cloakroom'), value = 'cloakroom' }
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		elements[#elements + 1] = {
			icon = "fas fa-ambulance",
			title = TranslateCap('boss_actions'),
			value = 'boss_actions'
		}
	end

	ESX.OpenContext("right", elements, function(menu, element)
		if element.value == 'cloakroom' then
			OpenCloakroomMenu()
		elseif element.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
				menu.close()
			end, { wash = false })
		end
	end)
end

function billingChoice(player)
	local elements = {
		{ label = 'เตียงรักษา $200', value = "200" },
		{ label = 'รักษาในเมือง $500', value = "500" },
		{ label = 'รักษานอกเมือง $1,000', value = "1000" },
		{ label = 'รักษาเมืองบน $1,500', value = "1500" },
		{ label = 'สุ่มเสี่ยง / เข้าถึงยาก $3,000', value = "3000" },
	}

	ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'ambulance_billing',
			{
				title    = 'Ambulance Billng',
				align    = 'top-right',
				elements = elements
			},
			function(data, menu)
				local action = data.current.value
				if action == "200" then
					menu.close()
					sendBillToServer(player, 'Ambulance',"ค่ารักษา", tonumber('200'),"ambulance")
				end
				if action == "500" then
					menu.close()
					sendBillToServer(player, 'Ambulance',"ค่ารักษา", tonumber('500'),"ambulance")
				end
				if action == "1000" then
					menu.close()
					sendBillToServer(player, 'Ambulance',"ค่ารักษา", tonumber('1000'),"ambulance")
				end
				if action == "1500" then
					menu.close()
					sendBillToServer(player, 'Ambulance',"ค่ารักษา", tonumber('1500'),"ambulance")
				end
				if action == "3000" then
					menu.close()
					sendBillToServer(player, 'Ambulance',"ค่ารักษา", tonumber('3000'),"ambulance")
				end
			end,
			function(data, menu)
				menu.close()
			end
	)
end

function bedMenu(closestPlayer)
		local elements = {
			{ label = 'เตียงรักษาผู้ป่วย', value = "heal" },
			-- { label = 'เตียงรักษาสุขภาพ', value = "healthy" },
			-- { label = 'เตียงรักษาพิเศษ', value = "restorePlayer" },
			{ label = 'พาผู้ป่วยลงเตียง', value = "cancel" },
		}
		ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'bed_actions',
				{
					title    = 'Bed Menu',
					align    = 'top-right',
					elements = elements
				},
				function(data, menu)
					local action = data.current.value
					if action == "heal" then
						menu.close()
						TriggerServerEvent('cc_bed:getPlayerToBedHeal', GetPlayerServerId(closestPlayer),"heal")
					end
					-- if action == "healthy" then
					-- 	menu.close()
					-- 	TriggerServerEvent('cc_bed:getPlayerToBedHeal', GetPlayerServerId(closestPlayer),"healthy")
					-- end
					-- if action == "restorePlayer" then
					-- 	menu.close()
					-- 	TriggerServerEvent('cc_bed:getPlayerToBedHeal', GetPlayerServerId(closestPlayer),"restorePlayer")
					-- end
					if action == "cancel" then
						menu.close()
						TriggerServerEvent('cc_bed:cancelPlayerFromBed', GetPlayerServerId(closestPlayer))
					end
				end,
				function(data, menu)
					menu.close()
				end
		)
end

function sendBillToServer(player, departmentLabel, label, amount, departmentName)
	ESX.TriggerServerCallback('esx_billing:sendBill', function()
		onSendbill()
		pcall(function()
			exports['azael_dc-serverlogs']:insertData({
				event = 'AmbulanceSendBill',
				content = ('ผู้เล่นได้ทำการสั่งจ่ายบิล เตียงสุขภาพ เป็นจำนวนเงิน $%s ให้กับ %s'):format( tonumber('100'), GetPlayerName(player)),
			})
		end)
	end,GetPlayerServerId(player), departmentLabel, label, tonumber(amount), departmentName)
end

function ambulanceMenu()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	local playerPed = PlayerPedId()
	if closestPlayer ~= -1 and closestDistance < 2.0 and not IsPedInAnyVehicle(playerPed, false)  then
		local elements = {
			{ label = "ผู้ป่วย : "..GetPlayerName(closestPlayer), value = "player_name"},
			{ label = 'อุ้มผู้หมดสติ', value = "drag_dead" },
			{ label = 'ชุบ', value = "revive" },
			{ label = 'ชุบ All', value = "revive_all" },
			{ label = 'เตียงรักษา', value = "player_to_bed" },
			{ label = 'บิลค่ารักษา', value = "fine_choice" },
			{ label = 'ระบุจำนวนบิลค่ารักษา', value = "fine" },
			{ label = 'เด้งศพของผู้หมดสติ' , value = 'search'},
			{ label = 'On Duty', value = "check_player"}
		}
		ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'ambulance_actions',
				{
					title    = 'Ambulance Menu',
					align    = 'top-right',
					elements = elements
				},
				function(data, menu)
					local action = data.current.value
					if action == "fine" then
						menu.close()
						OpenFineMenu(closestPlayer)
					end
					if action == "fine_choice" then
						menu.close()
						billingChoice(closestPlayer)
					end
					if action == "drag_dead" then
						menu.close()
						exports['cc_ambulancecarry'].GetDeadPlayersInArea()
					end
					if action == "revive" then
						menu.close()
						if not isBusy and IsPedDeadOrDying(GetPlayerPed(closestPlayer), 1)  then
							playerCheckSkill(closestPlayer)
						end
					end
					if action == "revive_all" then
						menu.close()
						if not isBusy then
							processReviveAmbulanceAll(5000)
						end
					end
					if action == "player_to_bed" then
						menu.close()
						bedMenu(closestPlayer)
					end
					if action == "check_player" then
						menu.close()
						exports.cc_optionduty:checkOnDutyPlayer("police")
					end
					if action == "search" then
						menu.close()
						TriggerServerEvent('esx_ambulancejob:svsearch')
					end
				end,
				function(data, menu)
					menu.close()
				end
		)
		return
	end
	noneClosestPlayerMenu()
end

function noneClosestPlayerMenu()
	local elements = {
		{ label = 'เด้งศพของผู้หมดสติ' , value = 'search'},
		{ label = 'On Duty', value = "check_player"}
	}
	ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'ambulance_actions',
			{
				title    = 'Ambulance Menu',
				align    = 'top-right',
				elements = elements
			},
			function(data, menu)
				local action = data.current.value
				if action == "check_player" then
					menu.close()
					exports.cc_optionduty:checkOnDutyPlayer("police")
				end
				if action == "search" then
					menu.close()
					TriggerServerEvent('esx_ambulancejob:svsearch')
				end
			end,
			function(data, menu)
				menu.close()
			end
	)
end

function miniGame(gridSize,lives,time,closestPlayer)
	local status = false
			local settings = {
				gridSize = gridSize,
				lives = lives,
				timeLimit = time,
			}
			exports["glow_minigames"]:StartMinigame(function(success)
				print(success)
				if success then
					revivePlayer(closestPlayer)
					return
				end
				if not success then
					TriggerServerEvent('esx_ambulancejob:removeItem', 'medkit')
					return
				end
			end, "path", settings)
	return
end

function processReviveAmbulanceAll(time)
	onProcess = true
	helpNotify = false
	exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
	TriggerEvent("mythic_progbar:client:progress",{
		name = "RevivePlayer",
		duration = time,
		label = "กำลังดำเนินการ",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = false,
		},
		animation = {
			animDict = "rcmbarry",
			anim = "mind_control_b_loop",
			flags = 33,
		},
	}, function(status)
		if not status then
			ESX.TriggerServerCallback('esx_ambulancejob:reviveAllPlayer', function()
				exports.helpnotify:hideHelpNotification()
				helpNotify = true
				onProcess = false
				isBusy = false
			end)
		end
		onProcess = false
		isBusy = false
	end)
end

function processReviveAmbulance(time, closestPlayer)
	onProcess = true
	helpNotify = false
	exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
	TriggerEvent("mythic_progbar:client:progress",{
		name = "RevivePlayer",
		duration = time,
		label = "กำลังดำเนินการ",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = false,
		},
		animation = {
			animDict = "mini@cpr@char_a@cpr_str",
			anim = "cpr_pumpchest",
			flags = 33,
		},
	}, function(status)
		if not status then
			TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer),'medkit')
			exports.helpnotify:hideHelpNotification()
			helpNotify = true
			onProcess = false
			isBusy = false
			TriggerServerEvent('esx_ambulancejob:removeItem', 'medkit')
		end
		onProcess = false
		isBusy = false
	end)
end

function playerCheckSkill(closestPlayer)
	if ESX.PlayerData.job.grade == 0  then
		--miniGame(6,1,3000, closestPlayer)
		revivePlayer(closestPlayer)
		return
	end
	if ESX.PlayerData.job.grade == 1  then
		--miniGame(4,1,3000, closestPlayer)
		revivePlayer(closestPlayer)
		return
	end
	if ESX.PlayerData.job.grade == 2 or  ESX.PlayerData.job.grade == 3 or ESX.PlayerData.job.grade == 4  then
		revivePlayer(closestPlayer)
		return
	end
end



function OpenFineMenu(player)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine',
			{
				title    = "สั่งจ่ายบิล",
				align    = 'top-right',
				elements = {
					{label = "สร้างบิล",   value = 'create_bills'}
				}
			}, function(data, menu)
				CreateBilling(player)
				-- OpenFineCategoryMenu(player, data.current.value)
			end, function(data, menu)
				menu.close() end)
end

function CreateBilling(player)
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog_createbill',
			{
				title = "ใส่ชื่อบิล",
			}, function(data, menu)
				--local length = string.len(data.value)
				if data.value == nil then
					onNoInfo()
				else
					CreateBillingAmbulance(player, data.value)
					menu.close()
				end
			end, function(data, menu)
				menu.close()
			end)
end

function CreateBillingAmbulance(player, value)
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog_createbill_price',
			{
				title = "ใส่จำนวนเงิน",
			}, function(data2, menu2)
				--local length = string.len(data.value)
				if tonumber(data2.value) then
					ESX.TriggerServerCallback('esx_billing:sendBill', function()
						onCreatBill()
						pcall(function()
							exports['azael_dc-serverlogs']:insertData({
								event = 'AmbulanceSendBill',
								content = ('ผู้เล่นได้ทำการสั่งจ่ายบิล %s เป็นจำนวนเงิน $%s ให้กับ %s'):format(value, tonumber(data2.value), GetPlayerName(player)),
							})
						end)
					end,GetPlayerServerId(player), 'ambulance',"ค่าปรับ: "..value, tonumber(data2.value),'ambulance')
					menu2.close()
				else
					onNoFineMoney()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
end


function revivePlayer(closestPlayer)
	isBusy = true
	ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
		if quantity > 0 then
			local closestPlayerPed = GetPlayerPed(closestPlayer)
			if IsPedDeadOrDying(closestPlayerPed, 1) and not IsPedInAnyVehicle(PlayerPedId(), false) then
				local playerPed = PlayerPedId()
				local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
				processReviveAmbulance(9000,closestPlayer)
				for i = 1, 18 do
					Wait(500)
					ESX.Streaming.RequestAnimDict(lib, function()
						TaskPlayAnim(playerPed, lib, anim, 12.0, -8.0, -1, 0, 0.0, false, false, false)
						RemoveAnimDict(lib)
					end)
					if not isBusy then
						ClearPedTasksImmediately(PlayerPedId())
						break
					end
				end
			end
		else
			isBusy = false
			onNoItemToRevive()
		end
	end, 'medkit')
end

function FastTravel(coords, heading)
	local playerPed = PlayerPedId()

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Wait(500)
	end

	ESX.Game.Teleport(playerPed, coords, function()
		DoScreenFadeIn(800)

		if heading then
			SetEntityHeading(playerPed, heading)
		end
	end)
end

-- Draw markers & Marker logic
CreateThread(function()
	while true do
		local sleep = 1500

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			local playerCoords = GetEntityCoords(PlayerPedId())
			local isInMarker, hasExited = false, false
			local currentHospital, currentPart, currentPartNum

			for hospitalNum, hospital in pairs(Config.Hospitals) do
				-- Ambulance Actions
				for k, v in ipairs(hospital.AmbulanceActions) do
					local distance = #(playerCoords - v)

					if distance < Config.DrawDistance then
						sleep = 0
						DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z,
							Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil,
							nil, false)


						if distance < Config.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActions', k
						end
					end
				end

				-- Pharmacies
				for k, v in ipairs(hospital.Pharmacies) do
					local distance = #(playerCoords - v)

					if distance < Config.DrawDistance then
						sleep = 0
						DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z,
							Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil,
							nil, false)


						if distance < Config.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Pharmacy', k
						end
					end
				end

				-- Vehicle Spawners
				for k, v in ipairs(hospital.Vehicles) do
					local distance = #(playerCoords - v.Spawner)

					if distance < Config.DrawDistance then
						sleep = 0
						DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r,
							v.Marker.g, v.Marker.b, v.Marker.a, false, true, 2, v.Marker.rotate, false, false, false)
						

						if distance < v.Marker.x then
							exports.helpnotify:showHelpNotification("กด","E","เพื่อซื้อรถ")
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Vehicles', k
						end
					end
				end

				-- Helicopter Spawners
				for k, v in ipairs(hospital.Helicopters) do
					local distance = #(playerCoords - v.Spawner)

					if distance < Config.DrawDistance then
						sleep = 0
						DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r,
							v.Marker.g, v.Marker.b, v.Marker.a, false, true, 2, v.Marker.rotate, false, false, false)


						if distance < v.Marker.x then
							exports.helpnotify:showHelpNotification("กด","E","เพื่อซื้อฮอ")
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Helicopters', k
						end
					end
				end

				-- Fast Travels (Prompt)
				for k, v in ipairs(hospital.FastTravelsPrompt) do
					local distance = #(playerCoords - v.From)

					if distance < Config.DrawDistance then
						sleep = 0
						DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r,
							v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)


						if distance < v.Marker.x then
							isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'FastTravelsPrompt', k
						end
					end
				end
			end

			-- Logic for exiting & entering markers
			if isInMarker and not HasAlreadyEnteredMarker or
				(isInMarker and (LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if (LastHospital ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
					(LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum = true, currentHospital, currentPart, currentPartNum

				TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentHospital, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				exports.helpnotify:hideHelpNotification()
				TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
			end
		end
		Wait(sleep)
	end
end)

AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(hospital, part, partNum)
	if part == 'AmbulanceActions' then
		CurrentAction = part
		CurrentActionMsg = TranslateCap('actions_prompt')
		CurrentActionData = {}
	elseif part == 'Pharmacy' then
		CurrentAction = part
		CurrentActionMsg = TranslateCap('open_pharmacy')
		CurrentActionData = {}
	elseif part == 'Vehicles' then
		CurrentAction = part
		--CurrentActionMsg = TranslateCap('garage_prompt')
		CurrentActionData = { hospital = hospital, partNum = partNum }
	elseif part == 'Helicopters' then
		CurrentAction = part
		--CurrentActionMsg = TranslateCap('helicopter_prompt')
		CurrentActionData = { hospital = hospital, partNum = partNum }
	elseif part == 'FastTravelsPrompt' then
		local travelItem = Config.Hospitals[hospital][part][partNum]

		CurrentAction = part
		CurrentActionMsg = travelItem.Prompt
		CurrentActionData = { to = travelItem.To.coords, heading = travelItem.To.heading }
	end

	--ESX.TextUI(CurrentActionMsg)
end)

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(hospital, part, partNum)
	if not isInShopMenu then
		ESX.CloseContext()
	end
	ESX.HideUI()
	CurrentAction = nil
end)

-- Key Controls
CreateThread(function()
	while true do
		local sleep = 1500

		if CurrentAction then
			sleep = 0

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'AmbulanceActions' then
					OpenAmbulanceActionsMenu()
				elseif CurrentAction == 'Pharmacy' then
					OpenPharmacyMenu()
				elseif CurrentAction == 'Vehicles' then
					OpenVehicleSpawnerMenu('car', CurrentActionData.hospital, CurrentAction, CurrentActionData.partNum)
				elseif CurrentAction == 'Helicopters' then
					OpenVehicleSpawnerMenu('helicopter', CurrentActionData.hospital, CurrentAction, CurrentActionData.partNum)
				elseif CurrentAction == 'FastTravelsPrompt' then
					FastTravel(CurrentActionData.to, CurrentActionData.heading)
				end

				CurrentAction = nil
			end
		end

		local playerCoords, letSleep = GetEntityCoords(PlayerPedId()), true

		for hospitalNum, hospital in pairs(Config.Hospitals) do
			-- Fast Travels
			for k, v in ipairs(hospital.FastTravels) do
				local distance = #(playerCoords - v.From)

				if distance < Config.DrawDistance then
					sleep = 0
					DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r,
						v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)


					if distance < v.Marker.x then
						FastTravel(v.To.coords, v.To.heading)
					end
				end
			end
		end
		Wait(sleep)
	end
end)

RegisterCommand("ambulance", function(src)
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == 'ambulance')  and not ESX.PlayerData.dead then
		ambulanceMenu()
	end
end)

RegisterKeyMapping("ambulance", "Open Ambulance Actions Menu", "keyboard", "F6")

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local vehicle, distance = ESX.Game.GetClosestVehicle()

	if vehicle and distance < 5 then
		local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

		for i = maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat then
			TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
		end
	end
end)

function OpenCloakroomMenu()
	local elements = {
		{ unselectable = true, icon = "fas fa-shirt", title = TranslateCap('cloakroom') },
		{ icon = "fas fa-shirt", title = TranslateCap('ems_clothes_civil'), value = "citizen_wear" },
		{ icon = "fas fa-shirt", title = TranslateCap('ems_clothes_ems'), value = "ambulance_wear" },
	}

	ESX.OpenContext("right", elements, function(menu, element)
		if element.value == "citizen_wear" then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
				isOnDuty = false

				for playerId, v in pairs(deadPlayerBlips) do
					RemoveBlip(v)
					deadPlayerBlips[playerId] = nil
				end
				deadPlayers = {}
				if Config.Debug then
					print("[^2INFO^7] Off Duty")
				end
			end)
		elseif element.value == "ambulance_wear" then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end

				isOnDuty = true
				ESX.TriggerServerCallback('esx_ambulancejob:getDeadPlayers', function(_deadPlayers)
					TriggerEvent('esx_ambulancejob:setDeadPlayers', _deadPlayers)
				end)
				if Config.Debug then
					print("[^2INFO^7] Player Sex |^5" .. tostring(skin.sex) .. "^7")
					print("[^2INFO^7] On Duty")
				end
			end)
		end
	end)
end

function OpenPharmacyMenu()
	local elements = {
		{ unselectable = true, icon = "fas fa-pills", title = TranslateCap('pharmacy_menu_title') }
	}

	for k, v in pairs(Config.PharmacyItems) do
		elements[#elements + 1] = {
			icon = "fas fa-pills",
			title = v.title,
			item = v.item
		}
	end

	ESX.OpenContext("right", elements, function(menu, element)
		local elements2 = {
			{ unselectable = true, icon = "fas fa-pills", title = element.title },
			{ title = "Amount", input = true, inputType = "number", inputMin = 1, inputMax = 100,
				inputPlaceholder = "Amount to buy.." },
			{ icon = "fas fa-check-double", title = "Confirm", val = "confirm" }
		}

		ESX.OpenContext("right", elements2, function(menu2, element2)
			local amount = menu2.eles[2].inputValue
			if Config.Debug then
				print("[^2INFO^7] Attempting to Give Item - ^5" .. tostring(element.item) .. "^7")
			end
			TriggerServerEvent('esx_ambulancejob:giveItem', element.item, amount)
		end, function(menu)
			OpenPharmacyMenu()
		end)
	end)
end

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 10))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 5))
		SetEntityHealth(playerPed, newHealth)
	end

	if Config.Debug then
		print("[^2INFO^7] Healing Player - ^5" .. tostring(healType) .. "^7")
	end
	if not quiet then
		ESX.ShowNotification(TranslateCap('healed'))
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if isOnDuty and job.name ~= 'ambulance' then
		for playerId, v in pairs(deadPlayerBlips) do
			if Config.Debug then
				print("[^2INFO^7] Removing dead blip - ^5" .. tostring(playerId) .. "^7")
			end
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end

		isOnDuty = false
	end
end)

RegisterNetEvent('esx_ambulancejob:PlayerDead')
AddEventHandler('esx_ambulancejob:PlayerDead', function(Player)
	if Config.Debug then
		print("[^2INFO^7] Player Dead | ^5" .. tostring(Player) .. "^7")
	end
	deadPlayers[Player] = "dead"
end)

RegisterNetEvent('esx_ambulancejob:PlayerNotDead')
AddEventHandler('esx_ambulancejob:PlayerNotDead', function(Player)
	if deadPlayerBlips[Player] then
		RemoveBlip(deadPlayerBlips[Player])
		deadPlayerBlips[Player] = nil
	end

	if Config.Debug then
		print("[^2INFO^7] Player Alive | ^5" .. tostring(Player) .. "^7")
	end
	deadPlayers[Player] = nil
end)

RegisterNetEvent('esx_ambulancejob:setDeadPlayers')
AddEventHandler('esx_ambulancejob:setDeadPlayers', function(_deadPlayers)
	deadPlayers = _deadPlayers

	if isOnDuty then
		for playerId, v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end

		for playerId, status in pairs(deadPlayers) do
			if Config.Debug then
				print("[^2INFO^7] Player Dead | ^5" .. tostring(playerId) .. "^7")
			end
			if status == 'distress' then
				if Config.Debug then
					print("[^2INFO^7] Creating Distress Blip for Player - ^5" .. tostring(playerId) .. "^7")
				end
				local player = GetPlayerFromServerId(playerId)
				local playerPed = GetPlayerPed(player)
				local blip = AddBlipForEntity(playerPed)

				SetBlipSprite(blip, 303)
				SetBlipColour(blip, 1)
				SetBlipFlashes(blip, true)
				SetBlipCategory(blip, 7)

				BeginTextCommandSetBlipName('STRING')
				AddTextComponentSubstringPlayerName(TranslateCap('blip_dead'))
				EndTextCommandSetBlipName(blip)

				deadPlayerBlips[playerId] = blip
			end
		end
	end
end)


RegisterNetEvent('esx_ambulancejob:PlayerDistressed')
AddEventHandler('esx_ambulancejob:PlayerDistressed', function(playerId, playerCoords)
	deadPlayers[playerId] = 'distress'
	if isOnDuty then
		if Config.Debug then
			print("[^2INFO^7] Player Distress Recived - ID:^5" .. tostring(playerId) .. "^7")
		end
		
		deadPlayerBlips[playerId] = nil

		local blip = AddBlipForCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		SetBlipSprite(blip, Config.DistressBlip.Sprite)
		SetBlipColour(blip, Config.DistressBlip.Color)
		SetBlipScale(blip, Config.DistressBlip.Scale)
		SetBlipFlashes(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(TranslateCap('blip_dead'))
		EndTextCommandSetBlipName(blip)
		deadPlayerBlips[playerId] = blip
	end
end)


function onNoItemToRevive()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบหมอ', -- หัวเรื่อง
        description = 'คุณไม่มีของใช้ที่กำหนด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_medkit', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end


function onSendbill()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบบิล', -- หัวเรื่อง
        description = 'สั่งจ่ายบิลเรียบร้อยแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'bill', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end



function onNoInfo()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบบิล', -- หัวเรื่อง
        description = 'กรุณาใส่รายละเอียด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'detail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end


function onNoFineMoney()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบบิล', -- หัวเรื่อง
        description = 'กรุณาใส่จำนวนเงิน', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'bill', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end


function onCreatBill()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบบิล', -- หัวเรื่อง
        description = 'สร้างบิลเรียบร้อยแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'bill', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end