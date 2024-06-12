local anchorDropped = false

function client.toggleAnchor()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, true)
    local isDriver = GetPedInVehicleSeat(vehicle, -1) == ped

    if not vehicle or not isDriver then
        return false
    end

    if DecorGetBool(vehicle, 'isAnchored') then
        onUnanchored(vehicle)
        DecorSetBool(vehicle, "isAnchored", false)

        return
    end

    if not canAnchor(vehicle) then
        return
    end

    TriggerServerEvent("fd_anchor:toggleAnchor", VehToNet(vehicle))
end

function client.applyAnchor(self, vehicle)
    vehicle = NetToVeh(vehicle)

    local done = onAnchoring(vehicle)

    client.vehicles[vehicle] = {
        anchorPos = GetEntityCoords(vehicle),
        magnitude = 0.0
    }

    DecorSetBool(vehicle, "isAnchored", true)
end

function client.setAnchor(self, vehicle)
    vehicle = NetToVeh(vehicle)

    client.vehicles[vehicle] = {
        anchorPos = GetEntityCoords(vehicle),
        magnitude = 0.0
    }
end

CreateThread(function()
    while true do
        for vehicle, data in pairs(client.vehicles) do
            if not DecorGetBool(vehicle, 'isAnchored') then
                client.vehicles[vehicle] = nil

                goto continue
            end

            if not isOwner(vehicle) then
                TriggerServerEvent("fd_anchor:passAnchor", VehToNet(vehicle))
                client.vehicles[vehicle] = nil

                goto continue
            end

            local distanceVector = data.anchorPos - GetEntityCoords(vehicle)

            if #(distanceVector) > shared.minDriftDistance then
                local forceVector = forceCalculation(vehicle, distanceVector, #(distanceVector))

                ApplyForceToEntityCenterOfMass(vehicle, 1, forceVector.x, forceVector.y, 0.0, false, false, false)

                if #(distanceVector) > 20.0 or (data.magnitude > shared.breakingForce and #forceVector < data.magnitude) then
                    client.vehicles[vehicle] = nil
                    DecorSetBool(vehicle, "isAnchored", false)
                    onAnchorBroke(vehicle)
                end

                data.magnitude = #forceVector
            end

            ::continue::
        end

        Wait(0)
    end
end)


Citizen.CreateThread(function()
    while true do
        if IsControlJustPressed(0, 83) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then 
            OnAnchor()
        end
        Citizen.Wait(0)
    end
end)

function OnAnchor()
	TriggerEvent("mythic_progbar:client:progress",{
		name = "Achor",
		duration = 5000,
		label = "กำลังถอนสมอ",
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(status)
		if not status then
            client:toggleAnchor()
		end
	end)
end

exports('ToggleAnchor', function()
    client.toggleAnchor()
end)

exports('CanAnchor', function(vehicle)
    return client.canAnchor(vehicle)
end)

exports('IsAnchored', function(vehicle)
    return (client.vehicles[vehicle] and DecorGetBool(vehicle, 'isAnchored'))
end)
