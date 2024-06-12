-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

---------------------------------------------------
-------------------- Database ---------------------
---------------------------------------------------

Config.DatabaseLoadVehicleData = function(plate)
	return MySQL.prepare.await('SELECT `owner`, JSON_VALUE(`vehicle`, "$.model") AS `model` FROM `owned_vehicles` WHERE `plate` = ?', { plate })
end

Config.DatabaseLoadVehiclesDataAndStorages = function(plates)
	if plates then
		return MySQL.prepare.await('SELECT `o`.`owner`, JSON_VALUE(`o`.`vehicle`, "$.model") AS `model`, `i`.`accounts` AS `inside_accounts`, `i`.`items` AS `inside_items`, `i`.`weapons` AS `inside_weapons`, `t`.`accounts` AS `trunk_accounts`, `t`.`items` AS `trunk_items`, `t`.`weapons` AS `trunk_weapons` FROM `owned_vehicles` AS `o` LEFT JOIN `nc_vehicle_inside_storage` `i` ON `o`.`plate` = `i`.`plate` LEFT JOIN `nc_vehicle_trunk_storage` `t` ON `o`.`plate` = `t`.`plate` WHERE `o`.`plate` = ?', plates)
	else
		return MySQL.query.await('SELECT `o`.`owner`, `o`.`plate`, JSON_VALUE(`o`.`vehicle`, "$.model") AS `model`, `i`.`accounts` AS `inside_accounts`, `i`.`items` AS `inside_items`, `i`.`weapons` AS `inside_weapons`, `t`.`accounts` AS `trunk_accounts`, `t`.`items` AS `trunk_items`, `t`.`weapons` AS `trunk_weapons` FROM `owned_vehicles` AS `o` LEFT JOIN `nc_vehicle_inside_storage` `i` ON `o`.`plate` = `i`.`plate` LEFT JOIN `nc_vehicle_trunk_storage` `t` ON `o`.`plate` = `t`.`plate`')
	end
end

Config.DatabaseLoadAllVehiclePlate = function()
	return MySQL.query.await('SELECT `plate` FROM `owned_vehicles`')
end

Config.DatabaseLoadAllVehicleStorage = function(chamberType)
	return MySQL.query.await('SELECT `plate` FROM `nc_vehicle_' .. chamberType .. '_storage`')
end

Config.DatabaseLoadVehicleStorage = function(chamberType, plate)
	return MySQL.prepare.await('SELECT `accounts`, `items`, `weapons` FROM `nc_vehicle_' .. chamberType .. '_storage` WHERE `plate` = ?', { plate })
end

Config.DatabaseCreateVehicleStorage = function(chamberType, plate)
	return MySQL.prepare.await('INSERT INTO `nc_vehicle_' .. chamberType .. '_storage` SET `plate` = ?', { plate })
end

Config.DatabaseSaveVehicleStorage = function(chamberType, plate, accounts, items, weapons)
	local rowsChanged = MySQL.prepare.await('UPDATE `nc_vehicle_' .. chamberType .. '_storage` SET `accounts` = ?, `items` = ?, `weapons` = ? WHERE `plate` = ?', {
		json.encode(accounts),
		json.encode(items),
		json.encode(weapons),
		plate
	})
	return rowsChanged > 0
end

Config.DatabaseRemoveVehicleStorage = function(chamberType, plate)
	local result = MySQL.prepare.await('DELETE FROM `nc_vehicle_' .. chamberType .. '_storage` WHERE `plate` = ?', { plate })
	return result ~= 0
end

Config.DatabaseRemoveAllVehicleStorage = function(plate)
	local value = { plate }
	return MySQL.transaction.await({
		{ 'DELETE FROM `nc_vehicle_inside_storage` WHERE `plate` = ?', value },
		{ 'DELETE FROM `nc_vehicle_trunk_storage` WHERE `plate` = ?', value }
	})
end