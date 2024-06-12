
local IsDead = false

local statusData = {} -- Added by Azael Dev

AddEventHandler('esx_basicneeds:resetStatus', function()
	--TriggerEvent('esx_status:set', 'hunger', 300000)
	--TriggerEvent('esx_status:set', 'thirst', 300000)
end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 300000)
  	TriggerEvent('esx_status:set', 'thirst', 300000)
  	TriggerEvent('esx_status:set', 'stress', 2000000)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
	Citizen.Wait(200)
	SetEntityHealth(playerPed, 200)
end)

AddEventHandler('esx:onPlayerDeath', function()
	TriggerEvent('esx_status:getStatus', 'hunger', function(status)	-- Added by Azael Dev
		statusData.hunger = status.val
	end)

	TriggerEvent('esx_status:getStatus', 'thirst', function(status)	-- Added by Azael Dev
		statusData.thirst = status.val
	end)
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end
	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 3000000, '#FFFF00', function(status) -- #CFAD0F -- Amarelo
		return true
	end, function(status)
		status.remove(833)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 3000000, '#0099FF', function(status) -- #0C98F1 -- Azul
		return true
	end, function(status)
		status.add(1)
  end)
  
  TriggerEvent('esx_status:registerStatus', 'stress', 0, '#cadfff', function(status)
		return false
	end, function(status)
		status.add(555)
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(2000)
			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				if status.val <= 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				if status.val <= 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
      		end)
      
      		TriggerEvent('esx_status:getStatus', 'stress', function(status)
				if status.val < 0 then
					TriggerEvent('esx_status:set', 'stress', 0)
				else
					stressVal = status.val
				end

				if stressVal >= 3000000 then
					health = 0
					local playerCoords = GetEntityCoords(playerPed)
					AddExplosion(playerCoords.x, playerCoords.y, playerCoords.z, 'EXPLOSION_GAS_TANK', 0, true, false, 0)
					TriggerEvent('esx_status:set', 'stress', 0)
					pcall(function()
						exports['azael_dc-serverlogs']:insertData({
							event = 'Dead',
							content = ('เสียชีวิต โดย ความเครียสูงเกินกำหนด(หัวระเบิด)'):format(),
						})
					end)
					Citizen.Wait(200)
				end
			end)

			if health ~= prevHealth  then
				SetEntityHealth(playerPed, health)
				Citizen.Wait(200)
			end
		end
	end)
end)