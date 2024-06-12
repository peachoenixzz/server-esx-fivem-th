-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config = { Punishing = {} }

Config.EventRoute = {
	['getSharedObject'] = 'esx:getSharedObject',				-- Default: 'esx:getSharedObject'
	['playerLoaded'] = 'esx:playerLoaded',						-- Default: 'esx:playerLoaded'
	['playerDropped'] = 'esx:playerDropped'						-- Default: 'esx:playerDropped'
}

Config.Debug = true							-- Debug Mode

Config.UseResourceManagement = true			-- ใช้งานระบบบริหารจัดการรับส่งข้อมูล C>S (หากไม่ได้รับคำแนะนำจาก NC Developer ไม่ควรแก้ไขส่วนนี้)

-- เปิดใช้งานกัรโปรคู่กับสคริปต์ที่ใช้งาน Escrow Protection
-- * หากเปิดใช้งาน Config.AllowEscrowProtection = true ระบบอาจจะไม่ป้องกันการ Inject เมนูโปรบางตัว แต่การป้องกันอื่นๆยังปกติ
Config.AllowEscrowProtection = true

-- Resources ที่ไม่ต้องการให้ตรวจสอบ (แนะนำให้ใส่ Resource ที่ใช้งาน Escrow Protection ของ FiveM)
-- * หากเปิดใช้งาน Config.AllowEscrowProtection = true ไม่จำเป็นต้องนำชื่อสคริปต์มาใส่ในส่วนนี้
-- ** ไม่จำเป็นไม่ต้องใส่ชื่อสคริปต์ในส่วนนี้ เพราะอาจจะเป็นการเปิดช่องโหว่ให้โปรได้
Config.NotValidateResources = {
	-- ใส่ชื่อทรัพยากรที่นี่

	-- 'rcore_guidebook',
}