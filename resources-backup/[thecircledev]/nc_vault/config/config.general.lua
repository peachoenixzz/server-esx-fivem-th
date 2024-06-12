-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --
Config = {}

Config.EventRoute = {
	['itemsImagePath'] = 'nui://nc_inventory/html/img/items',	-- ตำแหน่งของรูป Items | Default: 'nui://nc_inventory/html/img/items'
	['getSharedObject'] = 'esx:getSharedObject',				-- Default: 'esx:getSharedObject' *รองรับการใส่ชื่อ Event และ Function (exports.es_extended.getSharedObject)
	['playerLoaded'] = 'esx:playerLoaded',						-- Default: 'esx:playerLoaded'
	['playerDropped'] = 'esx:playerDropped',					-- Default: 'esx:playerDropped'
	['onPlayerDeath'] = 'esx:onPlayerDeath',					-- Default: 'esx:onPlayerDeath'
	['onPlayerSpawn'] = 'playerSpawned',						-- Default: 'esx:onPlayerSpawn'
	['setJob'] = 'esx:setJob',									-- Default: 'esx:setJob'
	['addInventoryItem'] = 'esx:addInventoryItem',				-- Default: 'esx:addInventoryItem'
	['removeInventoryItem'] = 'esx:removeInventoryItem',		-- Default: 'esx:removeInventoryItem'
	['setAccountMoney'] = 'esx:setAccountMoney',				-- Default: 'esx:setAccountMoney'

	-- สำหรับ essentialmode (es_extended 1.1) * ไม่จำเป็นต้องแก้ไขส่วนนี้
	['addedMoney'] = 'es:addedMoney',							-- Default: 'es:addedMoney'
	['removedMoney'] = 'es:removedMoney'						-- Default: 'es:removedMoney'
}

Config.Debug = false								-- Debug Mode
Config.OpenVaultOnDead = false					-- สามารถเปิดตู้เซฟขณะตายได้

Config.SavingDataType = 0						-- ใช้การบันทึกข้อมูลต่างๆใน Database [ 0: บันทึกข้อมูลทุกครั้งที่มีการเปลี่ยนแปลงสิ่งของ | 1: บันทึกข้อมูลทุกครั้งที่ผู้เล่นคนสุดท้ายออกจากตู้เซฟ | 2: บันทึกข้อมูลทุกครั้งที่ผู้เล่นคนสุดท้ายออกเกม ]
Config.SaveInterval = 15						-- เวลาในการบันทึกข้อมูลตู้เซฟทุกๆ xx นาที (หน่วยเป็นนาที) *ระบบนี้จะทำงานเมื่อตั้งค่า Config.SavingDataType เป็น 1 หรือ 2 เท่านั้น

Config.VaultNameTagLength = 4					-- จำนวนตัวอักษรของชื่อ NameTag (สามารถตั้งค่าได้ 3-6 ตัว) | Default: 4

Config.HUD = {
	scale = 1.0,								-- ขนาดของ UI
	content_scale = 1.0,						-- ขนาดของเนื้อหา
	border_radius_scale = 1.0,					-- ความโค้งมนของขอบ
	timing_factor = 1.0,						-- ตัวคูณความเร็วของ Animation ต่างๆ (1.0 คือค่าปกติ | 0.0 คือเร็วที่สุด)
	colors = {
		base = { r = 255, g = 204, b = 0 },			-- สีหลัก
		content = { r = 0, g = 0, b = 0 },			-- สีของเนื้อหา
		vault = { r = 25, g = 25, b = 25 },				-- สีพื้นหลัง
		confirm_button = { r = 255, g = 204, b = 0 }	-- สีปุ่มยืนยัน
	}
}

