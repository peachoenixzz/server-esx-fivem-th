ESX = nil
local currentdrugZone = nil
local Objects 			= 0
local ObjectLists 		= {}
local IsPickingUp		= false
local startWork = false
local helpNotify = true
local ongoingDelObj = false
nearbyObject, nearbyID = nil,nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end 

	Citizen.Wait(1000)

    ESX.TriggerServerCallback('cc_pick_drug:checkZoneDrug', function(circleDrugZones)
        callbackdrugZone(circleDrugZones)
		print("call back poly zone")
    end)

	ESX.TriggerServerCallback('cc_pick_drug:checkSpawnDrug', function(circleDrugZones)
        circleSpawnZones = circleDrugZones,
		print("call back spawn pos")
    end)

end)


function callbackdrugZone(zone)
	for _,v in pairs(zone) do
		--print(v.name)
		if v.enable == true then
			local drugZone = CircleZone:Create(v.coords, v.distance, {
				name = v.name,
				debugPoly = v.debug, 
			})

			drugZone:onPlayerInOut(function(isPointInside, point)
				if isPointInside then
					if not ongoingDelObj then
						currentdrugZone = drugZone.name
						startWork = true
						pcall(function() -- Start log 
							exports['azael_dc-serverlogs']:insertData({
								event = 'StartIllegalJob',
								content = ('ผู้เล่นเข้าเขตการทำงานดำ'):format(),
							})
						end) -- End log
						startjobWork()
						print('In '..currentdrugZone)
					end
				else
					starkWork = false
					IsPickingUp = false
					currentdrugZone = nil
					pcall(function() -- Start log
						exports['azael_dc-serverlogs']:insertData({
							event = 'StopIllegalJob',
							content = ('ผู้เล่นออกจากเขตการทำงานดำ'):format(),
						})
					end) -- End log
					DeleteObject()
				end
			end)
		end
	end
end

function startjobWork()
	if startWork then
		Citizen.CreateThread(function()
			while startWork do
				Citizen.Wait(0)
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
								event = 'DoingPickUpIllegalItem',
								content = ('ผู้เล่นได้ทำการกด E เพื่อเริ่มเก็บของงานดำ'):format(),
							})
						end) -- End log
					end
				end
			end
			return
		end)
	end
end

function SpawnObjects()
	for _,v in pairs(circleSpawnZones) do
		if v.polyname == currentdrugZone then
			--print(v.polyname..'SpawnObjFunc')
			while #ObjectLists < v.objectCount and not ongoingDelObj do
				local ObjectCoords = GenerateObjectCoords(v.spawnPropPos, v.spawnPropDistance)

				ESX.Game.SpawnLocalObject(v.objectName, vector3(ObjectCoords.x, ObjectCoords.y, v.spawnPropPos.z), function(object)
					if v.placeOnjectOnGround then
						PlaceObjectOnGroundProperly(object)
					end
					FreezeEntityPosition(object, true)
					table.insert(ObjectLists, object)
				end)
					if not startWork then
					for k, v in pairs(ObjectLists) do
						ESX.Game.DeleteObject(v)
					end
					break
				end 
			end
		end
	end
end

function GenerateObjectCoords(spawnPropPos, spawnPropDistance) 
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
	startWork = false
	ongoingDelObj = true
	for k, v in pairs(ObjectLists) do
		ESX.Game.DeleteObject(v)
	end
	ObjectLists = {}
	Citizen.Wait(2000)
	ongoingDelObj = false
end

function checkNearbyObject()
	for _,v in pairs(Config.DrugInfoClient) do
        if v.polyname == currentdrugZone then
			Citizen.CreateThread(function()
					Citizen.Wait(500)
					local coords = GetEntityCoords(PlayerPedId())
					if nearbyObject == nil and nearbyID == nil then
						for i=1, #ObjectLists, 1 do
							if GetDistanceBetweenCoords(coords, GetEntityCoords(ObjectLists[i]), false) < v.pickDistance and not IsPedInAnyVehicle(PlayerPedId(), false) then
								exports.helpnotify:showHelpNotification("กด","E","เพื่อเก็บ")
								nearbyObject, nearbyID = ObjectLists[i], i
								return
							end
						end
					end

				if nearbyObject ~= nil and nearbyID ~= nil then
					if GetDistanceBetweenCoords(coords, GetEntityCoords(ObjectLists[nearbyID]), false) > v.pickDistance then
						exports.helpnotify:hideHelpNotification()
						nearbyObject, nearbyID =nil, nil
						return
					end
				end
				return
			end)
		end
	end
end

function PickedUp(nearbyID,nearbyObject)


	for _,v in pairs(Config.DrugInfoClient) do
		if v.polyname == currentdrugZone then
			TriggerEvent("mythic_progbar:client:progress",{
				name = "PickedUp",
				duration = v.pickTime,
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
					ESX.Game.DeleteObject(nearbyObject)
					table.remove(ObjectLists, nearbyID)
					IsPickingUp = false
					exports.helpnotify:hideHelpNotification()
					TriggerServerEvent('giveDrugItem', currentdrugZone)
				end
			end)
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
                IsPickingUp = false
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						event = 'CancelPickUpIllegalItem',
						content = ('ผู้เล่นได้ทำการกด X เพื่อยกเลิกการเก็บงานดำ'):format(),
					})
				end) -- End log
            end
        end
    end)
end

------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler('esx:onPlayerDeath', function() 
	if startWork then
		IsPickingUp = false
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





