local clientOnCurfew = false
local clientCurfewLocation = {}

RegisterNetEvent('curfewmarker:updateCurfew')
AddEventHandler('curfewmarker:updateCurfew', function(onCurfew, curfewLocation)
    clientOnCurfew = onCurfew
    clientCurfewLocation = curfewLocation
    Wait(1000)
    startCurfew()
end)

function startCurfew()
	if clientOnCurfew then
		Citizen.CreateThread(function()
			while clientOnCurfew do
				local sleep = 1000
		        local coords = GetEntityCoords(PlayerPedId())
                if(GetDistanceBetweenCoords(coords, clientCurfewLocation.x, clientCurfewLocation.y, clientCurfewLocation.z, false) < 150) then
                    DrawMarker(1, clientCurfewLocation.x, clientCurfewLocation.y, clientCurfewLocation.z-5, 0.0, 0.0, 0.0, 0, 0.0, 0.0,
						100.00, 100.00, 50.00, 255, 0, 0, 100,
						false, true, 2, false, false, false, false)
                    sleep = 0
                end
                Citizen.Wait(sleep)
			end
			return
		end)
	end
end