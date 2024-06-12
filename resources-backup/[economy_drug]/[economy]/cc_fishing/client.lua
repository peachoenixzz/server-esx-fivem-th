ESX = nil
local currentfishingzone = nil
local startFishing = false
local helpNotify = true
local isFishing = false 
local onminiGame = false
local onautoFishing = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

for _,v in pairs(Config.FishingPolyZone) do
    if v.enable == true then
        local fishingZone = PolyZone:Create(v.coords, {
            name = v.name,
            debugPoly = v.debug, 
			minZ = v.minZ,
            maxZ = v.maxZ,
        })

        fishingZone:onPlayerInOut(function(isPointInside, point)
            if isPointInside then
				currentfishingzone = v.name
				startFishing = true
				start()
            else
				if isFishing then
					TriggerEvent("mythic_progbar:client:cancel")
				end
				currentfishingzone = nil
				startFishing = false
				helpNotify = true
				isFishing = false
				onminiGame = false
				onautoFishing = false
				exports.helpnotify:hideHelpNotification()
            end
        end)
    end
end

function start()
	if startFishing then
		Citizen.CreateThread(function()
			while startFishing do
				Citizen.Wait(0)
				if not IsPedSwimming(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId(), true)then
					if helpNotify and startFishing and not isFishing and not onautoFishing then
						exports.helpnotify:showHelpNotification("กด","E","เพื่อเหวี่ยงเบ็ด")
						helpNotify = false
					end
					if IsControlJustPressed(0, 38) and not isFishing and not onautoFishing then
						ESX.TriggerServerCallback('checkRodBait', function(haveItem)
							if haveItem then
								onautoFishing = true
								isFishing = true
								ongoingFishing()
								processFishing()
							end
						end, currentfishingzone)
					end
				else
					exports.helpnotify:hideHelpNotification()
					helpNotify = true
					Citizen.Wait(500)
				end
			end
		end)
	end
end

function processFishing()	--
	for _,v in pairs(Config.FishingInfoClient) do
		if v.name == currentfishingzone then
			ESX.TriggerServerCallback('cc_fishing:checkCardFinshing', function(calculateFishingtime)
				--print(calculateFishingtime)
				TriggerEvent("mythic_progbar:client:progress",{
					name = "fishing",
					duration = calculateFishingtime, 
					label = "กำลังตกปลา",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = "amb@world_human_stand_fishing@idle_a",
						anim = "idle_c",
						flags = 49
					},
					prop = {
						model = "prop_fishing_rod_01", 
						bone = 18905,
						coords = { x = 0.1, y = 0.05, z = 0.0 },
						rotation = { x = 80.0, y = 120.0, z = 160.0 },
					}
				}, function(status)
					if not status then
						ObjectFishingRod()
						FishingAnim()
						exports.helpnotify:hideHelpNotification()
						onminiGame = true
						minigameFishing()
					end
				end)
			end, currentfishingzone, v.fishingTime)
		end
	end
end

function minigameFishing()
	for _,v in pairs(Config.FishingInfoClient) do
		if currentfishingzone == v.name then
			SendNUIMessage({type = "playsound"})
			Citizen.Wait(1000)

			local success = exports.cc_minigame:StartLockPickCircle(v.minigameQuantity,v.minigameTime,v.minigameFail,'whitespace')

			if success then
				ClearPedSecondaryTask(PlayerPedId())
				ClearPedTasks(PlayerPedId())
				SetEntityAsMissionEntity(ObjecRod, true, true)
				DeleteEntity(ObjecRod)
				TriggerServerEvent('succesMiniGame', currentfishingzone)
				helpNotify = true
				isFishing = false
				onminiGame = false
				exports.helpnotify:hideHelpNotification()
				Citizen.Wait(1000)
				autoFishing()
			else
				ClearPedSecondaryTask(PlayerPedId())
				ClearPedTasks(PlayerPedId())
				SetEntityAsMissionEntity(ObjecRod, true, true)
				DeleteEntity(ObjecRod)
				TriggerServerEvent('failMiniGame', currentfishingzone)
				helpNotify = true
				isFishing = false
				onminiGame = false
				exports.helpnotify:hideHelpNotification()
				Citizen.Wait(1000)
				autoFishing()
			end
		end
	end
end

function autoFishing()
	ESX.TriggerServerCallback('checkRodBait', function(haveItem)
		if haveItem then
			isFishing = true
			ongoingFishing()
			processFishing()
		else
			onautoFishing = false
		end
	end, currentfishingzone)
end

function ongoingFishing()
	exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
    Citizen.CreateThread(function()
		while isFishing do
            Citizen.Wait(0)
			if isFishing then
				DisableControlAction(0,Config.Key['G'], true)
				DisableControlAction(0, Config.Key['T'], true)
				DisableControlAction(0,Config.Key['H'], true)
				DisableControlAction(0, Config.Key['F'], true)
				EnableControlAction(0, Config.Key['E'], true)
				EnableControlAction(0, Config.Key['DELETE'], true)
				EnableControlAction(0, Config.Key['F2'], true)
				EnableControlAction(0, Config.Key['X'], true)
			end

			if IsControlJustPressed(0,73) and isFishing and not onminiGame then
				TriggerEvent("mythic_progbar:client:cancel")
				helpNotify = true
				isFishing = false
				onminiGame = false
				onautoFishing = false
				exports.helpnotify:hideHelpNotification()		
			end

			if IsPedInAnyVehicle(PlayerPedId(), true) then
                TriggerEvent("mythic_progbar:client:cancel")
				helpNotify = true
				isFishing = false
				onminiGame = false
				onautoFishing = false
				exports.helpnotify:hideHelpNotification()
            end
		end
	end)
end

function ObjectFishingRod()
	ObjecRod = CreateObject(GetHashKey('prop_fishing_rod_01'), GetEntityCoords(PlayerPedId()), true, true, false)  
	AttachEntityToEntity(ObjecRod, PlayerPedId(),GetPedBoneIndex(PlayerPedId(), 18905), 0.1, 0.05, 0, 80.0, 120.0, 160.0, true, true, false, true, 1, true)
end

function FishingAnim()
	while (not HasAnimDictLoaded("amb@world_human_stand_fishing@idle_a")) do
		RequestAnimDict("amb@world_human_stand_fishing@idle_a")
		Citizen.Wait(100)
	end
	TaskPlayAnim(PlayerPedId(), "amb@world_human_stand_fishing@idle_a", "idle_c", 8.0, 8.0, -1, 17, 0, false, false, false)
end

RegisterNetEvent('cc_fishing:BrokenRod')
AddEventHandler('cc_fishing:BrokenRod', function ()
	damageBroken = math.random(1, 3)
	currentPed = GetPlayerPed(-1)
	maxHealth = GetEntityHealth(currentPed)-damageBroken
	SetEntityHealth(currentPed,maxHealth)
end)

AddEventHandler('esx:onPlayerDeath', function() 
	if startFishing then
		isFishing = false
		onautoFishing = false
		TriggerEvent("mythic_progbar:client:cancel")
	end
end)







