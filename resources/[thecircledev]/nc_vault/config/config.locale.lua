-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config.Locale = {
	GAME = {
		share_select = 'กด ~b~%s ~s~เพื่อเลือก',
		info_text = {
			slot = 'ช่อง: %s',
			account = 'เงิน: %s',
			item = 'สิ่งของ: %s',
			weapon = 'อาวุธ: %s'
		}
	},
	UI = {
		time_left = 'mm:ss',
		loading = 'กำลังโหลดข้อมูล',
		my_vault = 'ตู้เซฟของคุณ',
		shared_vault = 'ตู้เซฟของเพื่อน',
		add_vault = 'สร้างตู้เซฟใหม่',
		add_vault_confirm = 'คุณต้องการเพิ่มตู้เซฟใหม่ใช่หรือไม่?',
		add_vault_confirm_use_item = 'ใช้ %s จำนวน %s ชิ้น',
		add_vault_confirm_use_account = 'ใช้ %s จำนวน $%s',
		add_vault_confirm_required_item = 'ต้องการ %s จำนวน %s ชิ้น',
		add_vault_confirm_required_account = 'ต้องการ %s จำนวน $%s',
		lvl = 'LVL',
		lvl_max = 'MAX',
		exp = 'EXP : %s / %s',
		info_button = 'ข้อมูล',
		setting_button = 'ตั้งค่า',
		setting_info_button = 'ข้อมูล',
		setting_panel = {
			upgrade_button = {
				title = 'อัพเกรด',
				subtitle = 'เพิ่มเลเวล',
				reverse = false,
			},
			open_vault_button = {
				title = 'เปิดตู้เซฟ',
				subtitle = 'เก็บของในตู้',
				reverse = false,
			},
			share_button = {
				title = 'แชร์ให้เพื่อน',
			},
			member_button = {
				title = 'รายชื่อเพื่อน',
			},
			vault_detail = {
				title = 'ข้อมูลตู้เซฟนี้',
				next_level = 'LVL ถัดไป',
				unlimited = 'ไม่จำกัด',
				unavailable = 'ไม่สามารถเก็บได้',
				will_available = 'สามารถเก็บได้เมื่อ',
				limit = {
					label = 'สิ่งของ',
					number = '%s ชิ้น'
				},
				weight = {
					label = 'น้ำหนัก',
					number = '%s kg'
				},
				slot = {
					label = 'ช่อง',
					number = '%s ช่อง'
				},
				account = {
					label = 'เงิน',
					number = '%s'
				},
				weapon = {
					label = 'อาวุธ',
					number = '%s ชิ้น'
				},
			},
			remove_vault_button = 'กดเพื่อลบตู้เซฟนี้ทิ้ง (ควรระวัง!)',
			remove_vault_confirm = 'คุณต้องการลบตู้เซฟนี้ใช่หรือไม่? (ระวัง!)'
		},
		dialog = {
			dialog_confirm = 'ยืนยัน',
			dialog_cancel = 'ยกเลิก',
			dialog_change_name = {
				title = 'เปลี่ยนชื่อตู้เซฟ'
			},
			dialog_upgrade = {
				title = 'อัพเกรดตู้เซฟ',
				upgrade_button = 'อัพเกรด',
				total_item_exp = 'EXP +%s',
				item_exp = 'EXP +%s / ชิ้น',
				account_exp = 'EXP +%s / ชิ้น',
				item_owned = 'มีอยู่ %s ชิ้น',
				account_owned = 'มีอยู่ %s ชิ้น',
				confirm_title = 'คุณต้องการอัพเกรดตู้เซฟนี้ใช่หรือไม่?'
			},
			dialog_members = {
				title = 'รายชื่อเพื่อน (รวม %s คน)',
				owner_suffix = '👑',
				loading = 'กำลังโหลดข้อมูล'
			}
		}
	}
}