Citizen.CreateThread(function()

	Citizen.Wait(1)

    SetMaxWantedLevel(0)
     --for k, v in pairs(PlayerEnvs.WeaponDamage) do
     --    N_0x4757f00bc6323cfe(tonumber(k), v)
     --end

    for _, hash in ipairs(PlayerEnvs.WeaponDropBlockedList) do
        ToggleUsePickupsForPlayer(PlayerId(), tonumber(hash), false)
    end

end)

Citizen.CreateThread(function()
    while true do
        DisablePlayerVehicleRewards(PlayerId())
		if PlayerEnvs.showhudcomponent then
			HideHudComponentThisFrame( 14 )
            HideHudComponentThisFrame(2)
        end
        Citizen.Wait(0)
    end
end)