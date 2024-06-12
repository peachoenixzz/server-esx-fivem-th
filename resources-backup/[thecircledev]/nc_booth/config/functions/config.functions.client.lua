-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

---------------------------------------------------
------------------- Client Side -------------------
---------------------------------------------------

-- Function นี้จะถูกเรียกใช้งานหลังกดใช้ Item ก่อนจะเปิดหน้าต่างตั้งร้านค้าขึ้นมา
Config.ClientWillStartBooth = function(zone, itemName, itemLabel, isOwner)
	--local status = nil
	pcall(function() exports.nc_inventory:BlockKey({ 'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9' }, true) end)
	--	ESX.TriggerServerCallback('nc_booth:checkValidateItems', function(reqItem)
	--		status = reqItem
	--	end)
	--while status==nil do
	--	if status then
	--		print("have require")
	--		return false
	--	end
	--	if not status then
	--		print("none require")
	--		return true
	--	end
	--	Wait(50)
	--	print("reload")
	--end
	print("test")
	 exports['azael_dc-serverlogs']:insertData({ -- Start log
	 event = 'OpenBoothMenu',
	 content = ('ผู้เล่นได้ทำการกดใช้ %s เพื่อทำการเปิดเมนูตั้งร้านค้า'):format(itemName),
	 }) -- End log
	--return true				-- ตั้งค่าเป็น True หากไม่ต้องการให้เปิดร้านค้า
end

-- Function นี้จะถูกเรียกเมื่อปิดหน้าต่างตั้งร้านค้าสำเร็จ
Config.ClientCloseBooth = function()
	pcall(function() exports.nc_inventory:BlockKey({ 'F2', '1', '2', '3', '4', '5', '6', '7', '8', '9' }, false) end)
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'CloseBoothMenu',
	content = ('ผู้เล่นได้ทำการปิดเมนูตั้งร้านค้า'):format(),
	}) -- End log
end

-- Function นี้จะถูกเรียกใช้งานก่อนเข้าร้านค้าผู้อื่น
Config.ClientWillEnterBooth = function(zone)
	-- return true				-- ตั้งค่าเป็น True หากไม่ต้องการให้เข้าร้านค้า
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'PlayerEnterMerchantBooth',
	content = ('ผู้เล่นได้ทำการกด E เพื่อเข้าดูสินค้าในร้านค้า'):format(),
	}) -- End log
end

-- Function นี้จะถูกเรียกใช้งานก่อนเข้าคลังเบิกสิ่งของ
Config.ClientWillEnterStorage = function()
	-- return true				-- ตั้งค่าเป็น True หากไม่ต้องการให้เข้าคลังเบิกสิ่งของ
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'OpenMerchantStorageMenu',
	content = ('ผู้เล่นได้ทำการกด E เพื่อเปิดเมนูจุดเบิกสินค้าฝากขาย'):format(),
	}) -- End log
end

-- Function นี้จะถูกเรียกใช้งานเมื่อเริ่มเปิดขายสินค้า
Config.ClientStartSelling = function()
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'MerchantBoothOpenForBusiness',
	content = ('ผู้เล่นได้ทำการเปิดพร้อมขายสินค้าในร้านค้า'):format(),
	}) -- End log
end

-- Function นี้จะถูกเรียกใช้งานเมื่อเริ่มหยุดขายสินค้า
Config.ClientStopSelling = function()
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'MerchantBoothCloseForToDay',
	content = ('ผู้เล่นได้ทำการปิดการขายสินค้าในร้านค้า'):format(),
	}) -- End log
end

-- Function นี้จะถูกเรียกใช้งานเมื่ออยู่ใน View Mode (สามารถเข้าสู่ ViewMode ได้โดยการกด Spacebar ขณะตั้งขายสินค้าอยู่ในร้านค้าส่วนตัว)
-- ระวัง!! Function นี้จะถูกเรียกใช้ทุก Frame เมื่ออยู่ใน View Mode
Config.ClientOnViewModeEveryFrame = function()
	DisableAllControlActions(0)
	EnableControlAction(0, 1, true)
	EnableControlAction(0, 2, true)
	EnableControlAction(0, 249, true)
end

