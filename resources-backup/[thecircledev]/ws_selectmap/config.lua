Config = {}


Config['Extended'] = false                                      -- // 1.1 = true || 1.2 - 1.9.4 = false

Config.EventRoute = {
	['getSharedObject'] = 'esx:getSharedObject',
	['playerLoaded'] = 'esx:playerLoaded',						-- Default: 'esx:playerLoaded'
}

Config.UseCommand = true										-- เปิดใช้ Command 
Config.Command = 'selectmap'									-- ชื่อ Command ที่เปิดใช้

-- Function เรียกใช้ สำหรับเอาไปเชื่อมกับสคริปอื่น
-- exports['ws_select_map']:selectmap()

-- Config Map ทำให้หมดแล้วกรณีต้องการเพิ่ม ติดต่อสอบถาม ws 

Config.map = {

	['default'] = {
		["default_0_0"] = "minimap_0_0",
		["default_0_1"] = "minimap_0_1",
		["default_1_0"] = "minimap_1_0",
		["default_1_1"] = "minimap_1_1",
		["default_2_0"] = "minimap_2_0",
		["default_2_1"] = "minimap_2_1",
		["default_lod_128"] = "minimap_lod_128",
		["default_sea_0_0"] = "minimap_sea_0_0",
		["default_sea_0_1"] = "minimap_sea_0_1",
		["default_sea_1_0"] = "minimap_sea_1_0",
		["default_sea_1_1"] = "minimap_sea_1_1",
		["default_sea_2_0"] = "minimap_sea_2_0",
		["default_sea_2_1"] = "minimap_sea_2_1"
    },

	['classic'] = {
		["classic_0_0"] = "minimap_0_0",
		["classic_0_1"] = "minimap_0_1",
		["classic_1_0"] = "minimap_1_0",
		["classic_1_1"] = "minimap_1_1",
		["classic_2_0"] = "minimap_2_0",
		["classic_2_1"] = "minimap_2_1",
		["classic_lod_128"] = "minimap_lod_128",
		["classic_sea_0_0"] = "minimap_sea_0_0",
		["classic_sea_0_1"] = "minimap_sea_0_1",
		["classic_sea_1_0"] = "minimap_sea_1_0",
		["classic_sea_1_1"] = "minimap_sea_1_1",
		["classic_sea_2_0"] = "minimap_sea_2_0",
		["classic_sea_2_1"] = "minimap_sea_2_1"
    },

	['color'] = {
		["color_0_0"] = "minimap_0_0",
		["color_0_1"] = "minimap_0_1",
		["color_1_0"] = "minimap_1_0",
		["color_1_1"] = "minimap_1_1",
		["color_2_0"] = "minimap_2_0",
		["color_2_1"] = "minimap_2_1",
		["color_lod_128"] = "minimap_lod_128",
		["color_sea_0_0"] = "minimap_sea_0_0",
		["color_sea_0_1"] = "minimap_sea_0_1",
		["color_sea_1_0"] = "minimap_sea_1_0",
		["color_sea_1_1"] = "minimap_sea_1_1",
		["color_sea_2_0"] = "minimap_sea_2_0",
		["color_sea_2_1"] = "minimap_sea_2_1"
    },

	['colorv2'] = {
		["colorv2_0_0"] = "minimap_0_0",
		["colorv2_0_1"] = "minimap_0_1",
		["colorv2_1_0"] = "minimap_1_0",
		["colorv2_1_1"] = "minimap_1_1",
		["colorv2_2_0"] = "minimap_2_0",
		["colorv2_2_1"] = "minimap_2_1",
		["colorv2_lod_128"] = "minimap_lod_128",
		["colorv2_sea_0_0"] = "minimap_sea_0_0",
		["colorv2_sea_0_1"] = "minimap_sea_0_1",
		["colorv2_sea_1_0"] = "minimap_sea_1_0",
		["colorv2_sea_1_1"] = "minimap_sea_1_1",
		["colorv2_sea_2_0"] = "minimap_sea_2_0",
		["colorv2_sea_2_1"] = "minimap_sea_2_1"
    },

    ['postal'] = {
		["postal_0_0"] = "minimap_0_0",
		["postal_0_1"] = "minimap_0_1",
		["postal_1_0"] = "minimap_1_0",
		["postal_1_1"] = "minimap_1_1",
		["postal_2_0"] = "minimap_2_0",
		["postal_2_1"] = "minimap_2_1",
		["postal_lod_128"] = "minimap_lod_128",
		["postal_sea_0_0"] = "minimap_sea_0_0",
		["postal_sea_0_1"] = "minimap_sea_0_1",
		["postal_sea_1_0"] = "minimap_sea_1_0",
		["postal_sea_1_1"] = "minimap_sea_1_1",
		["postal_sea_2_0"] = "minimap_sea_2_0",
		["postal_sea_2_1"] = "minimap_sea_2_1"
    },

	['postalv2'] = {
		["postalv2_0_0"] = "minimap_0_0",
		["postalv2_0_1"] = "minimap_0_1",
		["postalv2_1_0"] = "minimap_1_0",
		["postalv2_1_1"] = "minimap_1_1",
		["postalv2_2_0"] = "minimap_2_0",
		["postalv2_2_1"] = "minimap_2_1",
		["postalv2_lod_128"] = "minimap_lod_128",
		["postalv2_sea_0_0"] = "minimap_sea_0_0",
		["postalv2_sea_0_1"] = "minimap_sea_0_1",
		["postalv2_sea_1_0"] = "minimap_sea_1_0",
		["postalv2_sea_1_1"] = "minimap_sea_1_1",
		["postalv2_sea_2_0"] = "minimap_sea_2_0",
		["postalv2_sea_2_1"] = "minimap_sea_2_1"
    },
	
	['satellite'] = {
		["satellite_0_0"] = "minimap_0_0",
		["satellite_0_1"] = "minimap_0_1",
		["satellite_1_0"] = "minimap_1_0",
		["satellite_1_1"] = "minimap_1_1",
		["satellite_2_0"] = "minimap_2_0",
		["satellite_2_1"] = "minimap_2_1",
		["satellite_lod_128"] = "minimap_lod_128",
		["satellite_sea_0_0"] = "minimap_sea_0_0",
		["satellite_sea_0_1"] = "minimap_sea_0_1",
		["satellite_sea_1_0"] = "minimap_sea_1_0",
		["satellite_sea_1_1"] = "minimap_sea_1_1",
		["satellite_sea_2_0"] = "minimap_sea_2_0",
		["satellite_sea_2_1"] = "minimap_sea_2_1"
    },
    
}





