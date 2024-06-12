ESX = nil
local currentcircleEventszone = nil
local onpickEvent = false
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

for _,v in ipairs(Config.circleEvent) do
    local circleEvent = PolyZone:Create(v.coords, {
        name = v.name,
        debugPoly = v.debug,
        minZ = v.minZ,
        maxZ = v.maxZ,
    })

    circleEvent:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            currentcircleEventszone = v.name
            exports.helpnotify:showHelpNotification("กด","E","เพื่อเก็บ")
        else
            currentcircleEventszone = nil
            exports.helpnotify:hideHelpNotification()
        end
    end)
end

-- Display markers
Citizen.CreateThread(function()
    while true do
        local sleep = 500
        Citizen.Wait(0)
        if currentcircleEventszone ~= nil then
            for k, v in pairs(Config.circleEvent) do
                if currentcircleEventszone == v.name then
                    DrawMarker(1, v.markerCoords.x, v.markerCoords.y, v.markerCoords.z, 0.0, 0.0,
                    0.0, 0, 0.0, 0.0, v.markerSize.x, v.markerSize.y, 1.00, 0,204, 204, 100, false, true, 2, false, false, false, false)
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
        if currentcircleEventszone ~= nil then
            if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) then
                startPickEvent()
            end
        else 
            Citizen.Wait(500)
        end
    end
end)

function startPickEvent()
    onpickEvent = true
    exports.helpnotify:hideHelpNotification()
    ongoingPickEvent()
    processPickEvent()
end

function ongoingPickEvent()
    exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
    Citizen.CreateThread(function()
        while onpickEvent do
            Citizen.Wait(0)
            if onpickEvent then
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
                onpickEvent = false
            end

            if IsControlJustPressed(0,73) and onpickEvent then
                exports.helpnotify:hideHelpNotification()
                TriggerEvent("mythic_progbar:client:cancel")
                onpickEvent = false
            end 
        end
    end)
end

function processPickEvent()
    TriggerEvent("mythic_progbar:client:progress",{
        name = "pickevent",
        duration = 30000,
        label = "กำลังเก็บของอีเว้น",
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
            if currentcircleEventszone ~= nil then
                print(currentcircleEventszone)
                TriggerServerEvent('donePickEvent', currentcircleEventszone)
                onpickEvent = false
                exports.helpnotify:hideHelpNotification()
            else
                onpickEvent = false
                exports.helpnotify:hideHelpNotification()
            end
        end
    end)         
end

AddEventHandler('esx:onPlayerDeath', function() 
	if onpickEvent then
		onpickEvent = false
        TriggerEvent("mythic_progbar:client:cancel")
	end
end)



