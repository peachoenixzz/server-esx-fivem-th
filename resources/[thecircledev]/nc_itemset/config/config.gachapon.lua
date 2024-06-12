-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config.Gachapon = {
	['gacha_support'] = {
		label = 'กาชาปองสนับสนุน', -- Required
		description = '',
		rarity = 5,
		list = { -- Required
			{ type = 'item', name = 'alloy', count = { 1, 1 }, score = 0.5 },
			{ type = 'item', name = 'weapon_box', count = { 1, 1 }, score = 1 },
			{ type = 'item', name = 'gum_eco', count = { 1, 1 }, score = 1 },
			{ type = 'item', name = 'gum_mining', count = { 1, 1 }, score = 1 },
			{ type = 'item', name = 'mre', count = { 1, 1 }, score = 1.5 },
			{ type = 'item', name = 'card_afk', count = { 1, 1 }, score = 2 },
			{ type = 'item', name = 'exp', count = { 1, 2 }, score = 2.5 },
			{ type = 'account', name = 'money', count = { 1000, 1500 }, score = 3 },
			{ type = 'item', name = 'vest', count = { 1, 1 }, score = 3.5 },						
			{ type = 'item', name = 'meal_1', count = { 1, 1 }, score = 4 },
			{ type = 'item', name = 'diamond', count = { 1, 2 }, score = 5 },
			{ type = 'item', name = 'ruby', count = { 1, 2 }, score = 5 },
			{ type = 'item', name = 'bandage', count = { 1, 2 }, score = 6 },
			{ type = 'account', name = 'money', count = { 300, 500 }, score = 7 },
			{ type = 'item', name = 'weed_pack', count = { 1, 1 }, score = 8 },
			{ type = 'item', name = 'meal_3', count = { 1, 2 }, score = 9 },
			{ type = 'item', name = 'work_kit', count = { 1, 1 }, score = 10 },
		}
	},
}