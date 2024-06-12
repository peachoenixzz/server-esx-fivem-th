

Config = {}
Config.delItems = {
    medkit = {
        name = "medkit",
        type = "normal"
    },
    gov_toolkit = {
        name = "gov_toolkit",
        type = "normal"
    },
    gov_aed = {
        name = "gov_aed",
        type = "normal"
    },
    gov_radio = {
        name =  "gov_radio",
        type = "normal"
    },
    gov_scuba = {
        name = "gov_scuba",
        type = "normal"
    },
    gov_vest = {
        name = "gov_vest",
        type = "normal"
    },
    gov_tablet = {
        name = "gov_tablet",
        type = "normal"
    },
    gov_help = {
        name = "gov_help",
        type = "normal"
    },
    weapon_stungun = {
        name = "WEAPON_STUNGUN",
        type = "weapon"
    },
    weapon_pumpshotgun = {
        name = "WEAPON_PUMPSHOTGUN",
        type = "weapon"
    },
    weapon_nightstick = {
        name = "WEAPON_NIGHTSTICK",
        type = "weapon"
    },
    weapon_bottle_sos = {
        name = "WEAPON_BOTTLE_SOS",
        type = "weapon"
    },
}

function delItem(xPlayer)
    for _,v in pairs(Config.delItems) do
        if v.type == "weapon" then
            local _, weapon = xPlayer.getWeapon(v.name)
            if weapon then
                xPlayer.removeWeapon(v.name)
                goto continue
            end
        end
        if v.type == "normal" then
            local item = xPlayer.getInventoryItem(v.name)
            if item.count > 0 then
                xPlayer.removeInventoryItem(item.name, item.count)
                goto continue
            end
        end
        ::continue::
    end
end

RegisterServerEvent('duty:onoff')
AddEventHandler('duty:onoff', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    
    if job == 'police' or job == 'ambulance' then
        xPlayer.setJob('off' ..job, grade)
        delItem(xPlayer)
        onDutyOff(source)
    elseif job == 'offpolice' then
        xPlayer.setJob('police', grade)
        onDutyOnPolice(source)
    elseif job == 'offambulance' then
        xPlayer.setJob('ambulance', grade)
        onDutyOnAmbulance(source)
    end

    sendToAzaelLogs(xPlayer)
end)

function sendToAzaelLogs(xPlayer)
    if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' then
        local sendToDiscord = '' .. xPlayer.name .. ' หน่วยงาน ' .. xPlayer.job.name .. ' ออกเวร'
    
        if xPlayer.job.name == 'police' then
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'JobDutyPolice', sendToDiscord, xPlayer.source, '^3')
        elseif xPlayer.job.name == 'ambulance' then
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'JobDutyAmbulance', sendToDiscord, xPlayer.source, '^3')
        end

    elseif xPlayer.job.name == 'offpolice' or xPlayer.job.name == 'offambulance' then
        local sendToDiscord = '' .. xPlayer.name .. ' หน่วยงาน ' .. string.gsub(xPlayer.job.name, 'off', '') .. ' เข้าเวร'
    
        if xPlayer.job.name == 'offpolice' then
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'JobDutyPolice', sendToDiscord, xPlayer.source, '^2')
        elseif xPlayer.job.name == 'offambulance' then
            TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'JobDutyAmbulance', sendToDiscord, xPlayer.source, '^2')
        end
    end
end


function onDutyOff(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบอาชีพ', -- หัวเรื่อง
        description = 'คุณได้ทำการออกเวรแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'off_duty', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end


function onDutyOnPolice(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบอาชีพ', -- หัวเรื่อง
        description = 'คุณได้ทำการเข้าเวรแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success',
        --color  = 'rgba(0, 204, 204)',  -- สีของพื้นหลัง
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'on_duty_pd', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function onDutyOnAmbulance(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบอาชีพ', -- หัวเรื่อง
        description = 'คุณได้ทำการเข้าเวรแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success',
        --color  = 'rgba(0, 204, 204)',  -- สีของพื้นหลัง
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'on_duty_md', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end