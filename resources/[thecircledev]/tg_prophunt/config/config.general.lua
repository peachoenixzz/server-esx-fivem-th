-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

Config = Config or {}

Config.EventRoute = {
    GetSharedObject = 'esx:getSharedObject',       -- ชื่อ Event สำหรับดึง Framework ไปใช้ (ค่าเริ่มต้น esx:getSharedObject)
    OnPlayerDeath = 'esx:onPlayerDeath',         -- ชื่อ Event เมื่อตัวละครตาย (ค่าเริ่มต้น esx:onPlayerDeath)
    PlayerDropped = 'esx:playerDropped',         -- ชื่อ Event เมื่อผู้เล่นออกจากเกม (ค่าเริ่มต้น esx:playerDropped)
    Revive = 'esx_ambulancejob:reviveAdmin',         -- ชื่อ Event สำหรับชุบชีวิตผู้เล่นทั้งหมด (ค่าเริ่มต้น esx_ambulancejob:revive)
    Heal = 'esx_ambulancejob:healPlayerEvent'      -- ชื่อ Event สำหรับเพิ่มเลือดผู้เล่นทั้งหมด (ค่าเริ่มต้น esx_basicneeds:healPlayer)
}

Config.Debug = true     -- เปิดใช้โหมดผู้พัฒนาหรือไม่
Config.HealWait = 2     -- คูลดาวน์ในการฮีลหลังเริ่มรอบนั้นๆ (หน่วยเป็นวินาที)

Config.Key = {
    JoinEvent = 244,     -- ปุ่มเข้าร่วมกิจกรรม (เปลี่ยนปุ่มบน UI ในไฟล์ index.html)

    Prop = {
        transform = 38,     -- ปุ่มแปลงร่าง
        cancel_transform = 73,      -- ปุ่มยกเลิกแปลงร่าง
        freeze = 20,        -- ปุ่มล็อคขา / ปลดล็อคขา
    },

    Spectator = {
        forward = 175,      -- ปุ่มสลับกล้อง (ถัดไป)
        backward = 174      -- ปุ่มสลับกล้อง (ย้อนกลับ)
    }
}