Config = {}

Config.Key = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["Enter"] = 191
}

Config.discord = ""  -- แจ้งเตือนดิสคอร์ด
Config.OpenUI = true -- เปิด UI
Config.onhotkeys = true  -- เปิด/ปิดฟังก์ชั่นใช้งานปุ่ม
Config.oncommand = true  -- เปิด/ปิดฟังก์ชั่นใช้งานคำสั่ง /economy
Config.hotkey = Config.Key['F5']  --ตั้งค่าปุ่ม

local second = 1000
local minute = 60 * second
Config.Time = 120 * minute ------ เวราอีโครี
Config.num = 300 ------ จำนวนสินค้าที่จะลดราคา
Config.discount = 5   ------- ลดกี่เปอเซ็น
Config.incre = 5 ------ เพิ่มกี่เปอเซ็น
Config.randomprice = false --สุ่มราคาทุกครั้งเวลารีเซิฟ
Config.drawmarker = false --เปิดรูปตัว $
Config.zones = {
	ecomarketrest = {
		coords = vector3(225.88999938964844, -892.4199829101562, 31.20000076293945),
		Pos = {h = 67.46},
		name = '<font face="font4thai">ตลาด</font>',
		color = 45,
		blipid = 207,
		NPC = 's_m_y_busboy_01',
		position="eco_market_rest"
	},
	ecomarketbar = {
		coords = vector3(150.02000427246097, -1084.6600341796875, 29.51000022888183),
		Pos = {h = 182.35},
		name = '<font face="font4thai">ตลาด</font>',
		color = 45,
		blipid = 207,
		NPC = 's_m_y_busboy_01',
		position="eco_market_bar"
	},
	akfmarket = {
		coords = vector3(-2797.300048828125, -1919.1700439453127, 4.51999998092651),
		Pos = {h = 47.75},
		name = '<font face="font4thai">ตลาด</font>',
		color = 45,
		blipid = 207,
		NPC = 's_m_y_busboy_01',
		position="afk_market"
	},
}

function NotificationNoitemWorkEconomy()

end

