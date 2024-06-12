ESX = nil
BJS = GetCurrentResourceName()

local Itemset = false
local Sound = false

Citizen.CreateThread(function() 
	while ESX == nil do 
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
		Citizen.Wait(1) 
	end 
		PlayerData = ESX.GetPlayerData()
end) 

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local Pedcoords = GetEntityCoords(PlayerPedId())
		for k , v in pairs(Config.PosSound.Sound) do
			if GetDistanceBetweenCoords(Pedcoords, v.x , v.y , v.z , true) <= 2 and IsPedOnFoot(PlayerPedId()) and Sound == false then
				local Randomsound = math.random(1 , 2)
				if Randomsound == 2 then
					Sound = true

					SendNUIMessage({
						type = Config.SoundSetup.Place2,
					})

					CreateNpc(v.x , v.y , v.z)
				
					Wait(Config.SoundSetup.TimeSound)
					Sound = false
				elseif Randomsound == 1 then
					Sound = true

					SendNUIMessage({
						type = Config.SoundSetup.Place1,
					})

					CreateNpc(v.x , v.y , v.z)
				
					Wait(Config.SoundSetup.TimeSound)
					Sound = false
				end
			end 
	    end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		local Pedcoords = GetEntityCoords(PlayerPedId())

		for k , v in pairs(Config.ItemSetup.Pos) do
			if GetDistanceBetweenCoords(Pedcoords, v.x , v.y , v.z , true) <= 1 and IsPedOnFoot(PlayerPedId()) and Itemset == false then

				DisplayHelpText('Press ~INPUT_CONTEXT~ to ~r~Pick ~w~Item.')

				if IsControlJustPressed(0, Keys["E"]) then
					Itemset = true
					TriggerEvent("mythic_progbar:client:progress", {
						name = "stealing",
						duration = 5000,
						label = "กำลังขโมยสายสิน..",
						useWhileDead = false,
						canCancel = false,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						},
						animation = {
							animDict = "random@peyote@chicken",
							anim = "wakeup",
							flags = 49,
						},
					}, function(status)
						if not status then
							Itemset = false
							TriggerServerEvent(BJS..'AddItem' , Config.ItemSetup.Itemname , Config.ItemSetup.Amount)
						end
					end)

			    end

			end
		end

	end
end)

CreateNpc = function(x , y , z)

	LoadModel(Config.GhostSetup.Model)

	local Randomnpc = math.random(1 , 1)

	local Ped = PlayerPedId()

	if Randomnpc == 1 then

		SendNUIMessage({
			type = Config.SoundSetup.Fountghost,
		})

		local ghost = CreatePed(5, GetHashKey(Config.GhostSetup.Model), x, y - 2, z - 1, 0.0, false, false)

		FreezeEntityPosition(ghost, true)

		Citizen.Wait(Config.GhostSetup.TimeFound)

		DeleteEntity(ghost)
	end

end

LoadModel = function(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end

DisplayHelpText = function(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
