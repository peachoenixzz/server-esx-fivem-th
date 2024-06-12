Citizen.CreateThread(function()

    while not NetworkIsPlayerActive(PlayerId()) do
        Citizen.Wait(0)
    end

    while GetEntityModel(PlayerPedId()) ~= 'mp_f_freemode_01' and GetEntityModel(PlayerPedId()) ~= 'mp_m_freemode_01' do
        Citizen.Wait(0)
    end

    Citizen.Wait(0)

    --while true do
        --Citizen.Wait(0)
		--SetPlayerHealthRechargeLimit(PlayerId(), 0.0)
		--SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
        --local ped = GetPlayerPed(-1)
        --if GetPedMaxHealth(ped) ~= 200 and not IsEntityDead(ped) then
            --SetPedMaxHealth(ped, 200)
            --SetEntityHealth(ped, GetEntityHealth(ped) + 25)
        --end
    --end
end)

--Citizen.CreateThread(function()
--    while true do
--        Citizen.Wait(0)
--        local playerPed = PlayerPedId()
--        --local vehicle = GetVehiclePedIsTryingToEnter(playerPed)
--        --if vehicle and DoesEntityExist(vehicle) then
--        --    local driverPed = GetPedInVehicleSeat(vehicle, -1)
--        --    if GetVehicleDoorLockStatus(vehicle) == 7 then
--        --        SetVehicleDoorsLocked(vehicle, 2)
--        --    end
--        --
--        --    if driverPed and DoesEntityExist(driverPed) then
--        --        SetPedCanBeDraggedOut(driverPed, true)
--        --    end
--        --end
--        SetPedDropsWeaponsWhenDead(playerPed,false)
--        SetPedCanLosePropsOnDamage(playerPed,false,0)
--        SetPedConfigFlag(
--                playerPed --[[ Ped ]],
--                35 --[[ integer ]],
--                false --[[ boolean ]]
--        )
--        --SetPedConfigFlag(
--        --        playerPed --[[ Ped ]],
--        --        359 --[[ integer ]],
--        --        false --[[ boolean ]]
--        --)
--
--    end
--end)




Citizen.CreateThread(function()
    local isInVehicle = false

    while true do
        local isPlayerInVehicle = IsPedInAnyVehicle(PlayerPedId(), true)

        if isPlayerInVehicle and not isInVehicle then
            isInVehicle = true
            exectryGetInVehicle()
            SetUserRadioControlEnabled(false)
            SetVehRadioStation(GetVehiclePedIsIn(PlayerPedId(), true), "OFF")
        elseif not isPlayerInVehicle and isInVehicle then
            isInVehicle = false
            -- Any code needed when player exits vehicle
        end

        if isInVehicle then
            HudWeaponWheelIgnoreSelection()
            HideHudComponentThisFrame(16)
        end

        Citizen.Wait(100)  -- Adjust wait time as needed for your game's responsiveness
    end
end)
