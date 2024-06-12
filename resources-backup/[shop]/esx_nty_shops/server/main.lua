ESX             = nil
local ShopItems = {}
local hasSqlRun = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Load items
AddEventHandler('onMySQLReady', function()
	hasSqlRun = true
	LoadShop()

end)

-- extremely useful when restarting script mid-game
Citizen.CreateThread(function()
	Citizen.Wait(2000) -- hopefully enough for connection to the SQL server

	if not hasSqlRun then
		LoadShop()
		hasSqlRun = true
	end
end)

function LoadShop()
	local itemResult = MySQL.Sync.fetchAll('SELECT name,label FROM items')
	local shopResult = MySQL.Sync.fetchAll('SELECT * FROM shops')
	local itemInformation = {}
	local label = nil
	for i=1, #itemResult, 1 do
		if itemInformation[itemResult[i].name] == nil then
			itemInformation[itemResult[i].name] = {}
		end
		itemInformation[itemResult[i].name].label = itemResult[i].label
		itemInformation[itemResult[i].name].name = itemResult[i].name
	end

	for i=1, #shopResult, 1 do
		if ShopItems[shopResult[i].store] == nil then
			ShopItems[shopResult[i].store] = {}
		end
		if shopResult[i].type == "economy"  then
			label = itemInformation[shopResult[i].item].label
		end

		if shopResult[i].type == "weapon"  then
			print(shopResult[i].name)
			label = ESX.GetWeaponLabel(shopResult[i].item)
		end

		table.insert(ShopItems[shopResult[i].store], {
			label = label,
			item  = shopResult[i].item,
			price = shopResult[i].price,
			type = shopResult[i].type,
		})
	end
end

ESX.RegisterServerCallback('esx_shops:requestDBItems', function(source, cb)
	if not hasSqlRun then
		TriggerClientEvent('esx:showNotification', source, 'The shop database has not been loaded yet, try again in a few moments.')
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'TheShopDatabaseNotLoaded',
				content = ('%s ได้ทำการเปิด Shop Menu แต่ตัว Data base ของ Shop ยังโหลดไม่เสร็จ'):format(xPlayer.name),
				source = xPlayer.source,
			})
		 end) -- End log
	end
	pcall(function() -- Start log
		exports['azael_dc-serverlogs']:insertData({
			event = 'TheShopDatabaseLoaded',
			content = ('%s ได้ทำการเปิด Shop Menu แต่ตัว Data base ของ Shop โหลดเสร็จ'):format(xPlayer.name),
			source = xPlayer.source,
		})
	 end) -- End log
	cb(ShopItems)
end)

RegisterServerEvent('esx_shops:buyItem')
AddEventHandler('esx_shops:buyItem', function(itemName, amount, zone, type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	amount = ESX.Round(amount)

	-- is the player trying to exploit?
	if amount < 0 then
		print('esx_shops: ' .. xPlayer.identifier .. ' attempted to exploit the shop!')
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'PlayerAttemptToExploitTheShop',
				content = ('%s พยายามจะโกงซื้อของใน Shop'):format(xPlayer.name),
				source = xPlayer.source,
			})
		end)-- End log
		return
	end

	if amount > 100 then
		wrongSituation(_source)
		print('esx_shops: ' .. xPlayer.identifier .. ' attempted to exploit the shop!')
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'PlayerAttemptToExploitTheShop',
				content = ('%s พยายามจะโกงซื้อของใน Shop'):format(xPlayer.name),
				source = xPlayer.source,
			})
		end)-- End log
		return
	end

	-- get price
	local price = 0
	local itemLabel = ''

	for i=1, #ShopItems[zone], 1 do
		if ShopItems[zone][i].item == itemName then
			price = ShopItems[zone][i].price
			itemLabel = ShopItems[zone][i].label
			break
		end
	end

	price = price * amount

	-- can the player afford this item?
	if xPlayer.getMoney() >= price then
		if type == "weapon" then
			print(itemName)
			print(type)
			if xPlayer.hasWeapon(itemName) then
				print("have weapon")
				xPlayer.removeMoney(price)
				xPlayer.addWeaponAmmo(itemName, 250)
			end
			if not xPlayer.hasWeapon(itemName) then
				print("no weapon")
				xPlayer.removeMoney(price)
				xPlayer.addWeapon(itemName, 250)
			end
			return
		end
		-- can the player carry the said amount of x item?
		--if xPlayer.canCarryItem(itemName, amount) then
		local itemInfo = xPlayer.getInventoryItem(itemName)

		if xPlayer.canCarryItem(itemName, amount) then
			if itemName == 'painkiller' or itemName == 'body_bag' then
				local xItemGangCard = xPlayer.getInventoryItem("card_gang")
				local xItemFamilyCard = xPlayer.getInventoryItem("card_family")
				if xItemGangCard.count >= 1 or xItemFamilyCard.count >= 1 then
					xPlayer.removeMoney(price)
					xPlayer.addInventoryItem(itemName, amount)	
				else
					onNoCardGang(source)
				end
				return
			end
			xPlayer.removeMoney(price)
			xPlayer.addInventoryItem(itemName, amount)
		else
			--TriggerClientEvent('esx:showNotification', _source, _U('player_cannot_hold'))
		end
	else
		local missingMoney = price - xPlayer.getMoney()
		--TriggerClientEvent('esx:showNotification', _source, _U('not_enough', missingMoney))
		onNoMoneyToBuy(source)
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'InsufficientMoneyToBuyItemFromShop',
				content = ('%s ไม่สามารถทำการซื้อ %s จำนวน %s ชิ้นจากร้านค้าได้เนื่องจากมีเงินในกระเป๋าไม่เพียงพอ มีเงินเหลือในกระเป๋า $%s ราคาสินค้ารวม $%s ต้องการเงินอีกจำนวน $%s เพื่อทำการซื้อ %s ให้สำเร็จ'):format(xPlayer.name, itemName, amount, ESX.Math.GroupDigits(xPlayer.getMoney()), price, missingMoney, itemLabel),
				source = xPlayer.source,
			})
		end) -- End log
	end
