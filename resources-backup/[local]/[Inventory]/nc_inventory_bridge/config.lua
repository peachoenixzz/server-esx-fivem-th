-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config = {}

Config.EventRoute = {
	['getSharedObject'] = 'esx:getSharedObject',			-- Default: 'esx:getSharedObject'
}

Config.Vault = {
	['exports'] = function() return exports['monster_vault']:getMonsterVaultLicense() end,
	['openVaultInventory'] = 'monster_inventoryhud:openVaultInventory',
	['getVaultInventory'] = 'monster_vault:getVaultInventory',
	['putItem'] = 'monster_vault:putItem',
	['getItem'] = 'monster_vault:getItem'
}

Config.ActionFunctions = {
	['trunk'] = {					-- ท้ายรถ (xzero_trunk)
		put = function(data)
			TriggerEvent('xzero_trunk:CL:OnPut', data)
		end,
		take = function(data)
			TriggerEvent('xzero_trunk:CL:OnTake', data)
		end
	},
	['vault'] = {					-- ตู้เซฟ (monster_vault)
		put = function(data)
			if type(data.number) == 'number' and math.floor(data.number) == data.number then
				local count = 0
				if data.item.type == 'item_weapon' then
					count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
				else
					count = (data.number > data.item.count or data.number == 0) and tonumber(data.item.count) or tonumber(data.number)
				end
				TriggerServerEvent(Config.Vault['putItem'], vaultType, data.item.type, data.item.name, count)
				refreshVaultInventory()
			end
		end,
		take = function(data)
			if type(data.number) == 'number' and math.floor(data.number) == data.number then
				local count = (data.number > data.item.count or data.number == 0) and tonumber(data.item.count) or tonumber(data.number)
				TriggerServerEvent(Config.Vault['getItem'], vaultType, data.item.type, data.item.name, count)
				refreshVaultInventory()
			end
		end
	},
}

Config.DoAction = function(action, secondaryName, data)
	if Config.ActionFunctions[secondaryName] and Config.ActionFunctions[secondaryName][action] then
		Config.ActionFunctions[secondaryName][action](data)
	end
end