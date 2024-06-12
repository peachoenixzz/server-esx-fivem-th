local LastMarker, LastPart, thisGarage, thisPound = nil, nil, nil, nil
local thisRepair = nil
local next = next
local nearMarker, menuIsShowed = false, false
local vehiclesList, vehiclesImpoundedList = {}, {}
local helpNotify = true
local repairProcess = false
local inSpawn = false

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


RegisterNetEvent('esx_garage:closemenu')
AddEventHandler('esx_garage:closemenu', function()
    menuIsShowed = false
    vehiclesList, vehiclesImpoundedList = {}, {}
    SetNuiFocus(false)
    SendNUIMessage({
        hideAll = true
    })
    pcall(function() exports.nc_inventory:CloseInventory() end)

    --if not menuIsShowed and thisGarage then
    --    ESX.TextUI(TranslateCap('access_parking'))
    --    pcall(function() -- Start log
    --        exports['azael_dc-serverlogs']:insertData({
    --            event = 'CloseGarageMenu',
    --            content = ('ผู้เล่นได้ทำการปิดเมนู garrage'):format(),
    --        })
    --    end) -- End log
    --end

    -- if not menuIsShowed and thisRepair then
    --     ESX.TextUI('กด E เพื่อเข้า Vehicle Care')
    -- end

    if thisRepair and menuIsShowed then
        menu.close()
    end

    --if not menuIsShowed and thisPound then
    --    ESX.TextUI(TranslateCap('access_Impound'))
    --    pcall(function() -- Start log
    --        exports['azael_dc-serverlogs']:insertData({
    --            event = 'CloseImpoundMenu',
    --            content = ('ผู้เล่นได้ทำการปิดเมนู Impound'):format(),
    --        })
    --    end) -- End log
    --end
end)


RegisterNUICallback('escape', function(data, cb)
    TriggerEvent('esx_garage:closemenu')
    cb('ok')
end)

function spawnVehicle(data,spawnCoords)
    ESX.TriggerServerCallback('esx_garage:vehicleOutGarage', function(veh,job)
        TriggerEvent('esx_garage:closemenu')
        ESX.Game.SpawnVehicle(veh.model, spawnCoords,data.spawnPoint.heading, function(vehicle)
            local playerPed = ESX.PlayerData.ped
            if job == "player" then
                ESX.Game.SetVehicleProperties(vehicle, veh)
                exports['cc_legacyfuel']:SetFuel(vehicle, veh.fuelLevel)
                SetVehicleEngineOn(vehicle,true,true,true)
                SetVehiclePetrolTankHealth(vehicle, veh.tankHealth)
                SetVehicleBodyHealth(vehicle, veh.bodyHealth)
                SetVehicleEngineHealth(vehicle, veh.engineHealth)
                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
            end
            --bad solution ...
            if job == "ambulance" or job == "police" or job == "circle" or job == "sos" then
                ESX.Game.SetVehicleProperties(vehicle, veh)
                exports['cc_legacyfuel']:SetFuel(vehicle, 100.0)
                SetVehiclePetrolTankHealth(vehicle, 1000.0)
                SetVehicleBodyHealth(vehicle, 1000.0)
                SetVehicleEngineHealth(vehicle, 1000.0)
                SetVehicleFixed(vehicle)
                SetVehicleDeformationFixed(vehicle)
                SetVehicleUndriveable(vehicle, false)
                TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
            end
        end)
    end,2, nil, nil, data, spawnCoords)
    inSpawn = false
end

function spawnVehicleImpound(data,spawnCoords)
    ESX.TriggerServerCallback('esx_garage:checkStatePlayer', function(hasMoney,havePlayer)
        if havePlayer then return end
        if hasMoney then
            if ESX.Game.IsSpawnPointClear(spawnCoords, 2.5) then
                thisPound = nil
                ESX.TriggerServerCallback('esx_garage:vehicleOutGarage', function(vehicle,job)
                    TriggerEvent('esx_garage:closemenu')
                    ESX.Game.SpawnVehicle(data.vehicleProps.model, spawnCoords,data.spawnPoint.heading, function(vehicle)
                        local playerPed = ESX.PlayerData.ped
                        ESX.Game.SetVehicleProperties(vehicle, data.vehicleProps)
                        exports['cc_legacyfuel']:SetFuel(vehicle, 50.0)
                        SetVehiclePetrolTankHealth(vehicle, 1000.0)
                        SetVehicleBodyHealth(vehicle, 1000.0)
                        SetVehicleEngineHealth(vehicle, 1000.0)
                        SetVehicleFixed(vehicle)
                        SetVehicleDeformationFixed(vehicle)
                        SetVehicleUndriveable(vehicle, false)
                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                        TriggerServerEvent('esx_garage:payPound', data.exitVehicleCost)
                    end)
                end,2, nil, nil, data, spawnCoords)
                inSpawn = false
                TriggerServerEvent('esx_garage:vehiclePound', 2, nil, nil, data, spawnCoords)
                TriggerEvent('esx_garage:closemenu')
            else
                --ESX.ShowNotification(TranslateCap('veh_block'), 'error')
            end
        else
            onNoMoneyToPound()
        end
    end, data.exitVehicleCost,data.vehicleProps.plate)
end


function openTrunk(data)
    ESX.TriggerServerCallback('esx_garage:openTrunk', function()

    end,data.vehicleProps)
end

RegisterNUICallback('spawnVehicle', function(data, cb)
    if data.trunkPoint then
        openTrunk(data)
        return
    end
    local spawnCoords = vector3(data.spawnPoint.x, data.spawnPoint.y, data.spawnPoint.z)
    if thisGarage then
        if ESX.Game.IsSpawnPointClear(spawnCoords, 2.5) then
            thisGarage = nil
            inSpawn = true
            TriggerEvent("mythic_progbar:client:progress",{
                name = "Parking Citizen",
                duration = 3000,
                label = "กำลังดำเนินการ",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
            }, function(status)
                if not status then
                    spawnVehicle(data,spawnCoords)
                end
            end)
        end
    elseif thisPound then
        inSpawn = true
        TriggerEvent("mythic_progbar:client:progress",{
            name = "Parking",
            duration = 3000,
            label = "กำลังดำเนินการ",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
        }, function(status)
            if not status then
                spawnVehicleImpound(data,spawnCoords)
            end
        end)
    end
end)

RegisterNUICallback('impound', function(data, cb)
    local poundCoords = {
        x = data.poundSpawnPoint.x,
        y = data.poundSpawnPoint.y
    }

    TriggerServerEvent('esx_garage:setImpound', data.poundName, data.vehicleProps)
    TriggerEvent('esx_garage:closemenu')

    SetNewWaypoint(poundCoords.x, poundCoords.y)

    cb('ok')
end)

-- Create Blips
-- CreateThread(function()
--     for k, v in pairs(Config.Garages) do
--         local blip = AddBlipForCoord(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)

--         SetBlipSprite(blip, v.Sprite)
--         SetBlipDisplay(blip, 4)
--         SetBlipScale(blip, v.Scale)
--         SetBlipColour(blip, v.Colour)
--         SetBlipAsShortRange(blip, true)

--         BeginTextCommandSetBlipName("STRING")
--         AddTextComponentSubstringPlayerName(TranslateCap('parking_blip_name'))
--         EndTextCommandSetBlipName(blip)
--     end

--     for k, v in pairs(Config.Impounds) do
--         local blip = AddBlipForCoord(v.GetOutPoint.x, v.GetOutPoint.y, v.GetOutPoint.z)

--         SetBlipSprite(blip, v.Sprite)
--         SetBlipDisplay(blip, 4)
--         SetBlipScale(blip, v.Scale)
--         SetBlipColour(blip, v.Colour)
--         SetBlipAsShortRange(blip, true)

--         BeginTextCommandSetBlipName("STRING")
--         AddTextComponentSubstringPlayerName(TranslateCap('Impound_blip_name'))
--         EndTextCommandSetBlipName(blip)
--     end
-- end)

