-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --
Config.Default = {
	title = {
		normal = 'ร้านค้าของ %s',
		service = 'บริการฝากขายสินค้า'
	},
	action_radius = 1.2, -- ระยะ Action ต่างๆ เช่น การเปิดร้านค้า, เข้าร้านค้าอื่นๆ
	max_service_booth = 1, -- จำกัดจำนวนการตั้งร้านฝากขายต่อ 1 คน (ไม่จำกัด = -1)
	nearby_marker = { -- Marker แสดงร้านค้าที่ใกล้ที่สุด
		show = true, -- แสดง Marker (true = แสดง | false = ไม่แสดง)
		sprite = 27, -- รูปแบบของ Marker
		color = {
			r = 103,
			g = 177,
			b = 186,
			a = 150
		}, -- สีของ Marker เป็นรูปแบบ rgba
		size = 1.0, -- ขนาดของ Marker
		height = 1.0, -- ความสูงของ Marker
		z_offset = -0.99, -- ระยะ Offset ในแนวแกน Z
		turn = true -- หมุน Marker
	},
	sell_action = {
		items = {
			type = 'blacklist', -- whitelist|blacklist
			list = {}
		},
		weapons = {
			type = 'blacklist', -- whitelist|blacklist
			list = {}
		}
	},
	ped_list = { -- รายการ Ped ที่สามารถเลือกได้ (https://docs.fivem.net/docs/game-references/ped-models/)
		`a_m_y_smartcaspat_01`}
}

Config.Zones = {
	[1] = {
		coords = vector3(125.7606, -1052.9363, 28.9605), -- ตำแหน่งของ Economy Shop
		radius = 15.0, -- ระยะห่างจากจุดศูนย์กลางที่สามารถเปิดร้านได้
		marker = {
			show = true, -- แสดง Marker (true = แสดง | false = ไม่แสดง)
			distance = 15.0, -- ระยะการมองเห็นจากขอบ Marker
			color = {
				r = 255,
				g = 204,
				b = 0,
				a = 100
			}, -- สีของ Marker เป็นรูปแบบ rgba
			height = 1.5 -- ความสูงของ Marker
		},
		blip = {
			show = false, -- แสดง Blip ในแผนที่
			name = 'Market Booth', -- ชื่อของ Blip
			color = 15, -- สีของ Blip
			sprite = 374, -- รูปแบบของ Blip (https://docs.fivem.net/docs/game-references/blips)
			size = 1.0 -- ขนาดของ Blip
		}
	},
}

Config.Items = {{
					booth_mode = 'service', -- ชนิดของร้านค้า ('normal': ตั้งร้านค้าส่วนตัว | 'service': บริการฝากขาย)
					use = {
						name = 'card_vip', -- ต้องการ Item ในการตั้งร้านค้าส่วนตัวหรือฝากขาย
						quantity = 1, -- จำนวน Item ที่ต้องการในการตั้งร้านค้าส่วนตัวหรือฝากขาย
						remove = false, -- ลบ Item เมื่อตั้งร้านค้าส่วนตัวหรือฝากขาย
						animation = { -- Animation ตอนกดใช้ Item
							enable = true, -- เปิด/ปิด Animation
							dict = 'mp_car_bomb', -- Animation Dictionary
							anim = 'car_bomb_mechanic', -- Animation Name
							flag = 1, -- Animation Flag
							duration = 3000 -- ระยะเวลาที่ทำ Animation (1000 = 1 วินาที) * ต่ำสุด 500
						}
					},
					edit = { -- โหมด "แก้ไข" (ใช้ได้เฉพาะ booth_mode = 'normal' เท่านั้น)
						rename = true -- อนุญาตให้เปลี่ยนชื่อร้านได้เมื่ออยู่ในโหมด "แก้ไข"
					},
					chat = {
						enable = false, -- เปิดการใช้กล่องข้อความในร้าน (ใช้ได้เฉพาะ booth_mode = 'normal' เท่านั้น)
						chat_options = {
							show_name = false -- แสดงชื่อผู้ส่งข้อความเป็นสาธารณะ
						}
					},
					options = {
						slot = 12, -- จำนวนสินค้าที่สามารถขายได้ในร้าน (หากต้องการให้ตั้งขายได้ไม่จำกัดให้ตัง -1)
						commission = 1.0 -- ค่า Commission โดยจะหักเป็น % จากเงินที่ได้จากการขาย
					},
					sell_action = {
						items = {
							type = 'blacklist', -- default|blacklist|whitelist
							list = {"card_reskin", "card_lastname", "auto_1h", "gum_mining", "gum_eco", "card_vip", "cron",
							"ad_blessing", "ad_clipper", "ad_spray", "vault_master", "ad_bag", "busker", "starter_kit", "box_rcar", "gacha_support",
							"vault_md", "medkit", "vault_pd", "card_gang", "megaphone", "gov_toolkit", "gov_aed", "gov_radio", "gov_scuba",
							"gov_vest", "gov_tablet", "pt_all", "r_bandage", "r_painkiller", "r_vest", "r_aed", "t1_box_knuckle",
							"t1_box_machete", "t1_box_bottle", "t1_box_poolcue", "t1_player", "meth_b", "heroine", "skateboard", "body_bag",
							"painkiller", "card_nplayer", "vault_key", "quest_a", "quest_b", "casino_chip", "card_afk", "exp", "weapon_box_unt",
							"key_gang", "radio_board", "radio", "fight_pack", "adrenaline", "gacha_5", "gacha_5_1", "gacha_5_2", "gacha_5_3",
							"gacha_5_4", "exp_gang", "keycard_silver", "keycard_gold", "keycard_red", "house_silver", "house_gold", "house_red",
							"rental_3d", "rental_7d", "rental_15d", "coin_killer", "r_adrenaline", "bullet", "speed_loader", "revolver_1",
							"revolver_2", "revolver_3", "gun_screw", "gun_mold", "gun_sight", "gun_permit", "player_mask", "card_id", "card_family",
							"card_vault", "exp_vault", "ad_bell", "gacha_event", "fashion_0", "gov_help", "tag_gang", "booster1", "booster2", "booster3",
							"card_wvault", "box_ad_citizen", "box_ad_family", "box_ad_gang", "box_sa_citizen", "box_sa_family", "box_sa_gang", "gov_painkiller",
							"box_exp", "box_gunpart"}
						},
						weapons = {
							type = 'blacklist', -- default|blacklist|whitelist
							list = {"WEAPON_STUNGUN", "WEAPON_PUMPSHOTGUN", "WEAPON_NIGHTSTICK", "WEAPON_BOTTLE_SOS", "WEAPON_SNIPERRIFLE",
							"R_WEAPON_BAT", "R_WEAPON_GOLFCLUB", "R_WEAPON_KNUCKLE", "R_WEAPON_MACHETE", "R_WEAPON_BOTTLE", "R_WEAPON_KNIFE",
							"R_WEAPON_DAGGER", "R_WEAPON_POOLCUE", "WEAPON_SNOWBALL", "T1_WEAPON_KNUCKLE", "T1_WEAPON_MACHETE", "T1_WEAPON_BOTTLE",
							"T1_WEAPON_POOLCUE", "WEAPON_BAT_1H", "WEAPON_BAT_1H_2", "WEAPON_BAT", "WEAPON_GOLFCLUB_1H", "WEAPON_GOLFCLUB_1H_2",
							"WEAPON_GOLFCLUB", "WEAPON_KNUCKLE", "WEAPON_KNUCKLE_2", "WEAPON_KNUCKLE_3", "WEAPON_KNUCKLE_4", "WEAPON_KNUCKLE_5",
							"WEAPON_MACHETE", "WEAPON_MACHETE_2", "WEAPON_MACHETE_3", "WEAPON_BOTTLE", "WEAPON_BOTTLE_2", "WEAPON_BOTTLE_3",
							"WEAPON_KNIFE", "WEAPON_KNIFE_2", "WEAPON_KNIFE_3", "WEAPON_DAGGER", "WEAPON_DAGGER_2", "WEAPON_DAGGER_3", "WEAPON_POOLCUE",
							"WEAPON_POOLCUE_2", "WEAPON_POOLCUE_3", "WEAPON_REVOLVER", "WEAPON_REVOLVER_MK2", "WEAPON_REVOLVER_MK3", "WEAPON_FLASHLIGHT"}
						}
					},
					custom_prices = { -- กำหนดราคาที่อนุญาตให้ตั้งขายได้ *หากไม่กำหนด ผู้เล่นจะสามารถตั้งราคาเท่าไหร่ก็ได้
						items = {
							-- ['itemName'] = { minPrice, maxPrice },	-- minPrice: ราคาต่ำสุด | maxPrice: ราคาสูงสุด *หากไม่ต้องการกำหนดค่านั้นๆให้ใส่ค่าเป็น -1
							-- ['bread'] = { 10, 100 },
						},
						weapons = {
							-- ['WEAPON_POOLCUE'] = { -1, 20000 },
						}
					},
					ped_list = { -- Ped ต่างๆที่อนุญาตให้เลือกใช้ * หากต้องการใช้ Default Ped ให้ตั้งค่าเป็น {} (มีผลเฉพาะ booth_mode = 'service' เท่านั้น)

					},
					zones = {1, 2, 3}
				},  {
					booth_mode = 'normal', -- ชนิดของร้านค้า ('normal': ตั้งร้านค้าส่วนตัว | 'service': บริการฝากขาย)
					use = {
						name = 'card_booth', -- ต้องการ Item ในการตั้งร้านค้าส่วนตัวหรือฝากขาย
						quantity = 1, -- จำนวน Item ที่ต้องการในการตั้งร้านค้าส่วนตัวหรือฝากขาย
						remove = true, -- ลบ Item เมื่อตั้งร้านค้าส่วนตัวหรือฝากขาย
						animation = { -- Animation ตอนกดใช้ Item
							enable = true, -- เปิด/ปิด Animation
							dict = 'mp_car_bomb', -- Animation Dictionary
							anim = 'car_bomb_mechanic', -- Animation Name
							flag = 1, -- Animation Flag
							duration = 3000 -- ระยะเวลาที่ทำ Animation (1000 = 1 วินาที) * ต่ำสุด 500
						}
					},
					edit = { -- โหมด "แก้ไข" (ใช้ได้เฉพาะ booth_mode = 'normal' เท่านั้น)
						rename = true -- อนุญาตให้เปลี่ยนชื่อร้านได้เมื่ออยู่ในโหมด "แก้ไข"
					},
					chat = {
						enable = true, -- เปิดการใช้กล่องข้อความในร้าน (ใช้ได้เฉพาะ booth_mode = 'normal' เท่านั้น)
						chat_options = {
							limit = 50, -- Limit จำนวนแชทสูงสุด
							show_name = true -- แสดงชื่อผู้ส่งข้อความเป็นสาธารณะ
						}
					},
					options = {
						slot = 12, -- จำนวนสินค้าที่สามารถขายได้ในร้าน (หากต้องการให้ตั้งขายได้ไม่จำกัดให้ตั้ง -1)
						commission = 1.00 -- ค่า Commission โดยจะหักเป็น % จากเงินที่ได้จากการขาย
					},
					sell_action = {
						items = {
							type = 'blacklist', -- default|blacklist|whitelist
							list = {"card_reskin", "card_lastname", "auto_1h", "gum_mining", "gum_eco", "card_vip", "cron",
							"ad_blessing", "ad_clipper", "ad_spray", "vault_master", "ad_bag", "busker", "starter_kit", "box_rcar", "gacha_support",
							"vault_md", "medkit", "vault_pd", "card_gang", "megaphone", "gov_toolkit", "gov_aed", "gov_radio", "gov_scuba",
							"gov_vest", "gov_tablet", "pt_all", "r_bandage", "r_painkiller", "r_vest", "r_aed", "t1_box_knuckle",
							"t1_box_machete", "t1_box_bottle", "t1_box_poolcue", "t1_player", "meth_b", "heroine", "skateboard", "body_bag",
							"painkiller", "card_nplayer", "vault_key", "quest_a", "quest_b", "casino_chip", "card_afk", "exp", "weapon_box_unt",
							"key_gang", "radio_board", "radio", "fight_pack", "adrenaline", "gacha_5", "gacha_5_1", "gacha_5_2", "gacha_5_3",
							"gacha_5_4", "exp_gang", "keycard_silver", "keycard_gold", "keycard_red", "house_silver", "house_gold", "house_red",
							"rental_3d", "rental_7d", "rental_15d", "coin_killer", "r_adrenaline", "bullet", "speed_loader", "revolver_1",
							"revolver_2", "revolver_3", "gun_screw", "gun_mold", "gun_sight", "gun_permit", "player_mask", "card_id", "card_family",
							"card_vault", "exp_vault", "ad_bell", "gacha_event", "fashion_0", "gov_help", "tag_gang", "booster1", "booster2", "booster3",
							"card_wvault", "box_ad_citizen", "box_ad_family", "box_ad_gang", "box_sa_citizen", "box_sa_family", "box_sa_gang", "gov_painkiller",
							"box_exp", "box_gunpart"}
						},
						weapons = {
							type = 'blacklist', -- default|blacklist|whitelist
							list = {"WEAPON_STUNGUN", "WEAPON_PUMPSHOTGUN", "WEAPON_NIGHTSTICK", "WEAPON_BOTTLE_SOS", "WEAPON_SNIPERRIFLE",
							"R_WEAPON_BAT", "R_WEAPON_GOLFCLUB", "R_WEAPON_KNUCKLE", "R_WEAPON_MACHETE", "R_WEAPON_BOTTLE", "R_WEAPON_KNIFE",
							"R_WEAPON_DAGGER", "R_WEAPON_POOLCUE", "WEAPON_SNOWBALL", "T1_WEAPON_KNUCKLE", "T1_WEAPON_MACHETE", "T1_WEAPON_BOTTLE",
							"T1_WEAPON_POOLCUE", "WEAPON_BAT_1H", "WEAPON_BAT_1H_2", "WEAPON_BAT", "WEAPON_GOLFCLUB_1H", "WEAPON_GOLFCLUB_1H_2",
							"WEAPON_GOLFCLUB", "WEAPON_KNUCKLE", "WEAPON_KNUCKLE_2", "WEAPON_KNUCKLE_3", "WEAPON_KNUCKLE_4", "WEAPON_KNUCKLE_5",
							"WEAPON_MACHETE", "WEAPON_MACHETE_2", "WEAPON_MACHETE_3", "WEAPON_BOTTLE", "WEAPON_BOTTLE_2", "WEAPON_BOTTLE_3",
							"WEAPON_KNIFE", "WEAPON_KNIFE_2", "WEAPON_KNIFE_3", "WEAPON_DAGGER", "WEAPON_DAGGER_2", "WEAPON_DAGGER_3", "WEAPON_POOLCUE",
							"WEAPON_POOLCUE_2", "WEAPON_POOLCUE_3", "WEAPON_REVOLVER", "WEAPON_REVOLVER_MK2", "WEAPON_REVOLVER_MK3", "WEAPON_FLASHLIGHT"}
						}
					},
					custom_prices = { -- กำหนดราคาที่อนุญาตให้ตั้งขายได้ *หากไม่กำหนด ผู้เล่นจะสามารถตั้งราคาเท่าไหร่ก็ได้
						items = {
							-- ['itemName'] = { minPrice, maxPrice },	-- minPrice: ราคาต่ำสุด | maxPrice: ราคาสูงสุด *หากไม่ต้องการกำหนดค่านั้นๆให้ใส่ค่าเป็น -1
							-- ['water'] = { 80, 100 },
						},
						weapons = {
							-- ['WEAPON_POOLCUE'] = { 20000, -1 },
						}
					},
					ped_list = { -- Ped ต่างๆที่อนุญาตให้เลือกใช้ * หากต้องการใช้ Default Ped ให้ตั้งค่าเป็น {} (มีผลเฉพาะ booth_mode = 'service' เท่านั้น)

					},
					zones = {1, 2, 3}
				}}

-- จุดเบิกของคืนจากร้านฝากขายสินค้า
Config.Storages = {
	title = 'จุดเบิกสินค้าฝากขาย',
	title_scale = 1.5,
	action_radius = 2.0, -- ระยำเปิดตู้เบิกของ
	locations = {{
					 title_z_offset = 1.4,
					 coords = vector3(129.2383, -1069.4092, 29.2621),
					 heading = 313.8699,
					 model = {
						 name = `p_cs_locker_01_s`,
						 z_offset = 0.0
					 },
					 blip = {
						 show = false, -- แสดง Blip ในแผนที่
						 name = 'Booth Storage', -- ชื่อของ Blip
						 color = 15, -- สีของ Blip
						 sprite = 568, -- รูปแบบของ Blip (https://docs.fivem.net/docs/game-references/blips)
						 size = 1.0 -- ขนาดของ Blip
					 }
				 } -- {
		-- 	title_z_offset = 1.0,
		-- 	coords = vector3(-79.234771728516, -820.31597900391, 326.17517089844),
		-- 	heading = 296.44277954102,
		-- 	model = {
		-- 		name = `ex_prop_crate_art_02_sc`,
		-- 		z_offset = 0.0
		-- 	},
		-- 	blip = {
		-- 		show = false,								-- แสดง Blip ในแผนที่
		-- 		name = 'Booth Storage',						-- ชื่อของ Blip
		-- 		color = 15,									-- สีของ Blip
		-- 		sprite = 568,								-- รูปแบบของ Blip (https://docs.fivem.net/docs/game-references/blips)
		-- 		size = 1.0									-- ขนาดของ Blip
		-- 	}
		-- },
		-- {
		-- 	title_z_offset = 1.0,
		-- 	coords = vector3(-87.079681396484, -810.61883544922, 321.28765869141),
		-- 	heading = 42.021327972412,
		-- 	model = {
		-- 		name = `ex_prop_crate_art_02_sc`,
		-- 		z_offset = 0.0
		-- 	},
		-- 	blip = {
		-- 		show = false,								-- แสดง Blip ในแผนที่
		-- 		name = 'Booth Storage',						-- ชื่อของ Blip
		-- 		color = 15,									-- สีของ Blip
		-- 		sprite = 568,								-- รูปแบบของ Blip (https://docs.fivem.net/docs/game-references/blips)
		-- 		size = 1.0									-- ขนาดของ Blip
		-- 	}
		-- },
	}
}
