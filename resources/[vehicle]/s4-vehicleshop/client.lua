
curGarage = nil
vehicle = nil
rgb = {}
spawnedVehs = {}

curVehName = ""

Citizen.CreateThread(function()
    for k,va in pairs(Config.Vehicles) do
        for i,v in pairs(Config.Vehicles[k]) do
            if k == "super" then
                v.fuel = math.random(80, 100)
                v.consumption = 3
                v.trunk = Config.TrunkCapacity
            elseif k == "vans" then
                v.fuel = math.random(80, 100)
                v.consumption = 2
                v.trunk = Config.TrunkVanCapacity
            else
                v.fuel = math.random(80, 100)
                v.consumption = 1
                v.trunk = Config.TrunkCapacity
            end
        end
    end

end)

local dealerZoneA = CircleZone:Create(vector3(-56.403923797607, -1096.7048095703, 26.422355651855), 1.5, {
    name="dealer_zone_a",
})

local dealerZoneb = CircleZone:Create(vector3(-861.8800048828125, -1323.8900146484375, 1.61000001430511), 1.5, {
    name="dealer_zone_b",
})

local comboDealer = ComboZone:Create({dealerZoneA, dealerZoneb}, {name="combo_dealer", debugPoly=false})
comboDealer:onPlayerInOut(function(isPointInside, point)
    if isPointInside then
        exports.helpnotify:showHelpNotification("กด","E","เพื่อเข้าโชว์รูม")
    else
        exports.helpnotify:hideHelpNotification()
    end
end)

local czas = 1000
Citizen.CreateThread(function()
    while true do
        if czas == 0 then
            Citizen.Wait(5000)
            czas = 1000
        else
            Citizen.Wait(5000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0+czas)
        local plyCoords = GetEntityCoords(PlayerPedId())

        for k,v in pairs(Config.Shops) do
            if GetDistanceBetweenCoords(plyCoords, v.coord)  <= v.dist then
                DrawMarker(Config.Type,v.coord.x, v.coord.y, v.coord.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
            end

            if GetDistanceBetweenCoords(plyCoords, v.coord) <= 1.5 then
                if IsControlJustPressed(1, 38) then
                    initGarage(k)
                    pcall(function() -- Start log
                        exports['azael_dc-serverlogs']:insertData({
                            event = 'OpenCarDealershipMenu',
                            content = ('ผู้เล่นได้ทำการกด E เพื่อเปิดใช้งานเมนูซื้อรถ'):format(),
                        })
                    end) -- End log
                    Wait(1500)
                end
            end

            if GetDistanceBetweenCoords(plyCoords, v.coord)  <= v.dist then
                if k then
                    czas = 0
                else
                    czas = 1000
                end
            end

        end
    end
end)

cam = nil

function initGarage(x)
    curGarage = Config.Shops[x]
    SetEntityVisible(PlayerPedId(), 0)
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
    SetCamCoord(cam, curGarage.camCoord)
    SetCamRot(cam, curGarage.camRot, 2)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1)
    SendNUIMessage({ action = "load", garage = curGarage })
    SetNuiFocus(1, 1)
    DisplayRadar(0)
    exports.CarHud:setCloseUI()
end



function destroyCam()
    if DoesCamExist(cam) then
        DestroyCam(cam, true)
        RenderScriptCams(false, true, 1)
        cam = nil
    end
end

RegisterNUICallback("close", function(data, cb)
    --SetPedCoordsKeepVehicle(PlayerPedId(), curGarage.coord)
    SetEntityCoords(PlayerPedId(), curGarage.coord)
    DisplayRadar(0)
    SetNuiFocus(0, 0)
    destroyCam()
    SetEntityVisible(PlayerPedId(), 1)
    deleteLastCar()
    exports.CarHud:setCloseVehicleShop()
    pcall(function() -- Start log
        exports['azael_dc-serverlogs']:insertData({
            event = 'CloseCarDealershipMenu',
            content = ('ผู้เล่นได้ทำการปิดเมนูซื้อรถ'):format(),
        })
    end) -- End log
end)


RegisterNUICallback("testdrive", function(data, cb)
    SetNuiFocus(0, 0)
    SetEntityVisible(PlayerPedId(), 1)
    destroyCam()
    exports.CarHud:setCloseVehicleShop()
    startTestDrive()
end)

