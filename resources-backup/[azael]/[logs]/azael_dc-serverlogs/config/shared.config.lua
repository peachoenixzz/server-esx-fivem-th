--===== FiveM Script: ========================================
--= DC - Server Logs (Webhook)
--===== Developed By: ========================================
--= Azael Dev <contact@azael.dev>
--===== Website: =============================================
--= https://www.azael.dev/
--===== License: =============================================
--= You are not allowed to sell this script or edit
--============================================================

CONFIG = {}

CONFIG.Resource = {                                         -- ทรัพยากร
    Name = GetCurrentResourceName()                         -- ชื่อทรัพยากร (ลงทะเบียน Events ภายใน)
}

CONFIG.Framework = {                                        -- ESX Framework
    Resource = {                                            -- ทรัพยากร
        Name = 'es_extended'                                -- ชื่อทรัพยากร (ค่าเริ่มต้น es_extended)
    }
}

if IsDuplicityVersion() then                                -- Server
    CONFIG.Wrapper = {                                      -- Wrapper (รองรับรหัสการส่งข้อมูลเวอร์ชันที่ล้าสมัยในรูปแบบ Trigger Events)
        Events = {                                          -- Events (รายชื่อเหตุการณ์ทั้งหมด)
            'azael_discordlogs:sendToDiscord',
            'azael_dc-serverlogs:sendToDiscord',
            'azael_dc-serverlogs:insertData'
        }
    }
end

CONFIG.Debug = {                                            -- แสดง Debug ไปยัง Server Console หรือ Client Console (F8)
    Enable = false                                          -- เปิดใช้งานแสดง Debug (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)
}
