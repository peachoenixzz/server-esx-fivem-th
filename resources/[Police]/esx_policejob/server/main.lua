local isHandcuffed = {}

if Config.EnableESXService then
	if Config.MaxInService ~= -1 then
		TriggerEvent('esx_service:activateService', 'police', Config.MaxInService)
	end
end

TriggerEvent('esx_phone:registerNumber', 'police', TranslateCap('alert_police'), true, true)
TriggerEvent('esx_society:registerSociety', 'police', 'Police', 'society_police', 'society_police', 'society_police', {type = 'public'})

RegisterNetEvent('esx_policejob:confiscatePlayerItem')
AddEventHandler('esx_policejob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local source = source
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	if sourceXPlayer.job.name ~= 'police' then
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Exploit The Confuscation System!'):format(sourceXPlayer.source))
		return
	end

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then

			-- can the player carry the said amount of x item?
			if sourceXPlayer.canCarryItem(itemName, sourceItem.count) then
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem   (itemName, amount)

				--sourceXPlayer.showNotification(TranslateCap('you_confiscated', amount, sourceItem.label, targetXPlayer.name))
				--targetXPlayer.showNotification(TranslateCap('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))
			else
				--sourceXPlayer.showNotification(TranslateCap('quantity_invalid'))
			end
		else
			--sourceXPlayer.showNotification(TranslateCap('quantity_invalid'))
		end

	elseif itemType == 'item_account' then
		local targetAccount = targetXPlayer.getAccount(itemName)

		-- does the target player have enough money?
		if targetAccount.money >= amount then
			targetXPlayer.removeAccountMoney(itemName, amount, "Confiscated")
			sourceXPlayer.addAccountMoney   (itemName, amount, "Confiscated")


			--sourceXPlayer.showNotification(TranslateCap('you_confiscated_account', amount, itemName, targetXPlayer.name))
			--targetXPlayer.showNotification(TranslateCap('got_confiscated_account', amount, itemName, sourceXPlayer.name))
		else
			--sourceXPlayer.showNotification(TranslateCap('quantity_invalid'))
		end

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end

		-- does the target player have weapon?
		if targetXPlayer.hasWeapon(itemName) then
			targetXPlayer.removeWeapon(itemName)
			sourceXPlayer.addWeapon   (itemName, amount)

			--sourceXPlayer.showNotification(TranslateCap('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
			--targetXPlayer.showNotification(TranslateCap('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
		else
			--sourceXPlayer.showNotification(TranslateCap('quantity_invalid'))
		end
	end
end)

RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'circle' then
		TriggerClientEvent('esx_policejob:handcuff', target)
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				 event = 'PoliceHandcuff',
				 content = ('%s อาชีพ %s ยศ %s ได้ทำการใช้กุญแจมือกับ %s'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, xTarget.name),
				 source = xPlayer.source,
			 })
		 end) -- End log
	else
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Exploit Handcuffs!'):format(xPlayer.source))
	end
end)

ESX.RegisterServerCallback('esx_policejob:activateHandCuff', function(source, cb , target)
	if type(isHandcuffed[target]) == "nil" then
		isHandcuffed[target] = false
	end
	cb()
end)


RegisterNetEvent('esx_policejob:handcuffByKey')
AddEventHandler('esx_policejob:handcuffByKey', function(target,playerheading, playerCoords, playerlocation)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerped = GetPlayerPed(source)
	local playerCoordsSv = GetEntityCoords(playerped)
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'circle'  then
		if not isHandcuffed[target] then
			isHandcuffed[target] = true
		else
			isHandcuffed[target] = false
		end
		TriggerClientEvent('esx_policejob:getarrested', target, playerheading, playerCoordsSv, playerlocation,isHandcuffed[target])
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'PoliceGetArrest',
				content = ('%s อาชีพ %s ได้ถูก %s อาชีพ %s ยศ %s ทำการจับกุม'):format(xTarget.name, xTarget.job.name, xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name),
				source = xTarget.source,
			})
		end) -- End log
		TriggerClientEvent('esx_policejob:doarrested', source,isHandcuffed[target])
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'PoliceDoArrest',
				content = ('%s อาชีพ %s ยศ %s ได้ทำการจับกุม %s อาชีพ %s'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, xTarget.name, xTarget.job.name),
				source = xPlayer.source,
			})
		end) -- End log
	else
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Exploit Handcuffs!'):format(xPlayer.source))
	end
end)

RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'circle'  then
		TriggerClientEvent('esx_policejob:drag', target, source)
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				 event = 'PoliceDrag',
				 content = ('%s อาชีพ %s ยศ %s ได้ทำการลาก %s อาชีพ %s '):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, xTarget.name, xTarget.job.name),
				 source = xPlayer.source,
			 })
		 end) -- End log
	else
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Exploit Dragging!'):format(xPlayer.source))
	end
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:putInVehicle', target)
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				 event = 'PolicePutInVehicle',
				 content = ('%s อาชีพ %s ยศ %s ได้ทำการจับ %s อาชีพ %s ขึ้นรถ'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, xTarget.name, xTarget.job.name),
				 source = xPlayer.source,
			 })
		 end) -- End log
	else
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Exploit Garage!'):format(xPlayer.source))
	end
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_policejob:OutVehicle', target)
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				 event = 'PoliceOutVehicle',
				 content = ('%s อาชีพ %s ยศ %s ได้นำตัว %s อาชีพ %s ลงจากรถ'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, xTarget.name, xTarget.job.name),
				 source = xPlayer.source,
			 })
		 end) -- End log
	else
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Exploit Dragging Out Of Vehicle!'):format(xPlayer.source))
	end
end)

RegisterNetEvent('esx_policejob:getStockItem')
AddEventHandler('esx_policejob:getStockItem', function(itemName, count)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if xPlayer.canCarryItem(itemName, count) then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				--xPlayer.showNotification(TranslateCap('have_withdrawn', count, inventoryItem.name))
			else
				--xPlayer.showNotification(TranslateCap('quantity_invalid'))
			end
		else
			--xPlayer.showNotification(TranslateCap('quantity_invalid'))
		end
	end)
end)

