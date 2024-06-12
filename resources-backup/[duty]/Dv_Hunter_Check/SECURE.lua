--[[
	resource: 	Dv_Hunter_Check
	edit by :	Devil Hunter developers
    discord	:	https://discord.gg/XthjKBBvwm
	fackbook:	https://www.facebook.com/Boss-Studio-101699331554365
	เว็บไซต์		: 	http://boss-studio.net/
    warning: หากนำไปขายต่อหรือแจกจ่าย จะหยุดการ Support ทันที
]]
-- 'ES Dv_Hunter_Check Modify By Devil Hunter developers'

TOKEN = { 

	SESSION = "HT_zvWD2g2iCsvX" , 	-- ติดต่อกขอ รับ KEY สำหรับรับเซิฟ ที่ซื้อกับทาง เรา ได้ที่  https://discord.gg/XthjKBBvwm

    DEBUG_MODE = true  ,            --> @ เปิดเมื่อต้องการเช็คค่าตัวแปรต่างๆหากสมบูรณ์แล้วให้ปรับเป็น false
	
    FRAMEWORK = {                   --> @ เปิด true Framework ที่ตัวเองใช้อยู่
        [true] = "esx",
        [false] = "monster",
    }, 

    DC_HOOK = {                     --> @ แจ้งเตือน Logs ขายของ
        API = ""
    }
}





