-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

-- ให้กระเป๋าแสดง อาวุธที่ผู้เล่นมีในฝั่ง Client (ไม่แนะนำ!! อาจส่งผลให้ Framerate กระชากได้)
Config.ShowClientWeapons = false		-- ยังอยู่ใน BETA โหมด

-- ค่าน้ำหนักเริ่มต้นของอาวุธทุกชนิด
Config.DefaultWeaponWeight = 0

-- ตั้งค่าน้ำหนักแยกของอาวุธชนิดต่างๆต่อ 1 ชิ้น (หน่วยเป็น Kg)
Config.WeaponsWeight = {
	-- ['WEAPON_POOLCUE'] = 1000,
	-- ['WEAPON_BAT'] = 1000,
	-- ['WEAPON_GOLFCLUB'] = 1000,
}

-- ความหายากเริ่มต้นของอาวุธทุกชนิด
Config.DefaultWeaponRarity = 0

-- ความหายากของอาวุธต่างๆ ** หากไม่ใส่ จะมีค่าเท่ากับ 0
Config.WeaponsRarity = {
	-- Rarity 1
	['WEAPON_BAT_1H_2'] = 1,
	['WEAPON_GOLFCLUB_1H_2'] = 1,
	['WEAPON_KNUCKLE_2'] = 1,
	['WEAPON_MACHETE'] = 1,
	['WEAPON_BOTTLE'] = 1,
	
	-- Rarity 2
	['WEAPON_BAT'] = 2,
	['WEAPON_GOLFCLUB'] = 2,
	['WEAPON_KNUCKLE_3'] = 2,
	['WEAPON_MACHETE_2'] = 2,
	['WEAPON_BOTTLE_2'] = 2,
	['WEAPON_KNIFE'] = 2,
	['WEAPON_DAGGER'] = 2,
	['WEAPON_POOLCUE'] = 2,
	['WEAPON_REVOLVER'] = 2,

	-- Rarity 3
	['WEAPON_KNUCKLE_4'] = 3,
	['WEAPON_MACHETE_3'] = 3,
	['WEAPON_BOTTLE_3'] = 3,
	['WEAPON_KNIFE_2'] = 3,
	['WEAPON_DAGGER_2'] = 3,
	['WEAPON_POOLCUE_2'] = 3,
	['WEAPON_REVOLVER_MK2'] = 3,

	-- Rarity 4
	['WEAPON_KNUCKLE_5'] = 4,
	['WEAPON_KNIFE_3'] = 4,
	['WEAPON_DAGGER_3'] = 4,
	['WEAPON_POOLCUE_3'] = 4,
	['WEAPON_REVOLVER_MK3'] = 4,

	-- Rarity 5 (T1 and specific variants)
	

	-- Rarity 6 (Police, circle, and specific variants)
	['WEAPON_STUNGUN'] = 6,
	['WEAPON_PUMPSHOTGUN'] = 6,
	['WEAPON_NIGHTSTICK'] = 6,
	['WEAPON_BOTTLE_SOS'] = 6,
	['WEAPON_SNIPERRIFLE'] = 6,
	['T1_WEAPON_BOTTLE'] = 6,
	['T1_WEAPON_KNUCKLE'] = 6,
	['T1_WEAPON_MACHETE'] = 6,
	['T1_WEAPON_POOLCUE'] = 6,
	['R_WEAPON_BAT'] = 6,
	['R_WEAPON_GOLFCLUB'] = 6,
	['R_WEAPON_KNUCKLE'] = 6,
	['R_WEAPON_MACHETE'] = 6,
	['R_WEAPON_BOTTLE'] = 6,
	['R_WEAPON_KNIFE'] = 6,
	['R_WEAPON_DAGGER'] = 6,
	['R_WEAPON_POOLCUE'] = 6,
}

-- ปิดกระเป๋าเมื่อใช้หยิบ/เก็บอาวุธต่างๆ
Config.CloseInventoryOnUseWeapon = {
	-- 'WEAPON_POOLCUE',
	-- 'WEAPON_BAT',
}

-- ปิดกระเป๋าเมื่อทิ้งอาวุธต่างๆ
Config.CloseInventoryOnDropWeapon = {
	-- 'WEAPON_GOLFCLUB',
}