function checkGarageType(name)
    if Config.Garages[name] ~= nil then
        return Config.Garages[name]
    end
    if Config.GaragesPolice[name] ~= nil then
        return Config.GaragesPolice[name] ~= nil
    end
    if Config.GaragesAmbulance[name] ~= nil then
        return Config.GaragesAmbulance[name] ~= nil
    end
    if Config.GaragesCircle[name] ~= nil then
        return Config.GaragesCircle[name] ~= nil
    end
    if Config.GarageCustom[name] ~= nil then
        return Config.GarageCustom[name] ~= nil
    end
    return Config.GaragesBoat[name]
end

AddEventHandler('esx_garage:hasEnteredMarker', function(name, part)
    if part == 'EntryPoint' then
        local isInVehicle = IsPedInAnyVehicle(ESX.PlayerData.ped, false)
        local garage = checkGarageType(name)
        thisGarage = garage

        --if isInVehicle then
        --    ESX.TextUI(TranslateCap('park_veh'))
        --else
        --    ESX.TextUI(TranslateCap('access_parking'))
        --end
    end

    if part == 'RepairPoint' then
        local repair = Config.repairPoint[name]
        thisRepair = repair
    end

    if part == 'GetOutPoint' then
        local pound = nil
        if Config.ImpoundDepartment[name] ~= nil then
            pound = Config.ImpoundDepartment[name]
        end
        if Config.Impounds[name] ~= nil then
            pound = Config.Impounds[name]
        end
        if Config.ImpoundBoat[name] ~= nil then
            pound = Config.ImpoundBoat[name]
        end
        thisPound = pound
        --ESX.TextUI(TranslateCap('access_Impound'))
    end
end)

AddEventHandler('esx_garage:hasEnteredMarkerHelpNotify', function(currentMarkerHelpNotify)
    if currentMarkerHelpNotify == 'RepairHelpNoti' then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            exports.helpnotify:showHelpNotification("กด","E","เพื่อเข้า Car Care")
        end
    end

    if currentMarkerHelpNotify == 'ParkingHelpNoti' then
        if IsPedInAnyVehicle(PlayerPedId(), true) then
            exports.helpnotify:showHelpNotification("กด","E","เพื่อเก็บพาหนะ")
        end
    end

    if currentMarkerHelpNotify == 'GarageHelpNoti' then
        if not IsPedInAnyVehicle(PlayerPedId(), true) then
            exports.helpnotify:showHelpNotification("กด","E","เพื่อเบิกรถ")
        end
    end

    if currentMarkerHelpNotify == 'GarageBoatHelpNoti' then
        if not IsPedInAnyVehicle(PlayerPedId(), true) then
            exports.helpnotify:showHelpNotification("กด","E","เพื่อเบิกเรือ")
        end
    end

    if currentMarkerHelpNotify == 'PoliceHeliGarageHelpNoti' then
        if not IsPedInAnyVehicle(PlayerPedId(), true) then
            exports.helpnotify:showHelpNotification("กด","E","เพื่อเบิกฮอ")
        end
    end

    if currentMarkerHelpNotify == 'AmbulanceHeliGarageHelpNoti' then
        if not IsPedInAnyVehicle(PlayerPedId(), true) then
            exports.helpnotify:showHelpNotification("กด","E","เพื่อเบิกฮอ")
        end
    end

    if currentMarkerHelpNotify == 'CircleHeliGarageHelpNoti' then
        if not IsPedInAnyVehicle(PlayerPedId(), true) then
            exports.helpnotify:showHelpNotification("กด","E","เพื่อเบิกฮอ")
        end
    end

    if currentMarkerHelpNotify == 'PoliceGarageHelpNoti' then
        if not IsPedInAnyVehicle(PlayerPedId(), true) then
            exports.helpnotify:showHelpNotification("กด","E","เพื่อเบิกรถ")
        end
    end

    if currentMarkerHelpNotify == 'AmbulanceGarageHelpNoti' then
        if not IsPedInAnyVehicle(PlayerPedId(), true) then
            exports.helpnotify:showHelpNotification("กด","E","เพื่อเบิกรถ")
        end
    end

    if currentMarkerHelpNotify == 'CircleGarageHelpNoti' then
        if not IsPedInAnyVehicle(PlayerPedId(), true) then
            exports.helpnotify:showHelpNotification("กด","E","เพื่อเบิกรถ")--
        end
    end

    if currentMarkerHelpNotify == 'PoundsHelpNoti' then
        if not IsPedInAnyVehicle(PlayerPedId(), true) then
            exports.helpnotify:showHelpNotification("กด","E","เพื่ออิมพาวน์")
        end
    end

    if currentMarkerHelpNotify == 'GarageTrunkNoti' then
        if not IsPedInAnyVehicle(PlayerPedId(), true) then
            exports.helpnotify:showHelpNotification("กด","E","เพื่อเปิดท้ายรถ")
        end
    end
end)


AddEventHandler('esx_garage:hasExitedMarker', function()
    thisGarage = nil
    thisPound = nil
    --ESX.HideUI()
    TriggerEvent('esx_garage:closemenu')
    exports.helpnotify:hideHelpNotification()
end)

