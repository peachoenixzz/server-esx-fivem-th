
-- Giant Dev 
-- https://discord.gg/AgutpzcVzv
-- Custom ui for your Server 

function checkitemskins(name)
    pcall(function()
    exports.pNotify:SendNotification({text = "ต้องการไอเทม "..name, timeout = 5000})
    end)
end

function alertAccessoryblank()
    pcall(function()
    exports.pNotify:SendNotification({text = "กรุณาใส่ชื่อเสื้อผ้า", timeout = 5000})
    end)
end

function alertAccessoryShort()
    pcall(function()
        exports.pNotify:SendNotification({text = "ชื่อสั้นเกินไป", timeout = 5000})
    end)
end

function alertAccessoryLong()
    pcall(function()
    exports.pNotify:SendNotification({text = "ชื่อยาวเกินไป", timeout = 5000})
    end)
end

function thiefblockalert(time)
    pcall(function()
        local min,sec = secondsToClock(time)
        print(json.encode("ติด cd ปล้นอยู่เหลือเวลาอีก "..min..":"..sec.." นาที"))
        -- exports.pNotify:SendNotification({text = "ติด cd ปล้นอยู่เหลือเวลาอีก "..min..":"..sec.." นาที", timeout = 5000})
        -- exports['okokTextUI']:Open("ติด cd ปล้นอยู่เหลือเวลาอีก "..min..":"..sec.." นาที", 'dark', 'center') 
        -- exports['okokNotify']:Alert(, 5000, 'warning')
        end)
end


function PaybutMoneyNotEnough(price, myMoney)
    pcall(function()
        local needmoney = price - myMoney
       onNoMoneyToBuyCloth()
    end)
end

function DoneUpdateSkin()
    pcall(function()
        exports.pNotify:SendNotification({text = "อัพเดทสกิลเรียบร้อยแล้ว", timeout = 5000})
    end)
end

function FullSlotCloth()
    pcall(function()
        TriggerEvent("pNotify:SendNotification", {
            text = '<strong class="green-text">ชุดเต็ม slot ไม่สามารถเพิ่มได้ กรุณาเพิ่ม slot </strong>',
            type = "error",
            timeout = 3000,
            layout = "bottomCenter",
            queue = "global"
        })
    end)

end


function NotEnoughMoneySavaCloth()
    pcall(function()
    TriggerEvent("pNotify:SendNotification", {
        text = '<strong class="red-text">เงินในกระเป๋าไม่เพียงพอต้องใช้  </strong>' ..addCommas(Config.wardrobePrice)..' บาท',
        type = "error",
        timeout = 3000,
        layout = "bottomCenter",
        queue = "global"
    })
    end)
end


function DoneLoadCloth()
    pcall(function()
        exports.pNotify:SendNotification({text = "<strong >โหลดชุดสำเร็จ </strong>", timeout = 5000})
    end)
end


function DoneSaveCloth()
    pcall(function()
        exports.pNotify:SendNotification({text = "<strong >บันทึกชุดเรียบร้อยแล้ว </strong>", timeout = 5000})
    end)
    TriggerServerEvent('Giant_skinui:saveCloth')
end


function NotEnoughMoneyAddSlot()
    pcall(function()
        TriggerEvent("pNotify:SendNotification", {
            text = '<strong class="red-text">เงินในกระเป๋าไม่เพียงพอต้องใช้  </strong>'..addCommas(Config.wardrobeslot),
            type = "error",
            timeout = 3000,
            layout = "bottomCenter",
            queue = "global"
        })
    end)
end


function onNoMoneyToBuyCloth()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบแต่งตัว', -- หัวเรื่อง
        description = 'คุณมีเงินไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end