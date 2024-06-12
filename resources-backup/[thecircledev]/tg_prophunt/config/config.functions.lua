-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

Config = Config or {}

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อมีแจ้งเตือนส่งมาหาผู้เล่น (ฟังก์ชั่นในฝั่ง Client)
-- text คือข้อความแจ้งเตือน
-- type คือประเภทของแจ้งเตือน มีทั้งหมด 2 ประเภท (error = ล้มเหลว / success สำเร็จ)
Config.ClientNotification = function(text, type)
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบซ่อนหา', -- หัวเรื่อง
        description = text, -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'detail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อมีแจ้งเตือนส่งมาหาผู้เล่น (ฟังก์ชั่นในฝั่ง Server)
-- source คือไอดีผู้เล่น
-- text คือข้อความแจ้งเตือน
-- type คือประเภทของแจ้งเตือน มีทั้งหมด 2 ประเภท (error = ล้มเหลว / success สำเร็จ)
Config.ServerNotification = function(source, text, type)
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบซ่อนหา', -- หัวเรื่อง
        description = text, -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_cop', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อผู้เล่นที่มี Permission ใช้คำสั่งเริ่มกิจกรรม (ฟังก์ชั่นในฝั่ง Server)
-- xPlayer คือข้อมูลผู้เล่นทั้งหมด
-- eventArgs คือไอดีของกิจกรรมที่ผู้เล่นพิมพ์คำสั่ง
Config.StartEventByCommand = function(xPlayer, eventArgs)

end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อกิจกรรมเริ่มอัตโนมัติตามเวลาที่ตั้งไว้ (ฟังก์ชั่นในฝั่ง Server)
-- hour คือชั่วโมงของกิจกรรมที่เริ่ม / minute คือนาทีของกิจกรรมที่เริ่ม / eventArgs คือไอดีของกิจกรรมที่เริ่ม
Config.StartEventByAutoTime = function(hour, minute, eventArgs)
    
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อทีมของผู้เล่นเป็นฝ่ายชนะและได้รับรางวัล (ฟังก์ชั่นในฝั่ง Server)
-- xPlayer คือข้อมูลผู้เล่นทั้งหมด / team คือทีมของผู้เล่นที่ได้รับรางวัล
-- type คือเป็นประเภทของของรางวัล (item = ไอเทม / money = เงินสด / black_money = เงินแดง)
-- name คือเป็นชื่อไอเทมหรือชื่อของเงินที่ได้รับ / count คือจำนวนไอเทมหรือจำนวนเงินที่ได้รับ
Config.GetReward = function(xPlayer, team, type, name, count)

end