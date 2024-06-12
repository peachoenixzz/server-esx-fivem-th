RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
    TriggerServerEvent('cc_weight:set')
end)