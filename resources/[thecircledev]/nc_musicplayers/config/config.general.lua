-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config = {}

Config.EventRoute = {
	['getSharedObject'] = 'esx:getSharedObject',				-- Default: 'esx:getSharedObject' *รองรับการใส่ชื่อ Event และ Function (exports.es_extended.getSharedObject)
	['playerDropped'] = 'esx:playerDropped',					-- Default: 'esx:playerDropped'
	['onPlayerDeath'] = 'esx:onPlayerDeath',					-- Default: 'esx:onPlayerDeath'
	['onPlayerSpawn'] = 'playerSpawned',						-- Default: 'esx:onPlayerSpawn'
	['setJob'] = 'esx:setJob',									-- Default: 'esx:setJob'

	['onAddInventoryItem'] = 'esx:onAddInventoryItem',			-- Default: 'esx:onAddInventoryItem'
	['onRemoveInventoryItem'] = 'esx:onRemoveInventoryItem'		-- Default: 'esx:onRemoveInventoryItem'
}

Config.Debug = false									-- Debug Mode
Config.DebugDev = false								-- Debug Developer Mode

Config.AntiSpam = 1200

Config.RefreshInterval = 100

Config.ActiveRadius = 20.0

Config.DefaultVolume = 0.5

Config.HUD = {
	scale = 1.0,								-- ขนาดของ UI
	content_scale = 1.0,						-- ขนาดของเนื้อหา
	border_radius_scale = 1.0,					-- ความโค้งมนของขอบ
	timing_factor = 1.0,						-- ตัวคูณความเร็วของ Animation ต่างๆ (1.0 คือค่าปกติ | 0.0 คือเร็วที่สุด)
	colors = {
		-- base = { r = 134, g = 37, b = 46 },			-- สีหลัก (แดง)
		base = { r=255,g= 204, b=0  },			-- สีหลัก
		content = { r = 18, g = 20, b = 23 },			-- สีของเนื้อหา
		confirm_button = { r=255,g= 204, b=0  },	-- สีปุ่มยืนยัน
		-- เลือกสีเพิ่มเติมได้ที่ https://htmlcolorcodes.com/color-picker/
	},
	logo = 'https://img2.pic.in.th/pic/mongkol.png',
	position = 'bottom-left',					-- ตำแหน่งที่ต้องการจะแสดง top|right|bottom|left|top-left|top-right|bottom-right|bottom-left
	offsets = {
		top = 6.0,								-- เว้น Offset จากด้านบน
		right = 1.5,							-- เว้น Offset จากด้านขวา
		bottom = 6.0,							-- เว้น Offset จากด้านล่าง
		left = 1.5								-- เว้น Offset จากด้านซ้าย
	}
}

Config.CustomFont = {
	enable = true,
	name = 'font4thai',
	scale = 1.0
}

Config.Keys = {
	use_keybindings = true,					-- เปิดใช้งานระบบ Key Bindings
	default = {								-- ปุ่มแบบ FiveM Default
		action = 38,						-- ปุ่ม เข้าใช้งานเครื่องเสียง/ลำโพง
	},
	keybindings = {
		action = 'E'						-- ปุ่ม เข้าใช้งานเครื่องเสียง/ลำโพง
	}
}

-- กลุ่ม Administrator (กลุ่มสามารถใช้งานคำสั่งต่างๆได้)
Config.AdminGroups = {
	'admin',
	'superadmin'
}

-- เพิ่มเติม .. หากต้องการ Block ปุ่มกด ให้ใช้คำสั่งดังนี้ (true: Block | false: ยกเลิก Block)
-- exports.nc_musicplayers:BlockKey({ 'KEYS', ... }, true)

-- ตัวอย่างการใช้งาน Block ไม่ให้สามารถใช้งานเครื่องเสียง/ลำโพงได้
-- exports.nc_musicplayers:BlockKey({ 'E' }, true)

-- ตัวอย่างการยกเลิก Block ปุ่ม ให้กลับมาใช้งานได้ดังเดิม
-- exports.nc_musicplayers:BlockKey({ 'E' }, false)

-- ตัวอย่างการ Block ปุ่ม หลายปุ่มในคำสั่งเดียว ให้กลับมาใช้งานได้ดังเดิม
-- exports.nc_musicplayers:BlockKey({ 'E' }, true)

-- * ในกรณี Resource นี้ จะมีแค่ 1 ปุ่มเท่านั้น (E)