local onUse = false

RegisterNetEvent('useAllBox')
AddEventHandler('useAllBox', function(name)
    if not onUse  and not IsPedInAnyVehicle(PlayerPedId(), true) then
        processAllBox(name)
    end
end)

function processAllBox(name)
    onUse = true
    TriggerEvent("mythic_progbar:client:progress", {
        name = "useallbox",
        duration = 3000,
        label = "กำลังเปิดกล่องดำ",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(status)
        if not status  then
            onUse = false
            TriggerServerEvent('spawnItemsAllBox', name)
        end
    end)
end

AddEventHandler('esx:onPlayerDeath', function() 
    if onUse then
        onUse = false
        TriggerEvent("mythic_progbar:client:cancel")
    end
end)