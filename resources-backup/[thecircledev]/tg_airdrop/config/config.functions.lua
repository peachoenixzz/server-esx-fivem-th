-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

Config = Config or {}

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อมีแจ้งเตือนส่งมาหาผู้เล่น (ฟังก์ชั่นในฝั่ง Client)
-- text คือข้อความแจ้งเตือน
-- type คือประเภทของแจ้งเตือน มีทั้งหมด 2 ประเภท (error = ล้มเหลว / success สำเร็จ)
Config.ClientNotification = function(type, text)
    TriggerEvent("pNotify:SendNotification", {
		text = text,
		type = type,
		timeout = 3000,
		layout = "bottomCenter",
		queue = "global"
	})
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อมีแจ้งเตือนส่งมาหาผู้เล่น (ฟังก์ชั่นในฝั่ง Server)
-- source คือไอดีผู้เล่น
-- text คือข้อความแจ้งเตือน
-- type คือประเภทของแจ้งเตือน มีทั้งหมด 2 ประเภท (error = ล้มเหลว / success สำเร็จ)
Config.ServerNotification = function(source, type, text)
    TriggerClientEvent("pNotify:SendNotification", source, {
		text = text,
		type = type,
		timeout = 3000,
		layout = "bottomCenter",
		queue = "global"
	})
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อผู้เล่นอยู่ตรงกล่องแอร์ดรอป (ฟังก์ชั่นในฝั่ง Client)
-- text คือข้อความแจ้งเตือน
Config.BoxNotification = function(text)
	ESX.ShowHelpNotification(text)
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อผู้เล่นเก็บแอร์ดรอป (ฟังก์ชั่นในฝั่ง Client)
Config.AfterAirdropCollect = function()
	-- สำหรับเซิร์ฟเวอร์ที่เอาไว้ใส่เควส หรือต้องการเพิ่มบางอย่างหลังเก็บของจากกล่องแอร์ดรอป
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อเปิดใช้งาน Config.EnableCustomLog (ฟังก์ชั่นในฝั่ง Server)
-- source คือไอดีผู้เล่น
-- type คือประเภทของไอเทม มีทั้งหมด 3 ประเภท (item = ไอเทม / money = เงินสด / blackmoney = เงินผิดกฎหมาย)
-- playerName คือชื่อผู้เล่น
-- name คือชื่อไอเทม ชื่อเงินสด หรือชื่อเงินผิดกฎหมาย (ชื่อที่จะแสดงขึ้นอยู่กับ type)
-- count คือจำนวน
Config.CustomLog = function(source, type, playerName, name, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'PlayerCollectAirdrop',
	content = ('%s ได้รับ %s จำนวน %s ชิ้นจากการเก็บ Airdrop'):format(playerName, name, count),
	source = xPlayer.source
	}) -- End log
end


