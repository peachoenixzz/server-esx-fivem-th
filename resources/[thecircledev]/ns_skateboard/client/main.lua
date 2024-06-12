local RCCar = {}
local player = GetPlayerPed(-1)

local Attached = false
local useSkateboard = false
local SkateboardModel = nil
local prop = nil
local IsDead = false
local InVehicle = false

local ControlUp = 32
local ControlDown = 33
local ControlLeft = 34
local ControlRight = 35

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if DoesEntityExist(RCCar.Entity) then
			DetachEntity(RCCar.Entity)
	
			DeleteEntity(RCCar.Skate)
			DeleteVehicle(RCCar.Entity)
			DeleteEntity(RCCar.Driver)
			Attached = false
			RCCar.UnloadModels()
		end

		if useSkateboard then
			useSkateboard = false 
			if DoesEntityExist(prop) then
				DeleteObject(prop) 
			end
		end
	end
end)

RegisterNetEvent('meow_skateboard')
AddEventHandler('meow_skateboard', function (skateboard)
	SkateboardModel = skateboard

	if DoesEntityExist(RCCar.Entity) then
		DetachEntity(RCCar.Entity)
		DeleteEntity(RCCar.Skate)
		DeleteVehicle(RCCar.Entity)
		DeleteEntity(RCCar.Driver)
		Attached = false
		RCCar.UnloadModels()
	end
	
	RCCar.SpawnHold()
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count)
	if item.name == 'skateboard' then
		if useSkateboard then
			useSkateboard = false 
			if DoesEntityExist(prop) then
				DeleteObject(prop) 
			end
		end

		if DoesEntityExist(RCCar.Entity) then
				
			Citizen.Wait(900)

			DetachEntity(RCCar.Entity)
	
			DeleteEntity(RCCar.Skate)
			DeleteVehicle(RCCar.Entity)
			DeleteEntity(RCCar.Driver)
			Attached = false
			RCCar.UnloadModels()
		end
	end
end)

RegisterNetEvent('longboard:start')
AddEventHandler('longboard:start', function()
	RCCar.Start()
end)

AddEventHandler('longboard:clear', function()
	DeleteEntity(RCCar.Skate)
	DeleteVehicle(RCCar.Entity)
	DeleteEntity(RCCar.Driver)
    RCCar.UnloadModels()
    Attached = false
end)

AddEventHandler('longboard:spawn', function()
    RCCar.Start()
end)

RegisterCommand('cskb', function()
    DetachEntity(RCCar.Entity)

	DeleteEntity(RCCar.Skate)
	DeleteVehicle(RCCar.Entity)
	DeleteEntity(RCCar.Driver)
	RCCar.UnloadModels()
	Attached = false

	if useSkateboard then
		useSkateboard = false 
		if DoesEntityExist(prop) then
			DeleteObject(prop) 
		end
	end
end)

AddEventHandler('esx:onPlayerDeath', function()
    IsDead = true
	DetachEntity(RCCar.Entity)

	DeleteEntity(RCCar.Skate)
	DeleteVehicle(RCCar.Entity)
	DeleteEntity(RCCar.Driver)
	RCCar.UnloadModels()
	Attached = false

	if useSkateboard then
		useSkateboard = false 
		if DoesEntityExist(prop) then
			DeleteObject(prop) 
		end
	end

end)

Citizen.CreateThread(function()
	while (true) do
		IsDead = IsPedDeadOrDying(PlayerPedId())
		InVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
		Citizen.Wait(3000)
		if InVehicle or IsDead or exports.cc_pick_staticprop:checkInStatic() then --or exports.cc_pick_dynamicprop:checkInDynamic()
				if useSkateboard then
					useSkateboard = false 
					if DoesEntityExist(prop) then
						DeleteObject(prop) 
					end
				end
				DetachEntity(RCCar.Entity)
			
				DeleteEntity(RCCar.Skate)
				DeleteVehicle(RCCar.Entity)
				DeleteEntity(RCCar.Driver)
				RCCar.UnloadModels()
				Attached = false
		end
	end
end)

