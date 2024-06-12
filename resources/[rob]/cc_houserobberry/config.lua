Config = {}
Config.Key 					= {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Config.HouseRob = {
	houserob1 = {
		name = "low_end_appartment",
		portal = {
			{
				type = "entrance",
				coords = vector3(23.419780, -1896.501098, 22.961182),
				destination = vector3(266.05999755859375, -1007.0399780273438, -100.83000030517578),
				onCooldown = false,
				heading = 348.661408,
			},
			{
				type = "exit",
				coords = vector3(266.004394, -1007.617554, -101.019776),
				destination = vector3(23.419780, -1896.501098, 23.961182),
				heading = 320.314972,
			},
		},

		robzone = {
			{
				coords = vector3(264.764832, -995.485718, -99.014648),
				type = "search",
			},
			{
				coords = vector3(262.918670, -1002.778016, -99.014648),
				type = "search",
			},
			{
				coords = vector3(256.905588, -995.934082, -99.014648),
				type = "search",
			},
			{
				coords = vector3(265.885712, -999.309876, -99.014648),
				type = "search",
			},
			{
				coords = vector3(256.457154, -1001.498902, -99.014648),
				type = "search",
			},
			{
				coords = vector3(259.318696, -1003.661560, -99.014648),
				type = "safe",
			},
		},
	},
	houserob2 = {
		name = "medium_end_apartment",
		portal = {
			{
				type = "entrance",
				coords = vector3(1265.696656, -458.162628, 70.511352),
				destination = vector3(346.57000732421875, -1012.8900146484376, -98.6999969482422),
				onCooldown = false,
				heading = 0.0,
			},
			{
				type = "exit",
				coords = vector3(346.562622, -1013.182434, -99.199952),
				destination = vector3(1265.696656, -458.162628, 71.511352),
				heading = 272.125976,
			},
		},

		robzone = {
			{
				coords = vector3(339.270324, -1003.345032, -99.199952),
				type = "search",
			},
			{
				coords = vector3(342.567048, -1003.213196, -99.199952),
				type = "search",
			},
			{
				coords = vector3(338.202210, -994.958252, -99.199952),
				type = "search",
			},
			{
				coords = vector3(350.215394, -993.599976, -99.199952),
				type = "search",
			},
			{
				coords = vector3(346.140656, -1001.670350, -99.199952),
				type = "search",
			},
			{
				coords = vector3(345.283508, -995.815368, -99.199952),
				type = "search",
			},
			{
				coords = vector3(344.030762, -1001.037354, -99.199952),
				type = "search",
			},
			{
				coords = vector3(352.760438, -998.756042, -99.199952),
				type = "safe",
			},
		},
	},
	houserob3 = {
		name = "motel",
		portal = {
			{
				type = "entrance",
				coords = vector3(240.593414, -1687.767090, 29.684204),
				destination = vector3(151.4499969482422, -1007.5800170898438, -98.5),
				onCooldown = false,
				heading = 357.165344,
			},
			{
				type = "exit",
				coords = vector3(151.437362, -1008.039550, -99.014648),
				destination = vector3(240.593414, -1687.767090, 30.684204),
				heading = 235.275588,
			},
		},

		robzone = {
			{
				coords = vector3(151.345062, -1002.975830, -99.014648),
				type = "search",
			},
			{
				coords = vector3(154.800004, -1005.876954, -99.014648),
				type = "search",
			},
			{
				coords = vector3(154.338470, -1003.279114, -99.014648),
				type = "search",
			},
			{
				coords = vector3(154.193406, -1000.694520, -99.014648),
				type = "search",
			},
			{
				coords = vector3(152.439560, -1000.232972, -99.014648),
				type = "safe",
			},
		},
	},
	houserob4 = {
		name = "document_forgery_office",
		portal = {
			{
				type = "entrance",
				coords = vector3(1341.243869, -597.349426, 74.690064),
				destination = vector3(1173.5699462890625, -3196.639892578125, -38.9099983215332),
				onCooldown = false,
				heading = 85.039368,
			},
			{
				type = "exit",
				coords = vector3(1173.784668, -3196.575928, -39.012452),
				destination = vector3(1341.243869, -597.349426, 75.090064),
				heading = 232.440948,
			},
		},

		robzone = {
			{
				coords = vector3(1171.898926, -3199.068116, -39.012452),
				type = "search",
			},
			{
				coords = vector3(1167.692260, -3194.439454, -39.012452),
				type = "search",
			},
			{
				coords = vector3(1161.758300, -3199.054932, -39.012452),
				type = "search",
			},
			{
				coords = vector3(1156.562622, -3195.032958, -39.012452),
				type = "search",
			},
			{
				coords = vector3(1160.268188, -3195.771484, -39.012452),
				type = "search",
			},
			{
				coords = vector3(1162.734008, -3195.890136, -39.012452),
				type = "search",
			},
			{
				coords = vector3(1165.556030, -3191.551758, -39.012452),
				type = "safe",
			},
		},
	},
	houserob5 = {
		name = "cocaine_lockup",
		portal = {
			{
				type = "entrance",
				coords = vector3(-595.542846, 393.019776, 101.868896),
				destination = vector3(1088.530029296875, -3188.030029296875, -38.7900016784668),
				onCooldown = false,
				heading = 175.748032,
			},
			{
				type = "exit",
				coords = vector3(1088.690064, -3187.463624, -38.995606),
				destination = vector3(-595.542846, 393.019776, 102.868896),
				heading = 11.338582,
			},
		},

		robzone = {
			{
				coords = vector3(1088.927490, -3195.125244, -38.995606),
				type = "search",
			},
			{
				coords = vector3(1090.272584, -3199.107666, -38.995606),
				type = "search",
			},
			{
				coords = vector3(1093.516480, -3199.107666, -38.995606),
				type = "search",
			},
			{
				coords = vector3(1094.861572, -3192.962646, -38.995606),
				type = "search",
			},
			{
				coords = vector3(1096.892334, -3196.246094, -38.995606),
				type = "search",
			},
			{
				coords = vector3(1086.791260, -3199.437256, -38.995606),
				type = "search",
			},
			{
				coords = vector3(1097.934082, -3199.344970, -38.995606),
				type = "safe",
			},
		},
	},
	houserob6 = {
		name = "garage_2_car",
		portal = {
			{
				type = "entrance",
				coords = vector3(1229.670288, -725.169250, 60.940674),
				destination = vector3(178.89999389648438, -1000.219970703125, -98.5999984741211),
				onCooldown = false,
				heading = 178.582688,
			},
			{
				type = "exit",
				coords = vector3(178.971436, -1000.101074, -99.014648),
				destination = vector3(1229.670288, -725.169250, 61.940674),
				heading = 93.543304,
			},
		},

		robzone = {
			{
				coords = vector3(178.997802, -1007.723084, -99.014648),
				type = "search",
			},
			{
				coords = vector3(177.296708, -999.797790, -99.014648),
				type = "search",
			},
			{
				coords = vector3(169.371430, -1002.606568, -99.014648),
				type = "search",
			},
			{
				coords = vector3(168.962632, -1008.013184, -99.014648),
				type = "search",
			},
			{
				coords = vector3(173.947250, -999.639588, -99.014648),
				type = "safe",
			},
		},
	},
	houserob7 = {
		name = "garage_6_car",
		portal = {
			{
				type = "entrance",
				coords = vector3(-824.610962, 422.004394, 92.112792),
				destination = vector3(207.2100067138672, -999.260009765625, -98.85),
				onCooldown = false,
				heading = 65.196854,
			},
			{
				type = "exit",
				coords = vector3(207.230774, -998.967042, -99.0146648),
				destination = vector3(-825.006592, 423.626374, 92.112792),
				heading = 0.0,
			},
		},

		robzone = {
			{
				coords = vector3(206.149444, -996.039550, -99.014648),
				type = "search",
			},
			{
				coords = vector3(202.061538, -994.549438, -99.014648),
				type = "search",
			},
			{
				coords = vector3(190.443954, -997.621948, -99.014648),
				type = "search",
			},
			{
				coords = vector3(190.773620, -1002.079102, -99.014648),
				type = "search",
			},
			{
				coords = vector3(190.826370, -1007.525268, -99.014648),
				type = "search",
			},
			{
				coords = vector3(206.531860, -1002.804382, -99.014648),
				type = "search",
			},
			{
				coords = vector3(206.558242, -1006.496704, -99.014648),
				type = "search",
			},
			{
				coords = vector3(194.808792, -993.494506, -99.014648),
				type = "safe",
			},
		},
	},
	houserob8 = {
		name = "high_towers",
		portal = {
			{
				type = "entrance",
				coords = vector3(-679.015380, 512.136292, 113.512084),
				destination = vector3(-777.613160, 340.457154, 160.5),
				onCooldown = false,
				heading = 90.708656,
			},
			{
				type = "exit",
				coords = vector3(-777.613160, 340.457154, 160.000732),
				destination = vector3(-679.015380, 512.136292, 114.512084),
				heading = 195.590546,
			},
		},

		robzone = {
			{
				coords = vector3(-778.523072, 332.558228, 160.000732),
				type = "search",
			},
			{
				coords = vector3(-789.626342, 327.085724, 158.585328),
				type = "search",
			},
			{
				coords = vector3(-787.331848, 330.131866, 158.585328),
				type = "search",
			},
			{
				coords = vector3(-801.362610, 326.465942, 158.585328),
				type = "search",
			},
			{
				coords = vector3(-799.806580, 342.540650, 158.585328),
				type = "search",
			},
			{
				coords = vector3(-796.958252, 340.747254, 153.783204),
				type = "search",
			},
			{
				coords = vector3(-794.386840, 336.105500, 153.783204),
				type = "search",
			},
			{
				coords = vector3(-794.334046, 330.764832, 153.783204),
				type = "search",
			},
			{
				coords = vector3(-782.149476, 327.837372, 160.000732),
				type = "safe",
			},
		},
	},
}