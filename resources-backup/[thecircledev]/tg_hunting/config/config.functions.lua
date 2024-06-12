-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

Config = Config or {}

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อมีการแจ้งเตือน (ฟังก์ชั่นในฝั่ง Client)
-- text คือข้อความแจ้งเตือน
-- type คือประเภทของแจ้งเตือน มีทั้งหมด 2 ประเภท (error = ล้มเหลว / success สำเร็จ)
Config.ClientNotification = function(text, type)
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบล่าสัตว์นะ', -- หัวเรื่อง
        description = text, -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'detail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 4000 -- ระยะเวลาการแสดง Notify
    })
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อมีการแจ้งเตือน (ฟังก์ชั่นในฝั่ง Server)
-- source คือ เลข ID ของผู้เล่น
-- text ข้อความแจ้งเตือน
-- type คือประเภทของแจ้งเตือน มีทั้งหมด 2 ประเภท (error = ล้มเหลว / success สำเร็จ)
Config.ServerNotification = function(source, text, type)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบล่าสัตว์นะ', -- หัวเรื่อง
        description = text, -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'detail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 4000 -- ระยะเวลาการแสดง Notify
    })
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อผู้เล่นอยู่ในระยะกดการปุ่ม (ฟังก์ชั่นในฝั่ง Client)
-- text คือข้อความแจ้งเตือน
Config.ShowHelpNotification = function(text)
    if text == 'pickup_animal' then
        exports.helpnotify:showHelpNotification("กด", "E", "เพื่อแร่หนังสัตว์")
    end
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อผู้เล่นเก็บของจากสัตว์เสร็จ (ฟังก์ชั่นในฝั่ง Client)
Config.ClientAfterLooting = function()
    exports.helpnotify:hideHelpNotification()
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อผู้เล่นเก็บของจากสัตว์เสร็จ (ฟังก์ชั่นในฝั่ง Server)
-- xPlayer คือข้อมูลผู้เล่นทั้งหมด
-- itemName คือชื่อไอเทมที่เก็บจากสัตว์ / itemCount คือจำนวนไอเทมที่เก็บจากสัตว์
-- bonusName คือชื่อไอเทมโบนัสที่เก็บจากสัตว์ / bonusCount คือจำนวนไอเทมโบนัสที่เก็บจากสัตว์
Config.ServerAfterLooting = function(xPlayer, itemName, itemCount, bonusName, bonusCount)
    
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อผู้เล่นเช่าอุปกรณ์ (ฟังก์ชั่นในฝั่ง Server)
-- xPlayer คือข้อมูลผู้เล่นทั้งหมด
-- equipmentName คือชื่ออุปกรณ์ที่กดซื้อ / equipmentCount คือจำนวนอุปกรณ์ที่กดซื้อ
Config.AfterRentEquipment = function(xPlayer, equipmentName, equipmentCount)

end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อผู้เล่นเช่ารถ (ฟังก์ชั่นในฝั่ง Server)
-- xPlayer คือข้อมูลผู้เล่นทั้งหมด
-- vehicleName คือชื่อยานพาหนะที่เช่า / rentalPrice คือราคาของยานพาหนะที่เช่า
Config.AfterRentVehicle = function(xPlayer, vehicleName, rentalPrice)
 
end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อผู้เล่นคืนรถ (ฟังก์ชั่นในฝั่ง Server)
-- xPlayer คือข้อมูลผู้เล่นทั้งหมด
-- vehicleName คือชื่อยานพาหนะที่คืน / refundPrice คือเงินที่ได้รับของยานพาหนะที่คืน
Config.AfterRefundVehicle = function(xPlayer, vehicleName, refundPrice)

end

-- Function นี้จะถูกเรียกใช้งานก็ต่อเมื่อลบอาวุธผู้เล่นเมื่อออกจากเกาะ (ฟังก์ชั่นในฝั่ง Server)
-- xPlayer คือข้อมูลผู้เล่นทั้งหมด
-- weaponName คือชื่ออาวุธที่ลบเมื่อออกจากโซน
Config.RemoveWeaponWhenLeavingZone = function(xPlayer, weaponName)

end