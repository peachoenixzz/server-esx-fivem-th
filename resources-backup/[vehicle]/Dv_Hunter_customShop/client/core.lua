local uiOpen = false

customCamMain = nil
customCamSec = nil
customConfigPosIndex = nil
customVehicle = nil
customVehiclePrice = nil
customVehicleData = nil
local vehicle_damage = nil
local renderingScriptCam = false
checkcar = nil
isOpenByAdmin = false

-- local CustomZoneA = CircleZone:Create(vector3(-300.45, 1055.85, 326.97), 10, {
--     name = "custom_zone_a",
-- })

-- local CustomZoneb = CircleZone:Create(vector3(-308.96, 1069.03 , 326.97), 10, {
--     name = "custom_zone_b",
-- })

 --local comboCustom = ComboZone:Create({CustomZoneA, CustomZoneb}, {
 --name="combo_custom",
 --debugPoly=true,
 --minZ = 300.0,
 --maxZ = 330.0,
 --})

local CustomZoneA = PolyZone:Create({
    vector3(-460.7099914550781, 1102.8599853515625, 327.8699951171875),
    vector3(-471.4200134277344, 1105.6800537109375, 327.8699951171875),
    vector3(-469.489990234375, 1113.239990234375, 327.8800048828125),
    vector3(-458.8200073242188, 1109.949951171875, 327.8699951171875),
}, {
    name = "custom_zone_a",
    minZ = 325.0,
    maxZ = 330.0,
})

local CustomZoneB = PolyZone:Create({
    vector3(-462.7900085449219, 1095.18994140625, 327.8699951171875),
    vector3(-473.5700073242188, 1097.6199951171875, 327.8800048828125),
    vector3(-471.55999755859375, 1105, 327.8699951171875),
    vector3(-460.9599914550781, 1102.1600341796875, 327.8699951171875),
}, {
    name = "custom_zone_b",
    minZ = 325.0,
    maxZ = 330.0,
})

local comboCustom = ComboZone:Create({CustomZoneA, CustomZoneB}, {
    name = "combo_custom", 
    debugPoly = false,
})

comboCustom:onPlayerInOut(function(isPointInside, point)
    if isPointInside then
        if IsPedInAnyVehicle(PlayerPedId(), true) then
            exports.helpnotify:showHelpNotification("กด","E","เพื่อแต่งรถ")
        end
    else
        exports.helpnotify:hideHelpNotification()
    end
end)

