
RegisterNetEvent('cc_snowballs:checkPlayerState')
AddEventHandler('cc_snowballs:checkPlayerState', function()
    RequestAnimDict('anim@mp_snowball') -- pre-load the animation
    if IsNextWeatherType('XMAS') then -- check for xmas weather type
        if not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not IsPlayerFreeAiming(PlayerId()) and not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) and not IsPedFalling(PlayerPedId()) and not IsPedRunning(PlayerPedId()) and not IsPedSprinting(PlayerPedId()) and GetInteriorFromEntity(PlayerPedId()) == 0 and not IsPedShooting(PlayerPedId()) and not IsPedUsingAnyScenario(PlayerPedId()) and not IsPedInCover(PlayerPedId(), 0) then -- check if the snowball should be picked up
            ESX.TriggerServerCallback('cc_snowballs:pickup', function(status)
                if status then
                    TaskPlayAnim(PlayerPedId(), 'anim@mp_snowball', 'pickup_snowball', 8.0, -1, -1, 0, 1, 0, 0, 0) -- pickup the snowball
                end
            end)
        end
    end
end)
