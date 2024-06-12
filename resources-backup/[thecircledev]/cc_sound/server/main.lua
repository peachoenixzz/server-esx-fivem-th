


ESX.RegisterServerCallback('cc_sound:initSound', function(source, cb, soundType)
    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)
    local xPlayers = ESX.OneSync.GetPlayersInArea(playerCoords, 13.0)
    for _, player in pairs(xPlayers) do
        TriggerClientEvent("cc_sound:playSound",player.id,soundType)
        ::endState::
    end
    cb()
end)