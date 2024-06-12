function openSelectUI(airdropType,dataPlayer)
    SetTimecycleModifier('Bloom') -- blur
    SetTimecycleModifierStrength(1.5)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        airdropType = airdropType,
        dataPlayer = dataPlayer
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