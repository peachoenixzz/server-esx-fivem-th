-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

Config = Config or {}

Config.Setup = {
	Items = {
		Krathong = {
			Name = 'lkt_krathong',		-- ชื่อไอเทมกระทง
			Remove = true		-- เปิดให้ลบไอเทมเมื่อลอยกระทงหรือไม่
		},
		Lantern = {
			Name = 'lkt_balloon',		-- ชื่อไอเทมโคมลอย
			Remove = true		-- เปิดให้ลบไอเทมเมื่อลอยโคมหรือไม่
		},
		SmallFirework = {
			Name = 'firework_1',		-- ชื่อไอเทมพลุอันเดียว	 
			Remove = true		-- เปิดให้ลบไอเทมเมื่อใช้พลุอันเดียวหรือไม่
		},	
		BigFirework = {
			Name = 'firework_2',		-- ชื่อไอเทมพลุหลายอัน
			Remove = true		-- เปิดให้ลบไอเทมเมื่อใช้พลุหลายอันหรือไม่
		}
	},
	Props = {
		Krathong = {
			Name = "prop_krathong_01"		-- ชื่อ Prop กระทง
		},
		Larntern = {
			Name = "prop_krathong_04"		-- ชื่อ Prop โคมลอย
		},
		SmallFirework = {
			Name = "ind_prop_firework_01"		-- ชื่อ Prop พลุอันเดียว
		},
		BigFirework = {
			Name = "ind_prop_firework_03"		-- ชื่อ Prop พลุหลายอัน
		}
	},
	Animation = {
		Krathong = {		-- กระทง
			AnimationDict = "amb@world_human_guard_patrol@male@idle_b",		-- ชื่ออนิเมชั่นในการทำงาน (AnimationDict และ AnimationName เชื่อมกัน เพราะฉนั้นใส่ให้ถูกต้องทั้งสองอย่าง)
			AnimationName = "idle_e",		-- ชื่ออนิเมชั่นในการทำงาน (AnimationDict และ AnimationName เชื่อมกัน เพราะฉนั้นใส่ให้ถูกต้องทั้งสองอย่าง)
		},
		CollectKrathong = {		-- เก็บกระทง
			AnimationDict = "amb@world_human_bum_wash@male@high@base",		-- ชื่ออนิเมชั่นในการทำงาน (AnimationDict และ AnimationName เชื่อมกัน เพราะฉนั้นใส่ให้ถูกต้องทั้งสองอย่าง)
			AnimationName = "base",		-- ชื่ออนิเมชั่นในการทำงาน (AnimationDict และ AnimationName เชื่อมกัน เพราะฉนั้นใส่ให้ถูกต้องทั้งสองอย่าง)
		},
		Larntern = {		-- โคมลอย
			AnimationDict = "anim@heists@box_carry@",		-- ชื่ออนิเมชั่นในการทำงาน (AnimationDict และ AnimationName เชื่อมกัน เพราะฉนั้นใส่ให้ถูกต้องทั้งสองอย่าง)
			AnimationName = "idle",		-- ชื่ออนิเมชั่นในการทำงาน (AnimationDict และ AnimationName เชื่อมกัน เพราะฉนั้นใส่ให้ถูกต้องทั้งสองอย่าง)
		},
		SmallFirework = {		-- พลุอันเดียว
			AnimationDict = "anim@mp_fireworks",		-- ชื่ออนิเมชั่นในการทำงาน (AnimationDict และ AnimationName เชื่อมกัน เพราะฉนั้นใส่ให้ถูกต้องทั้งสองอย่าง)
			AnimationName = "place_firework_1_rocket",		-- ชื่ออนิเมชั่นในการทำงาน (AnimationDict และ AnimationName เชื่อมกัน เพราะฉนั้นใส่ให้ถูกต้องทั้งสองอย่าง)
		},
		BigFirework = {		-- พลุหลายอัน
			AnimationDict = "anim@mp_fireworks",		-- ชื่ออนิเมชั่นในการทำงาน (AnimationDict และ AnimationName เชื่อมกัน เพราะฉนั้นใส่ให้ถูกต้องทั้งสองอย่าง)
			AnimationName = "place_firework_3_box",		-- ชื่ออนิเมชั่นในการทำงาน (AnimationDict และ AnimationName เชื่อมกัน เพราะฉนั้นใส่ให้ถูกต้องทั้งสองอย่าง)
		}
	}
}

