-- ██████╗  █████╗ ██████╗ ██████╗ ██╗████████╗    ██████╗ ███████╗██╗   ██╗
-- ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║╚══██╔══╝    ██╔══██╗██╔════╝██║   ██║
-- ██████╔╝███████║██████╔╝██████╔╝██║   ██║       ██║  ██║█████╗  ██║   ██║
-- ██╔══██╗██╔══██║██╔══██╗██╔══██╗██║   ██║       ██║  ██║██╔══╝  ╚██╗ ██╔╝
-- ██║  ██║██║  ██║██████╔╝██████╔╝██║   ██║       ██████╔╝███████╗ ╚████╔╝ 
-- ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝   ╚═╝       ╚═════╝ ╚══════╝  ╚═══╝  
-- https://discord.gg/GfvECJ4Z8q

Config = {}
-- เปิดโหมดพัฒนา
Config["Debug"] = false

Config["KeyMappingEnabled"] = true      -- คุณสามารถเปิด/ปิดการใช้งานเมนู (F3) ที่นี่ : ค่าเดิมคือ true

Config["ShowPlayerName"] = false        -- แสดงชื่อตอน Share Emotes : ค่าเดิมคือ false

-- ใช้ Hotkey
Config["HotkeyEnabled"] = true
Config["HotkeyDetectCombat"] = true     -- ไม่สามารถกดปุ่ม Hotkey หากอยู่ในสถานะต่อสู้ : ค่าเดิมคือ true

-- Hotkey Effect
Config["HotkeyEffect"] = {
    enabled = false,                    -- แสดง Effect เมื่อกดปุ่ม Hotkey : ค่าเดิมคือ false
    fxdict = "proj_indep_firework",
    fxname = 'scr_indep_launcher_sparkle_spawn',
    fxsize = 0.1
}

Config["HotkeyCooldownTime"] = 0     -- ติดคูลดาวน์ตอนกดปุ่ม Hotkey : ค่าเดิมคือ 3000 = 3 วินาที หากไม่ต้องการ = 0

-- เปลี่ยนปุ่มลัด
-- กรุณาทำความเข้าใจเรื่องการใช้งาน RegisterKeyMapping
Config["KeyMapping"] = "F3"

Config["Colors"] = {
    ['textPrimary'] = "#DDDDDD",        -- สีข้อความหลัก
    ['textSecound'] = "#DDDDDD",        -- สีข้อความในรายชื่อ emotes
    ['~r~'] = "rgb(255, 0, 0)",         -- Red
    ['~b~'] = "#0099ff",                -- Blue
    ['~g~'] = "#00ff00",                -- Green
    ['~y~'] = "#ffff00",                -- Yellow
    ['~p~'] = "#9933ff",                -- Purple
    ['~c~'] = "#A3A3A3",                -- Grey
    ['~m~'] = "#A3A3A3",                -- Dark Grey
    ['~u~'] = "#000000",                -- Black
    ['~o~'] = "#FF8300",                -- Orange
}

-- จุดที่ไม่สามารถเปิดหน้า Emotes UI ได้
Config["LocationDisabled"] = {
    Enabled = false, -- true เปิด / false ปิด
    locations = {
        { coords = vector3(-338.0, -920.4, 31.5), radius = 30.0 },
        -- { coords = vector3(-338.0, -920.4, 31.5), radius = 30.0 },
    }
}