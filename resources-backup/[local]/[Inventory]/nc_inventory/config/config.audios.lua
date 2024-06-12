-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

-- เปิดใช้งานระบบเสียงในกระเป๋า
Config.EnableAudios = true

-- เสียงต่างๆในกระเป๋า
Config.Audios = {
	inventory_open = '',							-- เสียง "เปิด" กระเป๋า
	inventory_close = '',							-- เสียง "ปิด" กระเป๋า
	item_hover = './sounds/beep1.mp3',				-- เสียงเมื่อ "วางเมาส์" บนสิ่งของ
	item_right_click = './sounds/beep2.mp3',		-- เสียงเมื่อ "คลิกขวา" ที่สิ่งของ
	filter_hover = './sounds/beep1.mp3',			-- เสียงเมื่อ "วางเมาส์" บนปุ่ม Filter
	filter_select = './sounds/beep3.mp3',			-- เสียงเมื่อ "คลิก" เลือก Filter
	context_hover = '',								-- เสียงเมื่อ "วางเมาส์" บนปุ่มใน Context Menu
	context_click = './sounds/beep3.mp3',			-- เสียงเมื่อ "คลิก" บน Context Menu
	button_hover = '',								-- เสียงเมื่อ "วางเมาส์" บนปุ่ม (ยืนยัน/ยกเลิก)
	button_click = './sounds/beep2.mp3',			-- เสียงเมื่อ "คลิก" ที่ปุ่ม (ยืนยัน/ยกเลิก)
	search_expand = './sounds/beep3.mp3',			-- เสียงเมื่อ "เปิด" ช่องค้นหา
	search_collapse = '',							-- เสียงเมื่อ "ปิด" ช่องค้นหา
	receive_item_on = './sounds/switch.wav',		-- เสียงเมื่อ "เปิด" รับมอบของ
	receive_item_off = './sounds/switch.wav',		-- เสียงเมื่อ "ปิด" รับมอบของ
	input_typing = './sounds/beep1.mp3',			-- เสียงเมื่อ "พิมพ์" ในช่องต่างๆ
	open_giving = '',								-- เสียงเมื่อ "เปิด" หน้าต่างเลือกผู้อื่น
	close_giving = '',								-- เสียงเมื่อ "ปิด" หน้าต่างเลือกผู้อื่น
	tab_hover = './sounds/beep1.mp3',				-- เสียงเมื่อกด "TAB" (แสดงผลแถบ Shortcut ปัจจุบัน)
	tab_changed = './sounds/beep3.mp3'				-- เสียงเมื่อกด "TAB" (แสดงผลแถบ Shortcut ถัดไป)
}