-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config.Storages.Models['TOROS'] = {
	['inside'] = {								-- ช่องเก็บของภายในรถ
		allowed_seats = { -1, 0 },				-- ที่นั่งที่สามารถใช้งานช่องเก็บของภายในยานพาหนะได้
		slot = 0,								-- จำนวนช่องทั้งหมดที่สามารถเก็บสิ่งของได้
		weight = 0,								-- จำนวนน้ำหนักทั้งหมดที่สามารถเก็บสิ่งของได้
		total_account_limit = 0,			-- จำนวนสูงสุดของสิ่งของประเภทเงินที่สามารถเก็บได้ (-1 : ไม่จำกัด)
		total_item_limit = 0,					-- จำนวนสูงสุดของสิ่งของทั่วไปที่สามารถเก็บได้ (-1 : ไม่จำกัด)
		total_weapon_limit = 0,					-- จำนวนสูงสุดของอาวุธที่สามารถเก็บได้ 1 ชิ้น/ช่อง (-1 : ไม่จำกัด)
		allow_accounts = false,					-- การเปิดใช้งานให้สามารถเก็บสิ่งของประเภทเงินได้
		allow_items = false,					-- การเปิดใช้งานให้สามารถเก็บสิ่งของทั่วไปได้
		allow_weapons = false,					-- การเปิดใช้งานให้สามารถอาวุธได้
		allowed_list = {						-- รายการ whitelist/blacklist ต่างๆ
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
		only_owner = true						-- เฉพาะเจ้าของยานพาหนะสามารถใช้งานได้
	},
	['trunk'] = {								-- ช่องเก็บของท้ายรถ
		action_radius = 3.1,					-- ระยะที่สามารถเปิดท้ายรถได้
		slot = -1,								-- จำนวนช่องทั้งหมดที่สามารถเก็บสิ่งของได้
		weight = 301,								-- จำนวนน้ำหนักทั้งหมดที่สามารถเก็บสิ่งของได้
		total_account_limit = -1,				-- จำนวนสูงสุดของสิ่งของประเภทเงินที่สามารถเก็บได้ (-1 : ไม่จำกัด)
		total_item_limit = -1,					-- จำนวนสูงสุดของสิ่งของทั่วไปที่สามารถเก็บได้ (-1 : ไม่จำกัด)
		total_weapon_limit = 0,					-- จำนวนสูงสุดของอาวุธที่สามารถเก็บได้ 1 ชิ้น/ช่อง (-1 : ไม่จำกัด)
		allow_accounts = true,					-- การเปิดใช้งานให้สามารถเก็บสิ่งของประเภทเงินได้
		allow_items = true,					-- การเปิดใช้งานให้สามารถเก็บสิ่งของทั่วไปได้
		allow_weapons = false,					-- การเปิดใช้งานให้สามารถอาวุธได้
		allowed_list = {						-- รายการ whitelist/blacklist ต่างๆ
			accounts = {
				type = 'whitelist',				-- whitelist|blacklist
				list = {						-- รายการของสิ่งของประเภทเงิน (ชนิดของรายการเป็น Array)

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
		only_owner = true						-- เฉพาะเจ้าของยานพาหนะสามารถใช้งานได้
	}
}