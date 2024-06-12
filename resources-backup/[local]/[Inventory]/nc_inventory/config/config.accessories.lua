-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

-- ให้ระบบบันทึกข้อมูลเสื้อผ้าและเครื่องประดับไปยัง Server เมื่อสวมใส่หรือถอดออก (ต้องการ esx_skin)
Config.SaveSkinOnChangingCloth = false

-- เครื่องประดับ
Config.AccessoryActions = {
	can_use = true,			-- สามารถใช้งานเครื่องประดับได้หรือไม่
	can_drop = true,		-- สามารถทิ้งเครื่องประดับได้หรือไม่
	can_give = true,		-- สามารถมอบเครื่องประดับให้ผู้อื่นได้หรือไม่
	can_shortcut = true		-- สามารถใช้งานเครื่องประดับใน Shortcuts ได้หรือไม่
}

-- รายชื่อเครื่องประดับที่ต้องการให้แสดงในกระเป๋า (โดยชื่อจะอิงจาก Database)
Config.AllowAccessories = {
	['player_bags'] = false,
	['player_bracelet'] = false,
	['player_clothes'] = false,
	['player_ears'] = true,
	['player_glasses'] = true,
	['player_helmet'] = true,
	['player_mask'] = true,
	['player_pants'] = true,
	['player_shoes'] = true,
	['player_watch'] = true,
}

-- ความหายากเริ่มต้นของเครื่องประดับ
Config.DefaultAccessoryRarity = 0

-- ความหายากของเครื่องประดับต่างๆ ** หากไม่ใส่ จะมีค่าเท่ากับ 0
Config.AccessoriesRarity = {
	  ['player_mask'] = 0,
}

-- ปิดกระเป๋าเมื่อใช้งานเครื่องประดับชนิดต่างๆ
Config.CloseInventoryOnWearingAccessory = {
	'player_bags',
	'player_bracelet',
	'player_clothes',
	'player_ears',
	'player_glasses',
	'player_helmet',
	'player_mask',
	'player_pants',
	'player_shoes',
	'player_watch',
}

-- ปิดกระเป๋าเมื่อเครื่องประดับต่างๆ
Config.CloseInventoryOnDropAccessory = {
	'player_bags',
	'player_bracelet',
	'player_clothes',
	'player_ears',
	'player_glasses',
	'player_helmet',
	'player_mask',
	'player_pants',
	'player_shoes',
	'player_watch',
}

