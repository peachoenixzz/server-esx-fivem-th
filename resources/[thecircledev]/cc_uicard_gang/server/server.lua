
RegisterNetEvent('cc_uicard_gang:showCardClosetPlayer')
AddEventHandler('cc_uicard_gang:showCardClosetPlayer', function(target)
    --local ped = playerPed
    --local xPlayer = ESX.GetPlayerFromId(source)
    local targetSource = ESX.GetPlayerFromId(target)
    --print(targetSource)
    --print(targetSource.source)
    --print(xPlayer)
    TriggerClientEvent("cc_uicard_gang:showCardClosetPlayer",targetSource.source)
end )