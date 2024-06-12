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
ESX = nil
local FirstSpawn = true
local sex = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		SetPedMaxHealth(GetPlayerPed(-1), Config.PedMaxHealth)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('Bose_skin:addskin')
AddEventHandler('Bose_skin:addskin', function(skin)
	local playerPed = PlayerPedId()
	local skin = skin

	if skin == "mp_m_freemode_01" or skin == "mp_f_freemode_01" or skin == "default" or skin == "" or skin == " " then
		RequestModel(skin)
		TriggerEvent('skinchanger:getSkin', function(skin)
			sex = skin["sex"]
		end)
		if sex == 0 then
			skin = "mp_m_freemode_01"
		elseif sex == 1 then
			skin = "mp_f_freemode_01"
		end
		
		Citizen.CreateThread(function()
			while not HasModelLoaded(skin) do
				RequestModel(skin)
				Citizen.Wait(0)
			end

			if IsModelInCdimage(skin) and IsModelValid(skin) then
				SetPlayerModel(PlayerId(), skin)
				SetPedDefaultComponentVariation(playerPed)
			end

			SetModelAsNoLongerNeeded(skin)

			if cb ~= nil then
				cb()
			end

			TriggerEvent('skinchanger:modelLoaded')
		end)
		Citizen.Wait(Config.Delay2)
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin4, jobSkin)
			TriggerEvent('skinchanger:loadSkin', skin4)
		end)

		TriggerServerEvent('Bose_skin:saveskin', "default")
	else
		RequestModel(skin)
		Citizen.CreateThread(function()
			while not HasModelLoaded(skin) do
				RequestModel(skin)
				Citizen.Wait(0)
			end

			if IsModelInCdimage(skin) and IsModelValid(skin) then
				SetPlayerModel(PlayerId(), skin)
				SetPedDefaultComponentVariation(playerPed)
			end

			SetModelAsNoLongerNeeded(skin)

			if cb ~= nil then
				cb()
			end

			TriggerEvent('skinchanger:modelLoaded')
		end)
		Citizen.Wait(Config.Delay2)
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin6, jobSkin)
			TriggerEvent('skinchanger:loadSkin', skin6)
		end)
		TriggerServerEvent('Bose_skin:saveskin', skin)
		
	end
	SetEntityHealth(GetPlayerPed(-1), Config.PedHealth)
end)

RegisterNetEvent('Bose_skin:addskins')
AddEventHandler('Bose_skin:addskins', function(skin)
	TriggerServerEvent('Bose_skin:addskins', skin)
end)

Citizen.CreateThread(function()
	while true do
		SetPedMaxHealth(GetPlayerPed(-1), Config.PedMaxHealth)
		if IsControlJustReleased(0, Keys[Config.OpenSkinMenu]) and Config.UseMoreSkin then
			ESX.TriggerServerCallback('Bose_skin:checkPlayerHaveSkin', function(skins)
				if skins > 0 then
					OpenSkinMenu()
					Citizen.Wait(1000)
				end
			end)
		end
		Citizen.Wait(0)
	end
end)

function OpenSkinMenu()
	ESX.TriggerServerCallback('Bose_skin:getPlayerSkinList', function(skins)
		local elements = {}
		elements = {
			{label = "สกิลหลัก", value = 'default'}
		}
		for i=1, #skins, 1 do
			table.insert(elements, {
				label = skins[i].skin,
				value = skins[i].skin
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'PlayerSkinMenu', {
			title    = "Player Skin Menu",
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
		TriggerEvent('Bose_skin:addskin', data.current.value)
		exports.pNotify:SendNotification(
		{
			text = "เปลี่ยนสกิลเป็น "..data.current.value.." แล้ว",
			type = "info",
			timeout = 3000,
			layout = "centerLeft",
			queue = "left"
		}
		)
		menu.close()
	end, function(data, menu)
	menu.close()
end)

	end)
end

AddEventHandler('playerSpawned', function()
	if FirstSpawn then
		Citizen.Wait(Config.Delay1)
		ESX.TriggerServerCallback('Bose_skin:getskin', function(skin2)
			if skin2 == nil or skin2 == "" or skin2 == "default" then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin3, jobSkin)
					if skin3 == nil then
						TriggerEvent('skinchanger:loadSkin', {sex = 0})
					else
						TriggerEvent('skinchanger:loadSkin', skin3)
					end
				end)
			else
				TriggerEvent('Bose_skin:addskin', skin2)
			end
		end)
		FirstSpawn = false

	end
end)
