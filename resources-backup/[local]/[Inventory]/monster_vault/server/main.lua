ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_vault:getItem')
AddEventHandler('esx_vault:getItem', function(--[[owner,--]] job, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(xPlayer.identifier)

	if type == 'item_standard' then

		local sourceItem = xPlayer.getInventoryItem(item)

		if xPlayer.job.name == job then
			TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..job, function(inventory)
				local inventoryItem = inventory.getItem(item)
				if count > 0 and inventoryItem.count >= count then
					if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
						print('notify: player cannot hold')
						TriggerClientEvent("pNotify:SendNotification", source, {type = 'error', text = _U('player_cannot_hold'), length = 5500})
					else
						inventory.removeItem(item, count)
						xPlayer.addInventoryItem(item, count)
						TriggerClientEvent("pNotify:SendNotification", source, {type = 'success', text = _U('have_withdrawn', count, inventoryItem.label), length = 7500})
					
						local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. inventoryItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ออกจากตู้นิรภัย'
						TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'VaultGetItemJob', sendToDiscord, _source, '^2')
					end
				else
					print('not enough in vault')
					TriggerClientEvent("pNotify:SendNotification", source, {type = 'error', text = _U('not_enough_in_vault'), length = 5500})
				end
			end)
		elseif job == 'vault' then
			TriggerEvent('esx_addoninventory:getInventory', 'vault', xPlayerOwner.identifier, function(inventory)
				local inventoryItem = inventory.getItem(item)
	
				
				if count > 0 and inventoryItem.count >= count then
					if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
						TriggerClientEvent('pNotify:client:SendAlert', _source,  {type = 'error', text = _U('player_cannot_hold'), length = 5500})
					else
						inventory.removeItem(item, count)
						xPlayer.addInventoryItem(item, count)
						TriggerClientEvent("pNotify:SendNotification", source, {type = 'success', text = _U('have_withdrawn', count, inventoryItem.label), length = 8500})

						local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. inventoryItem.label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' ออกจากตู้นิรภัย'
						TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'VaultGetItem', sendToDiscord, _source, '^2')
					end
				else
					TriggerClientEvent("pNotify:SendNotification", source, {type = 'error', text = _U('not_enough_in_vault'), length = 5500})
				end
			end)
		else
			print('notify: not permission for this job')
		end

	elseif type == 'item_account' then
		if xPlayer.job.name == job then
			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..job..'_'..item, function(account)
				local policeAccountMoney = account.money

				if policeAccountMoney >= count then
					account.removeMoney(count)
					xPlayer.addAccountMoney(item, count)

					local sendToDiscord = '' .. xPlayer.name .. ' นำ Derty Money จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ออกจากตู้นิรภัย'
					TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'VaultGetMoneyJob', sendToDiscord, _source, '^3')
				else
					TriggerClientEvent("pNotify:SendNotification", source, {type = 'error', text = _U('amount_invalid'), length = 5500})
				end
			end)
		elseif job == 'vault' then
			TriggerEvent('esx_addonaccount:getAccount', 'vault_' .. item, xPlayerOwner.identifier, function(account)
				local roomAccountMoney = account.money
	
				if roomAccountMoney >= count then
					account.removeMoney(count)
					xPlayer.addAccountMoney(item, count)

					local sendToDiscord = '' .. xPlayer.name .. ' นำ Derty Money จำนวน $' .. ESX.Math.GroupDigits(count) .. ' ออกจากตู้นิรภัย'
					TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'VaultGetMoney', sendToDiscord, _source, '^3')
				else
					TriggerClientEvent("pNotify:SendNotification", source, {type = 'error', text = _U('amount_invalid'), length = 5500})
				end
			end)
		else
			TriggerClientEvent("pNotify:SendNotification", source, {type = 'error', text = "You not have permission", length = 5500})
		end
	elseif type == 'item_weapon' then
		if xPlayer.job.name == job then
			TriggerEvent('esx_datastore:getSharedDataStore', 'society_'..job, function(store)
				local storeWeapons = store.get('weapons') or {}
				local weaponName   = nil
				local ammo         = nil
	
				for i=1, #storeWeapons, 1 do
					if storeWeapons[i].name == item then
						weaponName = storeWeapons[i].name
						ammo       = storeWeapons[i].ammo
	
						table.remove(storeWeapons, i)
						break
					end
				end
	
				store.set('weapons', storeWeapons)
				xPlayer.addWeapon(weaponName, ammo)

				if ammo ~= nil and ammo > 0 then
					local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetWeaponLabel(weaponName) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(ammo) .. ' ออกจากตู้นิรภัย'
					TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'VaultGetWeaponJob', sendToDiscord, _source, '^1')
				else
					local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetWeaponLabel(weaponName) .. ' ออกจากตู้นิรภัย'
					TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'VaultGetWeaponJob', sendToDiscord, _source, '^1')
				end
			end)
		elseif job == 'vault' then
			TriggerEvent('esx_datastore:getDataStore', 'vault', xPlayerOwner.identifier, function(store)
				local storeWeapons = store.get('weapons') or {}
				local weaponName   = nil
				local ammo         = nil
	
				for i=1, #storeWeapons, 1 do
					if storeWeapons[i].name == item then
						weaponName = storeWeapons[i].name
						ammo       = storeWeapons[i].ammo
	
						table.remove(storeWeapons, i)
						break
					end
				end
	
				store.set('weapons', storeWeapons)
				xPlayer.addWeapon(weaponName, ammo)

				if ammo ~= nil and ammo > 0 then
					local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetWeaponLabel(weaponName) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(ammo) .. ' ออกจากตู้นิรภัย'
					TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'VaultGetWeapon', sendToDiscord, _source, '^1')
				else
					local sendToDiscord = '' .. xPlayer.name .. ' นำ ' .. ESX.GetWeaponLabel(weaponName) .. ' ออกจากตู้นิรภัย'
					TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'VaultGetWeapon', sendToDiscord, _source, '^1')
				end
			end)
		else
			TriggerClientEvent("pNotify:SendNotification", source, {type = 'error', text = 'You not have permission', length = 5500})
		end
	end

