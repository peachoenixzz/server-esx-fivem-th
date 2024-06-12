local isDead       = false
local ProgressList = {}
local lasttarget   = 0
local lasttargetNet = 0
local isCarry      = false
local TargetSource = 0
local isPlayer2    = false
local UiOpen       = false
local Dragsource   = {}

CreateThread(function()
	for key, value in pairs(Config.Animation) do
		ProgressList[key] = false
	end

	local playerPed = PlayerPedId()
	Entity(playerPed).state:set('dragesource', 0, true)
end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	PlayerLoaded = true
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

AddEventHandler('esx:onPlayerDeath', function()
	ESX.UI.Menu.CloseAll()
	isDead    = true
	isPlayer2 = false
	UiOpen = false
	for key, value in pairs(Config.Animation) do
		ProgressList[key] = false
	end
	Wait(200)
	TriggerEvent("esx_status:set" ,  "thirst" , 3000000)
	TriggerEvent("esx_status:set" ,  "hunger" , 3000000)
	TriggerEvent("esx_status:set" ,  "stress" , 0)
	ClearPedTasksImmediately(GetPlayerPed(-1))
end)

AddEventHandler('esx:onPlayerSpawn', function()
	local playerPed = PlayerPedId()
	isDead = false
	isPlayer2 = false
	if TargetSource ~= 0 then
		TargetSource = 0
	end
	Entity(playerPed).state:set('isDead', false, true)
	SetPedConfigFlag(playerPed, 71, false)
	TriggerEvent('carry_cc:cl_stop')
	TriggerServerEvent('carry_cc:setdeathstatus', false)
end)


function GetDeathStatus(target, cb)
	local targetped = GetPlayerFromServerId(target)
	local deathstatus = Entity(GetPlayerPed(targetped)).state.isDead

	if deathstatus ~= nil then
		cb(deathstatus)
	else
		local asyncTasks = {}
		table.insert(asyncTasks, function(cb)
			ESX.TriggerServerCallback('carry_cc:getdeathstatus', function(data)
				if data == nil then
					cb(false)
				else
					cb(data)
				end
			end, target)
		end)

		Async.parallel(asyncTasks, function(results)
			cb(results[1])
		end)
	end

end

function GetDragSource(target, cb)
	local targetped = GetPlayerFromServerId(target)
	Dragsource = Entity(GetPlayerPed(targetped)).state.dragesource

	if Dragsource ~= nil then
		cb(Dragsource)
	else
		local asyncTasks = {}
		table.insert(asyncTasks, function(cb)
			ESX.TriggerServerCallback('carry_cc:getdragsource', function(dragsource)
				if dragsource == nil then
					cb(0)
				else
					cb(dragsource)
				end
			end, target)
		end)

		Async.parallel(asyncTasks, function(results)
			cb(results[1])
		end)
	end
end

function IsDragPlayer()
	local IsDrag = false
	for key, value in pairs(ProgressList) do
		if value == true then IsDrag = true end
	end
	return IsDrag
end
exports("IsDragPlayer", IsDragPlayer);


RegisterNetEvent('carry_cc:updatedragsource')
AddEventHandler('carry_cc:updatedragsource:', function(source, dragsource)
	Dragsource[source] = dragsource
end)

RegisterNetEvent('carry_cc:clearCarryState')
AddEventHandler('carry_cc:clearCarryState', function()

	local clear = false
	for key, value in pairs(ProgressList) do
		if value == true then
			clear = true
			ProgressList[key] = false
		end
	end

	if clear then
		local playerped = PlayerPedId()
		ClearPedSecondaryTask(playerped)
		DetachEntity(playerped, true, false)
		FreezeEntityPosition(playerped, false)
	end

	isPlayer2 = false
end)

function OpenCivilianActionsMenu()


	if isDead then return end


	ESX.UI.Menu.CloseAll()

	if isPlayer2 then
		return
	end


	local elements = {}

	table.insert(elements, { label = ('Player Menu'), value = 'id_kort4', requestaccept = true })
	-- table.insert(elements, { label = ('Player Menu'), value = 'id_kort4' })

	local Department = {
		['admin'] = true,
		['police'] = true,
		['ambulance'] = true,
		['circle'] = true
	}


	PlayerData = ESX.GetPlayerData()

	if Department[PlayerData.job.name] then
		table.insert(elements, { label = ('Agency Menu'), value = 'agency_menu', requestaccept = false })
	end

	ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'civilian_actions',
			{
				title    = _U('citizen_interactions'),
				align    = 'top-right2',
				elements = elements
			}, function(data, menu)
				if data.current.value == 'id_kort4' then
					OpenActionMenuInteraction(data.current.requestaccept)
				end

				if data.current.value == 'agency_menu' then
					OpenActionMenuInteraction(data.current.requestaccept)
				end
			end, function(data, menu)
				UiOpen = false
				menu.close()
			end)
