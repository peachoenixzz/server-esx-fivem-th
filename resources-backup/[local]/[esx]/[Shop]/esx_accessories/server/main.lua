RegisterServerEvent('esx_accessories:pay')
AddEventHandler('esx_accessories:pay', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeMoney(Config.Price, "Accessory Purchase")
	--TriggerClientEvent('esx:showNotification', source, TranslateCap('you_paid', ESX.Math.GroupDigits(Config.Price)))
end)

RegisterServerEvent('esx_accessories:save')
AddEventHandler('esx_accessories:save', function(skin, accessory)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	--TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
		--store.set('has' .. accessory, true)

		local itemSkin = {}
		local item1 = string.lower(accessory) .. '_1'
		local item2 = string.lower(accessory) .. '_2'
		itemSkin[item1] = skin[item1]
		itemSkin[item2] = skin[item2]
		print("acc : ",accessory)
		print("skin : ",skin[item1])
		local rowMaskOwner = MySQL.single.await('SELECT owner FROM meeta_accessory_inventory WHERE owner = ? and type = ? ', {xPlayer.identifier,"player_mask"})
		if rowMaskOwner then
			MySQL.update.await('UPDATE meeta_accessory_inventory SET skin = ? WHERE owner = ?', {json.encode(itemSkin),xPlayer.identifier})
			exports.nc_inventory:RemoveItem(source, {
				name = 'หน้ากาก',
				type = 'accessory',
				optionType = 'player_mask'
			})
			exports.nc_inventory:AddItem(source, {
				name = "หน้ากาก",
				type = 'accessory',
				accessoryData = itemSkin,
				optionType = 'player_mask'
			})
			exports.nc_inventory:UpdateItems(source, 'accessory')
		end
		if not rowMaskOwner then
			MySQL.Async.execute('INSERT INTO meeta_accessory_inventory(owner, label, skin, type) VALUES (@owner, @label, @skin, @type)', {
				['@owner'] = xPlayer.identifier,
				['@label'] = 'หน้ากาก',
				['@skin'] = json.encode(itemSkin),
				['@type'] = 'player_' ..string.lower(accessory)
			}, function(rows)
				if rows then
					exports.nc_inventory:RemoveItem(source, {
						name = 'หน้ากาก',
						type = 'accessory',
						optionType = 'player_mask'
					})
					exports.nc_inventory:AddItem(source, {
						name = 'หน้ากาก',
						type = 'accessory',
						accessoryData = itemSkin,
						optionType = 'player' .. accessory
					})
					exports.nc_inventory:UpdateItems(source, 'accessory')
				end
			end)
		end
		--store.set('skin', itemSkin)
	--end)
end)

ESX.RegisterServerCallback('esx_accessories:get', function(source, cb, accessory)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
		local hasAccessory = (store.get('has' .. accessory) and store.get('has' .. accessory) or false)
		local skin = (store.get('skin') and store.get('skin') or {})

		cb(hasAccessory, skin)
	end)

end)

ESX.RegisterServerCallback('esx_accessories:checkMoney', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(xPlayer.getMoney() >= Config.Price)
end)
