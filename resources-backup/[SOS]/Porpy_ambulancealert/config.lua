--[[
	resource: Porpy_ambulancealert
	edit: Panatron
    contact: https://www.facebook.com/panantron.na.nakron
    discord: https://discord.gg/dNvqnXQ
    warning: หากนำไปขายต่อหรือแจกจ่าย จะหยุดการ Support ทันที
]]
Config = {}
Config["base_key"] = 19
Config["base_key_text"] = "<b>ALT</b>" -- ชื่อปุ่มที่แสดงในแจ้งเตือน
Config["duration"] = 12
Config["worker_name"] = true			-- แสดงชื่อผู้รับเคส
Config["red_radius"] = 60.0 

Config["alert_section"] = {
	dead = true,
	dead2 = true,
	ping = true,
}

-- การ Setup โดยการวาง Event ที่ระบบหลัก
-- ถ้าเป็นไฟล์ Client ให้ TriggerEvent("Porpy_ambulancealert:alertNet", "dead") -- เปลี่ยน event ได้
-- ถ้าเป็นไฟล์ Server ให้ TriggerClientEvent("Porpy_ambulancealert:getalertNet", source, "dead") -- เปลี่ยน event ได้

Config["alert_position"] = "topRight" 

Config["translate"] = {
	title = "",
	male = "<span  style=\"color:red;\">ชาย</span>",
	female = "<span  style=\"color:red;\">หญิง</span>",
	text = "<span  style=\"color:white;\"></span> <span style=\"color:green;\"><b>%s</b></span> <span style=\"color:white;\"><br>เพศ <b>%s อยู่ที่ 📌 </span> <span style=\"color:orange;\"><b>%s</b></span>",
	tip = "<b> เพื่อรับงานนี้</b>",
	action_dead = "มีคนกำลังสลบ",
	action_dead2 = "มีคนถูกห่อศพ",
	ping = "ช่วยด้วย",
}


function alertActionNotify(title, actionType, value, tip, location,sex,streetName)
	TriggerEvent("cc_alertui:alertDepartment",title ,actionType ,value, tip, location, Config["duration"] * 800, "ambulance", sex, streetName)
end

function workerNameNotification(playerName,tip)
	TriggerEvent("cc_alertui:confirmDepartment",playerName,tip,"confirm-ambulance",Config["duration"] * 800)
end
