
ESX.RegisterInput("circle:guidebook", "Guide Book Circle Hotkey", "keyboard", "PAGEUP", function()
    -- openGUI()
end)


function openGUI()
    SetTimecycleModifier('Bloom') -- blur
    SetTimecycleModifierStrength(1.5)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
    })
end

RegisterNUICallback('NUIFocusOff', function()
    closeGUI()
end)

function closeGUI()
    SendNUIMessage({action = "closeAll"})
    SetNuiFocus(false, false)
    SetTimecycleModifier('default') -- blur
    ClearPedTasks(PlayerPedId())
end


AddEventHandler('esx:onPlayerDeath', function(data)
    exports.helpnotify:hideHelpNotification()
    SendNUIMessage({action = "closeAll"})
    closeGUI()
end)