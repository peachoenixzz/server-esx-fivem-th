local PlayerLoaded   = false
local FirstSpawn     = true

RegisterNetEvent(Config['router_base']['playerLoaded'])
AddEventHandler(Config['router_base']['playerLoaded'], function(xPlayer)
	PlayerLoaded = true
end)


AddEventHandler('sm_skin:playerSpawned', function()
	Citizen.CreateThread(function()
		while not PlayerLoaded do
			Citizen.Wait(10)
		end
		print(FirstSpawn)
		if FirstSpawn then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				print(skin)
				if skin == nil then
					OpenMenuSkin()
					TriggerEvent('sm_skin:OpenMenuSkin')
					TriggerEvent('skinchanger:loadDefaultModel', true)
					Wait(5000)
					TriggerEvent('skinchanger:change', 'sex', 0)
				else
					TriggerEvent('skinchanger:loadSkin', skin)
				end
			end)

			FirstSpawn = false
		end
	end)
end)

RegisterNetEvent(script_name..':OpenMenuSkin', function()
	OpenMenuSkin()
end)