-- Blacklist ทิ้งอาวุธ/มอบอาวุธ
Config.WeaponsActionList = {
	shortcut = {				-- การลากอาวุธเข้า Shortcuts
		type = 'blacklist',		-- ชนิดของ List ที่ต้องการ (whitelist|blacklist)
		list = {
			'GADGET_PARACHUTE',
			-- 'WEAPON_POOLCUE',
		}
	},
	use = {						-- การ "ใช้" อาวุธ
		type = 'blacklist',
		list = {
			'GADGET_PARACHUTE',
			-- 'WEAPON_POOLCUE',
		}
	},
	drop = {					-- การ "ทิ้ง" อาวุธ
		type = 'blacklist',
		list = {
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
	},
	give = {					-- การ "มอบ" อาวุธ
		type = 'blacklist',
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
	},
	search = {					-- การ "โยกย้าย" อาวุธเมื่อเปิดกระเป๋าผู้เล่น
		type = 'blacklist',
		list = {
			
		}
	}
}
-- การตั้งค่า Action ต่างๆ
-- 'whitelist'	=> อาวุธต่างๆที่อยู่ใน List จะ "อนุญาต" ให้ทำการกระทำนั้นๆ
--				=> โดยที่อาวุธที่ไม่อยู่ใน List จะ "ไม่อนุญาต" ให้ทำการกระทำนั้นๆ
-- 'blacklist'	=> อาวุธต่างๆที่อยู่ใน List จะ "ไม่อนุญาต" ให้ทำการกระทำนั้นๆ
--				=> โดยที่อาวุธที่ไม่อยู่ใน List จะ "อนุญาต" ให้ทำการกระทำนั้นๆ

Config.NoAmmoWeapons = {
	'WEAPON_NIGHTSTICK',
	'WEAPON_BOTTLE_SOS',
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
	'WEAPON_FLASHLIGHT',
	'WEAPON_STUNGUN',
	'WEAPON_SNIPERRIFLE',
	'GADGET_PARACHUTE',
}


-- Animations
Config.SkipAnimationOnUseAllWeapon = false		-- เปิด/ปิด Animation หยิบ/เก็บ อาวุธเมื่อกดใช้งานอาวุธทุกชิ้น
Config.SkipAnimationOnUseEachWeapon = {			-- เปิด/ปิด Animation หยิบ/เก็บ อาวุธเมื่อกดใช้งานอาวุธที่อยู่ในรายชื่อ
	--'WEAPON_NIGHTSTICK',
	--'WEAPON_STUNGUN',
	--'WEAPON_PUMPSHOTGUN',
	--'WEAPON_SWITCHBLADE',
	--'WEAPON_PISTOL_MK2',
	--'WEAPON_TACTICALRIFLE',
	--'WEAPON_SNIPERRIFLE',
}

-- ท่า หยิบ/เก็บ อาวุธเมื่อกดใช้งานอาวุธ
Config.WeaponAnimations = {
	default = {					-- ค่าเริ่มต้น (หากไม่มีการตั้งค่าใน customs)
		put_in = {
			enable = true,
			dict = 'reaction@intimidation@1h',
			anim = 'outro',
			flag = 50,
			action_on = 1800,
			duration = 1900
		},
		take_out = {
			enable = true,
			dict = 'reaction@intimidation@1h',
			anim = 'intro',
			flag = 50,
			action_on = 800,
			duration = 2600
		}
	},
	customs = {
		['WEAPON_SWITCHBLADE'] = {
			put_in = {
				enable = false,
				dict = 'anim@melee@switchblade@holster',
				anim = 'holster',
				flag = 50,
				action_on = 1400,
				duration = 1900
			},
			take_out = {
				enable = false,
				dict = 'anim@melee@switchblade@holster',
				anim = 'unholster',
				flag = 50,
				action_on = 200,
				duration = 2000
			}
		},
		['WEAPON_STUNGUN'] = {
			put_in = {
				enable = false,
				dict = 'anim@melee@switchblade@holster',
				anim = 'holster',
				flag = 50,
				action_on = 1400,
				duration = 1900
			},
			take_out = {
				enable = false,
				dict = 'anim@melee@switchblade@holster',
				anim = 'unholster',
				flag = 50,
				action_on = 200,
				duration = 2000
			}
		},
		['WEAPON_PUMPSHOTGUN'] = {
			put_in = {
				enable = false,
				dict = 'anim@melee@switchblade@holster',
				anim = 'holster',
				flag = 50,
				action_on = 1400,
				duration = 1900
			},
			take_out = {
				enable = false,
				dict = 'anim@melee@switchblade@holster',
				anim = 'unholster',
				flag = 50,
				action_on = 200,
				duration = 2000
			}
		},
		['WEAPON_PISTOL_MK2'] = {
			put_in = {
				enable = false,
				dict = 'anim@melee@switchblade@holster',
				anim = 'holster',
				flag = 50,
				action_on = 1400,
				duration = 1900
			},
			take_out = {
				enable = false,
				dict = 'anim@melee@switchblade@holster',
				anim = 'unholster',
				flag = 50,
				action_on = 200,
				duration = 2000
			}
		},
		['WEAPON_TACTICALRIFLE'] = {
			put_in = {
				enable = false,
				dict = 'anim@melee@switchblade@holster',
				anim = 'holster',
				flag = 50,
				action_on = 1400,
				duration = 1900
			},
			take_out = {
				enable = false,
				dict = 'anim@melee@switchblade@holster',
				anim = 'unholster',
				flag = 50,
				action_on = 200,
				duration = 2000
			}
		},
		['WEAPON_SNIPERRIFLE'] = {
			put_in = {
				enable = false,
				dict = 'anim@melee@switchblade@holster',
				anim = 'holster',
				flag = 50,
				action_on = 1400,
				duration = 1900
			},
			take_out = {
				enable = false,
				dict = 'anim@melee@switchblade@holster',
				anim = 'unholster',
				flag = 50,
				action_on = 200,
				duration = 2000
			}
		},
		['WEAPON_NIGHTSTICK'] = {
			put_in = {
				enable = false,
				dict = 'anim@melee@switchblade@holster',
				anim = 'holster',
				flag = 50,
				action_on = 1400,
				duration = 1900
			},
			take_out = {
				enable = false,
				dict = 'anim@melee@switchblade@holster',
				anim = 'unholster',
				flag = 50,
				action_on = 200,
				duration = 2000
			}
		},
		['WEAPON_MUSKET'] = {
			put_in = {
				enable = false,
				dict = 'anim@melee@switchblade@holster',
				anim = 'holster',
				flag = 50,
				action_on = 1400,
				duration = 1900
			},
			take_out = {
				enable = false,
				dict = 'anim@melee@switchblade@holster',
				anim = 'unholster',
				flag = 50,
				action_on = 200,
				duration = 2000
			}
		},
	}
}