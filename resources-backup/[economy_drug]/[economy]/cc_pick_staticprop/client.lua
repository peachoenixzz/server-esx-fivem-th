ESX = nil
local currentJobZone = nil
local Objects 			= 0
local ObjectLists 		= {}
local IsPickingUp		= false
local startWorkStatic = false
local helpNotify = true
local ongoingDelObj = false
local ongoingAutofarmStatic = false
nearbyObject, nearbyID = nil,nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function checkInStatic()
    return startWorkStatic
end


for _,v in pairs(Config.JobPolyZone) do
    print(v.name)
    if v.enable == true then
        local jobZone = CircleZone:Create(v.coords, v.distance, {
            name = v.name,
            debugPoly = v.debug, 
        })

        jobZone:onPlayerInOut(function(isPointInside, point)
            if isPointInside then
                if not ongoingDelObj then
                    currentJobZone = jobZone.name
                    startWorkStatic = true
                    startjobWork()
                    --print('In '..currentJobZone)
					pcall(function() -- Start log
						exports['azael_dc-serverlogs']:insertData({
							event = 'GoInWorkZone',
							content = ('ผู้เล่นได้ทำการเข้าเขตทำงาน %s'):format(jobZone.name),
						})
					end) -- End log 
                end
            else
                starkWork = false
				IsPickingUp = false
                currentJobZone = nil
				ongoingAutofarmStatic = false
                DeleteObject()
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						event = 'GoOutWorkZone',
						content = ('ผู้เล่นได้ทำการออกจากเขตทำงาน %s'):format(jobZone.name),
					})
				end) -- End log 
            end
        end)
    end
end

function startjobWork()
	if startWorkStatic then
		Citizen.CreateThread(function()
			while startWorkStatic do
				Citizen.Wait(0)
				local coords = GetEntityCoords(PlayerPedId())
				if #ObjectLists < 4 then
					SpawnObjects()
				end
				checkNearbyObject()
				if nearbyObject and IsPedOnFoot(PlayerPedId()) then
					if IsControlJustReleased(0, 38) and not IsPickingUp then
						IsPickingUp = true
						PickedUp(nearbyID,nearbyObject)
						onPickingUp()
						pcall(function() -- Start log
							exports['azael_dc-serverlogs']:insertData({
								event = 'PickingUpWorkItem',
								content = ('ผู้เล่นได้ทำการกด E เพื่อเก็บของงานขาว'):format(),
							})
						end) -- End log 
					end
				end
				for _,v in pairs(Config.JobInfoClient) do
					--print(v.polyname)
					if currentJobZone == v.polyname then
						if v.enableautoFarm == true then
							DrawMarker(21, v.autoMarkerPos.x, v.autoMarkerPos.y, v.autoMarkerPos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 204, 0, 100, false, true, 2, false, false, false, false)
							if (GetDistanceBetweenCoords(coords, v.autoMarkerPos.x, v.autoMarkerPos.y, v.autoMarkerPos.z, false) < 1) and not IsPedInAnyVehicle(PlayerPedId(), false) then
								if helpNotify then
									exports.helpnotify:showHelpNotification("กด","E","เพื่อเริ่มเก็บอัตโนมัติ")
									helpNotify = false
								end
								if IsControlJustReleased(0, 38) then
									ongoingAutofarmStatic = true
									autoFarm()
									onAutoFarm()
									pcall(function() -- Start log
										exports['azael_dc-serverlogs']:insertData({
											event = 'AutoFarmPickingUpWorkItem',
											content = ('ผู้เล่นได้ทำการกด E เพื่อเก็บของงานขาว แบบ Auto Farm'):format(),
										})
									end) -- End log 
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
				end
			end
			return
		end)
	end
end

function autoFarm()
	--TaskGoToEntity(
	--		entity --[[ Entity ]],
	--		target --[[ Entity ]],
	--		duration --[[ integer ]],
	--		distance --[[ number ]],
	--		speed --[[ number ]],
	--		p5 --[[ number ]],
	--		p6 --[[ integer ]]
	--)
	--IsTaskMoveNetworkActive return task boolean
	--print("is here")
	local closestDistance = math.huge -- Start with a very large value
	local closestObject = nil
	local coords = GetEntityCoords(PlayerPedId())
	for i=1, #ObjectLists do
		local distance = GetDistanceBetweenCoords(coords, GetEntityCoords(ObjectLists[i]), false)
		if distance < closestDistance then
			closestDistance = distance
			closestObject = ObjectLists[i]
		end
	end
	TaskGotoEntityAiming(PlayerPedId(), closestObject, 0.1, 150.0)
	SetPedKeepTask(
			PlayerPedId() --[[ Ped ]],
			true --[[ boolean ]]
	)
