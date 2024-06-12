-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

---------------------------------------------------
------------------- Server Side -------------------
---------------------------------------------------

-- Function นี้จะถูกเรียกใช้เพื่อตรวจสอบพื้นที่ว่างสำหรับเก็บ Item ต่างๆในกระเป๋า
Config.ServerValidateCanCarryItem = function(action, xPlayer, itemType, itemName, itemCount)
	-- action		=>	action ที่เรียกใช้ Function น๊้ (buy|get_storage)
	-- xPlayer		=>	xPlayer ของผู้รับของ
	-- itemType		=>	'item' - สิ่งของทั่วไป | 'weapon' - อาวุธ
	-- itemName		=>	ชื่อสิ่งของ/อาวุธ
	-- itemCount	=>	จำนวนสิ่งของที่ทำการซื้อขาย (itemCount จะเท่ากับ 1 เสมอเมื่อ itemType == 'weapon')
	if itemType == 'item' then
		local xItem = xPlayer.getInventoryItem(itemName)
		if xItem then
			local countByLimit, countByWeight = nil, nil
			if xItem.limit and xItem.limit ~= -1 and xItem.count + itemCount > xItem.limit then
				countByLimit = xItem.limit - xItem.count
			end
			if xItem.weight and xPlayer.getWeight and xPlayer.getMaxWeight then
				local weight = xPlayer.getWeight()
				local maxWeight = xPlayer.getMaxWeight()
				if xItem.weight * itemCount > maxWeight - weight then
					itemCount = math.floor((maxWeight - weight) / xItem.weight)
				end
			end
			return math.min(countByLimit or itemCount, countByLimit or itemCount)
		end
	elseif itemType == 'weapon' then
		local i,weapon = xPlayer.getWeapon(itemName)
		if not weapon then
			return 1
		end
	end
	return 0		-- return กลับไปเป็นจำนวนที่อนุญาตให้เก็บเข้ากระเป๋า (return 0 เมื่อไม่ต้องการให้การกระทำนี้สำเร็จ)
end

-- Function นี้จะถูกเรียกใช้เมื่อผู้เล่นตั้งร้านขายสินค้าสำเร็จ
-- โดย items, weapons จะส่งมาในรูปแบบของ Object ที่มี key => itemName และ value => { count = itemCount, ammo = weaponAmmo, price = itemPrice }
Config.ServerStartBooth = function(boothType, xPlayer, items, weapons)
	-- boothType		=>	'normal' - ร้านค้าทั่วไป | 'service' - ร้านค้าฝากขาย
	for itemName, itemData in pairs(items) do -- For Log Purpose
        local itemCount = itemData.count
        local itemPrice = itemData.price
		exports['azael_dc-serverlogs']:insertData({ -- Start log
			event = 'OpenMerchantBooth',
			content = ('%s ได้ทำการเปิดร้าค้าประเภท %s ที่มี %s จำนวน %s ชิ้น ราคาชิ้นละ $%s'):format(xPlayer.name, boothType, itemName, itemCount, itemPrice),
			source = xPlayer.source,
		}) -- End log
	end -- End log

	if boothType == 'normal' then
		exports.nc_notify:PushNotification(xPlayer.source,{
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบตั้งร้านค้า', -- หัวเรื่อง
			description = 'คุณได้ตั้งร้านค้าส่วนตัวสำเร็จ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'booth', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	elseif boothType == 'service' then
		exports.nc_notify:PushNotification(xPlayer.source,{
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบตั้งร้านค้า', -- หัวเรื่อง
			description = 'คุณได้ตั้งร้านค้าฝากขายสำเร็จ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'booth', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	end
end

-- Function นี้จะถูกเรียกใช้เมื่อผู้เล่นซื้อสินค้าสำเร็จ
Config.ServerBuyItem = function(boothType, xOwner, xBuyer, itemType, itemName, itemCount, accountBuyType, buyPrice, accountSellType, netPrice, commission)
	-- boothType		=>	'normal' - ร้านค้าทั่วไป | 'service' - ร้านค้าฝากขาย
	-- xOwner			=>	xPlayer ของผู้ขาย
	-- xBuyer			=>	xPlayer ของผู้ซื้อ
	-- itemType			=>	'item' - สิ่งของทั่วไป | 'weapon' - อาวุธ
	-- itemName			=>	ชื่อสิ่งของ/อาวุธ
	-- itemCount		=>	จำนวนสิ่งของที่ทำการซื้อขาย (itemCount คือจำนวนกระสุน เมื่อ itemType == 'weapon')
	-- accountBuyType	=>	ชนิดของเงินที่ผู้ซื้อสูญเสีย
	-- buyPrice			=>	ราคาขายของสินค้า
	-- accountSellType	=>	ชนิดของเงินที่ขายได้รับ
	-- netPrice			=>	ราคาขายของสินค้า (โดยหักค่า Commission แล้ว)
	-- commission		=>	ค่า Commission ของร้านค้า (%)
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'SellItemFromMerchantBooth',
	content = ('%s ได้รับ %s จำนวน $%s จากการขาย %s จำนวน %s ชิ้น ราคาชิ้นละ $%s ให้กับ %s โดนหักค่า commission %s เปอร์เซ็นเป็นเงินจำนวน $%s'):format(xOwner.name, accountSellType, netPrice, itemName, itemCount, buyPrice, xBuyer.name, commission, (buyPrice - netPrice)),
	source = xOwner.source,
	}) -- End log
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'BuyItemFromMerchantBooth',
	content = ('%s ได้ทำการซื้อ %s จำนวน %s ชิ้น จาก %s ในราคาชิ้นละ $%s สูญเสีย %s จำนวน $%s'):format(xBuyer.name, itemName, itemCount, xOwner.name, buyPrice, accountBuyType, buyPrice),
	source = xBuyer.source,
	}) -- End log
end

-- Function นี้จะถูกเรียกใช้เมื่อผู้เล่นเบิกของออกจากคลัง
-- โดย items, weapons จะส่งมาในรูปแบบของ Object ที่มี key => itemName และ value => count/ammo (จำนวนที่ได้รับ)
-- หากผู้เล่นไม่สามารถเบิกสินค้าได้ ระบบจะส่ง items = {}, weapons = {}
Config.ServerGetStorageItems = function(xPlayer, items, weapons)
	for itemName, itemCount in pairs(items) do -- For log purpose
		exports['azael_dc-serverlogs']:insertData({ -- Start log
		event = 'GetItemFromMerchantStorage',
		content = ('%s ได้ทำการเบิก %s จำนวน %s ชิ้น จากจุดเบิกสินค้าฝากขาย'):format(xPlayer.name, itemName, itemCount),
		source = xPlayer.source,
		}) -- End log
	end -- End log
end

ESX.RegisterServerCallback('nc_booth:checkValidateItems', function(source, cb)
	local has_required_item = true
	local xPlayer = ESX.GetPlayerFromId(source)
	for _, req_item in ipairs(Config.RequiredItem.req) do
		print(req_item)
		local xItem = xPlayer.getInventoryItem(req_item)
		if xItem and xItem.count > 0 then
			has_required_item = false
			break
		end
	end
	print(has_required_item)
	cb(has_required_item)
	return
end)

Config.RequiredItem = {
	req = {"card_merchant_1","card_merchant_2","card_merchant_3","card_merchant_4"},
}