Config.listitem = {
	test_1 = {		id  = 1 ,
					item  = "pork_1" ,
					label = "หมู" ,
					price = math.random(34,43) ,
					pricemin = 34 ,
					pricemax = 43 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_a",
					position_item = "eco_market_bar",
					sellPosition = vector3(150.02000427246097, -1084.6600341796875, 29.51000022888183),
					processPosition = vector3(982.918702, -2125.727540, 30.459350),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(1450.378052, 1067.235108, 114.235108),

	},
	test_2 = {		id  = 2 ,
					item  = "pork_2" ,
					label = "หมูสไลด์" ,
					price = math.random(127,171) ,
					pricemin = 127 ,
					pricemax = 171 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_a",
					position_item = "eco_market_rest",
					sellPosition = vector3(225.88999938964844, -892.4199829101562, 31.20000076293945),
					processPosition = vector3(982.918702, -2125.727540, 30.459350),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(1450.378052, 1067.235108, 114.235108),

	},
	test_3 = {		id  = 3 ,
					item  = "chicken_1" ,
					label = "ไก่" ,
					price = math.random(38,52) ,
					pricemin = 38 ,
					pricemax = 52 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_a",
					position_item = "eco_market_bar",
					sellPosition = vector3(150.02000427246097, -1084.6600341796875, 29.51000022888183),
					processPosition = vector3(346.747254, 3407.182374, 36.525268),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(2378.624268, 5053.437500, 46.432984),

	},
	test_4 = {		id  = 4 ,
					item  = "chicken_2" ,
					label = "เนื้อไก่" ,
					price = math.random(148,198) ,
					pricemin = 148 ,
					pricemax = 198 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_a",
					position_item = "eco_market_rest",
					sellPosition = vector3(225.88999938964844, -892.4199829101562, 31.20000076293945),
					processPosition = vector3(346.747254, 3407.182374, 36.525268),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(2378.624268, 5053.437500, 46.432984),

	},
	test_5 = {		id  = 5 ,
					item  = "rice_1" ,
					label = "ข้าว" ,
					price = math.random(37,50) ,
					pricemin = 37 ,
					pricemax = 50 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_a",
					position_item = "eco_market_bar",
					sellPosition = vector3(150.02000427246097, -1084.6600341796875, 29.51000022888183),
					processPosition = vector3(-126.86000061035156, 2790.18994140625, 53.11000061035156),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(2524.114258, 4342.522950, 39.356080),

	},
	test_6 = {		id  = 6 ,
					item  = "rice_2" ,
					label = "กระสอบข้าว" ,
					price = math.random(143,192) ,
					pricemin = 143 ,
					pricemax = 192 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_a",
					position_item = "eco_market_rest",
					sellPosition = vector3(225.88999938964844, -892.4199829101562, 31.20000076293945),
					processPosition = vector3(-126.86000061035156, 2790.18994140625, 53.11000061035156),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(2524.114258, 4342.522950, 39.356080),

	},
	test_7 = {		id  = 7 ,
					item  = "cabbage_1" ,
					label = "กะหล่ำ" ,
					price = math.random(36,48) ,
					pricemin = 36 ,
					pricemax = 48 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_a",
					position_item = "eco_market_bar",
					sellPosition = vector3(150.02000427246097, -1084.6600341796875, 29.51000022888183),
					processPosition = vector3(1551.9599609375, 2190.25, 78.83999633789062),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(2825.4599609375, 4603.9599609375, 46.43999862670898),

	},
	test_8 = {		id  = 8 ,
					item  = "cabbage_2" ,
					label = "กะหล่ำหั่น" ,
					price = math.random(138,184) ,
					pricemin = 138 ,
					pricemax = 184 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_a",
					position_item = "eco_market_rest",
					sellPosition = vector3(225.88999938964844, -892.4199829101562, 31.20000076293945),
					processPosition = vector3(1551.9599609375, 2190.25, 78.83999633789062),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(2825.4599609375, 4603.9599609375, 46.43999862670898),

	},
	test_9 = {		id  = 9 ,
					item  = "milk_1" ,
					label = "นม" ,
					price = math.random(35,47) ,
					pricemin = 35 ,
					pricemax = 47 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_a",
					position_item = "eco_market_bar",
					sellPosition = vector3(150.02000427246097, -1084.6600341796875, 29.51000022888183),
					processPosition = vector3(562.5399780273438, 2737.64990234375, 42.22000122070312),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(2490.469970703125, 4737.47021484375, 34.29999923706055),

	},
	test_10 = {		id  = 10 ,
					item  = "milk_2" ,
					label = "นมกล่อง" ,
					price = math.random(133,178) ,
					pricemin = 133 ,
					pricemax = 178 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_a",
					position_item = "eco_market_rest",
					sellPosition = vector3(225.88999938964844, -892.4199829101562, 31.20000076293945),
					processPosition = vector3(562.5399780273438, 2737.64990234375, 42.22000122070312),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(2490.469970703125, 4737.47021484375, 34.29999923706055),

	},
	test_11 = {		id  = 11 ,
					item  = "fish_1" ,
					label = "ปลากระบอก" ,
					price = math.random(199,232) ,
					pricemin = 199 ,
					pricemax = 232 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_a",
					position_item = "eco_market_bar",
					sellPosition = vector3(150.02000427246097, -1084.6600341796875, 29.51000022888183),
					processPosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(1437.43994140625, 1086.219970703125, 114.0999984741211),

	},
	test_12 = {		id  = 12 ,
					item  = "fish_2" ,
					label = "ปลานิล" ,
					price = math.random(211,253) ,
					pricemin = 211 ,
					pricemax = 253 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_a",
					position_item = "eco_market_bar",
					sellPosition = vector3(150.02000427246097, -1084.6600341796875, 29.51000022888183),
					processPosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(1437.43994140625, 1086.219970703125, 114.0999984741211),

	},
	test_13 = {		id  = 13 ,
					item  = "fish_3" ,
					label = "ปลากระพง" ,
					price = math.random(227,270) ,
					pricemin = 227 ,
					pricemax = 270 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_a",
					position_item = "eco_market_bar",
					sellPosition = vector3(150.02000427246097, -1084.6600341796875, 29.51000022888183),
					processPosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(1437.43994140625, 1086.219970703125, 114.0999984741211),

	},
	test_14 = {		id  = 14 ,
					item  = "hunt_1" ,
					label = "เนื้อหมูป่า" ,
					price = math.random(272,331) ,
					pricemin = 272 ,
					pricemax = 331 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_a",
					position_item = "eco_market_bar",
					sellPosition = vector3(150.02000427246097, -1084.6600341796875, 29.51000022888183),
					processPosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(1437.43994140625, 1086.219970703125, 114.0999984741211),

	},
	test_15 = {		id  = 15 ,
					item  = "hunt_2" ,
					label = "เขากวาง" ,
					price = math.random(290,358) ,
					pricemin = 290 ,
					pricemax = 358 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_a",
					position_item = "eco_market_bar",
					sellPosition = vector3(150.02000427246097, -1084.6600341796875, 29.51000022888183),
					processPosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(1437.43994140625, 1086.219970703125, 114.0999984741211),

	},
	test_16 = {		id  = 16 ,
					item  = "hunt_3" ,
					label = "หนังเสือ" ,
					price = math.random(312,389) ,
					pricemin = 312 ,
					pricemax = 389 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_a",
					position_item = "eco_market_bar",
					sellPosition = vector3(150.02000427246097, -1084.6600341796875, 29.51000022888183),
					processPosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(1437.43994140625, 1086.219970703125, 114.0999984741211),

	},
	test_17 = {		id  = 17 ,
					item  = "afk_gem" ,
					label = "อัญมณี" ,
					price = math.random(1250,1250) ,
					pricemin = 1250 ,
					pricemax = 1250 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_special",
					position_item = "afk_market",
					sellPosition = vector3(-2797.300048828125, -1919.1700439453127, 4.51999998092651),
					processPosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(1437.43994140625, 1086.219970703125, 114.0999984741211),

	},
	test_18 = {		id  = 18 ,
					item  = "afk_squid" ,
					label = "ปลาหมึก" ,
					price = math.random(1200,1200) ,
					pricemin = 1200 ,
					pricemax = 1200 ,
					randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					typemoney = true, -- true เงินเขียว  false เงินแดง
					max_count = 75,
					category = "eco_special",
					position_item = "afk_market",
					sellPosition = vector3(-2797.300048828125, -1919.1700439453127, 4.51999998092651),
					processPosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					pickPosition = vector3(1437.43994140625, 1086.219970703125, 114.0999984741211),

	},
	test_19 = {		id  = 19 ,
					  item  = "bonus_eco" ,
					  label = "Bonus Economy" ,
					  price = math.random(5000,5000) ,
					  pricemin = 5000 ,
					  pricemax = 5000 ,
					  randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					  typemoney = true, -- true เงินเขียว  false เงินแดง
					  max_count = 75,
					  category = "eco_a",
					  position_item = "eco_market_rest",
					  sellPosition = vector3(225.88999938964844, -892.4199829101562, 31.20000076293945),
					  processPosition = vector3(982.918702, -2125.727540, 30.459350),
					  packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					  pickPosition = vector3(1450.378052, 1067.235108, 114.235108),

	},
	test_20 = {		id  = 20 ,
					  item  = "bonus_mining" ,
					  label = "Bonus Mining" ,
					  price = math.random(5000,5000) ,
					  pricemin = 5000 ,
					  pricemax = 5000 ,
					  randomprice = false, -- สุ่มราคาทุกครั้งที่กดขาย
					  typemoney = true, -- true เงินเขียว  false เงินแดง
					  max_count = 75,
					  category = "eco_a",
					  position_item = "eco_market_rest",
					  sellPosition = vector3(225.88999938964844, -892.4199829101562, 31.20000076293945),
					  processPosition = vector3(982.918702, -2125.727540, 30.459350),
					  packagePosition = vector3(949.5599975585938, -2109.72998046875, 30.54999923706054),
					  pickPosition = vector3(1450.378052, 1067.235108, 114.235108),

	},
}