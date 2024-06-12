
local isDead, isBusy = false, false
local doRepair, helpNotify = false,true

RegisterNetEvent('esx_mechanicjob:onHijack')
AddEventHandler('esx_mechanicjob:onHijack', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		local chance = math.random(100)
		local alarm  = math.random(100)

		if DoesEntityExist(vehicle) then
			if alarm <= 33 then
				SetVehicleAlarm(vehicle, true)
				StartVehicleAlarm(vehicle)
			end

			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

			CreateThread(function()
				Wait(10000)
				if chance <= 66 then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					--ESX.ShowNotification(TranslateCap('veh_unlocked'))
				else
					--ESX.ShowNotification(TranslateCap('hijack_failed'))
					ClearPedTasksImmediately(playerPed)
				end
			end)
		end
	end
end)


function onCarKit(type)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = ESX.Game.GetClosestVehicle(coords)
		end
		if DoesEntityExist(vehicle) then
			doingProcess(15000,vehicle,type)
		end
	end
end


RegisterNetEvent('esx_mechanicjob:checkPlayerInVehicle')
AddEventHandler('esx_mechanicjob:checkPlayerInVehicle', function(itemName)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 8.0) then
		local vehicle = ESX.Game.GetClosestVehicle(coords)
		if DoesEntityExist(vehicle) then
			if ESX.Game.IsVehicleEmpty(vehicle) then
				ESX.TriggerServerCallback('esx_mechanicjob:validateBeforeRepair', function(res)
					--print(res)
					if res == "onCarKit" then
						onCarKit(res)
					end
					if res == "onCarKitGov" then
						onCarKit(res)
					end
					if res == "carWash" then
						onCarKit(res)
					end
				end, itemName)
				return
			end

			exports.nc_notify:PushNotification({
				scale = 1.0, -- ปรับขนาดของ Notify
				title = 'ระบบซ่อมรถ', -- หัวเรื่อง
				description = 'ไม่สามารถทำรายการได้ในขณะนี้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
				type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
				position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
				direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
				priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
				icon = 'no_repair', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
				duration = 3000 -- ระยะเวลาการแสดง Notify
			})
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		::reCheck::
		Citizen.Wait(0)
		if not doRepair then
			Citizen.Wait(1000)
			goto reCheck
		end
		if doRepair then
			local playerPed = PlayerPedId()

			if helpNotify and doRepair then
				exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
				helpNotify = false
			end

			if doRepair then
				DisableControlAction(0,Config.Key['G'], true)
				DisableControlAction(0, Config.Key['T'], true)
				DisableControlAction(0, Config.Key['E'], true)
				DisableControlAction(0, Config.Key['F'], true)
				EnableControlAction(0, Config.Key['X'], true)
				DisableControlAction(0, Config.Key['DELETE'], true)
				DisableControlAction(0, Config.Key['F2'], true)
			end

			if IsPedInAnyVehicle(PlayerPedId(), true) and doRepair then
                exports.helpnotify:hideHelpNotification()
				TriggerEvent("mythic_progbar:client:cancel")
				--FreezeEntityPosition(playerPed,false)
				helpNotify = true
				doRepair = false
            end

			if IsControlJustPressed(0,73) and doRepair then
				exports.helpnotify:hideHelpNotification()
				TriggerEvent("mythic_progbar:client:cancel")
				FreezeEntityPosition(playerPed,false)
				helpNotify = true
				doRepair = false
				pcall(function() -- Start Log
					exports['azael_dc-serverlogs']:insertData({
						event = 'playerCancelRepairVehicle',
						content = ('ผู้เล่นได้ทำการกด X เพื่อยกเลิกการซ่อมรถแล้ว'):format(),
					})
				end) -- End Log
			end
		end
	end
end)


function doingProcess(time,vehicle,type) -- สามารถเพิ่ม param anim ได้ หรือ obj ก็ได้
	doRepair = true
	TriggerEvent("mythic_progbar:client:progress",{
		name = "processRepair",
		duration = time,
		label = "กำลังซ่อม",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "amb@world_human_gardener_plant@female@base", -- ท่าทางเวลาขุด
			anim = "base_female",		-- ท่าทางเวลาขุด
			flags = 49,
		},
	}, function(status)
		if not status then
			successProcess(type,vehicle)
		end
	end)
end

function successProcess(type,vehicle)
	if IsEntityDead(vehicle) then
		SetEntityAsMissionEntity(vehicle, true, true)
		DeleteVehicle(vehicle)
		doRepair = false
		exports.helpnotify:hideHelpNotification()
		return
	end
	if type == "onCarKit" then
		ESX.TriggerServerCallback('esx_mechanicjob:finalcheckitem', function(haveitem)
			if haveitem then
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				SetVehicleDirtLevel(vehicle, 0.0)
				doRepair=false
				exports.helpnotify:hideHelpNotification()
				--ESX.ShowNotification(TranslateCap('veh_repaired'))
				onVehicleRepair()
			else
				notinoitemtofix()
				doRepair=false
				exports.helpnotify:hideHelpNotification()
			end
			return
		end, "toolkit") --ส่งไอเทมเนมไปด้วย hardcode
	end
	if type == "onCarKitGov" then
		SetVehicleFixed(vehicle)
		SetVehicleDeformationFixed(vehicle)
		SetVehicleUndriveable(vehicle, false)
		SetVehicleDirtLevel(vehicle, 0.0)
		doRepair=false
		exports.helpnotify:hideHelpNotification()
		--ESX.ShowNotification(TranslateCap('veh_repaired'))
		onVehicleRepair()
		return
	end
	if type == "carWash" then
		ESX.TriggerServerCallback('esx_mechanicjob:finalcheckitem', function(haveitem)
			if haveitem then
				--SetVehicleUndriveable(vehicle, false)
				SetVehicleDirtLevel(vehicle, 0.0)
				SetVehicleDeformationFixed(vehicle)
				doRepair=false
				exports.helpnotify:hideHelpNotification()
				--ESX.ShowNotification(TranslateCap('veh_repaired'))
				onVehicleWash()
			else
				notinoitemtofix()
				doRepair=false
				exports.helpnotify:hideHelpNotification()
			end
			return
		end, "veh_towel") --ส่งไอเทมเนมไปด้วย hardcode
	end
end


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
	if doRepair then
		TriggerEvent("mythic_progbar:client:cancel")
	end
	doRepair = false
	helpNotify = true
	FreezeEntityPosition(PlayerPedId(),false)
	exports.helpnotify:hideHelpNotification()
end)
AddEventHandler('esx:onPlayerSpawn', function(spawn) isDead = false end)


function onVehicleWash()
	exports.nc_notify:PushNotification({
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบล้างรถ', -- หัวเรื่อง
		description = 'ล้างรถสำเร็จแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'success',
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'repair', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end

function notinoitemtofix()
	exports.nc_notify:PushNotification({
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบล้างรถ', -- หัวเรื่อง
		description = 'คุณไม่มีสิ่งของที่กำหนด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning',
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end

function onVehicleRepair()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบซ่อมรถ', -- หัวเรื่อง
        description = 'ซ่อมรถสำเร็จแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'repair', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end