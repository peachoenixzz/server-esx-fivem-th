Config                            = {}

Config.DrawDistance               = 25.0 -- How close do you need to be for the markers to be drawn (in GTA units).
Config.MarkerType                 = {Cloakrooms = 20, Armories = 21, BossActions = 22, Vehicles = 29, Helicopters = 29}
Config.MarkerSize                 = {x = 1.0, y = 1.0, z = 1.0}
Config.MarkerColor                = {r = 255, g = 204, b = 0}

Config.EnablePlayerManagement     = true -- Enable if you want society managing.
Config.EnableArmoryManagement     = false
Config.EnableESXIdentity          = true -- Enable if you're using esx_identity.
Config.EnableESXOptionalneeds     = false -- Enable if you're using esx_optionalneeds
Config.EnableLicenses             = false -- Enable if you're using esx_license.

Config.EnableHandcuffTimer        = true -- Enable handcuff timer? will unrestrain player after the time ends.
Config.HandcuffTimer              = 15 * 60000 -- 10 minutes.

Config.EnableJobBlip              = false -- Enable blips for cops on duty, requires esx_society.
Config.EnableCustomPeds           = false -- Enable custom peds in cloak room? See Config.CustomPeds below to customize peds.

Config.EnableESXService           = false -- Enable esx service?
Config.MaxInService               = -1 -- How many people can be in service at once? Set as -1 to have no limit
Config.NcInventory = true
Config.TheCircle = true
Config.Locale = GetConvar('esx:locale', 'en')

Config.OxInventory                = ESX.GetConfig().OxInventory
Config.PoliceStations = {
	LSPD = {
		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(472.4800109863281, -994.4400024414064, 30.69000053405761)
		},

		Armories = {
			vector3(482.5199890136719, -995.469970703125, 30.68000030517578)
		},

		Vehicles = {
			{
				Spawner = vector3(463.0799865722656, -986.5999755859376, 25.61000061035156),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0},
					{coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0},
					{coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0},
					{coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0}
				}
			},
			{
				Spawner = vector3(473.3, -1018.8, 28.0),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0},
					{coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(458.848358, -989.472534, 43.686402),
				InsideShop = vector3(481.542846, -981.560424, 40.990478),
				SpawnPoints = {
					{coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0}
				}
			}
		},

		BossActions = {
			vector3(448.4, -973.2, 30.6)
		}

	}

}

Config.AuthorizedTools = {
	sos_student = {
		{labelName = "เกราะหน่วยงาน", name = "gov_vest", price = 0},
		{labelName = "กล่องซ่อม", name = "gov_toolkit", price = 100}
	},

	sos_staff = {
		{labelName = "เกราะหน่วยงาน", name = "gov_vest", price = 0},
		{labelName = "กล่องซ่อม", name = "gov_toolkit", price = 100}
	},

	sos_sergeant = {
		{labelName = "เกราะหน่วยงาน", name = "gov_vest", price = 0},
		{labelName = "กล่องซ่อม", name = "gov_toolkit", price = 100}
	},

	sos_captain = {
		{labelName = "เกราะหน่วยงาน", name = "gov_vest", price = 0},
		{labelName = "กล่องซ่อม", name = "gov_toolkit", price = 100}
	},

	sos_commander = {
		{labelName = "เกราะหน่วยงาน", name = "gov_vest", price = 0},
		{labelName = "กล่องซ่อม", name = "gov_toolkit", price = 100}
	},

}

Config.AuthorizedWeapons = {
	sos_student = {
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {1000, 1000, nil}, price = 0},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
	},

	sos_staff = {
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {1000, 1000, nil}, price = 0},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
	},

	sos_sergeant = {
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {1000, 1000, nil}, price = 0},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
	},

	sos_captain = {
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {1000, 1000, nil}, price = 0},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
	},

	sos_commander = {
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {1000, 1000, nil}, price = 0},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 0},
	}
}

Config.AuthorizedVehicles = {
	car = {
		sos_student = {
			{model = 'emsstalker', price = 1000},
			{model = 'polbuff', price = 1000},
			{model = 'polvigor', price = 15000},
		},

		sos_staff = {
			{model = 'emsstalker', price = 1000},
			{model = 'polbuff', price = 1000},
			{model = 'polvigor', price = 15000},
			{model = 'polcoq2', price = 30000}
		},

		sos_sergeant = {
			{model = 'emsstalker', price = 1000},
			{model = 'polbuff', price = 1000},
			{model = 'polvigor', price = 15000},
			{model = 'polcoq2', price = 30000},
			{model = 'polcoquettes2', price = 50000}
		},

		sos_captain = {
			{model = 'emsstalker', price = 1000},
			{model = 'polbuff', price = 1000},
			{model = 'polvigor', price = 15000},
			{model = 'polcoq2', price = 30000},
			{model = 'polcoquettes2', price = 50000}
		},

		sos_commander = {
			{model = 'emsstalker', price = 1000},
			{model = 'polbuff', price = 1000},
			{model = 'polvigor', price = 15000},
			{model = 'polcoq2', price = 30000},
			{model = 'polcoquettes2', price = 50000}
		}
	},

	helicopter = {
		sos_student = {
			{model = 'polmav', props = {modLivery = 2}, price = 10000},
			{model = 'seasparrow', price = 5000}
		},

		sos_staff = {
			{model = 'polmav', props = {modLivery = 2}, price = 10000},
			{model = 'seasparrow', price = 5000}
		},

		sos_sergeant = {
			{model = 'polmav', props = {modLivery = 2}, price = 10000},
			{model = 'seasparrow', price = 5000}
		},

		sos_captain = {
			{model = 'polmav', props = {modLivery = 2}, price = 10000},
			{model = 'seasparrow', price = 5000}
		},

		sos_commander = {
			{model = 'polmav', props = {modLivery = 2}, price = 10000},
			{model = 'seasparrow', price = 5000}
		}
	}
}

