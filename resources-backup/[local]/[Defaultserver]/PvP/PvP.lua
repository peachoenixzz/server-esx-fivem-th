-- CLIENTSIDED --

-- Citizen.CreateThread(function()
	-- while true do
		-- Citizen.Wait(0)
		-- SetCanAttackFriendly(GetPlayerPed(-1), true, false)
		-- NetworkSetFriendlyFireOption(true)
	-- end
-- end)

AddEventHandler("playerSpawned", function(spawn)
	SetCanAttackFriendly(GetPlayerPed(-1), true, false)
	NetworkSetFriendlyFireOption(true)
end)