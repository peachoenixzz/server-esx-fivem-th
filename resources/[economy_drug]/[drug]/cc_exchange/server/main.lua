TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('cc_exchange:blackmoneyexchange')
AddEventHandler('cc_exchange:blackmoneyexchange', function(quantity)
    if quantity >= 100 then
        local source = source
        local xPlayer =  ESX.GetPlayerFromId(source)
        local currentAccount = xPlayer.getAccount("black_money")
        if currentAccount.money >= quantity then  
            xPlayer.removeAccountMoney("black_money", quantity)   
            xPlayer.addAccountMoney("money", quantity)
        else
            exports.nc_notify:PushNotification(source,{
            scale = 1.0, -- ปรับขนาดของ Notify
                title = 'ระบบแลกเงินผิดกฎหมาย', -- หัวเรื่อง
                description = 'คุณมีเงินผิดกฎหมายไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                type = 'warning',
                position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                icon = 'no_money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                duration = 3000 -- ระยะเวลาการแสดง Notify
                })
        end  
    end
end)



