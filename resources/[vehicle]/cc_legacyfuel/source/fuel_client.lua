local WEAPON_UNARMED, WEAPON_PETROLCAN = GetHashKey('WEAPON_UNARMED'), GetHashKey('WEAPON_PETROLCAN')
local isNearPump = false
local isFueling = false
local currentFuel = 0.0
local currentCost = 0.0
local currentCash = 1000
local fuelSynced = false
local inBlacklisted = false

if Config.UseESX then
	Citizen.CreateThread(function()
		while not ESX do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(100)
		end

		while not (ESX.GetPlayerData() and ESX.GetPlayerData().money) do
			Citizen.Wait(0)
		end

		currentCash = ESX.GetPlayerData().money
	end)

	RegisterNetEvent('esx:setAccountMoney', function(account)
		if account.name == 'money' and account.money ~= currentCash then
			currentCash = account.money
		end
	end)
	RegisterNetEvent('es:activateMoney', function(amount)
		currentCash = amount
	end)
end

function ManageFuelUsage(vehicle)
	if not DecorExistOn(vehicle, Config.FuelDecor) then
		SetFuel(vehicle, math.random(200, 800) / 10)
	elseif not fuelSynced then
		SetFuel(vehicle, GetFuel(vehicle))
		fuelSynced = true
	end

	if IsVehicleEngineOn(vehicle) then
		--print(Config.Classes[GetVehicleClass(vehicle)])
		SetFuel(vehicle, GetVehicleFuelLevel(vehicle) - Config.FuelUsage[Round(GetVehicleCurrentRpm(vehicle), 1)] * (Config.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
	end
end


Citizen.CreateThread(function()
	DecorRegister(Config.FuelDecor, 1)

	for i = 1, #Config.Blacklist do
		if type(Config.Blacklist[i]) == 'string' then
			Config.Blacklist[GetHashKey(Config.Blacklist[i])] = true
		else
			Config.Blacklist[Config.Blacklist[i]] = true
		end
	end

	for i = #Config.Blacklist, 1, -1 do
		table.remove(Config.Blacklist, i)
	end

	while true do
		Citizen.Wait(1000)

		local ped = PlayerPedId()

		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
			local vehicleModel = GetEntityModel(vehicle)
			inBlacklisted = Config.Blacklist[vehicleModel] and true or false
			if not inBlacklisted and GetPedInVehicleSeat(vehicle, -1) == ped then
				ManageFuelUsage(vehicle)
			end
		else
			fuelSynced = false
			inBlacklisted = false
		end
	end
end)



RegisterNUICallback('close', function()
	isFueling = false
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(250)

		local pumpObject, pumpDistance = FindNearestFuelPump()

		if pumpDistance < 2.5 then
			isNearPump = pumpObject

			if Config.UseESX then
				local playerData = ESX.GetPlayerData()
				for i=1, #playerData.accounts, 1 do
					if playerData.accounts[i].name == 'money' then
						currentCash = playerData.accounts[i].money
						break
					end
				end
			end
		else
			isNearPump = false

			Citizen.Wait(math.ceil(pumpDistance * 20))
		end
	end
end)

RegisterCommand('se', function()
	local vehicle = GetPlayersLastVehicle()
	SetFuel(vehicle, 5)
end)

AddEventHandler('fuel:startFuelUpTick', function(pumpObject, ped, vehicle)
	currentFuel = GetVehicleFuelLevel(vehicle)

	local tankFuel = -1
	while isFueling do
		Citizen.Wait(10)
		local oldFuel = DecorGetFloat(vehicle, Config.FuelDecor)
		local fuelToAdd = 1.0
		local extraCost = fuelToAdd / 1.5 * Config.CostMultiplier

		if not pumpObject then
			local currentTankFuel = GetAmmoInPedWeapon(ped, WEAPON_PETROLCAN)
			local newTankFuel = math.floor(currentTankFuel - (fuelToAdd * 100))
			if newTankFuel >= 0 then
				currentFuel = oldFuel + fuelToAdd
				tankFuel = newTankFuel
				SetPedAmmo(ped, WEAPON_PETROLCAN, newTankFuel)
				SetFuel(vehicle, currentFuel)
			else
				isFueling = false
				SendNUIMessage({
					showDisplay = false,
				})
			end
		else
			currentFuel = oldFuel + fuelToAdd
		end

		if pumpObject then
			ESX.TriggerServerCallback('cc_fuel:checkMoney', function(money)
					if money >= math.floor(currentCost + extraCost) or not isNearPump then
						SetFuel(vehicle, currentFuel)
					end
					if money < math.floor(currentCost + extraCost) then
						isFueling = false
						SetFuel(vehicle, currentFuel)
						SendNUIMessage({
							showDisplay = false,
						})
						TriggerServerEvent('fuel:pay', math.floor(currentCost))
					end
					if money == math.floor(currentCost + extraCost) then
						isFueling = false
						SetFuel(vehicle, currentFuel)
						SendNUIMessage({
							showDisplay = false,
						})
						TriggerServerEvent('fuel:pay', math.floor(currentCost))
					end

					if currentFuel > 100.0 then
						currentFuel = 100.0
						SetFuel(vehicle, currentFuel)
						isFueling = false
						SendNUIMessage({
							showDisplay = false,
						})
						TriggerServerEvent('fuel:pay', math.floor(currentCost))
					end

					if pumpObject then
						currentCost = currentCost + extraCost
					end
			end,currentCost + extraCost)
		end

		--if currentFuel > 100.0 then
		--	currentFuel = 100.0
		--	isFueling = false
		--	SendNUIMessage({
		--		showDisplay = false,
		--	})
		--end
		--
		--currentCost = currentCost + extraCost
		--
		--if currentCash >= currentCost or not isNearPump then
		--	SetFuel(vehicle, currentFuel)
		--else
		--	isFueling = false
		--	SendNUIMessage({
		--		showDisplay = false,
		--	})
		--end
	end


	if not pumpObject then
		--TriggerServerEvent('fuel:pay', currentCost)
		pcall(function() exports.nc_inventory:UpdateWeaponAmmo('WEAPON_PETROLCAN', tankFuel) end)
	end

	currentCost = 0.0
end)

AddEventHandler('fuel:refuelFromPump', function(pumpObject, ped, vehicle)
	TaskTurnPedToFaceEntity(ped, vehicle, 2000)
	Citizen.Wait(2000)
	SetCurrentPedWeapon(ped, -1569615261, true)
	LoadAnimDict("timetable@gardener@filling_can")
	TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)

	TriggerEvent('fuel:startFuelUpTick', pumpObject, ped, vehicle)
	SendNUIMessage({
		showDisplay = true,
	})
	while isFueling do
		for _, controlIndex in pairs(Config.DisableKeys) do
			DisableControlAction(0, controlIndex)
		end

		local vehicleCoords = GetEntityCoords(vehicle)

		if pumpObject then
			SendNUIMessage({
				percent = Round(currentFuel, 1),
				money = roundxx(currentCost),
				ispump = true,
			})
		else
			SendNUIMessage({
				percent = Round(currentFuel, 1),
				percentjerry = roundxx(GetAmmoInPedWeapon(ped, 883325847) / 4500 * 100, 1),
				ispump = false,
			})
		end

		if not IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
			TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
		end

		 --if IsControlJustReleased(0, 38) or DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) or (isNearPump and GetEntityHealth(pumpObject) <= 0) then
		 --	Wait(1000)
		 --	isFueling = false
		 --	SendNUIMessage({
		 --		showDisplay = false,
		 --	})
		 --end

		Citizen.Wait(0)
	end

	SendNUIMessage({
		showDisplay = false,
	})

	ClearPedTasks(ped)
	RemoveAnimDict("timetable@gardener@filling_can")
end)

