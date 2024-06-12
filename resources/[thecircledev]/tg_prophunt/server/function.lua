ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('tg_prophunt:giveWeapon')
AddEventHandler('tg_prophunt:giveWeapon', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon('WEAPON_CARBINERIFLE', 300)
end)

RegisterNetEvent('tg_prophunt:removeWeapon')
AddEventHandler('tg_prophunt:removeWeapon', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeWeapon('WEAPON_CARBINERIFLE')
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeWeapon('WEAPON_CARBINERIFLE')
end)