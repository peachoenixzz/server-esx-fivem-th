--===== FiveM Script: ========================================
--= DB - Health and Armor
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

CONFIG.Frameworks = {                                       -- Frameworks (สามารถเพิ่ม Framework ได้)
    {                                                       -- ESX Framework
        Resource = 'es_extended',                           -- ชื่อทรัพยากร
        Directory = 'esx',                                  -- ชื่อไดเรกทอรี (Path: public/framework/esx)
        Dependencies = {                                    -- การพึ่งพาทรัพยากร (ความต้องการ)
            'skinchanger'
        }
    },

    {                                                       -- QBCore Framework
        Resource = 'qb-core',                               -- ชื่อทรัพยากร
        Directory = 'qb',                                   -- ชื่อไดเรกทอรี (Path: public/framework/qb)
        Dependencies = {                                    -- การพึ่งพาทรัพยากร (ความต้องการ)
            'qb-clothing'
        }
    }
}

CONFIG.Debug = {                                            -- แสดง Debug ไปยัง Server Console หรือ Client Console (F8)
    Enable = false                                          -- เปิดใช้งานแสดง Debug (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)
}
