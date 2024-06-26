-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config = {}

Config.EventRoute = {
	['getSharedObject'] = 'esx:getSharedObject',				-- Default: 'esx:getSharedObject'
	['playerLoaded'] = 'esx:playerLoaded',						-- Default: 'esx:playerLoaded'
	['playerDropped'] = 'esx:playerDropped',					-- Default: 'esx:playerDropped'
	['onPlayerDeath'] = 'esx:onPlayerDeath',					-- Default: 'esx:onPlayerDeath'
	['onPlayerSpawn'] = 'playerSpawned',						-- Default: 'esx:onPlayerSpawn'
	['setJob'] = 'esx:setJob',									-- Default: 'esx:setJob'
	['addInventoryItem'] = 'esx:addInventoryItem',				-- Default: 'esx:addInventoryItem'
	['removeInventoryItem'] = 'esx:removeInventoryItem',		-- Default: 'esx:removeInventoryItem'
}

Config.Debug = false								-- Debug Mode
Config.DeveloperMode = false					-- แสดงรัสมีขณะตั้งค่า

Config.RobDeadPlayer = true						-- เปิดการปล้นผู้เล่นที่หมดสติ
Config.RobKneelPlayer = true					-- เปิดการปล้นผู้เล่นที่คุกเข่า
Config.RobHandsUpPlayer = false					-- เปิดการปล้นผู้เล่นที่ยกมือ

Config.OnlyKillerCanRobDeadPlayer = false		-- อนุญาตให้คนที่ฆ่าเท่านั้นสามารถปล้นได้

Config.ShowIndicator = false						-- เปิดการแสดงสัญลักษณ์บ่งบอกคนที่สามารถปล้นได้ *หากตั้งค่า Config.ShowIndicator = true จะทำให้ Resmon วิ่งสูงขึ้นเนื่องจากระบบจะต้องเช็คผู้เล่นรอบข้างตลอดเวลา

Config.WeaponsUsedForRobbery = {				-- อาวุธที่ใช้ในการปล้น
	'WEAPON_BAT',
	'WEAPON_GOLFCLUB',
	'WEAPON_MACHETE_2',
	'WEAPON_MACHETE_3',
	'WEAPON_BOTTLE_2',
	'WEAPON_BOTTLE_3',
	'WEAPON_KNIFE',
	'WEAPON_KNIFE_2',
	'WEAPON_KNIFE_3',
	'WEAPON_DAGGER',
	'WEAPON_DAGGER_2',
	'WEAPON_DAGGER_3',
	'WEAPON_POOLCUE',
	'WEAPON_POOLCUE_2',
	'WEAPON_POOLCUE_3',
}

Config.ProtectionItems = {						-- สิ่งของป้องกันการถูกปล้น
	-- ['ชื่อสิ่งของ'] = จำนวน,
	['card_nplayer'] = 1,
}

