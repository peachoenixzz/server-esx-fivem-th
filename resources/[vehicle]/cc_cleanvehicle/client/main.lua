-- client.lua

local cleanVehicles = {}

-- Function to keep a vehicle clean
local function keepVehicleClean(vehicle)
    if vehicle and DoesEntityExist(vehicle) then
        SetVehicleDirtLevel(vehicle, 0.0)
    end
end

-- Event to add a vehicle to the clean list
RegisterNetEvent('vehicle:keepClean')
AddEventHandler('vehicle:keepClean', function(plate)
    cleanVehicles[plate] = true
end)

-- Event to remove a vehicle from the clean list
RegisterNetEvent('vehicle:removeClean')
AddEventHandler('vehicle:removeClean', function(plate)
    cleanVehicles[plate] = nil
end)

-- Check and keep vehicles clean
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3000) -- Check every 3 seconds
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local plate = GetVehicleNumberPlateText(vehicle)
            if cleanVehicles[plate] then
                keepVehicleClean(vehicle)
            end
        else
            Citizen.Wait(5000) -- If not in a vehicle, wait longer
        end
    end
end)

-- Request the clean list from the server when the player spawns
AddEventHandler('playerSpawned', function()
    ESX.TriggerServerCallback('vehicle:getCleanList', function(vehicles)
        cleanVehicles = vehicles
    end)
end)

-- Remove vehicle from clean list
function removeVehicleFromCleanList(plate)
    ESX.TriggerServerCallback('vehicle:removeFromCleanList', function(success)
        if success then
            print("Vehicle with plate " .. plate .. " removed from clean list.")
        else
            print("Failed to remove vehicle with plate " .. plate .. " from clean list.")
        end
    end, plate)
end