end)

RegisterServerEvent('esx_vault:putItem')
AddEventHandler('esx_vault:putItem', function(--[[owner,--]] job, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(xPlayer.identifier)

	if type == 'item_standard' then

		local playerItemCount = xPlayer.getInventoryItem(item).count

		if playerItemCount >= count and count > 0 then
			if xPlayer.job.name == job then
				TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..job, function(inventory)
					xPlayer.removeInventoryItem(item, count)
					inventory.addItem(item, count)
					TriggerClientEvent("pNotify:SendNotification", source, {type = 'success', text = _U('have_deposited', count, inventory.getItem(item).label), length = 7500})
				
					local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. inventory.getItem(item).label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
					TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'VaultPutItemJob', sendToDiscord, _source, '^2')
				end)
				-- print("esx_vault:putItem")
			elseif job == 'vault' then
				TriggerEvent('esx_addoninventory:getInventory', 'vault', xPlayerOwner.identifier, function(inventory)
					xPlayer.removeInventoryItem(item, count)
					inventory.addItem(item, count)
					TriggerClientEvent("pNotify:SendNotification", source, {type = 'success', text = _U('have_deposited', count, inventory.getItem(item).label), length = 7500})

					local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. inventory.getItem(item).label .. ' จำนวน ' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
					TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'VaultPutItem', sendToDiscord, _source, '^2')
				end)
			else
				TriggerClientEvent("pNotify:SendNotification", source, {type = "error", text = 'You not have permission for this job!', length = 5500})
			end
		else
			TriggerClientEvent("pNotify:SendNotification", source, {type = "error", text = _U('invalid_quantity'), length = 5500})
		end

	elseif type == 'item_account' then

		local playerAccountMoney = xPlayer.getAccount(item).money

		if playerAccountMoney >= count and count > 0 then
			xPlayer.removeAccountMoney(item, count)
			if xPlayer.job.name == job and job == 'police' then
				TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..job..'_'..item, function(account)
					account.addMoney(count)
				end)

				local sendToDiscord = '' .. xPlayer.name .. ' ฝาก Derty Money จำนวน $' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
				TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'VaultPutMoneyJob', sendToDiscord, _source, '^3')
			elseif job == 'vault' then
				TriggerEvent('esx_addonaccount:getAccount', 'vault_' .. item, xPlayerOwner.identifier, function(account)
					account.addMoney(count)
				end)

				local sendToDiscord = '' .. xPlayer.name .. ' ฝาก Derty Money จำนวน $' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
				TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'VaultPutMoney', sendToDiscord, _source, '^3')
			else
				xPlayer.addAccountMoney(item, count)
				TriggerClientEvent("pNotify:SendNotification", source, {type = 'error', text = 'This job not allow for black money', length = 5500})
			end
			
		else
			TriggerClientEvent("pNotify:SendNotification", source, {type = 'error', text = _U('amount_invalid'), length = 5500})
		end

	elseif type == 'item_weapon' then
		if xPlayer.job.name == job then
			TriggerEvent('esx_datastore:getSharedDataStore', 'society_'..job, function(store)
				local storeWeapons = store.get('weapons') or {}
	
				table.insert(storeWeapons, {
					name = item,
					count = count
				})
	
				xPlayer.removeWeapon(item)
				store.set('weapons', storeWeapons)
				
				if count ~= nil and count > 0 then
					local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. ESX.GetWeaponLabel(item) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
					TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'VaultPutWeaponJob', sendToDiscord, _source, '^1')
				else
					local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. ESX.GetWeaponLabel(item) .. ' เข้าตู้นิรภัย'
					TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'VaultPutWeaponJob', sendToDiscord, _source, '^1')
				end
			end)
		elseif job == 'vault' then
			TriggerEvent('esx_datastore:getDataStore', 'vault', xPlayerOwner.identifier, function(store)
				local storeWeapons = store.get('weapons') or {}
	
				table.insert(storeWeapons, {
					name = item,
					ammo = count
				})
	
				xPlayer.removeWeapon(item)
				store.set('weapons', storeWeapons)
				
				if count ~= nil and count > 0 then
					local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. ESX.GetWeaponLabel(item) .. ' และ กระสุน จำนวน ' .. ESX.Math.GroupDigits(count) .. ' เข้าตู้นิรภัย'
					TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'VaultPutWeapon', sendToDiscord, _source, '^1')
				else
					local sendToDiscord = '' .. xPlayer.name .. ' ฝาก ' .. ESX.GetWeaponLabel(item) .. ' เข้าตู้นิรภัย'
					TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'VaultPutWeapon', sendToDiscord, _source, '^1')
				end				
			end)
		else
			TriggerClientEvent("pNotify:SendNotification", source, {type = 'error', text = 'You not have permission', length = 5500})
		end
	end

