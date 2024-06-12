-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config.ShowProtectPlusLogoOnStart = true	-- แสดง PROTECT+ Logo เมื่อเข้าเกม

Config.AutoProtectResources = true			-- เปิดใช้งานระบบเชื่อม PROTECT+ เข้ากับ Resource ต่างๆให้อัตโนมัติ

Config.Admins = {
	['superadmin'] = false,
	['admin'] = false,
}

Config.IdentifierType = 'steam'				-- 'steam|live|discord'		*แนะนำให้ตั้งค่าเป็น steam

Config.ImageCaches = {						-- Cache รูปภาพสำหรับใช้งาน Screenshot
	channelId = '1221758968959996056',							-- Channel ID
	webhook = 'https://discord.com/api/webhooks/1221759049041969184/Tqksbp_ITPVbrupNIltMcAdqDdbNKYbi6Vf_uhZNQIH7_86XecwwCeEOlyXCI3En1tLm'							-- Discord Webhook สำหรับ Cache
}

Config.BannedConnectWebhook = 'https://discord.com/api/webhooks/1221759049041969184/Tqksbp_ITPVbrupNIltMcAdqDdbNKYbi6Vf_uhZNQIH7_86XecwwCeEOlyXCI3En1tLm'			-- แสดง Discord Log เมื่อผู้เล่นที่ถูกแบนพยายามเข้าสู่ Server

Config.AdminActivitiesWebhook = 'https://discord.com/api/webhooks/1221759049041969184/Tqksbp_ITPVbrupNIltMcAdqDdbNKYbi6Vf_uhZNQIH7_86XecwwCeEOlyXCI3En1tLm'			-- แสดง Discord Log เมื่อ Admin แบน/ปลดแบนผู้เล่นผ่านคำสั่ง ban/unban