end

function SpawnObjects()
    for _,v in pairs(Config.JobInfoClient) do
        if v.polyname == currentJobZone then
            --print(v.polyname..'SpawnObjFunc')
            while #ObjectLists < v.objectCount and not ongoingDelObj do
                local ObjectCoords = GenerateObjectCoords(v.spawnPropPos, v.spawnPropDistance)

                ESX.Game.SpawnLocalObject(v.objectName, vector3(ObjectCoords.x, ObjectCoords.y, v.spawnPropPos.z), function(object)
					if v.placeOnjectOnGround then
                    	PlaceObjectOnGroundProperly(object)
					end
					local entityheading = math.random(0, 360)
					SetEntityHeading(object, entityheading+0.1) -- +0.1 ไว้ลักไก่ให้เป็นทศนิยมขกเขียนสูตรคำนวณ เพราะ ถ้าไม่เป็นทศนิยมมันจะไม่เซ็ต heading
                    FreezeEntityPosition(object, true)
                    table.insert(ObjectLists, object)
                end)
                if not startWorkStatic then
                    for k, v in pairs(ObjectLists) do
                        ESX.Game.DeleteObject(v)
                    end
                    break
                end 
            end
        end
    end
end

function GenerateObjectCoords(spawnPropPos, spawnPropDistance) --
	while true do
		Citizen.Wait(1)

		local crabCoordX, crabCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-spawnPropDistance, spawnPropDistance)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-spawnPropDistance, spawnPropDistance)

		crabCoordX = spawnPropPos.x + modX
		crabCoordY = spawnPropPos.y + modY

		local coordZ = GetCoordZ(crabCoordX, crabCoordY)
		local coord = vector3(crabCoordX, crabCoordY, coordZ)

		if ValidateObjectCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y) -- COORDZ ไม่ได้ใช้วางแบบ flat เอา
	local groundCheckHeights = Config.CoordZ

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 35.0
end

function ValidateObjectCoord(plantCoord)
	if #ObjectLists > 0 then
		local validate = true

		for k, v in pairs(ObjectLists) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		-- if GetDistanceBetweenCoords(plantCoord, Config.Zone.Pos.x, Config.Zone.Pos.y, Config.Zone.Pos.z, false) > 50 then
		-- 	validate = false
		-- end

		return validate
	else
		return true
	end
end

function DeleteObject()
	startWorkStatic = false
	ongoingDelObj = true
	for k, v in pairs(ObjectLists) do
		ESX.Game.DeleteObject(v)
	end
	ObjectLists = {}
	Citizen.Wait(2000)
	ongoingDelObj = false
end

function checkNearbyObject()
	for _,v in pairs(Config.JobInfoClient) do
        if v.polyname == currentJobZone then
			Citizen.CreateThread(function()
					Citizen.Wait(500)
					local coords = GetEntityCoords(PlayerPedId())
					if nearbyObject == nil and nearbyID == nil then
						for i=1, #ObjectLists, 1 do
							if GetDistanceBetweenCoords(coords, GetEntityCoords(ObjectLists[i]), false) < v.pickDistance and not IsPedInAnyVehicle(PlayerPedId(), false) then
								nearbyObject, nearbyID = ObjectLists[i], i
								if not ongoingAutofarmStatic then
									exports.helpnotify:showHelpNotification("กด","E","เพื่อเก็บ")
								end
								if ongoingAutofarmStatic then
									IsPickingUp = true
									PickedUp(nearbyID,nearbyObject)
									onPickingUp()
								end
								return
							end
						end
					end

				if nearbyObject ~= nil and nearbyID ~= nil then
					if GetDistanceBetweenCoords(coords, GetEntityCoords(ObjectLists[nearbyID]), false) > v.pickDistance then
						if not ongoingAutofarmStatic then
							exports.helpnotify:hideHelpNotification()
						end
						nearbyObject, nearbyID = nil, nil
						return
					end
				end
				return
			end)
		end
	end
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

