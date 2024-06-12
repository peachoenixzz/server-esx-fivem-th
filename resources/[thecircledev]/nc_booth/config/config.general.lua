-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config = {}

Config.EventRoute = {
	['itemsImagePath'] = 'nui://nc_inventory/html/img/items',	-- ตำแหน่งของรูป Items | Default: 'nui://nc_inventory/html/img/items'
	['getSharedObject'] = 'esx:getSharedObject',				-- Default: 'esx:getSharedObject'
	['playerLoaded'] = 'esx:playerLoaded',						-- Default: 'esx:playerLoaded'
	['playerDropped'] = 'esx:playerDropped',					-- Default: 'esx:playerDropped'
	['onPlayerDeath'] = 'esx:onPlayerDeath',					-- Default: 'esx:onPlayerDeath'
	['onPlayerSpawn'] = 'playerSpawned',						-- Default: 'esx:onPlayerSpawn'
	['setJob'] = 'esx:setJob',									-- Default: 'esx:setJob'
	['onRemoveInventoryItem'] = 'esx:onRemoveInventoryItem',	-- Default: 'esx:onRemoveInventoryItem'
	['addInventoryItem'] = 'esx:addInventoryItem',				-- Default: 'esx:addInventoryItem'
	['removeInventoryItem'] = 'esx:removeInventoryItem',		-- Default: 'esx:removeInventoryItem'
	['setAccountMoney'] = 'esx:setAccountMoney',				-- Default: 'esx:setAccountMoney'
	['addWeapon'] = 'esx:addWeapon',							-- Default: 'esx:addWeapon'
	['removeWeapon'] = 'esx:removeWeapon',						-- Default: 'esx:removeWeapon'
	['setWeaponAmmo'] = 'esx:setWeaponAmmo',					-- Default: 'esx:setWeaponAmmo'

	-- สำหรับ essentialmode (es_extended 1.1) * ไม่จำเป็นต้องแก้ไขส่วนนี้
	['addedMoney'] = 'es:addedMoney',							-- Default: 'es:addedMoney'
	['removedMoney'] = 'es:removedMoney',						-- Default: 'es:removedMoney'
}

Config.Debug = false						-- Debug Mode

Config.Blur = true							-- เปิดโหมด Blur เมื่อเปิดร้านค้า
Config.OpenBoothOnDead = false				-- สามารถเปิดร้านค้าขณะตายได้

Config.HUD = {
	scale = 1.0,							-- ขนาด UI
	border_radius_scale = 1.0,				-- ความโค้งมนของขอบ
	timing_factor = 1.0,					-- ตัวคูณความเร็วของ Animation ต่างๆ (1.0 คือค่าปกติ | 0.0 คือเร็วที่สุด)
	form = {
		base = {
			column = 3,						-- จำนวน column ร้านค้าส่วนตัว
			width = 55.0,					-- ความกว้างร้านค้าส่วนตัว (คิดเป็น % จากความสูงหน้าจอ)
			height = 62.5					-- ความสูงร้านค้าส่วนตัว (คิดเป็น % จากความสูงหน้าจอ)
		},
		chat = {
			width = 26.0					-- ความกว้างของกล่องข้อความ
		}
	},
	colors = {
		base = { r = 255, g = 204, b = 0 },
		content = { r = 25, g = 25, b = 25 },
		chat = {
			base = { r = 255, g = 204, b = 0 },
			message = {
				other = { r = 110, g = 110, b = 110 },
				owner = {  r = 255, g = 204, b = 0  }
			}
		},
		service = {
			use_custom = true,
			base = { r = 255, g = 204, b = 0 },
			content = { r = 25, g = 25, b = 25 }
		},
		storage = {
			use_custom = true,
			base = { r = 255, g = 204, b = 0 },
			content = { r = 25, g = 25, b = 25 }
		}
	}
}
--[[
	---------- สีแดง ----------
	base = { r = 186, g = 30, b = 83 },
	content = { r = 18, g = 10, b = 18 }
]]

Config.Sound = {
	buy = {
		enable = true,
		file = 'buy.mp3',
		volume = 1.0,
	},
	chat_typing = {
		enable = true,
		file = 'chat_typing.mp3',
		volume = 1,
	},
	chat_send = {
		enable = true,
		file = 'chat_send.mp3',
		volume = 1,
	},
	chat_alert = {
		enable = true,
		file = 'chat_alert.mp3',
		volume = 1.0,
	},
	chat_enter = {
		enable = true,
		file = 'chat_enter.mp3',
		volume = 1.0,
	},
	chat_leave = {
		enable = false,
		file = '',
		volume = 1.0,
	}
}

Config.Keys = {
	use_keybindings = true,				-- เปิดใช้งานระบบ Key Bindings
	default = {								-- ปุ่มแบบ FiveM Default
		enter = 38,							-- ปุ่มกดเข้าร้านค้า/คลังเก็บสินค้าฝากขาย (ปุ่มปิดร้านค้าจะเป็น Esc ไม่สามารถแก้ไขได้)
		prev = 34,							-- ปุ่มกดเลื่อนไป NPC ก่อนหน้า
		next = 35,							-- ปุ่มกดเลื่อนไป NPC ถัดไป
		confirm = 191						-- ปุ่มกดยืนยันเลือก NPC
	},
	keybindings = {
		enter = 'E',						-- ปุ่มกดเข้าร้านค้า/คลังเก็บสินค้าฝากขาย (ปุ่มปิดร้านค้าจะเป็น Esc ไม่สามารถแก้ไขได้)
		prev = 'A',							-- ปุ่มกดเลื่อนไป NPC ก่อนหน้า
		next = 'D',							-- ปุ่มกดเลื่อนไป NPC ถัดไป
		confirm = 'RETURN'					-- ปุ่มกดยืนยันเลือก NPC
	}
}

Config.Font = {
	name = 'font4thai',
	scale = 1.0,
	head_offset = 0.3,				-- ระยะ Text บนหัวผู้เล่น
	distance = 2.0					-- ระยะคนที่อยู่รอบข้างที่สามารถมอบของให้ได้
}

-- ลำดับความสำคัญ น้อยกว่า = สำคัญมากกว่า | มากกว่า = สำคัญน้อยกว่า ** หากตั้งเท่ากันก็จะมีความสำคัญเท่ากัน โดยจะเรียงลำดับตามตัวอักษรของชื่อสิ่งของนั้นๆ
Config.Priorities = {
	item = 1,
	weapon = 2,
	-- water = 3
}


-- เพิ่มเติม .. หากต้องการ Block ปุ่มกด ให้ใช้คำสั่งดังนี้ (true: Block | false: ยกเลิก Block)
-- exports.nc_booth:BlockKey({ 'KEYS', ... }, true)

-- ตัวอย่างการใช้งาน Block ไม่ให้เข้าใช้งานร้านค้า Booth Shop ในกรณีต่างๆ
-- exports.nc_booth:BlockKey({ 'E' }, true)

-- ตัวอย่างการยกเลิก Block ปุ่ม ให้กลับมาใช้งานได้ดังเดิม
-- exports.nc_booth:BlockKey({ 'E' }, false)

-- ตัวอย่างการ Block ปุ่ม หลายปุ่มในคำสั่งเดียว ให้กลับมาใช้งานได้ดังเดิม
-- exports.nc_booth:BlockKey({ 'E', 'A', 'D', 'RETURN' }, true)

-- * ในกรณี Resource นี้ จะมีแค่ 4 ปุ่มเท่านั้น (E, A, D, RETURN)