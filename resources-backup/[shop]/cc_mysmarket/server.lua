ESX.RegisterServerCallback('checkCardMysMarket', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItemTicket = xPlayer.getInventoryItem("ticket_bmarket")
    if xItemTicket.count >= 1 then
        xPlayer.removeInventoryItem("ticket_bmarket", 1)
        cb(true)
        return
    end
    onNoItemtoUse(xPlayer.source)
    cb(false)
end)

function onNoItemtoUse(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'พ่อค้าลึกลับ', -- หัวเรื่อง
        description = 'คุณไม่มีไอเทมที่กำหนด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end


AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        collectgarbage("collect")
    end
end)