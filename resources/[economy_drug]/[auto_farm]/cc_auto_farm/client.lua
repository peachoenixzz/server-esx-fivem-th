ESX = nil
local inzoneautoFarm = false
local currentAutoFarm = nil
local onAutoFarm = false
local helpNotify = true
local inzoneautoFarmTimeOut = false 

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function checkInZoneAutoFarm()
    return inzoneautoFarmTimeOut
end

for _,v in pairs(Config.AutoFarmPolyZoneTimeOut) do
    local autoZoneTimeOut = PolyZone:Create(v.coords, {
        name = v.name,
        debugPoly = v.debug,
        minZ = v.minZ,
        maxZ = v.maxZ,
    })

    autoZoneTimeOut:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            inzoneautoFarmTimeOut = true
            --print(inzoneautoFarmTimeOut)
        else
            inzoneautoFarmTimeOut = false
            --print(inzoneautoFarmTimeOut)
        end
    end)
end

for _,v in pairs(Config.AutoFarmPolyZone) do
		local autoZone = PolyZone:Create(v.coords, {
			name = v.name,
			debugPoly = v.debug,
			minZ = v.minZ,
			maxZ = v.maxZ,
		})

        autoZone:onPlayerInOut(function(isPointInside, point)
            if isPointInside then
                inzoneautoFarm = true
            else
                inzoneautoFarm = false
                helpNotify = true
                currentAutoFarm = nil
                onAutoFarm = false
                TriggerServerEvent("cc_auto_farm:cancelFromClient")
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
        if inzoneautoFarm == true then
            if helpNotify then
                exports.helpnotify:showHelpNotification("กด","E","เพื่อเริ่มต้นใช้งาน")
                helpNotify = false
            end
            if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) then
                pcall(function()-- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'OpenAutoFarmMenu',
                        content = ('ผู้เล่นได้ทำการกด E เพื่อเปิดเมนู Auto Farm'):format(),
                    })
                end)-- End Log
                ESX.TriggerServerCallback('checkExpireItem', function(stateProcess)
                    if stateProcess then
                        autofarmMenu()
                    end
                end)
            end
        else 
            Citizen.Wait(500)
        end
    end
end)

function autofarmMenu()
    SendNUIMessage({
        action = "open",
        config = json.encode(Config.AutoFarmInfoClient)
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
    ESX.TriggerServerCallback('checkWeight', function(stateProcess)
        if stateProcess then
            startAutoFarm(data.currentAutoFarm)
            pcall(function()-- Start Log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'StartAutoFarm',
                    content = ('ผู้เล่นได้เริ่มทำการ Auto Farm เก็บ %s'):format(data.currentAutoFarm),
                })
            end)-- End Log
        end
    end,data.currentAutoFarm)
    cb("ok")
end)

RegisterNUICallback('NUIFocusOff', function()
    closeUI()
end)


RegisterNetEvent('ongoingAutoFarm')
AddEventHandler('ongoingAutoFarm', function ()
    if onAutoFarm then
        processAutoFarm()
    else
        FreezeEntityPosition(PlayerPedId(),false)
		exports.helpnotify:hideHelpNotification()
        exports.autofarm_ui:hideProcessDetail()
        TriggerEvent("mythic_progbar:client:cancel")
        --TriggerServerEvent("cc_auto_farm:cancelFromClient")
        onAutoFarm = false
        currentAutoFarm = nil
        helpNotify = true
    end
end)

RegisterNetEvent('cc_auto_farm:initUI')
AddEventHandler('cc_auto_farm:initUI', function (selectedItems)
    exports.autofarm_ui:showProcessDetail(selectedItems)
end)

RegisterNetEvent('cc_auto_farm:updateUI')
AddEventHandler('cc_auto_farm:updateUI', function (selectedItems)
    exports.autofarm_ui:updateProcessDetail(selectedItems)
end)

RegisterNetEvent('preparestopAutoFarm')
AddEventHandler('preparestopAutoFarm', function ()
    stopAutoFarm()
end)

function startAutoFarm(autofarmIdentify)
    FreezeEntityPosition(PlayerPedId(),true)
    currentAutoFarm = autofarmIdentify
    onAutoFarm = true
    processAutoFarm()
    onautofarmforBlockandCancel()
end

function stopAutoFarm()
    FreezeEntityPosition(PlayerPedId(),false)
	exports.helpnotify:hideHelpNotification()
    exports.autofarm_ui:hideProcessDetail()
    TriggerEvent("mythic_progbar:client:cancel")
    TriggerServerEvent("cc_auto_farm:cancelFromClient")
    onAutoFarm = false
    currentAutoFarm = nil
    helpNotify = true
end

function processAutoFarm()
    for _,v in pairs(Config.AutoFarmInfoClient) do
        if currentAutoFarm == v.name then
            TriggerEvent("mythic_progbar:client:progress",{
                name = "autofarm",
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
                    animDict = "rcmcollect_paperleadinout@",
                    anim = "meditiate_idle",
                    flags = 1,
                },
            }, function(status)
                if not status then
                    if inzoneautoFarm == true then
                        -- print(currentAutoFarm)
                        -- print(v.picktime)
                        TriggerServerEvent('doneAutoFarm',currentAutoFarm)
                    else 
                        print("outzone")
                    end
                end
            end)
        end
    end
end

function onautofarmforBlockandCancel()
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
                pcall(function()-- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'StopAutoFarm',
                        content = ('ผู้เล่นได้ทำการกด X เพื่อหยุดการทำ Auto Farm'):format(),
                    })
                end)-- End Log
                FreezeEntityPosition(PlayerPedId(),false)
		        exports.helpnotify:hideHelpNotification()
                exports.autofarm_ui:hideProcessDetail()
                TriggerEvent("mythic_progbar:client:cancel")
                TriggerServerEvent("cc_auto_farm:cancelFromClient")
                onAutoFarm = false
                currentAutoFarm = nil
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
        TriggerServerEvent("cc_auto_farm:cancelFromClient")
        TriggerEvent("mythic_progbar:client:cancel")
        onAutoFarm = false
        currentAutoFarm = nil
        helpNotify = true
	end
end)






