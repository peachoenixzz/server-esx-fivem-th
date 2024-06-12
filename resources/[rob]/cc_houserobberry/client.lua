ESX = nil
local currentHouse = nil
local houseDataInfo = {}
local ongoingRobHouse = false
local entranceCoords = nil
local ongoingfreeze = false
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local fontId
Citizen.CreateThread(function()
    RegisterFontFile('font4thai')
    fontId = RegisterFontId('font4thai') 
end)

function DrawText3DHouseRob(x,y,z, text,mul)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
	local scale = (1/dist)*2
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov *mul
	if onScreen then
		SetTextScale(0.0*scale, 0.55*scale)
		SetTextFont(fontId)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
		local coords = GetEntityCoords(PlayerPedId())
		for _,a in pairs(Config.HouseRob) do
            for _,v in pairs(a.portal) do
                if(GetDistanceBetweenCoords(coords, v.coords, false) < 5) then
                    if v.type == "entrance" then
						if not v.onCooldown then
							DrawText3DHouseRob(v.coords.x, v.coords.y, v.coords.z, "กด ~y~[E]~w~ เพื่อปล้นบ้าน", 1.0)
						end
                        sleep = 0
                    end
					if v.type == "entrance"  then
						if v.onCooldown then
							DrawText3DHouseRob(v.coords.x, v.coords.y, v.coords.z, "~r~ บ้านถูกปล้นแล้ว", 1.0)
						end
						sleep = 0
					end
                    if v.type == "exit" then
                        DrawText3DHouseRob(v.coords.x, v.coords.y, v.coords.z, "~r~กด ~r~[E]~r~ เพื่อออกจากบ้าน", 1.0)
                        sleep = 0
                    end
                end

                if(GetDistanceBetweenCoords(coords, v.coords, false) < 1) then
					if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) then
						if exports.Dv_Hunter_Check:CheckPolice(6) then
							if v.type == "entrance" and v.onCooldown then
								pcall(function()-- Start Log
									exports['azael_dc-serverlogs']:insertData({
										event = 'TryToExploitCooldown',
										content = ('ผู้เล่นพยายามจะเข้าบ้านที่ติด Cooldown ชื่อบ้าน %s พิกัด %s'):format(v.name,v.destination),
									})
								end)-- End Log
								isCooldown()
								goto endState
							end
							entranceCoords = v.coords
							startrobHouse(v.type, v.destination , v.heading, a.name)
						else
							isNocop()
						end
                    end
                end
            end
		end
		::endState::
		Citizen.Wait(sleep)
    end
end)

function startrobHouse(teloporttype, destination, heading, name)
	if teloporttype == "entrance" then
		ESX.TriggerServerCallback('cc_houserobberry:checkkeyCard', function(havekeycard,canRob)
			if not canRob then
				pcall(function()-- Start Log
					exports['azael_dc-serverlogs']:insertData({
						event = 'TryToExploitCooldown',
						content = ('ผู้เล่นพยายามจะเข้าบ้านที่ติด Cooldown ชื่อบ้าน %s พิกัด %s'):format(name,destination),
					})
				end)-- End Log
				isCooldown()
				return
			end
			if havekeycard then
				local minigameresult = exports.storerobbery:miniGameLockPick(false)
				if minigameresult then
					ESX.TriggerServerCallback('cc_houserobberry:statrobminigameSussces', function(cango)
						if cango then
							pcall(function()-- Start Log
								exports['azael_dc-serverlogs']:insertData({
									event = 'SuccessTeleportRob',
									content = ('ผู้เล่นสามารถเข้าบ้านได้สำเร็จ ชื่อบ้าน %s พิกัด %s'):format(name,destination),
								})
							end)-- End Log
							currentHouse = name
							ongoingRobHouse = true
							startTeleportRob(destination, heading)
							inithouseData()
						end
					end,name)
				else
					TriggerServerEvent('cc_houserobberry:statrobminigameFail')
					--TriggerEvent("Porpy_policealert:alertNet", "house_rob",entranceCoords)
				end
			end
			
			if not havekeycard then
				onNoItemtoRob()
			end 
		end,name)
	end

	if teloporttype == "exit" then
		currentHouse = nil
		ongoingRobHouse = false
		houseDataInfo = {}
		TriggerServerEvent('cc_houserobberry:exitHouse')
		startTeleportRob(destination, heading)
	end
end

function forceExit()
	for _,v in pairs(Config.HouseRob) do
		if v.name == currentHouse then 
			for _,v in pairs(v.portal) do
				if v.type == "exit" then 
					currentHouse = nil
					ongoingRobHouse = false
					houseDataInfo = {}
					TriggerServerEvent('cc_houserobberry:exitHouse')
					startTeleportRob(v.destination, v.heading)
				end
			end
		end
	end
end

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

function startTeleportRob(destination, heading)
	local ped = PlayerPedId()
	local currentHealth = GetEntityHealth(ped)
	local currentArmor = GetPedArmour(ped)
	SwitchOutPlayer(ped,0,1)
	Citizen.Wait(1000)
	freezePlayer(PlayerId(), true)
	-- preload collisions for the spawnpoint
	RequestCollisionAtCoord(destination.x, destination.y, destination.z)
	-- spawn the player

	SetEntityCoordsNoOffset(ped, destination.x, destination.y, destination.z, false, false, false)
	NetworkResurrectLocalPlayer(destination.x, destination.y, destination.z, heading, true, true, false)
	SetGameplayCamRelativeHeading(0.0)
	SetEntityHeading(ped, heading)
	SetEntityHealth(ped, currentHealth)
	SetPedArmour(ped, currentArmor)
	Citizen.Wait(1000)
	local time = GetGameTimer()
	while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 30000) do
		RequestCollisionAtCoord(destination.x, destination.y, destination.z)
		Citizen.Wait(0)
	end
	SwitchInPlayer(ped)
	ongoingfreeze = true
	unFreeze()
