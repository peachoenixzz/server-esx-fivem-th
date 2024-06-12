-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

local airdropType       = {}
local airdropObject     = {}
local airdropTime       = 0
local isAnimation       = false
local startEvent     = false
local isDead        = false
local isAdmin       = false
local notZone       = false
local isZone        = false
local isCancel      = false
local health        = 200
local radius        = Config.Primary.StartingRadius

AddEventHandler("tg_airdrop:startEvent", function(airdropState)
    startEvent = true
    airdropType = airdropState
end)

AddEventHandler("tg_airdrop:timeSync", function(timeRemaning)
    airdropTime = timeRemaning
end)

AddEventHandler("tg_airdrop:radiusSync", function(radiusRemaning)
    radius = radiusRemaning
end)

Citizen.CreateThread(function()
    TriggerServerEvent("tg_airdrop:checkAirdrop")

    ESX.TriggerServerCallback("tg_airdrop:checkAdministrator", function(playerRank)
        if playerRank == Config.Primary.AdministratorGroup then
            isAdmin = true
        end
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if startEvent then
            for k, v in pairs(airdropType) do
                local playerPed = PlayerPedId()
                local coords = GetEntityCoords(playerPed)
                local dist = Vdist(v.airdropCoords, coords)
                
                if dist < Config.Primary.StartingRadius*3 then
                    DrawMarker(1, v.airdropCoords.x, v.airdropCoords.y, v.airdropCoords.z-50.0, 0, 0, 0, 0, 0, 0, radius*2, radius*2, Config.Primary.StartingRadius*2, v.color.red, v.color.green, v.color.blue, v.color.alpha, 0, 0, 2, 0, 0, 0, 0)
                end
            end
        else 
            Citizen.Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if startEvent then
            if airdropTime > 0 then
                isZone = false
            end
            for k, v in pairs(airdropType) do
                local playerPed = PlayerPedId()
                local coords = GetEntityCoords(playerPed)
                local dist = Vdist(v.airdropCoords, coords)

                if dist <= radius*2 then
                    if dist <= radius then
                        if airdropTime <= 0 then
                            if not isZone then
                                if isAdmin and not Config.Primary.EnableAdministratorEnter then
                                    local coords = GetEntityCoords(GetPlayerPed(-1), false)
                                    local forward = GetEntityForwardVector(GetPlayerPed(-1))

                                    SetEntityCoords(GetPlayerPed(-1), (coords.x-(forward.x*5)), (coords.y-(forward.y*5)), coords.z-1)
                                    Config.ClientNotification("error", Config.Locale.Notification.unable_player_enter)
                                elseif not isAdmin then
                                    local coords = GetEntityCoords(GetPlayerPed(-1), false)
                                    local forward = GetEntityForwardVector(GetPlayerPed(-1))
                                    
                                    SetEntityCoords(GetPlayerPed(-1), (coords.x-(forward.x*5)), (coords.y-(forward.y*5)), coords.z-1)
                                    Config.ClientNotification("error", Config.Locale.Notification.unable_player_enter)
                                end
                            end
                        end
                    end
                    if dist <= radius + 10.0 then 
                        if not Config.Primary.EnableVehicleEnter then
                            GetOffVehicle()
                        end
                        if dist <= radius then
                            notZone = true
                            if airdropTime > 0 then
                                isZone = true
                            end
                            if dist < 4.0 then
                                for key, value in pairs(v.blacklistJobs) do
                                    if airdropTime > 0 then
                                        Config.BoxNotification(Config.Locale.Notification.show_help)
                                        if IsControlJustPressed(0, Config.Primary.Key.action) then                            
                                            if ESX.GetPlayerData().job.name ~= value then
                                                Config.ClientNotification("error", Config.Locale.Notification.cannot_open_box)
                                                break
                                            else
                                                Config.ClientNotification("error", Config.Locale.Notification.deny_job)
                                                break
                                            end
                                        end
                                    else
                                        if not isDead and not isAnimation then
                                            Config.BoxNotification(Config.Locale.Notification.show_help)
                                            if IsControlJustPressed(0, Config.Primary.Key.action) then
                                                if ESX.GetPlayerData().job.name ~= value then
                                                    local rdm = math.random(1,500)
                                                    Citizen.Wait(rdm)
                                                    health = GetEntityHealth(PlayerPedId())
                                                    CheckHealth()
                                                    KeepAirdrop(k)
                                                else
                                                    Config.ClientNotification("error", Config.Locale.Notification.deny_job)
                                                    break
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if isZone and notZone and not isDead then
                                notZone = false
                                OutOfZone()
                            end
                        end
                    end
                end
            end
        else Citizen.Wait(500) end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        
        if Config.ProgressBar.Addition.can_cancel then
            if isAnimation and IsControlJustPressed(0, Config.Primary.Key.cancel) then
                isCancel = true
            end
            if isCancel then
                ClearPedTasks(PlayerPedId())
                TriggerEvent(Config.ProgressBar.CancelEvent)
                isAnimation = false
                isCancel = false
            end
        else
            Citizen.Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if isAnimation then
            if HasEntityBeenDamagedByAnyPed(PlayerPedId()) then
                isCancel = true
                ClearEntityLastDamageEntity(PlayerPedId())
            end

            if isCancel then
                ClearPedTasks(PlayerPedId())
                TriggerEvent(Config.ProgressBar.CancelEvent)
                isAnimation = false
                isCancel = false
            end
        else
            Citizen.Wait(500)
        end
    end
end)

function KeepAirdrop(boxName)
    isAnimation = true
    TriggerEvent(Config.ProgressBar.ProgressEvent, {
        name = "pickUp",
        duration = Config.Primary.OpenBoxDuration * 1000,
        label = Config.ProgressBar.Label,
        useWhileDead = false,
        canCancel = Config.ProgressBar.Addition.can_cancel,
        controlDisables = {
            disableMovement = Config.ProgressBar.Addition.disable_movement,
            disableCarMovement = Config.ProgressBar.Addition.disable_car_movement,
            disableMouse = Config.ProgressBar.Addition.disable_mouse,
            disableCombat = Config.ProgressBar.Addition.disable_combat,
        },
        animation = {
            animDict = Config.Primary.Animation.anim_dict,
            anim = Config.Primary.Animation.anim
        },
    }, function(status)
        if not status then
            if not isDead and isAnimation then
                TriggerServerEvent("tg_airdrop:getReward", boxName)
                TriggerServerEvent("tg_airdrop:deleteAirdropServer", boxName)
                Config.AfterAirdropCollect()
                isAnimation = false
            end
        end
    end)
end

function OutOfZone()
    Citizen.CreateThread(function()
        while not notZone and not IsPedDeadOrDying(PlayerPedId()) do
            Citizen.Wait(1000)
            if not notZone and not IsPedDeadOrDying(PlayerPedId()) then

                if Config.Primary.EnableDecreaseHealth then
                    SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - Config.Primary.InjuredHealth)
                else
                    SetEntityCoords(PlayerPedId(), Config.Primary.EliminateCoords.x, Config.Primary.EliminateCoords.y, Config.Primary.EliminateCoords.z)
                    SetEntityHeading(PlayerPedId(), Config.Primary.EliminateCoords.heading)
                    Config.ClientNotification("error", Config.Locale.Notification.eliminate)
                    startEvent = false
                    notZone = true
                end
            end
        end
    end)
end

function CheckHealth()
    Citizen.CreateThread(function()
        while isAnimation do
            Citizen.Wait(0)
            if health ~= GetEntityHealth(PlayerPedId()) then
                isAnimation = false
            end
        end
    end)
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(airdropType) do 
            DeleteEntity(v.Object) 
        end
    end
end)