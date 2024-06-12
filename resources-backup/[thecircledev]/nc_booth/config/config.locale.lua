-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config.Locale = {
	GAME = {
		in_zone = 'You are in Booth zone',
		enter_booth = 'Press ~INPUT_CONTEXT~ to ~o~Enter ~s~this market',
		enter_storage = 'Press ~INPUT_CONTEXT~ to ~b~Enter ~s~storage',
		choosing_npc = {
			'~INPUT_MOVE_LEFT_ONLY~ - Previous    ~INPUT_MOVE_RIGHT_ONLY~ - Next',
			'~INPUT_FRONTEND_CANCEL~ - Back to ~y~Edit Booth~s~',
			'~INPUT_FRONTEND_RDOWN~ - ~g~Start Booth ~s~with this ~b~Ped'
		}
	},
	UI = {
		service_label = 'ระบบฝากขายอัตโนมัติ',
		service_button = 'เลือก NPC เพื่อฝากขาย',
		stop_booth_button = 'ปิดร้านค้า',
		commission_label = 'ค่าคอมมิชชั่น',
		active_slot_label = 'ตั้งขาย',
		allow_audio_label = 'เสียงการแจ้งเตือน',
		available_money = 'คุณมี %s อยู่',
		money_unit = '$%s',
		item = {
			price_label = 'ราคา',
			price_unit = '$%s',
			count_unit = 'ชิ้น',
			detail_label_prefix = 'สินค้า:',
			detail_count_prefix = 'มีอยู่',
			soldout = 'สินค้าหมด'
		},
		storage = {
			title = 'คลังเบิกสินค้า',
			button = 'เบิกสินค้า',
			label = 'คลัง # %s'
		},
		chat = {
			chat_title = 'กระดานสนทนา',
			input_placeholder = 'พิมพ์ข้อความที่นี่..',
			owner_default_name = 'เจ้าของร้าน',
			owner_name_prefix = '👑',
			customer_default_name = 'ลูกค้า',
			you_label = '(คุณ)',
			sending_label = 'กำลังส่งข้อความ..',
			customer_enter_booth = 'เข้าชมร้านค้า',
			customer_leave_booth = 'ออกจากร้านค้า',
			customer_buy_item = 'ซื้อ %s จำนวน %s ชิ้น (รวม $%s)'
		},
		dialog = {
			dialog_title = 'ใส่จำนวนที่ต้องการ',
			dialog_info = 'จำนวน %s ชิ้น',
			dialog_close_confirm = 'คุณต้องการยกเลิกการตั้งร้านใช่หรือไม่?',
			dialog_stop_booth = 'คุณต้องการปิดร้านค้าใช่หรือไม่?',
			dialog_confirm = 'ยืนยัน',
			dialog_cancel = 'ยกเลิก',
			dialog_put = 'นำเข้า',
			dialog_take = 'นำออกจาก'
		}
	}
}