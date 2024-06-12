--------- Variables ---------
local cooldown = false
local currentSpeed = 0.0
local cruiseSpeed = 999.0
local cruiseIsOn = false
local SeatbeltON = false
--local speedBuffer = {}
--local velBuffer = {}
local isInVehControl = false
local inVehicleShop = false
--------- Variables End ---------
--local ui = false
function SetDisplayUI(bool)
    SendNUIMessage({
        action = 'ui',
        ui = bool
    })
end

function setCloseUI()
    inVehicleShop = true
    SendNUIMessage({
        action = 'ui',
        ui = false,
    })
end

function setCloseVehicleShop()
    inVehicleShop = false
end

Citizen.CreateThread(function()
    while true do
        if IsNuiFocused() then
            local controlActions = {1, 2, 3, 4, 5, 6, 24, 64, 200, 257, 346}
            for _, control in ipairs(controlActions) do
                DisableControlAction(0, control, true)
            end
            if IsPedInAnyVehicle(PlayerPedId(), true) then
                DisableControlAction(0, 85, true)
            end
            Wait(0)
        else
            Wait(1000)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        local playerPed = GetPlayerPed(-1)
        if IsPedInAnyVehicle(playerPed, false) and DisableSeatShuffle then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            if GetPedInVehicleSeat(vehicle, 0) == playerPed and GetIsTaskActive(playerPed, 165) then
                SetPedIntoVehicle(playerPed, vehicle, 0)
            end
        end
        Wait(0) -- Adjust based on how quickly the shuffle needs to be prevented
    end
end)


--------- Main ---------
Citizen.CreateThread(function()
    local ui = false

    while true do
        local sleep = 500
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)

        if IsPedInVehicle(ped, vehicle, false) and not pauseMenuOn and not inVehicleShop then
            ui = true
            sleep = 10

            local fuel = math.floor(GetVehicleFuelLevel(vehicle))
            local health = math.floor(GetVehicleEngineHealth(vehicle) / 10)
            local RPM = GetVehicleCurrentRpm(vehicle)

            if not GetIsVehicleEngineRunning(vehicle) then
                RPM = 0
            elseif RPM > 0.2 then
                RPM = RPM * 100 + math.random(-2, 2)
                RPM = RPM / 100
            end

            local vehicleData = {
                action = 'ui',
                ui = true,
                TyreBurst1 = IsVehicleTyreBurst(vehicle, 0),
                TyreBurst2 = IsVehicleTyreBurst(vehicle, 1),
                TyreBurst3 = IsVehicleTyreBurst(vehicle, 4),
                TyreBurst4 = IsVehicleTyreBurst(vehicle, 5),
                TyreHealth1 = GetTyreHealth(vehicle,0),
                TyreHealth2 = GetTyreHealth(vehicle,1),
                TyreHealth3 = GetTyreHealth(vehicle,4),
                TyreHealth4 = GetTyreHealth(vehicle,5),
                speedType = Config.SpeedType,
                light = getLight(GetVehicleLightsState(vehicle)),
                engineControl = GetIsVehicleEngineRunning(vehicle),
                speedLimit = Config.SpeedAlertLimit,
                fuelLimit = Config.FuelAlertLimit,
                fuel = fuel,
                healthLimit = Config.HealthAlertLimit,
                health = health,
                handbrake = GetVehicleHandbrake(vehicle),
                speed = math.floor(GetEntitySpeed(vehicle) * 3.6),
                gear = math.floor(GetVehicleCurrentGear(vehicle)),
                isCar = IsCar(vehicle),
                doorlock = GetVehicleDoorLockStatus(vehicle),
                car = IsCar2(vehicle),
                rpm = round(RPM * 7),
                rpmPercent = RPM / 0.0133
            }

            if GetVehicleClass(vehicle) == 13 then
                SetVehicleFuelLevel(vehicle, 0)
            end

            SendNUIMessage(vehicleData)

        elseif ui then
            ui = false
            SendNUIMessage({action = 'ui', ui = false})
            if isInVehControl then
                closeVehControl()
            end
        end

        Citizen.Wait(sleep)
    end
end)

--------- Main End ---------
function IsCar2(vehicle)
    local vc = GetVehicleClass(vehicle)
    if (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20) then
        return "car"
    elseif (vc == 8) then
        return "motorcycles"
    elseif (vc == 14) then
        return "boat"
    elseif vc == 16 then
		return 'air'
    elseif (vc == 13) then
        return "motorcycles"
    elseif (vc == 15 or vc == 16) then
        return "helicopters"
    end
end	

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end
--------- Seatbelt ---------
AddEventHandler('seatbelt:sounds', function(soundFile, soundVolume)
    SendNUIMessage({
        transactionType = 'playSound',
        transactionFile = soundFile,
        transactionVolume = soundVolume
    })
end)

function IsCar(veh)
    local vc = GetVehicleClass(veh)
    return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end	

function Fwv(entity)
    local hr = GetEntityHeading(entity) + 90.0
    if hr < 0.0 then hr = 360.0 + hr end
    hr = hr * 0.0174533
    return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end
