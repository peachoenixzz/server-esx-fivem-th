-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --
local itemsBlacklist = {
	'card_vip',
	'ad_blessing',
	'ad_clipper',
	'ad_spray',
	'vault_master',
	'ad_bag',
	'starter_kit',
	'box_rcar',
	'vault_md',
	'vault_pd',
	'card_gang',
	'r_bandage',
	'r_painkiller',
	'r_vest',
	'r_aed',
	't1_box_knuckle',
	't1_box_machete',
	't1_box_bottle',
	't1_box_poolcue',
	't1_player',
	'card_nplayer',
	'vault_key',
	'quest_a',
	'quest_b',
	'casino_chip',
	'card_afk',
	--'exp',
	'key_gang',
	'exp_gang',
	'house_silver',
	'house_gold',
	'house_red',
	'coin_killer',
	'r_adrenaline',
	'player_mask',
	'card_id',
	'card_family',
	'card_vault',
	'exp_vault',
	'ad_bell',
	'booster1',
	'booster2',
	'booster3',
	'rental_3d',
	'rental_7d',
	'rental_15d',
	'card_wvault',
	'box_exp',
	'auto_1h',
}


local itemsBlacklistTent = {
	'card_vip',
	'ad_blessing',
	'ad_clipper',
	'ad_spray',
	'vault_master',
	'ad_bag',
	'starter_kit',
	'box_rcar',
	'vault_md',
	'vault_pd',
	'card_gang',
	'r_bandage',
	'r_painkiller',
	'r_vest',
	'r_aed',
	't1_box_knuckle',
	't1_box_machete',
	't1_box_bottle',
	't1_box_poolcue',
	't1_player',
	'card_nplayer',
	'vault_key',
	'quest_a',
	'quest_b',
	'casino_chip',
	'card_afk',
	--'exp',
	'key_gang',
	'exp_gang',
	'house_silver',
	'house_gold',
	'house_red',
	'coin_killer',
	'r_adrenaline',
	'player_mask',
	'card_id',
	'card_family',
	'card_vault',
	'exp_vault',
	'ad_bell',
	'booster1',
	'booster2',
	'booster3',
	'rental_3d',
	'rental_7d',
	'rental_15d',
	'card_wvault',
	'box_exp',
	'auto_1h',
}

local weaponBlacklist = {
	'WEAPON_STUNGUN',
	'WEAPON_PUMPSHOTGUN',
	'WEAPON_NIGHTSTICK',
	'WEAPON_BOTTLE_SOS',
	'WEAPON_SNIPERRIFLE',
	'R_WEAPON_BAT',
	'R_WEAPON_GOLFCLUB',
	'R_WEAPON_KNUCKLE',
	'R_WEAPON_MACHETE',
	'R_WEAPON_BOTTLE',
	'R_WEAPON_KNIFE',
	'R_WEAPON_DAGGER',
	'R_WEAPON_POOLCUE',
	'T1_WEAPON_KNUCKLE',
	'T1_WEAPON_MACHETE',
	'T1_WEAPON_BOTTLE',
	'T1_WEAPON_POOLCUE',
}

