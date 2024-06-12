local oldprop = ''
local onEvent = false
local onGame = false
local team = ''
local location = {}
local Freeze = false
local isDead = false
local oldposition
local gameList = {}

local list = ESX.GetWeaponList()
for i=1, #list, 1 do
    print(list[i].name .. ' => ' .. list[i].label)
end

Citizen.CreateThread(function()


    while true do
        local nearby = false
        local dstCheck = nil
        local sleep = 0

        (function()
            if onGame and team == 'prop'  and not isDead then
                DisableControlAction(0,24,true)
                DisableControlAction(0,47,true)
                DisableControlAction(0,58,true)
                DisableControlAction(0,263,true)
                DisableControlAction(0,264,true)
                DisableControlAction(0,257,true)
                DisableControlAction(0,140,true)
                DisableControlAction(0,141,true)
                DisableControlAction(0,142,true)
                DisableControlAction(0,143,true)

                if IsControlJustPressed(0, Config.Key.Prop.transform) then
                    local hit, coords, entity = RayCastGamePlayCamera(20.0)

                    if hit == 1 and GetEntityType(entity) == 3   then
                        if not has_value(gameList.BlacklistProp,GetEntityModel(entity))  then
                            if not checkprop then
                                SendNUIMessage({
                                    action = 'useprop'
                                })

                                checkprop = true

                                local ped = GetPlayerPed(-1)

                                SetEntityVisible(ped,0,0)

                                local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
                                local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetEntityModel(entity), false, false, false)

                                if object ~= 0 then
                                    DeleteObject(object)
                                end

                                local x,y,z = table.unpack(GetEntityCoords(ped))
                                local coordZ = GetCoordZ(position.x, position.y, gameList.map.CheckHeight)
                                local prop = CreateObject(GetEntityModel(entity), x, y, coordZ, true, true, true)
                                local boneIndex = GetPedBoneIndex(ped, 0x8245)
                                local zpos = coordZ  - z +0.0

                                AttachEntityToEntity(prop, ped, boneIndex, 0.0, 0.0, zpos, 0.0, 0.00,0.0, true, true, false, true, 1, true)

                                oldprop = GetEntityModel(entity)

                                SetEntityCompletelyDisableCollision(prop , false, true)
                            end
                        else
                            Config.ClientNotification(Config.Locale.Notification.blacklist_prop, 'error')
                        end
                    end
                end

                if IsControlJustPressed(0, Config.Key.Prop.cancel_transform) then


                    SendNUIMessage({
                        action = 'canprop'
                    })

                    local ped = GetPlayerPed(-1)

                    SetEntityVisible(ped,1,0)

                    local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
                    local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, oldprop, false, false, false)

                    if object ~= 0 then
                        DeleteObject(object)
                    end

                    local x,y,z = table.unpack(GetEntityCoords(ped))
                    local prop = CreateObject(oldprop, x, y, z + 0.2, true, true, true)
                    local boneIndex = GetPedBoneIndex(ped, 0x8245)

                    AttachEntityToEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
                    ClearPedTasks(ped)

                    checkprop = false

                    DetachEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
                    DeleteObject(prop)

                    oldprop = ''

                end

                if IsControlJustPressed(0, Config.Key.Prop.freeze) then
                    if not Freeze then
                        Freeze = true
                        FreezeEntityPosition( GetPlayerPed(-1),true,true)
                        SendNUIMessage({
                            action = 'fprop'
                        })
                    else
                        Freeze = false
                        FreezeEntityPosition( GetPlayerPed(-1),false,false)
                        SendNUIMessage({
                            action = 'uprop'
                        })
                    end
                end
            elseif onGame and team == 'hunter' then
                if IsControlJustPressed(0, 24) then
                    frie = true
                    Wait(100)

                    if frie then
                        local health = GetEntityHealth(PlayerPedId()) - Config.MissingShot
                        SetEntityHealth(PlayerPedId(), health)
                    end
                end
            else
                Wait(1000)
            end
        end)()

        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        local nearby = false
        local dstCheck = nil
        local sleep = 0

        (function()

            if onEvent then
                sleep = 0

                if isBusy then return end

                if IsControlJustPressed(0, Config.Key.JoinEvent) then
                    isBusy = true

                    ESX.TriggerServerCallback('tg_prophunt:RequestForjoin', function(cbData)
                        if cbData then
                            oldposition = GetEntityCoords(GetPlayerPed(-1))

                            Config.ClientNotification(Config.Locale.Notification.event_joined, 'success')

                            SendNUIMessage({
                                action = 'hidepush'
                            })
                        else
                            Config.ClientNotification(Config.Locale.Notification.event_player_full, 'error')
                        end
                    end)
                end
            else
                sleep = 1000
            end
        end)()

        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent('tg_prophunt:startEvent')
