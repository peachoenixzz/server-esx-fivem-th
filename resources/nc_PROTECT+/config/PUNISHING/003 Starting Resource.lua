-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config.Punishing['starting_resource'] = {							-- ป้องกันการสั่งเริ่มการทำงานทรัพยากรณ์ที่ไม่มีอยู่ในระบบ
	punish = 'ban',								-- 'none|kick|ban' [none: ไม่ทำอะไร | kick: เตะผู้เล่น | ban: แบนผู้เล่น]
	attempt = 1,								-- จำนวนครั้งที่ผู้เล่นสามารถกระทำผิดได้
	attempt_time = 15 * 60,						-- ระยะเวลาที่ไม่อนุญาตให้ผู้เล่นทำผิดซ้ำได้อีก (จะมีผลกรณีที่ attempt > 1) *หน่วยเป็นวินาที | Default: 60 วินาที
	alert = {
		kick = 'Suspicious action detected, ตรวจพบการกระทำต้องสงสัย',
		ban = 'สั่งเริ่มการทำงาน Resource (%s)'
	},
	discord_log = {
		webhook = 'https://discord.com/api/webhooks/1221759049041969184/Tqksbp_ITPVbrupNIltMcAdqDdbNKYbi6Vf_uhZNQIH7_86XecwwCeEOlyXCI3En1tLm',
		message = 'สั่งเริ่มการทำงาน Resource (%s)',
		screenshot = true
	},
	admin_notification = {
		enable = true,
		title = 'ตรวจพบผู้กระทำผิด',
		description = 'ผู้เล่นไอดี %s สั่งเริ่มการทำงาน Resource (%s)'
	}
}