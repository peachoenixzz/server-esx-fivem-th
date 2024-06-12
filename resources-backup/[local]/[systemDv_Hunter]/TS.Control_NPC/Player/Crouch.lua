if PlayerEnvs.EnableCrouch then
    local isLoadAnimDict = false
    function toggleEngine()
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
                SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), false, true)
        end
    end
end

Citizen.CreateThread(function()
    while true do Wait(0)
        if IsControlJustPressed(0, 303) then
            triggerCarEngine()
            Wait(3000)
        end
    end    
end)

function triggerCarEngine()   
    toggleEngine()
end  
