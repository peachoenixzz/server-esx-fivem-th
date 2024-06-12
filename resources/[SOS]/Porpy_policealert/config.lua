--[[
	resource: Porpy_policealert
	edit: Panatron
    contact: https://www.facebook.com/panantron.na.nakron
    discord: https://discord.gg/dNvqnXQ
    warning: หากนำไปขายต่อหรือแจกจ่าย จะหยุดการ Support ทันที
]]

Config = {}
Config["base_key"] = 19 				-- ปุ่มหลักในการใช้ร่วมกับปุ่มตัวเลข เช่น ALT + 1
Config["base_key_text"] = "<b>ALT</b>" 	-- ชื่อปุ่มที่แสดงในแจ้งเตือน
Config["duration"] = 12				-- ระยะเวลาที่จะตอบรับ
Config["red_radius"] = 60.0 			-- ขนาดของวงที่จะขึ้นบนแมพ เมื่อมีการแจ้งเตือน
Config["worker_name"] = true			-- แสดงชื่อผู้รับเคส
Config["alert_section"] = {
	carjacking = false,
	melee = false,
	gunshot = false,
}

-- การ Setup โดยการวาง Event ที่ระบบหลัก
-- ถ้าเป็นไฟล์ Client ให้ TriggerEvent("Porpy_policealert:alertNet", "cement") -- เปลี่ยน event ได้
-- ถ้าเป็นไฟล์ Server ให้ TriggerClientEvent("Porpy_policealert:getalertNet", source, "cement") -- เปลี่ยน event ได้
Config["alert_position"] = "bottomRight"
Config["translate"] = {
	title = "",
	male = "<span  style=\"font-size:20px;color:blue;\">ผู้ชาย</span>",
	female = "<span  style=\"font-size:20px;color:red;\">ผู้หญิง</span>",--[[ </b><br> ]]
	text = "<span  style=\"color:white;\"></span> <span style=\"color:green;\"><b>%s</b></span> <span style=\"color:white;\"><br>เพศ <b>%s อยู่ที่ 📌</span> <span style=\"color:orange;\"><b>%s</b></span>",
	tip = "<b> เพื่อไปจุดมาร์ค</b>",
	action_carjacking = "<span style=\"font-size:22px;color:red;\">โจรกรรมรถยนต์</span>",
	action_melee = "<span style=\"font-size:22px;color:red;\">ทำร้ายร่างกายผู้อื่น</span>",
	action_gunshot = "ยิงปืน",
}

Config["alert"] = {
	drug = {
		type = 'drug',																-- Event Name
		action = "ขายยา"			-- ตอนขึ้นแจ้งเตือน
	},
	amp = {
		type = 'amp',																-- Event Name
		action = "เก็บแอมป์"			-- ตอนขึ้นแจ้งเตือน
	},
	cement = {
		type = 'cement',
		action = "ขโมยปูน"
	},
	thief = {
		type = 'thief',
		action = "โจรปล้น"
	},
	store_rob = {
		type = 'store_rob',
		action = "งัดร้านค้า"
	},
	superstore_rob = {
		type = 'superstore_rob',
		action = "งัดคลังสินค้า"
	},
	house_rob = {
		type = 'house_rob',
		action = "งัดบ้าน"
	},
	ping = {
		type = 'ping',
		action = "ช่วยด้วย"
	},
	prisonbreak = {
		type = 'prisonbreak',
		action = "แหกคุก"
	},
	robvehicle = {
		type = "robvehicle",
		action = "งัดรถ"
	},
	dead = {
		type = "dead",
		action = "หมดสติ"
	},
	dead2 = {
		type = "dead2",
		action = "ศพ (ถูกห่อ)"
	},
	bleeding_shroud = {
		type = "bleeding_shroud",
		action = "ศพ (เข้าตู้เอ๋อ)"
	},
	bleeding = {
		type = "bleeding",
		action = "เสียชีวิต"
	},
	gang_dead = {
		type = "gang_dead",
		action = "เพื่อนหมดสติ"
	},
}


function alertActionNotify(title, actionType, value, tip, location,sex,streetName)
	TriggerEvent("cc_alertui:alertDepartment",title ,actionType ,value, tip, location, Config["duration"] * 800, "police", sex, streetName)
end

function workerNameNotification(playerName,tip)		-- ตอนมีตำรวจรับงาน
	TriggerEvent("cc_alertui:confirmDepartment",playerName,tip,"confirm-police",Config["duration"] * 800)
end


