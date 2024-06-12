-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

Config = Config or {} 

Config.DiscordLogs = {
    EventStart = {
        enable = true,      -- เปิดใช้งาน Discord Log เริ่มกิจกรรมหรือไม่
        webhook = 'WEBHOOK_HERE'        -- ลิงก์ Webhook Discord
    },
    HunterReward = {
        enable = true,      -- เปิดใช้งาน Discord Log รางวัลของ Hunter หรือไม่   
        webhook = 'WEBHOOK_HERE'        -- ลิงก์ Webhook Discord
    },
    PropReward = {
        enable = true,      -- เปิดใช้งาน Discord Log รางวัลของ Prop หรือไม่    
        webhook = 'WEBHOOK_HERE'        -- ลิงก์ Webhook Discord
    },
}