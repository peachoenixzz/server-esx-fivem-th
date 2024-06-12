Language = "en"

Config = {}

Config.DevMode = true
Config.SpawnModel = `sf_prop_poker_01`

Config.MoneyItem = "casino_chip"

-- txh textures: 0 green, 1 red, 2 blue, 3 purple
Config.Tables = {
	{
		coords = vec3(1147.626587, 265.531921, -52.840851),
		heading = 224.00001525879,
		model = 1783728142,
		spawn = false,
		texture = 0,
		type = "normal",
		smallBlind = 500,
	},
}

Config.PrepareTime = 20

TxhModels = {
	`sf_prop_poker_01`,
}

Bets = {
	10,
	5000
}

BetChips = {
	[10] = `vw_prop_chip_10dollar_x1`,
	[50] = `vw_prop_chip_50dollar_x1`,
	[100] = `vw_prop_chip_100dollar_x1`,
	[120] = `vw_prop_chip_10dollar_st`,
	[500] = `vw_prop_chip_500dollar_x1`,
	[600] = `vw_prop_chip_50dollar_st`,
	[1000] = `vw_prop_chip_1kdollar_x1`,
	[1200] = `vw_prop_chip_100dollar_st`,
	[5000] = `vw_prop_chip_5kdollar_x1`,
	[6000] = `vw_prop_chip_500dollar_st`,
	[10000] = `vw_prop_chip_10kdollar_x1`,
	[60000] = `vw_prop_chip_5kdollar_st`,
	[120000] = `vw_prop_chip_10kdollar_st`,
	["dealer"] = `sf_prop_chip_1`,
	["big"] = `sf_prop_chip_2`,
	["small"] = `sf_prop_chip_3`,
	["allin"] = `sf_prop_allin`,
}

Config.CancelDist = 10.0 -- distance between player and target coords that exits the game

-- https://docs.fivem.net/docs/game-references/controls/
Config.Controls = {
	["check_cards"] = 337,
	["auto_check_fold"] = 22,
	["exit"] = 200,
	["bet"] = 191,
	["check"] = 22,
	["fold"] = 23,
	["call"] = 26
}

-- display players money
Config.DisplayMoney = true

-- hide cards when you press X next time
Config.CardsToggle = true