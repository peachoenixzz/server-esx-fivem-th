-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config = {}

Config.EventRoute = {
	['getSharedObject'] = 'esx:getSharedObject',			-- Default: 'esx:getSharedObject' *รองรับการใส่ชื่อ Event และ Function (exports.es_extended.getSharedObject)
	['playerLoaded'] = 'esx:playerLoaded',					-- Default: 'esx:playerLoaded'
	['playerDropped'] = 'esx:playerDropped',				-- Default: 'esx:playerDropped'
	['onPlayerDeath'] = 'esx:onPlayerDeath',				-- Default: 'esx:onPlayerDeath'
	['onPlayerSpawn'] = 'playerSpawned',					-- Default: 'esx:onPlayerSpawn'
	['setJob'] = 'esx:setJob',								-- Default: 'esx:setJob'
	['addInventoryItem'] = 'esx:addInventoryItem',			-- Default: 'esx:addInventoryItem'
	['removeInventoryItem'] = 'esx:removeInventoryItem',	-- Default: 'esx:removeInventoryItem'
	['setAccountMoney'] = 'esx:setAccountMoney',			-- Default: 'esx:setAccountMoney'

	-- สำหรับ essentialmode (es_extended 1.1) * ไม่จำเป็นต้องแก้ไขส่วนนี้
	['addedMoney'] = 'es:addedMoney',						-- Default: 'es:addedMoney'
	['removedMoney'] = 'es:removedMoney'					-- Default: 'es:removedMoney'
}

Config.Debug = false							-- Debug Mode
Config.DeveloperMode = false			-- แสดงรัสมีขณะตั้งค่า

Config.AntiSpam = 1000						-- ระยะเวลาป้องการการ Spam กดขโมยสิ่งของ (1000 = 1 วินาที)

Config.UseNativeGetObjects = true			-- ใช้ Native Functions ในการตรวจสอบ Objects (เพื่อลดอาการหน่วง)
Config.DeleteEntityOnBlocked = true			-- ลบ Prop นั้นๆเมื่ออยู่ใน Blocked Zone

Config.CustomUpdatePoliceCount = false		-- ใช้งานการนับจำนวนตำรวจด้วยตนเอง (จำเป็นจะต้องใช้ exports.nc_stealjobs:SetPolice() ในการกำหนดจำนวนตำรวจในเมือง)

Config.TurnToEntity = true					-- หมุนตัวไปหาสิ่งของนั้นๆก่อนขโมย (ใช้เวลาประมาณ 1.5 วินาที)

Config.Keys = {
	use_keybindings = false,				-- เปิดใช้งานระบบ Key Bindings
	default = {								-- ปุ่มแบบ FiveM Default
		steal = 38							-- ปุ่ม ขโมย
	},
	keybindings = {
		steal = 'E'							-- ปุ่ม ขโมย
	}
}

Config.CustomFont = {
	enable = true,
	name = 'font4thai',						-- Default: '$Font2_cond'
	scale = 1.0
}


-- เพิ่มเติม .. หากต้องการ Block ปุ่มกด ให้ใช้คำสั่งดังนี้ (true: Block | false: ยกเลิก Block)
-- exports.nc_stealjobs:BlockKey({ 'KEYS', ... }, true)

-- ตัวอย่างการใช้งาน Block ไม่ให้ขโมย
-- exports.nc_stealjobs:BlockKey({ 'E' }, true)

-- ตัวอย่างการยกเลิก Block ปุ่ม ให้กลับมาใช้งานได้ดังเดิม
-- exports.nc_stealjobs:BlockKey({ 'E' }, false)

-- * ในกรณี Resource นี้ จะมีแค่ 1 ปุ่มเท่านั้น (E)