-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config.Punishing['anti_devtools'] = {								-- ป้องกันการเปิดใช้งาน NUI DevTools+
	enable = true,
	punish = 'kick',							-- 'none|kick|ban' [none: ไม่ทำอะไร | kick: เตะผู้เล่น | ban: แบนผู้เล่น]
	alert = {
		kick = 'Do not try to open NUI DevTools',
		ban = 'Open NUI DevTools'
	},
	discord_log = {
		webhook = 'https://discord.com/api/webhooks/1221759049041969184/Tqksbp_ITPVbrupNIltMcAdqDdbNKYbi6Vf_uhZNQIH7_86XecwwCeEOlyXCI3En1tLm',
		message = 'เปิดใช้งาน NUI DevTools'
	},
	admin_notification = {
		enable = true,
		title = 'ตรวจพบผู้กระทำผิด',
		description = 'ผู้เล่นไอดี %s ได้เปิดใช้งาน NUI DevTools'
	}
}