end

if Config.UseKeymapping then
	RegisterCommand('playerMenu', function()
		local IsHandcuffed = false
		if GetResourceState("esx_policejob") ~= "missing" then
			IsHandcuffed = exports['esx_policejob']:getStatusHandcuffed() or false
		end
		if not IsHandcuffed then
			OpenCivilianActionsMenu()
		end
	end, false)

	RegisterKeyMapping('playerMenu', 'Player Menu', 'keyboard', 'F9')
else
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1)
			local IsHandcuffed = false
			if GetResourceState("esx_policejob") ~= "missing" then
				IsHandcuffed = exports['esx_policejob']:getStatusHandcuffed() or false
			end
			if IsControlPressed(0, 56) and not IsHandcuffed then
				OpenCivilianActionsMenu()
				Wait(1000)
			end
		end
	end)
end


function StatusLabel(text, status)
	local text = text

	local color = 'rgb(0, 150, 255)'

	if status then
		text = ("<span  style='color: %s'>%s</span>"):format(color, text)
	end

	return text
end

function OpenActionMenuInteraction(requestaccept)
	local elements = {}
	local index = 1
	for key, value in pairs(ProgressList) do
		if not Config.Animation[key].hide then
			index = Config.Animation[key].index
			if value == true then
				elements = {}
				index = 1
			end

			elements[index] = { label = StatusLabel(Config.Animation[key].label, value), value = key }

			if value == true then break end
		end
	end

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'action_menu',
			{
				title    = ('Player Menu'),
				align    = 'top-right2',
				elements = elements
			}, function(data, menu)


				if IsPedInAnyVehicle(PlayerPedId()) then
					goto endmenu
				end

				local playerped = PlayerPedId()
				if not ProgressList[data.current.value] then
					GetClosestPlayer(3, function(list)
						if list[1] ~= nil then

							local player = list[1]

							local closestPlayer = player[5]
							if not IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) then
								local ped = GetPlayerPed(closestPlayer)
								local target = player[1]
								if Config.Animation[data.current.value].deathonly then
									if not player[4] then
										exports.nc_notify:PushNotification({
											scale = 1.0, -- ปรับขนาดของ Notify
											title = 'ระบบอุ้ม', -- หัวเรื่อง
											description = 'ไม่สามารถอุ้มผู้หมดสติด้วยท่าทางนี้ได้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
											type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
											position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
											direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
											priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
											icon = 'no_result', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
											duration = 3000 -- ระยะเวลาการแสดง Notify
										})
										return
									end
								end

								if Config.Animation[data.current.value].blockdeath and player[4] then
									exports.nc_notify:PushNotification({
										scale = 1.0, -- ปรับขนาดของ Notify
										title = 'ระบบอุ้ม', -- หัวเรื่อง
										description = 'ไม่สามารถอุ้มผู้หมดสติด้วยท่าทางนี้ได้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
										type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
										position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
										direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
										priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
										icon = 'no_result', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
										duration = 3000 -- ระยะเวลาการแสดง Notify
									})
									return
								end

								GetDragSource(target, function(Dragsource)
									if Dragsource == nil then return end

									if not IsPedInAnyVehicle(GetPlayerPed(GetPlayerFromServerId(Dragsource))) then
										TriggerServerEvent('carry_cc:sync', target, data.current.value, not requestaccept)
										menu.close()
									else
										exports.nc_notify:PushNotification({
											scale = 1.0, -- ปรับขนาดของ Notify
											title = 'ระบบอุ้ม', -- หัวเรื่อง
											description = 'ไม่สามารถทำการกระทำนี้ได้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
											type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
											position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
											direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
											priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
											icon = 'no_result', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
											duration = 3000 -- ระยะเวลาการแสดง Notify
										})
									end
								end)
							else
								exports.nc_notify:PushNotification({
									scale = 1.0, -- ปรับขนาดของ Notify
									title = 'ระบบอุ้ม', -- หัวเรื่อง
									description = 'ไม่สามารถทำการกระทำนี้ได้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
									type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
									position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
									direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
									priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
									icon = 'no_result', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
									duration = 3000 -- ระยะเวลาการแสดง Notify
								})
							end
						else
							exports.nc_notify:PushNotification({
								scale = 1.0, -- ปรับขนาดของ Notify
								title = 'ระบบอุ้ม', -- หัวเรื่อง
								description = 'ไม่มีผู้เล่นอยู่ในบริเวณ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
								type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
								position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
								direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
								priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
								icon = 'no_result', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
								duration = 3000 -- ระยะเวลาการแสดง Notify
							})
						end

					end)

				else
					ProgressList[data.current.value] = false
					ClearPedSecondaryTask(playerped)
					DetachEntity(playerped, true, false)

					if lasttarget ~= 0 then
						GetDragSource(lasttarget, function(lastDragsource)
							if GetPlayerServerId(PlayerId()) == lastDragsource then
								TriggerServerEvent("carry_cc:stop", lasttarget)
								menu.close()
							end
						end)
					end
				end
				UiOpen = false

				::endmenu::
			end, function(data, menu)
				UiOpen = false
				menu.close()
			end)