isTestDriving = false
function startTestDrive(dealer_object)
    if isTestDriving then
        return
    end
    if vehicle and DoesEntityExist(vehicle) then
        FreezeEntityPosition(vehicle,false)
        SetVehicleUndriveable(vehicle,false)
        SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
        SetPedCoordsKeepVehicle(PlayerPedId(), Config.TestDrive.coords)
        SendNUIMessage({ action = "startTest" })
    end
    local finished = nil
    CreateThread(function()
        local start = GetGameTimer()/1000
        exports.helpnotify:showHelpNotification("กด", "Backspace", "เพื่อยกเลิก")
        ESX.Game.SetVehicleProperties(vehicle, { engineHealth = 999.5, fuelLevel = 99.5, modTurbo = 1, modArmor = 4, modEngine = 3, modTransmission = 2, modBrakes = 2, modSuspension = 3 })
        while GetGameTimer()/1000 - start < Config.TestDrive.seconds and DoesEntityExist(vehicle) and not IsEntityDead(PlayerPedId()) do
            if #(GetEntityCoords(PlayerPedId()) - Config.TestDrive.coords) > Config.TestDrive.range then
                SetPedCoordsKeepVehicle(PlayerPedId(), Config.TestDrive.coords)
            end
            if GetVehiclePedIsIn(PlayerPedId(), false) == 0 and DoesEntityExist(vehicle) then
                SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
            end
            if IsControlJustPressed(0, 177) then -- 200 is the control code for ESC key
                break -- Exit the loop
            end
            Wait(0)
        end
        exports.helpnotify:hideHelpNotification()
        SetPedCoordsKeepVehicle(PlayerPedId(), curGarage.carSpawnCoord)
        FreezeEntityPosition(vehicle, true)
        SetVehicleUndriveable(vehicle, true)
        ClearPedTasksImmediately(PlayerPedId())
        SetEntityCoords(PlayerPedId(), curGarage.coord)
        finished = true
        SendNUIMessage({ action = "stopTest" })
        deleteLastCar()
    end)
    while finished == nil or not finished do
        Wait(0)
    end
    return
end


RegisterNUICallback("moveright", function(data)
    moveCarRight(2)
end)

RegisterNUICallback("moveleft", function(data)
    moveCarLeft(2)
end)


RegisterNUICallback("buy", function(data, cb)
    local PlayerPed = PlayerPedId()
    --print(curVehName)
    local veh = getVehicleFromName(curVehName)
    --print(ESX.DumpTable(veh))
    if not ESX.Game.IsSpawnPointClear(curGarage.deliveryCoord, 2.5) then
        exports.nc_notify:PushNotification({
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบร้านขายรถ', -- หัวเรื่อง
            description = 'คุณซื้อรถไม่สำเร็จเนื่องจากมีสิ่งกีดขวางอยู่', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'bottom', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'block', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 3000 -- ระยะเวลาการแสดง Notify
        })
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PLayerCanNotBuyCarSomethingBlockTheWay',
                content = ('ผู้เล่นไม่สามารถซื้อรถได้เนื่องจากมีสิ่งกีดขวางอยู่ในที่ Spawn รถ'):format(),
            })
        end) -- End log
        return
    end
    ESX.TriggerServerCallback("s4-vehicleshop:checkPrice", function(pg)
        if pg == true then
            Citizen.CreateThread(function()
                RequestModel(GetHashKey(veh.name))
                while not HasModelLoaded(GetHashKey(veh.name)) do
                    Wait(1000)
                end
                DoScreenFadeOut(800)
                while not IsScreenFadedOut() do
                    Wait(50)
                end
                SetEntityCoords(PlayerPedId(), curGarage.deliveryCoord)
                DoScreenFadeIn(800)
                Wait(100)
                ESX.Game.SpawnVehicle(GetHashKey(veh.name), curGarage.deliveryCoord, 81.36, function(xVehicle)
                    --local xVehicle = CreateVehicle(veh.name, curGarage.deliveryCoord, true, false)
                    local newPlate = GeneratePlate()
                    --print("test : ",newPlate)
                    local  vehicleClass = GetVehicleClassFromName(veh.name)
                    local vehicleType = ""
                    if vehicleClass == 14 then
                        vehicleType = "boat"
                    elseif vehicleClass == 15 or vehicleClass == 16 then
                        vehicleType = "aircraft"
                    elseif vehicleClass == 16   then --vehicleClass == 17 or vehicleClass == 18 or vehicleClass == 19 or vehicleClass == 20
                        vehicleType = "commercial"
                    else
                        vehicleType = "car"
                    end
                    exports['cc_legacyfuel']:SetFuel(xVehicle, 100.0)
                    SetVehicleNumberPlateText(xVehicle, newPlate)
                    SetVehicleCustomPrimaryColour(xVehicle, tonumber(rgb.r), tonumber(rgb.g), tonumber(rgb.b))
                    SetVehicleCustomSecondaryColour(xVehicle, tonumber(rgb.r), tonumber(rgb.g), tonumber(rgb.b))
                    SetPedIntoVehicle(PlayerPed, xVehicle, -1)
                    Wait(100)
                    TriggerServerEvent('s4-vehicleshop:server:givecar', ESX.Game.GetVehicleProperties(xVehicle), vehicleType, newPlate)
                    rgb = {}
                    DisplayRadar(0)
                    SetNuiFocus(0, 0)
                    destroyCam()
                    SetEntityVisible(PlayerPed, 1)
                    deleteLastCar()
                    exports.CarHud:setCloseVehicleShop()
                    exports.nc_inventory:UpdateItems('vehicle_key')
                end)
            end)
            Wait(500)
            cb(pg)
        else
            cb(false)
        end
    end, { price = veh.price , name = veh.name }) --, blackMoney = blackMoney
