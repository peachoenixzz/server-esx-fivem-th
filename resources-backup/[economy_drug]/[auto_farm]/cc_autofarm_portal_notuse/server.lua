ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('checkPermissionAndPlayer', function(source, cb, distance)
    local xPlayer = ESX.GetPlayerFromId(source)
    if exports.cc_coreeffect:coreEffectCheckTime(xPlayer,'auto_farm') <= 0 then
        expireTimeItem(xPlayer.source)
        cb(false)
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'NoAutoFarmAccess',
                content = ('%s พยายามใช้วาป เพื่อเข้าไป auto farm แต่ไม่ได้กดใช้บัตร auto farm จึงเข้าไม่ได้'):format(xPlayer.name),
                source = xPlayer.source,
            })
        end) -- End log
        return
    end
    local NearbyPlayers = ESX.OneSync.GetPlayersInArea(distance, 300.0)
    --print(#NearbyPlayers)
    if #NearbyPlayers >= 50 then
        maximumPlayer(xPlayer.source)
        cb(false,#NearbyPlayers)
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'AutoFarmFull',
                content = ('%s พยายามใช้วาป เพื่อเข้าไป auto farm แต่ผู้เล่นจำนวน %s คนอยู่ใน auto farm แล้ว'):format(xPlayer.name, #NearbyPlayers),
                source = xPlayer.source,
            })
        end) -- End log
    end
    cb(true)
    pcall(function() -- Start log
        exports['azael_dc-serverlogs']:insertData({
            event = 'EnterAutoFarm',
            content = ('%s ได้ใช้วาป เพื่อเข้าไป auto farm ข้างใน auto farm มีผู้เล่นจำนวน %s คน'):format(xPlayer.name, #NearbyPlayers),
            source = xPlayer.source,
        })
    end) -- End log
end)

ESX.RegisterServerCallback('checkPlayer', function(source, cb, distance)
    local NearbyPlayers = ESX.OneSync.GetPlayersInArea(distance, 300.0)
    cb(#NearbyPlayers)
end)


function maximumPlayer(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบ Auto Farm', -- หัวเรื่อง
        description = 'มีคนในห้องเกินที่กำหนดไว้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_area', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function expireTimeItem(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบ Auto Farm', -- หัวเรื่อง
        description = 'คุณไม่มีไอเทมที่กำหนดไว้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end