local HasAlreadyEnteredMarker = false
local LastZone, CurrentAction, CurrentActionMsg
local CurrentActionData	= {}

function OpenAccessoryMenu()
	local elements = {
		{unselectable = true, icon = "fas fa-user", title = TranslateCap('set_unset')},
		{icon = "fas fa-hat-cowboy", title = TranslateCap("helmet"), value = "Helmet"},
		{icon = "fas fa-deaf", title = TranslateCap("ears"), value = "Ears"},
		{icon = "fas fa-mask", title = TranslateCap("mask"), value = "Mask"},
		{icon = "fas fa-glasses", title = TranslateCap("glasses"), value = "Glasses"}
	}

	ESX.OpenContext("right", elements, function(menu,element)
		SetUnsetAccessory(element.value)
	end)
end

function SetUnsetAccessory(accessory)
	ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
		local _accessory = string.lower(accessory)

		if hasAccessory then
			TriggerEvent('skinchanger:getSkin', function(skin)
				local mAccessory = -1
				local mColor = 0

				if _accessory == "mask" then
					mAccessory = 0
				end

				if skin[_accessory .. '_1'] == mAccessory then
					mAccessory = accessorySkin[_accessory .. '_1']
					mColor = accessorySkin[_accessory .. '_2']
				end

				local accessorySkin = {}
				accessorySkin[_accessory .. '_1'] = mAccessory
				accessorySkin[_accessory .. '_2'] = mColor
				TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
			end)
		else
			ESX.ShowNotification(TranslateCap('no_' .. _accessory))
		end
	end, accessory)
end

function OpenShopMenu(accessory)
	local _accessory = string.lower(accessory)
	local restrict = {}

	restrict = { _accessory .. '_1', _accessory .. '_2' }
	TriggerEvent('esx_skin:openRestrictedMenuDefault', function(data, menu)
		menu.close()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm',
				{
					title = "ร้านหน้ากาก",
					align = 'bottom-right',
					elements = {
						{label = _U('yes', ESX.Math.GroupDigits(Config.Price)), value = 'yes'},
						{label = _U('no'), value = 'no'},
					}
				}, function(data, menu)
					menu.close()
					if data.current.value == 'yes' then
						ESX.TriggerServerCallback('esx_accessories:checkMoney', function(hasEnoughMoney)
							if hasEnoughMoney then
								TriggerServerEvent('esx_accessories:pay')
								TriggerEvent('skinchanger:getSkin', function(skin)
									TriggerServerEvent('esx_accessories:save', skin, accessory)
								end)
								return
							else
								local player = PlayerPedId()
								if accessory == "Ears" then
									ClearPedProp(player, 2)
								elseif accessory == "Mask" then
									SetPedComponentVariation(player, 1, 0 ,0, 2)
								elseif accessory == "Helmet" then
									ClearPedProp(player, 0)
								elseif accessory == "Glasses" then
									SetPedPropIndex(player, 1, -1, 0, 0)
								end
								ESX.ShowNotification(_U('not_enough_money'))
								return
							end
						end)
					end

					if data.current.value == 'no' then
						local player = PlayerPedId()
						if accessory == "Ears" then
							ClearPedProp(player, 2)
						elseif accessory == "Mask" then
							SetPedComponentVariation(player, 1, 0 ,0, 2)
						elseif accessory == "Helmet" then
							ClearPedProp(player, 0)
						elseif accessory == "Glasses" then
							SetPedPropIndex(player, 1, -1, 0, 0)
						end
						return
					end

					CurrentAction     = 'shop_menu'
					CurrentActionMsg  = _U('press_access')
					CurrentActionData = {}
				end, function(data, menu)
					menu.close()
					CurrentAction     = 'shop_menu'
					CurrentActionMsg  = _U('press_access')
					CurrentActionData = {}
					local player = PlayerPedId()
					if accessory == "Ears" then
						ClearPedProp(player, 2)
					elseif accessory == "Mask" then
						SetPedComponentVariation(player, 1, 0 ,0, 2)
					elseif accessory == "Helmet" then
						ClearPedProp(player, 0)
					elseif accessory == "Glasses" then
						SetPedPropIndex(player, 1, -1, 0, 0)
					end
				end)
	end, function(data, menu)
		menu.close()
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('press_access')
		CurrentActionData = {}
		local player = PlayerPedId()
		if accessory == "Ears" then
			ClearPedProp(player, 2)
		elseif accessory == "Mask" then
			SetPedComponentVariation(player, 1, 0 ,0, 2)
		elseif accessory == "Helmet" then
			ClearPedProp(player, 0)
		elseif accessory == "Glasses" then
			SetPedPropIndex(player, 1, -1, 0, 0)
		end
	end, restrict)