AddEventHandler('tg_prophunt:startEvent', function(data)
    location = data.map
    isBusy = false
    onEvent = true

    SendNUIMessage({
        action = 'start',
        data = data
    })
end)

RegisterNetEvent('tg_prophunt:notjoin')
AddEventHandler('tg_prophunt:notjoin', function()
    onEvent = false
end)



RegisterNetEvent('tg_prophunt:startEvent2')
AddEventHandler('tg_prophunt:startEvent2', function(data,a,b,c)
    onEvent = false
    isBusy = false
    gameList = data
    onGame  = true

    FreezeEntityPosition(PlayerPedId(), false)


    local ped = GetPlayerPed(-1)

    SetEntityVisible(ped,1,0)

    local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, oldprop, false, false, false)

    if object ~= 0 then
        DeleteObject(object)
    end

    local x,y,z = table.unpack(GetEntityCoords(ped))
    local prop = CreateObject(oldprop, x, y, z + 0.2, true, true, true)
    local boneIndex = GetPedBoneIndex(ped, 0x8245)

    AttachEntityToEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
    ClearPedTasks(ped)

    checkprop = false

    DetachEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
    DeleteObject(prop)

    oldprop = ''


    SendNUIMessage({
        action = 'start2',
        data = data,
        round = c
    })

    SendNUIMessage({
        action = 'updateplayerteam',
        hunter = a,
        prop = b
    })

    exports.nc_inventory:DisableShortcuts()
    SetCurrentPedWeapon(PlayerPedId(), 'WEAPON_UNARMED', true)
    RemoveWeaponFromPed(PlayerPedId(), gameList.Gameplay.hunter_weapon)

    if isDead then
        TriggerEvent(Config.EventRoute.Revive)

        if Config.Debug then
            print('^5DEBUG : ^0Trigger to event > ' .. Config.EventRoute.Revive)
        end

        isDead = false
    end

    if team == 'prop' then
        SendNUIMessage({
            action = 'showeye'
        })

        SetEntityCoords(PlayerPedId(),gameList.map.PropSpawner)

        if Config.Debug then
            print('^5DEBUG : ^0Set coords > ' .. gameList.map.PropSpawner)
        end

        Wait(Config.HealWait * 1000)

        TriggerEvent(Config.EventRoute.Heal)

        if Config.Debug then
            print('^5DEBUG : ^0Trigger to event > ' .. Config.EventRoute.Heal)
        end
    elseif team == 'hunter' then
        SendNUIMessage({
            action = 'specte'
        })

        SetEntityCoords(PlayerPedId(),gameList.map.HunterSpawner)

        if Config.Debug then
            print('^5DEBUG : ^0Set coords > ' .. gameList.map.HunterSpawner)
        end

        Wait(Config.HealWait * 1000)

        TriggerEvent(Config.EventRoute.Heal)

        if Config.Debug then
            print('^5DEBUG : ^0Trigger to event > ' .. Config.EventRoute.Heal)
        end

        SendNUIMessage({
            action = 'hide'
        })
        FreezeEntityPosition(PlayerPedId(), true)

        FreezeEntityPosition(PlayerPedId(), false)
        GiveWeaponToPed(PlayerPedId(), gameList.Gameplay.hunter_weapon ,gameList.Gameplay.hunter_weapon_ammo, false , true )
        SetCurrentPedWeapon(PlayerPedId(), gameList.Gameplay.hunter_weapon, true)
    end
end)

RegisterNetEvent('tg_prophunt:updateAmountPlayer')
AddEventHandler('tg_prophunt:updateAmountPlayer', function(a,b)
    SendNUIMessage({
        action = 'updateplayerteam',
        hunter = b,
        prop = a
    })
end)

RegisterNetEvent('updateplayer')
AddEventHandler('updateplayer', function(player,limit)
    SendNUIMessage({
        action = 'updateplayer',
        player = player,
        limit = limit
    })
end)

local winteam = ''

RegisterNetEvent('tg_prophunt:playerSetTeam')
AddEventHandler('tg_prophunt:playerSetTeam', function(teams)
    team = teams
end)

