-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

Config = Config or {}

Config.EventRoute = {
    GetSharedObject = 'esx:getSharedObject',       -- ชื่อ Event สำหรับดึง Framework ไปใช้ (ค่าเริ่มต้น esx:getSharedObject)
    GetPlayerSkin = 'esx_skin:getPlayerSkin',       -- ชื่อ Event สำหรับดึง Skin ผู้เล่น (ค่าเริ่มต้น esx_skin:getPlayerSkin)
    LoadSkin = 'skinchanger:loadSkin'       -- ชื่อ Event สำหรับโหลด Skin ผู้เล่น (ค่าเริ่มต้น skinchanger:loadSkin)
}

Config.Key = {
    ChangeMode = "G",        -- ปุ่มเปลี่ยน Mode ปืนฉีดน้ำ
    RefillWater = "E"        -- ปุ่มเติมน้ำ
}

Config.ParticleSync = true        -- เปิดเพื่อใช้งาน Particle Sync หรือไม่ (เปิดใช้งาน = ทุกคนจะเห็นน้ำที่ออกมาจากปืนฉีดน้ำเหมือนกันแต่จะทำให้เซิร์ฟเวอร์ทำงานหนัก / ปิดใช้งาน = จะเห็นน้ำเฉพาะปืนฉีดน้ำของตัวเองและไม่ทำให้เซิร์ฟเวอร์ทำงานหนัก)