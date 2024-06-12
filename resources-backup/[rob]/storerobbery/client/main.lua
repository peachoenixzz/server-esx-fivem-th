Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}
local script_name = GetCurrentResourceName()
local Token = nil
local ServerEvent = {}
local isRemoveItems = true
local Result = nil
local uiOpen = false
local currentRegister   = 0
local currentSafe = 0
local usingAdvanced = false
local robb = false
--local currentpos = 0
--local robsafe = false
--local robcashier = false
local havekey = false
local fail = false
local timetotal = 0
--local timesafe = 0
--local timecashier = 0

Config = {}

Citizen.CreateThread(function()
	--PlayerData = ESX.GetPlayerData()
	TriggerServerEvent(script_name .. ':server:LoadConfig')
end)

RegisterNetEvent(script_name .. ':client:GetConfig')
AddEventHandler(script_name .. ':client:GetConfig',  function(f)
    ServerEvent = f.se
	Token = f.tk
	Config = f.cf
	
	LoadScript()
end)

--RegisterNetEvent('esx:playerLoaded')
--AddEventHandler('esx:playerLoaded', function(xPlayer)
--    PlayerData = xPlayer
--end)
--
--RegisterNetEvent('esx:setJob')
--AddEventHandler('esx:setJob', function(job)
--	PlayerData.job = job
--end)

