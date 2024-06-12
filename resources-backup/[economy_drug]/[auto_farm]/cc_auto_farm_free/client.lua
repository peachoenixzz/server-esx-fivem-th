ESX = nil
local inzonefreeautoFarm = false
local currentFreeAutoFarm = nil
local onAutoFarm = false
local helpNotify = true

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)



for _,v in pairs(Config.AutoFarmFreePolyZone) do
		local afkfreeZone = PolyZone:Create(v.coords, {
			name = v.name,
			debugPoly = v.debug,
			minZ = v.minZ,
			maxZ = v.maxZ,
		})

        afkfreeZone:onPlayerInOut(function(isPointInside, point)
            if isPointInside then
                inzonefreeautoFarm = true
            else
                inzonefreeautoFarm = false
                helpNotify = true
                currentFreeAutoFarm = nil
                onAutoFarm = false
                TriggerServerEvent("cc_auto_farm_free:cancelFromClient")
                closeUI()
                exports.autofarm_ui:hideProcessDetail()
                exports.helpnotify:hideHelpNotification()
                FreezeEntityPosition(PlayerPedId(),false)
            end
        end)
end

-- Player Press E
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if inzonefreeautoFarm == true then
            if helpNotify then
                exports.helpnotify:showHelpNotification("กด","E","เพื่อเริ่มต้นใช้งาน")
                helpNotify = false
            end
            if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) then
                autofarmMenu()
            end
        else 
            Citizen.Wait(500)
        end
    end
end)

function autofarmMenu()
    SendNUIMessage({
        action = "open",
        config = json.encode(Config.AutoFarmFreeInfoClient)
    })
    SetTimecycleModifier('hud_def_blur') -- blur
    SetTimecycleModifierStrength(1.0)
    --SetTimecycleModifier('default')
    --SetTimecycleModifierStrength(0.0);
    ESX.SetTimeout(200, function()
        SetNuiFocus(true, true)
    end)
end

function closeUI()
    SetNuiFocus(false, false)
    SendNUIMessage({action = 'closeAll'})
    SetTimecycleModifier('default')
    SetTimecycleModifierStrength(0.0);
end

RegisterNUICallback('NUIStartAuto', function(data,cb)
    --print("test")
    ESX.TriggerServerCallback('checkHasItem', function(stateProcess)
        if stateProcess then
            startFreeAutoFarm(data.currentAutoFarm)
        end
    end,data.currentAutoFarm)
    cb("ok")
end)

RegisterNUICallback('NUIFocusOff', function()
    closeUI()
end)


RegisterNetEvent('ongoingFreeAutoFarm')
AddEventHandler('ongoingFreeAutoFarm', function ()
    if onAutoFarm then
        processFreeAutoFarm()
    else
        FreezeEntityPosition(PlayerPedId(),false)
		exports.helpnotify:hideHelpNotification()
        exports.autofarm_ui:hideProcessDetail()
        TriggerEvent("mythic_progbar:client:cancel")
        --TriggerServerEvent("cc_auto_farm_free:cancelFromClient")
        onAutoFarm = false
        currentFreeAutoFarm = nil
        helpNotify = true
    end
end)

RegisterNetEvent('cc_auto_farm_free:initUI')
AddEventHandler('cc_auto_farm_free:initUI', function (selectedItems)
    exports.autofarm_ui:showProcessDetail(selectedItems)
end)

RegisterNetEvent('cc_auto_farm_free:updateUI')
AddEventHandler('cc_auto_farm_free:updateUI', function (selectedItems)
    exports.autofarm_ui:updateProcessDetail(selectedItems)
end)

RegisterNetEvent('preparestopAutoFarm')
AddEventHandler('preparestopAutoFarm', function ()
    stopAutoFarm()
end)

function startFreeAutoFarm(autofarmIdentify)
    FreezeEntityPosition(PlayerPedId(),true)
    currentFreeAutoFarm = autofarmIdentify
    onAutoFarm = true
    processFreeAutoFarm()
    onfreeautofarmforBlockandCancel()
end

function stopAutoFarm()
    FreezeEntityPosition(PlayerPedId(),false)
	exports.helpnotify:hideHelpNotification()
    exports.autofarm_ui:hideProcessDetail()
    TriggerEvent("mythic_progbar:client:cancel")
    TriggerServerEvent("cc_auto_farm_free:cancelFromClient")
    onAutoFarm = false
    currentFreeAutoFarm = nil
    helpNotify = true
end

function processFreeAutoFarm()
    for _,v in pairs(Config.AutoFarmFreeInfoClient) do
        if currentFreeAutoFarm == v.name then
            TriggerEvent("mythic_progbar:client:progress",{
                name = "freeautofarm",
                duration = v.picktime,
                label = "กำลังเก็บ",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "amb@world_human_stand_fishing@idle_a",
                    anim = "idle_c",
                    flags = 49,
                },
                prop = {
                    model = "prop_fishing_rod_01", 
                    bone = 18905,
                    coords = { x = 0.1, y = 0.05, z = 0.0 },
                    rotation = { x = 80.0, y = 120.0, z = 160.0 },
                }
            }, function(status)
                if not status then
                    if inzonefreeautoFarm == true then
                        -- print(currentFreeAutoFarm)
                        -- print(v.picktime)
                        TriggerServerEvent('doneFreeAutoFarm',currentFreeAutoFarm)
                    else 
                        print("outzone")
                    end
                end
            end)
        end
    end
end

function onfreeautofarmforBlockandCancel()
    exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
    Citizen.CreateThread(function()
        while onAutoFarm do
            Citizen.Wait(0)
            if onAutoFarm then
                DisableControlAction(0,Config.Key['G'], true)
				DisableControlAction(0, Config.Key['T'], false)
				DisableControlAction(0, Config.Key['E'], true)
				EnableControlAction(0, Config.Key['X'], true)
				DisableControlAction(0, Config.Key['DELETE'], true)
				DisableControlAction(0, Config.Key['F2'], true)
            end

            if IsControlJustPressed(0,73) and onAutoFarm then
                FreezeEntityPosition(PlayerPedId(),false)
		        exports.helpnotify:hideHelpNotification()
                exports.autofarm_ui:hideProcessDetail()
                TriggerEvent("mythic_progbar:client:cancel")
                TriggerServerEvent("cc_auto_farm_free:cancelFromClient")
                onAutoFarm = false
                currentFreeAutoFarm = nil
                helpNotify = true
            end
        end
    end)
end

AddEventHandler('esx:onPlayerDeath', function() 
	if onAutoFarm then
        FreezeEntityPosition(PlayerPedId(),false)
		exports.helpnotify:hideHelpNotification()
        exports.autofarm_ui:hideProcessDetail()
        TriggerServerEvent("cc_auto_farm_free:cancelFromClient")
        TriggerEvent("mythic_progbar:client:cancel")
        onAutoFarm = false
        currentFreeAutoFarm = nil
        helpNotify = true
	end
end)






