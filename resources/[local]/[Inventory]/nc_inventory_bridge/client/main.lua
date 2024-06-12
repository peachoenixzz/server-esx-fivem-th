-- ESX = nil
-- CreateThread(function()
-- 	while not ESX do
-- 		TriggerEvent(Config.EventRoute and Config.EventRoute['getSharedObject'] or 'esx:getSharedObject', function(obj) ESX = obj end)
-- 		Wait(0)
-- 	end
-- end)

local SECONDARY_TYPE = nil
local ITEMS = nil
local ITEM_COUNT = 0

local typesMap = { item_standard = 'item', item_account = 'account', item_weapon = 'weapon' }
local typesMapOriginal = { item = 'item_standard', account = 'item_account', weapon = 'item_weapon' }

local GetDefaultTbl = function()
	return { item = {}, account = {}, weapon = {} }
end

local function CloneTable(t)
	if type(t) ~= 'table' then return t end
	local meta = getmetatable(t)
	local target = {}
	for k, v in pairs(t) do
		target[k] = type(v) == 'table' and CloneTable(v) or v
	end
	setmetatable(target, meta)
	return target
end

AddEventHandler('nc_inventory_bridge:CloseInventory', function()
	if ITEMS then
		SendNUIMessage({ action = 'display_off' })
	end
end)

AddEventHandler('nc_inventory_bridge:Action', function(secondaryName, dragAction, item)
	if secondaryName == SECONDARY_TYPE then
		if dragAction and item then
			local itemType = item.type
			local itemCount = item.number
			item.type = typesMapOriginal[itemType]
			if dragAction == 'put' then
				Config.DoAction(dragAction, secondaryName, {
					number = itemCount,
					item = item
				})
			elseif dragAction == 'take' then
				if ITEMS and ITEMS[itemType] then
					local ownedItem = nil
					if itemType == 'weapon' then
						if item.uniqueKey then
							item.wKey = item.uniqueKey		-- for xzero_trunk
							local weaponName = string.format('%s:%s', item.name, item.uniqueKey)
							ownedItem = ITEMS[itemType][weaponName]
						else
							ownedItem = ITEMS[itemType][item.name]
						end
					else
						ownedItem = ITEMS[itemType][item.name]
					end
					if ownedItem then
						if ownedItem.count < itemCount then
							itemCount = ownedItem.count
						end
						Config.DoAction(dragAction, secondaryName, {
							number = itemCount,
							item = item
						})
					end
				end
			end
		end
	end
end)

RegisterNUICallback('setSecondInventoryItems', function(data)
	local dataCount = #data
	if ITEMS then
		local updateItems = {}
		if dataCount == ITEM_COUNT then			-- Update
			for _, v in ipairs(data) do
				local itemType = typesMap[v.type]
				if itemType then
					local itemName = itemType == 'weapon' and v.wKey and string.format('%s:%s', v.name, v.wKey) or v.name
					if ITEMS[itemType][itemName].count ~= v.count then
						ITEMS[itemType][itemName].count = v.count
					end
					table.insert(updateItems, {
						type = itemType,
						name = v.name,
						count = v.count,
						uniqueKey = v.wKey
					})
				end
			end
		elseif dataCount > ITEM_COUNT then		-- Add
			for _, v in ipairs(data) do
				local itemType = typesMap[v.type]
				if itemType then
					local update = false
					local itemName = itemType == 'weapon' and v.wKey and string.format('%s:%s', v.name, v.wKey) or v.name
					if not ITEMS[itemType][itemName] then
						ITEMS[itemType][itemName] = {
							count = v.count,
							uniqueKey = v.wKey
						}
						update = true
					elseif ITEMS[itemType][itemName].count ~= v.count then
						ITEMS[itemType][itemName].count = v.count
						update = true
					end
					if update then
						table.insert(updateItems, {
							type = itemType,
							name = v.name,
							count = v.count,
							uniqueKey = v.wKey
						})
					end
				end
			end
		else									-- Remove
			local tempItems = CloneTable(ITEMS)
			for _, v in ipairs(data) do
				local itemType = typesMap[v.type]
				if itemType then
					local itemName = itemType == 'weapon' and v.wKey and string.format('%s:%s', v.name, v.wKey) or v.name
					tempItems[itemType][itemName] = nil
				end
			end
			for itemType, v in pairs(tempItems) do
				for itemName, u in pairs(v) do
					local updateName = itemName
					if itemType == 'weapon' then
						local weaponName, uniqueKey = string.match(itemName, '(.+):(.+)')
						if weaponName and uniqueKey then
							updateName = weaponName
						end
					end
					table.insert(updateItems, {
						type = itemType,
						name = updateName,
						count = itemType == 'weapon' and -1 or 0,
						uniqueKey = u.uniqueKey
					})
					ITEMS[itemType][itemName] = nil
				end
			end
		end
		pcall(function() exports.nc_inventory:SetSecondaryData({ itemList = updateItems }) end)
	else				-- First Loaded
		local items, itemsArray = GetDefaultTbl(), {}
		for _, v in ipairs(data) do
			local itemType = typesMap[v.type]
			if itemType then
				local itemName = itemType == 'weapon' and v.wKey and string.format('%s:%s', v.name, v.wKey) or v.name
				items[itemType][itemName] = {
					count = v.count,
					uniqueKey = v.wKey
				}
				table.insert(itemsArray, {
					type = itemType,
					name = v.name,
					count = v.count,
					uniqueKey = v.wKey
				})
			end
		end
		ITEMS = items
		pcall(function() exports.nc_inventory:SetSecondaryData({ itemList = itemsArray }) end)
	end
	ITEM_COUNT = dataCount
end)