end

function SyncTarget(target, animation, checkshroud)

	TargetSource = target
	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	local animationdata = Config.Animation[animation]


	-- if GetDistanceBetweenCoords(GetEntityCoords(playerPed), GetEntityCoords(targetPed), true) > 2 then
	-- return
	-- end

	isPlayer2 = true

	ProgressList[animation] = true
	isCarry                 = true


	RequestAnimDict(animationdata.lib2)

	while not HasAnimDictLoaded(animationdata.lib2) do
		Citizen.Wait(10)
	end

	if IsEntityDead(playerPed) or isDead then
		Reviveafterdead()
	end

	if animationdata.spin == nil then animationdata.spin = 180.0 end

	AttachEntityToEntity(playerPed, targetPed, 0, animationdata.distans2, animationdata.distans, animationdata.height, 0.5, 0.5, animationdata.spin, false, false, false, false, 2, false)
	FreezeEntityPosition(playerPed, true)
	if animationdata.controlFlagTarget == nil then
		animationdata.controlFlagTarget = 0
	end

	if not isDead then
		TaskPlayAnim(playerPed, animationdata.lib2, animationdata.anim2, 8.0, -8.0, animationdata.length,
				animationdata.controlFlagTarget, 0, false, false, false)
	else
		TaskPlayAnim(playerPed, 'missarmenian2', 'corpse_search_exit_ped', 8.0, -8.0, -1, 1, 0, false, false, false)
	end

	TriggerServerEvent('carry_cc:syncownewr', TargetSource, animation)

	Wait(100)

	if isDead then
		SetPedConfigFlag(playerPed, 71, true)
	end
end