function roundxx(x)
	return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local ped = PlayerPedId()

		if not isFueling and ((isNearPump and GetEntityHealth(isNearPump) > 0) or (GetSelectedPedWeapon(ped) == WEAPON_PETROLCAN and not isNearPump)) then
			if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped), -1) == ped then
				local pumpCoords = GetEntityCoords(isNearPump)

				DrawText3Ds(pumpCoords.x, pumpCoords.y, pumpCoords.z + 1.2, Config.Strings.ExitVehicle)
			else
				local vehicle = GetPlayersLastVehicle()
				local vehicleCoords = GetEntityCoords(vehicle)

				if DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(ped), vehicleCoords) < 2.5 then
					if not DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) then
						local stringCoords = GetEntityCoords(isNearPump)
						local canFuel = true

						if GetSelectedPedWeapon(ped) == WEAPON_PETROLCAN then
							stringCoords = vehicleCoords

							if GetAmmoInPedWeapon(ped, WEAPON_PETROLCAN) < 150 then
								canFuel = false
							end
						end

						if GetVehicleFuelLevel(vehicle) < 95 and canFuel then
							if currentCash > 0 or not isNearPump then
								DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.EToRefuel)

								if IsControlJustReleased(0, 38) then
									isFueling = true

									TriggerEvent('fuel:refuelFromPump', isNearPump, ped, vehicle)
									LoadAnimDict('timetable@gardener@filling_can')
								end
							else
								DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.NotEnoughCash)
							end
						elseif not canFuel then
							DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.JerryCanEmpty)
						else
							DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.FullTank)
						end
					end
				elseif isNearPump then
					local stringCoords = GetEntityCoords(isNearPump)

					if currentCash >= Config.JerryCanCost then
						if not HasPedGotWeapon(ped, WEAPON_PETROLCAN) then
							DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.PurchaseJerryCan)

							if IsControlJustReleased(0, 38) then
								TriggerServerEvent('fuel:pay', Config.JerryCanCost, true)
							end
						else
							if Config.UseESX then
								local refillCost = Round(Config.RefillCost * (1 - GetAmmoInPedWeapon(ped, 883325847) / 4500))

								if refillCost > 0 then
									if currentCash >= refillCost then
										DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.RefillJerryCan .. refillCost)

										if IsControlJustReleased(0, 38) then
											TriggerServerEvent('fuel:pay', refillCost, true)
										end
									else
										DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.NotEnoughCashJerryCan)
									end
								else
									DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.JerryCanFull)
								end
							else
								DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.RefillJerryCan)

								if IsControlJustReleased(0, 38) then
									SetPedAmmo(ped, WEAPON_PETROLCAN, 4500)
								end
							end
						end
					else
						DrawText3Ds(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, Config.Strings.NotEnoughCash)
					end
				else
					Citizen.Wait(250)
				end
			end
		else
			Citizen.Wait(250)
		end
	end
