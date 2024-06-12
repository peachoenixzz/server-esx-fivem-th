Config 						= {}
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

Config.AllMeal ={
	Meal1 = {
		ItemName = "meal_1", --ข้าวราดแกง
		Hunger = 3000000,
		Health = 0,
		Stress = 750000,
		AnimDict = "mp_player_inteat@burger",
		Anim = "mp_player_int_eat_burger",
		Prop = "prop_cs_plate_01",
		PropBone = 18905,
		PropCoord = { x = 0.13, y = 0.05, z = 0.0 },
		PropRotation = { x = -110.0, y = -40.0, z = 0.0 },
		time = {30000, 30000, 30000, 30000, 30000},
	},
	Meal2 = {
		ItemName = "meal_2", --กระเพราไก่
		Hunger = 3000000,
		Health = 0,
		Stress = 0,
		AnimDict = "mp_player_inteat@burger",
		Anim = "mp_player_int_eat_burger",
		Prop = "prop_cs_plate_01",
		PropBone = 18905,
		PropCoord = { x = 0.13, y = 0.05, z = 0.0 },
		PropRotation = { x = -110.0, y = -40.0, z = 0.0 },
		time = {30000, 30000, 30000, 30000, 30000},
	},
	Meal3 = {
		ItemName = "meal_3", --นมจืด
		Hunger = 300000,
		Health = 0,
		Stress = 900000,
		AnimDict = "mp_player_inteat@burger",
		Anim = "mp_player_int_eat_burger",
		Prop = "v_res_tt_milk",
		PropBone = 18905,
		PropCoord = { x = 0.13, y = 0.05, z = 0.0 },
		PropRotation = { x = -110.0, y = -40.0, z = 0.0 },
		time = {20000, 20000, 20000, 20000, 20000},
	},
	Mealmre = {
		ItemName = "meal_mre",
		Hunger = 3000000,
		Health = 0,
		Stress = 3000000,
		AnimDict = "mp_player_inteat@burger",
		Anim = "mp_player_int_eat_burger",
		Prop = "prop_cs_plate_01",
		PropBone = 18905,
		PropCoord = { x = 0.13, y = 0.05, z = 0.0 },
		PropRotation = { x = -110.0, y = -40.0, z = 0.0 },
		time = {30000, 30000, 30000, 30000, 30000},
	},

}