-- Display markers
Citizen.CreateThread(function()
    while not ESX.PlayerLoaded do
        Wait(1000)
    end

    while true do
        local sleep = 500
        local playerPed = ESX.PlayerData.ped
        local coords = GetEntityCoords(playerPed)
        local inVehicle = IsPedInAnyVehicle(playerPed, false)


        for _, v in pairs(Config.GarageCustom) do
            if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) < 5) then
                DrawMarker(Config.Markers.EntryPoint.Type, v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z, 0.0, 0.0,
                        0.0, 0, 0.0, 0.0, Config.Markers.EntryPoint.Size.x, Config.Markers.EntryPoint.Size.y,
                        Config.Markers.EntryPoint.Size.z, Config.Markers.EntryPoint.Color.r,
                        Config.Markers.EntryPoint.Color.g, Config.Markers.EntryPoint.Color.b, 100, false, true, 2, false,
                        false, false, false)
                sleep = 0
                -- break
            end
        end

        -- parking
        for _, v in pairs(Config.GaragesTrunk) do
            if (#(coords - vector3(v.TrunkPoint.x, v.TrunkPoint.y, v.TrunkPoint.z)) < 5) then
                DrawMarker(Config.Markers.TrunkPoint.Type, v.TrunkPoint.x, v.TrunkPoint.y, v.TrunkPoint.z, 0.0, 0.0,
                        0.0, 0, 0.0, 0.0, Config.Markers.TrunkPoint.Size.x, Config.Markers.TrunkPoint.Size.y,
                        Config.Markers.TrunkPoint.Size.z, Config.Markers.TrunkPoint.Color.r,
                        Config.Markers.TrunkPoint.Color.g, Config.Markers.TrunkPoint.Color.b, 100, false, true, 2, false,
                        false, false, false)
                sleep = 0
                -- break
            end
        end

        -- parking
        for _, v in pairs(Config.Garages) do
            if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) < Config.DrawDistance) then
                DrawMarker(Config.Markers.EntryPoint.Type, v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z, 0.0, 0.0,
                        0.0, 0, 0.0, 0.0, Config.Markers.EntryPoint.Size.x, Config.Markers.EntryPoint.Size.y,
                        Config.Markers.EntryPoint.Size.z, Config.Markers.EntryPoint.Color.r,
                        Config.Markers.EntryPoint.Color.g, Config.Markers.EntryPoint.Color.b, 100, false, true, 2, false,
                        false, false, false)
                sleep = 0
                -- break
            end
        end

        -- parking
        for _, v in pairs(Config.GaragesHelicopterPolice) do
            if ESX.PlayerData.job.name == "police" or  ESX.PlayerData.job.name == "ambulance" then
                if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) < Config.DrawDistance) then
                    DrawMarker(34, v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z, 0.0, 0.0,
                            0.0, 0, 0.0, 0.0, Config.Markers.EntryPoint.Size.x, Config.Markers.EntryPoint.Size.y,
                            Config.Markers.EntryPoint.Size.z, Config.Markers.EntryPoint.Color.r,
                            Config.Markers.EntryPoint.Color.g, Config.Markers.EntryPoint.Color.b, 100, false, true, 2, false,
                            false, false, false)
                    sleep = 0
                    -- break
                end
            end
        end

        for k, v in pairs(Config.GaragesHelicopterAmbulance) do
            if ESX.PlayerData.job.name == "police" or  ESX.PlayerData.job.name == "ambulance" then
                if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) < Config.DrawDistance) then
                    DrawMarker(34, v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z, 0.0, 0.0,
                            0.0, 0, 0.0, 0.0, Config.Markers.EntryPoint.Size.x, Config.Markers.EntryPoint.Size.y,
                            Config.Markers.EntryPoint.Size.z, Config.Markers.EntryPoint.Color.r,
                            Config.Markers.EntryPoint.Color.g, Config.Markers.EntryPoint.Color.b, 100, false, true, 2, false,
                            false, false, false)
                    sleep = 0
                    -- break
                end
            end
        end

        for k, v in pairs(Config.GaragesHelicopterCircle) do
            if ESX.PlayerData.job.name == "circle" then
                if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) < Config.DrawDistance) then
                    DrawMarker(34, v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z, 0.0, 0.0,
                            0.0, 0, 0.0, 0.0, Config.Markers.EntryPoint.Size.x, Config.Markers.EntryPoint.Size.y,
                            Config.Markers.EntryPoint.Size.z, Config.Markers.EntryPoint.Color.r,
                            Config.Markers.EntryPoint.Color.g, Config.Markers.EntryPoint.Color.b, 100, false, true, 2, false,
                            false, false, false)
                    sleep = 0
                    -- break
                end
            end
        end

        -- parking
        for k, v in pairs(Config.repairPoint) do
            if (#(coords - vector3(v.RepairPoint.x, v.RepairPoint.y, v.RepairPoint.z)) < 5) then
                DrawMarker(Config.Markers.RepairPoint.Type, v.RepairPoint.x, v.RepairPoint.y, v.RepairPoint.z, 0.0, 0.0,
                        0.0, 0, 0.0, 0.0, Config.Markers.RepairPoint.Size.x, Config.Markers.RepairPoint.Size.y,
                        Config.Markers.RepairPoint.Size.z, Config.Markers.RepairPoint.Color.r,
                        Config.Markers.RepairPoint.Color.g, Config.Markers.RepairPoint.Color.b, 100, false, true, 2, false,
                        false, false, false)
                sleep = 0
                -- break
            end
        end

        -- parking
        for k, v in pairs(Config.Parking) do
            if v.job ~= nil then
                --print(v.job,ESX.PlayerData.job.name)
                if v.job ~= ESX.PlayerData.job.name then goto endState end
            end
            if (#(coords - vector3(v.parkingPoint.x, v.parkingPoint.y, v.parkingPoint.z)) < Config.DrawDistance) then
                DrawMarker(Config.Markers.GetOutPoint.Type, v.parkingPoint.x, v.parkingPoint.y, v.parkingPoint.z, 0.0, 0.0,
                        0.0, 0, 0.0, 0.0, Config.Markers.GetOutPoint.Size.x, Config.Markers.GetOutPoint.Size.y,
                        Config.Markers.GetOutPoint.Size.z, Config.Markers.GetOutPoint.Color.r,
                        Config.Markers.GetOutPoint.Color.g, Config.Markers.GetOutPoint.Color.b, 100, false, true, 2, false,
                        false, false, false)
                sleep = 0
                -- break
            end
            ::endState::
        end

        -- Impound
        for k, v in pairs(Config.Impounds) do
            if (#(coords - vector3(v.GetOutPoint.x, v.GetOutPoint.y, v.GetOutPoint.z)) < Config.DrawDistance) then
                DrawMarker(Config.Markers.ImpoundPoint.Type, v.GetOutPoint.x, v.GetOutPoint.y, v.GetOutPoint.z, 0.0, 0.0,
                        0.0, 0, 0.0, 0.0, Config.Markers.ImpoundPoint.Size.x, Config.Markers.ImpoundPoint.Size.y,
                        Config.Markers.ImpoundPoint.Size.z, Config.Markers.ImpoundPoint.Color.r,
                        Config.Markers.ImpoundPoint.Color.g, Config.Markers.ImpoundPoint.Color.b, 100, false, true, 2, false,
                        false, false, false)
                sleep = 0
                break
            end
        end

        -- ImpoundDepartment
        for k, v in pairs(Config.ImpoundDepartment) do
            if ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "ambulance" or ESX.PlayerData.job.name == "circle" then
                if (#(coords - vector3(v.GetOutPoint.x, v.GetOutPoint.y, v.GetOutPoint.z)) < Config.DrawDistance) then
                    DrawMarker(Config.Markers.ImpoundPoint.Type, v.GetOutPoint.x, v.GetOutPoint.y, v.GetOutPoint.z, 0.0, 0.0,
                            0.0, 0, 0.0, 0.0, Config.Markers.ImpoundPoint.Size.x, Config.Markers.ImpoundPoint.Size.y,
                            Config.Markers.ImpoundPoint.Size.z, Config.Markers.ImpoundPoint.Color.r,
                            Config.Markers.ImpoundPoint.Color.g, Config.Markers.ImpoundPoint.Color.b, 100, false, true, 2, false,
                            false, false, false)
                    sleep = 0
                    break
                end
            end
        end

        -- ImpoundDepartment
        for k, v in pairs(Config.ImpoundBoat) do
            --print("impound boat",v.GetOutPoint.x,v.GetOutPoint.y, v.GetOutPoint.z)
            --print(#(coords - vector3(v.GetOutPoint.x, v.GetOutPoint.y, v.GetOutPoint.z)) < Config.DrawDistance)
            if (#(coords - vector3(v.GetOutPoint.x, v.GetOutPoint.y, v.GetOutPoint.z)) < Config.DrawDistance) then
                DrawMarker(35, v.GetOutPoint.x, v.GetOutPoint.y, v.GetOutPoint.z, 0.0, 0.0,
                        0.0, 0, 0.0, 0.0, Config.Markers.ImpoundPoint.Size.x, Config.Markers.ImpoundPoint.Size.y,
                        Config.Markers.ImpoundPoint.Size.z, Config.Markers.ImpoundPoint.Color.r,
                        Config.Markers.ImpoundPoint.Color.g, Config.Markers.ImpoundPoint.Color.b, 100, false, true, 2, false,
                        false, false, false)
                sleep = 0
                break
            end
        end

        for k, v in pairs(Config.GaragesPolice) do
            if ESX.PlayerData.job.name == "police" or  ESX.PlayerData.job.name == "ambulance" then
                if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) < Config.DrawDistance) then
                    DrawMarker(Config.Markers.EntryPoint.Type, v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z, 0.0, 0.0,
                            0.0, 0, 0.0, 0.0, Config.Markers.EntryPoint.Size.x, Config.Markers.EntryPoint.Size.y,
                            Config.Markers.EntryPoint.Size.z, Config.Markers.EntryPoint.Color.r,
                            Config.Markers.EntryPoint.Color.g, Config.Markers.EntryPoint.Color.b, 100, false, true, 2, false,
                            false, false, false)
                    sleep = 0
                    -- break
                end
            end
        end

        for k, v in pairs(Config.GaragesAmbulance) do
            if ESX.PlayerData.job.name == "police" or  ESX.PlayerData.job.name == "ambulance" then
                if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) < Config.DrawDistance) then
                    DrawMarker(Config.Markers.EntryPoint.Type, v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z, 0.0, 0.0,
                            0.0, 0, 0.0, 0.0, Config.Markers.EntryPoint.Size.x, Config.Markers.EntryPoint.Size.y,
                            Config.Markers.EntryPoint.Size.z, Config.Markers.EntryPoint.Color.r,
                            Config.Markers.EntryPoint.Color.g, Config.Markers.EntryPoint.Color.b, 100, false, true, 2, false,
                            false, false, false)
                    sleep = 0
                    -- break
                end
            end
        end

        for k, v in pairs(Config.GaragesCircle) do
            if ESX.PlayerData.job.name == "circle" then
                if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) < Config.DrawDistance) then
                    DrawMarker(Config.Markers.EntryPoint.Type, v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z, 0.0, 0.0,
                            0.0, 0, 0.0, 0.0, Config.Markers.EntryPoint.Size.x, Config.Markers.EntryPoint.Size.y,
                            Config.Markers.EntryPoint.Size.z, Config.Markers.EntryPoint.Color.r,
                            Config.Markers.EntryPoint.Color.g, Config.Markers.EntryPoint.Color.b, 100, false, true, 2, false,
                            false, false, false)
                    sleep = 0
                    -- break
                end
            end
        end

        for k, v in pairs(Config.GaragesBoat) do
            if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) < Config.DrawDistance) then
                DrawMarker(35, v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z, 0.0, 0.0,
                        0.0, 0, 0.0, 0.0, Config.Markers.EntryPoint.Size.x, Config.Markers.EntryPoint.Size.y,
                        Config.Markers.EntryPoint.Size.z, Config.Markers.EntryPoint.Color.r,
                        Config.Markers.EntryPoint.Color.g, Config.Markers.EntryPoint.Color.b, 100, false, true, 2, false,
                        false, false, false)
                sleep = 0
                break
            end
        end

        if sleep == 0 then
            nearMarker = true
        else
            nearMarker = false
        end
        Wait(sleep)
    end
