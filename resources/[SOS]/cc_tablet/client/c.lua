function alertTabletPanel(title, actionType, location, streetName, phone, formattedTime)
    --print(title, actionType, streetName, location, phone, formattedTime)
    SendNUIMessage({
        action = "update",
        name = actionType,
        labelName = title,
        address = streetName,
        phone = phone,
        location = location,
        time = formattedTime,
    })
end

function closeUI()
    SetNuiFocus(false, false)
    SendNUIMessage({action = 'close'})
end

RegisterNUICallback('NUIFocusOff', function()
    closeUI()
end)

RegisterNetEvent("cc_tablet:openTablet")
AddEventHandler("cc_tablet:openTablet", function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open"
    })
end)

RegisterNUICallback('alertArea', function(data)
    SetNewWaypoint(tonumber(data.x), tonumber(data.y))
    Citizen.CreateThread(function()
        local blip = AddBlipForRadius(tonumber(data.x), tonumber(data.y), tonumber(data.z), 60.0)
        SetBlipHighDetail(blip, true)
        SetBlipColour(blip, 1)
        SetBlipAlpha(blip, 200)
        SetBlipAsShortRange(blip, true)
        local duration = 200
        local updateInterval = duration / 12 * 100
        local updateAmount = duration / 12
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


