-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config = {}

Config.EventRoute = {
	['itemsImagePath'] = 'nui://nc_inventory/html/img/items/',
	['vehiclesImagePath'] = 'nui://nc_itemset/html/img/vehicles/',
	['gachaponsImagePath'] = 'nui://nc_itemset/html/img/gachapons/',
	['getSharedObject'] = 'esx:getSharedObject',				-- Default: 'esx:getSharedObject' *รองรับการใส่ชื่อ Event และ Function (exports.es_extended.getSharedObject)
	['playerLoaded'] = 'esx:playerLoaded',						-- Default: 'esx:playerLoaded'
	['playerDropped'] = 'esx:playerDropped',					-- Default: 'esx:playerDropped'
	['addInventoryItem'] = 'esx:addInventoryItem',				-- Default: 'esx:addInventoryItem'
	['removeInventoryItem'] = 'esx:removeInventoryItem',		-- Default: 'esx:removeInventoryItem'
	['setAccountMoney'] = 'esx:setAccountMoney',				-- Default: 'esx:setAccountMoney'
	['addWeapon'] = 'esx:addWeapon',							-- Default: 'esx:addWeapon'
	['removeWeapon'] = 'esx:removeWeapon',						-- Default: 'esx:removeWeapon'
	['setWeaponAmmo'] = 'esx:setWeaponAmmo',					-- Default: 'esx:setWeaponAmmo'

	-- สำหรับ essentialmode (es_extended 1.1) * ไม่จำเป็นต้องแก้ไขส่วนนี้
	['addedMoney'] = 'es:addedMoney',							-- Default: 'es:addedMoney'
	['removedMoney'] = 'es:removedMoney'						-- Default: 'es:removedMoney'
}

Config.Debug = false							-- Debug Mode

Config.HUD = {
	scale = 1.0,								-- ขนาดของ UI
	content_scale = 1.0,						-- ขนาดของเนื้อหา
	border_radius_scale = 1.0,					-- ความโค้งมนของขอบ
	timing_factor = 1.0,						-- ตัวคูณความเร็วของ Animation ต่างๆ (1.0 คือค่าปกติ | 0.0 คือเร็วที่สุด)
	form = {
		width = 42,								-- ความกว้างของหน้าต่าง (คิดเป็น % จากความสูงหน้าจอ)
		height = 62.5,							-- ความสูงของหน้าต่าง (คิดเป็น % จากความสูงหน้าจอ)
		item_image_size = 70,					-- ขนาดรูป Items (หน่วยเป็น %)
		item_aspect_ratio = 7 / 8				-- อัตราส่วนของช่อง Items
	},
	colors = {
		base = { r = 255, g = 204, b = 0 },				-- สีหลัก
		content = { r = 19, g = 19, b = 19 },			-- สีของเนื้อหา
		confirm_button = { r = 255, g = 204, b = 0 }	-- สีปุ่มยืนยัน
	}
}