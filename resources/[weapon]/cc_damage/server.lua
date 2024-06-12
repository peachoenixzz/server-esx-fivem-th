
RegisterServerEvent('cc_damage:removePara')
AddEventHandler('cc_damage:removePara', function()
    local xPlayer	= ESX.GetPlayerFromId(source)
    xPlayer.removeWeapon("GADGET_PARACHUTE", 1)
end)

ESX.RegisterServerCallback('cc_damge:lifestealattacker', function(source, cb, attacker)
    TriggerClientEvent('cc_damage:healattacker', attacker)
    cb(true)
end)