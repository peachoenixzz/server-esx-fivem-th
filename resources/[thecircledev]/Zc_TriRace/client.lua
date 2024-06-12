ESX = nil
local delen = false
local alertarea = false
local spawnnewone = false
local Joined = false
local inputstunt = false
local addwing = false
local PlayerCheckPoint = 1
local endpoin = 0
local GameMode = 0
local GameStart = false
local StopRace = false
local InVeh = false
local IsEndding = false
local VehinGame = {}
local Veh2 = nil
local setwaypoint = false
local Beforestart = false
local JoinEventConfirm = false
local deny = false
local GM = nil
local freeze2 = false
local OX = false
local restart = false
local freeze = false
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    Citizen.Wait(2000)
    while not ESX.IsPlayerLoaded() do Wait(0) end
    TriggerServerEvent('sv_tokenevent_Triathlon')
    if Config2.PassiveOnGame then SetLocalPlayerAsGhost(false) end
end)




AddEventHandler('onResourceStop', function(resourceName)

    if (GetCurrentResourceName() ~= resourceName) then return end
    if GameStart then
        TriggerServerEvent("SwitchDimension", 0)
    end
end)

RegisterNetEvent("zcxTriathlon")
AddEventHandler("zcxTriathlon", function(tk)
    zcx = tk
end)

RegisterFontFile('sarabun')
fontId = RegisterFontId('sarabun')

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z + 0.5)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.5, 0.5)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)
    AddTextComponentString(text)
    DrawText(_x, _y)
end

function DrawHudText(text, colour, coordsx, coordsy, scalex, scaley, id)
    SetTextFont(id)
    SetTextProportional(7)
    SetTextScale(scalex, scaley)
    local colourr, colourg, colourb, coloura = table.unpack(colour)
    SetTextColour(colourr, colourg, colourb, coloura)
    SetTextDropshadow(0, 0, 0, 0, coloura)
    SetTextEdge(1, 0, 0, 0, coloura)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(coordsx, coordsy)
end

local sendbutton = false
local GameMode
local zcolor = 0
RegisterNetEvent('Dm_Triathlon:StartGamePhaseone')
AddEventHandler('Dm_Triathlon:StartGamePhaseone', function(MODE)
    GameMode = MODE
    GamemodeA = Config['Mode_' .. MODE]
    SendNUIMessage({type = 1, Detail = 'start'})
    TriggerEvent('Dm_Triathlon:Restart')
    TriggerServerEvent("SwitchDimension", 0)
    if Config2.Sound then
        SendNUIMessage({
            transactionType = 'playSound',
            transactionFile = Config2.Song,
            transactionVolume = Config2.Soundlevel
        })
    end

    Beforestart = true

    local TimetoJoin = Config['Mode_' .. MODE].CountDown
    JoinEventConfirm = false
    deny = false
    Joined = false

    Citizen.CreateThread(function()
        while Beforestart do
            if TimetoJoin > 0 then
                TimetoJoin = TimetoJoin - 1
                if not sendbutton then
                    SendNUIMessage({type = 1, Detail = 'run', time = TimetoJoin})
                end
            else
                SendNUIMessage({type = 1, Detail = 'end'})
                Beforestart = false
                sendbutton = false
                TriggerEvent('Dm_Triathlon:StartRaceGame', MODE, GameTime)

                zcolor = 0
            end
            Citizen.Wait(1000)
        end
    end)

    Citizen.CreateThread(function()
        while Beforestart do
            Sleep = 1000
            local PlayerCoords = GetEntityCoords(PlayerPedId())
            if TimetoJoin > 0 then

                Sleep = 5

                if not JoinEventConfirm and not deny and not sendbutton then

                    if IsControlJustReleased(0, 47) then

                        if not inzone then

                            StartScreenEffect("MinigameEndFranklin", 0, 0)
                            local rcoords = GetEntityCoords(PlayerPedId())
                            JoinEventConfirm = true
                            returncoords = rcoords

                            TriggerServerEvent('Dm_Triathlon:Isjoining', MODE)
                            SendNUIMessage({type = 1, Detail = 'end'})
                            sendbutton = true
                            if GamemodeA.FlyMode then

                                addwing = true
                                TriggerServerEvent('addwing')
                                TriggerEvent('wingtrue')
                            end
                            TriggerEvent("pNotify:SendNotification", {
                                text = " รอเวลาเข้าร่วมกิจกรรม",
                                type = "alert",
                                timeout = TimetoJoin * 1000,
                                layout = "CenterRight",
                                queue = "global"
                            })
                        else
                            TriggerEvent("pNotify:SendNotification", {
                                text = " โซนนี้ห้ามเล่นกิจกรรม",
                                type = "alert",
                                timeout = 5 * 1000,
                                layout = "CenterRight",
                                queue = "global"
                            })
                        end

                    end

                    if IsControlJustReleased(0, 73) then
                        deny = true
                        sendbutton = true
                        SendNUIMessage({type = 1, Detail = 'end'})
                        TriggerEvent("pNotify:SendNotification", {
                            text = " ปฎิเสธเข้าร่วมกิจกรรม",
                            type = "alert",
                            timeout = 5 * 1000,
                            layout = "CenterRight",
                            queue = "global"
                        })

                    end

                end

            end
            Citizen.Wait(Sleep)
        end
    end)
end)

