function openSelectUI(airdropType,blackCount,redCount,greenCount,whiteCount,blueCount)
    SetTimecycleModifier('Bloom') -- blur
    SetTimecycleModifierStrength(1.5)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        airdropType = airdropType,
        allColor = {
            black = blackCount ,
            red = redCount,
            green = greenCount,
            white = whiteCount,
            blue = blueCount
        },
    })
end

RegisterNUICallback('NUIFocusOff', function()
    closeGui()
end)

function closeGui()
    SendNUIMessage({action = "closeAll"})
    SetNuiFocus(false, false)
    SetTimecycleModifier('default') -- blur
    ClearPedTasks(PlayerPedId())
end


AddEventHandler('esx:onPlayerDeath', function(data)
    exports.helpnotify:hideHelpNotification()
    SendNUIMessage({action = "closeAll"})
    closeGui()
end)