Config.AllowedList = {
	put = {										-- รายชื่อสิ่งของที่ห้ามใส่เข้ากระเป๋าผู้อื่น
		accounts = {
			type = 'blacklist',					-- whitelist|blacklist
			list = {
				'bank',
			}
		},
		items = {
			type = 'blacklist',					-- whitelist|blacklist
			list = {
				'card_reskin',
				'card_lastname',
				'auto_1h',
				'gum_mining',
				'gum_eco',
				'card_vip',
				'cron',
				'heart_100',
				'ad_blessing',
				'ad_clipper',
				'ad_spray',
				'vault_master',
				'ad_bag',
				'busker',
				'starter_kit',
				'box_rcar',
				'gacha_support',
				'vault_md',
				'medkit',
				'vault_pd',
				'card_gang',
				'megaphone',
				'gov_toolkit',
				'gov_aed',
				'gov_radio',
				'gov_scuba',
				'gov_vest',
				'gov_tablet',
				'pt_all',
				'r_bandage',
				'r_painkiller',
				'r_vest',
				'r_aed',
				't1_box_knuckle',
				't1_box_machete',
				't1_box_bottle',
				't1_box_poolcue',
				't1_player',
				'skateboard',
				'snow_gloves',
				'hifi',
				'rose_1',
				'rose_2',
				'body_bag',
				'painkiller',
				'bandage',
				'card_nplayer',
				'vault_key',
				'quest_a',
				'quest_b',
				'casino_chip',
				'card_afk',
				'exp',
				'meal_mre',
				'vest',
				'helmet',
				'weapon_box_unt',
				'key_gang',
				'radio_board',
				'radio',
				'fight_pack',
				'adrenaline',
				'gacha_5',
				'gacha_5_1',
				'gacha_5_2',
				'gacha_5_3',
				'gacha_5_4',
				'exp_gang',
				'house_silver',
				'house_gold',
				'house_red',
				'rental_3d',
				'rental_7d',
				'rental_15d',
				'coin_killer',
				'r_adrenaline',
				'player_mask',
				'card_id',
				'card_family',
				'card_vault',
				'exp_vault',
				'ad_bell',
				'gacha_event',
				'fashion_0',
				'baby1',
				'baby2',
				'baby3',
				'baby4',
				'baby5',
				'baby6',
				'baby7',
				'baby8',
				'spacpup',
				'spacpupb',
				'spacpupc',
				'spacpupd',
				'spacpupe',
				'spacpupf',
				'summersocute1',
				'summersocute2',
				'summersocute3',
				'summersocute4',
				'summersocute5',
				'summersocute6',
				'gov_help',
				'tag_gang',
				'booster1',
				'booster2',
				'booster3',
				'card_wvault',
				'box_ad_citizen',
				'box_ad_family',
				'box_ad_gang',
				'box_sa_citizen',
				'box_sa_family',
				'box_sa_gang',
				'gov_painkiller',
				'box_exp',
			}
		},
		weapons = {
			type = 'blacklist',					-- whitelist|blacklist
			list = {
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
				'WEAPON_SNOWBALL',
				'T1_WEAPON_KNUCKLE',
				'T1_WEAPON_MACHETE',
				'T1_WEAPON_BOTTLE',
				'T1_WEAPON_POOLCUE',
				'WEAPON_BAT_1H',
				'WEAPON_BAT_1H_2',
				'WEAPON_BAT',
				'WEAPON_GOLFCLUB_1H',
				'WEAPON_GOLFCLUB_1H_2',
				'WEAPON_GOLFCLUB',
				'WEAPON_KNUCKLE',
				'WEAPON_KNUCKLE_2',
				'WEAPON_KNUCKLE_3',
				'WEAPON_KNUCKLE_4',
				'WEAPON_KNUCKLE_5',
				'WEAPON_MACHETE',
				'WEAPON_MACHETE_2',
				'WEAPON_MACHETE_3',
				'WEAPON_BOTTLE',
				'WEAPON_BOTTLE_2',
				'WEAPON_BOTTLE_3',
				'WEAPON_KNIFE',
				'WEAPON_KNIFE_2',
				'WEAPON_KNIFE_3',
				'WEAPON_DAGGER',
				'WEAPON_DAGGER_2',
				'WEAPON_DAGGER_3',
				'WEAPON_POOLCUE',
				'WEAPON_POOLCUE_2',
				'WEAPON_POOLCUE_3',
				'WEAPON_REVOLVER',
				'WEAPON_REVOLVER_MK2',
				'WEAPON_REVOLVER_MK3',
				'WEAPON_FLASHLIGHT',
			}
		}
	},
	take = {									-- รายชื่อสิ่งของที่ห้ามปล้นจากกระเป๋าผู้อื่น
		accounts = {
			type = 'blacklist',					-- whitelist|blacklist
			list = {
				'bank',
			}
		},
		items = {
			type = 'blacklist',					-- whitelist|blacklist
			list = {
				'card_reskin',
				'card_lastname',
				'auto_1h',
				'gum_mining',
				'gum_eco',
				'card_vip',
				'cron',
				'heart_100',
				'ad_blessing',
				'ad_clipper',
				'ad_spray',
				'vault_master',
				'ad_bag',
				'busker',
				'starter_kit',
				'box_rcar',
				'gacha_support',
				'vault_md',
				'medkit',
				'vault_pd',
				'card_gang',
				'megaphone',
				'gov_toolkit',
				'gov_aed',
				'gov_radio',
				'gov_scuba',
				'gov_vest',
				'gov_tablet',
				'pt_all',
				'r_bandage',
				'r_painkiller',
				'r_vest',
				'r_aed',
				't1_box_knuckle',
				't1_box_machete',
				't1_box_bottle',
				't1_box_poolcue',
				't1_player',
				'skateboard',
				'snow_gloves',
				'hifi',
				'rose_1',
				'rose_2',
				'body_bag',
				'painkiller',
				'bandage',
				'card_nplayer',
				'vault_key',
				'quest_a',
				'quest_b',
				'casino_chip',
				'card_afk',
				'exp',
				'meal_mre',
				'vest',
				'helmet',
				'weapon_box_unt',
				'key_gang',
				'radio_board',
				'radio',
				'fight_pack',
				'adrenaline',
				'gacha_5',
				'gacha_5_1',
				'gacha_5_2',
				'gacha_5_3',
				'gacha_5_4',
				'exp_gang',
				'house_silver',
				'house_gold',
				'house_red',
				'rental_3d',
				'rental_7d',
				'rental_15d',
				'coin_killer',
				'r_adrenaline',
				'player_mask',
				'card_id',
				'card_family',
				'card_vault',
				'exp_vault',
				'ad_bell',
				'gacha_event',
				'fashion_0',
				'baby1',
				'baby2',
				'baby3',
				'baby4',
				'baby5',
				'baby6',
				'baby7',
				'baby8',
				'spacpup',
				'spacpupb',
				'spacpupc',
				'spacpupd',
				'spacpupe',
				'spacpupf',
				'summersocute1',
				'summersocute2',
				'summersocute3',
				'summersocute4',
				'summersocute5',
				'summersocute6',
				'gov_help',
				'tag_gang',
				'booster1',
				'booster2',
				'booster3',
				'card_wvault',
				'box_ad_citizen',
				'box_ad_family',
				'box_ad_gang',
				'box_sa_citizen',
				'box_sa_family',
				'box_sa_gang',
				'gov_painkiller',
				'box_exp',
			}
		},
		weapons = {
			type = 'blacklist',					-- whitelist|blacklist
			list = {
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
				'WEAPON_SNOWBALL',
				'T1_WEAPON_KNUCKLE',
				'T1_WEAPON_MACHETE',
				'T1_WEAPON_BOTTLE',
				'T1_WEAPON_POOLCUE',
				'WEAPON_BAT_1H',
				'WEAPON_BAT_1H_2',
				'WEAPON_BAT',
				'WEAPON_GOLFCLUB_1H',
				'WEAPON_GOLFCLUB_1H_2',
				'WEAPON_GOLFCLUB',
				'WEAPON_KNUCKLE',
				'WEAPON_KNUCKLE_2',
				'WEAPON_KNUCKLE_3',
				'WEAPON_KNUCKLE_4',
				'WEAPON_KNUCKLE_5',
				'WEAPON_MACHETE',
				'WEAPON_MACHETE_2',
				'WEAPON_MACHETE_3',
				'WEAPON_BOTTLE',
				'WEAPON_BOTTLE_2',
				'WEAPON_BOTTLE_3',
				'WEAPON_KNIFE',
				'WEAPON_KNIFE_2',
				'WEAPON_KNIFE_3',
				'WEAPON_DAGGER',
				'WEAPON_DAGGER_2',
				'WEAPON_DAGGER_3',
				'WEAPON_POOLCUE',
				'WEAPON_POOLCUE_2',
				'WEAPON_POOLCUE_3',
				'WEAPON_REVOLVER',
				'WEAPON_REVOLVER_MK2',
				'WEAPON_REVOLVER_MK3',
				'WEAPON_FLASHLIGHT',
			}
		}
	}
}

