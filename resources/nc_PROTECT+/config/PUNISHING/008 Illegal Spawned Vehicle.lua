-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config.Punishing['illegal_spawned_vehicle'] = {						-- ป้องกันการสร้าง VEHICLE อย่างไม่ถูกต้อง
	enable = true,
	punish = 'ban',								-- 'none|kick|ban' [none: ไม่ทำอะไร | kick: เตะผู้เล่น | ban: แบนผู้เล่น]
	attempt = 1,								-- จำนวนครั้งที่ผู้เล่นสามารถกระทำผิดได้
	attempt_time = 15 * 60,						-- ระยะเวลาที่ไม่อนุญาตให้ผู้เล่นทำผิดซ้ำได้อีก (จะมีผลกรณีที่ attempt > 1) *หน่วยเป็นวินาที | Default: 60 วินาที
	alert = {
		kick = 'Suspicious action detected, ตรวจพบการกระทำต้องสงสัย',
		ban = 'สร้าง %s อย่างไม่ถูกต้อง'
	},
	discord_log = {
		webhook = 'https://discord.com/api/webhooks/1221759049041969184/Tqksbp_ITPVbrupNIltMcAdqDdbNKYbi6Vf_uhZNQIH7_86XecwwCeEOlyXCI3En1tLm',
		message = 'สร้าง %s อย่างไม่ถูกต้อง',
		screenshot = true
	},
	admin_notification = {
		enable = true,
		title = 'ตรวจพบผู้กระทำผิด',
		description = 'ผู้เล่นไอดี %s สร้าง %s อย่างไม่ถูกต้อง'
	}
}