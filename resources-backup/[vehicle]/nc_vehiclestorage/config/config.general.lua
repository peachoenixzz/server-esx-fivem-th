-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config = { Storages = { Global = {}, Classes = {}, Models = {}, Plates = {} } }

Config.EventRoute = {
	['getSharedObject'] = exports.es_extended.getSharedObject,	-- Default: 'esx:getSharedObject' *รองรับการใส่ชื่อ Event และ Function
	['playerLoaded'] = 'esx:playerLoaded',						-- Default: 'esx:playerLoaded'
	['playerDropped'] = 'esx:playerDropped',					-- Default: 'esx:playerDropped'
	['onPlayerDeath'] = 'esx:onPlayerDeath',					-- Default: 'esx:onPlayerDeath'
	['onPlayerSpawn'] = 'playerSpawned'							-- Default: 'esx:onPlayerSpawn'
}

-- คำสั่งเปิด Debug Mode Dev		/vehiclestorage debug
-- คำสั่งเปิด Developer Mode เพื่อแสดงระยะของช่องเก็บของท้ายรถ (Trunk)		/vehiclestorage dev	*จำเป็นต้องเปิด Debug Mode Dev ก่อน

Config.Debug = false									-- Debug ข้อความต่างๆ

Config.OpenVehicleStorageOnDead = false				-- สามารถเปิดช่องเก็บของยานพาหนะขณะตายได้

Config.PreloadVehiclesStorages = false				-- โหลดข้อมูลยานพาหนะมาเก็บไว้ในตัวสคริปต์ก่อน (อาจจะมีการใช้งาน RAM สูงขึ้น)

Config.AutoDeleteStorageNoVehicleData = true		-- ลบข้อมูลช่องเก็บของยานพาหนะเมื่อ "ไม่พบ" ข้อมูลยานพาหานะใน Database (owned_vehicles)

Config.DeleteStorageOnRemoveVehicle = false			-- ลบข้อมูลช่องเก็บของยานพาหนะเมื่อใช้ Export Function RemoveVehicle

Config.SavingDataType = 0							-- ใช้การบันทึกข้อมูลต่างๆใน Database [ 0: บันทึกข้อมูลทุกครั้งที่มีการเปลี่ยนแปลงสิ่งของ | 1: บันทึกข้อมูลทุกครั้งที่ผู้เล่นคนสุดท้ายออกจากช่องเก็บของยานพาหนะ ]
Config.SaveInterval = 0							-- เวลาในการบันทึกข้อมูลช่องเก็บของยานพาหนะทุกๆ xx นาที (หน่วยเป็นนาที) *ระบบนี้จะทำงานเมื่อตั้งค่า Config.SavingDataType เป็น 1 เท่านั้น

Config.Keys = {
	use_keybindings = false,				-- เปิดใช้งานระบบ Key Bindings
	default = {								-- ปุ่มแบบ FiveM Default
		open = 74,							-- ปุ่ม เปิด ช่องเก็บของยานพาหนะ (ปุ่มปิดช่องเก็บของยานพาหนะจะเป็น Esc ไม่สามารถแก้ไขได้)
	},
	keybindings = {
		open = 'H'							-- ปุ่ม เปิด ช่องเก็บของยานพาหนะ (ปุ่มปิดช่องเก็บของยานพาหนะจะเป็น Esc ไม่สามารถแก้ไขได้)
	}
}

-- คำสั่งต่างๆได้ของ Admin
Config.AdminCommands = {
	open = 'openstorage',			-- คำสั่งเปิดช่องเก็บของยานพาหนะด้วยหมายเลขตู้		/openstorage [inside|trunk] [plate]
	saveall = 'saveallstorage'		-- คำสั่งบันทึกข้อมูลช่องเก็บของยานพาหนะทั้งหมด
}

-- กลุ่ม Administrator (กลุ่มสามารถใช้งานคำสั่งต่างๆได้)
Config.AdminGroups = {
	'admin',
	'superadmin'
}
Config.AllowAdminsToOpenVehicleStorage = true


-- เพิ่มเติม .. หากต้องการ Block ปุ่มกด ให้ใช้คำสั่งดังนี้ (true: Block | false: ยกเลิก Block)
-- exports.nc_vehiclestorage:BlockKey({ 'KEYS', ... }, true)

-- ตัวอย่างการใช้งาน Block ไม่ให้เปิดช่องเก็บของยานพาหนะ
-- exports.nc_vehiclestorage:BlockKey({ 'L' }, true)

-- ตัวอย่างการยกเลิก Block ปุ่ม ให้กลับมาใช้งานได้ดังเดิม
-- exports.nc_vehiclestorage:BlockKey({ 'L' }, false)

-- ตัวอย่างการ Block ปุ่ม หลายปุ่มในคำสั่งเดียว ให้กลับมาใช้งานได้ดังเดิม
-- exports.nc_vehiclestorage:BlockKey({ 'L' }, true)

-- * ในกรณี Resource นี้ จะมีแค่ 1 ปุ่มเท่านั้น (L)