RCCar.SpawnHold = function()
	local location = { a = 0.07, b = 0.0, c = 0.08, d = -3.0, e = -86.0, f = -7.0,}
	if not useSkateboard then 
		useSkateboard = true
		local ped = GetPlayerPed(-1) 
		local position = GetEntityCoords(GetPlayerPed(PlayerId()), false) 
		local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey(SkateboardModel), false, false, false) 
		if object ~= 0 then DeleteObject(object) end 
		local x,y,z = table.unpack(GetEntityCoords(ped)) 
		prop = CreateObject(GetHashKey(SkateboardModel), x, y, z + 0.2, true, true, true) 
		local boneIndex = GetPedBoneIndex(ped, 57005) 
		AttachEntityToEntity(prop, ped, boneIndex, location.a, location.b, location.c, location.d, location.e, location.f, true, true, false, true, 1, true) 
		while DoesEntityExist(prop) and useSkateboard do
			Citizen.Wait(5)
			RCCar.ReadyKeys()
		end
	else 
		local ped = GetPlayerPed(-1) 
		ClearPedTasks(ped) 
		useSkateboard = false 
		DeleteObject(prop) 
	end
end

RCCar.Start = function()
	player = GetPlayerPed(-1)
	if DoesEntityExist(RCCar.Entity) then return end

	RCCar.Spawn()

	while DoesEntityExist(RCCar.Entity) and DoesEntityExist(RCCar.Driver) do
		Citizen.Wait(0)

		local distanceCheck = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),  GetEntityCoords(RCCar.Entity), true)

		RCCar.DrawInstructions(distanceCheck)
		RCCar.HandleKeys(distanceCheck)

		if distanceCheck <= Config.LoseConnectionDistance then
			if not NetworkHasControlOfEntity(RCCar.Driver) then
				NetworkRequestControlOfEntity(RCCar.Driver)
			elseif not NetworkHasControlOfEntity(RCCar.Entity) then
				NetworkRequestControlOfEntity(RCCar.Entity)
			end
		else
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 6, 2500)
			if DoesEntityExist(RCCar.Entity) then
					
				Citizen.Wait(900)
	
				DetachEntity(RCCar.Entity)
		
				DeleteEntity(RCCar.Skate)
				DeleteVehicle(RCCar.Entity)
				DeleteEntity(RCCar.Driver)
				RCCar.UnloadModels()
			end
		end
	end
end

RCCar.ReadyKeys = function()
	if useSkateboard then
		if IsControlJustReleased(0, 47) then
			RCCar.SpawnHold()
			Citizen.Wait(500)
			RCCar.Start()
		end
	end
end

RCCar.HandleKeys = function(distanceCheck)
	if distanceCheck <= 1.5 then
		if IsControlJustPressed(0, 38) then
			RCCar.Attach("pick")
		end

		if IsControlJustReleased(0, 47) then
			if Attached then
				RCCar.AttachPlayer(false)
			else
				RCCar.AttachPlayer(true)
			end
		end
	end

	if Attached then
		local x = GetEntityRotation(RCCar.Entity).x
		local y = GetEntityRotation(RCCar.Entity).y

		if (-40.0 < x and x > 40.0) or (-40.0 < y and y > 40.0) or (HasEntityCollidedWithAnything(RCCar.Entity) and GetEntitySpeed(RCCar.Entity) > 2.6) then
			RCCar.AttachPlayer(false)
			SetPedToRagdoll(player, 4000, 4000, 0, true, true, false)
		end	
	end           
	
	if distanceCheck < Config.LoseConnectionDistance then
		if IsControlPressed(0, ControlUp) and not IsControlPressed(0, ControlDown) and Attached then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 9, 1)
		end

		-- Jump
		if IsControlPressed(0, 22) and Attached then
			local vel = GetEntityVelocity(RCCar.Entity)
			if not IsEntityInAir(RCCar.Entity) then
				SetEntityVelocity(RCCar.Entity, vel.x, vel.y, vel.z + 5.0)
				Citizen.Wait(500)
			end
			
		end

		if Attached then
		
			if IsControlJustReleased(0, ControlUp) or IsControlJustReleased(0, ControlDown) then
				TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 6, 2500)
			end

			if IsControlPressed(0, ControlDown) and not IsControlPressed(0, ControlUp) then
				TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 22, 1)
			end

			if IsControlPressed(0, ControlLeft) and IsControlPressed(0, ControlDown) then
				TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 13, 1)
			end

			if IsControlPressed(0, ControlRight) and IsControlPressed(0, ControlDown) then
				TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 14, 1)
			end

			if IsControlPressed(0, ControlUp) and IsControlPressed(0, ControlDown) then
				TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 30, 100)
			end

			if IsControlPressed(0, ControlLeft) and IsControlPressed(0, ControlUp) then
				TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 7, 1)
			end

			if IsControlPressed(0, ControlRight) and IsControlPressed(0, ControlUp) then
				TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 8, 1)
			end

			if IsControlPressed(0, ControlLeft) and not IsControlPressed(0, ControlUp) and not IsControlPressed(0, ControlDown) then
				TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 4, 1)
			end

			if IsControlPressed(0, ControlRight) and not IsControlPressed(0, ControlUp) and not IsControlPressed(0, ControlDown) then
				TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 5, 1)
			end
		else
			SetVehicleHandbrake(RCCar.Entity, true)
		end
		
	end