RegisterNetEvent('Dm_Triathlon:SetPlayerJoined')
AddEventHandler('Dm_Triathlon:SetPlayerJoined', function() Joined = true end)

RegisterNetEvent('Dm_Triathlon:StartRaceGame')
AddEventHandler('Dm_Triathlon:StartRaceGame', function(MODE, GameTime)
    TriggerServerEvent("SwitchDimension", 0)
    local GameMode = Config['Mode_' .. MODE]
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    local CountGameTime1 = 0
    local CountGameTime2 = 0
    PlayerCheckPoint = 1
    GM = GameMode
    restart = false
    if Joined then
        GameStart = true
        FreezeEntityPosition(PlayerPedId(), true)
    end

    Citizen.Wait(100)
    if GameStart then
        TriggerServerEvent("SwitchDimension", 1)
        SwitchOutPlayer(PlayerPedId(), 0, 1)
        Citizen.Wait(2000)
        freeze = true
        FreezeEntityPosition(PlayerPedId(), true)
        Citizen.Wait(3000)

        SetEntityCoords(PlayerPedId(),
                        GameMode.StartPoint.x + math.random(0, 10),
                        GameMode.StartPoint.y + math.random(0, 10),
                        GameMode.StartPoint.z + 2)

        SwitchInPlayer(PlayerPedId())
        Citizen.Wait(10000)
        SendNUIMessage({
            transactionType = 'playSound',
            transactionFile = '5count',
            transactionVolume = 0.5
        })

        Citizen.Wait(5000)
        StartScreenEffect("MinigameEndFranklin", 0, 0)
        freeze = false
        FreezeEntityPosition(PlayerPedId(), false)
        if Config2.PassiveOnGame then SetLocalPlayerAsGhost(true) end

        SendNUIMessage({type = 2, Detail = 'start'})
        Citizen.CreateThread(function()
            local Ipoint = 0
            while GameStart do
                Sleepx = 1000
                if GameStart then
                    if Ipoint == 50 then
                        endpoin = GM.EndPoint
                        if not restart then
                            SendNUIMessage({
                                type = 2,
                                Detail = 'run',
                                time = CountGameTime1,
                                poin = PlayerCheckPoint - 1,
                                endpoin = endpoin

                            })
                        end
                        Ipoint = 0
                    end
                    Ipoint = Ipoint + 1
                    if PlayerCheckPoint <= GameMode.EndPoint then
                        local PlayerCoords = GetEntityCoords(PlayerPedId())
                        local CoordsPoint =
                            GameMode.CheckPoint['CheckPoint_' ..
                                PlayerCheckPoint]

                        if not setwaypoint then
                            SetNewWaypoint(CoordsPoint)
                            setwaypoint = true
                        end
                        if GetDistanceBetweenCoords(PlayerCoords, CoordsPoint.x,
                                                    CoordsPoint.y,
                                                    CoordsPoint.z, false) <
                            5000.0 then
                            Sleepx = 0

                            if GameMode.Marker == nil then
                                DrawMarker(4, CoordsPoint.x, CoordsPoint.y,
                                           CoordsPoint.z - 1, 0, 0, 0, 0, 0, 0,
                                           15.0, 0.1, 300.0, 102, 178, 255, 70,
                                           false, true, 2, false, false, false,
                                           false)
                            else
                                DrawMarker(GameMode.Marker.id, CoordsPoint.x,
                                           CoordsPoint.y, CoordsPoint.z - 1, 0,
                                           0, 0, 0, 0, 0,
                                           GameMode.Marker.scalex,
                                           GameMode.Marker.scaley,
                                           GameMode.Marker.scalez, 102, 178,
                                           255, 70, false, true, 2, false,
                                           false, false, false)
                            end

                            if Config['Mode_' .. MODE].Boost then
                                local SprintPoint =
                                    GameMode.SprintPoint['SprintPoint_' ..
                                        PlayerCheckPoint]
                                if SprintPoint ~= nil then

                                    if GetDistanceBetweenCoords(PlayerCoords,
                                                                SprintPoint.x,
                                                                SprintPoint.y,
                                                                SprintPoint.z,
                                                                false) < 2.5 then

                                        if IsPedInVehicle(PlayerPedId(),
                                                          vehicle2, true) then
                                            ApplyForceToEntity(vehicle2, true,
                                                               0.0, 1000.0, 2.5,
                                                               0.0, 0.0, 0.0,
                                                               false, true,
                                                               false, false,
                                                               false, true)
                                        end
                                    end
                                    DrawMarker(42, SprintPoint.x, SprintPoint.y,
                                               SprintPoint.z, 0, 0, 0, 0, 0, 0,
                                               2.0, 2.0, 2.0, 102, 178, 255, 70,
                                               false, true, 2, false, false,
                                               false, false)
                                end
                            end
                            if GameMode.FlyMode then
                                DrawMarker(28, CoordsPoint.x, CoordsPoint.y,
                                           CoordsPoint.z - 1, 0, 0, 0, 0, 0, 0,
                                           15.0, 0.1, 15.0, 255, 210, 60, 90,
                                           false, true, 2, false, false, false,
                                           false)
                            end

                            if GetDistanceBetweenCoords(PlayerCoords,
                                                        CoordsPoint.x,
                                                        CoordsPoint.y,
                                                        CoordsPoint.z, false) <
                                GameMode.MarkerDist then

                                PlayerCheckPoint = PlayerCheckPoint + 1
                                setwaypoint = false
                                StartScreenEffect("MinigameEndFranklin", 0, 0)
                                SendNUIMessage({
                                    transactionType = 'playSound',
                                    transactionFile = 'impact-6291',
                                    transactionVolume = 0.5
                                })
                                if not StopRace then

                                    if PlayerCheckPoint == GameMode.EndPoint + 1 then

                                        TriggerServerEvent(
                                            'Dm_Triathlon:GotWinner', MODE, zcx)

                                    end
                                end
                            end
                        end
                    end
                    PGT = CountGameTime1
                    PCP = PlayerCheckPoint
                end
                Citizen.Wait(Sleepx)
            end
        end)

        RegisterCommand("exit",
                        function() TriggerEvent('Dm_Triathlon:Restart') end)

        Citizen.CreateThread(function()
            while GameStart do
                Citizen.Wait(100)
                if not GameMode.FlyMode then
                    if IsControlPressed(0, 47) then
                        if not pressed then
                            pressed = true
                            if PlayerCheckPoint > 1 then

                                for k, v in pairs(VehinGame) do
                                    DeleteEntity(v)
                                end
                                SetEntityCoords(PlayerPedId(),
                                                GameMode.CheckPoint['CheckPoint_' ..
                                                    (PlayerCheckPoint - 1)])
                                for k, v in pairs(GameMode.SpawnVeh) do
                                    if PlayerCheckPoint > v.Point and
                                        PlayerCheckPoint <= v.DeletePoint then
                                        local Clearzone = 2.5

                                        InVeh = true
                                        TriggerEvent('Dm_Triathlon:SpawnVeh',
                                                     v.VehicleName,
                                                     v.DeletePoint, GameMode)

                                    end
                                end
                                Wait(1000)
                                pressed = false
                            end
                        end
                    end
                end
            end
        end)

        Citizen.CreateThread(function()
            while GameStart do
                Citizen.Wait(100)
                if GameStart then
                    CountGameTime2 = CountGameTime2 + 1
                    if CountGameTime2 == 10 then
                        CountGameTime1 = CountGameTime1 + 1
                        CountGameTime2 = 0
                    end
                    if PlayerCheckPoint == GameMode.EndPoint + 1 then

                        PlayerCheckPoint = PlayerCheckPoint + 1

                        Wait(1100)
                        SendNUIMessage({type = 1, Detail = 'end'})
                        TriggerEvent('Dm_Triathlon:Restart')

                        break
                    end
                end
            end
        end)

        Citizen.CreateThread(function()
            while GameStart do
                Citizen.Wait(5000)
                if GameStart then
                    local PlayerHealth = GetEntityHealth(PlayerPedId())
                    if PlayerHealth == 0 or IsPedDeadOrDying(PlayerPedId(), 1) and
                        not GameMode.FlyMode then
                        Citizen.Wait(5000)
                        SetEntityCoords(PlayerPedId(),
                                        GameMode.CheckPoint['CheckPoint_' ..
                                            (PlayerCheckPoint - 1)])
                        Citizen.Wait(500)
                        if IsEntityInWater(GetPlayerPed(-1)) then
                            local PlayerCoords = GetEntityCoords(PlayerPedId())
                            if PlayerCoords.z <= 0 then
                                SetEntityCoords(PlayerPedId(), PlayerCoords.x,
                                                PlayerCoords.y, 5.0)
                            else
                                SetEntityCoords(PlayerPedId(), PlayerCoords.x,
                                                PlayerCoords.y,
                                                PlayerCoords.z + 5)
                            end
                        end
                        Citizen.Wait(500)
                        TriggerEvent('esx_ambulancejob:revive', false)
                        Citizen.Wait(3000)
                        SetEntityHealth(PlayerPedId(), 200)
                    end
                end
            end
        end)

        Citizen.CreateThread(function()
            while GameStart do
                Citizen.Wait(1000)
                if GameStart then
                    if not InVeh then
                        if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                            local playerVehicle = GetVehiclePedIsIn(
                                                      GetPlayerPed(-1), false)
                            if not playerVehicle == Veh2 then
                                ClearPedTasksImmediately(PlayerPedId())
                                TriggerEvent("pNotify:SendNotification", {
                                    text = "ไม่ใช่รถของท่าน",
                                    type = "alert",
                                    timeout = TimetoJoin * 1000,
                                    layout = "CenterRight",
                                    queue = "global"
                                })
                            end
                        end
                    end
                end
            end
        end)

        Citizen.CreateThread(function()
            while GameStart do
                Citizen.Wait(700)
                if GameStart then
                    if not InVeh then

                        for k, v in pairs(GameMode.SpawnVeh) do
                            if PlayerCheckPoint >= v.Point + 1 and
                                PlayerCheckPoint < v.DeletePoint + 1 then

                                local Clearzone = 1.0
                                if GameMode.FlyMode then
                                    Clearzone = 1.0
                                end
                                if ESX.Game.IsSpawnPointClear(GetEntityCoords(
                                                                  PlayerPedId()),
                                                              Clearzone) then

                                    TriggerEvent('Dm_Triathlon:SpawnVeh',
                                                 v.VehicleName, v.DeletePoint,
                                                 GameMode)
                                    InVeh = true
                                else
                                    if not IsPedInAnyVehicle(PlayerPedId(), true) then

                                        TriggerEvent("pNotify:SendNotification",
                                                     {
                                            text = "พื้นที่ไม่ว่าง",
                                            type = "alert",
                                            timeout = 2 * 1000,
                                            layout = "CenterRight",
                                            queue = "global"
                                        })
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

RegisterNetEvent('Dm_Triathlon:SpawnVeh')
AddEventHandler('Dm_Triathlon:SpawnVeh',
                function(VehicleNameSpawn, DeleteVehiclePoint, GameMode)
    local PlayerX, PlayerY, PlayerZ = table.unpack(
                                          GetOffsetFromEntityInWorldCoords(
                                              PlayerPedId(), 0.0, 0.5, -0.5))
    local PlayerHeading = GetEntityHeading(PlayerPedId())
    local SpawnCoords = vector3(PlayerX, PlayerY, PlayerZ)
    local vehicleProps = VehicleNameSpawn

    ESX.Game.SpawnVehicle(vehicleProps, SpawnCoords, PlayerHeading,
                          function(vehicle)
        vehicle2 = vehicle

        if Config2.Effect then inputstunt = true end
        ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
        if GameMode.FlyMode then
            ESX.Game.SetVehicleProperties(vehicle, {modRoof = 1})
        end

        local playerPed = PlayerPedId()
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        table.insert(VehinGame, vehicle)
        Veh2 = vehicle
        -- Citizen.Wait(1000)
        delen = false
        spawnnewone = false
    end)

    Citizen.CreateThread(function()
        while InVeh do
            Citizen.Wait(1000)
            local playerVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            if playerVehicle == Veh2 then
                inputstunt = false

                if not GameMode.FlyMode then
                    SetVehicleBodyHealth(playerVehicle, 1000.0)
                    SetVehicleEngineHealth(playerVehicle, 1000.0)
                else
                    SetVehicleBodyHealth(playerVehicle, 1000.0)
                    SetVehicleEngineHealth(playerVehicle, 1000.0)
                    SetPlaneEngineHealth(playerVehicle, 1000.0)
                    SetPlanePropellersHealth(playerVehicle, 1000.0)
                    SetEntityInvincible(playerVehicle, true)
                end
            else
                SetPedCanRagdoll(PlayerPedId(), true)
                SetPedCanRagdollFromPlayerImpact(PlayerPedId(), true)
                for k, v in pairs(VehinGame) do DeleteEntity(v) end
                InVeh = false

            end
        end
    end)

    -- Citizen.CreateThread(function()
    --     while InVeh do
    --         local zc = 1000

    --         local playerVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    --         if playerVehicle == Veh2 then
    --             if GameMode.FlyMode then
    --                 zc = 0
    --                 SetEntityInvincible(playerVehicle, true)
    --             end
    --         end
    --         Citizen.Wait(zc)
    --     end
    -- end)

    Citizen.CreateThread(function()
        while InVeh do
            Sleep = 1000
            if IsPedDeadOrDying(PlayerPedId(), 1) then
                for k, v in pairs(VehinGame) do DeleteEntity(v) end
                InVeh = false
            end
            Citizen.Wait(Sleep)
        end
    end)

    Citizen.CreateThread(function()
        while InVeh do
            Sleep = 500
            if PlayerCheckPoint == DeleteVehiclePoint + 1 then
                for k, v in pairs(VehinGame) do
                    -- if not delen then
                    DeleteEntity(v)
                    -- delen = true
                    -- end
                end
                InVeh = false
            end
            Citizen.Wait(500)
        end
    end)
end)

RegisterNetEvent('Dm_Triathlon:TimeEndding')
AddEventHandler('Dm_Triathlon:TimeEndding', function(EndPlayerEnd)
    if GameStart then
        restart = true
        IsEndding = true
        local TimeBeforeEnd = Config2.TimeBeforeEnd
        SendNUIMessage({type = 2, Detail = 'end'})
        SendNUIMessage({type = 3, Detail = 'start'})
        Citizen.CreateThread(function()
            while IsEndding do
                Citizen.Wait(1000)
                if TimeBeforeEnd > 0 then
                    TimeBeforeEnd = TimeBeforeEnd - 1
                    if restart then
                        SendNUIMessage({
                            type = 3,
                            Detail = 'run',
                            time = TimeBeforeEnd,
                            poin = PlayerCheckPoint - 1,
                            endpoin = endpoin

                        })
                    end
                    if TimeBeforeEnd == 0 then
                        TriggerServerEvent('loserItem', zcx)
                        TriggerEvent('Dm_Triathlon:Restart')
                        SendNUIMessage({type = 1, Detail = 'end'})
                        SendNUIMessage({type = 2, Detail = 'end'})
                        SendNUIMessage({type = 3, Detail = 'end'})
                        IsEndding = false
                    end
                end
            end
        end)
    end
end)

RegisterNetEvent('Dm_Triathlon:StopRace')
AddEventHandler('Dm_Triathlon:StopRace', function()
    StopRace = true
    if GameStart then
        TriggerEvent('Dm_Triathlon:Restart')
        if Config2.PassiveOnGame then SetLocalPlayerAsGhost(false) end
    end
end)

RegisterNetEvent('Dm_Triathlon:Restart')
AddEventHandler('Dm_Triathlon:Restart', function()

    local GameMode = Config['Mode_' .. GameMode]
    for k, v in pairs(VehinGame) do DeleteEntity(v) end
    if GameStart then
        freeze2 = true
        FreezeEntityPosition(PlayerPedId(), true)
        SetEntityCoords(PlayerPedId(), returncoords)
        Citizen.Wait(3000)
        if Config2.PassiveOnGame then SetLocalPlayerAsGhost(false) end
        freeze2 = false
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerServerEvent("SwitchDimension", 0)
        Config2.reviveOnEndGame()
        SendNUIMessage({type = 1, Detail = 'end'})
        SendNUIMessage({type = 2, Detail = 'end'})
        SendNUIMessage({type = 3, Detail = 'end'})

    end

    PlayerCheckPoint = 0
    GameStart = false
    StopRace = false
    InVeh = false
    Beforestart = false
    JoinEventConfirm = false
    deny = false
    Joined = false

    Veh2 = nil
    if GameStart then
        Citizen.Wait(2000)
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
        SetPedMovementClipset(PlayerPedId(), "move_m@multiplayer", 0.25)
    end
    -- if GameMode.FlyMode then
    if addwing then
        addwing = false
        TriggerServerEvent('removewing')
        TriggerEvent('wingfalse')
    end
    -- end

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1200)
        if inputstunt then
            local particleDictionary = "scr_rcbarry2"
            local particleName = "scr_clown_appears"
            RequestNamedPtfxAsset(particleDictionary)
            while not HasNamedPtfxAssetLoaded(particleDictionary) do
                Citizen.Wait(0)
            end
            bone = GetPedBoneIndex(GetPlayerPed(-1), 18905)

            SetPtfxAssetNextCall(particleDictionary)
            effect3 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName,
                                                                 PlayerPedId(),
                                                                 0.15, -0.0000,
                                                                 0.0000, 0.0,
                                                                 180.0, 0.0,
                                                                 18905, 1.0,
                                                                 false, false,
                                                                 false)
            SetPtfxAssetNextCall(particleDictionary)
            effect2 = StartNetworkedParticleFxNonLoopedOnPedBone(particleName,
                                                                 PlayerPedId(),
                                                                 0.15, -0.0000,
                                                                 0.0000, 0.0,
                                                                 180.0, 0.0,
                                                                 57005, 1.0,
                                                                 false, false,
                                                                 false)
        end
    end
end)
