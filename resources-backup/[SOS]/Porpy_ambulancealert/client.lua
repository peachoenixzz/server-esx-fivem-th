local resourceName = GetCurrentResourceName()
local ESX = nil
local playerWhitelisted = true
local availableStatus = {
    {
        type =  "all",
        phoneRequire = false,
        status = true
    },
    {
        type =  "drug",
        phoneRequire = false,
        status = false
    },
    {
        type =  "amp",
        phoneRequire = false,
        status = false
    },
    {
        type = "cement",
        phoneRequire = false,
        status = false
    },
    {
        type = "thief",
        phoneRequire = false,
        status = false
    },
    {
        type = "store_rob",
        phoneRequire = false,
        status = false
    },
    {
        type = "house_rob",
        phoneRequire = false,
        status = false
    },
    {
        type = "ping",
        phoneRequire = true,
        status = false
    },
    {
        type = "dead",
        phoneRequire = true,
        status = false
    },
    {
        type = "dead2",
        phoneRequire = true,
        status = false
    },
    {
        type = "prisonbreak",
        phoneRequire = false,
        status = false
    },
    {
        type = "robvehicle",
        phoneRequire = false,
        status = false
    }
}
Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)


AddEventHandler("skinchanger:loadSkin", function(skin)
    sex = skin.sex == 0 and "male" or "female"
end)

RegisterNUICallback("updateAlert",function(data)
    playerWhitelisted = data.update
    print(playerWhitelisted)
end)

RegisterNUICallback("updateTypeAvailable",function(data,cb)
    for _,v in pairs(availableStatus) do
        print(data.type,v.type)
        if data.type == "all" then
            if v.type == data.type then
                if v.status then
                    v.status = false
                    cb(false)
                    goto continue
                end

                if not v.status then
                    v.status = true
                    cb(true)
                    goto continue
                end
            end
            v.status = false
        end

        if data.type ~= "all" then
            if v.type == "all" then
                v.status = false
                goto continue
            end

            if v.status and v.type == data.type then
                v.status = false
                cb(false)
                break
            end

            if not v.status and v.type == data.type then
                v.status = true
                cb(true)
                break
            end
        end
        ::continue::
    end
    print(json.encode(availableStatus))
end)

RegisterNetEvent(resourceName .. ":Notify")
AddEventHandler(resourceName .. ":Notify", function(title, actionType, value, tip, location,streetName,phone,formattedTime)
    if playerWhitelisted then
        for _,v in pairs(availableStatus) do
            if actionType == v.type then
                if not v.phoneRequire then
                    phone = "?????"
                end
            end
        end

        for _,v in pairs(availableStatus) do
            if v.type == actionType then
                if v.status then
                    alertActionNotify(title, actionType, value, tip, location, sex,streetName)
                    exports.cc_tablet:alertTabletPanel(title, actionType, location, streetName, phone, formattedTime)
                    TriggerEvent(resourceName .. ":alertArea", location)
                end
            end

            if v.type == "all" then
                if v.status then
                    alertActionNotify(title, actionType, value, tip, location, sex,streetName)
                    exports.cc_tablet:alertTabletPanel(title, actionType, location, streetName, phone, formattedTime)
                    TriggerEvent(resourceName .. ":alertArea", location)
                end
            end

        end
    end
end)

RegisterNetEvent(resourceName .. ":Notifyaccept")
AddEventHandler(resourceName .. ":Notifyaccept", function(playerName,slot)
    if playerWhitelisted then
        workerNameNotification(playerName,slot)
    end
end)

RegisterNetEvent(resourceName .. ":sendLocation")
AddEventHandler(resourceName .. ":sendLocation", function(location,slot)
    SetNewWaypoint(location.x, location.y)
    --SendGps()
    if Config["worker_name"] then
        TriggerServerEvent(resourceName .. ":accept",slot)
    end
end)

local function controlPressed(inputGroup, control)
    return IsControlPressed(inputGroup, control) or IsDisabledControlPressed(inputGroup, control)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2)
        local inputGroup
        if controlPressed(1, 157) then
            inputGroup = 1
        elseif controlPressed(1, 158) then
            inputGroup = 2
        elseif controlPressed(1, 160) then
            inputGroup = 3
        elseif controlPressed(1, 164) then
            inputGroup = 4
        elseif controlPressed(1, 165) then
            inputGroup = 5
        elseif controlPressed(1, 159) then
            inputGroup = 6
        elseif controlPressed(1, 161) then
            inputGroup = 7
        elseif controlPressed(1, 162) then
            inputGroup = 8
        elseif controlPressed(1, 163) then
            inputGroup = 9
        end

        if controlPressed(1, Config["base_key"]) and inputGroup and playerWhitelisted then
            TriggerServerEvent(resourceName .. ":getLocation", inputGroup)
            Citizen.Wait(1000)
        end
    end
end)

local function GetStreetName()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local streetName, _ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    streetName = GetStreetNameFromHashKey(streetName)
    return streetName
end

RegisterNetEvent(resourceName .. ":alertArea")
AddEventHandler(resourceName .. ":alertArea", function(location)
    Citizen.CreateThread(function()
        SendNUIMessage({ type = "playsound" })
        local blip = AddBlipForRadius(location.x, location.y, location.z, Config["red_radius"])
        SetBlipHighDetail(blip, true)
        SetBlipColour(blip, 1)
        SetBlipAlpha(blip, 200)
        SetBlipAsShortRange(blip, true)
        local duration = 200
        local updateInterval = duration / Config["duration"] * 100
        local updateAmount = duration / Config["duration"]

        while duration > 0 do
            duration = duration - updateAmount
            if duration <= 0 then
                RemoveBlip(blip)
            else
                SetBlipAlpha(blip, math.floor(duration))
            end
            Citizen.Wait(updateInterval)
        end
    end)
end)

AddEventHandler(resourceName .. ":alertNet", function(workerName)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    TriggerServerEvent(resourceName .. ":defaultAlert", workerName, sex, GetStreetName(), playerCoords)
end)

RegisterNetEvent(resourceName .. ":getalertNet")
AddEventHandler(resourceName .. ":getalertNet", function(workerName)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    TriggerServerEvent(resourceName .. ":defaultAlert", workerName, sex, GetStreetName(), playerCoords)
end)

