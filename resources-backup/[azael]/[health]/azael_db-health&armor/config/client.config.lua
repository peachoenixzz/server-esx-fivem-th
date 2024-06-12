--===== FiveM Script: ========================================
--= DB - Health and Armor
--===== Developed By: ========================================
--= Azael Dev <contact@azael.dev>
--===== Website: =============================================
--= https://www.azael.dev/
--===== License: =============================================
--= You are not allowed to sell this script or edit
--============================================================

CONFIG.General = {                                          -- ทั่วไป
    Check = {                                               -- ตรวจสอบ "พลังชีวิต" และ "เกราะ" ตัวละคร
        Time = 2                                            -- เวลาในการตรวจสอบทุกๆ X วินาที (1 เท่ากับ 1 วินาที)
    },

    Health = {                                              -- พลังชีวิต
        Recharge = {                                        -- ฟื้นฟู "พลังชีวิต" หากพลังชีวิตของตัวละครน้อยกว่า 50%
            Rate = 0.0                                      -- อัตราการฟื้นฟู Native: https://docs.fivem.net/natives/?_0x5DB660B38DD98A31 (0.0 เท่ากับ ปิดใช้งาน)
        }
    },

    Notify = {                                              -- แจ้งเตือน
        Enable = false                                       -- เปิดใช้งานการแจ้งเตือนสถานะ "พลังชีวิต" และ "เกราะ" คงเหลือ ในขณะที่ผู้เล่นเข้าร่วมเซิร์ฟเวอร์ (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)
    }
}

CONFIG.Status = {                                           -- สถานะ
    Health = {                                              -- สถานะ "พลังชีวิต"
        Enable = true,                                      -- เปิดใช้งานบันทึก "พลังชีวิต" ไปยังฐานข้อมูล (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)
        Default = 200,                                      -- ค่าเริ่มต้นของสถานะ "พลังชีวิต" สำหรับการสร้างตัวละครในครั้งเเรก (ห้ามกำหนดน้อยกว่า 100)
        Maximum = 200                                       -- ค่าสูงสุดของสถานะ "พลังชีวิต" (ห้ามกำหนดน้อยกว่า 200)
    },

    Armour = {                                              -- สถานะ "เกราะ"
        Enable = true,                                      -- เปิดใช้งานบันทึก "เกราะ" ไปยังฐานข้อมูล (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)
        Default = 0,                                        -- ค่าเริ่มต้นของสถานะ "เกราะ" สำหรับการสร้างตัวละครในครั้งเเรก
        Maximum = 100                                       -- ค่าสูงสุดของสถานะ "เกราะ"
    }
}

--- แจ้งเตือนสถานะ "พลังชีวิต" และ "เกราะ" คงเหลือ ในขณะที่ผู้เล่นเข้าร่วมเซิร์ฟเวอร์
---@param status table<{ health: table<{ value: number, percent: number >, armour: table<{ value: number, percent: number ตารางข้อมูลสถานะ "พลังชีวิต" และ "เกราะ"
CONFIG.Notification = function(status)
    local pedId = PlayerPedId()
    
    if DoesEntityExist(pedId) then
        local mugshot = RegisterPedheadshot(pedId)

        while not IsPedheadshotReady(mugshot) do
            Citizen.Wait(100)
        end

        local mugshotStr = GetPedheadshotTxdString(mugshot)
        local message

        if status.health and status.armour then
            message = ('Your ~g~Health~s~ %s%s (%s)\nYour ~b~Armour~s~ %s%s (%s)'):format(status.health.percent, '%', status.health.value, status.armour.percent, '%', status.armour.value)
        elseif status.health then
            message = ('Your ~g~Health~s~ %s%s (%s)'):format(status.health.percent, '%', status.health.value)
        elseif status.armour then
            message = ('Your ~b~Armour~s~ %s%s (%s)'):format(status.armour.percent, '%', status.armour.value)
        end

        local playerId = PlayerId()
        local serverId = GetPlayerServerId(playerId)
        local playerName = GetPlayerName(playerId)

        AddTextEntry('playerNotification', message)
        BeginTextCommandThefeedPost('playerNotification')
        EndTextCommandThefeedPostMessagetext(mugshotStr, mugshotStr, false, 8, 'PLAYER INFO', ('%s #%s'):format(playerName, serverId))

        UnregisterPedheadshot(mugshot)
    end
end
