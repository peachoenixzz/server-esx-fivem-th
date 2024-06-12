
Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["Enter"] = 191
}

local cantdo 			= nil
Dv_Hunter                   = GetCurrentResourceName()


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if cantdo then
			DisableAllControlActions(0)
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent(Dv_Hunter..'suit')
AddEventHandler(Dv_Hunter..'suit', function (suit)
	TriggerEvent('esx_inventoryhud:closeHud')
	cantdo = true
	animationsuit()
	Citizen.Wait(2000)
	Changeset(suit)
	cantdo = false
end)

function animationsuit()
	local ped = PlayerPedId()
	RequestAnimDict(Config.RequestAnimDict)
	while (not HasAnimDictLoaded(Config.RequestAnimDict)) do 
		Citizen.Wait(0)
	end
	Wait(100)
	TaskPlayAnim(ped, Config.RequestAnimDict, Config.TaskPlayAnim, 1.0, 1.0, -1, 0, 0, false, false, false) 
end

function Changeset(suit)
	if not maxez then
		maxez = true
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, suit.male)
			else
				TriggerEvent('skinchanger:loadClothes', skin, suit.female)
			end
		end)	
	else
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
		end)
		maxez = false
		ClearPedTasks(playerPed)
	end
end