end)


function repairMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
        title    = 'Vehicle Care',
        align    = 'top-right',
        elements = {
            {label = "ซ่อมรถ (500$)",               value = 'repairVehicle'},
            {label = "เคลือบเงา (1000$)",               value = 'repairVehicle'},
            {label = "ล้างรถ (200$)",               value = 'cleanVehicle'},
        }
    }, function(data, menu)
        local action = data.current.value
        if action == 'repairVehicle' then
            repairVehicle()
            TriggerEvent('esx_garage:closemenu')
            menu.close()
        end
        if action == 'cleanVehicle' then
            cleanVehicle()
            TriggerEvent('esx_garage:closemenu')
            menu.close()
        end
        if action == 'waxVehicle' then
            waxVehicle()
            TriggerEvent('esx_garage:closemenu')
            menu.close()
        end
    end, function(data, menu)
        TriggerEvent('esx_garage:closemenu')
        menu.close()
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'CloseCarCaredMenu',
                content = ('ผู้เล่นได้ทำการปิดเมนู car care'):format(),
            })
        end) -- End log
    end)
end

function waxVehicle()
    ESX.TriggerServerCallback('esx_garage:playerCoords', function(coords)
        local vehicle = ESX.Game.GetClosestVehicle(coords)
        if DoesEntityExist(vehicle) then
            exports.CarHud:setCloseUI()
            TriggerEvent("mythic_progbar:client:progress",{
                name = "WaxMode",
                duration = 5000,
                label = "กำลังดำเนินการ",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "amb@world_human_gardener_plant@female@base", -- ท่าทางเวลาขุด
                    anim = "base_female",		-- ท่าทางเวลาขุด
                    flags = 49,
                },
            }, function(status)
                if not status then
                    addVehicleToCleanList(vehicle)
                end
            end)
        end
    end)
end

function addVehicleToCleanList(vh)
    local plate = GetVehicleNumberPlateText(vh)
    ESX.TriggerServerCallback('vehicle:addToCleanList', function(success)
        if success then
            print("Vehicle with plate " .. plate .. " added to clean list.")
        else
            print("Failed to add vehicle with plate " .. plate .. " to clean list.")
        end
    end, plate)
end

function repairVehicle()
    ESX.TriggerServerCallback('esx_garage:playerCoords', function(coords)
        local vehicle = ESX.Game.GetClosestVehicle(coords)
        if DoesEntityExist(vehicle) then
            exports.CarHud:setCloseUI()
            TriggerEvent("mythic_progbar:client:progress",{
                name = "RepairMode",
                duration = 15000,
                label = "กำลังดำเนินการ",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "amb@world_human_gardener_plant@female@base", -- ท่าทางเวลาขุด
                    anim = "base_female",		-- ท่าทางเวลาขุด
                    flags = 49,
                },
            }, function(status)
                if not status then
                    repairSuccess(vehicle)
                end
            end)
        end
    end)
end


RegisterNetEvent('esx_garage:repairVehicle')
AddEventHandler('esx_garage:repairVehicle', function(vehicle,vehicleProps)
    SetVehicleFixed(vehicle)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleUndriveable(vehicle, false)
    SetVehicleEngineOn(vehicle, true, true)
    SetVehiclePetrolTankHealth(vehicle, 1000.0)
    SetVehicleBodyHealth(vehicle, 1000.0)
    SetVehicleEngineHealth(vehicle, 1000.0)
    SetVehicleDirtLevel(vehicle, 0.0)
    exports['cc_legacyfuel']:SetFuel(vehicle, vehicleProps.fuelLevel)
    SetVehicleEngineOn(vehicle,true,true,true)
end)

RegisterNetEvent('esx_garage:cleanVehicle')
AddEventHandler('esx_garage:cleanVehicle', function(vehicle)
    SetVehicleDirtLevel(vehicle, 0.0)
    SetVehicleEngineOn(vehicle,true,true,true)
end)


function repairSuccess(vehicle)
    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
    ESX.TriggerServerCallback('esx_garage:checkRepair', function(haveMoney)
        SetVehicleEngineOn(vehicle,false,true,true)
        if haveMoney then
            repairProcess = false
            exports.nc_notify:PushNotification({
                scale = 1.0, -- ปรับขนาดของ Notify
                title = 'ระบบซ่อมรถ', -- หัวเรื่อง
                description = 'ซ่อมรถสำเร็จแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                icon = 'garage', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                duration = 3000 -- ระยะเวลาการแสดง Notify
            })
        end
    end,500,vehicle,vehicleProps)
    exports.CarHud:setCloseVehicleShop()
end

function cleanSuccess(vehicle)
    ESX.TriggerServerCallback('esx_garage:checkRepair', function(haveMoney)
        SetVehicleEngineOn(vehicle,false,true,true)
        if haveMoney then
            exports.nc_notify:PushNotification({
                scale = 1.0, -- ปรับขนาดของ Notify
                title = 'ระบบล้างรถ', -- หัวเรื่อง
                description = 'ล้างรถสำเร็จแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                icon = 'garage', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                duration = 3000 -- ระยะเวลาการแสดง Notify
            })
        end
    end,200,vehicle)
    exports.CarHud:setCloseVehicleShop()
end

function cleanVehicle()
    ESX.TriggerServerCallback('esx_garage:playerCoords', function(coords)
        local vehicle = ESX.Game.GetClosestVehicle(coords)
        if DoesEntityExist(vehicle) then
            exports.CarHud:setCloseUI()
            TriggerEvent("mythic_progbar:client:progress",{
                name = "RepairMode",
                duration = 10000,
                label = "กำลังดำเนินการ",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "amb@world_human_gardener_plant@female@base", -- ท่าทางเวลาขุด
                    anim = "base_female",		-- ท่าทางเวลาขุด
                    flags = 49,
                },
            }, function(status)
                if not status then
                    cleanSuccess(vehicle)
                end
            end)
        end
    end)
end

function countVehicleCitizen()
    ESX.TriggerServerCallback('esx_garage:getCountVehicle', function(countInGarage,countInPound)
        SendNUIMessage({
            countUI = true,
            countInGarage = countInGarage,
            countInPound = countInPound
        })
    end)
end

function countVehicleDepartment()
    ESX.TriggerServerCallback('esx_garage:getCountVehicleDepartment', function(countInGarage,countInPound)
        SendNUIMessage({
            countUI = true,
            countInGarage = countInGarage,
            countInPound = countInPound
        })
    end)
end

