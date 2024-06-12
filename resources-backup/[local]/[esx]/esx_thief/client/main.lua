local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local searching = true
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function IsAbleToSearch(targetSID, err)
	ESX.TriggerServerCallback('esx_thief:getValue', function(result)
		local result = result
		if result.value then
			err(false)
		else
			err(_U('no_hands_up'))
		end
	end, targetSID)
end

function OpenBodySearchMenu(player)
	TriggerEvent("esx_inventoryhud:openPlayerInventory", GetPlayerServerId(player), GetPlayerName(player))
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local ped = PlayerPedId()
		if IsControlJustPressed(0, Keys['G']) and IsPedArmed(ped, 7) and not IsEntityDead(ped) and IsPedOnFoot(ped) then
			local target, distance = ESX.Game.GetClosestPlayer()

			if target ~= -1 and distance ~= -1 and distance <= 5.0 then
				local target_id = GetPlayerServerId(target)
				
				IsAbleToSearch(target_id, function(err)
					if(not err)then
						local playerPed = GetPlayerPed(-1)
						local coords = GetEntityCoords(playerPed)
						searching = true
						TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
						TriggerEvent("mythic_progbar:client:progress", {
							name = "unique_action_name",
							duration = 5000,
							label = "กำลังปล้นผู้เล่น",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
								},
								}, function(status)
								if not status then
									-- Do Something If Event Wasn't Cancelled
								end
							end)
						Citizen.Wait(5000)
						OpenBodySearchMenu(target, target_id)
						ClearPedTasksImmediately(playerPed)
						while searching do
							Citizen.Wait(100)
							ESX.TriggerServerCallback('esx_thief:getValue', function(result)
								local result = result
								print(result.value)
								if result.value == false then
									searching = false
									ESX.UI.Menu.CloseAll()
								end
							end, target_id)		
						end
					else
						ESX.ShowNotification(err)
					end
				end)
			elseif distance < 0 and distance > 5.0 then
				ESX.ShowNotification(_U('too_far'))
			else
				ESX.ShowNotification(_U('no_players_nearby'))
			end
		end
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		
	end
end)