-- ค่าตั้งต้นของเครื่องประดับต่างๆ หากถอดออก
Config.AccessoriesDefault = {
	['player_bags'] = {
		[`mp_m_freemode_01`] = {		-- Model ตัวละครผู้ชาย
			['bags_1'] = -1,
			['bags_2'] = 1
		},
		[`mp_f_freemode_01`] = {		-- Model ตัวละครผู้หญิง
			['bags_1'] = -1,
			['bags_2'] = 1
		}
	},
	['player_bracelet'] = {
		[`mp_m_freemode_01`] = {		-- Model ตัวละครผู้ชาย
			['bracelets_1'] = -1,
			['bracelets_2'] = 0
		},
		[`mp_f_freemode_01`] = {		-- Model ตัวละครผู้หญิง
			['bracelets_1'] = -1,
			['bracelets_2'] = 0
		}
	},
	['player_clothes'] = {
		[`mp_m_freemode_01`] = {		-- Model ตัวละครผู้ชาย
			['torso_1'] = 15,
			['torso_2'] = 0,
			['tshirt_1'] = 15,
			['tshirt_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 15,
			['arms_2'] = 0,
		},
		[`mp_f_freemode_01`] = {		-- Model ตัวละครผู้หญิง
			['torso_1'] = 74,
			['torso_2'] = 0,
			['tshirt_1'] = 15,
			['tshirt_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 15,
			['arms_2'] = 0,
		}
	},
	['player_ears'] = {
		[`mp_m_freemode_01`] = {		-- Model ตัวละครผู้ชาย
			['ears_1'] = -1,
			['ears_2'] = 0
		},
		[`mp_f_freemode_01`] = {		-- Model ตัวละครผู้หญิง
			['ears_1'] = -1,
			['ears_2'] = 0
		}
	},
	['player_glasses'] = {
		[`mp_m_freemode_01`] = {		-- Model ตัวละครผู้ชาย
			['glasses_1'] = -1,
			['glasses_2'] = 0
		},
		[`mp_f_freemode_01`] = {		-- Model ตัวละครผู้หญิง
			['glasses_1'] = -1,
			['glasses_2'] = 0
		}
	},
	['player_helmet'] = {
		[`mp_m_freemode_01`] = {		-- Model ตัวละครผู้ชาย
			['helmet_1'] = -1,
			['helmet_2'] = 0
		},
		[`mp_f_freemode_01`] = {		-- Model ตัวละครผู้หญิง
			['helmet_1'] = -1,
			['helmet_2'] = 0
		}
	},
	['player_mask'] = {
		[`mp_m_freemode_01`] = {		-- Model ตัวละครผู้ชาย
			['mask_1'] = -1,
			['mask_2'] = 0
		},
		[`mp_f_freemode_01`] = {		-- Model ตัวละครผู้หญิง
			['mask_1'] = -1,
			['mask_2'] = 0
		}
	},
	['player_pants'] = {
		[`mp_m_freemode_01`] = {		-- Model ตัวละครผู้ชาย
			['pants_1'] = 61,
			['pants_2'] = 0
		},
		[`mp_f_freemode_01`] = {		-- Model ตัวละครผู้หญิง
			['pants_1'] = 14,
			['pants_2'] = 0
		}
	},
	['player_shoes'] = {
		[`mp_m_freemode_01`] = {		-- Model ตัวละครผู้ชาย
			['shoes_1'] = 34,
			['shoes_2'] = 0
		},
		[`mp_f_freemode_01`] = {		-- Model ตัวละครผู้หญิง
			['shoes_1'] = 35,
			['shoes_2'] = 0
		}
	},
	['player_watch'] = {
		[`mp_m_freemode_01`] = {		-- Model ตัวละครผู้ชาย
			['watches_1'] = -1,
			['watches_2'] = 0
		},
		[`mp_f_freemode_01`] = {		-- Model ตัวละครผู้หญิง
			['watches_1'] = -1,
			['watches_2'] = 0
		}
	},
}

-- Animation ขณะ สวมใส่/ถอด เครื่องประดับชนิดต่างๆ
Config.AccessoriesAnimation = {
	['player_bags'] = {
		on = {												-- สวมใส่
			dict = 'anim@heists@ornate_bank@grab_cash',		-- Animation Dictionary
			anim = 'intro',									-- Animation
			flag = 48,										-- Animation Flag
			action_on = 1200,								-- เวลาสวมใส่เครื่องประดับ
			duration = 1600									-- ระยะเวลาการทำ Animation ทั้งหมด
		},
		off = {												-- ถอดออก
			dict = 'anim@heists@ornate_bank@grab_cash',
			anim = 'intro',
			flag = 48,
			action_on = 1200,
			duration = 1600
		}
	},
	['player_bracelet'] = {
		on = {
			dict = 'nmt_3_rcm-10',
			anim = 'cs_nigel_dual-10',
			flag = 48,
			action_on = 1200,
			duration = 1200
		},
		off = {
			dict = 'nmt_3_rcm-10',
			anim = 'cs_nigel_dual-10',
			flag = 48,
			action_on = 1200,
			duration = 1200
		}
	},
	['player_clothes'] = {
		on = {
			dict = 'clothingtie',
			anim = 'try_tie_negative_a',
			flag = 48,
			action_on = 1000,
			duration = 1100
		},
		off = {
			dict = 'clothingtie',
			anim = 'try_tie_negative_a',
			flag = 48,
			action_on = 1000,
			duration = 1100
		}
	},
	['player_ears'] = {
		on = {
			dict = 'mini@ears_defenders',
			anim = 'takeoff_earsdefenders_idle',
			flag = 48,
			action_on = 400,
			duration = 900
		},
		off = {
			dict = 'mini@ears_defenders',
			anim = 'takeoff_earsdefenders_idle',
			flag = 48,
			action_on = 400,
			duration = 900
		}
	},
	['player_glasses'] = {
		on = {
			dict = 'clothingspecs',
			anim = 'take_off',
			flag = 48,
			action_on = 1000,
			duration = 1100
		},
		off = {
			dict = 'clothingspecs',
			anim = 'take_off',
			flag = 48,
			action_on = 1000,
			duration = 1100
		}
	},
	['player_helmet'] = {
		on = {
			dict = 'veh@bicycle@roadfront@base',
			anim = 'put_on_helmet',
			flag = 48,
			action_on = 1100,
			duration = 1400
		},
		off = {
			dict = 'veh@bike@common@front@base',
			anim = 'take_off_helmet_walk',
			flag = 48,
			action_on = 700,
			duration = 1200
		}
	},
	['player_mask'] = {
		on = {
			dict = 'veh@bicycle@roadfront@base',
			anim = 'put_on_helmet',
			flag = 48,
			action_on = 1100,
			duration = 1400
		},
		off = {
			dict = 'veh@bike@common@front@base',
			anim = 'take_off_helmet_walk',
			flag = 48,
			action_on = 700,
			duration = 1200
		}
	},
	['player_pants'] = {
		on = {
			dict = 're@construction',
			anim = 'out_of_breath',
			flag = 48,
			action_on = 1000,
			duration = 1100
		},
		off = {
			dict = 're@construction',
			anim = 'out_of_breath',
			flag = 48,
			action_on = 1000,
			duration = 1100
		}
	},
	['player_shoes'] = {
		on = {
			dict = 'random@domestic',
			anim = 'pickup_low',
			flag = 48,
			action_on = 800,
			duration = 900
		},
		off = {
			dict = 'random@domestic',
			anim = 'pickup_low',
			flag = 48,
			action_on = 800,
			duration = 900
		}
	},
	['player_watch'] = {
		on = {
			dict = 'nmt_3_rcm-10',
			anim = 'cs_nigel_dual-10',
			flag = 48,
			action_on = 1200,
			duration = 1200
		},
		off = {
			dict = 'nmt_3_rcm-10',
			anim = 'cs_nigel_dual-10',
			flag = 48,
			action_on = 1200,
			duration = 1200
		}
	},
}