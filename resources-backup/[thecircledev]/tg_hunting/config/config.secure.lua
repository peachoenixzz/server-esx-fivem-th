-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

Config = Config or {} 

Config.DiscordLogs = {
    EquipmentRental = {
        enable = true,      -- เปิดใช้งาน Discord Log เช่าอุปกรณ์หรือไม่  
        webhook = 'WEBHOOK_HERE'        -- ลิงก์ Webhook Discord
    },
    CarRental = {
        enable = true,      -- เปิดใช้งาน Discord Log เช่ารถหรือไม่   
        webhook = 'WEBHOOK_HERE'        -- ลิงก์ Webhook Discord
    },
    Reward = {
        enable = true,      -- เปิดใช้งาน Discord Log ไอเทมที่ได้รับเมื่อเก็บของจากสัตว์หรือไม่    
        webhook = 'WEBHOOK_HERE'        -- ลิงก์ Webhook Discord
    },
    RemoveWeapon = {
        enable = true,      -- เปิดใช้งาน Discord Log อาวุธที่ลบเมื่อออกจากเกาะหรือไม่     
        webhook = 'WEBHOOK_HERE'        -- ลิงก์ Webhook Discord
    }
}