RegisterNetEvent('esx_policejob:putStockItems')
AddEventHandler('esx_policejob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			--xPlayer.showNotification(TranslateCap('have_deposited', count, inventoryItem.name))
		else
			--xPlayer.showNotification(TranslateCap('quantity_invalid'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getOtherPlayerData', function(source, cb, target, notify)
	local xPlayer = ESX.GetPlayerFromId(target)

	if notify then
		--xPlayer.showNotification(TranslateCap('being_searched'))
	end

	if xPlayer then
		local data = {
			name = xPlayer.getName(),
			job = xPlayer.job.label,
			grade = xPlayer.job.grade_label,
			inventory = xPlayer.getInventory(),
			accounts = xPlayer.getAccounts(),
			weapons = xPlayer.getLoadout()
		}
		if Config.EnableESXIdentity then
			data.dob = xPlayer.get('dateofbirth')
			data.height = xPlayer.get('height')

			if xPlayer.get('sex') == 'm' then data.sex = 'male' else data.sex = 'female' end
			pcall(function() -- Start log
				exports['azael_dc-serverlogs']:insertData({
					 event = 'PoliceCheckPlayerData',
					 content = ('%s อาชีพ %s ยศ %s ได้ทำการเช็คข้อมูลของ %s'):format(xTarget.name, xTarget.job.name, xTarget.job.grade_name, xPlayer.name),
					 source = xTarget.source,
				 })
			 end) -- End log
		end

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status then
				data.drunk = ESX.Math.Round(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end
	end
end)

ESX.RegisterServerCallback('esx_policejob:getFineList', function(source, cb, category)
	MySQL.query('SELECT * FROM fine_types WHERE category = ?', {category},
	function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleInfos', function(source, cb, plate)
	local retrivedInfo = {
		plate = plate
	}
	if Config.EnableESXIdentity then
		MySQL.single('SELECT u.firstname, u.lastname FROM owned_vehicles INNER JOIN users u ON owned_vehicles.owner = u.identifier WHERE plate = ?', {plate},
		function(result)
			if result then
				retrivedInfo.owner = ('%s %s'):format(result.firstname, result.lastname)
			end
			cb(retrivedInfo)
		end)
	else
		MySQL.scalar('SELECT owner FROM owned_vehicles WHERE plate = ?', {plate},
		function(owner)
			if owner then
				local xPlayer = ESX.GetPlayerFromIdentifier(owner)
				if xPlayer then
					retrivedInfo.owner = xPlayer.getName()
				end
			end
			cb(retrivedInfo)
		end)
	end
end)

ESX.RegisterServerCallback('esx_policejob:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end
		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
		local weapons = store.get('weapons') or {}
		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
		end)
end)

ESX.RegisterServerCallback('esx_policejob:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
		local weapons = store.get('weapons') or {}

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('esx_policejob:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.AuthorizedWeapons[xPlayer.job.grade_name]

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Buy Invalid Weapon - ^5%s^7!'):format(source, weaponName))
		cb(false)
	else
		-- Weapon
		if type == 1 then
			if xPlayer.getMoney() >= selectedWeapon.price then
				xPlayer.removeMoney(selectedWeapon.price, "Weapon Bought")
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						 event = 'PoliceBuyWeaponRemoveMoney',
						 content = ('%s อาชีพ %s ยศ %s ได้ทำการซื้อ %s สูญเสียเงินจำนวน $%s เหลือเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, weaponName, selectedWeapon.price, ESX.Math.GroupDigits(xPlayer.getMoney())),
						 source = xPlayer.source,
					 })
				 end) -- End log
				xPlayer.addWeapon(weaponName, 100)
				pcall(function() -- Start log
					exports['azael_dc-serverlogs']:insertData({
						 event = 'PoliceBuyWeapon',
						 content = ('%s อาชีพ %s ยศ %s ได้รับ %s จากการซื้อ'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, weaponName),
						 source = xPlayer.source,
					 })
				 end) -- End log

				cb(true)
			else
				cb(false)
			end

		-- Weapon Component
		elseif type == 2 then
			local price = selectedWeapon.components[componentNum]
			local weaponNum, weapon = ESX.GetWeapon(weaponName)
			local component = weapon.components[componentNum]

			if component then
				if xPlayer.getMoney() >= price then
					xPlayer.removeMoney(price, "Weapon Component Bought")
					pcall(function() -- Start log
						exports['azael_dc-serverlogs']:insertData({
							 event = 'PoliceBuyComponentRemoveMoney',
							 content = ('%s อาชีพ %s ยศ %s ได้ทำการซื้อ %s สำหรับ %s สูญเสียเงินจำนวน $%s เหลือเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, component.name, weaponName, price, ESX.Math.GroupDigits(xPlayer.getMoney())),
							 source = xPlayer.source,
						 })
					 end) -- End log
					xPlayer.addWeaponComponent(weaponName, component.name)
					pcall(function() -- Start log
						exports['azael_dc-serverlogs']:insertData({
							 event = 'PoliceBuyWeaponComponent',
							 content = ('%s อาชีพ %s ยศ %s ได้รับ %s สำหรับ %s จากการซื้อ'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, component.name, weaponName),
							 source = xPlayer.source,
						 })
					 end) -- End log

					cb(true)
				else
					cb(false)
				end
			else
				print(('[^3WARNING^7] Player ^5%s^7 Attempted To Buy Invalid Weapon Component - ^5%s^7!'):format(source, componentNum))
				cb(false)
			end
		end
	end
end)

ESX.RegisterServerCallback('esx_policejob:buyTool', function(source, cb,name)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(name)
	if xItem.count > 0 then cb(false) return end
	xPlayer.addInventoryItem(name, 1)
	pcall(function() -- Start Log ยังไม่เสร็จ
		exports['azael_dc-serverlogs']:insertData({
			event = 'PoliceBuyTool',
			content = ('%s อาชีพ %s ยศ %s ได้ทำการเบิก %s จำนวน 1 ชิ้น'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, xItem.name),
			source = xPlayer.source,
		})
	end) -- End Log
	cb(true)
end)

ESX.RegisterServerCallback('esx_policejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('[^3WARNING^7] Player ^5%s^7 Attempted To Buy Invalid Vehicle - ^5%s^7!'):format(source, vehicleProps.model))
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price, "Job Vehicle Bought")
			pcall(function() -- Start Log ยังไม่เสร็จ
				exports['azael_dc-serverlogs']:insertData({
					event = 'PoliceBuyVehicle',
					content = ('%s อาชีพ %s ยศ %s ได้ทำการซื้อรถของหน่วยงาน %s ทะเบียน %s สูญเสียเงินจำนวน $%s เหลือเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, vehicleProps.model, vehicleProps.plate, price, ESX.Math.GroupDigits(xPlayer.getMoney())),
					source = xPlayer.source,
				})
			end) -- End Log

			MySQL.insert('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (?, ?, ?, ?, ?, ?)', { xPlayer.identifier, json.encode(vehicleProps), vehicleProps.plate, type, "sos", true},
			function (rowsChanged)
				exports.nc_vehiclekey:ReloadVehicleKey(vehicleProps.plate)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_policejob:storeNearbyVehicle', function(source, cb, plates,vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)

	local plate = MySQL.scalar.await('SELECT plate FROM owned_vehicles WHERE owner = ? AND plate IN (?) AND job = ?', {xPlayer.identifier, plates, xPlayer.job.name})

	if plate and vehicleProps ~= nil then
		MySQL.update('UPDATE owned_vehicles SET `stored` = true , vehicle = ?  WHERE owner = ? AND plate = ? AND job = ?', {json.encode(vehicleProps),xPlayer.identifier, plate, xPlayer.job.name},
		function(rowsChanged)
			if rowsChanged == 0 then
				cb(false)
			else
				cb(plate)
			end
		end)
	else
		cb(false)
	end
end)

function getPriceFromHash(vehicleHash, jobGrade, type)
	local vehicles = Config.AuthorizedVehicles[type][jobGrade]

	for i = 1, #vehicles do
		local vehicle = vehicles[i]
		if GetHashKey(vehicle.model) == vehicleHash then
			return vehicle.price
		end
	end

	return 0
end

ESX.RegisterServerCallback('esx_policejob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('esx_policejob:lockpick', function(source, cb,target)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem('lockpick')
	if item.count == 0 then

		return
	end
	TriggerClientEvent('esx_policejob:unHandcuff', target,source)
	pcall(function() -- Start Log
		exports['azael_dc-serverlogs']:insertData({
			event = 'PoliceUseLockpick',
			content = ('%s อาชีพ %s ยศ %s ได้ทำการใช้ %s กับ %s อาชีพ %s มี %s ในกระเป๋าจำนวน %s ชิ้น'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, item.name, xTarget.name, xTarget.job.name, item.name, xPlayer.getInventoryItem('lockpick').count),
			source = xPlayer.source,
		})
	end) -- End Log
	cb(true)
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleFromPlate', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then

			MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					cb(result2[1].firstname .. ' ' .. result2[1].lastname, true)
				else
					cb(result2[1].name, true)
				end

			end)
		else
			cb(_U('unknown'), false)
		end
	end)
end)



ESX.RegisterUsableItem('lockpick', function(source)
	local source = source
	TriggerClientEvent('esx_policejob:checkPlayerState', source)
	--TriggerClientEvent('esx_policejob:unrestrain', source)
	--TriggerClientEvent('esx:showNotification', source, TranslateCap('you_used_body_kit'))
end)

ESX.RegisterUsableItem('gov_help', function(source)
	local source = source
	TriggerClientEvent('esx_policejob:pingByItem', source)
	--TriggerClientEvent('esx_policejob:unrestrain', source)
	--TriggerClientEvent('esx:showNotification', source, TranslateCap('you_used_body_kit'))
end)


RegisterNetEvent('esx_policejob:removeLockpick')
AddEventHandler('esx_policejob:removeLockpick', function(playerUseLockpick)
	local xPlayer = ESX.GetPlayerFromId(playerUseLockpick)
	local item = xPlayer.getInventoryItem('lockpick')
	if item.count == 0 then
		return
	end
	xPlayer.removeInventoryItem('lockpick', 1)
	pcall(function() -- Start Log
		exports['azael_dc-serverlogs']:insertData({
			event = 'PoliceRemoveLockpick',
			content = ('%s อาชีพ %s ยศ %s ได้สูญเสีย %s จำนวน 1 ชิ้น เหลือ %s ในกระเป๋าจำนวน %s ชิ้น'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, item.name, item.name, xPlayer.getInventoryItem('lockpick').count),
			source = xPlayer.source,
		})
	end) -- End Log
end)


AddEventHandler('playerDropped', function()
	local playerId = source
	if playerId then
		local xPlayer = ESX.GetPlayerFromId(playerId)

		if xPlayer and xPlayer.job.name == 'police' then
			Wait(5000)
			TriggerClientEvent('esx_policejob:updateBlip', -1)
		end
	end
end)



--function updateBlip()
--	Wait(5000)
--	TriggerClientEvent('esx_policejob:updateBlip', -1)
--	return updateBlip()
--end
--
--Citizen.CreateThread(function()
--	Citizen.Wait(30000)
--	updateBlip()
--end)
--
--RegisterNetEvent('esx_policejob:spawned')
--AddEventHandler('esx_policejob:spawned', function()
--	local playerId = source
--	local xPlayer = ESX.GetPlayerFromId(playerId)
--	if xPlayer and xPlayer.job.name == 'police' then
--		Wait(5000)
--		TriggerClientEvent('esx_policejob:updateBlip', -1)
--	end
--end)


--RegisterNetEvent('esx_policejob:forceBlip')
--AddEventHandler('esx_policejob:forceBlip', function()
--	for _, xPlayer in pairs(ESX.GetExtendedPlayers('job', 'police')) do
--		TriggerClientEvent('esx_policejob:updateBlip', xPlayer.source)
--	end
--end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Wait(5000)
		for _, xPlayer in pairs(ESX.GetExtendedPlayers('job', 'police')) do
			TriggerClientEvent('esx_policejob:updateBlip', xPlayer.source)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'police')
	end
end)