CreateThread(function()
    -- for i = 1, #Config.Positions, 1 do
    --     local tempPos = Config.Positions[i]
    --     if (tempPos.hasBlip == nil or tempPos.hasBlip == true) then
    --         addBlip(tempPos.pos, 72, 0, '<font face="font4thai">อู่แต่งรถ</font>')
    --     end
    -- end

    local waitTime
    local playerPed
    local playerPos
    local playerVeh

    while (true) do
        waitTime = 500

        playerPed = PlayerPedId()
        playerVeh = GetVehiclePedIsIn(playerPed, false)
        if (not uiOpen) then
            if ((playerVeh ~= 0) and (DoesEntityExist(playerVeh)) and (GetPedInVehicleSeat(playerVeh, -1) == playerPed)) then
                waitTime = 100
                playerPos = GetEntityCoords(playerVeh)
                for i = 1, #Config.Positions, 1 do
                    local tempPos = Config.Positions[i]
                    if Config.mechanic then              
                      	if (not tempPos.whitelistJobName or jobName == tempPos.whitelistJobName) then
							local tempDist = #(playerPos - vector3(tempPos.pos.x, tempPos.pos.y, tempPos.pos.z))
							local tempActionDist = tempPos.actionDistance or Config.ActionDistance
							
							if (tempDist <= tempActionDist) then
								waitTime = 0
								
								if (not IsHudHidden()) then
									DrawHelpText('Press ~' .. Config.Keys.action.name .. '~ to enter customs', true)
								end
	
								if (IsControlJustReleased(0, Config.Keys.action.key)) then
									customConfigPosIndex = i
									checkcar = VehToNet(playerVeh)
									openUI()
                                    pcall(function() -- Start log
                                        exports['azael_dc-serverlogs']:insertData({
                                            event = 'OpenCustomShopMenu',
                                            content = ('ผู้เล่นได้ทำการกด E เพื่อเปิดเมนูแต่งรถ'):format(),
                                        })
                                    end) -- End log
									TriggerServerEvent('Dv_Hunter_Customshop:sv:CheckDeleted', checkcar)
								end
	
								break
							end
						end
					else
						local tempDist = #(playerPos - vector3(tempPos.pos.x, tempPos.pos.y, tempPos.pos.z))
                        local tempActionDist = tempPos.actionDistance or Config.ActionDistance
                        
                        if (tempDist <= tempActionDist) then
                            waitTime = 0
                            
                            if (not IsHudHidden()) then
                                DrawHelpText('Press ~' .. Config.Keys.action.name .. '~ to enter customs', true)
                            end

                            if (IsControlJustReleased(0, Config.Keys.action.key)) then
                                exports.helpnotify:hideHelpNotification()
                                customConfigPosIndex = i
                                checkcar = VehToNet(playerVeh)
                                openUI()
                                pcall(function() -- Start log
                                    exports['azael_dc-serverlogs']:insertData({
                                        event = 'OpenCustomShopMenu',
                                        content = ('ผู้เล่นได้ทำการกด E เพื่อเปิดเมนูแต่งรถ'):format(),
                                    })
                                end) -- End log
                                TriggerServerEvent('Dv_Hunter_Customshop:sv:CheckDeleted', checkcar)
                            end

                            break
                        end
					end
                end
            end
        else
            if (customConfigPosIndex) then
                local tempPos = Config.Positions[customConfigPosIndex]
                updateCash()
                if (playerVeh == 0 or playerVeh ~= customVehicle) then

                    closeUI(1, 1)
                    TriggerServerEvent('Dv_Hunter_Customshop:sv:Deleallcar', checkcar)

                else
                    local playerPos = GetEntityCoords(customVehicle)
                    local tempActionDist = tempPos.actionDistance or Config.ActionDistance

                    local tempDist = GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, tempPos.pos.x, tempPos.pos.y, tempPos.pos.z, true)
                    if (tempDist > tempActionDist) then
                        closeUI(1, 1)           
                    end
                end
            end
        end

        Wait(waitTime)
    end
end)

RegisterNetEvent("Dv_Hunter_Customshop:cl:Deleallcar")
AddEventHandler("Dv_Hunter_Customshop:cl:Deleallcar", function(delcar)
    local playerPed = PlayerPedId()   
        local pVeh = NetToVeh(delcar)
        Wait(1000)

        SetVehicleHasBeenOwnedByPlayer(pVeh, true)
        ESX.Game.DeleteVehicle(pVeh)
        Wait(5000)
        ESX.Game.DeleteVehicle(pVeh)

end)