getLight = function(n, n2)
	if n == 0 then
		return n2
	else
		return n
	end
end
local vehData = {
    hasBelt = false,
    engineRunning = false,

    currSpd = 0.0,
    cruiseSpd = 0.0,
    prevVelocity = { x = 0.0, y = 0.0, z = 0.0 }, 
}

Citizen.CreateThread(function()
    Citizen.Wait(500)
    local wasInCar = false
    local speedBuffer = {0.0, 0.0}
    local velBuffer = {vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0)}

    while true do
        local ped = PlayerPedId()
        local car = GetVehiclePedIsIn(ped)
        local isCar = IsCar(car)

        if car ~= 0 then
            SetRadarZoom(1100)
            if not wasInCar then
                wasInCar = true
                speedBuffer = {0.0, 0.0}
                velBuffer = {vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0)}
            end

            if SeatbeltON then DisableControlAction(0, 75) end

            if not SeatbeltON then
                local speed = GetEntitySpeed(car)
                local speedVectorY = GetEntitySpeedVector(car, true).y

                if speedBuffer[2] > Config.MinSpeed and
                        speedVectorY > 1.0 and
                        (speedBuffer[2] - speed) > (speed * Config.DiffTrigger) then
                    local co = GetEntityCoords(ped)
                    local fw = Fwv(ped)
                    SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
                    SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
                    SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
                end
            end

            speedBuffer[2], speedBuffer[1] = speedBuffer[1], GetEntitySpeed(car)
            velBuffer[2], velBuffer[1] = velBuffer[1], GetEntityVelocity(car)

            if IsControlJustReleased(0, Config.SeatBeltInput) then
                    SeatbeltON = not SeatbeltON
                    SendNUIMessage({
                        action = 'seatbelt',
                        isCar = isCar,
                        SeatbeltON = SeatbeltON,
                        SeatbeltColor  =  Config.SeatbeltColor
                    })
                    if SeatbeltON then
                        TriggerEvent("seatbelt:sounds", "buckle", Config.SeatBeltVolume )
                    else
                        TriggerEvent("seatbelt:sounds", "unbuckle", Config.SeatBeltVolume )
                    end
            end

        elseif wasInCar then
            wasInCar = false
            SeatbeltON = false
        end
        Citizen.Wait(0)
    end
end)


--------- Seatbelt End ---------

Citizen.CreateThread(function()
    while true do
        if not SeatbeltON and not inVehicleShop then
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(ped, false)
            if IsPedInVehicle(ped, vehicle, false) and IsCar(vehicle) then
                TriggerEvent("seatbelt:sounds", "belt", Config.SeatBeltVolume)
            end
        end
        Citizen.Wait(1600) -- Adjust if necessary
    end
end)


Citizen.CreateThread(function()
    while true do
        local displayRadar = IsPedInAnyVehicle(PlayerPedId(), false) and not inVehicleShop
        DisplayRadar(displayRadar)
        Citizen.Wait(5000) -- Adjust if necessary
    end
end)

-- RegisterKeyMapping("speedometer", "Key Bind speedometer", "keyboard", 'G')
-- RegisterCommand("speedometer", function()
--     local ped = PlayerPedId()
--     local vehicle = GetVehiclePedIsIn(ped)
--     local car = IsPedInVehicle(ped, vehicle, false)
--     if car then
--         SendNUIMessage({
--             speedometertype = 'open',
--         })
--         SetNuiFocus(true, true)
--     end
-- end)



--Vehicle Control
RegisterNUICallback('menuget', function(data, cb)
    if data.name == 'door' then
		DoorControl(data.num)
	elseif data.name == 'engine' then
		EngineControl()
	elseif data.name == 'chair' then
		SeatControl(data.num)
	end
	cb("ok")
end)

function EngineControl()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
        SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), false, true)
    end
end

function DoorControl(door)
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
			SetVehicleDoorShut(vehicle, door, false)
		else
			SetVehicleDoorOpen(vehicle, door, false)
		end
	end
end

function SeatControl(seat)
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if IsVehicleSeatFree(vehicle, seat) then
			SetPedIntoVehicle(GetPlayerPed(-1), vehicle, seat)
		end
	end
end
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			if ( IsControlJustReleased( 0, 84 ) or IsDisabledControlJustReleased( 0, 84 ) ) and GetLastInputMethod( 0 ) then
				if not isInVehControl and not inVehicleShop then
					openVehControl()
				else
					closeVehControl()
				end
			end
		else
			Citizen.Wait(500)
		end
    end
end)

function openVehControl()
	isInVehControl = true
	SetNuiFocusKeepInput(true)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'menucar',
		displayMenucar = true
	})
end

function closeVehControl()
	SetNuiFocus(false, false)
	SetNuiFocusKeepInput(false)
	
	SendNUIMessage({
		action = 'menucar',
		displayMenucar = false
	})
	Wait(2000)
	isInVehControl = false
end