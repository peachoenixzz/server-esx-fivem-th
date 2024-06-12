-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

-- ตั้งค่ากลับไป Filter ตั้งต้นเสมอเมื่อปิดกระเป๋า
Config.SetDefaultFilterOnCloseInventory = true

-- สามารถหา Icon ได้ที่ https://icon-sets.iconify.design/
-- หากต้องการให้ Filter ไหนเป็นค่าเริ่มต้นให้ใส่ default = true
Config.FilterIndicators = {
	{
		default = true,
		name = 'all',
		label = 'ทั้งหมด',
		icon = 'ion:grid-outline'
	},
	{
		name = 'account',
		label = 'การเงิน',
		icon = 'ion:wallet-outline'
	},
	{
		name = 'food',
		label = 'อาหาร',
		icon = 'ion:restaurant-outline'
	},
	{
		name = 'weapon',
		label = 'อาวุธ',
		icon = 'ion:eyedrop-outline'
	},
	{
		name = 'armory',
		label = 'ยุทธโภค',
		icon = 'game-icons:trench-body-armor'
	},
	{
		name = 'box',
		label = 'แพ็คกล่อง',
		icon = 'solar:box-bold-duotone'
	},
	{
		name = 'illegal',
		label = 'ผิดกฎหมาย',
		icon = 'ion:ban'
	},
	{
		name = 'key',
		label = 'กุญแจ',
		icon = 'ion:key-outline'
	},
	{
		name = 'fashion',
		label = 'แฟชั่น',
		icon = 'ion:star-outline'
	},
	--{
	--	name = 'accessory',
	--	label = 'เครื่องแต่งกาย',
	--	icon = 'ion:shirt-outline'
	--},
}

-- ใส่ค่า Filter ให้ตรงตามโหมดด้านบน โดนโหมดที่ไม่จำเป็นต้องใส่ Items ได้แก่ all, cloth
Config.FilterItems = {
	['key'] = {
		'vehicle_key',
	},
	['food'] = {
		'noodle',
		'beer',
		'meal_1',
		'meal_2',
		'meal_3',
		'meal_mre',
	},
	['armory'] = {
		'vest',
		'painkiller',
		'bandage',
		'aed',
		'adrenaline',
		'fight_pack',
	},
	['box'] = {
		'box_gold',
		'box_steel',
		'box_copper',
		'box_wood',
		'box_cement',
		'box_diamond',
		'box_ruby',
		'weapon_box',
	},
	['fashion'] = {
		'baby1',
		'baby2',
		'baby3',
		'baby4',
		'baby5',
		'baby6',
		'baby7',
		'baby8',
		'spacpup',
		'spacpupb',
		'spacpupc',
		'spacpupd',
		'spacpupe',
		'spacpupf',
		'summersocute1',
		'summersocute2',
		'summersocute3',
		'summersocute4',
		'summersocute5',
		'summersocute6',
		'booster1',
		'booster2',
		'booster3',
	},
	['illegal'] = {
		'cocaine_1',
		'cocaine_2',
		'weed',
		'weed_pack',
		'cement',
		'meth',
		'meth_a',
		'amp_r',
		'amp_b',
		'amp_g',
		'meth_b',
		'heroine',
		'keycard_silver',
		'keycard_gold',
		'keycard_red',
		'house_silver',
		'house_gold',
		'house_red',
		'screwdv',
		'screwdv_broken',
		'disruptor',
	}
}

-- ซ่อนสิ่งของต่างๆจากการแสดงทั้งหมด (ตามหมวดหมู่สิ่งของ)
Config.HideItemsFromAllItemListByCategory = {
	['account'] = false,
	['item'] = false,
	['weapon'] = false,
	['key'] = true,
	['fashion'] = true,
	['accessory'] = false,
	-- Category หลักจะมีแค่นี้!
	-- *ค่าที่อยู่ใน Config.FilterItems จะเป็นแค่ Filter เท่านั้น ไม่ใช่ Category

	-- สำหรับ Custom ให้ใส่ชนิดของ Custom Item นั้นๆ
	['personal'] = false,
}

-- ซ่อนสิ่งของต่างๆจากการแสดงทั้งหมด (ตามชื่อของสิ่งของ)
Config.HideItemsFromAllItemListByName = {
	-- ['water'] = true,
	-- ['WEAPON_BAT'] = true,
	['baby1'] = false,
	['baby2'] = false,
	['baby3'] = false,
	['baby4'] = false,
	['baby5'] = false,
	['baby6'] = false,
	['baby7'] = false,
	['baby8'] = false,
	['spacpup'] = false,
	['spacpupb'] = false,
	['spacpupc'] = false,
	['spacpupd'] = false,
	['spacpupe'] = false,
	['spacpupf'] = false,
	['summersocute1'] = false,
	['summersocute2'] = false,
	['summersocute3'] = false,
	['summersocute4'] = false,
	['summersocute5'] = false,
	['summersocute6'] = false,
	['booster1'] = false,
	['booster2'] = false,
	['booster3'] = false,
}