function updateCash()
    local whitelistJobName = nil
    if (customConfigPosIndex and customConfigPosIndex > 0 and customConfigPosIndex <= #Config.Positions and Config.Positions[customConfigPosIndex]) then
        whitelistJobName = Config.Positions[customConfigPosIndex].whitelistJobName
    end

    ESX.TriggerServerCallback("cc_customCar:checkMoney", function(money)
        SendNUIMessage({
            type = 'update',
            what = 'cash',
            cash = money,
            whitelistJobName = whitelistJobName
        })
    end)
end

function updateVehicleCard(vehicle)
    local vehicleModel = GetEntityModel(vehicle)

    local vehDisplayName = GetDisplayNameFromVehicleModel(vehicleModel)
    local vehicleLabelText = GetLabelText(vehDisplayName)
    local vehicleName = vehicleLabelText == 'NULL' and vehDisplayName or vehicleLabelText
    
    local acceleration = (GetVehicleModelAcceleration(vehicleModel) or 0.0) * 10
    local maxSpeed = (GetVehicleModelEstimatedMaxSpeed(vehicleModel) or 0.0) / 10
    local breaks = GetVehicleModelMaxBraking(vehicleModel) or 0.0
    local power = (acceleration + maxSpeed) / 2
    
    SendNUIMessage({
        type = 'update',
        what = 'card',
        vehicleName = vehicleName,
        power = power,
        acceleration = acceleration,
        maxSpeed = maxSpeed,
        breaks = breaks
    })
end

function openUI()
    if (uiOpen) then 
	return 
	end

    local playerPed = PlayerPedId()
    local playerVeh = GetVehiclePedIsIn(playerPed, false)
    
    if (playerVeh ~= 0 and DoesEntityExist(playerVeh)) then
        customVehicle = playerVeh
        customVehicleData = GetVehicleData(customVehicle)
        FreezeEntityPosition(customVehicle, true)

        SetVehicleOnGroundProperly(playerVeh)

        DisplayHud(false)
        SetNuiFocus(true, false)
        SetNuiFocusKeepInput(true)
        
        customVehiclePrice = 50000
        local tempVehicleModel = GetEntityModel(customVehicle)
        for model, data in pairs(Config.Vehicles) do
            if (tempVehicleModel == GetHashKey(model)) then
                customVehiclePrice = data.price 
                break
            end
        end

        --updateCash()
        updateVehicleCard(customVehicle)

        updateMenu('main')
        SendNUIMessage({
            type = 'open',
            isOpenByAdmin = isOpenByAdmin
        })
        
        local vehPos = GetEntityCoords(customVehicle)
        local camPos = GetOffsetFromEntityInWorldCoords(customVehicle, -2.0, 5.0, 3.0)
        local headingToObject = GetHeadingFromVector_2d(vehPos.x - camPos.x, vehPos.y - camPos.y)
        
        customCamMain = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', camPos.x, camPos.y, camPos.z, -35.0, 0.0, headingToObject, GetGameplayCamFov(), false, 2)
        customCamSec = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', camPos.x, camPos.y, camPos.z, -35.0, 0.0, headingToObject, GetGameplayCamFov(), false, 2)

        SetCamActive(customCamMain, true)
        RenderScriptCams(true, true, 500, true, true)
        renderingScriptCam = true
        
        uiOpen = true
        vehicle_damage = GetVehicleEngineHealth(playerVeh)
        exports.CarHud:setCloseUI()
        CreateThread(function()
            while (uiOpen) do
                DisableAllControlActions(0)
                EnableControlAction(0, 0, true) -- mouse mv
                EnableControlAction(0, 1, true) -- mouse mv
                EnableControlAction(0, 2, true) -- mouse mv

                EnableControlAction(0, 86, true) -- horn
                EnableControlAction(0, 249, true) -- voice
                EnableControlAction(0, 74, true) -- Light

                if (IsDisabledControlJustReleased(0, 26)) then
                    RenderScriptCams(not renderingScriptCam, true, 500, true, true)
                    renderingScriptCam = not renderingScriptCam
                end

                Wait(0)
            end
        end)
    end
end

function closeUI(sendToUI, resetVehToDefault)
    sendToUI = sendToUI or 0
    resetVehToDefault = resetVehToDefault or 0
    local playerPed = PlayerPedId()
    local vehicle =	GetVehiclePedIsIn(playerPed, false)
    DisplayHud(true)
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)

    if (sendToUI == 1) then
        SendNUIMessage({
            type = 'close'
        })
    end

    RenderScriptCams(false, true, 500, true, true)
    renderingScriptCam = false
    DestroyCam(customCamMain, true)
    DestroyCam(customCamSec, true)
    ClearFocus()
    
    if (resetVehToDefault == 1) then
        SetVehicleData(customVehicle, customVehicleData)
    end

    openDoors(customVehicle, {0,0,0,0,0,0,0})
    customVehiclePrice = nil
    FreezeEntityPosition(customVehicle, false)
    customVehicle = nil
    customVehicleData = nil
    customConfigPosIndex = nil

    if (isOpenByAdmin) then
        isOpenByAdmin = false
    end
    --SetVehicleEngineHealth(vehicle, 1000.0)
    exports.CarHud:setCloseVehicleShop()
    uiOpen = false
