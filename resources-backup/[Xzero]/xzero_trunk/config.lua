-- Script For FiveM (GTAV)
-- Created By.xZERO

-- Base Extended
Config.Base = {
    getSharedObject = 'esx:getSharedObject'
}

-- for es_extended new version
Config.UseCarryItem = true -- true = สำหรับ es_extended ตัวใหม่เท่านั้นและใช้งานระบบน้ำหนัก

-- =================== Key Open Inventory ===================
Config.Key_OpenInventory = Keys['H'] -- ปุ่มในการเปิดช่องเก็บไอเทม

--[[
    =================== Animation Put And Take ===================
    อนิเมชั่นตอนเอาไอเทม เข้า-ออก จากหลังรถ
]]
Config.Anim = {
    -- เอาไอเทมเข้าหลังรถ
    ['Put'] = {
        Enabled = true, -- true = เปิดใช้งาน
        Anim_Dict = "mp_am_hold_up",
        Anim_Name = "purchase_beerbox_shopkeeper"
    },
    -- เอาไอเทมออกจากหลังรถ
    ['TakeFrom'] = {
        Enabled = true, -- true = เปิดใช้งาน
        Anim_Dict = "mp_am_hold_up",
        Anim_Name = "purchase_beerbox_shopkeeper"
    }
}

--[[
    ===== Notify Function Custom =====
    ฟังชั่นสำหรับแจ้งเตือนข้อความ
]]
Config.notifyFunc = function(text, type, time)
    TriggerEvent("pNotify:SendNotification", {
        text = text,
        type = type,
        queue = GetCurrentResourceName(),
        timeout = time,
        layout = "bottomCenter"
    })
end
Config.notifyOpenInvFunc = function(time)
    -- แจ้งเตือนตอนกำลังโหลดก่อนเปิดกระเป๋าหลังรถ
    -- TriggerEvent("pNotify:SendNotification", {
    --     text = "กรุณารอสักครู่...",
    --     type = "info",
    --     queue = GetCurrentResourceName(),
    --     timeout = time,
    --     layout = "bottomCenter"
    -- })
end

