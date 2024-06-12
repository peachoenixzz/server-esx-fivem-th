local effectActive = false
Config = {}
local speedBuffer = {}
local velBuffer = {}
Config.weaponList = {
    WEAPON_UNARMED = {
         name = "WEAPON_UNARMED",
         damage = 3,
         hash = nil,
         block_instant_kill = false,
         block_hit = false,
         headshot_dead = false,
         disable_critical_hit = false
    },
    WEAPON_FLASHLIGHT = {
        name = "WEAPON_FLASHLIGHT",
        damage = 1,
        hash = nil,
        block_instant_kill = true,
        block_hit = true,
        headshot_dead = false,
        disable_critical_hit = false
    },
    -- Bat
    WEAPON_BAT_1H = {
        name = "WEAPON_BAT_1H",
        damage = 10,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_BAT_1H_2 = {
        name = "WEAPON_BAT_1H_2",
        damage = 12,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_BAT = {
        name = "WEAPON_BAT",
        damage = 14,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    -- Golfclub
    WEAPON_GOLFCLUB_1H = {
        name = "WEAPON_GOLFCLUB_1H",
        damage = 10,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_GOLFCLUB_1H_2 = {
        name = "WEAPON_GOLFCLUB_1H_2",
        damage = 12,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_GOLFCLUB = {
        name = "WEAPON_GOLFCLUB",
        damage = 14,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    -- Knuckle
    WEAPON_KNUCKLE = {
        name = "WEAPON_KNUCKLE",
        damage = 7,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_KNUCKLE_2 = {
        name = "WEAPON_KNUCKLE_2",
        damage = 9,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_KNUCKLE_3 = {
        name = "WEAPON_KNUCKLE_3",
        damage = 11,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_KNUCKLE_4 = {
        name = "WEAPON_KNUCKLE_4",
        damage = 14,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_KNUCKLE_5 = {
        name = "WEAPON_KNUCKLE_5",
        damage = 17,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    -- Machete
    WEAPON_MACHETE = {
        name = "WEAPON_MACHETE",
        damage = 19,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_MACHETE_2 = {
        name = "WEAPON_MACHETE_2",
        damage = 23,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_MACHETE_3 = {
        name = "WEAPON_MACHETE_3",
        damage = 27,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    -- Bottle
    WEAPON_BOTTLE = {
        name = "WEAPON_BOTTLE",
        damage = 18,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_BOTTLE_2 = {
        name = "WEAPON_BOTTLE_2",
        damage = 21,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_BOTTLE_3 = {
        name = "WEAPON_BOTTLE_3",
        damage = 23,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    -- Knife
    WEAPON_KNIFE = {
        name = "WEAPON_KNIFE",
        damage = 26,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_KNIFE_2 = {
        name = "WEAPON_KNIFE_2",
        damage = 30,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_KNIFE_3 = {
        name = "WEAPON_KNIFE_3",
        damage = 33,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    -- Dagger
    WEAPON_DAGGER = {
        name = "WEAPON_DAGGER",
        damage = 26,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_DAGGER_2 = {
        name = "WEAPON_DAGGER_2",
        damage = 30,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_DAGGER_3 = {
        name = "WEAPON_DAGGER_3",
        damage = 33,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    -- Poolcue
    WEAPON_POOLCUE = {
        name = "WEAPON_POOLCUE",
        damage = 18,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_POOLCUE_2 = {
        name = "WEAPON_POOLCUE_2",
        damage = 21,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_POOLCUE_3 = {
        name = "WEAPON_POOLCUE_3",
        damage = 23,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    -- Revolver
    WEAPON_REVOLVER = {
        name = "WEAPON_REVOLVER",
        damage = 1,
        hash = nil,
        block_instant_kill = true,
        block_hit = false,
        hasEffect = true,
        doEffect = function(isHeadshot, hashWeapon)
            local ped = PlayerPedId()
            local pedInVeh = GetPlayerPed(-1)
            local car = IsPedInAnyVehicle(pedInVeh, false)
            if car then
                local entity =  GetVehiclePedIsUsing(pedInVeh)
                if GetEntitySpeed(entity) < 15.0 then
                    TaskLeaveVehicle(ped,entity,0)
                    Wait(1)
                    SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
                end
            end
            if not effectActive and not isHeadshot then
                Citizen.CreateThread(function()
                    effectActive = true
                    for i = 1, 10 do
                        SetTimecycleModifierStrength(1.0)
                        SetTimecycleModifier("BeastIntro02")
                        SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
                        Citizen.Wait(500)
                    end
                    SetTimecycleModifierStrength(0.0)
                    SetTimecycleModifier("default")
                    effectActive = false
                end)
            end
            if not effectActive and isHeadshot then
                Citizen.CreateThread(function()
                    effectActive = true
                    for i = 1, 14 do
                        SetTimecycleModifierStrength(1.0)
                        SetTimecycleModifier("BeastIntro02")
                        SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
                        Citizen.Wait(500)
                    end
                    SetTimecycleModifierStrength(0.0)
                    SetTimecycleModifier("default")
                    effectActive = false
                end)
            end
        end,
        headshot_dead = false,
        disable_critical_hit = true
    },
    WEAPON_REVOLVER_MK2 = {
        name = "WEAPON_REVOLVER_MK2",
        damage = 1,
        hash = nil,
        block_instant_kill = true,
        block_hit = false,
        hasEffect = true,
        doEffect = function(isHeadshot, hashWeapon)
            local ped = PlayerPedId()
            local pedInVeh = GetPlayerPed(-1)
            local car = IsPedInAnyVehicle(pedInVeh, false)
            if car then
                local entity =  GetVehiclePedIsUsing(pedInVeh)
                if GetEntitySpeed(entity) < 15.0 then
                    TaskLeaveVehicle(ped,entity,0)
                    Wait(1)
                    SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
                end
            end
            if not effectActive and not isHeadshot then
                Citizen.CreateThread(function()
                    effectActive = true
                    for i = 1, 10 do
                        SetTimecycleModifierStrength(1.0)
                        SetTimecycleModifier("BeastIntro02")
                        SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
                        Citizen.Wait(500)
                    end
                    SetTimecycleModifierStrength(0.0)
                    SetTimecycleModifier("default")
                    effectActive = false
                end)
            end
            if not effectActive and isHeadshot then
                Citizen.CreateThread(function()
                    effectActive = true
                    for i = 1, 14 do
                        SetTimecycleModifierStrength(1.0)
                        SetTimecycleModifier("BeastIntro02")
                        SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
                        Citizen.Wait(500)
                    end
                    SetTimecycleModifierStrength(0.0)
                    SetTimecycleModifier("default")
                    effectActive = false
                end)
            end
        end,
        headshot_dead = false,
        disable_critical_hit = true
    },
    -- WEAPON_REVOLVER_MK3 = {
    --     name = "WEAPON_REVOLVER_MK3",
    --     damage = 1,
    --     hash = nil,
    --     block_instant_kill = true,
    --     block_hit = false,
    --     hasEffect = true,
    --     doEffect = function(isHeadshot, hashWeapon)
    --         local ped = PlayerPedId()
    --         local pedInVeh = GetPlayerPed(-1)
    --         local car = IsPedInAnyVehicle(pedInVeh, false)
    --         if car then
    --             local entity =  GetVehiclePedIsUsing(pedInVeh)
    --             if GetEntitySpeed(entity) < 15.0 then
    --                 TaskLeaveVehicle(ped,entity,0)
    --                 Wait(1)
    --                 SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
    --             end
    --         end
    --         if not effectActive and not isHeadshot then
    --             Citizen.CreateThread(function()
    --                 effectActive = true
    --                 for i = 1, 10 do
    --                     SetTimecycleModifierStrength(1.0)
    --                     SetTimecycleModifier("BeastIntro02")
    --                     SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
    --                     Citizen.Wait(500)
    --                 end
    --                 SetTimecycleModifierStrength(0.0)
    --                 SetTimecycleModifier("default")
    --                 effectActive = false
    --             end)
    --         end
    --         if not effectActive and isHeadshot then
    --             Citizen.CreateThread(function()
    --                 effectActive = true
    --                 for i = 1, 14 do
    --                     SetTimecycleModifierStrength(1.0)
    --                     SetTimecycleModifier("BeastIntro02")
    --                     SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
    --                     Citizen.Wait(500)
    --                 end
    --                 SetTimecycleModifierStrength(0.0)
    --                 SetTimecycleModifier("default")
    --                 effectActive = false
    --             end)
    --         end
    --     end,
    --     headshot_dead = false,
    --     disable_critical_hit = true
    -- },
    -- WEAPON_REVOLVER_MK2 = {
    --     name = "WEAPON_REVOLVER_MK2",
    --     damage = 1,
    --     hash = nil,
    --     block_instant_kill = true,
    --     block_hit = false,
    --     hasEffect = true,
    --     doEffect = function(isHeadshot, hashWeapon)
    --         local ped = PlayerPedId()
    --         if not effectActive and not isHeadshot then
    --             Citizen.CreateThread(function()
    --                 effectActive = true
    --                 for i = 1, 10 do
    --                     SetTimecycleModifierStrength(1.0)
    --                     SetTimecycleModifier("BeastIntro02")
    --                     SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
    --                     Citizen.Wait(500)
    --                 end
    --                 local co = GetEntityCoords(ped)
    --                 local fw = Fwv(ped)
    --                 SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
    --                 SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
    --                 Citizen.Wait(1)
    --                 SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
    --                 SetTimecycleModifierStrength(0.0)
    --                 SetTimecycleModifier("default")
    --                 effectActive = false
    --             end)
    --         end
    --         if not effectActive and isHeadshot then
    --             Citizen.CreateThread(function()
    --                 effectActive = true
    --                 for i = 1, 14 do
    --                     SetTimecycleModifierStrength(1.0)
    --                     SetTimecycleModifier("BeastIntro02")
    --                     SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
    --                     Citizen.Wait(500)
    --                 end
    --                 SetTimecycleModifierStrength(0.0)
    --                 SetTimecycleModifier("default")
    --                 effectActive = false
    --             end)
    --         end
    --     end,
    --     headshot_dead = false,
    --     disable_critical_hit = true
    -- },
    -- WEAPON_POOLCUE_PUNK = {
    --     name = "WEAPON_POOLCUE_PUNK",
    --     damage = 26,
    --     hash = nil,
    --     block_instant_kill = false,
    --     block_hit = false,
    --     hasEffect = false,
    --     doEffect = function(isHeadshot, hashWeapon)
    --         local ped = PlayerPedId()
    --         local percent = 0.5
    --         local randPer = math.random(1, 100000)/100000
    --         if randPer < percent then
    --             ApplyDamageToPed(ped,math.ceil(Config.weaponHash[hashWeapon].damage)-1, true)
    --         end
    --     end,
    --     headshot_dead = false,
    --     disable_critical_hit = false
    -- },

    -- Police
    WEAPON_NIGHTSTICK = {
        name = "WEAPON_NIGHTSTICK",
        damage = 45,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_STUNGUN = {
        name = "WEAPON_STUNGUN",
        damage = 0.000001,
        hash = nil,
        block_instant_kill = true,
        block_hit = false,
        hasEffect = true,
        doEffect = function(isHeadshot, hashWeapon)
            local ped = PlayerPedId()
            if not effectActive and not isHeadshot then
                Citizen.CreateThread(function()
                    effectActive = true
                    for i = 1, 15 do
                        SetTimecycleModifierStrength(1.0)
                        SetTimecycleModifier("BeastIntro02")
                        SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
                        Citizen.Wait(500)
                    end
                    SetTimecycleModifierStrength(0.0)
                    SetTimecycleModifier("default")
                    effectActive = false
                end)
            end
            if not effectActive and isHeadshot then
                Citizen.CreateThread(function()
                    effectActive = true
                    for i = 1, 20 do
                        SetTimecycleModifierStrength(1.0)
                        SetTimecycleModifier("BeastIntro02")
                        SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
                        Citizen.Wait(500)
                    end
                    SetTimecycleModifierStrength(0.0)
                    SetTimecycleModifier("default")
                    effectActive = false
                end)
            end
        end,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_PUMPSHOTGUN = {
        name = "WEAPON_PUMPSHOTGUN",
        damage = 0,
        hash = nil,
        block_instant_kill = true,
        block_hit = false,
        hasEffect = true,
        doEffect = function(isHeadshot, hashWeapon)
            local ped = PlayerPedId()
            if not effectActive and not isHeadshot then
                Citizen.CreateThread(function()
                    effectActive = true
                    for i = 1, 8 do
                        SetTimecycleModifierStrength(1.0)
                        SetTimecycleModifier("BeastIntro02")
                        SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
                        Citizen.Wait(500)
                    end
                    SetTimecycleModifierStrength(0.0)
                    SetTimecycleModifier("default")
                    effectActive = false
                end)
            end
            if not effectActive and isHeadshot then
                Citizen.CreateThread(function()
                    effectActive = true
                    for i = 1, 12 do
                        SetTimecycleModifierStrength(1.0)
                        SetTimecycleModifier("BeastIntro02")
                        SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
                        Citizen.Wait(500)
                    end
                    SetTimecycleModifierStrength(0.0)
                    SetTimecycleModifier("default")
                    effectActive = false
                end)
            end
        end,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_BOTTLE_SOS = {
        name = "WEAPON_BOTTLE_SOS",
        damage = 23,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_SNIPERRIFLE = {
        name = "WEAPON_SNIPERRIFLE",
        damage = 1,
        hash = nil,
        block_instant_kill = true,
        block_hit = false,
        hasEffect = true,
        doEffect = function(isHeadshot, hashWeapon)
            local ped = PlayerPedId()
            local pedInVeh = GetPlayerPed(-1)
            local car = IsPedInAnyVehicle(pedInVeh, false)
            if car then
                local entity =  GetVehiclePedIsUsing(pedInVeh)
                if GetEntitySpeed(entity) < 15.0 then
                    TaskLeaveVehicle(ped,entity,0)
                    Wait(1)
                    SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
                end
            end
            if not effectActive and not isHeadshot then
                Citizen.CreateThread(function()
                    effectActive = true
                    for i = 1, 10 do
                        SetTimecycleModifierStrength(1.0)
                        SetTimecycleModifier("BeastIntro02")
                        SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
                        Citizen.Wait(500)
                    end
                    SetTimecycleModifierStrength(0.0)
                    SetTimecycleModifier("default")
                    effectActive = false
                end)
            end
            if not effectActive and isHeadshot then
                Citizen.CreateThread(function()
                    effectActive = true
                    for i = 1, 14 do
                        SetTimecycleModifierStrength(1.0)
                        SetTimecycleModifier("BeastIntro02")
                        SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
                        Citizen.Wait(500)
                    end
                    SetTimecycleModifierStrength(0.0)
                    SetTimecycleModifier("default")
                    effectActive = false
                end)
            end
        end,
        headshot_dead = false,
        disable_critical_hit = true
    },
    WEAPON_SNOWBALL = {
        name = "WEAPON_SNOWBALL",
        damage = 1,
        hash = nil,
        block_instant_kill = true,
        block_hit = false,
        hasEffect = true,
        doEffect = function(isHeadshot, hashWeapon)
            local ped = PlayerPedId()
            if not effectActive and not isHeadshot then
                return
            end
            if not effectActive and isHeadshot then
                ApplyDamageToPed(ped,math.ceil(4)-1, true)
                Citizen.CreateThread(function()
                    effectActive = true
                    for i = 1, 4 do
                        SetTimecycleModifierStrength(1.0)
                        SetTimecycleModifier("BeastIntro02")
                        SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
                        Citizen.Wait(500)
                    end
                    SetTimecycleModifierStrength(0.0)
                    SetTimecycleModifier("default")
                    effectActive = false
                end)
            end
        end,
        headshot_dead = false,
        disable_critical_hit = false
    },

    --thief
    WEAPON_CROWBAR = {
        name = "WEAPON_CROWBAR",
        damage = 1,
        hash = nil,
        block_instant_kill = true,
        block_hit = true,
        headshot_dead = false,
        disable_critical_hit = false
    },
    --admin
    WEAPON_GRENADE = {
        name = "WEAPON_GRENADE",
        damage = 5,
        hash = nil,
        block_instant_kill = true,
        block_hit = false,
        hasEffect = true,
        doEffect = function(isHeadshot, hashWeapon)
            local ped = PlayerPedId()
            if not effectActive  then
                Citizen.CreateThread(function()
                    effectActive = true
                    for i = 1, 10 do
                        SetTimecycleModifierStrength(1.0)
                        SetTimecycleModifier("BeastIntro02")
                        SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
                        Citizen.Wait(500)
                    end
                    SetTimecycleModifierStrength(0.0)
                    SetTimecycleModifier("default")
                    effectActive = false
                end)
            end
        end,
        headshot_dead = false,
        disable_critical_hit = false
    },
    WEAPON_COMPACTLAUNCHER = {
        name = "WEAPON_COMPACTLAUNCHER",
        damage = 1,
        hash = nil,
        block_instant_kill = true,
        block_hit = false,
        hasEffect = true,
        doEffect = function(isHeadshot, hashWeapon)
            local ped = PlayerPedId()
            if not effectActive  then
                Citizen.CreateThread(function()
                    effectActive = true
                    for i = 1, 10 do
                        SetTimecycleModifierStrength(1.0)
                        SetTimecycleModifier("BeastIntro02")
                        SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
                        Citizen.Wait(500)
                    end
                    SetTimecycleModifierStrength(0.0)
                    SetTimecycleModifier("default")
                    effectActive = false
                end)
            end
        end,
        headshot_dead = false,
        disable_critical_hit = false
    },

    -- Arena
    R_WEAPON_BOTTLE = {
        name = "R_WEAPON_BOTTLE",
        damage = 24,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    R_WEAPON_POOLCUE = {
        name = "R_WEAPON_POOLCUE",
        damage = 21,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    R_WEAPON_BAT = {
        name = "R_WEAPON_BAT",
        damage = 15,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    R_WEAPON_GOLFCLUB = {
        name = "R_WEAPON_GOLFCLUB",
        damage = 15,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    R_WEAPON_MACHETE = {
        name = "R_WEAPON_MACHETE",
        damage = 29,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    R_WEAPON_KNIFE = {
        name = "R_WEAPON_KNIFE",
        damage = 33,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    R_WEAPON_KNUCKLE = {
        name = "R_WEAPON_KNUCKLE",
        damage = 11,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },
    R_WEAPON_DAGGER = {
        name = "R_WEAPON_DAGGER",
        damage = 33,
        hash = nil,
        block_instant_kill = false,
        block_hit = false,
        headshot_dead = false,
        disable_critical_hit = false
    },

    -- t1
    T1_WEAPON_POOLCUE = {
        name = "T1_WEAPON_POOLCUE",
        damage = 26,
        hash = nil,
        block_instant_kill = false,
        block_hit = true,
        hasEffect = false,
        doEffect = function(isHeadshot, hashWeapon)
            local ped = PlayerPedId()
            local percent = 0.5
            local randPer = math.random(1, 100000)/100000
            if randPer < percent then
                ApplyDamageToPed(ped,math.ceil(Config.weaponHash[hashWeapon].damage)-1, true)
            end
        end,
        headshot_dead = false,
        disable_critical_hit = false
    },
    T1_WEAPON_BOTTLE = {
        name = "T1_WEAPON_BOTTLE",
        damage = 25,
        hash = nil,
        block_instant_kill = false,
        block_hit = true,
        headshot_dead = false,
        disable_critical_hit = false
    },
    T1_WEAPON_KNUCKLE = {
        name = "T1_WEAPON_KNUCKLE",
        damage = 9,
        hash = nil,
        block_instant_kill = false,
        block_hit = true,
        headshot_dead = false,
        disable_critical_hit = false
    },
    T1_WEAPON_MACHETE = {
        name = "T1_WEAPON_MACHETE",
        damage = 21,
        hash = nil,
        block_instant_kill = false,
        block_hit = true,
        headshot_dead = false,
        disable_critical_hit = false
    },

    -- Hunting
    -- WEAPON_MUSKET = {
    --     name = "WEAPON_MUSKET",
    --     damage = 10,
    --     hash = nil,
    --     block_instant_kill = true,
    --     block_hit = false,
    --     headshot_dead = false,
    --     disable_critical_hit = false
    -- },
}

Config.weaponHash = {}


Citizen.CreateThread(function()
    for _,v in pairs(Config.weaponList) do
        local weaponHash = GetHashKey(v.name)
        --print(v.name)
        --print(weaponHash)
        v.hash = weaponHash
        Config.weaponHash[weaponHash] = {
            damage = v.damage,
            block_instant_kill = v.block_instant_kill,
            headshot_dead = v.headshot_dead,
            hasEffect = v.hasEffect,
            name = v.name,
            disable_critical_hit = v.disable_critical_hit
        }
        SetWeaponDamageModifier(weaponHash,0.0001)
        ::continue::
    end
end)

AddEventHandler('gameEventTriggered', function (name, args)
    --print(Config.weaponHash[args[7]].name)
    --print(args[7])
    if not exports.cc_armor:isHelmetOn() then
        if type(Config.weaponHash[args[7]]) ~= "nil" then
            if  Config.weaponHash[args[7]].disable_critical_hit then
                SetPedSuffersCriticalHits(GetPlayerPed(-1), false)
            end

            if not Config.weaponHash[args[7]].headshot_dead and not Config.weaponHash[args[7]].disable_critical_hit  then
                SetPedSuffersCriticalHits(GetPlayerPed(-1), true)
            end

            if not Config.weaponHash[args[7]].disable_critical_hit then
                SetPedSuffersCriticalHits(GetPlayerPed(-1), true)
            end
        end
    end

    if name == "CEventNetworkEntityDamage" and args[1] ~= 514 and args[4] ~= 1 then -- and GetPedType(args[1]) ~= 0
        if Config.weaponHash[args[7]] == nil then return end
        if not IsEntityDead(args[1]) then
            if HasEntityBeenDamagedByWeapon(args[1], args[7], 0) then
                local boneHit, whatBone = GetPedLastDamageBone(args[1])
                if boneHit then
                    if whatBone == 31086 and Config.weaponHash[args[7]].headshot_dead then
                        if not IsEntityDead(args[1]) then
                            ApplyDamageToPed(args[1],math.ceil(250)-1, true)
                            clearEntity(args[1],args[7])
                        end
                    end
                end

                if boneHit then
                    if exports.cc_armor:isHelmetOn() and whatBone == 31086 and args[1] == PlayerPedId() then
                        exports.cc_armor:helmetBroken()
                        return
                    end
                end

                if Config.weaponHash[args[7]].hasEffect and args[1] == PlayerPedId() then
                    local isHeadshot = whatBone == 31086
                    Config.weaponList[Config.weaponHash[args[7]].name].doEffect(isHeadshot, args[7])
                    --applyEffect(Config.weaponHash[args[7]].name,args[1])
                end

                ApplyDamageToPed(args[1],math.ceil(Config.weaponHash[args[7]].damage)-1, true) -- Config.Weaponlis
                clearEntity(args[1],args[7])
            end
        end
    end
end)

function clearEntity(ped,hash)
    local heathly = GetEntityHealth(ped)
    if (heathly - math.ceil(Config.weaponHash[hash].damage)) > 0 then
        ClearEntityLastDamageEntity(ped)
    end
end
-- Configuration
Config.PedAbleToWalkWhileSwapping = true
Config.UnarmedHash = -1569615261
local animDict = 'reaction@intimidation@1h'
local animFlag = 0
local lastWeapon = nil
local GetPlayerPed = GetPlayerPed
local IsPedInAnyVehicle = IsPedInAnyVehicle
local GetSelectedPedWeapon = GetSelectedPedWeapon
local DisableControlAction = DisableControlAction
local DisablePlayerFiring = DisablePlayerFiring
local GetGameTimer = GetGameTimer
local IsControlPressed = IsControlPressed
local isBlocking = false
local blockUntil = 0

Citizen.CreateThread(function()
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
end)

Citizen.CreateThread(function()

    while true do
        local sleep = 1500
        local playerPed = GetPlayerPed(-1)

        if GetPedParachuteState(playerPed) == 0 then
            TriggerServerEvent('removePara')
        end
        if not IsPedInAnyVehicle(playerPed, true) then
            animFlag = Config.PedAbleToWalkWhileSwapping and 48 or 0
            local currentWeapon = GetSelectedPedWeapon(playerPed)

            for _, weapon in pairs(Config.weaponList) do
                if currentWeapon == weapon.hash then
                    if weapon.block_instant_kill or weapon.block_hit then
                        DisableControlAction(1, 140, true)
                        DisableControlAction(1, 141, true)
                        DisableControlAction(1, 142, true)
                        sleep = 0
                    end

                    if weapon.block_hit then
                        DisablePlayerFiring(PlayerPedId(), true)
                        break
                    end
                end
            end
        end

        lastWeapon = GetSelectedPedWeapon(playerPed)
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        --SetPedSuffersCriticalHits(GetPlayerPed(-1), false)
        DisableControlAction(0, 36, true) -- บล็อกปุ่ม ctrl สำหรับเข้าโหมดรอบสังหาร ทดสอบแล้วย้ายปุ่มก็กดไม่ได้
    end
end)
-- Control Blocking Thread
Citizen.CreateThread(function()
    while true do
        local currentTime = GetGameTimer()
        DisableControlAction(0, 36, true)

        if isBlocking and currentTime >= blockUntil then
            isBlocking = false
        end

        if IsControlPressed(0, 22) and not isBlocking and HoldCheck(22, 5000) then
            onHoldPressed()
            isBlocking = true
            blockUntil = currentTime + 6000
        end

        if isBlocking then
            DisablePlayerFiring(PlayerId(), true) -- Disable weapon firing
            DisableControlAction(0, 24, true) -- disable attack
            DisableControlAction(0, 25, true) -- disable aim
            DisableControlAction(1, 37, true) -- disable weapon select
            DisableControlAction(0, 47, true) -- disable weapon
            DisableControlAction(0, 58, true) -- disable weapon
            DisableControlAction(0, 140, true) -- disable melee
            DisableControlAction(0, 141, true) -- disable melee
            DisableControlAction(0, 142, true) -- disable melee
            DisableControlAction(0, 143, true) -- disable melee
            DisableControlAction(0, 263, true) -- disable melee
            DisableControlAction(0, 264, true) -- disable melee
            DisableControlAction(0, 257, true) -- disable melee
        end

        Citizen.Wait(0) -- Necessary to prevent freezing, but placed at the end of the loop for efficiency
    end
end)


function HoldCheck(control, duration)
    local startTime = GetGameTimer()
    while IsControlPressed(0, control) and GetGameTimer() - startTime < duration do
        Citizen.Wait(0)
    end
    return GetGameTimer() - startTime >= duration
end

function onHoldPressed()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบป้องกัน', -- หัวเรื่อง
        description = 'รำไปทำไมรำเพื่ออะไร', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'detail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end
