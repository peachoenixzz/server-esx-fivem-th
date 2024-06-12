ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
end)

Config = {
    DamageNeeded = 300.0,
    MaxWidth = 5.0,
    MaxHeight = 5.0,
    MaxLength = 5.0
}

local Keys = {
    ["E"] = 38, ["LEFTSHIFT"] = 21, ["A"] = 34, ["D"] = 9
}

local VehicleData = {
    Coords = nil,
    Vehicle = nil,
    Dimensions = nil,
    IsInFront = false,
    Distance = nil
}

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local closestVehicle, distance = ESX.Game.GetClosestVehicle()
        if distance < 6.0 and not IsPedInAnyVehicle(ped, false) then
            local vehicleCoords = GetEntityCoords(closestVehicle)
            local dimension = GetModelDimensions(GetEntityModel(closestVehicle))
            VehicleData = {
                Coords = vehicleCoords,
                Dimensions = dimension,
                Vehicle = closestVehicle,
                Distance = distance,
                IsInFront = IsEntityInFront(ped, closestVehicle)
            }
        else
            VehicleData = {Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil}
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()

        if VehicleData.Vehicle and IsControlPressed(0, Keys["LEFTSHIFT"]) and IsVehicleSeatFree(VehicleData.Vehicle, -1) and not IsEntityAttachedToEntity(ped, VehicleData.Vehicle) and IsControlJustPressed(0, Keys["E"]) and GetVehicleEngineHealth(VehicleData.Vehicle) <= Config.DamageNeeded then
            HandleVehicleInteraction(ped, VehicleData)
        end
    end
end)

function IsEntityInFront(ped, entity)
    return GetDistanceBetweenCoords(GetEntityCoords(entity) + GetEntityForwardVector(entity), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(entity) + GetEntityForwardVector(entity) * -1, GetEntityCoords(ped), true)
end

function HandleVehicleInteraction(ped, vehicleData)
    NetworkRequestControlOfEntity(vehicleData.Vehicle)
    local coords = GetEntityCoords(ped)
    if vehicleData.IsInFront then
        AttachEntityToEntity(PlayerPedId(), vehicleData.Vehicle, GetPedBoneIndex(6286),
                0.0, vehicleData.Dimensions.y * -1 + 0.1, vehicleData.Dimensions.z + 1.0,
                0.0, 0.0, 180.0, 0.0, false, false, true, false, true)
    else
        AttachEntityToEntity(PlayerPedId(), vehicleData.Vehicle, GetPedBoneIndex(6286),
                0.0, vehicleData.Dimensions.y - 0.3, vehicleData.Dimensions.z + 1.0,
                0.0, 0.0, 0.0, 0.0, false, false, true, false, true)
    end

        -- Continue vehicle interaction
        ESX.Streaming.RequestAnimDict('missfinale_c2ig_11')
        TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
        Citizen.Wait(200)

        local currentVehicle = vehicleData.Vehicle
        while true do
            Citizen.Wait(5)
            if IsDisabledControlPressed(0, Keys["A"]) then
                TaskVehicleTempAction(PlayerPedId(), currentVehicle, 11, 1000)
            end

            if IsDisabledControlPressed(0, Keys["D"]) then
                TaskVehicleTempAction(PlayerPedId(), currentVehicle, 10, 1000)
            end

            if vehicleData.IsInFront then
                SetVehicleForwardSpeed(currentVehicle, -1.0)
            else
                SetVehicleForwardSpeed(currentVehicle, 1.0)
            end

            if HasEntityCollidedWithAnything(currentVehicle) then
                SetVehicleOnGroundProperly(currentVehicle)
            end

            if not IsDisabledControlPressed(0, Keys["E"]) then
                DetachEntity(ped, false, false)
                StopAnimTask(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
                FreezeEntityPosition(ped, false)
                break
            end
        end
    end