RegisterNUICallback('setInfoText', function(data)
	pcall(function()
		exports.nc_inventory:SetSecondaryData({
			info = data.plate or data.text,
			maxLimit = data.limit,
			weight = data.weight,
			maxWeight = data.max
		})
	end)
end)

RegisterNUICallback('display', function(secondaryType)
	SetNuiFocus(false, false)
	SECONDARY_TYPE = secondaryType
	pcall(function() exports.nc_inventory:OpenSecondaryInventory(secondaryType) end)
end)

RegisterNUICallback('NUIFocusOff', function()
	SECONDARY_TYPE = nil
	ITEMS = nil
	ITEM_COUNT = 0
	SetNuiFocus(false, false)
end)

function loadPlayerInventory() end


-- SCOTTY CAR KEYS
local scottyReady = false
AddEventHandler('scotty:globalFetchCarKeys', function(newKeys)
	while not scottyReady do Wait(0) end
	local keys = {}
	for k, v in pairs(newKeys or {}) do
		table.insert(keys, { name = k, label = k })
	end
	pcall(function() exports.nc_inventory:UpdateItemList({ type = 'vehicle_key', itemList = keys }) end)
end)
AddEventHandler('nc_inventory_bridge:SetScottyCarKeysReady', function() scottyReady = true end)


-- esx_inventoryhud
local GetEventName = function(a, b) return string.format('%s:%s', a, b) end
AddEventHandler('esx_inventoryhud:closeInventory', function()	-- esx_inventoryhud:closeInventory
	pcall(function() exports.nc_inventory:CloseInventory() end)
end)
local events = {
	['PoliceSearchInventory'] = function(playerId)				-- esx_inventoryhud:PoliceSearchInventory
		pcall(function() exports.nc_inventory:SearchInventory(playerId,'police') end)
	end
}
local netEvents = {
	['getOwnerVehicle'] = function()							-- esx_inventoryhud:getOwnerVehicle
		pcall(function() exports.nc_inventory:UpdateItems('vehicle_key') end)
	end,
	['getOwnerHouse'] = function()								-- esx_inventoryhud:getOwnerHouse
		pcall(function() exports.nc_inventory:UpdateItems('house_key') end)
	end,
	['getOwnerAccessories'] = function()						-- esx_inventoryhud:getOwnerAccessories
		pcall(function() exports.nc_inventory:UpdateItems('accessory') end)
	end
}
for _, v in ipairs({ 'nc_inventory', 'esx_inventoryhud' }) do
	for k, u in pairs(events) do AddEventHandler(GetEventName(v, k), u) end
	for k, u in pairs(netEvents) do RegisterNetEvent(GetEventName(v, k), u) end
end