--- CODE
function LoadScript()
	--Citizen.CreateThread(function()
	--	Citizen.Wait(1000)
	--	setupRegister()
	--	setupSafes()
	--	while true do
	--		local ped = GetPlayerPed(-1)
	--		local pos = GetEntityCoords(ped)
	--		local inRange = false
	--		for k, v in pairs(Config.Registers) do
	--			local dist = GetDistanceBetweenCoords(pos, Config.Registers[k].x, Config.Registers[k].y, Config.Registers[k].z)
	--			if dist <= 1.0 and Config.Registers[k].robbed then
	--				inRange = true
	--				DrawText3Ds(Config.Registers[k].x, Config.Registers[k].y, Config.Registers[k].z, 'This cashier is empty....')
	--			end
	--		end
	--		if not inRange then
	--			Citizen.Wait(2000)
	--		end
	--		Citizen.Wait(3)
	--	end
	--end)

	--Citizen.CreateThread(function()
	--	while true do
	--		Citizen.Wait(1)
	--		local inRange = false
	--
	--			local pos = GetEntityCoords(GetPlayerPed(-1))
	--			for safe,_ in pairs(Config.Safes) do
	--				local dist = GetDistanceBetweenCoords(pos, Config.Safes[safe].x, Config.Safes[safe].y, Config.Safes[safe].z)
	--				if dist < 3 then
	--					inRange = true
	--					if dist < 0.7 then
	--						if not Config.Safes[safe].robbed then
	--							if robb and havekey then
	--								DrawText3Ds(Config.Safes[safe].x, Config.Safes[safe].y, Config.Safes[safe].z, 'Press ~g~E~w~ to open the safe.')
	--								if IsControlJustPressed(0, Keys["E"]) then
	--									print(exports.Dv_Hunter_check:CheckPolice(1))
	--									if exports.Dv_Hunter_check:CheckPolice(1) then
	--										currentSafe = safe
	--										local crpos = {x = Config.Safes[safe].x, y = Config.Safes[safe].y, z = Config.Safes[safe].z}
	--										TriggerServerEvent('what_emergency-alert:sv:alertPolice', "STORE ROB")
	--										-- if not robsafe then
	--											-- robsafe = true
	--											-- timesafe = 15
	--										-- end
	--
	--										if Config.Safes[safe].type == "keypad" then
	--											SendNUIMessage({
	--												action = "openKeypad",
	--											})
	--											SetNuiFocus(true, true)
	--										else
	--											ESX.TriggerServerCallback('cc_storerobbery:server:getPadlockCombination', function(combination)
	--												TriggerEvent("SafeCracker:StartMinigame", combination)
	--											end, safe)
	--										end
	--									else
	--										exports['what_notify']:MsgNotification({
	--											msg = 'Required more cop to get it.',
	--											type = 1,
	--											wait = 5,
	--										})
	--									end
	--								end
	--							end
	--						else
	--							DrawText3Ds(Config.Safes[safe].x, Config.Safes[safe].y, Config.Safes[safe].z, 'This safe is empty.')
	--						end
	--					end
	--				end
	--			end
	--
	--
	--		if not inRange then
	--			Citizen.Wait(2000)
	--		end
	--	end
	--end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if robb then
				Citizen.Wait(1000)
				timetotal = timetotal - 1
				if timetotal <= 0 then
					robb = false
					havekey = false
					-- local crpos = {x = Config.Registers[currentpos].x, y = Config.Registers[currentpos].y, z = Config.Registers[currentpos].z}
					-- TriggerServerEvent("lone_police:defaultAlert", "storerobbery", "male", getStreetName(crpos), crpos,"rgb(255, 255, 0,0.5)")
					-- currentpos = 0
				end
				-- if robcashier then
					-- timecashier = timecashier - 1
					-- if timecashier <= 0 then
						-- robcashier = false
						-- local crpos = {x = Config.Registers[currentpos].x, y = Config.Registers[currentpos].y, z = Config.Registers[currentpos].z}
						-- TriggerServerEvent("lone_police:defaultAlert", "storerobbery", "male", getStreetName(crpos), crpos,"rgb(255, 255, 0,0.5)")
					-- end
				-- end
				-- if robsafe then
					-- timesafe = timesafe - 1
					-- if timesafe <= 0 then
						-- robsafe = false
						-- local crpos = {x = Config.Registers[currentpos].x, y = Config.Registers[currentpos].y, z = Config.Registers[currentpos].z}
						-- TriggerServerEvent("lone_police:defaultAlert", "storerobbery", "male", getStreetName(crpos), crpos,"rgb(255, 255, 0,0.5)")
					-- end
				-- end
			else
				Citizen.Wait(500)
			end
		end
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if robb then
				--prepare for safe
				--if timetotal > 0 then
				--	drawTxt(1.26, 1.46 , 1.0,1.0,0.4, 'Robbery time ~r~' .. timetotal .. '~w~ seconds remaning', 255, 255, 255, 255)
				--end
				-- if robcashier and timecashier > 0 then
					-- drawTxt(1.26, 1.43 , 1.0,1.0,0.4, 'Cashier time ~r~' .. timecashier .. '~w~ seconds remaning', 255, 255, 255, 255)
				-- end
				-- if robsafe and timesafe > 0 then
					-- drawTxt(1.26, 1.43 , 1.0,1.0,0.4, 'Safe time ~r~' .. timesafe .. '~w~ seconds remaning', 255, 255, 255, 255)
				-- end
			else
				Citizen.Wait(500)
			end
		end
	end)



	function setupRegister()
		ESX.TriggerServerCallback('cc_storerobbery:server:getRegisterStatus', function(Registers)
			for k, v in pairs(Registers) do
				Config.Registers[k].robbed = Registers[k].robbed
			end
		end)
	end

	function setupSafes()
		ESX.TriggerServerCallback('cc_storerobbery:server:getSafeStatus', function(Safes)
			for k, v in pairs(Safes) do
				Config.Safes[k].robbed = Safes[k].robbed
			end
		end)
	end

	function miniGameLockPick(state)
		Wait(300)
		isRemoveItems = state
		if not uiOpen then
			uiOpen = true
			if isRemoveItems then
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						event = 'StoreRobberyMiniGameStart',
						content = ('ผู้เล่นได้เริ่มเล่นมินิเกมงัดร้านค้า'):format(),
					})
				end) -- End log
			end
			pcall(function() -- Start log
				exports['azael_dc-serverlogs']:insertData({
					event = 'StoreRobberyMiniGameStart',
					content = ('ผู้เล่นได้เริ่มเล่นมินิเกมส์ Lockpick'):format(),
				})
			end) -- End log
			SendNUIMessage({
				action = "ui",
				toggle = true,
			})
			SetCursorLocation(0.5, 0.2)
			while uiOpen do
				Wait(5)
				SetNuiFocus(true, true)
			end
			Wait(500)
			SetNuiFocus(false, false)
			return Result
		end
	end

	RegisterNUICallback('fail', function()
		if uiOpen then
			Result = false
			uiOpen = false
			if math.random(1,100) < 60 and isRemoveItems then
				TriggerServerEvent("cc_storerobbery:server:removeitem")
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						event = 'StoreRobberyMiniGameFail',
						content = ('ผู้เล่นได้เล่นมินิเกมงัดร้านค้าไม่ผ่าน'):format(),
					})
				end)
			end
			SendNUIMessage({
				action = "ui",
				toggle = false,
			})
			pcall(function() -- Start log
				exports['azael_dc-serverlogs']:insertData({
					event = 'LockPickMiniGameFail',
					content = ('ผู้เล่น เล่นมินิเกมส์ Lockpick ไม่สำเร็จ'):format(),
				})
			end) -- End log
		end
		isRemoveItems = true
	end)

	RegisterNUICallback('exit', function()
		if uiOpen then
			Result = false
			uiOpen = false
			SendNUIMessage({
				action = "ui",
				toggle = false,
			})
			if isRemoveItems then
				TriggerServerEvent("cc_storerobbery:server:removeitem")
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						event = 'StoreRobberyMiniGameExit',
						content = ('ผู้เล่นได้ออกจากการเล่นมินิเกมงัดร้านค้า'):format(),
					})
				end) -- End log
			end
			pcall(function() -- Start log
				exports['azael_dc-serverlogs']:insertData({
					event = 'StoreRobberyMiniGameExit',
					content = ('ผู้เล่นได้ออกจากการเล่น มินิเกมส์ Lockpick'):format(),
				})
			end) -- End log
		end
		isRemoveItems = true
	end)


	RegisterNUICallback('success', function()
		Result = true
		uiOpen = false
		SendNUIMessage({
			action = "ui",
			toggle = false,
		})

		if isRemoveItems then
			TriggerServerEvent("cc_storerobbery:server:removeitem")
		end

			--havekey = true
			--ongoingstoreRob = true
			-- robcashier = false
			-- timecashier = 0
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'StoreRobberyMiniGameSuccess',
				content = ('ผู้เล่นได้เล่นมินิเกมงัดร้านค้าผ่าน'):format(),
			})
		end) -- End log
		isRemoveItems = true
	end)

	function loadAnimDict(dict)
		while (not HasAnimDictLoaded(dict)) do
			RequestAnimDict(dict)
			Citizen.Wait(100)
		end
	end

	function takeAnim()
		fail = true
		local ped = GetPlayerPed(-1)
		while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do
			RequestAnimDict("amb@prop_human_bum_bin@idle_b")
			Citizen.Wait(100)
		end
		TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "idle_d", 8.0, 8.0, -1, 50, 0, false, false, false)
		Citizen.Wait(2500)
		TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "exit", 8.0, 8.0, -1, 50, 0, false, false, false)
		Citizen.Wait(5000)
		fail = false
	end

	--start minigame safecracker let go to another script
	RegisterNetEvent('SafeCracker:EndMinigame')
	AddEventHandler('SafeCracker:EndMinigame', function(won)
		if currentSafe ~= 0 then
			if won then
				if not Config.Safes[currentSafe].robbed then
					-- robsafe = false
					-- timesafe = 0
					SetNuiFocus(false, false)
					TriggerServerEvent(script_name .. ServerEvent[2], currentSafe, Token)
					TriggerServerEvent("cc_storerobbery:server:setSafeStatus", currentSafe)
					takeAnim()
					timetotal = 0
					currentSafe = 0
				end
			end
		end
	end)

	RegisterNUICallback('PadLockSuccess', function()
		if currentSafe ~= 0 then
			if not Config.Safes[currentSafe].robbed then
				--[[SendNUIMessage({
					action = "kekw",
				})]]--
			end
		--[[else
			SendNUIMessage({
				action = "kekw",
			})]]--
		end
	end)

	RegisterNUICallback('PadLockClose', function()
		SetNuiFocus(false, false)
	end)

	RegisterNUICallback("CombinationFail", function(data, cb)
		PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
	end)

	--when enter keypad logic
	RegisterNUICallback('TryCombination', function(data, cb)
		ESX.TriggerServerCallback('cc_storerobbery:server:isCombinationRight', function(combination)
			if tonumber(data.combination) ~= nil then
				if tonumber(data.combination) == combination then
					-- robsafe = false
					-- timesafe = 0
					TriggerServerEvent(script_name .. ServerEvent[2], currentSafe, Token)
					TriggerServerEvent("cc_storerobbery:server:setSafeStatus", currentSafe)
					SetNuiFocus(false, false)
					SendNUIMessage({
						action = "closeKeypad",
						error = false,
					})
					takeAnim()
					timetotal = 0
					currentSafe = 0
					
				else
					SetNuiFocus(false, false)
					SendNUIMessage({
						action = "closeKeypad",
						error = true,
					})
					currentSafe = 0
				end
			end
		end, currentSafe)
	end)


	RegisterNetEvent('cc_storerobbery:client:setRegisterStatus')
	AddEventHandler('cc_storerobbery:client:setRegisterStatus', function(register, bool)
		Config.Registers[register].robbed = bool
	end)

	RegisterNetEvent('cc_storerobbery:client:setSafeStatus')
	AddEventHandler('cc_storerobbery:client:setSafeStatus', function(safe, bool)
		Config.Safes[safe].robbed = bool
	end)
end

AddEventHandler('esx:onPlayerDeath', function(data)
	if uiOpen then
		Result = false
		uiOpen = false
		SendNUIMessage({
			action = "ui",
			toggle = false,
		})
		TriggerServerEvent("cc_storerobbery:server:removeitem")
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'StoreRobberyMiniGameExit',
				content = ('ผู้เล่นได้ออกจากการเล่นมินิเกมงัดร้านค้า (เสียชีวิต)'):format(),
			})
		end) -- End log
	end
end)