Config.CustomPeds = {
	shared = {
		{label = 'Sheriff Ped', maleModel = 's_m_y_sheriff_01', femaleModel = 's_f_y_sheriff_01'},
		{label = 'Police Ped', maleModel = 's_m_y_cop_01', femaleModel = 's_f_y_cop_01'}
	},

	recruit = {},

	officer = {},

	sergeant = {},

	lieutenant = {},

	boss = {
		{label = 'SWAT Ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'}
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
	sos_student = {
		male = {
			tshirt_1 = 134,  tshirt_2 = 0,
			torso_1 = 357,   torso_2 = 0,
			arms = 18,
			pants_1 = 124,   pants_2 = 0,
			shoes_1 = 149,   shoes_2 = 0,
			helmet_1 = 141,  helmet_2 = 0,
		},
		female = {
			tshirt_1 = 194,  tshirt_2 = 0,
			torso_1 = 375,   torso_2 = 0,
			arms = 33,
			pants_1 = 130,   pants_2 = 0,
			shoes_1 = 163,   shoes_2 = 0,
			helmet_1 = 140,  helmet_2 = 0,
		}
	},

	sos_staff = {
		male = {
			tshirt_1 = 134,  tshirt_2 = 0,
			torso_1 = 357,   torso_2 = 0,
			arms = 18,
			pants_1 = 124,   pants_2 = 0,
			shoes_1 = 149,   shoes_2 = 0,
			helmet_1 = 141,  helmet_2 = 0,
		},
		female = {
			tshirt_1 = 194,  tshirt_2 = 0,
			torso_1 = 375,   torso_2 = 0,
			arms = 33,
			pants_1 = 130,   pants_2 = 0,
			shoes_1 = 163,   shoes_2 = 0,
			helmet_1 = 140,  helmet_2 = 0,
		}
	},

	sos_sergeant = {
		male = {
			tshirt_1 = 134,  tshirt_2 = 0,
			torso_1 = 357,   torso_2 = 0,
			arms = 18,
			pants_1 = 124,   pants_2 = 0,
			shoes_1 = 149,   shoes_2 = 0,
			helmet_1 = 141,  helmet_2 = 0,
		},
		female = {
			tshirt_1 = 194,  tshirt_2 = 0,
			torso_1 = 375,   torso_2 = 0,
			arms = 33,
			pants_1 = 130,   pants_2 = 0,
			shoes_1 = 163,   shoes_2 = 0,
			helmet_1 = 140,  helmet_2 = 0,
		}
	},

	sos_captain = {
		male = {
			tshirt_1 = 134,  tshirt_2 = 0,
			torso_1 = 357,   torso_2 = 0,
			arms = 18,
			pants_1 = 124,   pants_2 = 0,
			shoes_1 = 149,   shoes_2 = 0,
			helmet_1 = 141,  helmet_2 = 0,
		},
		female = {
			tshirt_1 = 194,  tshirt_2 = 0,
			torso_1 = 375,   torso_2 = 0,
			arms = 33,
			pants_1 = 130,   pants_2 = 0,
			shoes_1 = 163,   shoes_2 = 0,
			helmet_1 = 140,  helmet_2 = 0,
		}
	},

	sos_commander = {
		male = {
			tshirt_1 = 134,  tshirt_2 = 0,
			torso_1 = 357,   torso_2 = 0,
			arms = 18,
			pants_1 = 124,   pants_2 = 0,
			shoes_1 = 149,   shoes_2 = 0,
			helmet_1 = 141,  helmet_2 = 0,
		},
		female = {
			tshirt_1 = 194,  tshirt_2 = 0,
			torso_1 = 375,   torso_2 = 0,
			arms = 33,
			pants_1 = 130,   pants_2 = 0,
			shoes_1 = 163,   shoes_2 = 0,
			helmet_1 = 140,  helmet_2 = 0,
		}
	},

	bullet_wear = {
		male = {
			bproof_1 = 11,  bproof_2 = 1
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},

	gilet_wear = {
		male = {
			tshirt_1 = 59,  tshirt_2 = 1
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1
		}
	}
}
