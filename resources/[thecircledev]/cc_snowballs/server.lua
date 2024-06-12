

ESX.RegisterServerCallback('cc_snowballs:pickup', function(source, cb )
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if xPlayer.hasWeapon("WEAPON_SNOWBALL") then
            local _, weapon = xPlayer.getWeapon("WEAPON_REVOLVER")
            xPlayer.addWeaponAmmo("WEAPON_SNOWBALL", 10)
            exports.nc_notify:PushNotification(xPlayer.source,{
                scale = 1.0,  -- ปรับขนาดของ Notify
                title = 'ระบบเก็บหิมะ',  -- หัวเรื่อง
                description = ('เก็บ หิมะทั้งหมด 10 ลูก'):format(),  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                type = 'success',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                direction = 'right',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                priority = 'medium',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                icon = 'inventory_max',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                duration = 1000  -- ระยะเวลาการแสดง Notify
            })
            cb(true)
            return
        else
            xPlayer.addWeapon("WEAPON_SNOWBALL", 10)
            cb(true)
            return
        end
    end
    cb(false)
end)



ESX.RegisterUsableItem('snow_gloves', function(source)
    TriggerClientEvent('cc_snowballs:checkPlayerState', source)
end)