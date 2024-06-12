ESX                           = nil
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local PlayerData              = {}
local helpNotify = true
local inShop = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()

	ESX.TriggerServerCallback('esx_shops:requestDBItems', function(ShopItems)
		for k,v in pairs(ShopItems) do
			if (Config.Zones[k] ~= nil) then
				Config.Zones[k].Items = v
			end
		end
	end)
end)

function OngoingOpen(zone)
	TriggerEvent("mythic_progbar:client:progress",{
		name = "ongoingopen",
		duration = 1000,
		label = "กำลังเปิดร้านค้า",
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
			OpenShopMenu(zone)		
		end
	end)
end

function OpenShopMenu(zone)
	PlayerData = ESX.GetPlayerData()
	
	SendNUIMessage({
		message		= "show",
		clear = true
	})


	Citizen.Wait(200)
	local elements = {}
	for i=1, #Config.Zones[zone].Items, 1 do

		local item = Config.Zones[zone].Items[i]
		if item.limit == -1 then
			item.limit = 100
		end

		if Config.Zones[zone].job  ~= nil then
			if Config.Zones[zone].job ~= ESX.PlayerData.job.name then
				exports.nc_notify:PushNotification({
					scale = 1.0, -- ปรับขนาดของ Notify
					title = 'ระบบร้านค้า', -- หัวเรื่อง
					description = 'ไม่สิทธิในการใช้งานร้านค้า', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
					type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
					position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
					direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
					priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
					icon = 'no_result', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
					duration = 3000 -- ระยะเวลาการแสดง Notify
				})
				return
			end
		end

		SendNUIMessage({
			message		= "add",
			item		= item.item,
			label      	= item.label,
			item       	= item.item,
			price      	= item.price,
			max        	= item.limit,
			type 		= item.type,
			loc			= zone
		})

	end

	SetTimecycleModifier('hud_def_blur') -- blur
	SetTimecycleModifierStrength(1.0)
	
	ESX.SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)
end

AddEventHandler('esx_shops:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_menu')
	CurrentActionData = {zone = zone}
end)

AddEventHandler('esx_shops:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Create Blips
-- Citizen.CreateThread(function()

-- 	for i=1, #Config.Map, 1 do

-- 		local blip = AddBlipForCoord(Config.Map[i].x, Config.Map[i].y, Config.Map[i].z)
-- 		SetBlipSprite (blip, Config.Map[i].id)
-- 		SetBlipScale  (blip, 0.6)
-- 		SetBlipDisplay(blip, 4)
-- 		SetBlipColour (blip, Config.Map[i].color)
-- 		SetBlipAsShortRange(blip, true)

-- 		BeginTextCommandSetBlipName("STRING")
-- 		AddTextComponentString(Config.Map[i].name)
-- 		EndTextCommandSetBlipName(blip)
-- 	end

-- end)

-- Display markers
local swieczkaHadesa = false
local czas = 1000
-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0+czas)
		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			--print(v.job)
			for i = 1, #v.Pos, 1 do
				if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 5) and v.isMark and not IsPedInAnyVehicle(PlayerPedId(), false) then
					DrawMarker(Config.Type,v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
				end

				if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 1)  and not IsPedInAnyVehicle(PlayerPedId(), false) then
					if helpNotify then
						exports.helpnotify:showHelpNotification("กด","E","เพื่อซื้อสินค้า")
						helpNotify = false
					end
					isInMarker  = true
					ShopItems   = v.Items
					currentZone = k
					LastZone    = k
				end

				if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < 5) and not IsPedInAnyVehicle(PlayerPedId(), false) then
					if k then
						czas = 0
					else
						czas = 1000
					end
				end
			end
		end

		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_shops:hasEnteredMarker', currentZone)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			exports.helpnotify:hideHelpNotification()
			helpNotify = true
			ESX.UI.Menu.CloseAll()
			closeGui()
			TriggerEvent('esx_shops:hasExitedMarker', LastZone)
		end
		::endState::
	end
end)

Citizen.CreateThread(function()
	while true do
		if czas == 0 then
		Citizen.Wait(5000)
		czas = 1000
		else
			Citizen.Wait(5000)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if CurrentAction ~= nil then
			if IsControlJustReleased(0, 38) and not IsPedInAnyVehicle(PlayerPedId(), false) and not inShop then
				if CurrentAction == 'shop_menu' then
					exports.helpnotify:hideHelpNotification()
					inShop = true,
					--Citizen.Wait(1000)
					OpenShopMenu(CurrentActionData.zone)
					pcall(function() -- Start log
						exports['azael_dc-serverlogs']:insertData({
							event = 'OpenShopMenu',
							content = ('ผู้เล่นได้ทำการกด E เปิดเมนูร้านค้า'):format(),
						})
					end) -- End log
				end
				--CurrentAction = nil
			--elseif IsControlJustReleased (0, 44) then
			--	ESX.SetTimeout(200, function()
			--		SetNuiFocus(false, false)
			--	end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function closeGui()
  inShop = false
  SetNuiFocus(false, false)
  SendNUIMessage({message = "hide"})
  SetTimecycleModifier('default') -- blur
end

AddEventHandler('esx:onPlayerDeath', function(data)
	CurrentAction = nil
	helpNotify = false
	exports.helpnotify:hideHelpNotification()
	closeGui()
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
	helpNotify = true
end)

RegisterNUICallback('quit', function(data, cb)
  closeGui()
	helpNotify = true
	pcall(function() -- Start log
        exports['azael_dc-serverlogs']:insertData({
            event = 'CloseShopMenu',
            content = ('ผู้เล่นได้ทำการปิดเมนูร้านค้า'):format(),
        })
    end) -- End log
  cb('ok')
end)

RegisterNUICallback('purchase', function(data, cb)
	TriggerServerEvent('esx_shops:buyItem', data.item, data.count, data.loc, data.type)
	cb('ok')
end)

RegisterNUICallback('purchaseCredit', function(data, cb)
	TriggerServerEvent('esx_shops:buyItemCredit', data.item, data.count, data.loc, data.type)
	cb('ok')
end)