-- Enter / Exit marker events (parking)
CreateThread(function()
    while true do
        if nearMarker then
            local playerPed = ESX.PlayerData.ped
            local coords = GetEntityCoords(playerPed)
            local isInMarker = false
            local currentMarker = nil
            local currentPart = nil
            local currentMarkerHelpNotify = nil

            for k, v in pairs(Config.GaragesTrunk) do
                if (#(coords - vector3(v.TrunkPoint.x, v.TrunkPoint.y, v.TrunkPoint.z)) <
                        Config.Markers.RepairPoint.Size.x) then
                    isInMarker = true
                    currentMarker = k
                    currentPart = 'GetOutPoint'
                    currentMarkerHelpNotify = 'GarageTrunkNoti'
                    local isInVehicle = IsPedInAnyVehicle(playerPed, false)
                    if not isInVehicle then
                        if IsControlJustReleased(0, 38) and not menuIsShowed then
                            exports.helpnotify:hideHelpNotification()
                            ESX.TriggerServerCallback('esx_garage:getVehiclesInTrunk', function(vehicles)
                                if next(vehicles) then
                                    menuIsShowed = true

                                    for i = 1, #vehicles, 1 do
                                        table.insert(vehiclesList, {
                                            model = GetDisplayNameFromVehicleModel(vehicles[i].vehicle.model),
                                            plate = vehicles[i].plate,
                                            props = vehicles[i].vehicle
                                        })

                                    end

                                    local spawnPoint = {
                                        x = 0,
                                        y = 0,
                                        z = 0,
                                        heading = 0
                                    }


                                    SendNUIMessage({
                                        showMenu = true,
                                        type = 'trunkVehicle',
                                        vehiclesList = {json.encode(vehiclesList)},
                                        spawnPoint = spawnPoint,
                                        locales = {
                                            action = TranslateCap('veh_exit'),
                                            veh_model = TranslateCap('veh_model'),
                                            veh_plate = TranslateCap('veh_plate'),
                                            veh_condition = TranslateCap('veh_condition'),
                                            veh_action = TranslateCap('veh_action'),
                                            no_veh_impounded = TranslateCap('no_veh_impounded')
                                        }
                                    })
                                    countVehicleCitizen()
                                    SetNuiFocus(true, true)

                                    --if menuIsShowed then
                                    --                                        ESX.HideUI()
                                    --                                    end
                                else
                                    onNoVehicleInGarrage()
                                end
                            end, currentMarker)
                        end
                    end
                    break
                end
                --ESX.HideUI()
            end

            for k, v in pairs(Config.repairPoint) do
                if (#(coords - vector3(v.RepairPoint.x, v.RepairPoint.y, v.RepairPoint.z)) <
                        Config.Markers.RepairPoint.Size.x) then
                    isInMarker = true
                    currentMarker = k
                    currentPart = 'RepairPoint'
                    currentMarkerHelpNotify = 'RepairHelpNoti'
                    local isInVehicle = IsPedInAnyVehicle(playerPed, false)
                    if isInVehicle then
                        if IsControlJustReleased(0, 38) and not menuIsShowed and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
                            exports.helpnotify:hideHelpNotification()
                            menuIsShowed = true
                            repairMenu()
                            pcall(function() -- Start log
                                exports['azael_dc-serverlogs']:insertData({
                                    event = 'OpenRepaireMenu',
                                    content = ('ผู้เล่นได้ทำการกด E เพื่อเปิด เมนู garage'):format(),
                                })
                            end) -- End log
                        end

                        --if menuIsShowed then
                        --    ESX.HideUI()
                        --end
                    end
                    break
                end
                --ESX.HideUI()
            end

            for k, v in pairs(Config.Parking) do
                if (#(coords - vector3(v.parkingPoint.x, v.parkingPoint.y, v.parkingPoint.z)) < 2.5) then --Config.Markers.GetOutPoint.Size.x
                    isInMarker = true
                    currentMarker = k
                    currentPart = 'EntryPoint'
                    currentMarkerHelpNotify = 'ParkingHelpNoti'
                    local isInVehicle = IsPedInAnyVehicle(playerPed, false)
                    if isInVehicle then
                        if IsControlJustReleased(0, 38) then
                            exports.helpnotify:hideHelpNotification()
                            local vehicle = GetVehiclePedIsIn(playerPed, false)
                            local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                            ESX.TriggerServerCallback('esx_garage:checkVehicleOwner', function(owner)
                                if owner then
                                    TriggerServerEvent('esx_garage:updateOwnedVehicle', true, currentMarker, nil, {vehicleProps = vehicleProps})
                                else
                                    onVehicleNotOwn()
                                end
                            end, vehicleProps.plate)
                            pcall(function() -- Start log
                                exports['azael_dc-serverlogs']:insertData({
                                    event = 'PlayerStoredVehicle',
                                    content = ('ผู้เล่นได้ทำการกด E เพื่อทำการเก็บรถ'):format(),
                                })
                            end) -- End log
                        end
                    end
                end
            end


            for k, v in pairs(Config.GarageCustom) do
                if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) <
                        Config.Markers.EntryPoint.Size.x) then
                    isInMarker = true
                    currentMarker = k
                    currentPart = 'EntryPoint'
                    currentMarkerHelpNotify = 'GarageHelpNoti'
                    local isInVehicle = IsPedInAnyVehicle(playerPed, false)
                    if not isInVehicle then
                        if IsControlJustReleased(0, 38) and not menuIsShowed then
                            exports.helpnotify:hideHelpNotification()
                            ESX.TriggerServerCallback('esx_garage:getVehiclesInParkingCustom', function(vehicles)
                                if next(vehicles) then
                                    menuIsShowed = true

                                    for i = 1, #vehicles, 1 do
                                        table.insert(vehiclesList, {
                                            model = GetDisplayNameFromVehicleModel(vehicles[i].vehicle.model),
                                            plate = vehicles[i].plate,
                                            props = vehicles[i].vehicle
                                        })

                                    end

                                    local spawnPoint = {
                                        x = v.SpawnPoint.x,
                                        y = v.SpawnPoint.y,
                                        z = v.SpawnPoint.z,
                                        heading = v.SpawnPoint.heading
                                    }


                                    SendNUIMessage({
                                        showMenu = true,
                                        type = 'garage',
                                        vehiclesList = {json.encode(vehiclesList)},
                                        spawnPoint = spawnPoint,
                                        locales = {
                                            action = TranslateCap('veh_exit'),
                                            veh_model = TranslateCap('veh_model'),
                                            veh_plate = TranslateCap('veh_plate'),
                                            veh_condition = TranslateCap('veh_condition'),
                                            veh_action = TranslateCap('veh_action'),
                                            no_veh_impounded = TranslateCap('no_veh_impounded')
                                        }
                                    })
                                    countVehicleCitizen()
                                    SetNuiFocus(true, true)

                                    --if menuIsShowed then
                                    --                                        ESX.HideUI()
                                    --                                    end
                                else
                                    onNoVehicleInGarrage()
                                end
                            end, currentMarker)
                        end
                    end
                    break
                end
            end



            for k, v in pairs(Config.Garages) do

                if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) <
                        Config.Markers.EntryPoint.Size.x) then
                    isInMarker = true
                    currentMarker = k
                    currentPart = 'EntryPoint'
                    currentMarkerHelpNotify = 'GarageHelpNoti'
                    local isInVehicle = IsPedInAnyVehicle(playerPed, false)
                    if not isInVehicle then
                        if IsControlJustReleased(0, 38) and not menuIsShowed then
                            pcall(function() -- Start log
                                exports['azael_dc-serverlogs']:insertData({
                                    event = 'OpenGaragedMenu',
                                    content = ('ผู้เล่นได้ทำการกด E เพื่อเปิด เมนู garage'):format(),
                                })
                            end) -- End log
                            exports.helpnotify:hideHelpNotification()
                            ESX.TriggerServerCallback('esx_garage:getVehiclesInParking', function(vehicles)
                                if next(vehicles) then
                                    menuIsShowed = true

                                    for i = 1, #vehicles, 1 do
                                        table.insert(vehiclesList, {
                                            model = GetDisplayNameFromVehicleModel(vehicles[i].vehicle.model),
                                            plate = vehicles[i].plate,
                                            props = vehicles[i].vehicle
                                        })

                                    end

                                    local spawnPoint = {
                                        x = v.SpawnPoint.x,
                                        y = v.SpawnPoint.y,
                                        z = v.SpawnPoint.z,
                                        heading = v.SpawnPoint.heading
                                    }


                                    SendNUIMessage({
                                        showMenu = true,
                                        type = 'garage',
                                        vehiclesList = {json.encode(vehiclesList)},
                                        spawnPoint = spawnPoint,
                                        locales = {
                                            action = TranslateCap('veh_exit'),
                                            veh_model = TranslateCap('veh_model'),
                                            veh_plate = TranslateCap('veh_plate'),
                                            veh_condition = TranslateCap('veh_condition'),
                                            veh_action = TranslateCap('veh_action'),
                                            no_veh_impounded = TranslateCap('no_veh_impounded')
                                        }
                                    })
                                    countVehicleCitizen()
                                    SetNuiFocus(true, true)

                                    --if menuIsShowed then
                                    --                                        ESX.HideUI()
                                    --                                    end
                                else
                                    onNoVehicleInGarrage()
                                end
                            end, currentMarker)
                        end
                    end
                    break
                end
            end



            for k, v in pairs(Config.GaragesBoat) do
                if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) <
                        Config.Markers.EntryPoint.Size.x) then
                    isInMarker = true
                    currentMarker = k
                    currentPart = 'EntryPoint'
                    currentMarkerHelpNotify = 'GarageBoatHelpNoti'
                    local isInVehicle = IsPedInAnyVehicle(playerPed, false)

                    if not isInVehicle then
                        if IsControlJustReleased(0, 38) and not menuIsShowed then
                            exports.helpnotify:hideHelpNotification()
                            ESX.TriggerServerCallback('esx_garage:getVehiclesInParkingBoat', function(vehicles)
                                if next(vehicles) then
                                    menuIsShowed = true
                                    for i = 1, #vehicles, 1 do
                                        table.insert(vehiclesList, {
                                            model = GetDisplayNameFromVehicleModel(vehicles[i].vehicle.model),
                                            plate = vehicles[i].plate,
                                            props = vehicles[i].vehicle
                                        })

                                    end

                                    local spawnPoint = {
                                        x = v.SpawnPoint.x,
                                        y = v.SpawnPoint.y,
                                        z = v.SpawnPoint.z,
                                        heading = v.SpawnPoint.heading
                                    }

                                    SendNUIMessage({
                                        showMenu = true,
                                        type = 'garage',
                                        vehiclesList = {json.encode(vehiclesList)},
                                        spawnPoint = spawnPoint,
                                        locales = {
                                            action = TranslateCap('veh_exit'),
                                            veh_model = TranslateCap('veh_model'),
                                            veh_plate = TranslateCap('veh_plate'),
                                            veh_condition = TranslateCap('veh_condition'),
                                            veh_action = TranslateCap('veh_action'),
                                            no_veh_impounded = TranslateCap('no_veh_impounded')
                                        }
                                    })

                                    countVehicleCitizen()
                                    SetNuiFocus(true, true)

                                    --if menuIsShowed then
                                    --    ESX.HideUI()
                                    --end
                                else
                                    onNoVehicleInGarrage()
                                end
                            end, currentMarker)
                        end
                    end
                    break
                end
            end

            for k, v in pairs(Config.GaragesHelicopterPolice) do
                if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) <
                        Config.Markers.EntryPoint.Size.x) and ESX.PlayerData.job.name == "police" then
                    isInMarker = true
                    currentMarker = k
                    currentPart = 'EntryPoint'
                    currentMarkerHelpNotify = 'PoliceHeliGarageHelpNoti'
                    local isInVehicle = IsPedInAnyVehicle(playerPed, false)

                    if not isInVehicle then
                        if IsControlJustReleased(0, 38) and not menuIsShowed then
                            exports.helpnotify:hideHelpNotification()
                            ESX.TriggerServerCallback('esx_garage:getVehiclesInParkingHelicopterPolice', function(vehicles)
                                if next(vehicles) then
                                    menuIsShowed = true

                                    for i = 1, #vehicles, 1 do
                                        table.insert(vehiclesList, {
                                            model = GetDisplayNameFromVehicleModel(vehicles[i].vehicle.model),
                                            plate = vehicles[i].plate,
                                            props = vehicles[i].vehicle
                                        })

                                    end

                                    local spawnPoint = {
                                        x = v.SpawnPoint.x,
                                        y = v.SpawnPoint.y,
                                        z = v.SpawnPoint.z,
                                        heading = v.SpawnPoint.heading
                                    }
                                    ----print(spawnPoint.x,spawnPoint.y,spawnPoint.z,spawnPoint.heading)
                                    SendNUIMessage({
                                        showMenu = true,
                                        type = 'garage',
                                        vehiclesList = {json.encode(vehiclesList)},
                                        spawnPoint = spawnPoint,
                                        locales = {
                                            action = TranslateCap('veh_exit'),
                                            veh_model = TranslateCap('veh_model'),
                                            veh_plate = TranslateCap('veh_plate'),
                                            veh_condition = TranslateCap('veh_condition'),
                                            veh_action = TranslateCap('veh_action'),
                                            no_veh_impounded = TranslateCap('no_veh_impounded')
                                        }
                                    })
                                    countVehicleDepartment()
                                    SetNuiFocus(true, true)

                                    --if menuIsShowed then
                                    --                                        ESX.HideUI()
                                    --                                    end
                                else
                                    onNoVehicleInGarrage()
                                end
                            end, currentMarker)
                        end
                    end
                    break
                end
            end

            for k, v in pairs(Config.GaragesHelicopterAmbulance) do
                if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) <
                        Config.Markers.EntryPoint.Size.x) and (ESX.PlayerData.job.name == "police" or  ESX.PlayerData.job.name == "ambulance") then
                    isInMarker = true
                    currentMarker = k
                    currentPart = 'EntryPoint'
                    currentMarkerHelpNotify = 'AmbulanceHeliGarageHelpNoti'
                    local isInVehicle = IsPedInAnyVehicle(playerPed, false)

                    if not isInVehicle then
                        if IsControlJustReleased(0, 38) and not menuIsShowed then
                            exports.helpnotify:hideHelpNotification()
                            ESX.TriggerServerCallback('esx_garage:getVehiclesInParkingHelicopterAmbulance', function(vehicles)
                                if next(vehicles) then
                                    menuIsShowed = true

                                    for i = 1, #vehicles, 1 do
                                        table.insert(vehiclesList, {
                                            model = GetDisplayNameFromVehicleModel(vehicles[i].vehicle.model),
                                            plate = vehicles[i].plate,
                                            props = vehicles[i].vehicle
                                        })

                                    end

                                    local spawnPoint = {
                                        x = v.SpawnPoint.x,
                                        y = v.SpawnPoint.y,
                                        z = v.SpawnPoint.z,
                                        heading = v.SpawnPoint.heading
                                    }
                                    --print(spawnPoint.x,spawnPoint.y,spawnPoint.z,spawnPoint.heading)
                                    SendNUIMessage({
                                        showMenu = true,
                                        type = 'garage',
                                        vehiclesList = {json.encode(vehiclesList)},
                                        spawnPoint = spawnPoint,
                                        locales = {
                                            action = TranslateCap('veh_exit'),
                                            veh_model = TranslateCap('veh_model'),
                                            veh_plate = TranslateCap('veh_plate'),
                                            veh_condition = TranslateCap('veh_condition'),
                                            veh_action = TranslateCap('veh_action'),
                                            no_veh_impounded = TranslateCap('no_veh_impounded')
                                        }
                                    })
                                    countVehicleDepartment()
                                    SetNuiFocus(true, true)

                                    --if menuIsShowed then
                                    --                                        ESX.HideUI()
                                    --                                    end
                                else
                                    onNoVehicleInGarrage()
                                end
                            end, currentMarker)
                        end
                    end
                    break
                end
            end

            for k, v in pairs(Config.GaragesCircle) do
                if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) <
                        Config.Markers.EntryPoint.Size.x) and ESX.PlayerData.job.name == "circle" then
                    isInMarker = true
                    currentMarker = k
                    currentPart = 'EntryPoint'
                    currentMarkerHelpNotify = 'CircleGarageHelpNoti'
                    local isInVehicle = IsPedInAnyVehicle(playerPed, false)

                    if not isInVehicle then
                        if IsControlJustReleased(0, 38) and not menuIsShowed then
                            exports.helpnotify:hideHelpNotification()
                            ESX.TriggerServerCallback('esx_garage:getVehiclesInParkingCircle', function(vehicles)
                                if next(vehicles) then
                                    menuIsShowed = true

                                    for i = 1, #vehicles, 1 do
                                        table.insert(vehiclesList, {
                                            model = GetDisplayNameFromVehicleModel(vehicles[i].vehicle.model),
                                            plate = vehicles[i].plate,
                                            props = vehicles[i].vehicle
                                        })

                                    end


                                    local spawnPoint = {
                                        x = v.SpawnPoint.x,
                                        y = v.SpawnPoint.y,
                                        z = v.SpawnPoint.z,
                                        heading = v.SpawnPoint.heading
                                    }

                                    ----print(spawnPoint.x,spawnPoint.y,spawnPoint.z,spawnPoint.heading)
                                    --print(json.encode(vehiclesList))
                                    SendNUIMessage({
                                        showMenu = true,
                                        type = 'garage',
                                        vehiclesList = {json.encode(vehiclesList)},
                                        spawnPoint = spawnPoint,
                                        locales = {
                                            action = TranslateCap('veh_exit'),
                                            veh_model = TranslateCap('veh_model'),
                                            veh_plate = TranslateCap('veh_plate'),
                                            veh_condition = TranslateCap('veh_condition'),
                                            veh_action = TranslateCap('veh_action'),
                                            no_veh_impounded = TranslateCap('no_veh_impounded')
                                        }
                                    })
                                    countVehicleDepartment()
                                    SetNuiFocus(true, true)

                                    --if menuIsShowed then
                                    --                                        ESX.HideUI()
                                    --                                    end
                                else
                                    onNoVehicleInGarrage()
                                end
                            end, currentMarker)
                        end
                    end
                    break
                end
            end


            for k, v in pairs(Config.GaragesHelicopterCircle) do
                if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) <
                        Config.Markers.EntryPoint.Size.x) and ESX.PlayerData.job.name == "circle" then
                    isInMarker = true
                    currentMarker = k
                    currentPart = 'EntryPoint'
                    currentMarkerHelpNotify = 'CircleHeliGarageHelpNoti'
                    local isInVehicle = IsPedInAnyVehicle(playerPed, false)

                    if not isInVehicle then
                        if IsControlJustReleased(0, 38) and not menuIsShowed then
                            exports.helpnotify:hideHelpNotification()
                            ESX.TriggerServerCallback('esx_garage:getVehiclesInParkingHelicopterCircle', function(vehicles)
                                if next(vehicles) then
                                    menuIsShowed = true

                                    for i = 1, #vehicles, 1 do
                                        table.insert(vehiclesList, {
                                            model = GetDisplayNameFromVehicleModel(vehicles[i].vehicle.model),
                                            plate = vehicles[i].plate,
                                            props = vehicles[i].vehicle
                                        })

                                    end

                                    local spawnPoint = {
                                        x = v.SpawnPoint.x,
                                        y = v.SpawnPoint.y,
                                        z = v.SpawnPoint.z,
                                        heading = v.SpawnPoint.heading
                                    }

                                    --print(spawnPoint.x,spawnPoint.y,spawnPoint.z,spawnPoint.heading)
                                    SendNUIMessage({
                                        showMenu = true,
                                        type = 'garage',
                                        vehiclesList = {json.encode(vehiclesList)},
                                        spawnPoint = spawnPoint,
                                        locales = {
                                            action = TranslateCap('veh_exit'),
                                            veh_model = TranslateCap('veh_model'),
                                            veh_plate = TranslateCap('veh_plate'),
                                            veh_condition = TranslateCap('veh_condition'),
                                            veh_action = TranslateCap('veh_action'),
                                            no_veh_impounded = TranslateCap('no_veh_impounded')
                                        }
                                    })
                                    countVehicleDepartment()
                                    SetNuiFocus(true, true)

                                    --if menuIsShowed then
                                    --                                        ESX.HideUI()
                                    --                                    end
                                else
                                    onNoVehicleInGarrage()
                                end
                            end, currentMarker)
                        end
                    end
                    break
                end
            end




            for k, v in pairs(Config.GaragesPolice) do
                if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) <
                        Config.Markers.EntryPoint.Size.x) and (ESX.PlayerData.job.name == "police" or  ESX.PlayerData.job.name == "ambulance") then
                    isInMarker = true
                    currentMarker = k
                    currentPart = 'EntryPoint'
                    currentMarkerHelpNotify = 'PoliceGarageHelpNoti'
                    local isInVehicle = IsPedInAnyVehicle(playerPed, false)

                    if not isInVehicle then
                        if IsControlJustReleased(0, 38) and not menuIsShowed then
                            exports.helpnotify:hideHelpNotification()
                            ESX.TriggerServerCallback('esx_garage:getVehiclesInParkingPolice', function(vehicles)
                                if next(vehicles) then
                                    menuIsShowed = true

                                    for i = 1, #vehicles, 1 do
                                        table.insert(vehiclesList, {
                                            model = GetDisplayNameFromVehicleModel(vehicles[i].vehicle.model),
                                            plate = vehicles[i].plate,
                                            props = vehicles[i].vehicle
                                        })

                                    end

                                    local spawnPoint = {
                                        x = v.SpawnPoint.x,
                                        y = v.SpawnPoint.y,
                                        z = v.SpawnPoint.z,
                                        heading = v.SpawnPoint.heading
                                    }

                                    --print(spawnPoint.x,spawnPoint.y,spawnPoint.z,spawnPoint.heading)
                                    SendNUIMessage({
                                        showMenu = true,
                                        type = 'garage',
                                        vehiclesList = {json.encode(vehiclesList)},
                                        spawnPoint = spawnPoint,
                                        locales = {
                                            action = TranslateCap('veh_exit'),
                                            veh_model = TranslateCap('veh_model'),
                                            veh_plate = TranslateCap('veh_plate'),
                                            veh_condition = TranslateCap('veh_condition'),
                                            veh_action = TranslateCap('veh_action'),
                                            no_veh_impounded = TranslateCap('no_veh_impounded')
                                        }
                                    })
                                    countVehicleDepartment()
                                    SetNuiFocus(true, true)

                                    --if menuIsShowed then
                                    --                                        ESX.HideUI()
                                    --                                    end
                                else
                                    onNoVehicleInGarrage()
                                end
                            end, currentMarker)
                        end
                    end
                    break
                end
            end

            for k, v in pairs(Config.GaragesAmbulance) do
                if (#(coords - vector3(v.EntryPoint.x, v.EntryPoint.y, v.EntryPoint.z)) <  Config.Markers.EntryPoint.Size.x) and (ESX.PlayerData.job.name == "police" or  ESX.PlayerData.job.name == "ambulance") then
                    isInMarker = true
                    currentMarker = k
                    currentPart = 'EntryPoint'
                    currentMarkerHelpNotify = 'AmbulanceGarageHelpNoti'
                    local isInVehicle = IsPedInAnyVehicle(playerPed, false)

                    if not isInVehicle then
                        if IsControlJustReleased(0, 38) and not menuIsShowed then
                            exports.helpnotify:hideHelpNotification()
                            ESX.TriggerServerCallback('esx_garage:getVehiclesInParkingAmbulance', function(vehicles)
                                if next(vehicles) then
                                    menuIsShowed = true

                                    for i = 1, #vehicles, 1 do
                                        table.insert(vehiclesList, {
                                            model = GetDisplayNameFromVehicleModel(vehicles[i].vehicle.model),
                                            plate = vehicles[i].plate,
                                            props = vehicles[i].vehicle
                                        })

                                    end

                                    local spawnPoint = {
                                        x = v.SpawnPoint.x,
                                        y = v.SpawnPoint.y,
                                        z = v.SpawnPoint.z,
                                        heading = v.SpawnPoint.heading
                                    }
                                    --print(spawnPoint.x,spawnPoint.y,spawnPoint.z,spawnPoint.heading)
                                    SendNUIMessage({
                                        showMenu = true,
                                        type = 'garage',
                                        vehiclesList = {json.encode(vehiclesList)},
                                        spawnPoint = spawnPoint,
                                        locales = {
                                            action = TranslateCap('veh_exit'),
                                            veh_model = TranslateCap('veh_model'),
                                            veh_plate = TranslateCap('veh_plate'),
                                            veh_condition = TranslateCap('veh_condition'),
                                            veh_action = TranslateCap('veh_action'),
                                            no_veh_impounded = TranslateCap('no_veh_impounded')
                                        }
                                    })
                                    countVehicleDepartment()
                                    SetNuiFocus(true, true)

                                    --if menuIsShowed then
                                    --                                        ESX.HideUI()
                                    --                                    end
                                else
                                    onNoVehicleInGarrage()
                                end
                            end, currentMarker)
                        end
                    end
                    break
                end
            end

            for k, v in pairs(Config.Impounds) do

                if (#(coords - vector3(v.GetOutPoint.x, v.GetOutPoint.y, v.GetOutPoint.z)) < 2.0)  and not IsPedInAnyVehicle(PlayerPedId(), false) then
                    isInMarker = true
                    currentMarker = k
                    currentPart = 'GetOutPoint'
                    currentMarkerHelpNotify = 'PoundsHelpNoti'

                    if IsControlJustReleased(0, 38) and not menuIsShowed  then
                        exports.helpnotify:hideHelpNotification()
                        ESX.TriggerServerCallback('esx_garage:getVehiclesInPound', function(vehicles)
                            if next(vehicles) then
                                menuIsShowed = true

                                for i = 1, #vehicles, 1 do
                                    table.insert(vehiclesList, {
                                        model = GetDisplayNameFromVehicleModel(vehicles[i].vehicle.model),
                                        plate = vehicles[i].plate,
                                        props = vehicles[i].vehicle
                                    })
                                end

                                local spawnPoint = {
                                    x = v.SpawnPoint.x,
                                    y = v.SpawnPoint.y,
                                    z = v.SpawnPoint.z,
                                    heading = v.SpawnPoint.heading
                                }

                                SendNUIMessage({
                                    showMenu = true,
                                    type = 'impound',
                                    vehiclesList = {json.encode(vehiclesList)},
                                    spawnPoint = spawnPoint,
                                    poundCost = v.Cost,
                                    locales = {
                                        action = TranslateCap('pay_impound'),
                                        veh_model = TranslateCap('veh_model'),
                                        veh_plate = TranslateCap('veh_plate'),
                                        veh_condition = TranslateCap('veh_condition'),
                                        veh_action = TranslateCap('veh_action')
                                    }
                                })
                                countVehicleCitizen()
                                SetNuiFocus(true, true)

                                --if menuIsShowed then
                                --    ESX.HideUI()
                                --end
                            else
                                onNoVehicleInImpound()
                            end
                        end, currentMarker)
                    end
                    break
                end
            end

            for k, v in pairs(Config.ImpoundDepartment) do

                if (#(coords - vector3(v.GetOutPoint.x, v.GetOutPoint.y, v.GetOutPoint.z)) < 2.0) and not IsPedInAnyVehicle(PlayerPedId(), false) then
                    isInMarker = true
                    currentMarker = k
                    currentPart = 'GetOutPoint'
                    currentMarkerHelpNotify = 'PoundsHelpNoti'

                    if IsControlJustReleased(0, 38) and not menuIsShowed then
                        exports.helpnotify:hideHelpNotification()
                        ESX.TriggerServerCallback('esx_garage:getVehiclesInPoundDepartment', function(vehicles)
                            if next(vehicles) then
                                menuIsShowed = true

                                for i = 1, #vehicles, 1 do
                                    table.insert(vehiclesList, {
                                        model = GetDisplayNameFromVehicleModel(vehicles[i].vehicle.model),
                                        plate = vehicles[i].plate,
                                        props = vehicles[i].vehicle
                                    })
                                end

                                local spawnPoint = {
                                    x = v.SpawnPoint.x,
                                    y = v.SpawnPoint.y,
                                    z = v.SpawnPoint.z,
                                    heading = v.SpawnPoint.heading
                                }

                                SendNUIMessage({
                                    showMenu = true,
                                    type = 'impound',
                                    vehiclesList = {json.encode(vehiclesList)},
                                    spawnPoint = spawnPoint,
                                    poundCost = v.Cost,
                                    locales = {
                                        action = TranslateCap('pay_impound'),
                                        veh_model = TranslateCap('veh_model'),
                                        veh_plate = TranslateCap('veh_plate'),
                                        veh_condition = TranslateCap('veh_condition'),
                                        veh_action = TranslateCap('veh_action')
                                    }
                                })
                                countVehicleCitizen()
                                SetNuiFocus(true, true)

                                --if menuIsShowed then
                                --  ESX.HideUI()
                                --end
                            else
                                onNoVehicleInImpound()
                            end
                        end, currentMarker)
                    end
                    break
                end
            end

            for k, v in pairs(Config.ImpoundBoat) do
                --print(v)
                if (#(coords - vector3(v.GetOutPoint.x, v.GetOutPoint.y, v.GetOutPoint.z)) < 2.0) and not IsPedInAnyVehicle(PlayerPedId(), false) then
                    isInMarker = true
                    currentMarker = k
                    currentPart = 'GetOutPoint'
                    currentMarkerHelpNotify = 'PoundsHelpNoti'

                    if IsControlJustReleased(0, 38) and not menuIsShowed then
                        exports.helpnotify:hideHelpNotification()
                        ESX.TriggerServerCallback('esx_garage:getVehiclesInPoundBoat', function(vehicles)
                            if next(vehicles) then
                                menuIsShowed = true

                                for i = 1, #vehicles, 1 do
                                    table.insert(vehiclesList, {
                                        model = GetDisplayNameFromVehicleModel(vehicles[i].vehicle.model),
                                        plate = vehicles[i].plate,
                                        props = vehicles[i].vehicle
                                    })
                                end

                                local spawnPoint = {
                                    x = v.SpawnPoint.x,
                                    y = v.SpawnPoint.y,
                                    z = v.SpawnPoint.z,
                                    heading = v.SpawnPoint.heading
                                }

                                SendNUIMessage({
                                    showMenu = true,
                                    type = 'impound',
                                    vehiclesList = {json.encode(vehiclesList)},
                                    spawnPoint = spawnPoint,
                                    poundCost = v.Cost,
                                    locales = {
                                        action = TranslateCap('pay_impound'),
                                        veh_model = TranslateCap('veh_model'),
                                        veh_plate = TranslateCap('veh_plate'),
                                        veh_condition = TranslateCap('veh_condition'),
                                        veh_action = TranslateCap('veh_action')
                                    }
                                })
                                countVehicleCitizen()
                                SetNuiFocus(true, true)

                                --if menuIsShowed then
                                --  ESX.HideUI()
                                --end
                            else
                                onNoVehicleInImpound()
                            end
                        end, currentMarker)
                    end
                    break
                end
            end

            if isInMarker and not HasAlreadyEnteredMarker or
                    (isInMarker and (LastMarker ~= currentMarker or LastPart ~= currentPart)) then

                if LastMarker ~= currentMarker or LastPart ~= currentPart then
                    TriggerEvent('esx_garage:hasExitedMarker')
                end

                HasAlreadyEnteredMarker = true
                LastMarker = currentMarker
                LastPart = currentPart

                TriggerEvent('esx_garage:hasEnteredMarker', currentMarker, currentPart)
                TriggerEvent('esx_garage:hasEnteredMarkerHelpNotify', currentMarkerHelpNotify)
            end

            if not isInMarker and HasAlreadyEnteredMarker then
                HasAlreadyEnteredMarker = false
                ESX.UI.Menu.CloseAll()
                TriggerEvent('esx_garage:hasExitedMarker')
            end

            Wait(0)
        else
            Wait(500)
        end
    end
end)



function onNoVehicleInImpound()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบอิมพาว', -- หัวเรื่อง
        description = 'คุณไม่มียานพาหนะอยู่ในพาว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_vehicle', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function onNoVehicleInGarrage()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบโรงรถ', -- หัวเรื่อง
        description = 'คุณไม่มียานพาหนะอยู่ในการาจ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_vehicle', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function onVehicleNotOwn()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบโรงรถ', -- หัวเรื่อง
        description = 'คุณไม่ได้เป็นเจ้าของยานพาหนะ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_garage', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function onNoMoneyToPound()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบอิมพาว', -- หัวเรื่อง
        description = 'คุณมีเงินไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

AddEventHandler('esx:onPlayerDeath', function()
    if inSpawn then
        TriggerEvent("mythic_progbar:client:cancel")
    end
end)