function PickedUp(nearbyID,nearbyObject)
	MakeEntityFaceCoord(PlayerPedId(), nearbyObject)
	for _,v in pairs(Config.JobInfoClient) do
		if v.polyname == currentJobZone then
			local pickTime = v.pickTime
			if ongoingAutofarmStatic then
				pickTime = v.pickTime + 1000
			end
			ESX.TriggerServerCallback('cc_pick_staticprop:checkCard', function(calculatePicktime)
				--print(calculatePicktime)
				TriggerEvent("mythic_progbar:client:progress",{
					name = "PickedUp",
					duration = calculatePicktime,
					label = "กำลังเก็บงานอีโคและขาวจ้า",
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
						local dict = "core"
						local particleName = "ent_dst_dust"

						RequestNamedPtfxAsset(dict)
						while not HasNamedPtfxAssetLoaded(dict) do
							Citizen.Wait(0)
						end

						local coords = GetEntityCoords(ObjectLists[nearbyID])
						UseParticleFxAssetNextCall(dict)
						StartParticleFxNonLoopedAtCoord(particleName, coords.x, coords.y, coords.z + 1.0, 0.0, 0.0, 0.0, 0.2, false, false, false)
						ESX.Game.DeleteObject(nearbyObject)
						table.remove(ObjectLists, nearbyID)
						IsPickingUp = false
						exports.helpnotify:hideHelpNotification()
						TriggerServerEvent('giveStaticItem', currentJobZone)
						if ongoingAutofarmStatic then
							exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
							autoFarm()
						end
					end
				end)
			end, currentJobZone, pickTime)
		end
	end
end

function onPickingUp()
    exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
    Citizen.CreateThread(function()
        while IsPickingUp do
            Citizen.Wait(0)
            if IsPickingUp then
                DisableControlAction(0,Config.Key['G'], true)
				DisableControlAction(0, Config.Key['T'], false)
				DisableControlAction(0, Config.Key['E'], true)
				EnableControlAction(0, Config.Key['X'], true)
				DisableControlAction(0, Config.Key['DELETE'], true)
				DisableControlAction(0, Config.Key['F2'], true)
            end

            if IsControlJustPressed(0,73) and IsPickingUp then
                exports.helpnotify:hideHelpNotification()
                TriggerEvent("mythic_progbar:client:cancel")
				-- SetPedKeepTask(
				-- 		PlayerPedId() --[[ Ped ]],
				-- 		false --[[ boolean ]]
				-- )
                IsPickingUp = false
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						event = 'CancelPickingUpWorkItem',
						content = ('ผู้เล่นได้ทำการกด X เพื่อยกเลิกการเก็บของงานขาว'):format(),
					})
				end) -- End log 
            end
        end
    end)
end

function onAutoFarm()
    exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
    Citizen.CreateThread(function()
        while ongoingAutofarmStatic do
            Citizen.Wait(0)
            if IsControlJustPressed(0,73) and ongoingAutofarmStatic then
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						event = 'CancelAutoFarmPickingUpWorkItem',
						content = ('ผู้เล่นได้ทำการกด X เพื่อยกเลิกการเก็บของงานขาว แบบ Auto Farm'):format(),
					})
				end) -- End log 
                exports.helpnotify:hideHelpNotification()
				ClearPedTasks(PlayerPedId())
				SetPedKeepTask(
						PlayerPedId() --[[ Ped ]],
						false --[[ boolean ]]
				)
                ongoingAutofarmStatic = false
            end
        end
    end)
end


------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler('esx:onPlayerDeath', function() 
	if startWorkStatic then
		IsPickingUp = false
		ongoingAutofarmStatic = false
		helpNotify = true
		TriggerEvent("mythic_progbar:client:cancel")
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(ObjectLists) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

RegisterNetEvent('brokenItemLoseHealth')
AddEventHandler('brokenItemLoseHealth', function ()
	local DamageBroken = math.random(1, 3)
	local currentPed = PlayerPedId()
	local currentHeal = GetEntityHealth(currentPed)
	local maxHealth = currentHeal-DamageBroken
	print(currentHeal)
	print(maxHealth)
	SetEntityHealth(currentPed,maxHealth)
end)



