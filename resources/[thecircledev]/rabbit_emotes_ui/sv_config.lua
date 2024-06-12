-- ██████╗  █████╗ ██████╗ ██████╗ ██╗████████╗    ██████╗ ███████╗██╗   ██╗
-- ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║╚══██╔══╝    ██╔══██╗██╔════╝██║   ██║
-- ██████╔╝███████║██████╔╝██████╔╝██║   ██║       ██║  ██║█████╗  ██║   ██║
-- ██╔══██╗██╔══██║██╔══██╗██╔══██╗██║   ██║       ██║  ██║██╔══╝  ╚██╗ ██╔╝
-- ██║  ██║██║  ██║██████╔╝██████╔╝██║   ██║       ██████╔╝███████╗ ╚████╔╝ 
-- ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝   ╚═╝       ╚═════╝ ╚══════╝  ╚═══╝  
-- https://discord.gg/GfvECJ4Z8q

DC = {}
DC.DiscordLog = {
    Enable = true, -- ใช้งาน Webhook ของเราเอง
    WebhookURL = "", -- ใส่ URL Webhook
    Color = 7877370, -- -- Color Send to Discord / สีที่ส่งไปใน Log หาสีได้จาก https://convertingcolors.com/ryb-color-120_50_250.html?search=RYB(120,%2050,%20250)  [ หาตัวเลข Decimal มาใส่ ]
}

DC.CustomDiscordLog = function(source, message)
    -- สามารถ ใส่ Log เองได้เลย เช่นของ Azael
    local sendToDiscord = message
    TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'WebhookURL', sendToDiscord, source, '^3')
end