Config.Krathong = {
	[1] = {
		Coords = vector3(-780.3099975585938, -1500.6199951171875, 1.35000002384185),		-- พิกัดจุดลอยกระทง
		Heading = 110.0,		-- ทิศทางหันหน้าเมื่อกดลอยกระทง
		Duration = 8,		-- ระยะเวลาลอยกระทง
		RemoveTime = 30,		-- ระยะเวลาที่กระทงจะลอยไปยังจุด Config.KrathongEndCoords
	},
	[2] = {
		Coords = vector3(-783.0900268554688, -1493.7099609375, 1.30999994277954),		-- พิกัดจุดลอยกระทง
		Heading = 110.0,		-- ทิศทางหันหน้าเมื่อกดลอยกระทง
		Duration = 8,		-- ระยะเวลาลอยกระทง
		RemoveTime = 30,		-- ระยะเวลาที่กระทงจะลอยไปยังจุด Config.KrathongEndCoords และหายไป
	},
	[3] = {
		Coords = vector3(-781.6500244140625, -1497.239990234375, 1.33000004291534),		-- พิกัดจุดลอยกระทง
		Heading = 110.0,		-- ทิศทางหันหน้าเมื่อกดลอยกระทง
		Duration = 8,		-- ระยะเวลาลอยกระทง
		RemoveTime = 30,		-- ระยะเวลาที่กระทงจะลอยไปยังจุด Config.KrathongEndCoords และหายไป
	},
	[4] = {
		Coords = vector3(-786.3300170898438, -1484.18994140625, 1.3400000333786),		-- พิกัดจุดลอยกระทง
		Heading = 110.0,		-- ทิศทางหันหน้าเมื่อกดลอยกระทง
		Duration = 8,		-- ระยะเวลาลอยกระทง
		RemoveTime = 30,		-- ระยะเวลาที่กระทงจะลอยไปยังจุด Config.KrathongEndCoords และหายไป
	},
	[5] = {
		Coords = vector3(-777.0800170898438, -1509.989990234375, 1.32000005245208),		-- พิกัดจุดลอยกระทง
		Heading = 109.0,		-- ทิศทางหันหน้าเมื่อกดลอยกระทง
		Duration = 8,		-- ระยะเวลาลอยกระทง
		RemoveTime = 30,		-- ระยะเวลาที่กระทงจะลอยไปยังจุด Config.KrathongEndCoords และหายไป
	},
}

Config.KrathongEndCoords = vector3(-859.8099975585938, -1528.75, 0.0)		-- จุดที่กระทงจะลอยไป

Config.Lantern = {
	Duration = 8,		-- ระยะเวลาลอยโคม
	RemoveTime = 30,		-- ระยะเวลาที่โคมจะลอยและหายไป
}