end


RCCar.DrawInstructions = function(distanceCheck)
	if distanceCheck <= Config.LoseConnectionDistance then
		if distanceCheck <= 1.5 then
			if not Attached then
				Draw3DText(GetEntityCoords(RCCar.Entity).x, GetEntityCoords(RCCar.Entity).y, GetEntityCoords(RCCar.Entity).z,0.5,"กด ~y~[E]~w~ เพื่อเก็บ /  กด ~y~[G]~w~ เพื่อขึ้น")
			end
		end
	end
end

local fontId
Citizen.CreateThread(function()
    RegisterFontFile('font4thai') -- the name of your .gfx, without .gfx
    fontId = RegisterFontId('font4thai') -- the name from the .xml
end)

function Draw3DText(x, y, z, scl_factor, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local p = GetGameplayCamCoords()
	local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	local scale = (1 / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov * scl_factor
	if onScreen then
		SetTextScale(0.0, scale)
		SetTextFont(fontId)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x, _y)
	end
end

RCCar.Spawn = function()
	RCCar.LoadModels({ GetHashKey("bmx"), 68070371, GetHashKey(SkateboardModel), "pickup_object", "move_strafe@stealth"})

	local spawnCoords, spawnHeading = GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(PlayerPedId()) * 2.0, GetEntityHeading(PlayerPedId())

	RCCar.Entity = CreateVehicle(GetHashKey("bmx"), spawnCoords, spawnHeading, true)
	RCCar.Skate = CreateObject(GetHashKey(SkateboardModel), 0.0, 0.0, 0.0, true, true, true)
	
	while not DoesEntityExist(RCCar.Entity) do
		Citizen.Wait(5)
	end

	while not DoesEntityExist(RCCar.Skate) do
		Citizen.Wait(5)
	end


	SetEntityNoCollisionEntity(RCCar.Entity, player, false)
	SetEntityVisible(RCCar.Entity, false)
	SetAllVehiclesSpawn(RCCar.Entity, true, true, true, true)
	-- AttachEntityToEntity(RCCar.Skate, RCCar.Entity, GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, -0.15, 0.0, 0.0, 90.0, true, true, true, true, 1, true)	
	AttachEntityToEntity(RCCar.Skate, RCCar.Entity, GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, -0.40, 0.0, 90.0, 0.0, true, true, true, true, 1, true)
	SetEntityCollision(RCCar.Skate, true, true)

	RCCar.Driver = CreatePed(5, 68070371, spawnCoords, spawnHeading, true)
	SetModelAsNoLongerNeeded(68070371)
	SetEntityCanBeDamaged(RCCar.Driver, false)
	SetPedAsEnemy(RCCar.Driver, false)
	SetBlockingOfNonTemporaryEvents(RCCar.Driver, true)
	SetPedResetFlag(RCCar.Driver, 249, 1)
	SetPedConfigFlag(RCCar.Driver, 185, true)
	SetPedConfigFlag(RCCar.Driver, 108, true)
	SetPedCanEvasiveDive(RCCar.Driver, 0)
	SetPedCanRagdollFromPlayerImpact(RCCar.Driver, 0)
	SetPedConfigFlag(RCCar.Driver, 208, true)
	SetPedCanRagdoll(RCCar.Driver, false)

	SetEntityInvincible(RCCar.Driver, true)
	SetEntityVisible(RCCar.Driver, false)
	SetPedCombatAbility(RCCar.Driver, 0)
	FreezeEntityPosition(RCCar.Driver, true)
	SetPedAlertness(RCCar.Driver, 0.0)

	TaskWarpPedIntoVehicle(RCCar.Driver, RCCar.Entity, -1)

	while not IsPedInVehicle(RCCar.Driver, RCCar.Entity) do
		Citizen.Wait(0)
	end

	RCCar.Attach("place")
end

RCCar.Attach = function(param)
	if not DoesEntityExist(RCCar.Entity) then
		return
	end

	if param == "place" then
		AttachEntityToEntity(RCCar.Entity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), -0.1, 0.0, -0.2, 70.0, 0.0, 270.0, 1, 1, 0, 0, 2, 1)

		TaskPlayAnim(PlayerPedId(), "pickup_object", "pickup_low", 8.0, -8.0, -1, 0, 0, false, false, false)

		Citizen.Wait(800)

		DetachEntity(RCCar.Entity, false, true)

		PlaceObjectOnGroundProperly(RCCar.Entity)
	elseif param == "pick" then
		Citizen.Wait(100)

		TaskPlayAnim(PlayerPedId(), "pickup_object", "pickup_low", 8.0, -8.0, -1, 0, 0, false, false, false)

		Citizen.Wait(600)
	
		AttachEntityToEntity(RCCar.Entity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), -0.1, 0.0, -0.2, 70.0, 0.0, 270.0, 1, 1, 0, 0, 2, 1)

		Citizen.Wait(900)
	
		DetachEntity(RCCar.Entity)

		DeleteEntity(RCCar.Skate)
		DeleteVehicle(RCCar.Entity)
		DeleteEntity(RCCar.Driver)

		RCCar.UnloadModels()
		RCCar.SpawnHold()
	end