RegisterNetEvent('carry_cc:syncTarget')
AddEventHandler('carry_cc:syncTarget', function(target, animation, department, isadmin)
	local EnableRequset

	if isadmin then
		EnableRequset = true
	else
		EnableRequset = department
	end

	if GetResourceState("dri_kidnap") ~= "missing" then
		if exports["dri_kidnap"]:getKidnap() then
			TargetSource = 0
			EnableRequset = true
		end
	end

	if isDead then
		TargetSource = 0
		EnableRequset = true
	end

	if not EnableRequset then
		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'Request_Menu',
				{
					title    = 'ตกลงที่จะโดนอุ้มรึป่าว ?',
					align    = 'top-right2',
					elements = {
						{ label = ('Yes'), value = 'yes' },
						{ label = ('No'), value = 'no' }
					}
				},

				function(data, menu)
					local coords = GetEntityCoords(PlayerPedId())
					local targetcoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))
					if (GetDistanceBetweenCoords(coords, targetcoords.x, targetcoords.y, targetcoords.z, true) > 5.0) then
						menu.close()
						return
					end

					if data.current.value == 'yes' then
						SyncTarget(target, animation, false)
						menu.close()
					elseif data.current.value == 'no' then
						menu.close()
					end

				end,
				function(data, menu)
					menu.close()
				end
		)
	else
		SyncTarget(target, animation, true)
	end
end)


function Reviveafterdead()
	local formattedCoords = GetEntityCoords(PlayerPedId())
	--local formattedCoords = GetEntityCoords(targetPed)
	RespawnAfter(PlayerPedId(), formattedCoords, 377.1)
	SetEntityHealth(PlayerPedId(), 120)
	SetEntityInvincible(PlayerPedId(), true)
	SetPlayerInvincible(PlayerId(), true)
	SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), false)
	SetEntityCanBeDamaged(GetPlayerPed(-1), false)
	SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
	ClearPedTasksImmediately(PlayerPedId())
	RequestAnimDict('missarmenian2')
	while not HasAnimDictLoaded('missarmenian2') do
		Citizen.Wait(0)
	end
end

function RespawnAfter(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z+0.4, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z+0.4, heading, true, false)
	ClearPedBloodDamage(ped)
	ESX.UI.Menu.CloseAll()
end

RegisterNetEvent('carry_cc:syncMe')
AddEventHandler('carry_cc:syncMe', function(animation, playerid)

	ProgressList[animation] = true

	lasttarget = playerid
	local ped = PedToNet(GetPlayerPed(GetPlayerFromServerId(lasttarget)))
	SetEntityAsMissionEntity(ped, true, true)
	SetNetworkIdExistsOnAllMachines(ped, true)
	NetworkSetNetworkIdDynamic(ped, true)
	SetNetworkIdCanMigrate(ped, false)
	local animationdata = Config.Animation[animation]
	local playerPed = GetPlayerPed(-1)
	RequestAnimDict(animationdata.lib)

	while not HasAnimDictLoaded(animationdata.lib) do
		Wait(10)
	end
	Wait(500)
	if animationdata.controlFlagMe == nil then animationdata.controlFlagMe = 0 end
	TaskPlayAnim(playerPed, animationdata.lib, animationdata.anim1, 8.0, -8.0, animationdata.length,
			animationdata.controlFlagMe, 0, false, false, false)
	Wait(animationdata.length)
end)

