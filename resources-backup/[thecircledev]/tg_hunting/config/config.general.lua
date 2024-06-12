-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

Config = Config or {}

Config.EventRoute = {
    GetSharedObject = 'esx:getSharedObject',       -- ชื่อ Event สำหรับดึง Framework ไปใช้ (ค่าเริ่มต้น esx:getSharedObject)
    OnPlayerDeath = 'esx:onPlayerDeath'         -- ชื่อ Event เมื่อตัวละครตาย (ค่าเริ่มต้น esx:onPlayerDeath)
}

Config.Debug = false     -- โหมดผู้พัฒนา
Config.ActionKey = 38     -- ปุ่มที่ใช้สำหรับเก็บสัตว์ที่ตาย (ใช้งานเมื่อ EnableActionKey = false)

Config.CheckInventoryItem = true        -- เปิดใช้งานระบบเช็คไอเทมในกระเป๋า (ถ้าปิดจะไม่มีการเช็คทั้ง canCarryItem และ limit)
Config.UseCanCarryItem = true       -- เปิดใช้ CanCarryItem เป็นตัวเช็ค (สำหรับ es_extended 1.2)

Config.ProgressBar = {
    ProgressEvent = 'mythic_progbar:client:progress',

    Addition = {
        can_cancel = true,       -- เปิดให้สามารถยกเลิกหลอดโหลดได้เมื่อหลอดโหลดทำงานหรือไม่
        disable_movement = true,     -- เปิดให้บล็อกการเคลื่อนไหวทั้งหมดเมื่อหลอดโหลดทำงานหรือไม่
        disable_car_movement = true,      -- เปิดให้บล็อกการเคลื่อนไหวบนยานพาหนะทั้งหมดเมื่อหลอดโหลดทำงานหรือไม่
        disable_mouse = false,        -- เปิดให้บล็อกการเคลื่อนไหวด้วยเมาส์เมื่อหลอดโหลดทำงานหรือไม่
        disable_combat = true,       -- เปิดให้บล็อกการโจมตีทั้งหมดเมื่อหลอดโหลดทำงานหรือไม่
    }
}