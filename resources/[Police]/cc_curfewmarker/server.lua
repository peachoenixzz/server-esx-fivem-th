ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local onCurfew = false
local curfewLocation = {}

ESX.RegisterUsableItem('gov_curfew', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("gov_curfew")
    if xItem.count > 0 and xPlayer.job.name == 'police' then
        checkCurfew(source)
    end
end)

function checkCurfew(source)
    if onCurfew then
        onCurfew = false
        curfewLocation = {}
        TriggerClientEvent('curfewmarker:updateCurfew', -1, onCurfew, curfewLocation)
        return
    end

    if not onCurfew then
        local playerPed = GetPlayerPed(source)
        local coords = GetEntityCoords(playerPed)
        onCurfew = true
        curfewLocation = coords
        TriggerClientEvent('curfewmarker:updateCurfew', -1, onCurfew, curfewLocation)
        return
    end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(player, xPlayer)
    TriggerClientEvent('curfewmarker:updateCurfew', xPlayer.source, onCurfew, curfewLocation)
end)