RegisterNetEvent('carry_cc:cl_stop')
AddEventHandler('carry_cc:cl_stop', function(deathState,formattedCoords)
	local playerped = PlayerPedId()

	for key, value in pairs(ProgressList) do
		if value == true then
			ProgressList[key] = false
		end
	end

	if isDead then
		local coords = GetEntityCoords(PlayerPedId())
		SetEntityCoordsNoOffset(GetPlayerPed(-1), coords.x, coords.y, coords.z+0.7, false, false, false, true)
		SetEntityHealth(playerped, 0)
		SetEntityInvincible(PlayerPedId(), false)
		SetPlayerInvincible(PlayerId(), false)
		SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), false)
		SetEntityCanBeDamaged(GetPlayerPed(-1), true)
		SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
		SetPedConfigFlag(playerped, 71, false)
	else
		SetEntityInvincible(PlayerPedId(), false)
		SetPlayerInvincible(PlayerId(), false)
		SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), false)
		SetEntityCanBeDamaged(GetPlayerPed(-1), true)
		SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
		SetPedConfigFlag(playerped, 71, false)
	end
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(playerped, true, false)
	FreezeEntityPosition(playerped, false)
	isPlayer2 = false
end)

function GetPlayers()
	local players = {}

	for _, player in ipairs(GetActivePlayers()) do
		if NetworkIsPlayerActive(player) then
			table.insert(players, player)
		end
	end

	return players
end

function GetClosestPlayer(radius, cb)
	local playerped = PlayerPedId()
	local playercoord = GetEntityCoords(playerped)
	local playerlist = ESX.Game.GetPlayersInArea(playercoord, radius)

	local checklist = {}
	local asyncTasks = {}

	for index, player in pairs(playerlist) do
		table.insert(asyncTasks, function(cb)
			local ped = GetPlayerPed(player)
			local serverid = GetPlayerServerId(player)
			local EntityCoord = GetEntityCoords(ped)
			local Distance = GetDistanceBetweenCoords(playercoord, EntityCoord, true)

			GetDeathStatus(serverid, function(data)
				local deathstatus = 0
				if data == true then
					deathstatus = 1
				end

				table.insert(checklist, { serverid, Distance, deathstatus, data, player })
				cb()
			end)
		end)
	end



	Async.parallel(asyncTasks, function(results)

		table.sort(checklist, function(a, b)
			return a[2] < b[2]
		end)

		table.sort(checklist, function(a, b)
			return a[3] > b[3]
		end)

		cb(checklist)
	end)
end

function LoadAnimationDictionary(animationD)
	while (not HasAnimDictLoaded(animationD)) do
		RequestAnimDict(animationD)
		Citizen.Wait(1)
	end
end

RegisterNetEvent('carry_cc:upplyft')
AddEventHandler('carry_cc:upplyft', function(target)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	local dict = "penguin@carry_f"

	if isCarry == false then
		LoadAnimationDictionary(dict)
		AttachEntityToEntity(playerPed, targetPed, 9816, 0.0, -0.0, 0.0, 0.9, 0.5, 180.0, false, false, false, false, 2, false)
		ClearPedTasksImmediately(playerPed)
		TaskPlayAnim(playerPed, dict, "penguin_carry_f", 8.0, -8, -1, 33, 0, 0, 0, 0)
		FreezeEntityPosition(playerPed, true)
		isCarry = true
	else
		DetachEntity(playerPed, true, false)
		ClearPedTasksImmediately(targetPed)
		ClearPedTasksImmediately(playerPed)
		FreezeEntityPosition(playerPed, false)

		isCarry = false
	end
end)

CreateThread(function()
	while true do
		Wait(1)
		local BlockAction = false
		for key, value in pairs(ProgressList) do
			if value == true then BlockAction = true end
			if key ~= 'dragdeath' and value == true then
				BlockSlide = true
			end
		end

		if BlockAction then
			EnableControlAction(0, 0, true)
			EnableControlAction(0, 1, true)
			EnableControlAction(0, 2, true)
			DisableControlAction(0, 38, true) -- E
			DisableControlAction(0, 74, true) -- H
		else
			Wait(1000)
		end
	end
end)

CreateThread(function()
	while true do
		Wait(10000)
		if IsPedInAnyVehicle(GetPlayerPed(GetPlayerFromServerId(TargetSource)), false)  and TargetSource ~= 0 then
			local clear = false
			for key, value in pairs(ProgressList) do
				if value == true then
					clear = true
				end
			end
			if clear then
				print(TargetSource)
				print(isDead)
				ESX.TriggerServerCallback('carry_cc:checkPlayerAlive', function(isDepartment)
					if not isDead and not isDepartment then
						clearDragPlayerOnVehicle()
					end
				end,TargetSource)
			end
		end
	end
end)