end)

RegisterNUICallback("buyCredit", function(data, cb)
    local PlayerPed = PlayerPedId()
    --print(curVehName)
    local veh = getVehicleFromName(curVehName)
    --print(ESX.DumpTable(veh))
    if not ESX.Game.IsSpawnPointClear(curGarage.deliveryCoord, 2.5) then
        exports.nc_notify:PushNotification({
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบร้านขายรถ', -- หัวเรื่อง
            description = 'คุณซื้อรถไม่สำเร็จเนื่องจากมีสิ่งกีดขวางอยู่', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'bottom', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'block', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 3000 -- ระยะเวลาการแสดง Notify
        })
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PLayerCanNotBuyCarSomethingBlockTheWay',
                content = ('ผู้เล่นไม่สามารถซื้อรถได้เนื่องจากมีสิ่งกีดขวางอยู่ในที่ Spawn รถ'):format(),
            })
        end) -- End log
        return
    end
    ESX.TriggerServerCallback("s4-vehicleshop:checkCredit", function(pg)
        if pg == true then
            Citizen.CreateThread(function()
                RequestModel(GetHashKey(veh.name))
                while not HasModelLoaded(GetHashKey(veh.name)) do
                    Wait(1000)
                end
                DoScreenFadeOut(800)
                while not IsScreenFadedOut() do
                    Wait(50)
                end
                SetEntityCoords(PlayerPedId(), curGarage.deliveryCoord)
                DoScreenFadeIn(800)
                Wait(100)
                ESX.Game.SpawnVehicle(GetHashKey(veh.name), curGarage.deliveryCoord, 81.36, function(xVehicle)
                    --local xVehicle = CreateVehicle(veh.name, curGarage.deliveryCoord, true, false)
                    local newPlate = GeneratePlate()
                    local  vehicleClass = GetVehicleClassFromName(veh.name)
                    local vehicleType = ""

                    if vehicleClass == 14 then
                        vehicleType = "boat"
                    elseif vehicleClass == 15 or vehicleClass == 16 then
                        vehicleType = "aircraft"
                    elseif vehicleClass == 16   then --vehicleClass == 17 or vehicleClass == 18 or vehicleClass == 19 or vehicleClass == 20
                        vehicleType = "commercial"
                    else
                        vehicleType = "car"
                    end
                    exports['cc_legacyfuel']:SetFuel(xVehicle, 100.0)
                    --print("test : ",newPlate)
                    SetVehicleNumberPlateText(xVehicle, newPlate)
                    SetVehicleCustomPrimaryColour(xVehicle, tonumber(rgb.r), tonumber(rgb.g), tonumber(rgb.b))
                    SetVehicleCustomSecondaryColour(xVehicle, tonumber(rgb.r), tonumber(rgb.g), tonumber(rgb.b))
                    SetPedIntoVehicle(PlayerPed, xVehicle, -1)
                    Wait(100)
                    TriggerServerEvent('s4-vehicleshop:server:givecar', ESX.Game.GetVehicleProperties(xVehicle),vehicleType, newPlate)
                    rgb = {}
                    Wait(500)
                    DisplayRadar(0)
                    SetNuiFocus(0, 0)
                    destroyCam()
                    SetEntityVisible(PlayerPed, 1)
                    deleteLastCar()
                    exports.CarHud:setCloseVehicleShop()
                    exports.nc_inventory:UpdateItems('vehicle_key')
                end)
            end)
            Wait(500)
            cb(pg)
        else
            cb(false)
        end
    end, { price = veh.price , name = veh.name }) --, blackMoney = blackMoney
