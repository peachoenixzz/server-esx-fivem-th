-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --
local itemsBlacklistAgent = {
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

local weaponBlacklistAgent = {
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

Config.SocietyVault = {
	-- 	['uniqueName'] = {											-- ชื่อกลุ่มของตู้เซฟ *ห้าม! ตั้งค่าซ้ำกับชื่อตู้เซฟอื่นใน SocietyVault
	-- 		name = 'vaultName',										-- ชื่อตู้เซฟ
	-- 		slot = -1,												-- จำนวนช่องทั้งหมดที่สามารถเก็บสิ่งของได้ (-1 : ไม่จำกัด)
	-- 		weight = -1,											-- น้ำหนักทั้งหมดที่สามารถเก็บสิ่งของได้ (-1 : ไม่จำกัด)
	-- 		total_account_limit = -1,								-- จำนวนสูงสุดของสิ่งของประเภทเงินที่สามารถเก็บได้ (-1 : ไม่จำกัด)
	-- 		total_item_limit = -1,									-- จำนวนสูงสุดของสิ่งของที่สามารถเก็บได้ (-1 : ไม่จำกัด)
	-- 		total_weapon_limit = -1									-- จำนวนสูงสุดของอาวุธที่สามารถเก็บได้ 1 ชิ้น/ช่อง (-1 : ไม่จำกัด)
	-- 		allow_accounts = true,									-- การเปิดใช้งานให้สามารถเก็บสิ่งของประเภทเงินได้
	-- 		allow_items = true,										-- การเปิดใช้งานให้สามารถเก็บสิ่งของทั่วไปได้
	-- 		allow_weapons = true,									-- การเปิดใช้งานให้สามารถอาวุธได้
	-- 		allowed_list = {										-- รายการ whitelist/blacklist ต่างๆ
	-- 			items = {
	-- 				type = 'whitelist|blacklist',
	-- 				list = {
	-- 					'itemName',
	-- 				}
	-- 			},
	-- 			accounts = {
	-- 				type = 'whitelist|blacklist',
	-- 				list = {
	-- 					'accountName',
	-- 				}
	-- 			},
	-- 			weapons = {
	-- 				type = 'whitelist|blacklist',
	-- 				list = {
	-- 					'weaponName',
	-- 				}
	-- 			}
	-- 		},
	-- 		open_vault_option = {									-- สิ่งของที่ต้องการในการเปิดตู้เซฟ (ไล่ลำดับความสำคัญจากบนลงล่าง โดยจะใช้แค่ 1 อย่างเท่านั้น)	*หากไม่ต้องการให้ใช้สิ่งของในการเปิด ไม่ต้องใส่ในรายการนี้
	-- 			{ type = 'item|account', name = 'itemName', quantity = 1, remove = false },
	-- 		},
	-- 		zone = {
	-- 			blip = {
	-- 				show = true,									-- แสดง Blip ในแผนที่
	-- 				name = 'blipName',								-- ชื่อของ Blip
	-- 				sprite = 267,									-- รูปแบบของ Blip (https://docs.fivem.net/docs/game-references/blips)
	-- 				color = 15,										-- สีของ Blip
	-- 				scale = 0.9										-- ขนาดของ Blip
	-- 			},
	-- 			text = {
	-- 				show = true,									-- แสดง 3DText
	-- 				title = 'titleText',							-- Title Text ที่ต้องการจะแสดง *เปลี่ยนขนาด Font โดยการใส่ '<font size="40">Text Here</font>'
	-- 				color = { r = 123, g = 197, b = 206 },			-- สีตัวอักษรพื้นฐาน | Default: { r = 255, g = 255, b = 255 }
	-- 				distance = 15									-- ระยะการแสดง Text
	-- 			},
	-- 			locations = {
	-- 				{
	-- 					model = `modelName`,						-- ชื่อ Model ตู้เซฟ *หากไม่ต้องการใช้งานให้ตั้งค่าเป็น nil
	-- 					coords = vector3(0, 0, 0),					-- ตำแหน่งของ Object
	-- 					heading = 0.0,								-- Heading ของ Object
	-- 					z_offset = 0.85,							-- ระยะที่ต้องการเพิ่มหรือลดลงในแนวแกน Z (+ เมื่อต้องการให้สูงขึ้น | - เมื่อต้องการให้ต่ำลง)
	-- 					text_z_offset = 0.85,						-- ระยะของ 3DText ที่ต้องการเพิ่มหรือลดลงในแนวแกน Z (+ เมื่อต้องการให้สูงขึ้น | - เมื่อต้องการให้ต่ำลง)
	-- 					place_on_ground = true,						-- วาง Object ลงบนพื้น
	-- 					action_radius = 1.5							-- ระยะที่ผู้เล่นสามารถเปิดตู้เซฟได้ (สูงสุด 15)
	-- 				},
	-- 			}
	-- 		},
	-- 		allowed_jobs = {										-- JOB(s) ที่อนุญาตให้เปิดใช้งานตู้เซฟชนิดนี้ได้
	-- 			['jobName'] = true,
	-- 		}
	-- 	},
	
	['POLICE'] = {
		name = 'ตู้เซฟตำรวจ',
		slot = -1,
		weight = -1,
		total_account_limit = -1,
		total_item_limit = -1,
		total_weapon_limit = -1,
		allow_accounts = true,
		allow_items = true,
		allow_weapons = true,
		allowed_list = {
			accounts = {
				type = 'blacklist',
				list = {
					'money',
					'bank'
				}
			},
			items = {
				type = 'blacklist',
				list = itemsBlacklistAgent
			},
			weapons = {
				type = 'blacklist',
				list = weaponBlacklistAgent
			}
		},
		open_vault_option = {
			{ type = 'item', name = 'vault_master', quantity = 1, open_time = 0, remove = false },
			{ type = 'item', name = 'vault_pd', quantity = 1, open_time = 0, remove = false },	
		},
		zone = {
			blip = {
				show = false,
				name = 'Police Vault',
				sprite = 267,
				color = 15,
				scale = 0.9
			},
			text = {
				show = false,
				title = 'Police Vault',
				color = { r = 123, g = 197, b = 206 },
				distance = 15
			},
			locations = {
				{ -- Los Santos Underground
					model = `p_v_43_safe_s`,
					coords = vector3(474.8699, -997.4799, 26.2700),
					heading = 180.15,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = true,
					action_radius = 1.5
				},
				{ -- Los Santos 1st Floor
					model = `p_v_43_safe_s`,
					coords = vector3(455.1259, -999.5569, 30.6920),
					heading = 180.0571,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = true,
					action_radius = 1.5
				},
				{ -- Sandy Shore
					model = ``,
					coords = vector3(1855.0035, 3699.2483, 34.2671),
					heading = 251.2423,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = true,
					action_radius = 1.5
				},
			}
		},
		allowed_jobs = {
			['police'] = true,
			['admin'] = true,
		}
	},

	['POLICE2'] = {
		name = 'ตู้สวัสดิการตำรวจ',
		slot = -1,
		weight = -1,
		total_account_limit = -1,
		total_item_limit = -1,
		total_weapon_limit = -1,
		allow_accounts = true,
		allow_items = true,
		allow_weapons = true,
		allowed_list = {
			accounts = {
				type = 'blacklist',
				list = {
					'money',
					'bank'
				}
			},
			items = {
				type = 'blacklist',
				list = itemsBlacklistAgent
			},
			weapons = {
				type = 'blacklist',
				list = weaponBlacklistAgent
			}
		},
		open_vault_option = {
			{ type = 'item', name = 'vault_master', quantity = 1, open_time = 0, remove = false },
			{ type = 'item', name = 'vault_pd', quantity = 1, open_time = 0, remove = false },	
		},
		zone = {
			blip = {
				show = false,
				name = 'Police Vault',
				sprite = 267,
				color = 15,
				scale = 0.9
			},
			text = {
				show = false,
				title = 'Police Vault',
				color = { r = 123, g = 197, b = 206 },
				distance = 15
			},
			locations = {
				{ -- Los Santos 1st Floor
					model = ``,
					coords = vector3(463.1000, -980.1900, 30.6900),
					heading = 268.01,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = true,
					action_radius = 1.5
				},
				{ -- Sandy Shore
					model = ``,
					coords = vector3(1851.0466, 3691.0417, 34.2670),
					heading = 268.01,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = true,
					action_radius = 1.5
				},
				{ -- Paleto Bay
				model = ``,
				coords = vector3(-449.8353, 6010.2104, 31.7164),
				heading = 268.01,
				z_offset = 0.0,
				text_z_offset = 0.1,
				place_on_ground = true,
				action_radius = 1.5
			},
			}
		},
		allowed_jobs = {
			['police'] = true,
			['admin'] = true,
		}
	},

	['POLICE_MONEY'] = {
		name = 'ตู้เซฟผู้บัญชาการตำรวจ',
		slot = -1,
		weight = -1,
		total_account_limit = -1,
		total_item_limit = -1,
		total_weapon_limit = -1,
		allow_accounts = true,
		allow_items = true,
		allow_weapons = true,
		allowed_list = {
			accounts = {
				type = 'blacklist',
				list = {
					--'money',
					--'bank'
				}
			},
			items = {
				type = 'blacklist',
				list = itemsBlacklistAgent
			},
			weapons = {
				type = 'blacklist',
				list = weaponBlacklistAgent
			}
		},
		open_vault_option = {
			{ type = 'item', name = 'vault_master', quantity = 1, open_time = 0, remove = false },
			{ type = 'item', name = 'vault_pd', quantity = 1, open_time = 0, remove = false },
		},
		zone = {
			blip = {
				show = false,
				name = 'Police Vault Money',
				sprite = 267,
				color = 15,
				scale = 0.9
			},
			text = {
				show = false,
				title = 'Police Vault Money',
				color = { r = 123, g = 197, b = 206 },
				distance = 15
			},
			locations = {
				{
					model = `prop_ld_int_safe_01`,
					coords = vector3(463.10, -984.10, 30.58),
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = true,
					action_radius = 1.5
				},
			}
		},
		allowed_jobs = {
			['police'] = true,
			['admin'] = true,
		}
	},

	-- ตู้หมอ
	['AMBULANCE'] = {
		name = 'ตู้เซฟหมอ',
		slot = -1,
		weight = -1,
		total_item_limit = -1,
		total_account_limit = -1,
		total_weapon_limit = -1,
		allow_accounts = true,
		allow_items = true,
		allow_weapons = true,
		allowed_list = {
			accounts = {
				type = 'blacklist',
				list = {
					--'money',
					--'bank',
				}
			},
			items = {
				type = 'blacklist',
				list = itemsBlacklistAgent
			},
			weapons = {
				type = 'blacklist',
				list = weaponBlacklistAgent
			}
		},
		open_vault_option = {
			{ type = 'item', name = 'vault_master', quantity = 1, open_time = 0, remove = false },
			{ type = 'item', name = 'vault_md', quantity = 1, open_time = 0, remove = false },
		},
		zone = {
			blip = {
				show = false,
				name = 'Ambulance Vault',
				sprite = 267,
				color = 15,
				scale = 0.9
			},
			text = {
				show = false,
				title = 'Ambulance Vault',
				color = { r = 123, g = 197, b = 206 },
				distance = 15
			},
			locations = {
				{
					model = `p_v_43_safe_s`,
					coords = vector3(332.50, -1433.91, 32.50),
					heading = 140.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = true,
					action_radius = 1.5
				},
			}
		},
		allowed_jobs = {
			['ambulance'] = true,
			['police'] = true,
			['admin'] = true,
		}
	},

	['AMBULANCE2'] = {
		name = 'ตู้สวัสดิการหมอ',
		slot = -1,
		weight = -1,
		total_account_limit = -1,
		total_item_limit = -1,
		total_weapon_limit = -1,
		allow_accounts = true,
		allow_items = true,
		allow_weapons = true,
		allowed_list = {
			accounts = {
				type = 'blacklist',
				list = {
					'money',
					'bank'
				}
			},
			items = {
				type = 'blacklist',
				list = itemsBlacklistAgent
			},
			weapons = {
				type = 'blacklist',
				list = weaponBlacklistAgent
			}
		},
		open_vault_option = {
			{ type = 'item', name = 'vault_master', quantity = 1, open_time = 0, remove = false },
			{ type = 'item', name = 'vault_md', quantity = 1, open_time = 0, remove = false },	
		},
		zone = {
			blip = {
				show = false,
				name = 'Police Vault',
				sprite = 267,
				color = 15,
				scale = 0.9
			},
			text = {
				show = false,
				title = 'Police Vault',
				color = { r = 123, g = 197, b = 206 },
				distance = 15
			},
			locations = {
				{ -- Los Santos
					model = ``,
					coords = vector3(316.2209, -1405.2958, 32.5118),
					heading = 268.01,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = true,
					action_radius = 1.5
				},
				{ -- Sandy Shore
					model = `p_v_43_safe_s`,
					coords = vector3(1827.1281, 3668.1980, 34.2924),
					heading = 303.4948,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = true,
					action_radius = 1.5
				},
				{ -- Paleto Bay
					model = `p_v_43_safe_s`,
					coords = vector3(-269.4396, 6318.6318, 32.4272),
					heading = 135.3324,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = true,
					action_radius = 1.5
			},
			}
		},
		allowed_jobs = {
			['police'] = true,
			['admin'] = true,
		}
	},

	['AMBULANCE_MONEY'] = {
		name = 'ตู้เซฟผู้อำนวยการหมอ',
		slot = -1,
		weight = -1,
		total_account_limit = -1,
		total_item_limit = -1,
		total_weapon_limit = -1,
		allow_accounts = true,
		allow_items = true,
		allow_weapons = true,
		allowed_list = {
			accounts = {
				type = 'blacklist',
				list = {
					--'money',
					--'bank'
				}
			},
			items = {
				type = 'blacklist',
				list = itemsBlacklistAgent
			},
			weapons = {
				type = 'blacklist',
				list = weaponBlacklistAgent
			}
		},
		open_vault_option = {
			{ type = 'item', name = 'vault_master', quantity = 1, open_time = 0, remove = false },
			{ type = 'item', name = 'vault_md', quantity = 1, open_time = 0, remove = false },
		},
		zone = {
			blip = {
				show = false,
				name = 'Police Vault Money',
				sprite = 267,
				color = 15,
				scale = 0.9
			},
			text = {
				show = false,
				title = 'Police Vault Money',
				color = { r = 123, g = 197, b = 206 },
				distance = 15
			},
			locations = {
				{
					model = ``,
					coords = vector3(375.0536, -1394.1675, 32.5111),
					heading = 0.0,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = true,
					action_radius = 1.5
				},
			}
		},
		allowed_jobs = {
			['police'] = true,
			['admin'] = true,
		}
	},

	['ADMIN'] = {
		name = 'ตู้เซฟแอดมิน',
		slot = -1,
		weight = -1,
		total_item_limit = -1,
		total_account_limit = -1,
		total_weapon_limit = -1,
		allow_accounts = true,
		allow_items = true,
		allow_weapons = true,
		allowed_list = {
			accounts = {
				type = 'blacklist',
				list = {
				}
			},
			items = {
				type = 'blacklist',
				list = {
				}
			},
			weapons = {
				type = 'blacklist',
				list = {
				}
			}
		},
		open_vault_option = {
			{ type = 'item', name = 'vault_master', quantity = 1, open_time = 0, remove = false },
		},
		zone = {
			blip = {
				show = false,
				name = 'Admin Vault',
				sprite = 267,
				color = 15,
				scale = 0.9
			},
			text = {
				show = false,
				title = 'Admin Vault',
				color = { r = 123, g = 197, b = 206 },
				distance = 15
			},
			locations = {
				{
					model = ``,
					coords = vector3(-430.6544, 1096.8813, 320.2181),
					heading = 325.26,
					z_offset = 0.0,
					text_z_offset = 0.1,
					place_on_ground = true,
					action_radius = 1.5
				},
			}
		},
		allowed_jobs = {
			['admin'] = true,
			['admin'] = true,
		}
	},
}