end)

RegisterServerEvent('esx_shops:buyItemCredit')
AddEventHandler('esx_shops:buyItemCredit', function(itemName, amount, zone, type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	amount = ESX.Round(amount)

	-- is the player trying to exploit?
	if amount < 0 then
		print('esx_shops: ' .. xPlayer.identifier .. ' attempted to exploit the shop!')
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'PlayerAttemptToExploitTheShop',
				content = ('%s พยายามจะโกงซื้อของใน Shop'):format(xPlayer.name),
				source = xPlayer.source,
			})
		end)-- End log
		return
	end

	if amount > 100 then
		wrongSituation(_source)
		print('esx_shops: ' .. xPlayer.identifier .. ' attempted to exploit the shop!')
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'PlayerAttemptToExploitTheShop',
				content = ('%s พยายามจะโกงซื้อของใน Shop'):format(xPlayer.name),
				source = xPlayer.source,
			})
		end)-- End log
		return
	end

	-- get price
	local price = 0
	local itemLabel = ''

	for i=1, #ShopItems[zone], 1 do
		if ShopItems[zone][i].item == itemName then
			price = ShopItems[zone][i].price
			itemLabel = ShopItems[zone][i].label
			break
		end
	end

	fee = (price * amount) * 0.07
	price = (price * amount) + fee

	-- can the player afford this item?
	if xPlayer.getAccount('bank').money >= price then
		-- can the player carry the said amount of x item?
		--if xPlayer.canCarryItem(itemName, amount) then
		if type == "weapon" then
			print(itemName)
			print(type)
			if xPlayer.hasWeapon(itemName) then
				print("have weapon")
				fee = price * 0.07
				price = price + fee
				xPlayer.removeAccountMoney('bank', price)
				xPlayer.addWeaponAmmo(itemName, 250)
			end
			if not xPlayer.hasWeapon(itemName) then
				print("no weapon")
				fee = price * 0.07
				price = price + fee
				xPlayer.removeAccountMoney('bank', price)
				xPlayer.addWeapon(itemName, 250)
			end
			return
		end
		local itemInfo = xPlayer.getInventoryItem(itemName)
		if xPlayer.canCarryItem(itemName, amount) then
			if itemName == 'painkiller' or itemName == 'body_bag' then
				local xItemGangCard = xPlayer.getInventoryItem("card_gang")
				local xItemFamilyCard = xPlayer.getInventoryItem("card_family")
				if xItemGangCard.count >= 1 or xItemFamilyCard.count >= 1 then
					xPlayer.removeAccountMoney('bank', price)
					xPlayer.addInventoryItem(itemName, amount)
					addMoneyCircleVaultSucessBuy(price)
				else
					onNoCardGang(source)
				end
				return
			end
			xPlayer.removeAccountMoney('bank', price)
			xPlayer.addInventoryItem(itemName, amount)
		else
			--TriggerClientEvent('esx:showNotification', _source, _U('player_cannot_hold'))
		end
	else
		local missingMoney = price - xPlayer.getMoney()
		--TriggerClientEvent('esx:showNotification', _source, _U('not_enough', missingMoney))
		onNoMoneyToBuy(source)
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'InsufficientCreditToBuyItemFromShop',
				content = ('%s ไม่สามารถทำรายการซื้อ %s จำนวน %s จากร้านค้าได้เนื่องจากมียอดเงินในธนาคารไม่เพียงพอมียอดเงินคงเหลือ $%s ราคาสินค้ารวมค่าทำเนียม $%s ค่าทำเนียม $%s ต้องการเงินอีกจำนวน $%s เพื่อทำการซื้อ %s ให้สำเร็จ'):format(xPlayer.name, itemName, amount, ESX.Math.GroupDigits(xPlayer.getAccount('bank').money), ESX.Round(price), ESX.Round(fee), ESX.Round(price - xPlayer.getAccount('bank').money), itemLabel),
				source = xPlayer.source,
			})
		end) -- End log
	end
end)

function onNoCardGang(source)
	exports.nc_notify:PushNotification(source,{
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบร้านค้า', -- หัวเรื่อง
		description = 'คุณไม่มีบัตรแก็งหรือบัตรครอบครัว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		--color  = 'rgba(0, 204, 204)',  -- สีของพื้นหลัง
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'block', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end

function onNoMoneyToBuy(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบร้านค้า', -- หัวเรื่อง
        description = 'คุณมีเงินไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function wrongSituation(source)
	exports.nc_notify:PushNotification(source,{
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบร้านค้า', -- หัวเรื่อง
		description = 'จำนวนในการซื้อสินค้ามากเกินกำหนด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'no_money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end