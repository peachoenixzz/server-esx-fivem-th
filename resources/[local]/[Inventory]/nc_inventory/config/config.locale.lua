-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config.Locale = {
	GAME = {
		give_select = 'กด ~b~%s ~s~เพื่อเลือก'
	},
	UI = {
		title = 'กระเป๋าส่วนตัว',
		weight = 'น้ำหนัก',
		weight_unit = 'kg',
		account_unit = '$',
		receivable = 'รับมอบของ',
		context_menu = {
			context_use = 'ใช้',
			context_give = 'มอบ',
			context_drop = 'ทิ้ง'
		},
		give = {
			give_account = 'เลือกคนที่ต้องการมอบ <span style="color: #59ffcd;">%s</span> จำนวน <span style="color: #59ffcd;">$%s</span> ให้',
			give_item = 'เลือกคนที่ต้องการมอบ <span style="color: #59ffcd;">%s</span> จำนวน <span style="color: #59ffcd;">%s</span> ชิ้นให้',
			give_weapon = 'เลือกคนที่ต้องการมอบ <span style="color: #59ffcd;">%s</span> ให้',
			give_vehicle_key = 'เลือกคนที่ต้องการมอบกุญแจยานพาหนะทะเบียน <span style="color: #59ffcd;">%s</span> ให้',
			give_house_key = 'เลือกคนที่ต้องการมอบกุญแจบ้าน <span style="color: #59ffcd;">%s</span> ให้',
			give_accessory = 'เลือกคนที่ต้องการมอบ <span style="color: #59ffcd;">%s</span> ให้',
			give_reroll = 'กด <span style="color: #fcbf31;">Spacebar</span> เพื่อมองหาคนรอบข้างใหม่'
		},
		dialog = {
			dialog_title = 'ใส่จำนวนที่ต้องการ',
			dialog_info = 'จำนวน %s ชิ้น',
			dialog_confirm = 'ยืนยัน',
			dialog_cancel = 'ยกเลิก',
			dialog_put = 'นำเข้า',
			dialog_take = 'นำออกจาก'
		},
		secondary_inventory = {
			inside = 'ช่องเก็บของ',
			trunk = 'ท้ายรถ',
			vault = 'ตู้นิรภัย',
			market = 'ร้านค้า',
		},
		search_inventory = {
			info = 'กำลังค้นกระเป๋าของ [%s] %s'
		},
		others = {
			vehicle_key = 'กุญแจยานพาหนะ',
			house_key = 'กุญแจบ้าน'
		},
		default_category = 'ทั่วไป'
	}
}