end


RCCar.LoadModels = function(models)
	for modelIndex = 1, #models do
		local model = models[modelIndex]

		if not RCCar.CachedModels then
			RCCar.CachedModels = {}
		end

		table.insert(RCCar.CachedModels, model)

		if IsModelValid(model) then
			while not HasModelLoaded(model) do
				RequestModel(model)	
				Citizen.Wait(10)
			end
		else
			while not HasAnimDictLoaded(model) do
				RequestAnimDict(model)
				Citizen.Wait(10)
			end    
		end
	end
end

RCCar.UnloadModels = function()
	if RCCar.CachedModels then
		for modelIndex = 1, #RCCar.CachedModels do
			local model = RCCar.CachedModels[modelIndex]
	
			if IsModelValid(model) then
				SetModelAsNoLongerNeeded(model)
			else
				RemoveAnimDict(model)   
			end
		end
	end
end

RCCar.AttachPlayer = function(toggle)
	if toggle then
		TaskPlayAnim(player, "move_strafe@stealth", "idle", 8.0, 8.0, -1, 1, 1.0, false, false, false)
		AttachEntityToEntity(player, RCCar.Entity , 20, 0.0, 0, 0.7, 0.0, 0.0, -15.0, true, true, true, true, true, true)
		SetEntityCollision(player, true, false)
		Attached = true		
	elseif not toggle then
		DetachEntity(player, false, false)
		Attached = false
		StopAnimTask(player, "move_strafe@stealth", "idle", 1.0)	
	end	
end

RegisterFontFile('sarabun')

ShowToolTip = function (msg, coords)
	AddTextEntry('FortuneHelpNotification', "<font face='sarabun'> ".. msg .. " </font>")
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('FortuneHelpNotification')
	EndTextCommandDisplayHelp(2, false, false, -1)
end
