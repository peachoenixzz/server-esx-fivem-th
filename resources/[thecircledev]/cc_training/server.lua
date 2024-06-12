RegisterServerEvent('cc_training:exittraining')
AddEventHandler('cc_training:exittraining', function()
    local xPlayer	= ESX.GetPlayerFromId(source)
    removeItemTraining(xPlayer)
    removeWeaponTraining(xPlayer)
end)

function removeItemTraining(xPlayer)
    for _,v in pairs(Config.removeItem) do
        local xItem = xPlayer.getInventoryItem(v.itemName)
        if xItem.count >= 1 then
            xPlayer.removeInventoryItem(xItem.name, xItem.count)
        end
    end
end

function removeWeaponTraining(xPlayer)
    for _,v in pairs(Config.removeWeapon) do
        local haveWeapon = xPlayer.getWeapon(v.weaponName)
        if haveWeapon then
            xPlayer.removeWeapon(v.weaponName)
        end
    end
end