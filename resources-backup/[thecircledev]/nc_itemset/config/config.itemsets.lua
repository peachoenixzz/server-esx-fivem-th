-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config.ItemSets = {
	['starter_kit'] = {
		type = 'package', -- package, selection, gachapon
		allow_multiple = false, -- true หากสามารถเปิดทีเดียวพร้อมกันได้หลาย ๆ ชิ้น
		list = {
			{ type = 'account', name = 'money', count = 10000 },
			{ type = 'item', name = 'Phone', count = 1 },
			{ type = 'item', name = 'toolkit', count = 5 },
			{ type = 'item', name = 'meal_mre', count = 5 },
			{ type = 'item', name = 'card_nplayer', count = 1 },
			{ type = 'item', name = 'card_reskin', count = 1 },
			{ type = 'item', name = 'card_vault', count = 1 },
			{ type = 'item', name = 'card_wvault', count = 1 },
			{ type = 'item', name = 'fashion_0', count = 1 },
			{ type = 'item', name = 'vault_key', count = 1 },
			{ type = 'item', name = 'weapon_box', count = 1 },
			{ type = 'vehicle', name = 'shabutrain' },
			{ type = 'item', name = 'box_rcar', count = 1 },
			{ type = 'item', name = 'gacha_support', count = 50 },
		}
	},
	['gacha_support'] = {
		type = 'gachapon', -- package, selection, gachapon
		allow_multiple = true, -- true หากสามารถเปิดทีเดียวพร้อมกันได้หลาย ๆ ชิ้น
		list = { -- Required
			{ type = 'item', name = 'alloy', count = { 1, 1 }, score = 0.5 },
			{ type = 'item', name = 'weapon_box', count = { 1, 1 }, score = 1 },
			{ type = 'item', name = 'gum_eco', count = { 1, 1 }, score = 1.25 },
			{ type = 'item', name = 'gum_mining', count = { 1, 1 }, score = 1.25 },
			{ type = 'item', name = 'meal_mre', count = { 1, 1 }, score = 2 },
			{ type = 'item', name = 'card_afk', count = { 1, 1 }, score = 2.5 },
			{ type = 'item', name = 'exp', count = { 1, 2 }, score = 2.5 },
			{ type = 'account', name = 'money', count = { 1000, 1500 }, score = 3 },
			{ type = 'item', name = 'vest', count = { 1, 2 }, score = 4 },
			{ type = 'item', name = 'diamond', count = { 1, 3 }, score = 4.5 },
			{ type = 'item', name = 'ruby', count = { 1, 3 }, score = 4.5 },						
			{ type = 'item', name = 'meal_1', count = { 1, 1 }, score = 5 },
			{ type = 'item', name = 'meal_3', count = { 1, 1 }, score = 6 },
			{ type = 'item', name = 'bandage', count = { 1, 3 }, score = 8 },
			{ type = 'account', name = 'money', count = { 300, 500 }, score = 9 },
			{ type = 'item', name = 'work_kit', count = { 1, 1 }, score = 10 },
		}
	},
	['gacha_event'] = {
		type = 'gachapon', -- package, selection, gachapon
		allow_multiple = true, -- true หากสามารถเปิดทีเดียวพร้อมกันได้หลาย ๆ ชิ้น
		list = { -- Required
			{ type = 'vehicle', name = 'shabuufocar', count = 1, score = 0.001 },
			{ type = 'item', name = 'alloy', count = { 1, 1 }, score = 0.5 },
			{ type = 'item', name = 'weapon_box', count = { 1, 2 }, score = 1 },
			{ type = 'item', name = 'meal_mre', count = { 1, 2 }, score = 2 },
			{ type = 'item', name = 'card_afk', count = { 1, 1 }, score = 3 },
			{ type = 'item', name = 'exp', count = { 1, 3 }, score = 4 },
			{ type = 'item', name = 'steel_3', count = { 1, 3 }, score = 5 },
			{ type = 'account', name = 'money', count = { 1500, 3000 }, score = 6 },
			{ type = 'item', name = 'vest', count = { 1, 3 }, score = 7 },
			{ type = 'item', name = 'diamond', count = { 3, 5 }, score = 8 },
			{ type = 'item', name = 'ruby', count = { 3, 5 }, score = 8 },
			{ type = 'item', name = 'weed_pack', count = { 1, 2 }, score = 9 },						
			{ type = 'account', name = 'money', count = { 1000, 1500 }, score = 10 },
		}
	},
	['fashion_0'] = {
		type = 'gachapon', -- package, selection, gachapon
		allow_multiple = false, -- true หากสามารถเปิดทีเดียวพร้อมกันได้หลาย ๆ ชิ้น
		list = { -- Required
			{ type = 'item', name = 'baby1', count = 1, score = 1 },
			{ type = 'item', name = 'baby2', count = 1, score = 1 },
			{ type = 'item', name = 'baby3', count = 1, score = 1 },
			{ type = 'item', name = 'baby4', count = 1, score = 1 },
			{ type = 'item', name = 'baby5', count = 1, score = 1 },
			{ type = 'item', name = 'baby6', count = 1, score = 1 },
			{ type = 'item', name = 'baby7', count = 1, score = 1 },
			{ type = 'item', name = 'baby8', count = 1, score = 1 },				
		}
	},
	['box_rcar'] = {
		type = 'gachapon', -- package, selection, gachapon
		allow_multiple = false, -- true หากสามารถเปิดทีเดียวพร้อมกันได้หลาย ๆ ชิ้น
		list = { -- Required
			{ type = 'vehicle', name = 'thrax', count = 1, score = 2 },
			{ type = 'vehicle', name = 'italigtb2', count = 1, score = 4 },
			{ type = 'vehicle', name = 'italigtb', count = 1, score = 6 },
			{ type = 'vehicle', name = 'furia', count = 1, score = 8 },
			{ type = 'vehicle', name = 'jester', count = 1, score = 10 },
		}
	},
	['rental_3d'] = {
		type = 'package', -- package, selection, gachapon
		allow_multiple = false, -- true หากสามารถเปิดทีเดียวพร้อมกันได้หลาย ๆ ชิ้น
		list = { -- Required
			{ type = 'vehicle', name = 'toros', count = 1 },
		}
	},
	['rental_7d'] = {
		type = 'package', -- package, selection, gachapon
		allow_multiple = false, -- true หากสามารถเปิดทีเดียวพร้อมกันได้หลาย ๆ ชิ้น
		list = { -- Required
			{ type = 'vehicle', name = 'toros', count = 1 },
		}
	},
	['rental_15d'] = {
		type = 'package', -- package, selection, gachapon
		allow_multiple = false, -- true หากสามารถเปิดทีเดียวพร้อมกันได้หลาย ๆ ชิ้น
		list = { -- Required
			{ type = 'vehicle', name = 'toros', count = 1 },
		}
	},
	['box_ad_citizen'] = {
		type = 'gachapon', -- package, selection, gachapon
		allow_multiple = true, -- true หากสามารถเปิดทีเดียวพร้อมกันได้หลาย ๆ ชิ้น
		list = { -- Required
			{ type = 'account', name = 'black_money', count = 1000, score = 10 },
			{ type = 'item', name = 'cron', count = 1, score = 2.5 },
			{ type = 'item', name = 'heart_70', count = 1, score = 1},
			{ type = 'item', name = 'alloy', count = 1, score = 0.05 },
		}
	},
	['box_ad_family'] = {
		type = 'gachapon', -- package, selection, gachapon
		allow_multiple = true, -- true หากสามารถเปิดทีเดียวพร้อมกันได้หลาย ๆ ชิ้น
		list = { -- Required
			{ type = 'account', name = 'black_money', count = 1000, score = 10 },
			{ type = 'item', name = 'diamond', count = 5, score = 7 },
			{ type = 'item', name = 'cron', count = 2, score = 2.5 },
			{ type = 'item', name = 'radio_board', count = 1, score = 1.5 },			
			{ type = 'item', name = 'heart_70', count = 1, score = 1 },
			{ type = 'item', name = 'alloy', count = 1, score = 0.1 },
		}
	},
	['box_ad_gang'] = {
		type = 'gachapon', -- package, selection, gachapon
		allow_multiple = true, -- true หากสามารถเปิดทีเดียวพร้อมกันได้หลาย ๆ ชิ้น
		list = { -- Required
			{ type = 'account', name = 'black_money', count = 1000, score = 10 },
			{ type = 'item', name = 'diamond', count = 10, score = 7 },
			{ type = 'item', name = 'cron', count = 3, score = 2.5 },
			{ type = 'item', name = 'radio_board', count = 1, score = 1.5 },			
			{ type = 'item', name = 'heart_90', count = 1, score = 1 },
			{ type = 'item', name = 'alloy', count = 1, score = 0.1 },
		}
	},
	['box_sa_citizen'] = {
		type = 'gachapon', -- package, selection, gachapon
		allow_multiple = true, -- true หากสามารถเปิดทีเดียวพร้อมกันได้หลาย ๆ ชิ้น
		list = { -- Required
			{ type = 'item', name = 'cron', count = 2, score = 10 },
			{ type = 'item', name = 'heart_70', count = 1, score = 2.5 },	
			{ type = 'item', name = 'gacha_5', count = 3, score = 1 },
			{ type = 'item', name = 'alloy', count = 1, score = 0.05 },			
			{ type = 'vehicle', name = 'shabuufocar', count = 1, score = 0.001 },
		}
	},
	['box_sa_family'] = {
		type = 'gachapon', -- package, selection, gachapon
		allow_multiple = true, -- true หากสามารถเปิดทีเดียวพร้อมกันได้หลาย ๆ ชิ้น
		list = { -- Required
			{ type = 'item', name = 'cron', count = 3, score = 10 },
			{ type = 'item', name = 'diamond', count = 5, score = 7 },
			{ type = 'item', name = 'heart_70', count = 1, score = 2.5 },
			{ type = 'item', name = 'gacha_5', count = 3, score = 1 },	
			{ type = 'item', name = 'alloy', count = 1, score = 0.07 },	
			{ type = 'vehicle', name = 'entity2', count = 1, score = 0.005 },		
			{ type = 'vehicle', name = 'shabuufocar', count = 1, score = 0.001 },
		}
	},
	['box_sa_gang'] = {
		type = 'gachapon', -- package, selection, gachapon
		allow_multiple = true, -- true หากสามารถเปิดทีเดียวพร้อมกันได้หลาย ๆ ชิ้น
		list = { -- Required
			{ type = 'item', name = 'cron', count = 4, score = 10 },
			{ type = 'item', name = 'diamond', count = 10, score = 7 },
			{ type = 'item', name = 'heart_90', count = 1, score = 2.5 },
			{ type = 'item', name = 'gacha_5', count = 3, score = 1 },	
			{ type = 'item', name = 'alloy', count = 1, score = 0.07 },	
			{ type = 'vehicle', name = 'entity2', count = 1, score = 0.005 },		
			{ type = 'vehicle', name = 'shabuufocar', count = 1, score = 0.001 },
		}
	},
	['box_exp'] = {
		type = 'gachapon', -- package, selection, gachapon
		allow_multiple = true, -- true หากสามารถเปิดทีเดียวพร้อมกันได้หลาย ๆ ชิ้น
		list = { -- Required
			{ type = 'item', name = 'exp', count = { 5, 15 } },
		}
	},
	['box_gunpart'] = {
		type = 'selection', -- package, selection, gachapon
		allow_multiple = true, -- true หากสามารถเปิดทีเดียวพร้อมกันได้หลาย ๆ ชิ้น
		list = { -- Required
			{ type = 'item', name = 'revolver_1', count = 1 },
			{ type = 'item', name = 'revolver_2', count = 1 },
			{ type = 'item', name = 'revolver_3', count = 1 },	
		}
	},
	['box_amp'] = {
		type = 'gachapon', -- package, selection, gachapon
		allow_multiple = true, -- true หากสามารถเปิดทีเดียวพร้อมกันได้หลาย ๆ ชิ้น
		list = { -- Required
			{ type = 'item', name = 'amp_r', count = 1, score = 1 },
			{ type = 'item', name = 'amp_b', count = 1, score = 1 },
			{ type = 'item', name = 'amp_g', count = 1, score = 0.5 },	
		}
	},
}