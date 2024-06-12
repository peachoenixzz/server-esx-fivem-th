-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config.FrameworkGetPlayerFromId = function(playerId)
	return ESX.GetPlayerFromId(playerId)
end

Config.FrameworkGetPlayerId = function(xPlayer)
	return xPlayer.source
end

Config.FrameworkGetIdentifier = function(xPlayer)
	return xPlayer.identifier
end

Config.FrameworkGetName = function(xPlayer)
	return xPlayer.name
end

Config.FrameworkGetGroup = function(xPlayer)
	return xPlayer.group
end

Config.FrameworkGetJob = function(xPlayer)
	return xPlayer.job
end


-- ACCOUNTS
Config.FrameworkGetMoney = function(xPlayer)
	return xPlayer.getMoney()
end

Config.FrameworkAddMoney = function(xPlayer, amount, reason)
	return xPlayer.addMoney(amount, reason)
end

Config.FrameworkRemoveMoney = function(xPlayer, amount, reason)
	return xPlayer.removeMoney(amount, reason)
end

Config.FrameworkGetBank = function(xPlayer)
	return xPlayer.getBank()
end

Config.FrameworkAddBank = function(xPlayer, amount, reason)
	return xPlayer.addBank(amount, reason)
end

Config.FrameworkRemoveBank = function(xPlayer, amount, reason)
	return xPlayer.removeBank(amount, reason)
end

Config.FrameworkGetAccounts = function(xPlayer)
	return xPlayer.getAccounts()
end

Config.FrameworkGetAccount = function(xPlayer, name)
	return xPlayer.getAccount(name)
end

Config.FrameworkAddAccountMoney = function(xPlayer, name, amount, reason)
	return xPlayer.addAccountMoney(name, amount, reason)
end

Config.FrameworkRemoveAccountMoney = function(xPlayer, name, amount, reason)
	return xPlayer.removeAccountMoney(name, amount, reason)
end


-- ITEMS
Config.FrameworkGetInventory = function(xPlayer)
	return xPlayer.getInventory()
end

Config.FrameworkGetInventoryItem = function(xPlayer, name)
	return xPlayer.getInventoryItem(name)
end

Config.FrameworkAddInventoryItem = function(xPlayer, name, count, reason)
	return xPlayer.addInventoryItem(name, count, reason)
end

Config.FrameworkRemoveInventoryItem = function(xPlayer, name, count, reason)
	return xPlayer.removeInventoryItem(name, count, reason)
end

Config.FrameworkGetMaxWeight = function(xPlayer)
	return xPlayer.getMaxWeight()
end


-- WEAPONS
Config.FrameworkGetLoadout = function(xPlayer)
	return xPlayer.getLoadout()
end

Config.FrameworkHasWeapon = function(xPlayer, name)
	return xPlayer.hasWeapon(name)
end

Config.FrameworkGetWeapon = function(xPlayer, name)
	return xPlayer.getWeapon(name)
end

Config.FrameworkAddWeapon = function(xPlayer, name, ammo, reason)
	return xPlayer.addWeapon(name, ammo, reason)
end

Config.FrameworkRemoveWeapon = function(xPlayer, name)
	return xPlayer.removeWeapon(name)
end

Config.FrameworkAddWeaponComponent = function(xPlayer, name, component)
	return xPlayer.addWeaponComponent(name, component)
end

Config.FrameworkSetWeaponTint = function(xPlayer, name, index)
	return xPlayer.setWeaponTint(name, index)
end

Config.FrameworkUpdateWeaponAmmo = function(xPlayer, name, ammo)
	return xPlayer.updateWeaponAmmo(name, ammo)
end