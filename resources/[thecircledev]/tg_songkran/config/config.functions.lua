-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

Config = Config or {}

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อหลอดโหลดทำงาน (ฟังก์ชั่นในฝั่ง Client)
Config.ProgressBar = function()
	TriggerEvent('mythic_progbar:client:progress', {
		name = "watergun",
		duration = Config.RefillWater.Duration * 1000,
		label = 'กำลังเติมน้ำ',
		useWhileDead = false,
		canCancel = true,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
	}, function(status)

	end)
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อมีแจ้งเตือนส่งมาหาผู้เล่น (ฟังก์ชั่นในฝั่ง Client)
Config.ClientNotification = function(type, text)
    TriggerEvent("pNotify:SendNotification", {
		text = text,
		type = type,
		timeout = 3000,
		layout = "bottomCenter",
		queue = "global"
	})
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อผู้เล่นใช้ปืนฉีดน้ำ (ฟังก์ชั่นในฝั่ง Client)
Config.ClientOnWatergun = function()
	
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อผู้เล่นถือปืนฉีดน้ำ (ฟังก์ชั่นในฝั่ง Client)
Config.ClientOnHoldingWatergun = function()
	DisableControlAction(0, 25, true)
	DisableControlAction(0, 140, true)		
	DisableControlAction(0, 141, true)
	DisableControlAction(0, 142, true)
	DisableControlAction(0, 143, true)
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อผู้เล่นโดนปะแป้ง (ฟังก์ชั่นในฝั่ง Client)
Config.ClientOnFlour = function()
	SetPedHeadOverlay(PlayerPedId(), 5, 29, (7 / 10) + 0.0)
	SetPedHeadOverlayColor(PlayerPedId(), 5, 2,	52)
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อผู้เล่นอยู่ในระยะที่สามารถเติมน้ำได้ (ฟังก์ชั่นในฝั่ง Client)
Config.ClientActionArea = function()
    ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to refill water')
end
