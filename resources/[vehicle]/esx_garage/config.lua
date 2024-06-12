Config = {}
Config.Locale = GetConvar('esx:locale', 'en')

Config.DrawDistance = 25.0

Config.Markers = {
	EntryPoint = {
		Type = 36,
		Size = {
			x = 1.5,
			y = 1.5,
			z = 1.5,
		},
		Color = {
			r = 255,
			g = 204,
			b = 0,
		},
	},

	TrunkPoint = {
		Type = 24,
		Size = {
			x = 1.0,
			y = 1.0,
			z = 1.0,
		},
		Color = {
			r = 255,
			g = 204,
			b = 0,
		},
	},

	RepairPoint = {
		Type = 1,
		Size = {
			x = 3.0,
			y = 3.0,
			z = 1.0,
		},
		Color = {
			r = 255,
			g = 204,
			b = 0,
		},
	},

	GetOutPoint = {
		Type = 1,
		Size = {
			x = 5.0,
			y = 5.0,
			z = 1.0,
		},
		Color = {
			r = 200,
			g = 51,
			b = 51,
		},
	},

	ImpoundPoint = {
		Type = 36,
		Size = {
			x = 1.0,
			y = 1.0,
			z = 1.0,
		},
		Color = {
			r = 200,
			g = 51,
			b = 51,
		},
	},
}

