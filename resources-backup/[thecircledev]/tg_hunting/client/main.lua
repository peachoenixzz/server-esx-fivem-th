-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

local removeWeapon = false
local isGhost = false
isNear = false

-- Rental Equipment
if Config.EquipmentRental.Rental.enable then
    Citizen.CreateThread(function()
        while true do 
            Wait(0)

            sleep = true 

            local ped = PlayerPedId()
            local playerCoords = GetEntityCoords(ped)
            local rental = Config.EquipmentRental.Rental

            if Vdist(playerCoords.x, playerCoords.y, playerCoords.z, rental.coords.x, rental.coords.y, rental.coords.z) <= rental.render_distance then
                sleep = false
                DrawMarker(rental.marker.type, rental.coords.x, rental.coords.y, rental.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, rental.marker.scale.x, rental.marker.scale.y, rental.marker.scale.z, rental.marker.color.r, rental.marker.color.g, rental.marker.color.b, rental.marker.color.a, false, true, 2, true)      

                if Vdist(playerCoords.x, playerCoords.y, playerCoords.z, rental.coords.x, rental.coords.y, rental.coords.z) <= rental.action_distance then
                    Config.ShowHelpNotification(Config.Locale.Notification.equipment_rental) 
                    
                    if IsControlJustPressed(0, 38) then
                        EquipmentShop()
                    end
                else
                    ESX.UI.Menu.CloseAll()
                end
            end

            if sleep then
                Wait(500)
            end
        end
    end)
end

-- Rental Car
if Config.CarRental.Rental.enable then
    Citizen.CreateThread(function()
        while true do 
            Wait(0)

            sleep = true 

            local ped = PlayerPedId()
            local playerCoords = GetEntityCoords(ped)
            local rental = Config.CarRental.Rental

            if Vdist(playerCoords.x, playerCoords.y, playerCoords.z, rental.coords.x, rental.coords.y, rental.coords.z) <= rental.render_distance then
                sleep = false
                DrawMarker(rental.marker.type, rental.coords.x, rental.coords.y, rental.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, rental.marker.scale.x, rental.marker.scale.y, rental.marker.scale.z, rental.marker.color.r, rental.marker.color.g, rental.marker.color.b, rental.marker.color.a, false, true, 2, true)      

                if Vdist(playerCoords.x, playerCoords.y, playerCoords.z, rental.coords.x, rental.coords.y, rental.coords.z) <= rental.action_distance then
                    Config.ShowHelpNotification(Config.Locale.Notification.car_rental) 
                    
                    if IsControlJustPressed(0, 38) then
                        CarShop()
                    end
                else
                    ESX.UI.Menu.CloseAll()
                end
            end

            if sleep then
                Wait(500)
            end
        end
    end)
end

-- Rental Car (Deleter)
Citizen.CreateThread(function()
    while true do 
        Wait(0)

        sleep = true 

        local ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped)
        local deleter = Config.CarRental.Deleter

        if deleter.marker.show_in_car then
            if IsPedInAnyVehicle(ped) then
                if Vdist(playerCoords.x, playerCoords.y, playerCoords.z, deleter.coords.x, deleter.coords.y, deleter.coords.z) <= deleter.render_distance then
                    sleep = false
                    DrawMarker(deleter.marker.type, deleter.coords.x, deleter.coords.y, deleter.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, deleter.marker.scale.x, deleter.marker.scale.y, deleter.marker.scale.z, deleter.marker.color.r, deleter.marker.color.g, deleter.marker.color.b, deleter.marker.color.a, false, true, 2, true)      

                    if Vdist(playerCoords.x, playerCoords.y, playerCoords.z, deleter.coords.x, deleter.coords.y, deleter.coords.z) <= deleter.action_distance then
                        Config.ShowHelpNotification(Config.Locale.Notification.car_delete) 
                        
                        if IsControlJustPressed(0, 38) then
                            DeleteCar()
                        end
                    end
                end
            end
        else
            if Vdist(playerCoords.x, playerCoords.y, playerCoords.z, deleter.coords.x, deleter.coords.y, deleter.coords.z) <= deleter.render_distance then
                sleep = false
                DrawMarker(deleter.marker.type, deleter.coords.x, deleter.coords.y, deleter.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, deleter.marker.scale.x, deleter.marker.scale.y, deleter.marker.scale.z, deleter.marker.color.r, deleter.marker.color.g, deleter.marker.color.b, deleter.marker.color.a, false, true, 2, true)      

                if Vdist(playerCoords.x, playerCoords.y, playerCoords.z, deleter.coords.x, deleter.coords.y, deleter.coords.z) <= deleter.action_distance then
                    Config.ShowHelpNotification(Config.Locale.Notification.car_delete) 
                    
                    if IsControlJustPressed(0, 38) then
                        DeleteCar()
                    end
                end
            end
        end

        if sleep then
            Wait(500)
        end
    end