RegisterNetEvent('tg_prophunt:endGameDeath')
AddEventHandler('tg_prophunt:endGameDeath', function(teams,nextgame)
    if isDead then
        TriggerEvent(Config.EventRoute.Revive)
        if Config.Debug then
            print('^5DEBUG : ^0Trigger to event > ' .. Config.EventRoute.Revive)
        end

        isDead = false
    end

    SendNUIMessage({
        action = 'nothide'
    })
    NetworkSetInSpectatorMode(false, spectateped)
    FreezeEntityPosition(PlayerPedId(), false)
    SetCurrentPedWeapon(PlayerPedId(), 'WEAPON_UNARMED', true)
    RemoveWeaponFromPed(PlayerPedId(), gameList.Gameplay.hunter_weapon)
    spectate = false
    onGame = false
    winteam = teams


    local ped = GetPlayerPed(-1)

    SetEntityVisible(ped,1,0)

    local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, oldprop, false, false, false)

    if object ~= 0 then
        DeleteObject(object)
    end

    local x,y,z = table.unpack(GetEntityCoords(ped))
    local prop = CreateObject(oldprop, x, y, z + 0.2, true, true, true)
    local boneIndex = GetPedBoneIndex(ped, 0x8245)

    AttachEntityToEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
    ClearPedTasks(ped)

    checkprop = false

    DetachEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
    DeleteObject(prop)

    oldprop = ''


    SendNUIMessage({
        action = 'specte'
    })

    if nextgame then
        if team == 'prop' then
            SetEntityCoords(PlayerPedId(),gameList.map.PropSpawner)

            if Config.Debug then
                print('^5DEBUG : ^0Set coords > ' .. gameList.map.PropSpawner)
            end
        elseif team == 'hunter' then
            SetEntityCoords(PlayerPedId(),gameList.map.HunterSpawner)

            if Config.Debug then
                print('^5DEBUG : ^0Set coords > ' .. gameList.map.HunterSpawner)
            end
        end

        SendNUIMessage({
            action = 'nextgame',
            data = gameList
        })
    else
        SendNUIMessage({
            action = 'endgame'
        })

        exports.nc_inventory:EnableShortcuts()
        RemoveWeaponFromPed(PlayerPedId(), gameList.Gameplay.hunter_weapon)
        onGame = false
        team = ''


        SetEntityCoords(PlayerPedId(),oldposition)

        if Config.Debug then
            print('^5DEBUG : ^0Set coords > ' .. oldposition)
        end
    end
end)

RegisterNetEvent('tg_prophunt:onEvent:cl')
AddEventHandler('tg_prophunt:onEvent:cl', function()




    Citizen.CreateThread(function()
        SetEntityHealth(PlayerPedId(), -1)
    end)
end)





RegisterNetEvent('tg_prophunt:nextround')
AddEventHandler('tg_prophunt:nextround', function()
    if isDead then

        TriggerEvent(Config.EventRoute.Revive)

        if Config.Debug then
            print('^5DEBUG : ^0Trigger to event > ' .. Config.EventRoute.Revive)
        end

        isDead = false
    end

    NetworkSetInSpectatorMode(false, spectateped)

    spectate = false
    onGame = false

    Wait(1000)

    FreezeEntityPosition(PlayerPedId(), false)



    local ped = GetPlayerPed(-1)

    SetEntityVisible(ped,1,0)

    local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, oldprop, false, false, false)

    if object ~= 0 then
        DeleteObject(object)
    end

    local x,y,z = table.unpack(GetEntityCoords(ped))
    local prop = CreateObject(oldprop, x, y, z + 0.2, true, true, true)
    local boneIndex = GetPedBoneIndex(ped, 0x8245)

    AttachEntityToEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
    ClearPedTasks(ped)

    checkprop = false

    DetachEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
    DeleteObject(prop)

    oldprop = ''


    if team == 'prop' then
        SetEntityCoords(PlayerPedId(),gameList.map.PropSpawner)

        if Config.Debug then
            print('^5DEBUG : ^0Set coords > ' .. gameList.map.PropSpawner)
        end
    elseif team == 'hunter' then
        SetEntityCoords(PlayerPedId(),gameList.map.HunterSpawner)

        if Config.Debug then
            print('^5DEBUG : ^0Set coords > ' .. gameList.map.HunterSpawner)
        end
    end
