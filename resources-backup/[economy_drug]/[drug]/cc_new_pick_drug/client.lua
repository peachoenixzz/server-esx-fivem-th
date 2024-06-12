ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local onPickDrug = false
local currentnewdrugZone
local allowPick = false
local helpNotify = true
Citizen.CreateThread(function()

    Citizen.Wait(1000)
    ESX.TriggerServerCallback('cc_exchange:checkZoneNewDrug', function(newdrugZones)
        alldrugZone = newdrugZones
        callbackData(newdrugZones)
    end)
end)

function callbackData(zone)
    for _,v in ipairs(zone) do
        local newdrugZone = PolyZone:Create(v.coords, {
            name = v.name,
            debugPoly = v.debug,
            minZ = v.minZ,
            maxZ = v.maxZ,
        })

        newdrugZone:onPlayerInOut(function(isPointInside, point)
            if isPointInside then
                currentnewdrugZone = newdrugZone.name
                --exports.helpnotify:showHelpNotification("กด","E","เพื่อเก็บ")
                --print(currentnewdrugZone)
            else
                currentnewdrugZone = nil
                helpNotify = true
                exports.helpnotify:hideHelpNotification()
                ESX.UI.Menu.CloseAll()
                onPickDrug = false
            end
        end)
    end
end

-- Display markers
Citizen.CreateThread(function()
    while true do
        local sleep = 500
        Citizen.Wait(0)
        if currentnewdrugZone ~= nil and allowPick then
            for _, v in pairs(alldrugZone) do
                --print(v.name)
                if currentnewdrugZone == v.name then
                    if helpNotify then
						exports.helpnotify:showHelpNotification("กด","E","เพื่อเก็บ")
						helpNotify = false
					end
                    DrawMarker(1, v.markerCoords.x, v.markerCoords.y, v.markerCoords.z, 0.0, 0.0,
                    0.0, 0, 0.0, 0.0, 4.50, 4.50, 1.00, 255, 204, 0, 100, false, true, 2, false, false, false, false)
                    sleep = 0
                end 
            end
        else 
            Citizen.Wait(sleep)
        end
    end
end)

-- Player Press E
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if currentnewdrugZone ~= nil and allowPick then
            if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) then
                if currentnewdrugZone == 'coke_meth_zone' then
                    if exports.Dv_Hunter_Check:CheckPolice(2) then
                        pcall(function() -- Start Log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'DoingPickUpNewDrugs',
                                content = ('ผู้เล่นได้ทำการกด E เพื่อเริ่มทำการเก็บยา'):format(),
                            })
                        end) -- End Log
                        ESX.TriggerServerCallback('cc_pick_new_drug:checkCanPressKey', function(status)
                            if status then
                                cokeAndMethMenu()
                            end
                        end)
                    else
                        exports.nc_notify:PushNotification({
                            scale = 1.0, -- ปรับขนาดของ Notify
                            title = 'ระบบตำรวจ', -- หัวเรื่อง
                            description = 'ตำรวจไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                            type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                            icon = 'no_cop', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                            duration = 3000 -- ระยะเวลาการแสดง Notify
                        })
                        Citizen.Wait(2000)
                    end
                end 
            end
        else 
            Citizen.Wait(500)
        end
    end
end)

function cokeAndMethMenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'coke_meth_drug_zone', {
                title    = 'Drug Zone',
                align    = 'top-right',
                elements = {
                    {label = "เก็บเศษยาไอซ์", name = 'meth'},
                    {label = "เก็บโคเคน", name = 'coke'},
                }
    },  function(data, menu)
        if currentnewdrugZone ~= nil then
            if data.current.name == 'meth' then
                startNewDrug('pick_meth')
                pcall(function() -- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'PickingUpMeth',
                        content = ('ผู้เล่นกำลังทำการเก็บ เศษยาไอซ์'):format(),
                    })
                end) -- End Log
                menu.close()
            end
            if data.current.name == 'coke' then
                startNewDrug('pick_coke')
                pcall(function() -- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'PickingUpCoke',
                        content = ('ผู้เล่นกำลังทำการเก็บ โคเคน'):format(),
                    })
                end) -- End Log
                menu.close()
            end
        else 
            menu.close()
        end
        end, function(data, menu)
            menu.close()
            pcall(function() -- Start Log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'ClosePickingUpMenu',
                    content = ('ผู้เล่นทำการปิดเมนูเก็บยา'):format(),
                })
            end) -- End Log
    end)
