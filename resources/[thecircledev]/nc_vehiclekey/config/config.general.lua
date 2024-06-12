-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config = {}

Config.EventRoute = {
	['getSharedObject'] = 'esx:getSharedObject',	-- Default: 'esx:getSharedObject' *รองรับการใส่ชื่อ Event และ Function (exports.es_extended.getSharedObject)
	['playerLoaded'] = 'esx:playerLoaded',			-- Default: 'esx:playerLoaded'
	['playerDropped'] = 'esx:playerDropped',		-- Default: 'esx:playerDropped'
	['onPlayerDeath'] = 'esx:onPlayerDeath',		-- Default: 'esx:onPlayerDeath'
	['onPlayerSpawn'] = 'playerSpawned'				-- Default: 'esx:onPlayerSpawn'
}

Config.AntiSpam = 500

Config.SyncMode = 0			-- Logic ในการ Sync ข้อมูล (0, 1) *หากตั้งค่าเป็น 0 แล้วพบปัญหาให้ตั้งค่าเป็น 1 แทน

Config.LockPlayerInsideLockedVehicle = false		-- ห้ามไม่ให้ผู้เล่นออกจากยานพาหนะ เมื่ออยู่ในยานพาหนะที่ถูกล็อคอยู่

Config.ActionDistance = 15.0						-- ระยะการ ล็อค/ปลด ล็อคยานพาหนะ

Config.EnableSoundOnlyOwner = false				-- เปิดใช้งานการได้ยินเสียง ล็อค/ปลดล็อค ยานพาหนะแค่เจ้าของยานพาหนะ
Config.Enable3DSound = true						-- เปิดใช้งานการได้ยินเสียง ล็อค/ปลดล็อค ยานพาหนะตามระยะ
Config.SoundMaxRadius = 6.0						-- ระยะไกลที่สุดที่จะได้ยินเสียง ล็อค/ปลดล็อค ยานพาหนะ
Config.SoundMaxVolume = {						-- ความดังของเสียง ล็อค/ปลดล็อค ยานพาหนะ (0 - 100)
	lock = 80,
	unlock = 80
}

Config.Keys = {
	enable = true,
	use_keybindings = true,					-- เปิดใช้งานระบบ Key Bindings
	default = {								-- ปุ่มแบบ FiveM Default
		action = 182,						-- ปุ่ม ล็อค/ปลดล็อค ยานพาหนะ
	},
	keybindings = {
		action = 'L'						-- ปุ่ม ล็อค/ปลดล็อค ยานพาหนะ
	}
}

-- เพิ่มเติม .. หากต้องการ Block ปุ่มกด ให้ใช้คำสั่งดังนี้ (true: Block | false: ยกเลิก Block)
-- exports.nc_vehiclekey:BlockKey({ 'KEYS', ... }, true)

-- ตัวอย่างการใช้งาน Block ไม่ให้เปิดช่องเก็บของยานพาหนะ
-- exports.nc_vehiclekey:BlockKey({ 'U' }, true)

-- ตัวอย่างการยกเลิก Block ปุ่ม ให้กลับมาใช้งานได้ดังเดิม
-- exports.nc_vehiclekey:BlockKey({ 'U' }, false)

-- ตัวอย่างการ Block ปุ่ม หลายปุ่มในคำสั่งเดียว ให้กลับมาใช้งานได้ดังเดิม
-- exports.nc_vehiclekey:BlockKey({ 'U' }, true)

-- * ในกรณี Resource นี้ จะมีแค่ 1 ปุ่มเท่านั้น (U)