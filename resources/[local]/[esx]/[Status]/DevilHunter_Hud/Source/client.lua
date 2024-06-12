local health, food, armor, dive, stress = 0.0, 0.0, 0.0, 100.0, 0.0
local live = false
local id = GetPlayerServerId(PlayerId())
local oldCombat, oldHealth, oldArmor, oldDive, oldFood, oldStress = false, 0, 0, 100, 0, 0

local function updateStatus()
	local playerPed = PlayerPedId()
	local newHealth = GetEntityHealth(playerPed)
	local newArmor = GetPedArmour(playerPed)
	local newDive = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10.00
	local isPedCombat = IsPedInMeleeCombat(playerPed)
	if newHealth ~= oldHealth or newArmor ~= oldArmor or newDive ~= oldDive or
			food ~= oldFood or stress ~= oldStress or isPedCombat ~= oldCombat then
		-- Update the old status to new
		oldHealth, oldArmor, oldDive, oldFood, oldStress, oldCombat =
		newHealth, newArmor, newDive, food, stress, isPedCombat

		SendNUIMessage({
			show = true,
			health = (newHealth - 100),
			stamina = 0,  -- Assuming stamina remains 0 as it's not updated
			dive = newDive,
			heal = newHealth,
			armor = newArmor,
			food = food,
			stress = stress,
			id = id,
			isCombat = isPedCombat,
			hidestatusbar = false,
		})
	end
end

Citizen.CreateThread(function()
	live = true
	while true do
		if live then
			updateStatus()
		end
		Wait(100)  -- Adjusted wait time for performance
	end
end)

AddEventHandler('playerSpawned', function()
	live = true
end)

function checkStatus()
	Citizen.CreateThread(function()
		while true do
			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				food = status.getPercent()
			end)

			TriggerEvent('esx_status:getStatus', 'stress', function(status)
				stress = status.getPercent()
			end)
			Wait(2000)  -- Reduced frequency to balance performance
		end
	end)
end

AddEventHandler('esx:onPlayerDeath', function()
	live = false
	SendNUIMessage({
		hidestatusbar = true,
	})
end)

checkStatus()