function clearDragPlayerOnVehicle()
	local playerped = PlayerPedId()
	ClearPedTasksImmediately(playerped)
	DetachEntity(playerped, true, false)
	FreezeEntityPosition(playerped, false)
	TriggerServerEvent("carry_cc:stop", lasttarget)
	lasttarget = 0
	lasttargetNet = 0
	TargetSource = 0
end

function clearDragPlayer()
	local playerped = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(TargetSource))
	ClearPedTasksImmediately(playerped)
	ClearPedTasksImmediately(targetPed)
	DetachEntity(playerped, true, false)
	FreezeEntityPosition(playerped, false)
	TriggerServerEvent("carry_cc:stop", lasttarget)
	lasttarget = 0
	lasttargetNet = 0
	TargetSource = 0
end


CreateThread(function()
	while true do
		Wait(500)
		if lasttarget ~= 0 then
			--print("lasttarget ~= 0")
				GetDragSource(lasttarget, function(lastDragsource)
				if lastDragsource ~= nil then
					--print("lastDragsource ~= nil")
					if lastDragsource ~= 0 then
						--print("if lastDragsource ~= 0 then")
						if lastDragsource ~= GetPlayerServerId(PlayerId()) then
							--print(" lastDragsource ~= GetPlayerServerId(PlayerId())")
							local playerped = PlayerPedId()

							for key, value in pairs(ProgressList) do
								ProgressList[key] = false
							end

							ClearPedSecondaryTask(playerped)
							DetachEntity(playerped, true, false)
							lasttarget = 0
							lasttargetNet = 0
						else
							--print(" before if isDead then")
							if isDead then
								--print(" before if isDead then")
								TriggerServerEvent("carry_cc:stop", lasttarget)
							end
						end
					else
						local playerped = PlayerPedId()
						--print(" else if lastDragsource ~= 0 then")
						for key, value in pairs(ProgressList) do
							ProgressList[key] = false
						end

						ClearPedSecondaryTask(playerped)
						DetachEntity(playerped, true, false)
						TriggerServerEvent("carry_cc:stop", lasttarget)
						lasttarget = 0
						lasttargetNet = 0
					end
				end
			end)
		end
		::endState::
		Wait(50)
	end
end)

CreateThread(function()
	RequestAnimDict('missarmenian2')
	while not HasAnimDictLoaded('missarmenian2') do
		Wait(0)
	end
	while true do
		Wait(300)
		local playerPed = PlayerPedId()
		if isDead then

			local state = Entity(playerPed).state.IsDead

			if state == nil then
				Entity(playerPed).state:set('isDead', isDead, true)
			end

			local animate = false
			for key, value in pairs(ProgressList) do
				if value == true then
					animate = true
				end
			end

			if animate then
				if IsEntityPlayingAnim(playerPed, 'missarmenian2', 'corpse_search_exit_ped', 3) ~= 1 then
					ESX.Streaming.RequestAnimDict('missarmenian2', function()
						TaskPlayAnim(playerPed, 'missarmenian2', 'corpse_search_exit_ped', 8.0, -8, -1, 47, 0.0, false, false, false)
					end)
				end
			end
		end
	end
end)


AddStateBagChangeHandler('dragesource', nil, function(bagName, key, value, _unused, replicated)
	-- we only want to cause an explosion when the value is set to true!
	if not value then return end
	--print("DragsourceIs: ".. value)
end)



AddStateBagChangeHandler('isDead', nil, function(bagName, key, value, _unused, replicated)
	-- we only want to cause an explosion when the value is set to true!
	if not value then return end
	--print("IsDead: ".. json.encode(value))
end)
