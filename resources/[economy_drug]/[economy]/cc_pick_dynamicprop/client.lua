ESX = nil
local currentJobZone = nil
Isworking 				= false
ProtectSpam 			= false
startWorkDynamic					= false
spawnProp = false
OnGoingHuntSession = false
AnimalsInSession = {}
local ongoingAutofarmDynamic = false
local helpNotify = true


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function checkInDynamic()
    return startWorkDynamic
end

for _,v in pairs(Config.JobDynamicInfoClient) do
	RequestModel(v.objectName)
end


for _,v in pairs(Config.JobDynamicPolyZone) do
    if v.enable == true then
        local jobZone = CircleZone:Create(v.coords, v.distance, {
            name = v.name,
            debugPoly = v.debug, 
        })

        jobZone:onPlayerInOut(function(isPointInside, point)
            if isPointInside then
                currentJobZone = jobZone.name
				startWorkDynamic = true
				StartHuntingSession()
                --print('In '..currentJobZone)
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						event = 'GoInButcherZone',
						content = ('ผู้เล่นได้ทำการเข้าเขตล่าสัตว์ %s'):format(jobZone.name),
					})
				end) -- End log 
            else
                currentJobZone = nil
				ongoingAutofarmDynamic = false
				DeleteObject()
				startWorkDynamic = false
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						event = 'GoOutButcherZone',
						content = ('ผู้เล่นได้ทำการออกจากเขตล่าสัตว์ %s'):format(jobZone.name),
					})
				end) -- End log 
            end
        end)
    end
end

function StartHuntingSession()
	Citizen.CreateThread(function()
		while startWorkDynamic do
			Citizen.Wait(0)
			if not startWorkDynamic then DeleteObject() return end
			local coords = GetEntityCoords(PlayerPedId())
			if next(AnimalsInSession) == nil and not spawnProp then
				spawnProp = true
				respawnProp()				
			end
			for _,v in pairs(Config.JobDynamicInfoClient) do
				if currentJobZone == v.polyname then
					DrawMarker(21, v.autoMarkerPos.x, v.autoMarkerPos.y, v.autoMarkerPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 204, 204, 100, false, true, 2, false, false, false, false)
					if (GetDistanceBetweenCoords(coords, v.autoMarkerPos.x, v.autoMarkerPos.y, v.autoMarkerPos.z, false) < 1) and not IsPedInAnyVehicle(PlayerPedId(), false) then
						if helpNotify then
							exports.helpnotify:showHelpNotification("กด","E","เพื่อเริ่มเก็บอัตโนมัติ")
							helpNotify = false
						end
						if IsControlJustReleased(0, 38) then
							ongoingAutofarmDynamic = true
							autoFarm()
							pcall(function() -- Start log
								exports['azael_dc-serverlogs']:insertData({
									event = 'AutoFarmButcheringAnimal',
									content = ('ผู้เล่นได้ทำการกด E เพื่อทำการแล่เนื้อแบบ Auto Farm'):format(),
								})
							end) -- End log 
							onAutoFarm()
						end
					end
					if (GetDistanceBetweenCoords(coords, v.autoMarkerPos.x, v.autoMarkerPos.y, v.autoMarkerPos.z, false) > 1) and not IsPedInAnyVehicle(PlayerPedId(), false) then
						if not helpNotify then
							exports.helpnotify:hideHelpNotification()
							helpNotify = true
						end
					end
				end
			end
			if OnGoingHuntSession then
				for index ,v in ipairs(AnimalsInSession) do
					if not startWorkDynamic then return end
					if DoesEntityExist(v.id) then
						local AnimalCoords = GetEntityCoords(v.id)
						local PlyCoords = GetEntityCoords(PlayerPedId())
						local PlyToAnimal = GetDistanceBetweenCoords(PlyCoords, AnimalCoords, true)
						if not Isworking then
							if PlyToAnimal < 1.5 then
								if ongoingAutofarmDynamic then
									Isworking = true
									onPickingUp()
									SetEntityHealth(v.id, 0)
									table.remove(AnimalsInSession, index)	
									PickedUp(v.id)
								end
								if IsControlJustReleased(0,38) and IsPedOnFoot(PlayerPedId()) then
									if DoesEntityExist(v.id) then
										Isworking = true
										onPickingUp()
										SetEntityHealth(v.id, 0)
										table.remove(AnimalsInSession, index)	
										PickedUp(v.id)
										pcall(function() -- Start log
											exports['azael_dc-serverlogs']:insertData({
												event = 'ButcheringAnimal',
												content = ('ผู้เล่นได้ทำการกด E เพื่อทำการแล่เนื้อ'):format(),
											})
										end) -- End log 
									end
								end
							end
						end
					end
				end
			end
		end
	end)
end

function autoFarm()
	local closestDistance = math.huge -- Start with a very large value
	local closestObject = nil
	local coords = GetEntityCoords(PlayerPedId())
	for i=1, #AnimalsInSession do
		local distance = GetDistanceBetweenCoords(coords, GetEntityCoords(AnimalsInSession[i].id), false)
		if distance < closestDistance then
			closestDistance = distance
			closestObject = AnimalsInSession[i].id
		end
	end
	TaskGotoEntityAiming(PlayerPedId(), closestObject, 0.1, 150.0)
	SetPedKeepTask(
			PlayerPedId() --[[ Ped ]],
			true --[[ boolean ]]
	)
end