end

function updateMenu(menuId)
    if (menuId == nil or Config.Menus[menuId] == nil) then return end

    local menu = clearMenu(Config.Menus[menuId])
    
    local newOptions = optionsShouldShow(menu)

    local whitelistJobName = nil
    if (customConfigPosIndex and customConfigPosIndex > 0 and customConfigPosIndex <= #Config.Positions and Config.Positions[customConfigPosIndex]) then
        whitelistJobName = Config.Positions[customConfigPosIndex].whitelistJobName
    end

    SendNUIMessage({
        type = 'update',
        what = 'menu',
        menuId = menuId,
        options = newOptions,
        menuTitle = menu.title,
        defaultOption = menu.defaultOption,
        whitelistJobName = whitelistJobName
    })
end

RegisterNUICallback('uiReady', function(data)
    updateUICurrentJob()
end)

RegisterNUICallback('handle', function(data)
    if (data.type == 'close') then
        closeUI(0, 1)
    elseif (data.type == 'update') then
        if (data.what == 'menu') then
            if (data.user == 'hover') then
                if (not data or not data.menuId or not data.menuIndex) then
                    return
                end
                
                local menu = Config.Menus[data.menuId]
                
                if (not menu) then
                    return
                end
                
                playSound('SELECT', 'HUD_FREEMODE_SOUNDSET')

                local newOptions = optionsShouldShow(menu)

                if (data.color ~= nil) then
                    local tempModType = string.sub(data.menuId, #'mod_' + 1)
                    SetVehicleModData(customVehicle, tempModType, data.color)

                    -- if (tempModType == 'tyreSmokeColor') then
                    --     -- burnout
                    -- end

                    return
                end

                local menuOption = newOptions[data.menuIndex + 1]
                if (menuOption.onHover ~= nil) then
                    menuOption.onHover()
                end
            elseif (data.user == 'enter') then
                Citizen.CreateThread(function()
                    if (not data.menuId or not data.menuIndex) then
                        return
                    end

                    local menu = Config.Menus[data.menuId]

                    if (not menu) then
                        return
                    end

                    local newOptions = optionsShouldShow(menu)
                    local menuOption = newOptions[data.menuIndex + 1]
                    local statusColor = nil
                    local statusMod = nil
                    local function CheckMoneyMod(cb)
                        local canBuyMod = true
                        ESX.TriggerServerCallback("cc_customCar:checkMoney", function(money)
                            if ((not isOpenByAdmin) and menuOption and menuOption.price) then
                                if (menuOption.price == -1) then
                                    canBuyMod = false
                                elseif (menuOption.price > 0) then
                                    canBuyMod = false
                                    menuOption.priceMult = menuOption.priceMult or 1
                                    local tempPrice = menuOption.price or math.floor(customVehiclePrice * menuOption.priceMult / 100)
                                    if money >= tempPrice then
                                        canBuyMod = true
                                        statusMod = true
                                        TriggerServerEvent('mechanic:sv:removeCash', tempPrice)
                                    end
                                    if money < tempPrice then
                                        statusMod = false
                                        canBuyMod = false
                                        onNoMoneyToCustomCar()
                                    end
                                    if (canBuyMod == false) then
                                        playSound('ATM_WINDOW', 'HUD_FRONTEND_DEFAULT_SOUNDSET')
                                        return
                                    end
                                    playSound('Zoom_In', 'DLC_HEIST_PLANNING_BOARD_SOUNDS')
                                    return
                                end
                            end
                            statusMod = true
                        end)
                        while statusMod == nil do
                            Citizen.Wait(0)
                        end
                        cb(statusMod)
                    end

                    local function CheckMoneyColor(cb)
                            ESX.TriggerServerCallback("cc_customCar:checkMoney", function(money)
                                if (data.color ~= nil) then
                                local tempModType = string.sub(data.menuId, #'mod_' + 1)
                                local tempPrice = math.floor(customVehiclePrice * data.priceMult / 100)
                                --if (customConfigPosIndex and customConfigPosIndex > 0 and customConfigPosIndex <= #Config.Positions and Config.Positions[customConfigPosIndex] and jobName ~= Config.Positions[customConfigPosIndex].whitelistJobName) then
                                --    tempPrice = tempPrice
                                -- end

                                if (not isOpenByAdmin) then
                                    if money >= tempPrice then
                                        TriggerServerEvent('mechanic:sv:removeCash', tempPrice)
                                        statusColor = true
                                    else
                                        playSound('ATM_WINDOW', 'HUD_FRONTEND_DEFAULT_SOUNDSET')
                                        statusColor = false
                                        return
                                    end
                                    customVehicleData = GetVehicleData(customVehicle)
                                    playCustomSound('spray')
                                    openColorPicker(data.colorTitle, tempModType, data.isCustom, data.priceMult)
                                    statusColor = true
                                    return
                                end
                                    customVehicleData = GetVehicleData(customVehicle)
                                    playCustomSound('spray')
                                    openColorPicker(data.colorTitle, tempModType, data.isCustom, data.priceMult)
                                    statusColor = true
                            end
                                statusColor = true
                        end)
                        while statusColor == nil do
                            Citizen.Wait(0)
                        end
                        cb(statusColor)
                    end


                    CheckMoneyMod(function(requestStatusMod)
                        statusMod = requestStatusMod
                        --print(statusMod)
                    end)


                    CheckMoneyColor(function(requestStatusColor)
                        statusColor = requestStatusColor
                        --print(statusColor)
                    end)
                    print(statusMod,statusColor)
                    while statusColor == nil and statusMod == nil do
                        Citizen.Wait(0)
                    end

                    if not statusMod then return end

                    if (not menuOption) then
                        return
                    end

                    if (menuOption.onSelect ~= nil) then
                        menuOption.onSelect()
                    end

                    if (menuOption.openSubMenu ~= nil) then
                        updateMenu(menuOption.openSubMenu)
                    end

                    if (menuOption.modType ~= nil) then
                        createMenu(data.menuId, menuOption)
                        updateMenu('mod_' .. menuOption.modType)
                    end
                    Citizen.Wait(200)
            end)

            elseif (data.user == 'backspace') then
                if (not data.menuId) then
                    return
                end

                local menu = Config.Menus[data.menuId]
                
                if (not menu) then
                    return
                end

                playSound('Zoom_In', 'DLC_HEIST_PLANNING_BOARD_SOUNDS')
                
                local newOptions = optionsShouldShow(menu)
                
                if (data.menuIndex) then
                    local menuOption = newOptions[data.menuIndex + 1]
                    if (menuOption) then
                        if (menuOption.onBack ~= nil) then
                            menuOption.onBack()
                        end
                    end
                end

                if (menu.onBack ~= nil) then
                    menu.onBack()
                end
                
                SetVehicleData(customVehicle, customVehicleData)
                openDoors(customVehicle, {0,0,0,0,0,0,0})
            end
        end
    end
end)

function optionsShouldShow(menu)
    local newOptions = {}
    
    for i = 1, #menu.options, 1 do
        local shouldShow = true

        if (menu.options[i].modType ~= nil) then
            if (GetNumVehicleModData(customVehicle, menu.options[i].modType) < 0) then
                shouldShow = false
            end
        end
        
        if (shouldShow and menu.options[i].openSubMenu ~= nil) then
            local subMenu = Config.Menus[menu.options[i].openSubMenu]
            local tempShouldShow = false
            for i = 1, #subMenu.options, 1 do
                if (subMenu.options[i].modType ~= nil) then
                    if (GetNumVehicleModData(customVehicle, subMenu.options[i].modType) >= 0 or subMenu.options[i].openSubMenu ~= nil) then
                        tempShouldShow = true
                        break
                    end
                end
            end

            shouldShow = tempShouldShow
        end

        if (not isOpenByAdmin) then
        --    if (customConfigPosIndex and customConfigPosIndex > 0 and customConfigPosIndex <= #Config.Positions and Config.Positions[customConfigPosIndex] and jobName ~= Config.Positions[customConfigPosIndex].whitelistJobName) then
                if (menu.options[i].openSubMenu == 'upgrade') then
                    shouldShow = true
                end
        --    end
        end

        if (shouldShow == true) then
            table.insert(newOptions, menu.options[i])
        end
    end

    return newOptions
end

function createMenu(menuId, menuOption)
    local newMenuId = 'mod_' .. menuOption.modType
    
    local curOption = GetVehicleCurrentMod(customVehicle, menuOption.modType)
    local curOptionOptionIndex = curOption + 1
    if (menuOption.modType == 'windowTint') then
        curOptionOptionIndex = curOption
    end
    
    Config.Menus[newMenuId] = {
        title = menuOption.label,
        options = {},
        onBack = function()
            updateMenu(menuId)
            
            if (menuOption.onSubBack ~= nil) then 
                menuOption.onSubBack()
            end
        end,
        defaultOption = curOptionOptionIndex
    }
    
    if (menuOption.customType == 'color' or menuOption.customType == 'customColor') then
        Config.Menus[newMenuId].title = ''
        return
    end

    local startIndex = -1
    if (menuOption.modType == 'windowTint' or menuOption.modType == 'extras') then
        startIndex = 0
    end

    for i = startIndex, GetNumVehicleModData(customVehicle, menuOption.modType), 1 do
        local tempLabel = GetVehicleModIndexLabel(customVehicle, menuOption.modType, i)
        if (not tempLabel or tempLabel == 'NULL') then
            tempLabel = tostring(i) + 1
        end

        menuOption.priceMult = menuOption.priceMult or 1.0

        local tempPrice = 0
        if (curOption == i) then
            tempPrice = -1
        else
            if (type(menuOption.priceMult) == 'number') then
                tempPrice = math.floor(customVehiclePrice * menuOption.priceMult / 100)
            else
                tempPrice = math.floor(customVehiclePrice * menuOption.priceMult[i + 2] / 100)
            end
        end
        
        table.insert(Config.Menus[newMenuId].options, {
            label = tempLabel,
            img = menuOption.img,
            price = tempPrice,
            priceMult = menuOption.priceMult,
            onHover = function()
                SetVehicleModData(customVehicle, menuOption.modType, i)
            end,
            onSelect = function()
                customVehicleData = GetVehicleData(customVehicle)
                createMenu(menuId, menuOption)
                updateMenu(newMenuId)
                playCustomSound('construction')
            end
        })

        if (menuOption.modType == 11 or menuOption.modType == 18) then
            local tempOption = Config.Menus[newMenuId].options[#Config.Menus[newMenuId].options]
            tempOption.onHover = function()
                SetVehicleModData(customVehicle, menuOption.modType, i)
                TaskVehicleTempAction(PlayerPedId(), customVehicle, 31, 2000)
            end
        elseif (menuOption.modType == 'extras') then
            local tempOption = Config.Menus[newMenuId].options[#Config.Menus[newMenuId].options]
            local isTempExtraOn = GetVehicleCurrentMod(customVehicle, 'extras', (i + 1))
            
            tempOption.price = nil
            tempOption.onHover = nil

            tempOption.onSelect = function()
                isTempExtraOn = GetVehicleCurrentMod(customVehicle, 'extras', (i + 1))

                Config.Menus['extras_on_off'] = {
                    title = 'EXTRA ' .. tostring(i + 1),
                    options = {
                        {
                            label = 'OFF',
                            img = 'img/icons/minus.png',
                            price = tempPrice,
                            onHover = function()
                                SetVehicleModData(customVehicle, menuOption.modType, {id = (i + 1), enable = 1})
                            end,
                            onSelect = function()
                                customVehicleData = GetVehicleData(customVehicle)

                                Config.Menus['extras_on_off'].options[1].price = -1
                                Config.Menus['extras_on_off'].options[2].price = tempPrice

                                updateMenu('extras_on_off')

                                playCustomSound('construction')
                            end
                        },
                        {
                            label = 'ON',
                            img = 'img/icons/plus.png',
                            price = tempPrice,
                            onHover = function()
                                SetVehicleModData(customVehicle, menuOption.modType, {id = (i + 1), enable = 0})
                            end,
                            onSelect = function()
                                customVehicleData = GetVehicleData(customVehicle)

                                Config.Menus['extras_on_off'].options[1].price = tempPrice
                                Config.Menus['extras_on_off'].options[2].price = -1

                                updateMenu('extras_on_off')

                                playCustomSound('construction')
                            end
                        },
                    },
                    onBack = function() updateMenu(newMenuId) end,
                    defaultOption = 0
                }
                
                if (isTempExtraOn == 0) then
                    Config.Menus['extras_on_off'].options[2].price = -1
                    Config.Menus['extras_on_off'].defaultOption = 1
                else
                    Config.Menus['extras_on_off'].options[1].price = -1
                end

                updateMenu('extras_on_off')
            end
        end
    end
end

function openColorPicker(title, modType, isCustom, priceMult)
    priceMult = priceMult or 1
    
    local defaultValue
    
    if (isCustom) then
        local r, g, b = GetVehicleCurrentMod(customVehicle, modType)
        defaultValue = {r, g, b}
    else
        defaultValue = GetVehicleCurrentMod(customVehicle, modType)
    end

    local whitelistJobName = nil
    if (customConfigPosIndex and customConfigPosIndex > 0 and customConfigPosIndex <= #Config.Positions and Config.Positions[customConfigPosIndex]) then
        whitelistJobName = Config.Positions[customConfigPosIndex].whitelistJobName
    end

    SendNUIMessage({
        type = 'open',
        what = 'colorPicker',
        isOpenByAdmin = isOpenByAdmin,
        isCustom = isCustom,
        defaultValue = defaultValue,
        title = title,
        priceMult = priceMult,
        price = math.floor(customVehiclePrice * priceMult / 100),
        whitelistJobName = whitelistJobName
    })
end

function updateUICurrentJob()
    SendNUIMessage({
        type = 'update'
    })
end

exports('openByMenuAdmin', function()
    isOpenByAdmin = true
    openUI()
end)

AddEventHandler('onResourceStop', function(resource)
    if (GetCurrentServerEndpoint() == nil) then
        return
    end

	if (resource == GetCurrentResourceName()) then
        if (uiOpen) then
            DisplayHud(true)
            SetNuiFocus(false, false)
            SetNuiFocusKeepInput(false)

            RenderScriptCams(false, true, 500, true, true)
            DestroyCam(customCamMain, true)
            DestroyCam(customCamSec, true)
            ClearFocus()

            SetVehicleData(customVehicle, customVehicleData)
            FreezeEntityPosition(customVehicle, false)
        end
    end
end)

function onNoMoneyToCustomCar()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบแต่งรถ', -- หัวเรื่อง
        description = 'คุณมีเงินไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end
