local spawnedVehicles = {}
local CurrentActionData = {}
local HasAlreadyEnteredMarker, isDead = false, false
local LastStation, LastPart, LastPartNum, CurrentAction, CurrentActionMsg
 isInShopMenu = false
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

AddEventHandler('cc_circlejob:hasEnteredMarker', function(station, part, partNum)
    --print(part)
    if part == 'Vehicles' then
        CurrentAction     = 'menu_vehicle_spawner'
        CurrentActionMsg  = ""
        CurrentActionData = {station = station, part = part, partNum = partNum}
    elseif part == 'Helicopters' then
        CurrentAction     = 'Helicopters'
        CurrentActionMsg  = ""
        CurrentActionData = {station = station, part = part, partNum = partNum}
    end
end)

AddEventHandler('cc_circlejob:hasExitedMarker', function(station, part, partNum)
    if not isInShopMenu then
        ESX.CloseContext()
    end
    CurrentAction = nil
end)

ESX.RegisterInput("circle:circlejob", "(ESX circlejob) Quick Actions", "keyboard", "F6", function()
    if not ESX.PlayerData.job or (ESX.PlayerData.job.name ~= 'circle') or isDead then
        return
    end
    openCircleMenu()
end)


ESX.RegisterInput("circle:interact", "(ESX circle) Interact", "keyboard", "E", function()
    if not CurrentAction then
        return
    end

    if not ESX.PlayerData.job or (ESX.PlayerData.job and not ESX.PlayerData.job.name == 'circle') then
        return
    end
    if CurrentAction == 'menu_vehicle_spawner' then
        OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
    end
    if CurrentAction == 'Helicopters' then
        OpenVehicleSpawnerMenu('helicopter', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
    end
end)

CreateThread(function()
    while true do
        local Sleep = 1500
        --print(ESX.PlayerData.job.name)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'circle' then
            Sleep = 500
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local isInMarker, hasExited = false, false
            local currentStation, currentPart, currentPartNum
            for k,v in pairs(Config.CircleStation) do
                for i=1, #v.Vehicles, 1 do
                    local distance = #(playerCoords - v.Vehicles[i].Spawner)
                    --print(v.Vehicles[i].Spawner)
                    --print(distance)
                    --print(distance < Config.DrawDistance)
                    if distance < Config.DrawDistance then
                        DrawMarker(Config.MarkerType.Vehicles, v.Vehicles[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
                        Sleep = 0
                        if distance < Config.MarkerSize.x then
                            isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Vehicles', i
                            exports.helpnotify:showHelpNotification("กด","E","เพื่อซื้อรถ")
                        end
                    end
                end

                for i=1, #v.Helicopters, 1 do
                    local distance =  #(playerCoords - v.Helicopters[i].Spawner)

                    if distance < Config.DrawDistance then
                        DrawMarker(Config.MarkerType.Helicopters, v.Helicopters[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
                        Sleep = 0

                        if distance < Config.MarkerSize.x then
                            isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Helicopters', i
                            exports.helpnotify:showHelpNotification("กด","E","เพื่อซื้อฮอ")
                        end
                    end
                end
            end

            if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
                if
                (LastStation and LastPart and LastPartNum) and
                        (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
                then
                    TriggerEvent('cc_circlejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
                    hasExited = true
                end

                HasAlreadyEnteredMarker = true
                LastStation             = currentStation
                LastPart                = currentPart
                LastPartNum             = currentPartNum

                TriggerEvent('cc_circlejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
            end

            if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
                HasAlreadyEnteredMarker = false
                exports.helpnotify:hideHelpNotification()
                TriggerEvent('cc_circlejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
            end
        end
        Wait(Sleep)
    end
end)

function openCircleMenu()
    ESX.UI.Menu.CloseAll()
        ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'circle_menu',
                {
                    title    = 'Circle Menu',
                    align    = 'top-right',
                    elements = {
                        {label = 'ตรวจสอบประชาชน',	value = 'citizen_interaction'},
                        {label = 'ล็อค/ปลดล็อคมือ',	value = 'handcuff'},
                        {label = 'ลาก',	value = 'drag'},
                        {label = 'ค้นตัว',	value = 'body_search'},
                        {label = 'On Duty', value = 'check_player'}
                    }
                },
                function(data, menu)
                    local selectedAction = data.current.value
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 1.5 then
                        if selectedAction == "citizen_interaction" then
                            pcall(function()
                                exports.cc_checkidentify:getIdentifyPlayer(GetPlayerServerId(closestPlayer))
                            end )
                            menu.close()
                        end
                        if selectedAction == "body_search" then
                            if ESX.PlayerData.job.grade ~= 0 then
                                pcall(function() exports.nc_inventory:SearchInventory(GetPlayerServerId(closestPlayer),'circle') end)
                                menu.close()
                            end
                        end
                        if selectedAction == "handcuff" then
                                local playerheading = GetEntityHeading(GetPlayerPed(-1))
                                local playerlocation = GetEntityForwardVector(PlayerPedId())
                                local playerCoords = GetEntityCoords(GetPlayerPed(-1))
                                TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer), playerheading, playerCoords, playerlocation)
                        end
                        if selectedAction == "drag" then
                                TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
                        end
                    end
                    if selectedAction == "check_player" then
                        menu.close()
                        exports.cc_optionduty:checkOnDutyPlayer("circle")
                    end
                end ,
                function(data, menu)
                    menu.close()
                end
        )
end

function CreateBilling(player)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog_createbill',
            {
                title = "ใส่ชื่อบิล",
            }, function(data, menu)
                --local length = string.len(data.value)
                if data.value == nil then
                    onNoInfo()
                else
                    createBillingCircle(player, data.value)
                    menu.close()
                end
            end, function(data, menu)
                menu.close()
            end)
end

function createBillingCircle(player, value)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog_createbill_price',
            {
                title = "ใส่จำนวนเงิน",
            }, function(data2, menu2)
                --local length = string.len(data.value)
                if tonumber(data2.value) then
                    ESX.TriggerServerCallback('esx_billing:sendBill', function()
                        onSendBill()
                    end,GetPlayerServerId(player), 'circle',"Fine: "..value, tonumber(data2.value))
                    menu2.close()
                else
                    onNoFineMoney()
                end
            end, function(data2, menu2)
                menu2.close()
            end)
end

function OpenFineMenu(player)
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine',
            {
                title    = "สั่งจ่ายบิล",
                align    = 'top-right',
                elements = {
                    {label = "สร้างบิล",   value = 'create_bills'}
                }
            }, function(data, menu)
                CreateBilling(player)
                -- OpenFineCategoryMenu(player, data.current.value)
            end, function(data, menu)
                menu.close() end)
end

function OpenVehicleSpawnerMenu(type, station, part, partNum)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local elements = {
        {unselectable = true, icon = "fas fa-car", title = "ร้านค้ารถ Circle"},
        {icon = "fas fa-car", title = 'ซื้อรถประจำตำแหน่ง', action = 'buy_vehicle'}
    }

    ESX.OpenContext("right", elements, function(menu,element)
        if element.action == "buy_vehicle" then
            local shopElements = {}
            local shopCoords = Config.CircleStation[station][part][partNum].InsideShop
            local authorizedVehicles = Config.AuthorizedVehicles[type][ESX.PlayerData.job.grade_name]

            if authorizedVehicles then
                if #authorizedVehicles > 0 then
                    for k,vehicle in ipairs(authorizedVehicles) do
                        if IsModelInCdimage(vehicle.model) then
                            local vehicleLabel = GetLabelText(GetDisplayNameFromVehicleModel(vehicle.model))

                            shopElements[#shopElements+1] = {
                                icon = 'fas fa-car',
                                title = ('%s - <span style="color:green;">%s</span>'):format(vehicleLabel, "ราคา : ".. ESX.Math.GroupDigits(vehicle.price)),
                                name  = vehicleLabel,
                                model = vehicle.model,
                                price = vehicle.price,
                                props = vehicle.props,
                                type  = type
                            }
                        end
                    end

                    if #shopElements > 0 then
                        OpenShopMenu(shopElements, playerCoords, shopCoords)
                    else

                    end
                else

                end
            end
        end
    end, function()
        isInShopMenu = false
        ESX.CloseContext()
    end)
end

function OpenShopMenu(elements, restoreCoords, shopCoords)
    local playerPed = PlayerPedId()
    isInShopMenu = true
    ESX.OpenContext("right", elements, function(menu,element)
        local elements2 = {
            {unselectable = true, icon = "fas fa-car", title = element.title},
            {icon = "fas fa-eye", title = "View", value = "view"}
        }

        ESX.OpenContext("right", elements2, function(menu2,element2)
            if element2.value == "view" then
                DeleteSpawnedVehicles()
                WaitForVehicleToLoad(element.model)

                ESX.Game.SpawnLocalVehicle(element.model, shopCoords, 0.0, function(vehicle)
                    table.insert(spawnedVehicles, vehicle)
                    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                    FreezeEntityPosition(vehicle, true)
                    SetModelAsNoLongerNeeded(element.model)

                    if element.props then
                        ESX.Game.SetVehicleProperties(vehicle, element.props)
                    end
                end)

                local elements3 = {
                    {unselectable = true, icon = "fas fa-car", title = element.title},
                    {icon = "fas fa-check-double", title = "Buy", value = "buy"},
                    {icon = "fas fa-eye", title = "Stop Viewing", value = "stop"}
                }

                ESX.OpenContext("right", elements3, function(menu3,element3)
                    if element3.value == 'stop' then
                        isInShopMenu = false
                        ESX.CloseContext()

                        DeleteSpawnedVehicles()
                        FreezeEntityPosition(playerPed, false)
                        SetEntityVisible(playerPed, true)

                        ESX.Game.Teleport(playerPed, restoreCoords)
                    elseif element3.value == "buy" then
                        local newPlate = exports['esx_vehicleshop']:GeneratePlate()
                        local vehicle  = GetVehiclePedIsIn(playerPed, false)
                        local props    = ESX.Game.GetVehicleProperties(vehicle)
                        props.plate    = newPlate

                        ESX.TriggerServerCallback('cc_circlejob:buyJobVehicle', function (bought)
                            if bought then
                                onBuyPDVehicleSuccess()
                                isInShopMenu = false
                                ESX.CloseContext()
                                DeleteSpawnedVehicles()
                                FreezeEntityPosition(playerPed, false)
                                SetEntityVisible(playerPed, true)
                                exports.nc_inventory:UpdateItems('vehicle_key')
                                ESX.Game.Teleport(playerPed, restoreCoords)
                            else
                                onBuyPDVehicleNoMoney()
                                ESX.CloseContext()
                            end
                        end, props, element.type)
                    end
                end, function()
                    isInShopMenu = false
                    ESX.CloseContext()

                    DeleteSpawnedVehicles()
                    FreezeEntityPosition(playerPed, false)
                    SetEntityVisible(playerPed, true)

                    ESX.Game.Teleport(playerPed, restoreCoords)
                end)
            end
        end,function()
            isInShopMenu = false
            ESX.CloseContext()
        end)
    end,function()
        isInShopMenu = false
        ESX.CloseContext()
    end)
end

function openIdentifyCard(player)
    ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
        TriggerEvent("cc_uicard:showCardClosetPlayer",data)
    end, GetPlayerServerId(player))
end

CreateThread(function()
    while true do
        Wait(0)
        if isInShopMenu then
            DisableControlAction(0, 75, true)  -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
        else
            Wait(500)
        end
    end
end)

function DeleteSpawnedVehicles()
    while #spawnedVehicles > 0 do
        local vehicle = spawnedVehicles[1]
        ESX.Game.DeleteVehicle(vehicle)
        table.remove(spawnedVehicles, 1)
    end
end

function WaitForVehicleToLoad(modelHash)
    modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
            Wait(0)
            DisableAllControlActions(0)
        end

        BusyspinnerOff()
    end
end


function onBuyPDVehicleNoMoney()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบส่วนกลาง', -- หัวเรื่อง
        description = 'เงินไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function onBuyPDVehicleSuccess()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบส่วนกลาง', -- หัวเรื่อง
        description = 'ซื้อยานพาหนะหน่วยงานสำเร็จ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'vehicle', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function onNoInfo()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบบิล', -- หัวเรื่อง
        description = 'กรุณาใส่รายละเอียด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'detail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end


function onNoFineMoney()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบบิล', -- หัวเรื่อง
        description = 'กรุณาใส่จำนวนเงิน', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'bill', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end


function onSendBill()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบบิล', -- หัวเรื่อง
        description = 'สร้างบิลเรียบร้อยแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'bill', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end


AddEventHandler('esx:onPlayerSpawn', function(spawn)
    isDead = false
    --TriggerEvent('esx_policejob:unrestrain')
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    isDead = true
end)