function respawnProp()
	--print("In respawnProp")
	for _,v in pairs(Config.JobDynamicInfoClient) do
		if v.polyname == currentJobZone then
			propAnimal = v.objectName
			--print(propAnimal)
			--print("in if check poly "..v.polyname.." "..currentJobZone)
			for _,v in pairs(v.spawnPropPos) do
				if not startWorkDynamic then return end
				--print("In for spawn")
				local Ped = PlayerPedId()
				local Animal = CreatePed(4, GetHashKey(propAnimal), v.x, v.y, v.z, 0.0, false, false)
				TaskWanderStandard(Animal , 10.0 , 10)
				--TaskSmartFleePed(Animal, Ped, 12000.0, -1, false, false)
				table.insert(AnimalsInSession, {id = Animal, x = v.x, y = v.y, z = v.z})
				Wait(500)
			end
		end
	end
	OnGoingHuntSession = true
	spawnProp = false
end

function DeleteObject()
	for _, v in pairs(AnimalsInSession) do
		if DoesEntityExist(v.id) then
			DeleteEntity(v.id)
		end
	end
	startWorkDynamic = false
	OnGoingHuntSession = false
	spawnProp = false
	AnimalsInSession = {}
end

function MakeEntityFaceCoord(entity1, nearbyObject)
	local Coord = GetEntityCoords(nearbyObject)
	local p1 = GetEntityCoords(entity1, true)
	local p2 = Coord
	local dx = p2.x - p1.x
	local dy = p2.y - p1.y
	local heading = GetHeadingFromVector_2d(dx, dy)
	SetEntityHeading( entity1, heading )
end

function PickedUp(animalSessionID)
	MakeEntityFaceCoord(PlayerPedId(), animalSessionID)
	for _,v in pairs(Config.JobDynamicInfoClient) do
		if v.polyname == currentJobZone then
			local pickTime = v.pickTime
			if ongoingAutofarmDynamic then
				pickTime = v.pickTime + 2000
			end
			ESX.TriggerServerCallback('cc_pick_dynamicprop:checkCard', function(calculatePicktime)
				--print(calculatePicktime)
				TriggerEvent("mythic_progbar:client:progress",{
					name = "PickedUp",
					duration = calculatePicktime,
					label = "เชือด",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = v.animDict, -- ท่าทางเวลาขุด
						anim = v.anim,		-- ท่าทางเวลาขุด
						flags = v.flags,
					},
				}, function(status)
					if not status then
						DeleteEntity(animalSessionID)
						Isworking = false
						TriggerServerEvent('giveDynamicItem', currentJobZone)
						exports.helpnotify:hideHelpNotification()
						if ongoingAutofarmDynamic then
							exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
							autoFarm()
						end
					end
					if status then
						DeleteEntity(animalSessionID)
						Isworking = false
						exports.helpnotify:hideHelpNotification()
					end
				end)
			end, currentJobZone, pickTime)
		end
	end
end

function onPickingUp()
    exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
    Citizen.CreateThread(function()
        while Isworking do
            Citizen.Wait(0)
            if Isworking then
                DisableControlAction(0,Config.Key['G'], true)
				DisableControlAction(0, Config.Key['T'], false)
				DisableControlAction(0, Config.Key['E'], true)
				EnableControlAction(0, Config.Key['X'], true)
				DisableControlAction(0, Config.Key['DELETE'], true)
				DisableControlAction(0, Config.Key['F2'], true)
            end

            if IsControlJustPressed(0,73) and Isworking then
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						event = 'CancelButcheringAnimal',
						content = ('ผู้เล่นได้ทำการกด X เพื่อยกเลิกการแล่เนื้อ'):format(),
					})
				end) -- End log
                exports.helpnotify:hideHelpNotification()
                TriggerEvent("mythic_progbar:client:cancel")
                Isworking = false
				-- SetPedKeepTask(
				-- 	PlayerPedId() --[[ Ped ]],
				-- 	false --[[ boolean ]]
				-- ) 
            end
        end
    end)
end

function onAutoFarm()
    exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
    Citizen.CreateThread(function()
        while ongoingAutofarmDynamic do
            Citizen.Wait(0)
            if IsControlJustPressed(0,73) and ongoingAutofarmDynamic then
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						event = 'CancelAutoFarmButcheringAnimal',
						content = ('ผู้เล่นได้ทำการกด X เพื่อยกเลิกการแล่เนื้อแบบ Auto Farm'):format(),
					})
				end) -- End log 
                exports.helpnotify:hideHelpNotification()
				ClearPedTasks(PlayerPedId())
				SetPedKeepTask(
						PlayerPedId() --[[ Ped ]],
						false --[[ boolean ]]
				)
                ongoingAutofarmDynamic = false
            end
        end
    end)
end

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler('esx:onPlayerDeath', function() 
	if startWorkDynamic then
		Isworking = false
		helpNotify = true
		ongoingAutofarmDynamic = false
		TriggerEvent("mythic_progbar:client:cancel")
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for _, v in pairs(AnimalsInSession) do
			if DoesEntityExist(v.id) then
				DeleteEntity(v.id)
			end
		end
	end
end)

RegisterNetEvent('brokenItemLoseHealthDynamic')
AddEventHandler('brokenItemLoseHealthDynamic', function ()
	local DamageBroken = math.random(1, 3)
	local currentPed = PlayerPedId()
	local currentHeal = GetEntityHealth(currentPed)
	local maxHealth = currentHeal-DamageBroken
	print(currentHeal)
	print(maxHealth)
	SetEntityHealth(currentPed,maxHealth)
end)





