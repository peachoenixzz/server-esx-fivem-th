-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

-- การเงินที่ต้องการให้แสดงในกระเป๋าส่วนตัว
Config.Accounts = {
	['money'] = true,
	['bank'] = false,
	['black_money'] = true,
}

-- Icon ของเงินชนิดต่างๆ (สำหรับกระเป๋าสองชนิด price)
Config.AccountsIcon = {
	['money'] = './img/assets/icon_money.png',
	['bank'] = './img/assets/icon_bank.png',
	['black_money'] = './img/assets/icon_black_money.png'
}

-- ค่าน้ำหนักเริ่มต้นของเงินทุกชนิด
Config.DefaultAccountWeight = 0

-- ตั้งค่าน้ำหนักแยกของเงินชนิดต่างๆทุกๆ $1 (หน่วยเป็น Kg)
Config.AccountsWeight = {
	-- ['money'] = 1,
	-- ['bank'] = 1,
	-- ['black_money'] = 1,
}

-- ความหายากเริ่มต้นของเงินทุกชนิด
Config.DefaultAccountRarity = 0

-- ความหายากของเงินชนิดต่างๆ ** หากไม่ใส่ จะมีค่าเท่ากับ 0
Config.AccountsRarity = {
	 ['money'] = 0,
	 ['black_money'] = 0,
}

-- ปิดกระเป๋าเมื่อทิ้งเงินชนิดต่างๆ
Config.CloseInventoryOnDropAccount = {
	'money',
	'black_money',
}

-- Blacklist ทิ้งเงิน/มอบเงิน
Config.AccountsActionList = {
	drop = {					-- การ "ทิ้ง" เงินชนิดต่างๆ
		type = 'blacklist',
		list = {
			'bank',
		}
	},
	give = {					-- การ "มอบ" เงินชนิดต่างๆ
		type = 'blacklist',
		list = {
			'bank',
		}
	},
	search = {					-- การ "โยกย้าย" เงินชนิดต่างๆเมื่อเปิดกระเป๋าผู้เล่น
		type = 'blacklist',
		list = {
			'bank',
		}
	}
}