end)

-- Equipment Blips
if Config.EquipmentRental.Rental.blip.enable then
    local rental = Config.EquipmentRental.Rental 
    Citizen.CreateThread(function()
        blipCoords = AddBlipForCoord(rental.coords)
        SetBlipSprite(blipCoords, rental.blip.sprite)
        SetBlipDisplay(blipCoords, 4)
        SetBlipScale(blipCoords, rental.blip.size)
        SetBlipColour(blipCoords, rental.blip.color)
        SetBlipAsShortRange(blipCoords, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(rental.blip.title or "Unconfigured")
        EndTextCommandSetBlipName(blipCoords) 
    end)
end

-- Car Rental Blips
if Config.CarRental.Rental.blip.enable then
    local rental = Config.CarRental.Rental
    Citizen.CreateThread(function()
        blipCoords = AddBlipForCoord(rental.coords)
        SetBlipSprite(blipCoords, rental.blip.sprite)
        SetBlipDisplay(blipCoords, 4)
        SetBlipScale(blipCoords, rental.blip.size)
        SetBlipColour(blipCoords, rental.blip.color)
        SetBlipAsShortRange(blipCoords, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(rental.blip.title or "Unconfigured")
        EndTextCommandSetBlipName(blipCoords) 
    end)
end

-- Car Deleter Blips
if Config.CarRental.Deleter.blip.enable then
    local deleter = Config.CarRental.Deleter
    Citizen.CreateThread(function()
        blipCoords = AddBlipForCoord(deleter.coords)
        SetBlipSprite(blipCoords, deleter.blip.sprite)
        SetBlipDisplay(blipCoords, 4)
        SetBlipScale(blipCoords, deleter.blip.size)
        SetBlipColour(blipCoords, deleter.blip.color)
        SetBlipAsShortRange(blipCoords, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(deleter.blip.title or "Unconfigured")
        EndTextCommandSetBlipName(blipCoords) 
    end)
end

-- Zone Blips
if Config.Zone.Blip.enable then 
    Citizen.CreateThread(function()
        local blip = Config.Zone.Blip
        for k, v in pairs(Config.Animal.Coords) do
            local circleBlip = AddBlipForRadius(v, Config.Animal.Radius)
            SetBlipHighDetail(circleBlip, true)
            SetBlipColour(circleBlip, blip.color)
            SetBlipAlpha(circleBlip, blip.alpha)
            SetBlipAsShortRange(circleBlip, true)
        end
    end)
end

-- Minimap / PVP
-- Deny Car Enter / Remove Weapon
Citizen.CreateThread(function()
    while true do

	    Wait(0)

        sleep = true 

        local playerCoords = GetEntityCoords(PlayerPedId())

        for k, v in pairs(Config.Animal.Coords) do
            local animalDistance = Vdist(playerCoords, v)

            if animalDistance <= Config.Animal.Radius then
                sleep = false

                if Config.EnableMinimap then 
                    DisplayRadar(true)
                end

                if not Config.EnablePVP then 
                    SetLocalPlayerAsGhost(true)
                    isGhost = true
                end
                
            else
                if isGhost then 
                    SetLocalPlayerAsGhost(false)
                    isGhost = false
                end
            end

            if animalDistance <= Config.Animal.Radius + Config.Zone.Marker.render_distance then 
                sleep = false

                if Config.Zone.Marker.enable then 
                    DrawMarker(Config.Zone.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 100.0 * 2, 100.0 * 2, 100.0, Config.Zone.Marker.color.r, Config.Zone.Marker.color.g, Config.Zone.Marker.color.b, Config.Zone.Marker.color.a, false, true, 2, true)    
                end

                if Config.Zone.CarEnter.enable then 
                    if animalDistance <= Config.Animal.Radius + Config.Zone.CarEnter.radius then 
                        local ped = PlayerPedId()
                        local currentVehicle = GetVehiclePedIsIn(ped, true)

                        if IsPedInVehicle(ped, currentVehicle, true) then
                            GetOffVehicle()
                        end      
                    end
                end
            end
        end
        
        if Config.EnableRemoveWeaponWhenLeavingIsland then 
            local islandDistance = Vdist(playerCoords, Config.CayoPerico)

            if islandDistance < 2500.0 then 
                removeWeapon = true
            else
                if removeWeapon then 
                    for k, v in pairs(Config.RemoveWeapon) do 
                        TriggerServerEvent('tg_hunting:removeWeapon', v)
                    end

                    removeWeapon = false
                end
            end 
        end

        if sleep then
            Wait(500)
        end
    end
end)

-- Spawn Animals with blips
Citizen.CreateThread(function() 
    for i, v in pairs(Config.Animal.Model) do
        table.insert(animalModels, v.name)
    end

    while true do
        player = PlayerPedId(-1)
        coords = GetEntityCoords(player)
        local pos = coords
        local land = false
        local X,Y,ZLoc = 0

        sleep = true

        if SpawnAnimalZone(pos) then   
            if not busy then   
                Wait(0)  
                if #search < Config.Animal.Count then
                    sleep = false

                    for k, v in pairs(Config.Animal.Coords) do
                        if GetDistanceBetweenCoords(pos, v, true) < Config.Animal.Radius then
                        X = v.x
                        Y = v.y
                        ZLoc = v.z 
                        end
                    end

                    local anihealth = nil
                    local randomanimals = math.random(1, #animalModels)

                    for i, v in pairs(Config.Animal.Model) do
                        if animalModels[randomanimals] == v.name then 
                            anihealth = v.health
                        end
                    end

                    local aniModel = GetHashKey(animalModels[randomanimals])

                    RequestModel(aniModel)
                        while not HasModelLoaded(aniModel) or not HasCollisionForModelLoaded(aniModel) do
                            Wait(1e2)
                        end
                    
                    local coordSpawn = GeneratePedCoords(vector3(X,Y,ZLoc),Config.Animal.Radius)
                    
                    entity = CreatePed(5, aniModel, coordSpawn.x, coordSpawn.y, coordSpawn.z, 0.0, false, false)
                    SetEntityHealth(entity, anihealth)
                    animalsSpawnedCount = animalsSpawnedCount + 1
                    TaskWanderStandard(entity, true, true)
                    table.insert(search, entity)

                    if Config.Animal.Blip.enable then
                        local blip = AddBlipForEntity(entity)
                        SetBlipSprite(blip,Config.Animal.Blip.sprite)
                        SetBlipColour(blip,Config.Animal.Blip.color)
                        SetBlipScale(blip, Config.Animal.Blip.size)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(Config.Animal.Blip.title or "Unconfigured")
                        EndTextCommandSetBlipName(blip)
                    end   
                end
               
            else 
                Wait(100)
            end
        else
            for i, entity in pairs(search) do
                DeletePed(entity, i)
            end
        end

        if Config.Animal.EnableWaterCheck then
            for i, entity in pairs(search) do
                if IsEntityInWater(entity) then
                    DeletePed(entity, i)
                end
            end
        end
        for k, v in pairs(Config.Animal.Coords) do
            for i, entity in pairs(search) do
                local entityCoord = GetEntityCoords(entity)
                if Vdist(entityCoord, v) > Config.Animal.Radius then
                    DeletePed(entity, i)
                end
            end
        end

        if sleep then
            Wait(500)
        end
    end             
end)

-- Monster Health Bar
if Config.HealthBar.Enable then 
    Citizen.CreateThread(function()
        while true do
            Wait(0)
            
            sleep = true

            local npcPed = GetPedDeployer()

            for i, v in pairs(npcPed) do
                local dist = #(GetEntityCoords(npcPed[i]) - GetEntityCoords(PlayerPedId()))
                if (not IsPedAPlayer(npcPed[i])) and (dist <= Config.HealthBar.Setting.render_distance) and (not IsPedDeadOrDying(npcPed[i],1) and not IsPedInAnyVehicle(npcPed[i], true)) then

                    local hash = GetEntityModel(npcPed[i])

                    for key, value in pairs(Config.Animal.Model) do
                        if GetHashKey(value.name) == hash then
                            sleep = false
                            DrawHealthBar(GetEntityCoords(v).x,GetEntityCoords(v).y,GetEntityCoords(v).z + Config.HealthBar.Setting.head_offset, GetGameplayCamCoords(), GetGameplayCamFov(), npcPed[i])
                        end
                    end
                    
                end
            end
            
            if sleep then 
                Wait(500)
            end
        end
    end)
end

-- Delete Ped & Near By
Citizen.CreateThread(function() 
    while true do
        Wait(0)

        sleep = true 

        for key, value in pairs(search) do
      
            if not busy then
                local ped = PlayerPedId()
                local distancePedPlayer = GetDistance(value)

                if Config.Animal.EnableWaterCheck then
                    if IsEntityInWater(value) then
                        sleep = false
                        DeletePed(value, i)
                    end
                end

                for k, v in pairs(Config.Animal.Coords) do
                    local entityCoord = GetEntityCoords(value)
                    if Vdist(entityCoord, v) > Config.Animal.Radius then
                        sleep = false
                        DeletePed(value, key)
                    end
                end

                if IsInSpawnAnimalZone(pedCoords) then
                    if distancePedPlayer < 3.0 and not IsPedInAnyVehicle(ped, false) then
                        if IsPedDeadOrDying(value, true) then 
                            sleep = false
                            IsNearAnimal(distancePedPlayer, value, key)
                            isNear = true 
                        end
                    end
                end

                if Config.Animal.Action.enable_take_action then
                    if IsInSpawnAnimalZone(pedCoords) then
                        if distancePedPlayer < Config.Animal.Action.render_distance and not IsPedInAnyVehicle(ped, false) then
                            if not IsPedDeadOrDying(value, true) then
                                AnimalAction(value, key)
                            end
                        end 
                    end 
                end

            end
        end

        if sleep then 
            Wait(500)
        end
    end
end)

-- Remove When Not Colleting  
Citizen.CreateThread(function()
    while true do
        Wait(0)

        sleep = true 

        if isNear then
            sleep = false 

            Wait(Config.Animal.RemoveTime * 1000)

            for key, value in pairs(search) do
                local ped = PlayerPedId()
                local distancePedPlayer = GetDistance(value)

                if not checkCollect then 
                    if distancePedPlayer < Config.Animal.ActionRadius and not IsPedInAnyVehicle(ped, false) then
                        if IsPedDeadOrDying(value, true) then
                            --exports.helpnotify:hideHelpNotification()
                            DeletePed(value, key)
                            isNear = false
                        end
                    end
                end
            end
        end

        if sleep then 
            Wait(500)
        end
    end
end)

-- Remove Ped When Stop Resource
AddEventHandler('onResourceStop', function(resource)  
    if resource == GetCurrentResourceName() then
        if Config.EnableDeleteEntityEntireWorld then
            local peds = ESX.Game.GetPeds()
            for i,v in pairs(peds) do 
                DeleteEntity(v)
            end 
        else
            for i, entity in pairs(search) do
                DeletePed(entity, i)
            end
        end
    end
end)

