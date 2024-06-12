local resourceName = GetCurrentResourceName()
ESX = nil

TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)

local alerts = {}

local function NotifyAll(title, actionType, value, tip, location,streetName,source)
    local currentTime = os.date("*t")
    local formattedTime = string.format("%02d:%02d", currentTime.hour, currentTime.min)

    getPhoneNumber(source, function (phone)
        TriggerClientEvent(resourceName .. ":Notify", -1, title, actionType, value, tip, location,streetName,phone,formattedTime)
    end)
end

function getPhoneNumber (source, callback)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer == nil then
        callback(nil)
    end
    MySQL.Async.fetchAll('SELECT phone_number FROM users WHERE identifier = @identifier',{
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        callback(result[1].phone_number)
    end)
end

RegisterServerEvent(resourceName .. ":accept")
AddEventHandler(resourceName .. ":accept", function(slot)
    local playerName = GetPlayerName(source)
    TriggerClientEvent(resourceName .. ":Notifyaccept", -1, playerName,slot)
end)

local function GetAvailableSlot(location)
    local slot
    for i = 1, 9 do
        local alert = alerts[i]
        if not alert then
            slot = i
            alerts[i] = { time = GetGameTimer() + Config["duration"] * 800, pos = location }
            break
        end
    end
    return slot
end

RegisterServerEvent(resourceName .. ":getLocation")
AddEventHandler(resourceName .. ":getLocation", function(slot)
    local alert = alerts[slot]
    if alert then
        TriggerClientEvent(resourceName .. ":sendLocation", source, alert.pos,slot)
    end
end)

local alertCooldowns = {}

RegisterServerEvent(resourceName .. ":defaultAlert")
AddEventHandler(resourceName .. ":defaultAlert", function(alertType, sex, streetName, location)
    local source = source
    if alertCooldowns[source] and alertCooldowns[source] > GetGameTimer() then
        return
    end

    local slot = GetAvailableSlot(location)
    if not slot then
        return
    end

    local action
    if alertType == "dead" then
        action = Config["translate"]["action_dead"]
    elseif alertType == "dead2" then
        action = Config["translate"]["action_dead2"]
    elseif alertType == "ping" then
        action = Config["translate"]["ping"]
    end
    alertCooldowns[source] = GetGameTimer() + Config["duration"] * 800
    NotifyAll(action, alertType, streetName, slot, location,streetName,source)
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, 9 do
            local alert = alerts[i]
            if alert and alert.time < GetGameTimer() then
                alerts[i] = nil
            end
        end
        Citizen.Wait(500)
    end
end)
