-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config = {}

Config.EventRoute = {
	['getSharedObject'] = 'esx:getSharedObject',		-- Default: 'esx:getSharedObject'
	['playerLoaded'] = 'esx:playerLoaded',				-- Default: 'esx:playerLoaded'
	['playerDropped'] = 'esx:playerDropped',			-- Default: 'esx:playerDropped'
	['onPlayerDeath'] = 'esx:onPlayerDeath',			-- Default: 'esx:onPlayerDeath'
	['onPlayerSpawn'] = 'playerSpawned',				-- Default: 'esx:onPlayerSpawn'
	['setJob'] = 'esx:setJob'							-- Default: 'esx:setJob'
}

Config.RealtimeUpdate = false							-- ใช้ระบบอัพเดทแบบ Realtime
-- * ระบบการอัพเดทแบบ Realtime เกิดอาการหน่วงได้เมื่อมีการใช้ Loop GetActivePlayers (หรือการ Loop ผู้เล่นรอบข้าง)
-- หากเกิดอาการหน่วงจากการ Loop ผู้เล่น แนะนำให้ปิดการใช้งานโหมดนี้ (อาการหน่วงอาจจะเกิดได้แค่หน่วยงานที่มีการแสดง Blip เท่านั้น!)

Config.JobSquads = {
	--		['jobName'] = {								-- ชื่ออาชีพ
	--			label = '[LABEL]',						-- ชื่อย่อชื่อของ Squads
	-- 			show_name = true|false,					-- เปิด/ปิด แสดงชื่อผู้เล่น
	--			blip = {								-- Blip
	--				sprite = 1,					-- รูปแบบของ Blip
	--				scale = 1.0,				-- ขนาดของ Blip
	--				color = 0,					-- สีของ Blip
	-- 				show_cone = true|false		-- เปิด/ปิด แสดงการหันหน้า
	--			},
	-- 			dead_blip = {							-- Blip ของคนหมดสติ
	-- 				enable = true|false,		-- เปิดใช้งาน Blip ของคนหมดสติ
	-- 				sprite = 84,				-- รูปแบบของ Blip
	-- 				scale = 1.0,				-- ขนาดของ Blip
	-- 				color = 0					-- สีของ Blip
	-- 			},
	-- 			show_blip_on_dead = true|false,			-- แสดง Blip เมื่อผู้เล่นหมดสติ
	--			server_update = 500,					-- ระยะเวลาการอัพเดทข้อมูลฝั่ง Server *ไม่มีผลหากตั้งค่า Config.RealtimeUpdate = true
	--			client_update = 500						-- ระยะเวลาการอัพเดทข้อมูลฝั่ง Client
	--		},
	['police'] = {
		label = '[MKGOV]',
		show_name = true,
		blip = {
			sprite = 1,
			scale = 1.0,
			color = 5,
			show_cone = true
		},
		dead_blip = {
			enable = true,
			sprite = 484,
			scale = 1.0,
			color = 5
		},
		show_blip_on_dead = true,
		server_update = 1500,
		client_update = 1000
	},
	--['ambulance'] = {
	--	label = '[MED]',
	--	show_name = true,
	--	blip = {
	--		sprite = 1,
	--		scale = 1.0,
	--		color = 8,
	--		show_cone = true
	--	},
	--	dead_blip = {
	--		enable = true,
	--		sprite = 484,
	--		scale = 1.0,
	--		color = 8
	--	},
	--	show_blip_on_dead = true,
	--	server_update = 500,
	--	client_update = 500
	--},
	-- ['mechanic'] = {
	-- 	label = '[MEC]',
	-- 	show_name = true,
	-- 	blip = {
	-- 		sprite = 1,
	-- 		scale = 1.0,
	-- 		color = 22,
	-- 		show_cone = true
	-- 	},
	-- 	dead_blip = {
	-- 		enable = true,
	-- 		sprite = 84,
	-- 		scale = 1.0,
	-- 		color = 22
	-- 	},
	-- 	show_blip_on_dead = true,
	-- 	server_update = 500,
	-- 	client_update = 500
	-- },
}

Config.CustomSquads = {
	--		['squadName'] = {									-- ชื่อ Squads
	--			label = '[LABEL]',						-- ชื่อย่อชื่อของ Squads
	-- 			show_name = true|false,					-- เปิด/ปิด แสดงชื่อผู้เล่น
	--			blip = {								-- Blip
	--				sprite = 1,						-- รูปแบบของ Blip
	--				scale = 1.0,					-- ขนาดของ Blip
	--				color = 0,						-- สีของ Blip
	-- 				show_cone = true|false			-- เปิด/ปิด แสดงการหันหน้า
	--			},
	-- 			dead_blip = {							-- Blip ของคนหมดสติ
	-- 				enable = true|false,			-- เปิดใช้งาน Blip ของคนหมดสติ
	-- 				sprite = 84,					-- รูปแบบของ Blip
	-- 				scale = 1.0,					-- ขนาดของ Blip
	-- 				color = 0						-- สีของ Blip
	-- 			},
	-- 			show_blip_on_dead = true|false,			-- แสดง Blip เมื่อผู้เล่นหมดสติ
	--			server_update = 500,					-- ระยะเวลาการอัพเดทข้อมูลฝั่ง Server *ไม่มีผลหากตั้งค่า Config.RealtimeUpdate = true
	--			client_update = 500						-- ระยะเวลาการอัพเดทข้อมูลฝั่ง Client
	--		},
	['gang1'] = {
		label = '[GANG1]',
		show_name = true,
		blip = {
			sprite = 1,
			scale = 1.0,
			color = 1,
			show_cone = true
		},
		dead_blip = {
			enable = true,
			sprite = 84,
			scale = 1.0,
			color = 1
		},
		show_blip_on_dead = true,
		server_update = 500,
		client_update = 500
	},
}