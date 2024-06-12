-- server.lua

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Table to store vehicles that should remain clean by their plate
local cleanVehicles = {}

-- Callback to get the clean vehicles list
ESX.RegisterServerCallback('vehicle:getCleanList', function(source, cb)
    cb(cleanVehicles)
end)

-- Callback to add a vehicle to the clean list
ESX.RegisterServerCallback('vehicle:addToCleanList', function(source, cb, plate)
    if not plate then
        cb(false, "Plate is required.")
        return
    end

    if cleanVehicles[plate] then
        cb(false, "Vehicle with plate " .. plate .. " is already in the clean list.")
        return
    end

    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeMoney(1000)
    cleanVehicles[plate] = true
    TriggerClientEvent('vehicle:keepClean', -1, plate)
    print("Vehicle with plate " .. plate .. " will now stay clean.")
    cb(true)
end)

-- Callback to remove a vehicle from the clean list
ESX.RegisterServerCallback('vehicle:removeFromCleanList', function(source, cb, plate)
    if not plate then
        cb(false, "Plate is required.")
        return
    end

    if not cleanVehicles[plate] then
        cb(false, "Vehicle with plate " .. plate .. " is not in the clean list.")
        return
    end

    cleanVehicles[plate] = nil
    TriggerClientEvent('vehicle:removeClean', -1, plate)
    print("Vehicle with plate " .. plate .. " will no longer stay clean.")
    cb(true)
end)
