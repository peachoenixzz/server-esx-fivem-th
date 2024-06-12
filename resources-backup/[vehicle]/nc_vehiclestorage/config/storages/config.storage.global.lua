-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config.Storages.Global.AllowedList = {
	['inside'] = {							-- ช่องเก็บของภายในรถ
		accounts = {
			type = 'whitelist',				-- whitelist|blacklist
			list = {						-- รายการของสิ่งของประเภทเงิน (ชนิดของรายการเป็น Array)
				'black_money'
			}
		},
		items = {
			type = 'blacklist',				-- whitelist|blacklist
			list = {						-- รายการของสิ่งของทั่วไป (ชนิดของรายการเป็น Array)
				
			}
		},
		weapons = {
			type = 'blacklist',				-- whitelist|blacklist
			list = {						-- รายการของอาวุธ (ชนิดของรายการเป็น Array)

			}
		}
	},
	['trunk'] = {							-- ช่องเก็บของท้ายรถ
		accounts = {
			type = 'whitelist',				-- whitelist|blacklist
			list = {						-- รายการของสิ่งของประเภทเงิน (ชนิดของรายการเป็น Array)
				"black_money",
			}
		},
		items = {
			type = 'blacklist',				-- whitelist|blacklist
			list = {						-- รายการของสิ่งของทั่วไป (ชนิดของรายการเป็น Array)
				"card_reskin",
				"card_lastname",
				"auto_1h",
				"gum_mining",
				"gum_eco",
				"card_vip",
				"cron",
				"heart_100",
				"ad_blessing",
				"ad_clipper",
				"ad_spray",
				"vault_master",
				"ad_bag",
				"busker",
				"starter_kit",
				"box_rcar",
				"gacha_support",
				"vault_md",
				"vault_pd",
				"card_gang",
				"megaphone",
				"gov_radio",
				"gov_vest",
				"gov_tablet",
				"pt_all",
				"r_bandage",
				"r_painkiller",
				"r_vest",
				"r_aed",
				"t1_box_knuckle",
				"t1_box_machete",
				"t1_box_bottle",
				"t1_box_poolcue",
				"t1_player",
				"skateboard",
				"snow_gloves",
				"hifi",
				"rose_1",
				"rose_2",
				"painkiller",
				"card_nplayer",
				"vault_key",
				"quest_a",
				"quest_b",
				"casino_chip",
				"card_afk",
				"exp",
				"weapon_box_unt",
				"key_gang",
				"radio",
				"gacha_5",
				"gacha_5_1",
				"gacha_5_2",
				"gacha_5_3",
				"gacha_5_4",
				"exp_gang",
				"house_silver",
				"house_gold",
				"house_red",
				"rental_3d",
				"rental_7d",
				"rental_15d",
				"coin_killer",
				"r_adrenaline",
				"player_mask",
				"card_id",
				"card_family",
				"card_vault",
				"exp_vault",
				"ad_bell",
				"gacha_event",
				"fashion_0",
				"baby1",
				"baby2",
				"baby3",
				"baby4",
				"baby5",
				"baby6",
				"baby7",
				"baby8",
				"spacpup",
				"spacpupb",
				"spacpupc",
				"spacpupd",
				"spacpupe",
				"spacpupf",
				"summersocute1",
				"summersocute2",
				"summersocute3",
				"summersocute4",
				"summersocute5",
				"summersocute6",
				"gov_help",
				"vest",
				"helmet",
				"booster1",
				"booster2",
				"booster3",
				"card_wvault",
				"box_ad_citizen",
				"box_ad_family",
				"box_ad_gang",
				"box_sa_citizen",
				"box_sa_family",
				"box_sa_gang",
				"gov_painkiller",
				"box_exp",
				"box_gunpart",
			}
		},
		weapons = {
			type = 'blacklist',				-- whitelist|blacklist
			list = {						-- รายการของอาวุธ (ชนิดของรายการเป็น Array)
				"WEAPON_STUNGUN",
				"WEAPON_PUMPSHOTGUN",
				"WEAPON_NIGHTSTICK",
				"WEAPON_BOTTLE_SOS",
				"WEAPON_SNIPERRIFLE",
				"R_WEAPON_BAT",
				"R_WEAPON_GOLFCLUB",
				"R_WEAPON_KNUCKLE",
				"R_WEAPON_MACHETE",
				"R_WEAPON_BOTTLE",
				"R_WEAPON_KNIFE",
				"R_WEAPON_DAGGER",
				"R_WEAPON_POOLCUE",
				"WEAPON_SNOWBALL",
				"T1_WEAPON_KNUCKLE",
				"T1_WEAPON_MACHETE",
				"T1_WEAPON_BOTTLE",
				"T1_WEAPON_POOLCUE",
				"WEAPON_BAT_1H",
				"WEAPON_BAT_1H_2",
				"WEAPON_BAT",
				"WEAPON_GOLFCLUB_1H",
				"WEAPON_GOLFCLUB_1H_2",
				"WEAPON_GOLFCLUB",
				"WEAPON_KNUCKLE",
				"WEAPON_KNUCKLE_2",
				"WEAPON_KNUCKLE_3",
				"WEAPON_KNUCKLE_4",
				"WEAPON_KNUCKLE_5",
				"WEAPON_MACHETE",
				"WEAPON_MACHETE_2",
				"WEAPON_MACHETE_3",
				"WEAPON_BOTTLE",
				"WEAPON_BOTTLE_2",
				"WEAPON_BOTTLE_3",
				"WEAPON_KNIFE",
				"WEAPON_KNIFE_2",
				"WEAPON_KNIFE_3",
				"WEAPON_DAGGER",
				"WEAPON_DAGGER_2",
				"WEAPON_DAGGER_3",
				"WEAPON_POOLCUE",
				"WEAPON_POOLCUE_2",
				"WEAPON_POOLCUE_3",
				"WEAPON_REVOLVER",
				"WEAPON_REVOLVER_MK2",
				"WEAPON_REVOLVER_MK3",
				"WEAPON_FLASHLIGHT",
			}
		}
	}
}