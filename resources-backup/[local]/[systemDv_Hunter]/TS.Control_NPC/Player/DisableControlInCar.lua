local checkingIsIn = false
local isInVehicle = false

function exectryGetInVehicle()
    local playerPed = PlayerPedId(-1)

    if IsPedInAnyVehicle(playerPed, false) and isInVehicle or checkingIsIn then
        return
    end

    checkingIsIn = true
    Wait(60)  -- Wait for 60 ms, consider adjusting based on necessity

    Citizen.CreateThread(function()
        while IsPedInAnyVehicle(playerPed, true) do
            for _, keyEnvs in ipairs(PlayerEnvs.WhileCarBlockControl) do
                DisableControlAction(keyEnvs[1], keyEnvs[2], true)
            end
            isInVehicle = true
            Citizen.Wait(0)
        end

        isInVehicle = false
        checkingIsIn = false
    end)
end