Config.AllowJobsForRobbery = {					-- Jobs ที่อนุญาตให้ทำการปล้นได้
	['unemployed'] = true,
	['police'] = true,
	['ambulnace'] = true,
	['circle'] = true,
	['admin'] = true,
	-- ['offpolice'] = true,
	-- ['offambulance'] = true,
}

Config.OnlineJobsNeedForRobbing = {				-- จำนวนคนใน Jobs ต่างๆที่ต้องการให้ออนไลน์ถึงจะปล้นได้
	 ['police'] = 6,
	-- ['ambulance'] = 1,
}

Config.BlockZone = {							-- Zone ที่ห้ามปล้น
	-- { coords = vector3(0, 0, 0), radius = 15.0 },
}

Config.Keys = {
	use_keybindings = false,				-- เปิดใช้งานระบบ Key Bindings
	default = {								-- ปุ่มแบบ FiveM Default
		rob = 47,							-- ปุ่มกดเพื่อปล้นผู้อื่น
		kneel = 246,						-- ปุ่มกดเพื่อคุกเข่า
		handsup = 73						-- ปุ่มกดเพื่อยกมือ
	},
	keybindings = {
		rob = 'G',							-- ปุ่มกดเพื่อปล้นผู้อื่น
		kneel = 'Y',						-- ปุ่มกดเพื่อคุกเข่า
		handsup = 'X'						-- ปุ่มกดเพื่อยกมือ
	}
}

Config.CustomFont = {							-- Font ของ Text ของตู้เซฟ
	enable = false,
	name = 'font4thai',							-- Default: '$Font2_cond'
	scale = 1.0
}


-- เพิ่มเติม .. หากต้องการ Block ปุ่มกด ให้ใช้คำสั่งดังนี้ (true: Block | false: ยกเลิก Block)
-- exports.nc_thief:BlockKey({ 'KEYS', ... }, true)

-- ตัวอย่างการใช้งาน Block ไม่ให้กดปุ่มปล้นผู้เล่น
-- exports.nc_thief:BlockKey({ 'G' }, true)

-- ตัวอย่างการยกเลิก Block ปุ่ม ให้กลับมาใช้งานได้ดังเดิม
-- exports.nc_thief:BlockKey({ 'G' }, false)

-- ตัวอย่างการ Block ปุ่ม หลายปุ่มในคำสั่งเดียว ให้กลับมาใช้งานได้ดังเดิม
-- exports.nc_thief:BlockKey({ 'G' }, true)

-- * ในกรณี Resource นี้ จะมีแค่ 2 ปุ่มเท่านั้น (G, Y)