end)

if Config.ShowNearestGasStationOnly then
	Citizen.CreateThread(function()
		local currentGasBlip = 0

		while true do
			local coords = GetEntityCoords(PlayerPedId())
			local closest = 1000
			local closestCoords

			for _, gasStationCoords in pairs(Config.GasStations) do
				local dstcheck = GetDistanceBetweenCoords(coords, gasStationCoords)

				if dstcheck < closest then
					closest = dstcheck
					closestCoords = gasStationCoords
				end
			end

			if DoesBlipExist(currentGasBlip) then
				RemoveBlip(currentGasBlip)
			end

			currentGasBlip = CreateBlip(closestCoords)

			Citizen.Wait(10000)
		end
	end)
elseif Config.ShowAllGasStations then
	Citizen.CreateThread(function()
		for _, gasStationCoords in pairs(Config.GasStations) do
			CreateBlip(gasStationCoords)
		end
	end)
end

if Config.EnableHUD then
	local function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
		SetTextFont(font)
		SetTextProportional(0)
		SetTextScale(sc, sc)
		N_0x4e096588b13ffeca(jus)
		SetTextColour(r, g, b, a)
		SetTextDropShadow(0, 0, 0, 0,255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(x - 0.1+w, y - 0.02+h)
	end

	local mph = 0
	local kmh = 0
	local fuel = 0
	local displayHud = false

	local x = 0.01135
	local y = 0.002

	Citizen.CreateThread(function()
		while true do
			local ped = PlayerPedId()

			if IsPedInAnyVehicle(ped) and not (Config.RemoveHUDForBlacklistedVehicle and inBlacklisted) then
				local vehicle = GetVehiclePedIsIn(ped)
				local speed = GetEntitySpeed(vehicle)

				mph = tostring(math.ceil(speed * 2.236936))
				kmh = tostring(math.ceil(speed * 3.6))
				fuel = tostring(math.ceil(GetVehicleFuelLevel(vehicle)))

				displayHud = true
			else
				displayHud = false

				Citizen.Wait(500)
			end

			Citizen.Wait(50)
		end
	end)

	Citizen.CreateThread(function()
		while true do
			if displayHud then
				DrawAdvancedText(0.130 - x, 0.77 - y, 0.005, 0.0028, 0.6, mph, 255, 255, 255, 255, 6, 1)
				DrawAdvancedText(0.174 - x, 0.77 - y, 0.005, 0.0028, 0.6, kmh, 255, 255, 255, 255, 6, 1)
				DrawAdvancedText(0.2195 - x, 0.77 - y, 0.005, 0.0028, 0.6, fuel, 255, 255, 255, 255, 6, 1)
				DrawAdvancedText(0.148 - x, 0.7765 - y, 0.005, 0.0028, 0.4, "mp/h              km/h              Fuel", 255, 255, 255, 255, 6, 1)
			else
				Citizen.Wait(750)
			end

			Citizen.Wait(0)
		end
	end)
end

function onNoMoneyToReFuel()
	exports.nc_notify:PushNotification({
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบปั้มน้ำมัน', -- หัวเรื่อง
		description = 'คุณมีเงินไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'no_money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end
