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
	local result = MongoDB.Sync.find({ collection = 'nc_vault' })
	return result																																			-- return ข้อมูลตู้เซฟ
end

Config.DatabaseLoadVaultStorageByVaultId = function(id)
	local result = MongoDB.Sync.findOne({ collection = 'nc_vault_storage', query = { vault_id = id } })
	return result and result[1]																																-- return ข้อมูลสิ่งของตู้เซฟ
end

Config.DatabaseCreateVault = function(owner, group, name_tag)
	local result, id = MongoDB.Sync.insertOne({
		collection = 'nc_vault',
		document = {
			owner = owner,
			group = group,
			name_tag = name_tag
		}
	})
	if result == 1 then
		return id[1]																																		-- return หมายเลขตู้เซฟ
	end
end

Config.DatabaseCreateVaultStorage = function(id)
	local result, id = MongoDB.Sync.insertOne({ collection = 'nc_vault_storage', document = { vault_id = id } })
	return result == 1																																		-- return true 	เมื่อ Database มีการเปลี่ยนแปลง																															
end

Config.DatabaseGetPlayerNameByIdentifier = function(identifier)
	return MySQL.prepare.await('SELECT CONCAT(`firstname`, " ", `lastname`) FROM `users` WHERE `identifier` = ?', { identifier }) or 'UNKNOWN'				-- return ชื่อผู้เล่น
end

Config.DatabaseSaveVaultDataByVaultId = function(id, owner, name, name_tag, exp, shared)
	MongoDB.Async.updateOne({
		collection = 'nc_vault',
		query = { _id = id },
		update = {
			['$set'] = {
				owner = owner,
				name = name,
				name_tag = name_tag,
				exp = exp,
				shared = shared
			}
		}
	})
end

Config.DatabaseSaveVaultStorageByVaultId = function(id, accounts, items, weapons)
	local rowsChanged = MongoDB.Sync.updateOne({
		collection = 'nc_vault_storage',
		query = { vault_id = id },
		update = {
			['$set'] = {
				accounts = accounts,
				items = items,
				weapons = weapons
			}
		}
	})
	return rowsChanged > 0																																	-- return true 	เมื่อ Database มีการเปลี่ยนแปลง
end

Config.DatabaseRemoveVaultByVaultId = function(id)
	local deletedVaultData = MongoDB.Sync.deleteOne({ collection = 'nc_vault', query = { _id = id } })
	local deletedVaultStorage = MongoDB.Sync.deleteOne({ collection = 'nc_vault_storage', query = { vault_id = id } })
	return (deletedVaultData == 1) or (deletedVaultStorage == 1)																							-- return true 	เมื่อ Database มีการเปลี่ยนแปลง
end
