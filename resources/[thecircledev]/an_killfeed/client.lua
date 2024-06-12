-- Join Discord for Support: https://discord.gg/KxdPzC5EeJ

-- Variables --
local showKillfeed = true
local recentDeaths = {}
local damageIndex = {
    fatal = 6,
    weapon = 7
}

-- Functions --
local function addKill(id, killer, victim, image, design, noScoped, headshot, driveBy, dist)
    SendNUIMessage({
        action = "addKill",
        data = {
            id = id,
            killer = killer,
            victim = victim,
            image = image,
            design = design,
            noScoped = noScoped,
            headshot = headshot,
            driveBy = driveBy,
            dist = dist
        }
    })
end

local function GetPedSubType(ped)
    if GetPedType(ped) == 28 then
        return "animal"
    end
    return "human"
end

local function GetNearbyVehicles(coords)
    local handle, entity = FindFirstVehicle()
    local success = nil
    local vehicles = {}
    repeat
        local pos = GetEntityCoords(entity)
        local distance = #(coords - pos)
        if distance < 15.0 then
            vehicles[#vehicles+1] = entity
        end
        success, entity = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return vehicles
end

local function HandleDeath(killerPed, victimPed, weaponHash, isMelee)
    local weapon = Config.weapons[weaponHash]
    local headshot = false
    local noScoped = false
    local driveBy = false
    local showDist = false

    if not Config.includeNPCs then
        if not IsPedAPlayer(victimPed) then
            return
        elseif not IsPedAPlayer(killerPed) then
            killerPed = -1
            weaponHash = 'default'
        end
    elseif not Config.includeAnimals then
        if GetPedSubType(victimPed) == "animal" then
            return
        elseif GetPedSubType(killerPed) == "animal" then
            killerPed = -1
            weaponHash = 'default'
        end
    end

    if not DoesEntityExist(killerPed) or (killerPed == victimPed and weapon.canSelf == false) then
        killerPed = -1
    end

    if weaponHash == 133987706 and (killerPed == victimPed or GetVehiclePedIsIn(killerPed, false) == GetVehiclePedIsIn(victimPed, false)) then
        local victimVeh = GetVehiclePedIsIn(victimPed, false)
        local vehicles = GetNearbyVehicles(GetEntityCoords(victimPed))
    
        for _index, vehicle in pairs(vehicles) do
            if victimVeh ~= vehicle then
                if HasEntityBeenDamagedByEntity(victimVeh, vehicle, true) then
                    local driver = GetPedInVehicleSeat(vehicle, -1)
                    if driver ~= 0 then
                        killerPed = driver
                        break
                    end
                end
            end
        end
    end

    if Config.showDriveBy and weapon.canDB and IsPedShooting(killerPed) then
        local vehicle = GetVehiclePedIsIn(killerPed, false)
        if vehicle ~= 0 then
            if GetVehicleClass(vehicle) == 8 or GetVehicleClass(vehicle) == 13 then
                driveBy = 'driveby_bike'
            else
                driveBy = 'driveby_vehicle'
            end
        end
    end

    if Config.showHeadshot and weapon.HS ~= false and not isMelee then
        local found, bone = GetPedLastDamageBone(victimPed)
        if found and (bone == 31086 or bone == 39317) then
            headshot = true
        end
    end

    if (Config.showKillDist and weapon.showDist) then
        showDist = true
    end

    local killer = {}
    if killerPed == -1 then
        killer.netId = 0
    else
        killer.netId = PedToNet(killerPed)
        if IsPedAPlayer(killerPed) then
            killer.type = "player"
            killer.sourceId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(killerPed))

            if Config.showNoScope and weapon.canNS and not IsFirstPersonAimCamActive() then
                noScoped = true
            end
        else
            killer.type = "npc"
            killer.gender = IsPedMale(killerPed) and "male" or "female"
            killer.pedType = GetPedSubType(killerPed)
        end
    end

    local victim = {}
    victim.netId = PedToNet(victimPed)
    if IsPedAPlayer(victimPed) then
        victim.type = "player"
        victim.sourceId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(victimPed))
    else
        victim.type = "npc"
        victim.gender = IsPedMale(victimPed) and "male" or "female"
        victim.pedType = GetPedSubType(victimPed)
    end

    TriggerServerEvent('an_killfeed:add', killer, victim, weapon.image, noScoped, headshot, driveBy, showDist)
end

local function OnEntityDamage(args)
    local fatal = args[damageIndex.fatal]
    if fatal == 0 then
        return
    end

    local victim = args[1]
    local killer = args[2]
    local playerPed = PlayerPedId()

    if not IsEntityAPed(victim) then
        return
    end

    if recentDeaths[victim] then
        return
    end

    if playerPed == killer or (not IsPedAPlayer(killer) and NetworkHasControlOfEntity(victim)) then
        local weaponHash = args[damageIndex.weapon]

        if not Config.weapons[weaponHash] then
            weaponHash = 'default'
        end

        if Config.weapons[weaponHash].ignoreDeath then
            return
        end

        local isMelee = (args[12] == 1 and true) or false
        recentDeaths[victim] = true
        HandleDeath(killer, victim, weaponHash, isMelee)
        Citizen.Wait(1000)
        recentDeaths[victim] = nil
    end
