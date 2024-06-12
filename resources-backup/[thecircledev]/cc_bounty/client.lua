local playerBlips = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

RegisterNetEvent('cc_bounty:updateBountyGpsBlips')
AddEventHandler('cc_bounty:updateBountyGpsBlips', function(playersData)
    for _, blip in pairs(playerBlips) do
        RemoveBlip(blip)
    end


    playerBlips = {}  -- Reset the playerBlips table

    -- Now, create new blips based on received coordinates
    for _, data in ipairs(playersData) do
        local blip = AddBlipForCoord(data.coords.x, data.coords.y, data.coords.z)
        SetBlipSprite(blip, 303)
        -- ... [other blip configurations] ...
        table.insert(playerBlips, blip)
    end
end)
