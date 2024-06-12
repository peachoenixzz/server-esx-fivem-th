
RegisterServerEvent('removePara')
AddEventHandler('removePara', function()
    local xPlayer	= ESX.GetPlayerFromId(source)
    xPlayer.removeWeapon("GADGET_PARACHUTE", 1)
end)