end

function startNewDrug(drugIdentify)
    onPickDrug = true
    exports.helpnotify:hideHelpNotification()
    ongoingPickNewDrug()
    processPickNewDrug(drugIdentify)
end

function ongoingPickNewDrug()
    --exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
    Citizen.CreateThread(function()
        while onPickDrug do
            Citizen.Wait(0)
            if onPickDrug then
                DisableControlAction(0,Config.Key['F'], true)
                DisableControlAction(0,Config.Key['F1'], true)
                DisableControlAction(0,Config.Key['H'], true)
                DisableControlAction(0,Config.Key['E'], true)
                DisableControlAction(0,Config.Key['ENTER'], true)
                DisableControlAction(0,Config.Key['T'], true)
                DisableControlAction(0, 75, true) --ลงรถ
                DisableControlAction(0, 101, true) -- บล็อกสไลด์
                DisableControlAction(0, 104, true) -- บล็อกสไลด์
                DisableControlAction(0, 304	, true) -- บล็อกสไลด์
            end
            
            if IsPedInAnyVehicle(PlayerPedId(), true) then
                exports.helpnotify:hideHelpNotification()
                TriggerEvent("mythic_progbar:client:cancel")
                helpNotify = true
                onPickDrug = false
            end

            -- if IsControlJustPressed(0,73) and onPickDrug then
            --     exports.helpnotify:hideHelpNotification()
            --     TriggerEvent("mythic_progbar:client:cancel")
            --     helpNotify = true
            --     onPickDrug = false
            -- end 
        end
    end)
end

function processPickNewDrug(drugIdentify)
    TriggerServerEvent('initTimeGlobal',drugIdentify)
    TriggerEvent("mythic_progbar:client:progress",{
        name = "picknewdrug",
        duration = 15000,
        label = "กำลังเก็บยา",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "anim@gangops@facility@servers@bodysearch@",
            anim = "player_search",
            flags = 49,
        },
    }, function(status)
        if not status then
            if currentnewdrugZone ~= nil then
                print("Exchange In Zone")
                pcall(function() -- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'PickUpNewDrugsInZone',
                        content = ('ผู้เล่นได้ทำการเก็บ ยาเสพติด สำเร็จและอยู่ใน zone'):format(),
                    })
                end) -- End Log
                print(drugIdentify)
                TriggerServerEvent('donePickNewDrug',drugIdentify)
                onPickDrug = false
                helpNotify = true
                exports.helpnotify:hideHelpNotification()
            else 
                print("Exchange out Zone")
                pcall(function() -- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'PickUpNewDrugsOutZone',
                        content = ('ผู้เล่นได้ทำการเก็บ ยาเสพติด สำเร็จแต่อยู่นอก zone'):format(),
                    })
                end) -- End Log
                notifyOutZoneNewDrugs()
                onPickDrug = false
                helpNotify = true
                exports.helpnotify:hideHelpNotification()
            end
        end
    end)
end

AddEventHandler('esx:onPlayerDeath', function() 
	if onPickDrug then
		onPickDrug = false
        helpNotify = true
        TriggerEvent("mythic_progbar:client:cancel")
	end
end)

RegisterNetEvent("cc_new_pick_drug:collectAllowData")
AddEventHandler("cc_new_pick_drug:collectAllowData", function(allowStatus)
    allowPick = allowStatus
end)


function notifyOutZoneNewDrugs()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบเก็บยา', -- หัวเรื่อง
        description = 'คุณอยู่นอกพื้นที่', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_area', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end
