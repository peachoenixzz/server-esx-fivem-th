ESX = nil
local onPickAmp = false
local currentampZone = nil
local helpNotify = true
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    Citizen.Wait(1000)
    ESX.TriggerServerCallback('cc_exchange:checkZoneAmp', function(ampZones)
        allampZone = ampZones
        callbackData(ampZones)
    end)
end)

function callbackData(zone)
    for _,v in ipairs(zone) do
        local ampZone = PolyZone:Create(v.coords, {
            name = v.name,
            debugPoly = v.debug,
            minZ = v.minZ,
            maxZ = v.maxZ,
        })

        ampZone:onPlayerInOut(function(isPointInside, point)
            if isPointInside then
                currentampZone = ampZone.name
                --exports.helpnotify:showHelpNotification("กด","E","เพื่อเก็บ")
                --print(currentampZone)
            else
                currentampZone = nil
                helpNotify = true
                exports.helpnotify:hideHelpNotification()
                ESX.UI.Menu.CloseAll()
                onPickAmp = false
            end
        end)
    end
end

-- Display markers
Citizen.CreateThread(function()
    while true do
        local sleep = 500
        Citizen.Wait(0)
        if currentampZone ~= nil then
            for k, v in pairs(allampZone) do
                --print(v.name)
                if currentampZone == v.name then
                    if helpNotify then
						exports.helpnotify:showHelpNotification("กด","E","เพื่อเก็บ")
						helpNotify = false
					end
                    DrawMarker(1, v.markerCoords.x, v.markerCoords.y, v.markerCoords.z, 0.0, 0.0,
                    0.0, 0, 0.0, 0.0, 5.50, 5.50, 1.00, 255,204, 0, 100, false, true, 2, false, false, false, false)
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
        if currentampZone ~= nil then
            if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) then
                if currentampZone == 'amp_zone' then
                    if exports.Dv_Hunter_Check:CheckPolice(2) then
                        pcall(function() -- Start Log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'DoPickUpAmp',
                                content = ('ผู้เล่นได้ทำการกด E เพื่อทำการเก็บ amp'):format(),
                            })
                        end) -- End Log
                        startAmp('pick_amp')
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

-- function ampMenu()
--     ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'amp_zone', {
--                 title    = 'Amp Zone',
--                 align    = 'top-right',
--                 elements = {
--                     {label = "เก็บแอม", name = 'amp'},
--                 }
--     },  function(data, menu)
--         if currentampZone ~= nil then
--             if data.current.name == 'amp' then
--                 startAmp('pick_amp')
--                 menu.close()
--             end
--         else 
--             menu.close()
--         end
--         end, function(data, menu)
--             menu.close()
--     end)
-- end

function startAmp(ampIdentify)
    onPickAmp = true
    exports.helpnotify:hideHelpNotification()
    ongoingPickAmp()
    processPickAmp(ampIdentify)
end

function ongoingPickAmp()
    --exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
    Citizen.CreateThread(function()
        while onPickAmp do
            Citizen.Wait(0)
            if onPickAmp then
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
                onPickAmp = false
            end

            -- if IsControlJustPressed(0,73) and onPickAmp then
            --     exports.helpnotify:hideHelpNotification()
            --     TriggerEvent("mythic_progbar:client:cancel")
            --     helpNotify = true
            --     onPickAmp = false
            -- end 
        end
    end)
end

function processPickAmp(ampIdentify)
    ESX.TriggerServerCallback('cc_pick_amp:checkStatus', function(statePick)
        if statePick then
            --TriggerEvent("Porpy_policealert:alertNet", "amp")
            exports['Porpy_policealert']:alertNet('amp')
            TriggerEvent("mythic_progbar:client:progress",{
                name = "pickamp",
                duration = 30000,
                label = "กำลังแอม",
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
                    if currentampZone ~= nil then
                        print("Exchange In Zone")
                        pcall(function() -- Start Log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'PickUpAmpInZone',
                                content = ('ผู้เล่นได้ทำการเก็บ amp สำเร็จและอยู่ใน zone'):format(),
                            })
                        end) -- End Log
                        print(ampIdentify)
                        TriggerServerEvent('donePickAmp',ampIdentify)
                        onPickAmp = false
                        helpNotify = true
                        exports.helpnotify:hideHelpNotification()
                    else
                        print("Exchange out Zone")
                        pcall(function() -- Start Log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'PickUpAmpOutZone',
                                content = ('ผู้เล่นได้ทำการเก็บ amp สำเร็จแต่อยู่นอก zone'):format(),
                            })
                        end) -- End Log
                        notifyOutZone()
                        onPickAmp = false
                        helpNotify = true
                        exports.helpnotify:hideHelpNotification()
                    end
                end
            end)
        end
    end)
end


AddEventHandler('esx:onPlayerDeath', function() 
	if onPickAmp then
		onPickAmp = false
        helpNotify = true
        TriggerEvent("mythic_progbar:client:cancel")
	end
end)

function notifyOutZone()
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