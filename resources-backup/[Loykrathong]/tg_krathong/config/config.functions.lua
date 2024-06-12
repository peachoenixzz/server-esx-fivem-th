-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

Config = Config or {}

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อมีการแจ้งเตือน (ฟังก์ชั่นในฝั่ง Client)
-- type คือประเภทของแจ้งเตือน มีทั้งหมด 2 ประเภท (error = ล้มเหลว / success สำเร็จ)
-- text คือข้อความแจ้งเตือน
Config.ClientNotification = function(type, text)
    -- TriggerEvent("pNotify:SendNotification", {
    --     text = text,
    --     type = type,
    --     timeout = 3000,
    --     layout = "bottomCenter",
    --     queue = "global"
    -- })
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อแจ้งเตือนผู้เล่นอธิษฐานทั้งเซิร์ฟเวอร์ (ฟังก์ชั่นในฝั่ง Server)
-- playerName คือชื่อของผู้เล่น
-- text คือข้อความที่ผู้เล่นอธิษฐาน
Config.ServerNotification = function(playerName, text)
    TriggerClientEvent('chat:addMessage', -1, {
        -- template = '<div style="width: fit-content; padding: 0.5vw; margin: 0.2vw; background-color: rgba(47, 47, 47, 0.85); border-radius: 3px; border-radius: 12px;"><span style="color: #4071BC; font-size: 17px; font-weight: bold;">{0}</span><br><span style="font-size: 15px;">ได้อธิษฐานว่า {1}</span></div>',
        template = '<div style="padding: 7px; margin-bottom: 8px; background-image: linear-gradient(to right, rgba(255, 223, 0, 0.7), rgba(255, 223, 0, 0.5)); border-radius: 7px; width: 605px; display: flex; align-items: center; font-size: 18px;"/>{0} ได้อธิษฐานว่า : {1}<br></div>',
        args = { playerName, text }
    })
end