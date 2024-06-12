ESX = nil
local insavezone1st = false
local insavezone2rd = false
local weaponHash = GetHashKey("WEAPON_UNARMED")

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

--===============================================================================================================================
--===============================================================================================================================

function checkInZoneSaveZone1st()
    return insavezone1st
end

for _,v in pairs(Config.SaveZone1st) do
    local savezoneCircle1st = PolyZone:Create(v.coords, {
        name = v.name,
        debugPoly = v.debug,
        minZ = v.minZ,
        maxZ = v.maxZ,
    })

    savezoneCircle1st:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            insavezone1st = true
        else
            insavezone1st = false
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if insavezone1st == true then
            --print("1st savezone "..insavezone1st)
            DisablePlayerFiring(PlayerPedId(), true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 264, true)
            DisableControlAction(0, 141, true)
            if currentWeapon ~= weaponHash then
                SetCurrentPedWeapon(PlayerPedId(), weaponHash, true)
            end
        else 
            Citizen.Wait(500)
        end
    end
end)

--===============================================================================================================================
--===============================================================================================================================

function checkInZoneSaveZone2rd()
    return insavezone2rd
end

for _,v in pairs(Config.SaveZone2rd) do
    local savezoneCircle2rd = PolyZone:Create(v.coords, {
        name = v.name,
        debugPoly = v.debug,
        minZ = v.minZ,
        maxZ = v.maxZ,
    })

    savezoneCircle2rd:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            insavezone2rd = true
        else
            insavezone2rd = false
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if insavezone2rd == true then
            --print("2rd savezone "..insavezone2rd)
            DisablePlayerFiring(PlayerPedId(), true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 264, true)
            DisableControlAction(0, 141, true)
            if currentWeapon ~= weaponHash then
                SetCurrentPedWeapon(PlayerPedId(), weaponHash, true)
            end
        else 
            Citizen.Wait(500)
        end
    end
end)







