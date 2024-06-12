-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

Config = Config or {}

Config.EventRoute = {
    GetSharedObject = 'esx:getSharedObject'       -- ชื่อ Event สำหรับดึง Framework ไปใช้ (ค่าเริ่มต้น esx:getSharedObject)
}

Config.EnablePrayText = false		-- เปิดใช้งานคำอธิษฐานบนหัวหรือไม่ (ถ้าเปิด Resmon ฝั่ง Client จะทำงานหนักมากเพราะต้อง DrawText)
Config.EnablePrayAnnouncement = true	-- เปิดใช้งานประกาศคำอธิษฐานหรือไม่
Config.EnableCollectKrathong = false		-- เปิดให้สามารถเก็บกระทงได้หรือไม่
Config.ProgressBar = "mythic_progbar:client:progress"      -- Event ของหลอดโหลด

Config.Marker = {
	Krathong = {		-- ตั้งค่า Marker จุดลอยกระทง				
		Type = 21,		-- ประเภทของ Marker 	
		Scale = {		-- ขนาดของ Marker
			X = 0.7,		-- ขนาดแกน X		
			Y = 0.7,		-- ขนาดแกน Y
			Z = 0.7,		-- ขนาดแกน Z
		},
		Color = {
			Red = 0,		-- สีของ Marker
			Green = 204,		-- สีของ Marker
			Blue = 204,		-- สีของ Marker
			Alpha = 100,		-- ความโปร่งแสง
		},
		RenderDistance = 15.0		-- ระยะที่จะแสดง Marker
	}
}

Config.Blips = {
	Krathong = {
		Enable = false,	-- เปิดใช้งาน Blips หรือไม่
		Coords = vector3(-731.9199829101562, -1451.3499755859375, 5.05000019073486),		-- พิกัดของ Blips
		Id = 304,		-- รูปสัญลักษณ์ของ Blips
		Color = 0,		-- สีของ Blips
		Size = 0.8,		-- ขนาด Blips
		Text = "Krathong Festival"		-- ข้อความของ Blips
	}
}

Config.PrayText = {
	Font = 'sarabun',		-- ชื่อฟอนต์ที่จะใช้สำหรับแสดงข้อความบนหัว
	Scale = 0.7,		-- ขนาดของฟอนต์บนหัว
	Coords = vector3(-781, -1496.969970703125, 1.45000004768371),		-- พิกัดจุดที่จะให้แสดงข้อความบนหัว
	PlayerRadius = 10.0,		-- ระยะที่จะแสดงข้อความบนหัวของผู้เล่นคนอื่น
	CoordsRadius = 20.0		-- ระยะที่จะแสดงข้อความบนหัวของตัวเรา
}