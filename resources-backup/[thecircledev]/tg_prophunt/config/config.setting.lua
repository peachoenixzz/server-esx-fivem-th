-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

Config = Config or {}

Config.MissingShot = 3		-- จำนวนเลือดที่จะลดเมื่อยิงไม่โดน Prop 

Config.StartEvent = {
	command = 'prophunt',		-- คำสั่งเริ่มกิจกรรม (ตัวอย่างการใช้งาน /prophunt ไอดีของกิจกรรม)
	permission = true		-- เปิดให้เฉพาะแอดมินใช้คำสั่งได้หรือไม่
}

-- * ไม่รองรับแมพ MLO เพราะอาจจะทำให้ CheckHeight ไม่ได้และแปลงร่างไม่ติด *
Config.Map = {
	['house_1'] = {	-- ชื่อแมพ
		Coords = vector3(2376.1201171875, 3113.639892578125, 48.04999923706055),		-- พิกัดจุดตรงกลางของแมพ
		HunterSpawner = vector3(2438.06005859375, 3111.139892578125, 47.97999954223633),		-- พิกัดจุดเกิด Hunter
		PropSpawner = vector3(2402.179931640625, 3107.35009765625, 48.29999923706055),		-- พิกัดจุดเกิด Prop
		Radius = 70.0,		-- รัศมีในการเล่นของแมพ
		Marker = {r = 95, g = 187, b = 230, a = 100},		-- สีและความทึบแสงของ Marker
		CheckHeight = {45.0, 47.0, 48.0, 52.0, 53.0},		-- เช็คความสูง (แนะนำให้ตั้งให้ตรงพิกัด Z ที่ตั้งไว้ใน Coords และ +- 5 จากพิกัด Z)
	},
} 

Config.Event = {
	[1] = {		-- ไอดีของกิจกรรม
		Gameplay = {
			hunter_weapon = 'WEAPON_HEAVYRIFLE',		-- ชื่ออาวุธที่ Hunter จะได้รับ
			hunter_weapon_ammo = 210,		-- จำนวนกระสุนที่ Hunter จะได้รับ
			map = 'house_1',		-- ชื่อแมพจาก Config.Map
			player_min = 10,		-- จำนวนผู้เล่นขั้นต่ำ (ห้ามต่ำกว่า 2 คน)
			player_max = 30,		-- จำนวนผู้เล่นสูงสุด
			player_hunter = 7 ,		-- จำนวนคนหาต่อรอบ (ผู้เล่นที่เหลือจะเป็นคนซ่อนทั้งหมด)
			round_limit = 2,		-- จำนวนรอบที่จะเล่น

			time = {
				start = 2,		-- เวลารอผู้เล่นเข้าร่วมกิจกรรม (หน่วยเป็นนาที)
				hide = 1,		-- เวลาในการซ่อน (หน่วยเป็นนาที)
				in_game = 8,		-- เวลาในการเล่นของรอบนั้นๆ (หน่วยเป็นนาที)
				next_round = 10,		-- เวลารอรอบต่อไป (หน่วยเป็นวินาที)
			},
		},

		StartTime = {
			hour = 14,		-- เวลาที่จะให้เริ่มกิจกรรมอัตโนมัติ (ชั่วโมง)
			minute = 00		-- เวลาที่จะให้เริ่มกิจกรรมอัตโนมัติ (นาที)
		},

		BlacklistProp = {
			'prop_bin_01a',		-- ชื่อสิ่งของที่ไม่ต้องการให้แปลงร่างได้
		},

		Reward = {
			Hunter = {		-- รางวัลของ Hunter / รอบ
				[1] = { 
					type = 'black_money',		-- ประเภทของรางวัล (item = ไอเทม / money = เงินสด / black_money = เงินแดง)
					count = 1000,		-- จำนวน
					percent = 100		-- เปอร์เซ็นต์
				},
				[2] = {
					type = 'item',		-- ประเภทของรางวัล (item = ไอเทม / money = เงินสด / black_money = เงินแดง)
					name = 'cron',		-- ชื่อไอเทม
					count = 2,		-- จำนวน
					percent = 25		-- เปอร์เซ็นต์
				},
			},
			Prop = {		-- รางวัลของ Prop / รอบ
				[1] = { 
					type = 'black_money',		-- ประเภทของรางวัล (item = ไอเทม / money = เงินสด / black_money = เงินแดง)
					count = 1000,		-- จำนวน
					percent = 100		-- เปอร์เซ็นต์
				},
				[2] = {
					type = 'item',		-- ประเภทของรางวัล (item = ไอเทม / money = เงินสด / black_money = เงินแดง)
					name = 'cron',		-- ชื่อไอเทม
					count = 2,		-- จำนวน
					percent = 25		-- เปอร์เซ็นต์
				},
			},
		},
	},
}