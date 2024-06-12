ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	PlayerData = ESX.GetPlayerData()
end)



function DrawGenericTextThisFrame()
	SetTextFont(RegisterFontId('Kanit'))
	SetTextProportional(0)
	SetTextScale(0.0, 0.7)
	SetTextColour(255, 0, 0, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

function SecondsToClock(seconds)
	if seconds <= 0 then
		return "00:00";
	else
		mins = string.format("%02.f", math.floor(seconds / 60 - (math.floor(seconds / 3600) * 60)));
		secs = string.format("%02.f", math.floor(seconds - math.floor(seconds / 3600) * 3600 - mins * 60));
		return mins .. ":" .. secs
	end
end


function playSoundDelCar()
 
	SendNUIMessage(
        {
            Type = "playSound",
            File = "dv_alert.mp3",
            Volume = 0.7
        }
    )

end

RegisterNetEvent("General:stopDelCar")
AddEventHandler("General:stopDelCar", function()
	SendNUIMessage({ShowMenu = false,})
end)



RegisterNetEvent("General:DelCar")
AddEventHandler("General:DelCar", function(_times)
	if _times == 30 or _times == 280 then
  		playSoundDelCar()
	end
		timetext = ''..SecondsToClock(_times)..''
		
		SendNUIMessage({
			ShowMenu = true,
			text1 = timetext,
		})
		if _times == 0 then
			for vehicle in EnumerateVehicles() do 
				
				if not IsEntityInWater(vehicle) then
					if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then  			
						SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
						SetEntityAsMissionEntity(vehicle, false, false)  
						DeleteVehicle(vehicle) 
						
						if (DoesEntityExist(vehicle)) then 
							DeleteVehicle(vehicle) 	
							
						end
					end		
				end
			end
			SendNUIMessage({ShowMenu = false,})
		end
    
  
end)


  local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

	local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
		return coroutine.wrap(function()
			local iter, id = initFunc()
			if not id or id == 0 then
				disposeFunc(iter)
				return
			end
		
			local enum = {handle = iter, destructor = disposeFunc}
			setmetatable(enum, entityEnumerator)
		
			local next = true
			repeat
				coroutine.yield(id)
				next, id = moveFunc(iter)
			until not next
		
			enum.destructor, enum.handle = nil, nil
			disposeFunc(iter)
		end)
	end

	function EnumerateVehicles() 
		return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle) 
	end
  





