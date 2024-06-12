-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config = {}

Config.EventRoute = {
	['itemsImagePath'] = 'nui://nc_inventory/html/img/items',		-- ตำแหน่งของรูป Items | Default: 'nui://nc_inventory/html/img/items'
	['getSharedObject'] = 'esx:getSharedObject',					-- Default: 'esx:getSharedObject'
	['addInventoryItem'] = 'esx:addInventoryItem',					-- Default: 'esx:addInventoryItem'
	['removeInventoryItem'] = 'esx:removeInventoryItem',			-- Default: 'esx:removeInventoryItem'
	['setAccountMoney'] = 'esx:setAccountMoney',					-- Default: 'esx:setAccountMoney'
	['addWeapon'] = 'esx:addWeapon',								-- Default: 'esx:addWeapon'
	['removeWeapon'] = 'esx:removeWeapon',							-- Default: 'esx:removeWeapon'

	-- สำหรับ essentialmode (es_extended 1.1) * ไม่จำเป็นต้องแก้ไขส่วนนี้
	['addedMoney'] = 'es:addedMoney',						-- Default: 'es:addedMoney'
	['removedMoney'] = 'es:removedMoney'					-- Default: 'es:removedMoney'
}

Config.MaxShow = -1					-- จำนวนในการแสดงพร้อมกันสูงสุด (ตั้ง -1 หากต้องการให้แสดงไม่จำกัด)

Config.Default = {
	scale = 1.00,						-- ขนาดของ Notify แยกเป็นอันๆ
	position = 'top',					-- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
	direction = 'right',				-- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
	priority = 'medium',				-- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
	bgColor = 'rgba(0, 0, 0, 0.6)',
	descriptionColor = 'white',
	icon = 'default',					-- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
	duration = 5000,					-- ระยะเวลาการแสดง Notify
	showDuration = true,				-- แสดงหลอดระยะวลาการแสดงผล
	colors = {
		info = '#52b3e0',
		success = '#FFED3D',
		error = '#FF5A30',
		warning = '#FF9A00',
		add = '#3ac46f',
		remove = '#c0394f'
	}
}

Config.HUD = {
	scale = 1.00,						-- ขนาดของ Notify
	border_radius_scale = 1.0,			-- ความโค้งมนของขอบ
	timing_factor = 1.0,				-- ตัวคุณความเร็วของ Animation ต่างๆ (1.0 คือค่าปกติ | 0.0 คือเร็วที่สุด)
	left = {
		offset_top = 0,					-- ระยะเว้นจากด้านบนของ Notify ฝั่ง 'ซ้าย' กรณี position = 'top'
		offset_bottom = 0,				-- ระยะเว้นจากด้านล่างของ Notify ฝั่ง 'ซ้าย' กรณี position = 'bottom'
		offset_left = 0					-- ระยะเว้นจากด้านข้างของ Notify ฝั่ง 'ซ้าย'
	},
	center = {
		offset_top = 0,					-- ระยะเว้นจากด้านบนของ Notify ฝั่ง 'กลาง' กรณี position = 'top'
		offset_bottom = 0,				-- ระยะเว้นจากด้านล่างของ Notify ฝั่ง 'กลาง' กรณี position = 'bottom'
	},
	right = {
		offset_top = 10,				-- ระยะเว้นจากด้านบนของ Notify ฝั่ง 'ขวา' กรณี position = 'top'
		offset_bottom = 0,				-- ระยะเว้นจากด้านล่างของ Notify ฝั่ง 'ขวา' กรณี position = 'bottom'
		offset_right = 0				-- ระยะเว้นจากด้านข้างของ Notify ฝั่ง 'ขวา'
	},
	top = {
		reverse = false					-- แสดงลำดับการเพิ่ม Notify เป็นทิศตรงข้าม
	},
	bottom = {
		reverse = false					-- แสดงลำดับการเพิ่ม Notify เป็นทิศตรงข้าม
	}
}

Config.InventoryNotify = {
	enable = true,						-- แสดงการแจ้งเตือนการได้รับและสูญเสียสิ่งของแบบอัตโนมัติ
	reverse_queue = true,				-- แสดงของที่ได้รับหรือสูญเสียหลังสุดขึ้นก่อน
	group_time = 0,					-- ระยะเวลาการจัดกลุ่ม Notify (หน่วยเป็น ms) * 1000 = 1 วินาที
	options = {
		scale = 1.00,
		--position = 'bottom',
		--direction = 'right',
		--priority = 'medium',
		--bgColor = 'white',
		--descriptionColor = '#4c535a',
		duration = 5000,
		showDuration = true
	}
}