Config.GroupVault = {														-- ตู้เซฟทั่วไป
	['NORMAL'] = {
		name = 'ตู้เซฟประชาชน',
		max_level = 10,
		exp_per_lvl = 30,
		lvl_permission = {
			[1] = {
				slot = -1,
				weight = 500,
				total_account_limit = -1,
				total_item_limit = 1000,
				total_weapon_limit = 0,
				allow_accounts = true,
				allow_items = true,
				allow_weapons = false,
				shareable = false
			},
			[2] = {
				slot = -1,
				weight = 1000,
				total_account_limit = -1,
				total_item_limit = 2000,
				total_weapon_limit = 0,
				allow_accounts = true,
				allow_items = true,
				allow_weapons = false,
				shareable = false
			},
			[3] = {
				slot = -1,
				weight = 1500,
				total_account_limit = -1,
				total_item_limit = 3000,
				total_weapon_limit = 0,
				allow_accounts = true,
				allow_items = true,
				allow_weapons = false,
				shareable = false
			},
			[4] = {
				slot = -1,
				weight = 2000,
				total_account_limit = -1,
				total_item_limit = 4000,
				total_weapon_limit = 0,
				allow_accounts = true,
				allow_items = true,
				allow_weapons = false,
				shareable = false
			},
			[5] = {
				slot = -1,
				weight = 2500,
				total_account_limit = -1,
				total_item_limit = 5000,
				total_weapon_limit = 0,
				allow_accounts = true,
				allow_items = true,
				allow_weapons = false,
				shareable = false
			},
			[6] = {
				slot = -1,
				weight = 3000,
				total_account_limit = -1,
				total_item_limit = 6000,
				total_weapon_limit = 0,
				allow_accounts = true,
				allow_items = true,
				allow_weapons = false,
				shareable = false
			},
			[7] = {
				slot = -1,
				weight = 4000,
				total_account_limit = -1,
				total_item_limit = 7000,
				total_weapon_limit = 0,
				allow_accounts = true,
				allow_items = true,
				allow_weapons = false,
				shareable = false
			},
			[8] = {
				slot = -1,
				weight = 5000,
				total_account_limit = -1,
				total_item_limit = 8000,
				total_weapon_limit = 0,
				allow_accounts = true,
				allow_items = true,
				allow_weapons = false,
				shareable = false
			},
			[9] = {
				slot = -1,
				weight = -1,
				total_account_limit = -1,
				total_item_limit = 10000,
				total_weapon_limit = 0,
				allow_accounts = true,
				allow_items = true,
				allow_weapons = false,
				shareable = false
			},
			[10] = {
				slot = -1,
				weight = -1,
				total_account_limit = -1,
				total_item_limit = -1,
				total_weapon_limit = 0,
				allow_accounts = true,
				allow_items = true,
				allow_weapons = true,
				shareable = true
			}
		},
		allowed_list = {											-- รายการ whitelist/blacklist ต่างๆ
			accounts = {
				type = 'blacklist',
				list = {
					'money',
					'bank',
				}
			},
			items = {
				type = 'blacklist',
				list = itemsBlacklist
			},
			weapons = {
				type = 'blacklist',
				list = weaponBlacklist
			}
		},
		upgrade_items = {
			{ type = 'item', name = 'exp', exp = 1 },
			{ type = 'item', name = 'exp_vault', exp = 5 },
		},
		open_vault_option = {
			{ type = 'item', name = 'vault_key', quantity = 1, open_time = 0, remove = false },
		},
		create_vault_option = {
			{ type = 'item', name = 'card_vault', quantity = 1, remove = true },
		},
		zone = {
			blip = {
				show = false,
				name = 'Citizen Vault',
				sprite = 267,
				color = 15,
				scale = 0.9
			},
			text = {
				show = true,
				title = 'Vault',
				color = { r = 255, g = 204, b = 0 },
				distance = 7
			},
			locations = {
				{
					model = ``,
					coords = vector3(-437.7699890136719, 1098.25, 327.2612), -- Rebel ประชาชน
					heading = 167,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = true,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(1099.02001953125, 3053.56005859375, 44.4129),  -- Rebel
					heading = 167,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = true,
					action_radius = 1.5
				},
				-- {
				-- 	model = `p_v_43_safe_s`,
				-- 	coords = vector3(-2832.3798828125, -1947.6300048828127, 5.8600001335144),  -- เกาะ AFK
				-- 	heading = 318,
				-- 	z_offset = 0.0,
				-- 	text_z_offset = 0.1,
				-- 	place_on_ground = true,
				-- 	action_radius = 1.5
				-- },
				{
					model = ``,
					coords = vector3(-139.0399932861328, -604.780029296875, 167.58999633789065), -- ห้องกาชา
					heading = 318,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = true,
					action_radius = 1.5
				},
			}
		},
		max_vault_per_player = 2,
		can_remove = false
	},
	
	['WEAPON'] = {
		name = 'ตู้เซฟอาวุธ',
		max_level = 1,
		exp_per_lvl = 30,
		lvl_permission = {
			[1] = {
				slot = -1,
				weight = -1,
				total_account_limit = -1,
				total_item_limit = -1,
				total_weapon_limit = -1,
				allow_accounts = false,
				allow_items = false,
				allow_weapons = true,
				shareable = false
			},
		},
		allowed_list = {											-- รายการ whitelist/blacklist ต่างๆ
			accounts = {
				type = 'blacklist',
				list = {
					'money',
					'bank',
				}
			},
			items = {
				type = 'blacklist',
				list = itemsBlacklist
			},
			weapons = {
				type = 'blacklist',
				list = weaponBlacklist
			}
		},
		upgrade_items = {
			-- { type = 'item', name = 'exp', exp = 1 },
			-- { type = 'item', name = 'exp_vault', exp = 5 },
		},
		open_vault_option = {
			{ type = 'item', name = 'vault_key', quantity = 1, open_time = 0, remove = false },
		},
		create_vault_option = {
			{ type = 'item', name = 'card_wvault', quantity = 1, remove = true },
		},
		zone = {
			blip = {
				show = false,
				name = 'Weapon Vault',
				sprite = 267,
				color = 15,
				scale = 0.9
			},
			text = {
				show = true,
				title = 'Weapon Vault',
				color = { r = 255, g = 204, b = 0 },
				distance = 7
			},
			locations = {
				{
					model = `p_v_43_safe_s`,
					coords = vector3(-442.0299987792969, 1099.239990234375, 327.260009765625), -- Rebel ประชาชน
					heading = 164.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = true,
					action_radius = 1.5
				},
				{
					model = `p_v_43_safe_s`,
					coords = vector3(1093.6099853515625, 3051.820068359375, 44.40999984741211), -- Rebel
					heading = 283.48,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = true,
					action_radius = 1.5
				},
			}
		},
		max_vault_per_player = 1,
		can_remove = false
	},

	['TENT'] = {
		name = 'เต็นท์พักของ',
		max_level = 1,
		exp_per_lvl = 30,
		lvl_permission = {
			[1] = {
				slot = -1,
				weight = -1,
				total_account_limit = 0,
				total_item_limit = 1000,
				total_weapon_limit = 0,
				allow_accounts = false,
				allow_items = true,
				allow_weapons = false,
				shareable = false
			},
		},
		allowed_list = {											-- รายการ whitelist/blacklist ต่างๆ
			accounts = {
				type = 'blacklist',
				list = {
					'money',
					'bank',
				}
			},
			items = {
				type = 'blacklist',
				list = itemsBlacklistTent
			},
			weapons = {
				type = 'blacklist',
				list = weaponBlacklist
			}
		},
		upgrade_items = {

		},
		open_vault_option = {
			{ type = 'item', name = 'card_vip', quantity = 1, open_time = 0, remove = false },
		},
		create_vault_option = {
			{ type = 'item', name = 'card_vip', quantity = 1, remove = false },
		},
		zone = {
			blip = {
				show = false,
				name = 'Tent',
				sprite = 1,
				color = 0,
				scale = 0.5
			},
			text = {
				show = false,
				title = 'Tent',
				color = { r = 123, g = 197, b = 206 },
				distance = 15
			},
			locations = {
				{
					model = ``,
					coords = vector3(-2761.929931640625, 2497.93994140625, 2.77999997138977), -- จุดขุดคริสตัล
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(-2302.489990234375, 366.5700073242188, 174.69000244140625), --แปรรูปคริสตัล
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(-1607.8499755859375, 3063.2900390625, 32.65999984741211), -- จุดเก็บเหล็ก
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(-3142.360107421875, 1051.3800048828125, 20.7800006866455), -- แปรรูปเหล็ก
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(-399.7300109863281, 2954.219970703125, 15.77000045776367), -- จุดขุดทอง
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(-1923.1199951171875, 2060.360107421875, 140.91000366210938), -- แปรรูปทอง
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(2502.0400390625, 4325.33984375, 38.7599983215332), -- จุดเกี่ยวข้าว
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(-110.27999877929688, 2807.219970703125, 53.25), -- แปรรูปข้าว
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(2805.25, 4613.35986328125, 45.72999954223633), -- จุดเก็บกะหล่ำ
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(1543.6400146484375, 2183.090087890625, 78.91999816894531), -- แปรรูปกะหล่ำ
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(2516.449951171875, 4731.64990234375, 34.27999877929687), -- จุดเก็บนม
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(570.5, 2740.840087890625, 42.29999923706055), -- แปรรูปนม
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(2362.27001953125, 5061.16015625, 46.63000106811523), -- จุดเก็บไก่
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(356.1199951171875, 3410.889892578125, 36.54999923706055), -- แปรรูปไก่
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(327.6700134277344, 3542.219970703125, 33.58000183105469), -- จุดตัดไม้
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(-54.08000183105469, 1885.4200439453127, 195.44000244140625), -- แปรรูปไม้
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(2967.85009765625, 2816.969970703125, 43.79000091552734), -- จุดขุดทองแดง
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(2707.949951171875, 1527.8900146484375, 24.60000038146972), -- แปรรูปทองแดง
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(1441.719970703125, 1047.06005859375, 114.76000213623048), -- จุดเก็บหมู
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(960.8800048828124, -2111.10009765625, 32.06000137329101), -- แปรรูปหมู
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(-439.2300109863281, 1124.6099853515625, 327.4200134277344), -- Rebel ประชาชน
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(219.6199951171875, -862.6699829101562, 30.39999961853027), -- Land ไก่ (ติดถนน)
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(152.36000061035156, -1095.6800537109375, 29.75), -- Land ไก่ (ใกล้สระน้ำ)
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
				{
					model = ``,
					coords = vector3(4966.3798828125, -5604.81982421875, 23.72999954223632), -- เกาะคาโย
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = false,
					action_radius = 1.5
				},
			}
		},
		max_vault_per_player = 1,
		can_remove = false
	},
}