-- Function นี้จะถูกเรียกใช้งานเมื่อมี Error
-- errAction จะถูกส่งมาตามนี้
-- title		=>	ตั้งชื่อร้าน
-- start_booth	=>	เปิดร้าน
-- buy			=>	ซื้อสินค้า
-- storage_open	=>	เปิดคลังสินค้า
-- storage_get	=>	เบิกสิ่งของออกจากคลัง
-- errType ที่ถูกส่งมาจะมีอยู่ 2 ชนิดคือ 'error' และ 'warning'
Config.OnError = function(errAction, errType, errText)
	-- ตัวอย่างการเขียน Notification ต่างๆ
	-- errText								errType
	-- no_title							=>	'error' - เนื่องจากชื่อร้านของคุณว่างเปล่า
	-- service_exceed_limit				=>	'error' - คุณใช้บริการตั้งร้านฝากขายสินค้าถึงจำนวนสูงสุดแล้ว
	-- service_storage_not_empty		=>	'error' - คุณยังมีสินค้าคงค้างอยู่ในคลัง
	-- source_too_close					=>	'error' - คุณอยู่ใกล้ร้านค้าอื่นมากเกินไป
	-- storage_too_close				=>	'error' - คุณอยู่ใกล้จุดเบิกสินค้ามากเกินไป
	-- source_in_vehicle				=>	'error' - กรุณาลงจากยานพาหนะก่อน
	-- no_items_selected				=>	'error' - คุณยังไม่ได้เลือกสินค้าเพื่อวางขาย
	-- source_account_not_enough		=>	'error' - คุณมีเงินไม่เพียงพอสำหรับซื้อสินค้าชิ้นนี้
	-- source_inventory_full			=>	'error' - พื้นที่ในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บของสิ่งนี้ | warning - พื้นที่ในกระเป๋าของคุณสามารถเก็บของสิ่งนี้บางส่วน
	-- storage_empty					=>	'error' - คุณไม่มีของคงค้างในคลังเบิกสินค้าฝากขาย
	-- storage_inventory_full			=>	'error' - พื้นที่ในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บของใดๆจากคลัง | 'warning' - พื้นที่ในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บของจากคลังทั้งหมด 
	if errText == 'no_title' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบตั้งร้านค้า', -- หัวเรื่อง
			description = 'คุณยังไม่ได้ตั้งชื่อร้านค้า', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_result', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'service_exceed_limit' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบตั้งร้านค้า', -- หัวเรื่อง
			description = 'คุณใช้บริการตั้งร้านฝากขายสินค้าถึงจำนวนสูงสุดแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_vault', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'service_storage_not_empty' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบตั้งร้านค้า', -- หัวเรื่อง
			description = 'คุณยังมีสินค้าคงค้างอยู่ในคลัง', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'source_too_close' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบตั้งร้านค้า', -- หัวเรื่อง
			description = 'คุณอยู่ใกล้ร้านค้าอื่นมากเกินไป', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_area', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'storage_too_close' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบตั้งร้านค้า', -- หัวเรื่อง
			description = 'คุณอยู่ใกล้จุดเบิกสินค้ามากเกินไป', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_area', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'source_in_vehicle' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบตั้งร้านค้า', -- หัวเรื่อง
			description = 'กรุณาลงจากยานพาหนะก่อน', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'vehicle', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'no_items_selected' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบตั้งร้านค้า', -- หัวเรื่อง
			description = 'คุณยังไม่ได้เลือกสินค้าเพื่อวางขาย', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'source_account_not_enough' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบตั้งร้านค้า', -- หัวเรื่อง
			description = 'คุณมีเงินไม่เพียงพอสำหรับซื้อสินค้าชิ้นนี้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'source_inventory_full' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบกระเป๋า', -- หัวเรื่อง
			description = 'น้ำหนักกระเป๋าของคุณไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'inventory_max', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'storage_empty' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบตั้งร้านค้า', -- หัวเรื่อง
			description = 'คุณไม่มีของคงค้างในคลังเบิกสินค้าฝากขาย', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'storage_inventory_full' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบกระเป๋า', -- หัวเรื่อง
			description = 'น้ำหนักกระเป๋าของคุณไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'inventory_max', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	end
end