-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

Config = Config or {}

Config.EventRoute = {
    GetSharedObject = 'esx:getSharedObject',       -- ชื่อ Event สำหรับดึง Framework ไปใช้ (ค่าเริ่มต้น esx:getSharedObject)
    OnPlayerDeath = 'esx:onPlayerDeath',         -- ชื่อ Event เมื่อตัวละครตาย (ค่าเริ่มต้น esx:onPlayerDeath)
    OnPlayerSpawn = 'playerSpawned',        -- ชื่อ Event เมื่อตัวละครเกิดใหม่ (ค่าเริ่มต้น esx:onPlayerSpawn)
    Revive = 'esx_ambulancejob:revive',         -- ชื่อ Event สำหรับชุบชีวิตผู้เล่นทั้งหมด (ค่าเริ่มต้น esx_ambulancejob:revive)
    Heal = 'esx_basicneeds:healPlayer'      -- ชื่อ Event สำหรับเพิ่มเลือดผู้เล่นทั้งหมด (ค่าเริ่มต้น esx_basicneeds:healPlayer)
}

Config.Debug = true		-- โหมดผู้พัฒนา

Config.CheckInventoryItem = false        -- เปิดใช้งานระบบเช็คไอเทมในกระเป๋า (ถ้าปิดจะไม่มีการเช็คทั้ง canCarryItem และ limit)   
Config.UseCanCarryItem = true       -- เปิดใช้ CanCarryItem เป็นตัวเช็ค (สำหรับ es_extended 1.2)   

Config.ProgressBar = {
    ProgressEvent = "mythic_progbar:client:progress",      -- ชื่อ Event ตอนหลอดโหลดทำงาน
    CancelEvent = "mythic_progbar:client:cancel",      -- ชื่อ Event ตอนหลอดโหลดยกเลิก
    Label = "กำลังเปิดแอร์ดรอป",      -- ข้อความที่จะแสดงบนหลอดโหลดเมื่อเก็บแอร์ดรอป

    Addition = {
        can_cancel = true,       -- เปิดให้สามารถยกเลิกหลอดโหลดได้เมื่อหลอดโหลดทำงานหรือไม่
        disable_movement = true,     -- เปิดให้บล็อกการเคลื่อนไหวทั้งหมดเมื่อหลอดโหลดทำงานหรือไม่
        disable_car_movement = true,      -- เปิดให้บล็อกการเคลื่อนไหวบนยานพาหนะทั้งหมดเมื่อหลอดโหลดทำงานหรือไม่
        disable_mouse = false,        -- เปิดให้บล็อกการเคลื่อนไหวด้วยเมาส์เมื่อหลอดโหลดทำงานหรือไม่
        disable_combat = true,       -- เปิดให้บล็อกการโจมตีทั้งหมดเมื่อหลอดโหลดทำงานหรือไม่
    }
}