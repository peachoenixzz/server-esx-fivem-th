-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config.Punishing['illegal_trigger_event'] = {						-- ป้องกัน TriggerEvent แบบไม่ถูกต้อง (ป้องกันการ Trigger ระหว่าง Client)
	punish = 'ban',								-- 'none|kick|ban' [none: ไม่ทำอะไร | kick: เตะผู้เล่น | ban: แบนผู้เล่น]
	attempt = 1,								-- จำนวนครั้งที่ผู้เล่นสามารถกระทำผิดได้
	attempt_time = 15 * 60,						-- ระยะเวลาที่ไม่อนุญาตให้ผู้เล่นทำผิดซ้ำได้อีก (จะมีผลกรณีที่ attempt > 1) *หน่วยเป็นวินาที | Default: 60 วินาที
	alert = {
		kick = 'Suspicious action detected, ตรวจพบการกระทำต้องสงสัย',
		ban = 'TriggerEvent (%s)'
	},
	discord_log = {
		webhook = 'https://discord.com/api/webhooks/1221759049041969184/Tqksbp_ITPVbrupNIltMcAdqDdbNKYbi6Vf_uhZNQIH7_86XecwwCeEOlyXCI3En1tLm',
		message = 'TriggerEvent (%s)'
	},
	admin_notification = {
		enable = true,
		title = 'ตรวจพบผู้กระทำผิด',
		description = 'ผู้เล่นไอดี %s ทำการ TriggerEvent (%s) อย่างไม่ถูกต้อง'
	}
}

Config.Punishing['illegal_trigger_server_event'] = {				-- ป้องกัน TriggerServerEvent แบบไม่ถูกต้อง (ป้องกันการ Trigger ไป Server)
	punish = 'ban',								-- 'none|kick|ban' [none: ไม่ทำอะไร | kick: เตะผู้เล่น | ban: แบนผู้เล่น]
	attempt = 1,								-- จำนวนครั้งที่ผู้เล่นสามารถกระทำผิดได้
	attempt_time = 15 * 60,						-- ระยะเวลาที่ไม่อนุญาตให้ผู้เล่นทำผิดซ้ำได้อีก (จะมีผลกรณีที่ attempt > 1) *หน่วยเป็นวินาที | Default: 60 วินาที
	alert = {
		kick = 'Suspicious action detected, ตรวจพบการกระทำต้องสงสัย',
		ban = 'TriggerServerEvent (%s)'
	},
	discord_log = {
		webhook = '',
		message = 'TriggerServerEvent (%s)'
	},
	admin_notification = {
		enable = true,
		title = 'ตรวจพบผู้กระทำผิด',
		description = 'ผู้เล่นไอดี %s ทำการ TriggerServerEvent (%s) อย่างไม่ถูกต้อง'
	}
}

Config.Punishing['anti_spamming_trigger_server_event'] = {			-- ป้องกันการสั่ง TriggerServerEvent เร็วเกินกำหนด
	punish = 'ban',								-- 'none|kick|ban' [none: ไม่ทำอะไร | kick: เตะผู้เล่น | ban: แบนผู้เล่น]
	attempt = 1,								-- จำนวนครั้งที่ผู้เล่นสามารถกระทำผิดได้
	attempt_time = 15 * 60,						-- ระยะเวลาที่ไม่อนุญาตให้ผู้เล่นทำผิดซ้ำได้อีก (จะมีผลกรณีที่ attempt > 1) *หน่วยเป็นวินาที | Default: 60 วินาที
	alert = {
		kick = 'Suspicious action detected, ตรวจพบการกระทำต้องสงสัย',
		ban = 'Spam TriggerServerEvent (%s)'
	},
	discord_log = {
		webhook = '',
		message = 'Spam TriggerServerEvent (%s)',
		screenshot = true
	},
	admin_notification = {
		enable = true,
		title = 'ตรวจพบผู้กระทำผิด',
		description = 'ผู้เล่นไอดี %s ทำการ Spam TriggerServerEvent (%s)'
	},
	event_list = {
		-- ['eventName'] = antiSpammingTime,		-- eventName : ชื่อ Event | antiSpammingTime : ระยะเวลา (หน่วยเป็น millisecond)
		
		-- ['item:pickUp'] = 3000,
	}
	-- ตัวอย่าง: หากตั้งค่า antiSpammingTime เป็น 3000(3 วินาที) แล้วมีการ TriggerServerEvent ด้วย Event ที่กำหนดเร็วกว่า 3 วินาที จะโดนลงโทษทันที
}