end

-- Events --
AddEventHandler('gameEventTriggered', function(event, args)
    if not exports.cc_training:checkInZoneTraining() then return end
	if event == "CEventNetworkEntityDamage" then
        OnEntityDamage(args)
    end
end)

RegisterNetEvent('an_killfeed:addCL')
AddEventHandler('an_killfeed:addCL', function(killer, victim, image, noScoped, headshot, driveBy, dist)
    if not exports.cc_training:checkInZoneTraining() then return end
    if not showKillfeed then return end
    local design = 'black-design'

    if killer.netId == PedToNet(PlayerPedId()) then
        design = 'teal-design'
    end
    if victim.netId == PedToNet(PlayerPedId()) then
        design = 'red-design'
    end

    addKill("id_k"..victim.netId, killer, victim, image, design, noScoped, headshot, driveBy, dist)
end)

-- Commands --
RegisterCommand(Config.ShowHideCommand, function(source, args, rawCommand)
    showKillfeed = not showKillfeed
    SendNUIMessage({ action = "toggleKillfeed", data = { state = showKillfeed } })
    if showKillfeed then
        TriggerEvent('chat:addMessage', { args = { "Killfeed is now enabled." } })
    else
        TriggerEvent('chat:addMessage', { args = { "Killfeed was disabled." } })
    end
end, false)


-- Start Script --
Citizen.CreateThread(function()
    Citizen.Wait(2500)

    -- Fix for game build 1604
    if GetGameBuildNumber() < 2060 then
        damageIndex.fatal = 4
        damageIndex.weapon = 5
    end

    SendNUIMessage({
        action = "setConfig",
        data = {
            showTime = Config.showTime,
            maxLines = Config.maxKillLines,
        }
    })
end)

------------- DEBUG -- TESTING ------------------------
if Config.enableDemo then
    local spawnedPeds = {}
    local randModels = {
        "a_f_m_tramp_01",
        "a_m_m_farmer_01",
        "a_m_m_prolhost_01",
        "a_m_m_tranvest_01",
        "a_m_o_soucent_03",
        "a_m_y_hasjew_01",
        "a_m_y_stwhi_01",
        "a_m_y_surfer_01",
        "a_c_cat_01",
        "a_c_deer",
        "a_c_cow",
        "a_c_husky",
        "a_c_rat",
        "a_c_rhesus",
    }

    RegisterCommand("spawntestpeds", function(s,a,r)
        if #spawnedPeds ~= 0 then
            for i = 1, #spawnedPeds do
                SetPedAsNoLongerNeeded(spawnedPeds[i])
                DeleteEntity(spawnedPeds[i])
                spawnedPeds = {}
            end
            return
        end
        local lastped = nil
        local number = math.random(4,6)
        for i = 1, number do 
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local h = GetEntityHeading(ped)
            local coords2
            if not lastped then
                coords2 = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
            else
                coords2 = GetOffsetFromEntityInWorldCoords(lastped, 1.0, 0.0, 0.0)
            end
            local model2 = GetHashKey(randModels[math.random(1, #randModels)])
            if model2 then
                RequestModel(model2)
                while not HasModelLoaded(model2) do
                    Wait(10)
                    RequestModel(model2)
                end
                local num = #spawnedPeds + 1
                spawnedPeds[num] = CreatePed(4, model2, coords2, h, true, true)
                SetPedAlertness(spawnedPeds[num], 0.0)
                SetBlockingOfNonTemporaryEvents(spawnedPeds[num], true)
                lastped = spawnedPeds[num]
            end
            Wait(100)
        end
    end)

    RegisterCommand("customdeaths", function(s,a,r)
        local killer = {}
        local victim = {}
        victim.netId = PedToNet(PlayerPedId())
        victim.type = "player"
        victim.sourceId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(PlayerPedId()))
        TriggerServerEvent('an_killfeed:add', killer, victim, "starvation", false, false, false, false)
        Wait(2000)
        TriggerServerEvent('an_killfeed:add', killer, victim, "dehydration", false, false, false, false)
        Wait(2000)
        TriggerServerEvent('an_killfeed:add', killer, victim, "bleeding", false, false, false, false)
    end)

    RegisterCommand("testkillfeed", function(s,a,r)
        while true do
            local killer = {}
            killer.netId = -1
            killer.type = "player"
            killer.sourceId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(PlayerPedId()))
            local victim = {}
            victim.netId = PedToNet(PlayerPedId())
            victim.type = "player"
            victim.sourceId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(PlayerPedId()))
            TriggerServerEvent('an_killfeed:add', killer, victim, "WEAPON_MUSKET", true, true, false, true)
            Wait(8000)
        end
    end)
end