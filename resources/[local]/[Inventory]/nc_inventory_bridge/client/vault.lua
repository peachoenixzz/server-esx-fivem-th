RegisterNetEvent(Config.Vault['openVaultInventory'], function(data)
	setVaultInventoryData(data)
	openVaultInventory()
end)

function refreshVaultInventory()
	data = Config.Vault.exports()
	ESX.TriggerServerCallback(Config.Vault['getVaultInventory'], function(inventory)
		setVaultInventoryData(inventory)
	end, data, true)
end

function setVaultInventoryData(inventory)
	items = {}

	SendNUIMessage({
		action = 'setInfoText',
		text = inventory.job
	})

	local blackMoney = inventory.blackMoney
	local vaultItems = inventory.items
	local vaultWeapons = inventory.weapons
	vaultType = inventory.job

	if blackMoney > 0 then
		accountData = {
			label = 'เงินแดง',
			count = blackMoney,
			type = 'item_account',
			name = 'black_money',
			usable = false,
			rare = false,
			limit = -1,
			canRemove = false
		}
		table.insert(items, accountData)
	end

	for i = 1, #vaultItems, 1 do
		local item = vaultItems[i]

		if item.count > 0 then
			item.type = 'item_standard'
			item.usable = false
			item.rare = false
			item.limit = -1
			item.canRemove = false

			table.insert(items, item)
		end
	end

	for i = 1, #vaultWeapons, 1 do
		local weapon = vaultWeapons[i]

		if vaultWeapons[i].name ~= 'WEAPON_UNARMED' then
			table.insert(items, {
				label = ESX.GetWeaponLabel(weapon.name),
				count = weapon.ammo or weapon.count,
				limit = -1,
				type = 'item_weapon',
				name = weapon.name,
				usable = false,
				rare = false,
				canRemove = false
			})
		end
	end

	SendNUIMessage({
		action = 'setSecondInventoryItems',
		itemList = items
	})
end

function openVaultInventory()
	loadPlayerInventory()
	isInInventory = true

	SendNUIMessage({
		action = 'display',
		type = 'vault'
	})
	SetNuiFocus(true, true)
end