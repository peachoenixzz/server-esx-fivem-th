--================================================================================================--
--==                                VARIABLES - DO NOT EDIT                                     ==--
--================================================================================================--
ESX                         = nil
inMenu                      = true
local atbank = false
local bankMenu = true
local helpnotify = true
local keys = {
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

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)





local sleep = 0
if bankMenu then
	Citizen.CreateThread(function()
		while true do
			Wait(sleep)
			if nearBank() or nearATM() and not IsPedInAnyVehicle(PlayerPedId(), false) then
				sleep = 0
				if helpnotify then
					exports.helpnotify:showHelpNotification("กด", "E",
							"เพื่อใช้งาน")
					helpnotify = false
				end
				if IsControlJustPressed(1, keys[Config.Keys.Open]) then --เริ่มกด E ตรงนี้
					openUI()
					TriggerServerEvent('bank:balance')
					exports.helpnotify:hideHelpNotification()
					local ped = GetPlayerPed(-1)
					pcall(function() -- Start Log
						exports['azael_dc-serverlogs']:insertData({
							event = 'PlayerUseATM',
							content = ('ผู้เล่นได้ทำการกด E เพื่อใช้งานตู้ ATM'):format(),
						})
					end) -- End Log
				end
			else
				sleep = 1000
				if not helpnotify then
					exports.helpnotify:hideHelpNotification()
					closeUI()
					helpnotify = true
				end
			end

			if IsControlJustPressed(1, keys[Config.Keys.Close]) then
				if nearBank() or nearATM() then
					closeUI()
					if not helpnotify then
						exports.helpnotify:hideHelpNotification()
						helpnotify = true
					end
				end
			end
		end
	end)
end


--===============================================
--==             Map Blips	                   ==
--===============================================

--BANK
-- Citizen.CreateThread(function()
	-- if Config.ShowBlips then
	  -- for k,v in ipairs(Config.Bank)do
		-- local blip = AddBlipForCoord(v.x, v.y, v.z)
		-- SetBlipSprite (blip, v.id)
		-- SetBlipDisplay(blip, 4)
		-- SetBlipScale  (blip, 0.9)
		-- SetBlipColour (blip, 2)
		-- SetBlipAsShortRange(blip, true)
		-- BeginTextCommandSetBlipName("STRING")
		-- AddTextComponentString(_U("bank_blip"))
		-- EndTextCommandSetBlipName(blip)
	  -- end
	-- end
-- end)

--ATM
-- Citizen.CreateThread(function()
	-- if Config.ShowBlips and Config.OnlyBank == false then
	  -- for k,v in ipairs(Config.ATM)do
		-- local blip = AddBlipForCoord(v.x, v.y, v.z)
		-- SetBlipSprite (blip, v.id)
		-- SetBlipDisplay(blip, 4)
		-- SetBlipScale  (blip, 0.9)
		-- SetBlipColour (blip, 2)
		-- SetBlipAsShortRange(blip, true)
		-- BeginTextCommandSetBlipName("STRING")
		-- AddTextComponentString(_U("atm_blip"))
		-- EndTextCommandSetBlipName(blip)
	  -- end
	-- end
-- end)


--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balanceBank,balanceMoney)
	local id = PlayerId()
	local playerName = GetPlayerName(id)
	SendNUIMessage({
		action = "balanceHUD",
		balanceBank = balanceBank,
		balanceMoney = balanceMoney,
		player = playerName
	})
end)
--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('bank:deposit', tonumber(data.amount))
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==          Withdraw Event                   ==
--===============================================
RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('bank:withdraw', tonumber(data.amountw))
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==         Balance Event                     ==
--===============================================
RegisterNUICallback('balance', function()
	TriggerServerEvent('bank:balance')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)


--===============================================
--==         Transfer Event                    ==
--===============================================
RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('bank:transfer', data.to, data.amountt)
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==         Result   Event                    ==
--===============================================
RegisterNetEvent('bank:result')
AddEventHandler('bank:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)


--===============================================
--==         ESX Invest Event                  ==
--===============================================
RegisterNUICallback('esx_invest', function()
	if(inMenu) then
		inMenu = false
		SetNuiFocus(false, false)
		SendNUIMessage({type = 'closeAll'})
		exports.esx_invest:openUI()
	end
end)

--===============================================
--==               NUIFocusoff                 ==
--===============================================
RegisterNUICallback('NUIFocusOff', function()
	closeUI()
	pcall(function() -- Start Log
		exports['azael_dc-serverlogs']:insertData({
			event = 'PlayerStopUseATM',
			content = ('ผู้เล่นได้หยุดการใช้งานตู้ ATM'):format(),
		})
	end) -- End Log
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	helpnotify = false
	exports.helpnotify:hideHelpNotification()
	closeUI()
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
	helpnotify = true
end)


AddEventHandler('onResourceStop', function (resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	closeUI()
end)

AddEventHandler('onResourceStart', function (resourceName)
	if(GetCurrentResourceName() ~= resourceName) then
		return
	end
	closeUI()
end)


--===============================================
--==            Capture Bank Distance          ==
--===============================================
function nearBank()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Bank) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 1 then
			return true
		end
	end
end

function nearATM()
	local player = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(player, 0)
	local atmProp = {"prop_atm_01","prop_atm_02","prop_atm_03","prop_fleeca_atm",}

	for _, v in pairs(atmProp) do
		--local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		--
		--if distance <= 1 then
		--	return true
		--end
		local atmObject = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(v), false)
		--print(atmObject,v)
		if DoesEntityExist(atmObject) then
			-- Player is near an ATM, display message
			return true
		end
	end
end

function closeUI()
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({action = 'closeAll'})
	SetTimecycleModifier('default')
	SetTimecycleModifierStrength(0.0);
end

function openUI()
	inMenu = true
	if Config.Animation.Active then
		playAnim('mp_common', 'givetake1_a', Config.Animation.Time)
		Citizen.Wait(Config.Animation.Time)
	end
	SetTimecycleModifier('hud_def_blur')
	SetTimecycleModifierStrength(0.5);
	SetNuiFocus(true, true)
	--print("hi")
	SendNUIMessage({action = 'openGeneral'})
	TriggerServerEvent('bank:balance')
end


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