end

AddEventHandler('esx_accessories:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = TranslateCap('press_access')
	CurrentActionData = { accessory = zone }
end)

AddEventHandler('esx_accessories:hasExitedMarker', function(zone)
	ESX.CloseContext()
	CurrentAction = nil
end)

-- Create Blips --
-- CreateThread(function()
-- 	for k,v in pairs(Config.ShopsBlips) do
-- 		if v.Pos then
-- 			for i=1, #v.Pos, 1 do
-- 				local blip = AddBlipForCoord(v.Pos[i])

-- 				SetBlipSprite (blip, v.Blip.sprite)
-- 				SetBlipDisplay(blip, 4)
-- 				SetBlipScale  (blip, 1.0)
-- 				SetBlipColour (blip, v.Blip.color)
-- 				SetBlipAsShortRange(blip, true)

-- 				BeginTextCommandSetBlipName("STRING")
-- 				AddTextComponentSubstringPlayerName(TranslateCap('shop', TranslateCap(string.lower(k))))
-- 				EndTextCommandSetBlipName(blip)
-- 			end
-- 		end
-- 	end
-- end)

local nearMarker = false
-- Display markers
CreateThread(function()
	while true do
		local sleep = 1500
		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if(Config.Type ~= -1 and #(coords - v.Pos[i]) < Config.DrawDistance) then
					DrawMarker(Config.Type, v.Pos[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 255, false, true, 2, false, false, false, false)
					sleep = 0
					break
				end
			end
		end
		if sleep == 0 then nearMarker = true else nearMarker = false end
		Wait(sleep)
	end
end)

CreateThread(function()
	while true do
		local sleep = 1500
		if nearMarker then
			sleep = 0
			local coords = GetEntityCoords(PlayerPedId())
			local isInMarker = false
			local currentZone = nil
			for k,v in pairs(Config.Zones) do
				for i = 1, #v.Pos, 1 do
					if #(coords - v.Pos[i]) < Config.Size.x then
						isInMarker  = true
						currentZone = k
						break
					end
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone = currentZone
				TriggerEvent('esx_accessories:hasEnteredMarker', currentZone)
				exports.helpnotify:showHelpNotification("กด","E","เพื่อซื้อหน้ากาก")
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_accessories:hasExitedMarker', LastZone)
				exports.helpnotify:hideHelpNotification()
			end
		end
		Wait(sleep)
	end
end)

-- Key controls
CreateThread(function()
	while true do
		local Sleep = 1500
		
		if CurrentAction then
			Sleep = 0
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and CurrentActionData.accessory then
				exports.helpnotify:hideHelpNotification()
				OpenShopMenu(CurrentActionData.accessory)
				CurrentAction = nil
			end
		end
		Wait(Sleep)
	end
end)

if Config.EnableControls then
	RegisterCommand("accessory", function(src)
		if not ESX.PlayerData.dead then
			OpenAccessoryMenu()
		end
	end)

	RegisterKeyMapping("accessory", "Open Accessory Menu", "keyboard", "k")
end
