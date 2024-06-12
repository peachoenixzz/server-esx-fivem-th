SkinData = {}

MySQL.ready(function(data)
	MySQL.Async.fetchAll('SELECT identifier, skin FROM users', {
	}, function(result)
		for i = 1, #result do
			SkinData[result[i].identifier] = result[i].skin
		end
	end)
end)

RegisterServerEvent('esx_skin:save')
AddEventHandler('esx_skin:save', function(skin)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	local item1 = 'mask_1'
	local item2 = 'mask_2'
	local mask = {}
	mask[item1] = skin[item1]
	mask[item2] = skin[item2]
	if mask[item1] > 0 then
		local rowMaskOwner = MySQL.single.await('SELECT owner FROM meeta_accessory_inventory WHERE owner = ? and type = ? ', {xPlayer.identifier,"player_mask"})
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'BuyClothesAndMask',
				content = ('%s ได้ทำการจ่ายเงิน $1000 หน้ากาก เหลือเงินในกระเป๋า $%s '):format(xPlayer.name, ESX.Math.GroupDigits(xPlayer.getMoney())),
				source = xPlayer.source,
			})
		end) -- End log
		if rowMaskOwner then
			MySQL.update.await('UPDATE meeta_accessory_inventory SET skin = ? WHERE owner = ?', {json.encode(mask),xPlayer.identifier})
			exports.nc_inventory:RemoveItem(src, {
				name = 'หน้ากาก',
				type = 'accessory',
				optionType = 'player_mask'
			})
			exports.nc_inventory:AddItem(src, {
				name = "หน้ากาก",
				type = 'accessory',
				accessoryData = mask,
				optionType = 'player_mask'
			})
			exports.nc_inventory:UpdateItems(src, 'accessory')
		end
		if not rowMaskOwner then
			MySQL.Async.execute('INSERT INTO meeta_accessory_inventory(owner, label, skin, type) VALUES (@owner, @label, @skin, @type)', {
				['@owner'] = xPlayer.identifier,
				['@label'] = 'หน้ากาก',
				['@skin'] = json.encode(mask),
				['@type'] = 'player_mask'
			}, function(rows)
				if rows then
					exports.nc_inventory:RemoveItem(src, {
						name = 'หน้ากาก',
						type = 'accessory',
						optionType = 'player_mask'
					})
					exports.nc_inventory:AddItem(src, {
						name = 'หน้ากาก',
						type = 'accessory',
						accessoryData = mask,
						optionType = 'player_mask'
					})
					exports.nc_inventory:UpdateItems(src, 'accessory')
				end
			end)
		end
	end
	pcall(function() -- Start log 
		exports['azael_dc-serverlogs']:insertData({
			event = 'BuyClothesAndMask',
			content = ('%s ได้ทำการจ่ายเงิน $1000 ซื้อเสื้อผ้า เหลือเงินในกระเป๋า $%s '):format(xPlayer.name, ESX.Math.GroupDigits(xPlayer.getMoney())),
			source = xPlayer.source,
		})
	end) -- End log
	SkinData[xPlayer.identifier] = json.encode(skin)	
end)


AddEventHandler('esx:playerDropped', function(playerId, reason)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	local _skin = SkinData[xPlayer.identifier]

	MySQL.Async.execute('UPDATE users SET skin = @skin WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
		['@skin'] = _skin
	})
end)

ESX.RegisterServerCallback('esx_skin:getPlayerSkin', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local jobSkin = {
		skin_male   = xPlayer.job.skin_male,
		skin_female = xPlayer.job.skin_female
	}
	local skin = json.decode(SkinData[xPlayer.identifier])

	cb(skin, jobSkin)
end)


ESX.RegisterCommand('skin', 'admin', function(xPlayer, args, showError)
	TriggerClientEvent('sm_skin:OpenMenuSkin', xPlayer.source)
end, true)

ESX.RegisterCommand('forceskin', 'admin', function(xPlayer, args, showError)
	TriggerClientEvent('sm_skin:OpenMenuSkin', tonumber(args[1]))
end, true)

if Config['Reskin_Items'].enable then 
	ESX.RegisterUsableItem(Config['Reskin_Items'].name, function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		TriggerClientEvent('sm_skin:OpenMenuSkin', xPlayer.source)
	
		if Config['Reskin_Items'].remove then 
			xPlayer.removeInventoryItem(Config['Reskin_Items'].name, 1)
		end
	end)
end