end)

local  frie

AddEventHandler("gameEventTriggered", function(eventName, eventArguments)
    if eventName == "CEventNetworkEntityDamage" then
        frie = false
    end
end)

RegisterNetEvent('tg_prophunt:seek')
AddEventHandler('tg_prophunt:seek', function()

    if team == 'hunter' then
        SendNUIMessage({
            action = 'nothide'
        })
    end
end)

RegisterNetEvent('tg_prophunt:setSpectate')
AddEventHandler('tg_prophunt:setSpectate', function(data)
    SendNUIMessage({
        action = 'spect'
    })

    spectate = true

    local indexkey = 1
    local spectlist = data

    Wait(1000)

    TriggerEvent(Config.EventRoute.Revive)

    Wait(1000)

    TriggerEvent(Config.EventRoute.Revive)

    if Config.Debug then
        print('^5DEBUG : ^0Trigger to event > ' .. Config.EventRoute.Revive)
    end

    while spectate do
        if IsControlJustReleased(0, Config.Key.Spectator.backward) then
            if indexkey == 1 then
                indexkey = #spectlist
            else
                indexkey = indexkey - 1
            end
        end

        if IsControlJustReleased(0, Config.Key.Spectator.forward) then
            if indexkey == #spectlist then
                indexkey = 1
            else
                indexkey = indexkey + 1
            end
        end

        local playerIdx = GetPlayerFromServerId(spectlist[indexkey])
        local ped = GetPlayerPed(playerIdx)

        positionped = GetEntityCoords(ped)
        spectateped = ped

        RequestCollisionAtCoord(positionped)
        NetworkSetInSpectatorMode(true, spectateped)

        cdspectate = false

        local cped = GetEntityCoords(spectateped)

        if cped.x == 0 and cped.y == 0 and cped.z == 0 then
            spectate = false

            RequestCollisionAtCoord(positionped)
            NetworkSetInSpectatorMode(false, spectateped)
            FreezeEntityPosition(PlayerPedId(), false)

            lastcoords = nil
            positionped = nil
            spectateped = nil
            cdspectate = false
        else
            SetEntityCoords(PlayerPedId(), cped.x, cped.y, cped.z - 10.0)
        end

        Wait(0)
    end
end)

AddEventHandler(Config.EventRoute.OnPlayerDeath, function(data)
    if not isDead then

        isDead = true
        ClearPedTasks(PlayerPedId())

        if Config.Debug then
            print('^5DEBUG : ^0Player Death = true')
        end

        if onGame and team ~= ""  then
            local player = PlayerPedId()




            local ped = GetPlayerPed(-1)

            SetEntityVisible(ped,1,0)

            local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
            local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, oldprop, false, false, false)

            if object ~= 0 then
                DeleteObject(object)
            end

            local x,y,z = table.unpack(GetEntityCoords(ped))
            local prop = CreateObject(oldprop, x, y, z + 0.2, true, true, true)
            local boneIndex = GetPedBoneIndex(ped, 0x8245)

            AttachEntityToEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
            ClearPedTasks(ped)

            checkprop = false

            DetachEntity(prop, ped, boneIndex, -0.59, -0.15, 0.00, 0.0, 90.00, 182.0, true, true, false, true, 1, true)
            DeleteObject(prop)

            oldprop = ''


            TriggerServerEvent('tg_prophunt:deletePlayerDeath',team)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        (function()
            if onGame then
                DrawMarker(1,location.Coords.x,location.Coords.y,location.Coords.z-1.0, 0.0, 0.0, 0.0, 0.0, 360.0, 0.0,location.Radius*2, location.Radius*2,
                        40.0, location.Marker.r, location.Marker.g, location.Marker.b, location.Marker.a, false, false, 2, false, false, false, false)
            end
        end)()
        Citizen.Wait( (onGame and 0) or 500)
    end
end)

local curlocation

Citizen.CreateThread(function()
    while true do
        (function()
            if onGame then
                local dist = #(GetEntityCoords(GetPlayerPed(-1)) - location.Coords)

                if dist <= location.Radius then
                    curlocation = GetEntityCoords(GetPlayerPed(-1))
                    Wait(1000)
                else
                    SetEntityCoords(PlayerPedId(),curlocation)
                end
            end
        end)()

        Citizen.Wait( (onGame and 0) or 100)
    end
end)

function IsPropHuntEvent()
    local data = onGame
    return data
end