Config.GaragesTrunk = { -- จุดเปิดท้ายรถ
	circle = {
		TrunkPoint = {
			x=-433.7799987792969, y=1152.4100341796875, z=327.1600036621094
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LandCircle",
	},
	landCat = {
		TrunkPoint = {
			x=-286.0400085449219, y=-922.7000122070312, z=31.07999992370605
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LandCat",
	},
	landBear = {
		TrunkPoint = {
			x=53.88999938964844, y=-1550.3699951171875, z=29.45999908447265
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LandBear",
	},
	landDeer = {
		TrunkPoint = {
			x=1047.030029296875, y=-768.8200073242188, z=57.90999984741211
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LandDeer",
	},
	landSheep = {
		TrunkPoint = {
			x=286.260009765625, y=-265.6900024414063, z=54.0099983215332
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LandSheep",
	},
	landTiger = {
		TrunkPoint = {
			x=-1524.469970703125, y=-453.3500061035156, z=35.59000015258789
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LandTiger",
	},
	landChicken1 = {
		TrunkPoint = {
			x=130.33999633789065, y=-1077.260009765625, z=29.26000022888183
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LandTiger",
	},
	landChicken2 = {
		TrunkPoint = {
			x=217.82000732421875, y=-856.8699951171875, z=30.2800006866455
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LandTiger",
	},
	PaletoBay = {
		TrunkPoint = {
			x=106.76000213623048, y=6612.2998046875, z=31.97999954223632
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LandTiger",
	},
	SeaShore = {
		TrunkPoint = {
			x=1218.75, y=-3326.550048828125, z=5.53000020980835
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LandTiger",
	},
	Kayo = {
		TrunkPoint = {
			x=4905.27001953125, y=-5217.6201171875, z=2.50999999046325
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LandTiger",
	},
}

Config.GarageCustom = { -- จุดแต่งรถ
	GarageCustom1 = {
		EntryPoint = {
			x = -459.7002,
			y = 1109.6229,
			z = 327.8656,
		},
		SpawnPoint = {
			x = -466.2840,
			y = 1108.8955,
			z = 327.8656,
			heading = 260.0962,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageCustom2 = {
		EntryPoint = {
			x = -463.1500,
			y = 1095.8553,
			z = 327.8654,
		},
		SpawnPoint = {
			x = -468.7951,
			y = 1099.7183,
			z = 327.8654,
			heading = 257.3160,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
}

Config.GaragesAmbulance = {

	AmbulanceStation = {
		EntryPoint = {
			x = 398.11, y = -1428.73, z = 29.45
		},
		SpawnPoint = {
			x = 401.05, y = -1425.80, z = 29.45, heading = 232.74
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	AmbulancePaletoBay = {
		EntryPoint = {
			x = -251.1901, y = 6339.7798, z = 32.4894
		},
		SpawnPoint = {
			x = -261.0648, y = 6344.2417, z = 32.4263, heading = 266.7879
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
}

Config.GaragesHelicopterAmbulance = {
	AmbulanceStation = {
		EntryPoint = {
			x = 317.235168, y = -1453.872558, z = 46.500366
		},
		SpawnPoint = {
			x = 313.384614, y = -1465.186768, z = 46.500366, heading = 42.519684
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	AmbulancePaletoBay = {
		EntryPoint = {
			x = -259.0105, y = 6350.6055, z = 32.6269
		},
		SpawnPoint = {
			x = -257.5059, y = 6314.4307, z = 37.6172, heading = 230.9631
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
}

Config.GaragesPolice = {

	PoliceStation = {
		EntryPoint = {
			x = 458.88, y = -992.59, z = 25.69
		},
		SpawnPoint = {
			x = 431.26, y = -986.58, z = 25.70, heading = 180.77
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	PoliceSandyShore = {
		EntryPoint = {
			x = 1868.14, y = 3694.81, z = 33.61
		},
		SpawnPoint = {
			x = 1868.14, y = 3694.81, z = 33.61, heading = 205.80
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	}, 
	PolicePaletoBay = {
		EntryPoint = {
			x = -435.0698, y = 6031.5342, z = 31.3405
		},
		SpawnPoint = {
			x = -435.0698, y = 6031.5342, z = 31.3405, heading = 205.80
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	}, 
	PoliceCitizenRebel1 = {
		EntryPoint = {
			x = -395.4879, y = 1170.2057, z = 326.9256
		},
		SpawnPoint = {
			x = -395.4879, y = 1170.2057, z = 326.9256, heading = 167.9223
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	}, 
	PoliceCitizenRebel2 = {
		EntryPoint = {
			x = -435.6510, y = 1180.8903, z = 326.9256
		},
		SpawnPoint = {
			x = -435.6510, y = 1180.8903, z = 326.9256, heading = 165.7327
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	}, 
}

Config.GaragesHelicopterPolice = {

	PoliceStation = {
		EntryPoint = {
			x = 461.182434, y = -989.393432, z = 43.686402
		},
		SpawnPoint = {
			x = 449.169220, y = -981.151672, z = 43.696402, heading = 342.992126
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	PoliceSandyShore = {
		EntryPoint = {
			x = 1864.88, y = 3700.43, z = 33.56
		},
		SpawnPoint = {
			x = 1889.29, y = 3704.94, z = 32.94, heading = 215.14
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	PolicePaletoBay = {
		EntryPoint = {
			x = -458.0899, y = 6018.3457, z = 31.4901
		},
		SpawnPoint = {
			x = -467.7755, y = 6021.8169, z = 31.3405, heading = 316.6352
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
}

Config.GaragesCircle = {
	-- CircleStation = {
	-- 	EntryPoint = {
	-- 		x=-403.938446, y=1217.617554, z=325.634400
	-- 	},
	-- 	SpawnPoint = {
	-- 		x=-403.938446, y=1217.617554, z=325.634400, heading = 326.72
	-- 	},
	-- 	Sprite = 357,
	-- 	Scale = 0.8,
	-- 	Colour = 3,
	-- 	ImpoundedName = "CircleOffice",
	-- },
}

Config.GaragesHelicopterCircle = {
	-- CircleStation = {
	-- 	EntryPoint = {
	-- 		x= -405.5733638, y= 1211.828614, z= 325.634400
	-- 	},
	-- 	SpawnPoint = {
	-- 		x= -410.927460, y= 1213.793458, z= 325.634400, heading= 342.992126
	-- 	},
	-- 	Sprite = 357,
	-- 	Scale = 0.8,
	-- 	Colour = 3,
	-- 	ImpoundedName = "LosSantos",
	-- },
	-- CircleStation2 = {
	-- 	EntryPoint = {
	-- 		x= -407.538452, y= 1206.290162, z= 325.634400
	-- 	},
	-- 	SpawnPoint = {
	-- 		x= -410.927460, y= 1213.793458, z= 325.634400, heading = 351.496064
	-- 	},
	-- 	Sprite = 357,
	-- 	Scale = 0.8,
	-- 	Colour = 3,
	-- 	ImpoundedName = "LosSantos",
	-- },
}

Config.repairPoint = {
	FirstRepairPoint = {
		RepairPoint = {
			x= -374.77, y= -105.77, z= 37.50
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		repair = true
	},
	SecondRepairPoint = {
		RepairPoint = {
			x= -365.95, y= -108.69, z= 37.50
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		repair = true
	},
	ThirdRepairPoint = {
		RepairPoint = {
			x= -206.16000366210935, y= 6220.77001953125, z= 30.48999977111816
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		repair = true
	},
	FouthRepairPoint = {
		RepairPoint = {
			x= 1981.3699951171875, y= 3784.89990234375, z= 31.18000030517578
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		repair = true
	},
	FifthRepairPoint = {
		RepairPoint = {
			x= -1142.8900146484375, y= -1988.18994140625, z= 12.15999984741211
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		repair = true
	},
	SixthRepairPoint = {
		RepairPoint = {
			x= 892.760009765625, y= -1023.52001953125, z= 33.97000122070312
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		repair = true
	},
}

Config.GaragesBoat = {

	FirstGarageBoat = {
		EntryPoint = {
			x= 1238.3399658203125, y= -3348.780029296875, z= 5.90000009536743
		},
		SpawnPoint = {
			x = 1238.5,
			y = -3362.22998046875,
			z = 2.63000011444091, 
			heading = 192.2,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	KayoGarageBoat = {
		EntryPoint = {
			x = 4907.08984375,
			y = -5172.2099609375,
			z = 2.47000002861022,
		},
		SpawnPoint = {
			x = 4907.10986328125,
			y = -5156.43017578125,
			z = 4.32999992370605,
			heading = 70.12,
		},
		Sprite = 524,
		Scale = 0.8,
		Colour = 1,
		ImpoundedName = "LosSantos",
	},
}

Config.GaragesHelicopter = {
	-- PoliceStation = {
	-- 	EntryPoint = {
	-- 		x= 458.8800048828125, y = -992.5999755859376, z= 25.69000053405761
	-- 	},
	-- 	SpawnPoint = {
	-- 		x= 431.260009765625, y= -986.5800170898438, z= 25.70000076293945, heading = 180.77
	-- 	},
	-- 	Sprite = 357,
	-- 	Scale = 0.8,
	-- 	Colour = 3,
	-- 	ImpoundedName = "LosSantos",
	-- }
}


Config.Garages = {
	GarageSheep1 = {
		EntryPoint = {
			x = 299.79,
			y = -235.08,
			z = 53.97,
		},
		SpawnPoint = {
			x = 299.79,
			y = -235.08,
			z = 53.97,
			heading = 189.75,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageSheep2 = {
		EntryPoint = {
			x = 294.69,
			y = -233.13,
			z = 53.97,
		},
		SpawnPoint = {
			x = 294.69,
			y = -233.13,
			z = 53.97,
			heading = 189.75,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageSheep3 = {
		EntryPoint = {
			x = 289.29,
			y = -231.06,
			z = 53.97,
		},
		SpawnPoint = {
			x = 289.29,
			y = -231.06,
			z = 53.97,
			heading = 189.75,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageSheep4 = {
		EntryPoint = {
			x = 283.96,
			y = -229.11,
			z = 53.97,
		},
		SpawnPoint = {
			x = 283.96,
			y = -229.11,
			z = 53.97,
			heading = 189.75,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageCat1 = {
		EntryPoint = {
			x = -296.55999755859375,
			y = -886.0900268554688,
			z = 31.07999992370605,
		},
		SpawnPoint = {
			x = -296.55999755859375,
			y = -886.0900268554688,
			z = 31.07999992370605,
			heading = 167.87,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageCat2 = {
		EntryPoint = {
			x = -292.8699951171875,
			y = -886.9099731445312,
			z = 31.07999992370605,
		},
		SpawnPoint = {
			x = -292.8699951171875,
			y = -886.9099731445312,
			z = 31.07999992370605,
			heading = 167.87,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageCat3 = {
		EntryPoint = {
			x = -289.3800048828125,
			y = -887.6199951171875,
			z = 31.07999992370605,
		},
		SpawnPoint = {
			x = -289.3800048828125,
			y = -887.6199951171875,
			z = 31.07999992370605,
			heading = 167.87,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageCat4 = {
		EntryPoint = {
			x = -285.8500061035156,
			y = -888.4500122070312,
			z = 31.07999992370605,
		},
		SpawnPoint = {
			x = -285.8500061035156,
			y = -888.4500122070312,
			z = 31.07999992370605,
			heading = 167.87,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageDeer1 = {
		EntryPoint = {
			x = 1025.56005859375,
			y = -781.989990234375,
			z = 57.88000106811523,
		},
		SpawnPoint = {
			x = 1025.56005859375,
			y = -781.989990234375,
			z = 57.88000106811523,
			heading = 310.91,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageDeer2 = {
		EntryPoint = {
			x = 1023.4000244140624,
			y = -779.1300048828125,
			z = 57.88999938964844,
		},
		SpawnPoint = {
			x = 1023.4000244140624,
			y = -779.1300048828125,
			z = 57.88999938964844,
			heading = 310.91,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageDeer3 = {
		EntryPoint = {
			x = 1020.969970703125,
			y = -776.1300048828125,
			z = 57.9000015258789,
		},
		SpawnPoint = {
			x = 1020.969970703125,
			y = -776.1300048828125,
			z = 57.9000015258789,
			heading = 310.91,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageBear1 = {
		EntryPoint = {
			x = 68.69,
			y = -1559.18,
			z = 29.46,
		},
		SpawnPoint = {
			x = 68.69,
			y = -1559.18,
			z = 29.46,
			heading = 49.65,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageBear2 = {
		EntryPoint = {
			x = 70.68,
			y = -1556.81,
			z = 29.46,
		},
		SpawnPoint = {
			x = 70.68,
			y = -1556.81,
			z = 29.46,
			heading = 49.65,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageBear3 = {
		EntryPoint = {
			x = 72.60,
			y = -1554.46,
			z = 29.46,
		},
		SpawnPoint = {
			x = 72.60,
			y = -1554.46,
			z = 29.46,
			heading = 49.65,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageBear4 = {
		EntryPoint = {
			x = 74.51,
			y = -1552.15,
			z = 29.46,
		},
		SpawnPoint = {
			x = 74.51,
			y = -1552.15,
			z = 29.46,
			heading = 49.65,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageTiger1 = {
		EntryPoint = {
			x = -1535.36,
			y = -434.94,
			z = 35.44,
		},
		SpawnPoint = {
			x = -1535.36,
			y = -434.94,
			z = 35.44,
			heading = 225.79,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageTiger2 = {
		EntryPoint = {
			x = -1532.99,
			y = -432.21,
			z = 35.44,
		},
		SpawnPoint = {
			x = -1532.99,
			y = -432.21,
			z = 35.44,
			heading = 225.79,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageTiger3 = {
		EntryPoint = {
			x = -1530.78,
			y = -429.73,
			z = 35.44,
		},
		SpawnPoint = {
			x = -1530.78,
			y = -429.73,
			z = 35.44,
			heading = 225.79,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GaragePaletoBay1 = {
		EntryPoint = {
			x = 117.52,
			y = 6599.50,
			z = 32.00,
		},
		SpawnPoint = {
			x = 117.52,
			y = 6599.50,
			z = 32.00,
			heading = 268.95,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GaragePaletoBay2 = {
		EntryPoint = {
			x = 121.6999969482422,
			y = 6595.31005859375,
			z = 32.02000045776367,
		},
		SpawnPoint = {
			x = 121.6999969482422,
			y = 6595.31005859375,
			z = 32.12000045776367,
			heading = 268.95,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GaragePaletoBay3 = {
		EntryPoint = {
			x = 126.9000015258789,
			y = 6590.10986328125,
			z = 31.94000053405761,
		},
		SpawnPoint = {
			x = 126.62000274658205,
			y = 6589.91015625,
			z = 31.94000053405761,
			heading = 268.95,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageSeaShore = {
		EntryPoint = {
			x = 1233.46,
			y = -3330.00,
			z = 5.65,
		},
		SpawnPoint = {
			x = 1233.46,
			y = -3330.00,
			z = 5.65,
			heading = 179.5,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageCitizenRebel1 = {
		EntryPoint = {
			x = -429.0512, 
			y = 1179.0714, 
			z = 326.9255
		},
		SpawnPoint = {
			x = -429.0512, 
			y = 1179.0714, 
			z = 326.9255,
			heading = 164.7051,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageCitizenRebel2 = {
		EntryPoint = {
			x = -432.3989, 
			y = 1179.9763, 
			z = 326.9256
		},
		SpawnPoint = {
			x = -432.3989, 
			y = 1179.9763, 
			z = 326.9256,
			heading = 164.7051,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageCitizenRebel3 = {
		EntryPoint = {
			x = -402.2444, 
			y = 1172.0048, 
			z = 326.9257
		},
		SpawnPoint = {
			x = -402.2444, 
			y = 1172.0048, 
			z = 326.9257,
			heading = 164.7051,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageCitizenRebel4 = {
		EntryPoint = {
			x = -398.8181, 
			y = 1171.0911, 
			z = 326.9256
		},
		SpawnPoint = {
			x = -398.8181, 
			y = 1171.0911, 
			z = 326.9256,
			heading = 164.7051,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageChicken1 = {
		EntryPoint = {
			x = 97.16000366210938,
			y = -1091.6099853515625,
			z = 29.15999984741211,
		},
		SpawnPoint = {
			x = 97.16000366210938,
			y = -1091.6099853515625,
			z = 29.15999984741211,
			heading = 246.28,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageChicken2 = {
		EntryPoint = {
			x = 99.0199966430664,
			y = -1087.31005859375,
			z = 29.15999984741211,
		},
		SpawnPoint = {
			x = 99.0199966430664,
			y = -1087.31005859375,
			z = 29.15999984741211,
			heading = 246.28,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageChicken3 = {
		EntryPoint = {
			x = 100.83999633789064,
			y = -1083.1300048828125,
			z = 29.15999984741211,
		},
		SpawnPoint = {
			x = 100.83999633789064,
			y = -1083.1300048828125,
			z = 29.15999984741211,
			heading = 246.28,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageChicken4 = {
		EntryPoint = {
			x = 216.63999938964844,
			y = -850.3699951171875,
			z = 30.20999908447265,
		},
		SpawnPoint = {
			x = 216.63999938964844,
			y = -850.3699951171875,
			z = 30.20999908447265,
			heading = 248.67,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageChicken5 = {
		EntryPoint = {
			x = 222.36000061035156,
			y = -852.4400024414062,
			z = 30.05999946594238,
		},
		SpawnPoint = {
			x = 222.36000061035156,
			y = -852.4400024414062,
			z = 30.05999946594238,
			heading = 248.67,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageChicken6 = {
		EntryPoint = {
			x = 227.7299957275391,
			y = -854.4500122070312,
			z = 29.93000030517578,
		},
		SpawnPoint = {
			x = 227.7299957275391,
			y = -854.4500122070312,
			z = 29.93000030517578,
			heading = 248.67,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	KayoGarage1 = {
		EntryPoint = {
			x = 4907.85986328125,
			y = -5221.7099609375,
			z = 2.51999998092651,
		},
		SpawnPoint = {
			x = 4907.85986328125,
			y = -5221.7099609375,
			z = 2.51999998092651,
			heading = 304.46,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	KayoGarage2 = {
		EntryPoint = {
			x = 4910.47021484375,
			y = -5227.02978515625,
			z = 2.51999998092651,
		},
		SpawnPoint = {
			x = 4910.47021484375,
			y = -5227.02978515625,
			z = 2.51999998092651,
			heading = 304.46,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageBoatShop1 = {
		EntryPoint = {
			x = -815.52001953125,
			y = -1318.510009765625,
			z = 5.0,
		},
		SpawnPoint = {
			x = -815.52001953125,
			y = -1318.510009765625,
			z = 5.0,
			heading = 167.88,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	GarageBoatShop2 = {
		EntryPoint = {
			x = -812.219970703125,
			y = -1319.1099853515625,
			z = 5.0,
		},
		SpawnPoint = {
			x = -812.219970703125,
			y = -1319.1099853515625,
			z = 5.0,
			heading = 167.88,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	PrisonGarage = {
		EntryPoint = {
			x = 1855.5087,
			y = 2578.9868,
			z = 45.6720,
		},
		SpawnPoint = {
			x = 1855.5087,
			y = 2578.9868,
			z = 45.6720,
			heading = 272.3136,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
	SandyShoreGarage = {
		EntryPoint = {
			x = 1708.0819,
			y = 3752.4031,
			z = 34.0780,
		},
		SpawnPoint = {
			x = 1708.0819,
			y = 3752.4031,
			z = 34.0780,
			heading = 234.7647,
		},
		Sprite = 357,
		Scale = 0.8,
		Colour = 3,
		ImpoundedName = "LosSantos",
	},
}

Config.Parking = {

	GarageSheep = {
		parkingPoint = {
			x = 294.35, y = -274.59, z = 53.00
		},
	},
	GarageCat = {
		parkingPoint = {
			x = -300.1300048828125, y = -898.75, z = 30.07999992370605
		},
	},
	GarageDeer = {
		parkingPoint = {
			x = 1033.5899658203125, y = -792.0800170898438, z = 56.86999893188476
		},
	},
	GarageBear = {
		parkingPoint = {
			x = 81.08000183105469, y = -1543.97998046875, z = 28.46
		},
	},
	GarageTiger = {
		parkingPoint = {
			x = -1509.20, y = -431.58, z = 34.25
		},
	},
	GarageSeaShore = {
		parkingPoint = {
			x = 1244.219970703125, y = -3330.550048828125, z = 5.03000020980835
		},
	},
	GarageBoat = {
		parkingPoint = {
			x = 1276.80, y = -3358.77, z = 0.88
		},
	},
	GarageBoatDealerShip = {
		parkingPoint = {
			x = -829.01, y = -1324.99, z = 4.00
		},
	},
	GarageCitizenRebel1 = {
		parkingPoint = {
			x = -390.8246, y = 1167.1962, z = 325.9293
		},
	},
	GarageCitizenRebel2 = {
		parkingPoint = {
			x = -444.6299, y = 1181.5725, z = 325.9302
		},
	},
	GarageHospital = {
		parkingPoint = {
			x = 291.1700, y = -1441.9100, z = 28.9699
		},
	},
	GaragePolice = {
		parkingPoint = {
			x = 416.2399, y = -1007.0999, z = 28.25
		},
	},

-- Los Santos
	-- Police
	PoliceStation = {
		parkingPoint = {
			x = 450.408782, y = -976.167054, z = 24.690796
		},
		job = "police"
	},
	PoliceHelicopterStation = {
		parkingPoint = {
			x = 449.169220, y = -981.151672, z = 42.686402
		},
		job = "police"
	},
	-- Ambulance
	AmbulanceStation = { 
		parkingPoint = {
			x = 393.942872, y = -1445.182374, z = 28.380982
		},
		job = "police"
	},
	AmbulanceHelicopterStation = {
		parkingPoint = {
			x = 313.384614, y = -1465.186768, z = 45.500366
		},
		job = "police"
	},
	-- Impound
	DepartmentImpoundParking = {
		parkingPoint = {
			x = 376.391204, y = -1612.641724, z = 28.25
		},
	},
	MechanicImpoundParking = {
		parkingPoint = {
			x = -368.109894, y = -96.857140, z = 44.75
		},
	},

-- Sandy Shore
	-- Police and Ambulance
	AmbulanceSandyShore = { -- SandyShore
		parkingPoint = {
		x = 1843.20, y = 3706.58, z = 32.50
	},
	job = "police"
	},
	-- Impound
	SandyShoreImpoundParking = {
		parkingPoint = {
			x = 1724.123046, y = 3713.736328, z = 33.25
		},
	},

-- Paleto Bay
	-- Police
	PolicePaletoBay = {
		parkingPoint = {
			x = -459.6860, y = 6042.5005, z = 30.3405
		},
		job = "police"
	},
	-- Ambulance
	AmbulancePaletoBay = { -- Paleto Bay
		parkingPoint = {
		x = -254.4819, y = 6349.3433, z = 31.3310
	},
	job = "police"
	},
	-- Impound
	PaletoBayImpoundParking = {
		parkingPoint = {
				x = -222.7054, y = 6184.1553, z = 30.4927
		},
	},

-- Custom Shop
	Custom1 = {
		parkingPoint = {
			x = -471.9967, y = 1113.3533, z = 326.8656
		},
	},
	Custom2 = {
		parkingPoint = {
			x = -475.9806, y = 1098.8107, z = 326.8656
		},
	},

	PaletoBayParking = {
		parkingPoint = {
			x = 115.25, y = 6607.97021484375, z = 30.89999961853027
		},
	},
	GarageChicken1 = {
		parkingPoint = {
			x = 90.58999633789064, y = -1108.9300537109375, z = 28.15999984741211
		},
	},
	GarageChicken2 = {
		parkingPoint = {
			x = 207.83999633789065, y = -846.6599731445312, z = 29.43000030517578
		},
	},
	KayoGarage = {
		parkingPoint = {
			x = 4901.47021484375, y = -5208.72998046875, z = 1.50999999046325
		},
	},
	KayoBoat = {
		parkingPoint = {
			x = 4954.580078125, y = -5163.2900390625, z = 0.4
		},
	},
	BoatShop = {
		parkingPoint = {
			x = -867.5800170898438, y = -1367.8699951171875, z = 0.4
		},
	},
}

Config.Impounds = {

	MechanicImpound = {
		GetOutPoint = {
			x = -359.02,
			y = -88.08,
			z = 45.56,
		},
		SpawnPoint = {
			x = -346.92,
			y = -90.19,
			z = 45.65,
			heading = 72.51,
		},
		Sprite = 524,
		Scale = 0.8,
		Colour = 1,
		Cost = 3000,
	},
	MechanicImpound2 = {
		GetOutPoint = {
			x = -1120.3199,
			y = -1988.5799,
			z = 13.1700,
		},
		SpawnPoint = {
			x = -1122.9699,
			y = -1985.6700,
			z = 13.1700,
			heading = 318.44,
		},
		Sprite = 524,
		Scale = 0.8,
		Colour = 1,
		Cost = 3000,
	},
	MechanicImpound3 = {
		GetOutPoint = {
			x = 900.0800,
			y = -1031.6899,
			z = 34.9700,
		},
		SpawnPoint = {
			x = 900.0800,
			y = -1031.6899,
			z = 34.9700,
			heading = 1.32,
		},
		Sprite = 524,
		Scale = 0.8,
		Colour = 1,
		Cost = 3000,
	},
	PoliceImpound = {
		GetOutPoint = {
			x = 418.22,
			y = -1013.00,
			z = 29.20,
		},
		SpawnPoint = {
			x = 418.22,
			y = -1013.00,
			z = 29.20,
			heading = 92.07,
		},
		Sprite = 524,
		Scale = 0.8,
		Colour = 1,
		Cost = 3000,
	},
	HospitalImpound = {
		GetOutPoint = {
			x = 304.98,
			y = -1452.15,
			z = 29.96,
		},
		SpawnPoint = {
			x = 312.27,
			y = -1444.56,
			z = 29.79,
			heading = 229.45,
		},
		Sprite = 524,
		Scale = 0.8,
		Colour = 1,
		Cost = 3000,
	},
	SandyShoreImpound = {
		GetOutPoint = {
			x = 1737.78,
			y = 3718.97,
			z = 34.04,
		},
		SpawnPoint = {
			x = 1737.78,
			y = 3718.97,
			z = 34.04,
			heading = 22.08,
		},
		Sprite = 524,
		Scale = 0.8,
		Colour = 1,
		Cost = 3000,
	},
	PaletoBayImpound = {
		GetOutPoint = {
			x = -217.6612,
			y = 6200.8413,
			z = 31.4900,
		},
		SpawnPoint = {
			x = -217.6612,
			y = 6200.8413,
			z = 31.4900,
			heading = 228.3020,
		},
		Sprite = 524,
		Scale = 0.8,
		Colour = 1,
		Cost = 3000,
	},
	KayoGarage = {
		GetOutPoint = {
			x=4950.52978515625, y=-5318.14013671875, z=8.09000015258789,
		},
		SpawnPoint = {
			x=4950.52978515625, y=-5318.14013671875, z=8.09000015258789,
			heading = 78.28,
		},
		Sprite = 524,
		Scale = 0.8,
		Colour = 1,
		Cost = 3000,
	},
}

Config.ImpoundDepartment = {
	LosSantos = {
		GetOutPoint = {
			x = 382.3699,
			y = -1624.8599,
			z = 29.2900
		},
		SpawnPoint = {
			x = 391.7200,
			y = -1620.2199,
			z = 29.2900,
			heading = 315.58,
		},
		Sprite = 524,
		Scale = 0.8,
		Colour = 1,
		Cost = 1500,
	},
	SandyShore = {
		GetOutPoint = {
			x = 1773.93,
			y = 3650.27,
			z = 34.43,
		},
		SpawnPoint = {
			x = 1778.92,
			y = 3656.43,
			z = 34.32,
			heading = 323.37,
		},
		Sprite = 524,
		Scale = 0.8,
		Colour = 1,
		Cost = 1500,
	},
	PaletoBay = {
		GetOutPoint = {
			x = -224.9697,
			y = 6265.7422,
			z = 31.5859,
		},
		SpawnPoint = {
			x = -223.4122,
			y = 6258.5444,
			z = 31.4677,
			heading = 133.4847,
		},
		Sprite = 524,
		Scale = 0.8,
		Colour = 1,
		Cost = 1500,
	},
}

Config.ImpoundBoat = {

	LosSantos = {
		GetOutPoint = {
			x = 1230.9300537109375,
			y = -3348.6201171875,
			z = 5.90000009536743,
		},
		SpawnPoint = {
			x = 1210.47998046875,
			y = -3363.639892578125,
			z = 7.38000011444091,
			heading = 273.13,
		},
		Sprite = 524,
		Scale = 0.8,
		Colour = 1,
		Cost = 3000,
	},
	Kayo = {
		GetOutPoint = {
			x = 4898.06005859375,
			y = -5168.8701171875,
			z = 2.46000003814697,
		},
		SpawnPoint = {
			x = 4926.43017578125,
			y = -5166.81982421875,
			z = 3.94000005722045,
			heading = 70.12,
		},
		Sprite = 524,
		Scale = 0.8,
		Colour = 1,
		Cost = 3000,
	},
}

exports("getGarages", function()
	return Config.Garages
end)
exports("getImpounds", function()
	return Config.Impounds
end)