Config.Keys = {
	use_keybindings = false,				-- เปิดใช้งานระบบ Key Bindings
	default = {								-- ปุ่มแบบ FiveM Default
		open = 38,							-- ปุ่ม เปิด ตู้เซฟส่วนตัว (ปุ่มปิดตู้เซฟจะเป็น Esc ไม่สามารถแก้ไขได้)
		selectors = {						-- ปุ่มสำหรับเลือกผู้เล่นรอบข้าง (ไม่ควรแก้ไข)
			[1] = 157,
			[2] = 158,
			[3] = 160,
			[4] = 164,
			[5] = 165,
			[6] = 159,
			[7] = 161,
			[8] = 162,
			[9] = 163
		},
		reroll = 22							-- ปุ่ม Reroll คนรอบข้างสำหรับแชร์ตู้เซฟ
	},
	keybindings = {
		open = 'E',							-- ปุ่ม เปิด ตู้เซฟส่วนตัว (ปุ่มปิดตู้เซฟจะเป็น Esc ไม่สามารถแก้ไขได้)
		selectors = {						-- ปุ่มสำหรับเลือกผู้เล่นรอบข้าง (ไม่ควรแก้ไข)
			[1] = '1',
			[2] = '2',
			[3] = '3',
			[4] = '4',
			[5] = '5',
			[6] = '6',
			[7] = '7',
			[8] = '8',
			[9] = '9'
		},
		reroll = 'SPACE'					-- ปุ่ม Reroll คนรอบข้างสำหรับแชร์ตู้เซฟ
	}
}

Config.CustomTitleFont = {						-- Font ของ Text ของตู้เซฟ
	enable = false,
	name = 'font4thai',							-- Default: '$Font2_cond'
	scale = 1.0
}

Config.OnSharing = {
	font = {									-- Font ของ Text บนศีรษะผู้เล่น
		name = 'font4thai',						-- Default: '$Font2_cond'
		scale = 1.0
	},
	head_offset = 0.3,							-- ระยะ Text บนหัวผู้เล่น
	max_players = 5,							-- จำนวนผู้เล่นที่แสดงรอบข้างขณะแชร์ตู้เซฟ (1-9)
	distance = 5.0,								-- ระยะคนที่อยู่รอบข้างที่สามารถแชร์ตู้เซฟได้
	enable_control = {							-- อนุญาตปุ่มกดขณะเลือกคนที่ต้องการจะแชร์ตู้เซฟ
		249,		-- N
	}
}

-- คำสั่งต่างๆได้ของ Admin
Config.AdminCommands = {
	open = 'openvault',							-- คำสั่งเปิตตู้เซฟด้วยหมายเลขตู้	 /openvault [vaultId]
	remove = 'removevault',						-- คำสั่งลบตู้เซฟด้วยหมายเลขตู้		/removevault [vaultId]
	change_owner = 'changeowner'				-- คำสั่งเปลี่ยนแปลงเจ้าของตู้เซฟ	/changeowner [vaultId] [playerId|identifier]	* playerId: เลข ID ผู้เล่น (ผู้เล่นต้องอยู่ในเกม) | identifier: Identifier ของผู้ที่ต้องการจะให้เป็นเจ้าของตู้เซฟใหม่
}

-- กลุ่ม Administrator (กลุ่มสามารถใช้งานคำสั่งต่างๆได้)
Config.AdminGroups = {
	'admin',
	'superadmin'
}


-- เพิ่มเติม .. หากต้องการ Block ปุ่มกด ให้ใช้คำสั่งดังนี้ (true: Block | false: ยกเลิก Block)
-- exports.nc_vault:BlockKey({ 'KEYS', ... }, true)

-- ตัวอย่างการใช้งาน Block ไม่ให้เปิดตู้เซฟ
-- exports.nc_vault:BlockKey({ 'E' }, true)

-- ตัวอย่างการยกเลิก Block ปุ่ม ให้กลับมาใช้งานได้ดังเดิม
-- exports.nc_vault:BlockKey({ 'E' }, false)

-- ตัวอย่างการ Block ปุ่ม หลายปุ่มในคำสั่งเดียว ให้กลับมาใช้งานได้ดังเดิม
-- exports.nc_vault:BlockKey({ 'E' }, true)

-- * ในกรณี Resource นี้ จะมีแค่ 1 ปุ่มเท่านั้น (E)


-- สำคัญ! กรุณาเพิ่ม TriggerEvent ด้านล่างลงใน function self.setName ในไฟล์ es_extended/classes/player.lua
-- ตัวอย่างการเพิ่ม TriggerEvent -> TriggerEvent('nc:setPlayerName', self.source, self.name)
--[[
	self.setName = function(newName)
		self.name = newName
		TriggerEvent('nc:setPlayerName', self.source, self.name)
	end
]]