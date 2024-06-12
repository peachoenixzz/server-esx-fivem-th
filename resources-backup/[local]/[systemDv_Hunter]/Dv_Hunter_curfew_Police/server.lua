ESX                = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local OnZone = false
RegisterServerEvent('esx_panicbutton:send')
AddEventHandler('esx_panicbutton:send', function(result)
	
	
	if not OnZone then
		TriggerClientEvent("redzone:setposition", source, result)
		OnZone = true
	else
		TriggerClientEvent("redzone:stopredzone", -1)
		OnZone = false
	end
end)

RegisterServerEvent('redzone:sentlocation')
AddEventHandler('redzone:sentlocation', function(x1,y1,z1,result)
	TriggerClientEvent('redzone:createForAll', -1, x1,y1,z1,result)
	-- OnZone = {x = x1, y = y1, z = z1, result= result}
end)

-- RegisterServerEvent('redzone:firstSpawn')
-- AddEventHandler("redzone:firstSpawn", function()
	-- for k,zone in pairs(OnZone) do 
		-- TriggerClientEvent('redzone:createForAll', source, zone.x, zone.y, zone.z, zone.result, k)
	-- end
-- end)
