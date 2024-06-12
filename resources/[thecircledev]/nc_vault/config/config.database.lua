-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

---------------------------------------------------
-------------------- Database ---------------------
---------------------------------------------------

Config.DatabaseLoadAllVaultData = function()
	return MySQL.query.await('SELECT * FROM `nc_vault`')																									-- return ข้อมูลตู้เซฟ
end

Config.DatabaseLoadVaultStorageByVaultId = function(id)
	return MySQL.prepare.await('SELECT * FROM `nc_vault_storage` WHERE `vault_id` = ?', { id })																-- return ข้อมูลสิ่งของตู้เซฟ
end

Config.DatabaseCreateVault = function(owner, group, name_tag)
	return MySQL.prepare.await('INSERT INTO `nc_vault` SET `owner` = ?, `group` = ?, `name_tag` = ?', { owner, group, name_tag })							-- return หมายเลขตู้เซฟ
end

Config.DatabaseCreateVaultStorage = function(id)
	return MySQL.prepare.await('INSERT INTO `nc_vault_storage` SET `vault_id` = ?', { id }) and true or false												-- return true 	เมื่อ Database มีการเปลี่ยนแปลง
end

Config.DatabaseGetPlayerNameByIdentifier = function(identifier)
	return MySQL.prepare.await('SELECT CONCAT(`firstname`, " ", `lastname`) FROM `users` WHERE `identifier` = ?', { identifier }) or 'UNKNOWN'				-- return ชื่อผู้เล่น
end

Config.DatabaseSaveVaultDataByVaultId = function(id, owner, name, name_tag, exp, shared)
	MySQL.prepare('UPDATE `nc_vault` SET `owner` = ?, `name` = ?, `name_tag` = ?, `exp` = ?, `shared` = ? WHERE `_id` = ?', { owner, name, name_tag, exp, json.encode(shared), id })
end

Config.DatabaseSaveVaultStorageByVaultId = function(id, accounts, items, weapons)
	local rowsChanged = MySQL.prepare.await('UPDATE `nc_vault_storage` SET `accounts` = ?, `items` = ?, `weapons` = ? WHERE `vault_id` = ?', { json.encode(accounts), json.encode(items), json.encode(weapons), id })
	return rowsChanged > 0																																	-- return true 	เมื่อ Database มีการเปลี่ยนแปลง
end

Config.DatabaseRemoveVaultByVaultId = function(id)
	return MySQL.transaction.await({ 'DELETE FROM `nc_vault` WHERE `_id` = ?', 'DELETE FROM `nc_vault_storage` WHERE `vault_id` = ?' }, { id })				-- return true 	เมื่อ Database มีการเปลี่ยนแปลง
end