end

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

function inithouseData()
	if currentHouse ~= nil then
		for _,v in pairs(Config.HouseRob) do
			if v.name == currentHouse then
				--print(v.name.." = "..currentHouse)
				for _,v in pairs(v.robzone) do
					pcall(function()-- Start Log
						exports['azael_dc-serverlogs']:insertData({
							event = 'initHouseAfterSuccesLockPick',
							content = ('จุดเก็บของที่ผู้เล่นได้รับ คือ %s ประเภท %s'):format(v.coords,v.type),
						})
					end)-- End Log
					table.insert(houseDataInfo, v)
				end
				spawnRobPosition()
			end
		end
	end
end

function spawnRobPosition()
	if currentHouse ~= nil then
		if ongoingRobHouse then
			Citizen.CreateThread(function()
				while ongoingRobHouse do
					local sleep = 1000
					local coords = GetEntityCoords(PlayerPedId())
					for k,v in pairs(houseDataInfo) do
						if(GetDistanceBetweenCoords(coords, v.coords, false) < 1) then
							if v.type == "search" then
								DrawText3DHouseRob(v.coords.x, v.coords.y, v.coords.z, "กด ~y~[G]~w~ เพื่อปล้น", 1.8)
								sleep = 0
							end
							if v.type == "safe" then
								DrawText3DHouseRob(v.coords.x, v.coords.y, v.coords.z, "กด ~y~[G]~w~ เพื่อปล้นตู้เซฟ", 1.8)
								sleep = 0
							end
						end
		
						if(GetDistanceBetweenCoords(coords, v.coords, false) < 1) then
							if IsControlJustPressed(0, 47) and IsPedOnFoot(PlayerPedId()) then
								if v.type == "search" then
									pcall(function()-- Start Log
										exports['azael_dc-serverlogs']:insertData({
											event = 'RobHouseSearch',
											content = ('เริ่มต้นการกระทำกับค้นหาของในบ้าน'):format(),
										})
									end)-- End Log
									searchHouse(k)
								end
								if v.type == "safe" then
									pcall(function()-- Start Log
										exports['azael_dc-serverlogs']:insertData({
											event = 'RobHouseSafe',
											content = ('เริ่มต้นการกระทำกับตู้เซฟในบ้าน'):format(),
										})
									end)-- End Log
									ESX.TriggerServerCallback('cc_houserobberry:checkkeyKeytoRob', function(havekeytorob)
										if havekeytorob then
											local res = exports["pd-safe"]:createSafe({math.random(0,20),math.random(30,60),math.random(80,99)})
											if res then
												houseDataInfo[k] = nil
												ESX.TriggerServerCallback('cc_houserobberry:giveitemHouseRobSafeCracker', function(givesafe)end)
											else
												--TriggerEvent("Porpy_policealert:alertNet", "house_rob",entranceCoords)
												exports['Porpy_policealert']:alertNet("house_rob",entranceCoords)
											end
										else
											pcall(function()-- Start Log
												exports['azael_dc-serverlogs']:insertData({
													event = 'HouseNoKeyCard',
													content = ('ผู้เล่นไม่มีกุญแจสำหรับเปิดตู้เซฟ'):format(),
												})
											end)-- End Log
											onNoItemtoRob()
										end
									end)
								end
							end
						end			
					end
					Citizen.Wait(sleep)
				end
			end)
		end
	end	
end

function searchHouse(k)
	TriggerEvent("mythic_progbar:client:progress",{
		name = "houserob",
		duration = 10000,
		label = "ปล้นบ้าน",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
			anim = "machinic_loop_mechandplayer",
			flags = 49,
		},
	}, function(status)
		if not status then
			houseDataInfo[k] = nil
			ESX.TriggerServerCallback('cc_houserobberry:giveitemHouseRobSearch', function(give)end)
			--table.remove(houseDataInfo, k)
		end
	end)
end

RegisterNetEvent('cc_houseRobbery:updateConfigEntrance')
AddEventHandler('cc_houseRobbery:updateConfigEntrance', function(name,status)
	for _,v in pairs(Config.HouseRob) do
		if v.name == name then
			for _,vh in pairs(v.portal) do
				if vh.type == "entrance" then
					vh.onCooldown = status
				end
			end
		end
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(5000)
-- 		for k,v in pairs(houseDataInfo) do
-- 			print(k.." = "..v.coords)
-- 		end
-- 		print("done")
-- 	end
-- end)


-- Notification Zone 
--=========================================================================================================================================================================================================================
--=========================================================================================================================================================================================================================


function onNoItemtoRob()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบงัดบ้าน', -- หัวเรื่อง
        description = 'คุณไม่มีไอเทมที่กำหนด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function isCooldown()
	exports.nc_notify:PushNotification({
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบงัดบ้าน', -- หัวเรื่อง
		description = 'ไม่สามารถปล้นบ้านได้ในขณะนี้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end

function isNocop()
	exports.nc_notify:PushNotification({
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบงัดบ้าน', -- หัวเรื่อง
		description = 'เจ้าหน้าที่ไม่เพียงพอสำหรับปล้นบ้าน', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'no_cop', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end