end)

ESX.RegisterServerCallback('esx_vault:checkcard', function(source, cb, items)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(items)

	if xItem.count >= 1 then
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_vault:getVaultInventory', function(source, cb, item, refresh)
	-- local xPlayer    = ESX.GetPlayerFromIdentifier(owner)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem
	if item.needItemLicense ~= '' or item.needItemLicense ~= nil then
		xItem = xPlayer.getInventoryItem(item.needItemLicense)
	else
		xItem = nil
	end
	local refresh = refresh or false

	local blackMoney = 0
	local items      = {}
	local weapons    = {}

	if not refresh and (item.needItemLicense ~= '' or item.needItemLicense ~= nil) and xItem ~= nil then
		if xItem.count < 1 then
			cb(false)
		end
		-- return
	elseif item.InfiniteLicense ~= nil and not refresh and (item.needItemLicense ~= '' or item.needItemLicense ~= nil)  then
		if not item.InfiniteLicense then
			xPlayer.removeInventoryItem(item.needItemLicense, 1)
		end
	end

	if item.job == xPlayer.job.name then
		print('u job: '..xPlayer.job.name)
	end

	local typeVault = ''
	local society = false
	if string.find(item.job, "vault") then
		typeVault = item.job
	else
		typeVault = "society_"..item.job
		society = true
	end
	--print("^2[esx_vault]: ^9ID "..typeVault)
	if society then
	
	
		if item.job == 'police' then
			TriggerEvent('esx_addonaccount:getSharedAccount', typeVault..'_black_money', function(account)
				blackMoney = account.money
			end)
		else
			blackMoney = 0
		end
		
		
		TriggerEvent('esx_addoninventory:getSharedInventory', typeVault, function(inventory)
			items = inventory.items
		end)
		TriggerEvent('esx_datastore:getSharedDataStore', typeVault, function(store)
			weapons = store.get('weapons') or {}
		end)
		cb({
			blackMoney = blackMoney,
			items      = items,
			weapons    = weapons,
			job = item.job
		})
	else
		TriggerEvent('esx_addonaccount:getAccount', typeVault..'_black_money', xPlayer.identifier, function(account)
			blackMoney = account.money
		end)

		TriggerEvent('esx_addoninventory:getInventory', typeVault, xPlayer.identifier, function(inventory)
			items = inventory.items
		end)

		TriggerEvent('esx_datastore:getDataStore', typeVault, xPlayer.identifier, function(store)
			weapons = store.get('weapons') or {}
		end)

		cb({
			blackMoney = blackMoney,
			items      = items,
			weapons    = weapons,
			job = item.job
		})		
	end
end)