end)

-- RegisterNUICallback('buy', function(data, cb)
--     local PlayerPed = PlayerPedId()
--     blackMoney = data.blackMoney 
--     ESX.TriggerServerCallback('s4-vehicleshop:checkPrice', function(pg)
--         local veh = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
--         if pg == true then
--             Citizen.CreateThread(function()
--                 RequestModel(GetHashKey(veh))
--                 while not HasModelLoaded(GetHashKey(veh)) do
--                     Citizen.Wait(2000)
--                 end
--                 local xVehicle = CreateVehicle(GetHashKey(veh), curGarage.deliveryCoord, true, true)
--                 local VehicleProps = ESX.Game.GetVehicleProperties(xVehicle)
--                 SetPedIntoVehicle(PlayerPed, xVehicle, -1)
--                 SetVehicleNumberPlateText(xVehicle, GetVehicleNumberPlateText(vehicle))
--                 SetVehicleCustomPrimaryColour(xVehicle, tonumber(rgb.r), tonumber(rgb.g), tonumber(rgb.b))
--                 SetVehicleCustomSecondaryColour(xVehicle, tonumber(rgb.r), tonumber(rgb.g), tonumber(rgb.b))
--                 TriggerServerEvent('s4-vehicleshop:server:givecar', VehicleProps)
--                 rgb = {}
--                 DisplayRadar(1)
--                 SetNuiFocus(0, 0)
--                 destroyCam()
--                 SetEntityVisible(PlayerPed, 1)
--                 deleteLastCar() 
--             end)
--             Citizen.Wait(20)
--             cb(pg) 
--         else
--             cb(false)
--         end
--     end, { price = 100, blackMoney = blackMoney })
-- end)

function getVehicleFromName(x)
    for k,va in pairs(curGarage.Vehicles) do
        for i,v in pairs(curGarage.Vehicles[k]) do
            if v.name == x then
                return v
            end
        end
    end
end

RegisterNUICallback("checkPlatePrice", function(data, cb)
    plate = data.plate
    ESX.TriggerServerCallback("s4-vehicleshop:checkPlatePrice", function(pg)  cb(pg) if pg == true then SetVehicleNumberPlateText(vehicle, plate) end end, plate)
end)

function moveCarRight(value)
    if vehicle and DoesEntityExist(vehicle) then
        SetEntityRotation(vehicle, GetEntityRotation(vehicle) + vector3(0,0,value), false, false, 2, false)
    end
end

function moveCarLeft(value)
    if vehicle and DoesEntityExist(vehicle) then
        SetEntityRotation(vehicle, GetEntityRotation(vehicle) - vector3(0,0,value), false, false, 2, false)
    end
end

RegisterNUICallback("setcolour", function(data)
    if DoesEntityExist(vehicle) then
        rgb = data.rgb
        SetVehicleCustomPrimaryColour(vehicle, tonumber(data.rgb.r), tonumber(data.rgb.g), tonumber(data.rgb.b))
    end
end)

RegisterNUICallback("showCar", function(data, cb) showCar(data.name) end)

function deleteLastCar()
    for i,v in pairs(spawnedVehs) do
        if DoesEntityExist(v) then
            DeleteEntity(v)
        end
        table.remove(spawnedVehs, i)
    end
    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
        vehicle = nil
    end
end

function showCar(modelName)
    local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))

    Citizen.CreateThread(function()
        deleteLastCar()
        local modelHash = model
        modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

        if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
            RequestModel(modelHash)

            while not HasModelLoaded(modelHash) do
                Citizen.Wait(1)
            end
        end

        vehicle = CreateVehicle(model, curGarage.carSpawnCoord, false, false)
        curVehName = modelName
        SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
        table.insert(spawnedVehs, vehicle)
        local timeout = 0

        SetEntityAsMissionEntity(vehicle, true, false)
        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
        SetVehicleNeedsToBeHotwired(vehicle, false)
        SetVehRadioStation(vehicle, 'OFF')
        SetModelAsNoLongerNeeded(model)
        RequestCollisionAtCoord(curGarage.carSpawnCoord.x, curGarage.carSpawnCoord.y, curGarage.carSpawnCoord.z)

        while not HasCollisionLoadedAroundEntity(vehicle) and timeout < 2000 do
            Citizen.Wait(0)
            timeout = timeout + 1
        end

        if cb then
            cb(vehicle)
        end
    end)
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 250
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
