-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

Config = Config or {}

Config.EventRoute = {
    GetSharedObject = 'esx:getSharedObject',       -- ชื่อ Event สำหรับดึง Framework ไปใช้ (ค่าเริ่มต้น esx:getSharedObject)
    PlayerDropped = 'esx:playerDropped',         -- ชื่อ Event เมื่อผู้เล่นออกจากเกม (ค่าเริ่มต้น esx:playerDropped)
    RemoveInventoryItem = 'esx:removeInventoryItem'     -- ชื่อ Event เมื่อผู้เล่นถูกลบไอเทมออกจากตัว (ค่าเริ่มต้น esx:removeInventoryItem)
}

Config.Debug = true     -- โหมดผู้พัฒนา
Config.EnableRemoveWhenTransfer = true      -- เปิดให้ลบ Prop ที่ใส่อยู่ทั้งหมดเมื่อมีการ Give ไอเทมหรือไม่ (หากมีการทิ้งไอเทมก็จะลบออกเช่นกันเนื่องจากดึง Framework ด้านบนมาใช้)

Config.Command = {
    PlayerRemove = {
        enable = true,      -- เปิดใช้งานคำสั่งลบแฟชั่นที่บัคหรือไม่      
        permission = true,     -- เปิดให้ใช้คำสั่งนี้เฉพาะแอดมินหรือไม่
        command = 'delfashion'      -- ชื่อคำสั่ง      
    },
    RemoveAll = {
        enable = true,       -- เปิดใช้งานคำสั่งลบแฟชั่นทั้งเซิร์ฟหรือไม่            
        permission = true,      -- เปิดให้ใช้คำสั่งนี้เฉพาะแอดมินหรือไม่ 
        command = 'delallfashion'       -- ชื่อคำสั่ง      
    },
}

Config.RemovePropDelay = 1       -- เวลาที่จะลบ Prop เมื่อผู้เล่นออกจากเกม (หน่วยเป็นวินาที)