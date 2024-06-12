Config = {}

Config.AllTattooList = json.decode(LoadResourceFile(GetCurrentResourceName(), 'AllTattoos.json'))
Config.TattooCats = {
	{"ZONE_HAIR", "HAIR", {vec(0.0, 0.7, 0.7), vec(0.7, 0.0, 0.7), vec(0.0, -0.7, 0.7), vec(-0.7, 0.0, 0.7)}, vec(0.0, 0.0, 0.5)},
	{"ZONE_HEAD", "HEAD", {vec(0.0, 0.7, 0.7), vec(0.7, 0.0, 0.7), vec(0.0, -0.7, 0.7), vec(-0.7, 0.0, 0.7)}, vec(0.0, 0.0, 0.5)},
	{"ZONE_LEFT_LEG", "LEFT LEGS", {vec(-0.2, 0.7, -0.7), vec(-0.7, 0.0, -0.7), vec(-0.2, -0.7, -0.7)}, vec(-0.2, 0.0, -0.6)},
	{"ZONE_LEFT_ARM", "LEFT ARMS", {vec(-0.4, 0.5, 0.2), vec(-0.7, 0.0, 0.2), vec(-0.4, -0.5, 0.2)}, vec(-0.2, 0.0, 0.2)},
	{"ZONE_RIGHT_LEG", "RIGHT LEGS", {vec(0.2, 0.7, -0.7), vec(0.7, 0.0, -0.7), vec(0.2, -0.7, -0.7)}, vec(0.2, 0.0, -0.6)},
	{"ZONE_TORSO", "BODY", {vec(0.0, 0.7, 0.2), vec(0.0, -0.7, 0.2)}, vec(0.0, 0.0, 0.2)},
	{"ZONE_RIGHT_ARM", "RIGHT ARMS", {vec(0.4, 0.5, 0.2), vec(0.7, 0.0, 0.2), vec(0.4, -0.5, 0.2)}, vec(0.2, 0.0, 0.2)},
}

Config.Shops = {
	{
		coords = vector3(1322.73, -1653.03, 52.28), -- แถวโพหมู
		distance = 2.5,
		debug = false,
		name = 'tattooA',
	},
	{
		coords = vector3(-1154.18, -1426.56, 4.95), -- แถวร้านหน้ากาก
		distance = 2.5,
		debug = false,
		name = 'tattooB',
	},
	{
		coords = vector3(323.08, 181.01, 103.59), -- แถวโรงหนัง
		distance = 2.5,
		debug = false,
		name = 'tattooC',
	},
}

--Config.interiorIds = {}
--for k, v in ipairs(Config.Shops) do
--    Config.interiorIds[#Config.interiorIds + 1] = GetInteriorAtCoords(v)
--end