Config.Reward = {

	-- Krathong
	-- [1] = {
	-- 	Type = 'krathong',		-- ของรางวัลสำหรับ (krathong = กระทง / lantern = โคมลอย / collect_krathong = เก็บกระทง)
	-- 	RewardType = 'item',		-- ประเภทของรางวัล (item = ไอเทม / money = เงิน / blackmoney = เงินแดง)
	-- 	ItemName = 'water',		-- ชื่อไอเทมที่จะได้รับ
	-- 	ItemCount = 1,		-- จำนวนไอเทมที่จะได้รับ

	-- 	ItemBonus = {
	-- 		[1] = {
	-- 			Name = 'gold',		-- ชื่อไอเทมโบนัสที่จะได้รับ
	-- 			Count = 1,		-- จำนวนไอเทมโบนัสที่จะได้รับ
	-- 			Percent = 100		-- เปอร์เซ็นต์ที่จะได้รับ
	-- 		},
	-- 		[2] = {
	-- 			Name = 'diamond',		-- ชื่อไอเทมโบนัสที่จะได้รับ
	-- 			Count = 1,		-- จำนวนไอเทมโบนัสที่จะได้รับ
	-- 			Percent = 50		-- เปอร์เซ็นต์ที่จะได้รับ
	-- 		},
	-- 	}
	-- },
	-- [2] = {
	-- 	Type = 'krathong',		-- ของรางวัลสำหรับ (krathong = กระทง / lantern = โคมลอย / collect_krathong = เก็บกระทง)
	-- 	RewardType = 'money',		-- ประเภทของรางวัล (item = ไอเทม / money = เงิน / blackmoney = เงินแดง)
	-- 	Count = 1000		-- จำนวนเงินที่จะได้รับ
	-- },
	-- [3] = {
	-- 	Type = 'krathong',		-- ของรางวัลสำหรับ (krathong = กระทง / lantern = โคมลอย / collect_krathong = เก็บกระทง)
	-- 	RewardType = 'blackmoney',		-- ประเภทของรางวัล (item = ไอเทม / money = เงิน / blackmoney = เงินแดง)
	-- 	Count = 1000		-- จำนวนเงินที่จะได้รับ
	-- },

	-- Lantern
	-- [4] = {
	-- 	Type = 'lantern',		-- ของรางวัลสำหรับ (krathong = กระทง / lantern = โคมลอย / collect_krathong = เก็บกระทง)
	-- 	RewardType = 'item',		-- ประเภทของรางวัล (item = ไอเทม / money = เงิน / blackmoney = เงินแดง)
	-- 	ItemName = 'bread',		-- ชื่อไอเทมที่จะได้รับ
	-- 	ItemCount = 1,		-- จำนวนไอเทมที่จะได้รับ

	-- 	ItemBonus = {
	-- 		[1] = {
	-- 			Name = 'gold',		-- ชื่อไอเทมโบนัสที่จะได้รับ
	-- 			Count = 1,		-- จำนวนไอเทมโบนัสที่จะได้รับ
	-- 			Percent = 100		-- เปอร์เซ็นต์ที่จะได้รับ
	-- 		},
	-- 		[2] = {
	-- 			Name = 'diamond',		-- ชื่อไอเทมโบนัสที่จะได้รับ
	-- 			Count = 1,		-- จำนวนไอเทมโบนัสที่จะได้รับ
	-- 			Percent = 50		-- เปอร์เซ็นต์ที่จะได้รับ
	-- 		},
	-- 	}
	-- },
	-- [5] = {
	-- 	Type = 'lantern',		-- ของรางวัลสำหรับ (krathong = กระทง / lantern = โคมลอย / collect_krathong = เก็บกระทง)
	-- 	RewardType = 'money',		-- ประเภทของรางวัล (item = ไอเทม / money = เงิน / blackmoney = เงินแดง)
	-- 	Count = 500		-- จำนวนเงินที่จะได้รับ
	-- },	
	-- [6] = {
	-- 	Type = 'lantern',		-- ของรางวัลสำหรับ (krathong = กระทง / lantern = โคมลอย / collect_krathong = เก็บกระทง)
	-- 	RewardType = 'blackmoney',		-- ประเภทของรางวัล (item = ไอเทม / money = เงิน / blackmoney = เงินแดง)
	-- 	Count = 500		-- จำนวนเงินที่จะได้รับ
	-- },

	-- Collect Krathong
	-- [7] = {
	-- 	Type = 'collect_krathong',		-- ของรางวัลสำหรับ (krathong = กระทง / lantern = โคมลอย / collect_krathong = เก็บกระทง)
	-- 	RewardType = 'item',		-- ประเภทของรางวัล (item = ไอเทม / money = เงิน / blackmoney = เงินแดง)
	-- 	ItemName = 'water',		-- ชื่อไอเทมที่จะได้รับ
	-- 	ItemCount = 1,		-- จำนวนไอเทมที่จะได้รับ

	-- 	ItemBonus = {
	-- 		[1] = {
	-- 			Name = 'gold',		-- ชื่อไอเทมโบนัสที่จะได้รับ
	-- 			Count = 1,		-- จำนวนไอเทมโบนัสที่จะได้รับ
	-- 			Percent = 100		-- เปอร์เซ็นต์ที่จะได้รับ
	-- 		},
	-- 		[2] = {
	-- 			Name = 'diamond',		-- ชื่อไอเทมโบนัสที่จะได้รับ
	-- 			Count = 1,		-- จำนวนไอเทมโบนัสที่จะได้รับ
	-- 			Percent = 50		-- เปอร์เซ็นต์ที่จะได้รับ
	-- 		},
	-- 	}
	-- },

	-- [8] = {
	-- 	Type = 'collect_krathong',		-- ของรางวัลสำหรับ (krathong = กระทง / lantern = โคมลอย / collect_krathong = เก็บกระทง)
	-- 	RewardType = 'money',		-- ประเภทของรางวัล (item = ไอเทม / money = เงิน / blackmoney = เงินแดง)
	-- 	Count = 100		-- จำนวนเงินที่จะได้รับ
	-- },	

}

