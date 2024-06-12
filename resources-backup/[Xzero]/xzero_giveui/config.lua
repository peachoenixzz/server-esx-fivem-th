--[[
    Script For FiveM (Only)
    Created: xZERO
]]
Config = {}

-- Base Extended
Config.Base = {
    getSharedObject = 'esx:getSharedObject'
}

Config.Distance           = 20.00 -- ผู้เล่นต้องอยู่ในระยะเท่าไหร่ถึงจะแสดง
Config.Time_Show          = 1000   -- เวลาที่แสดง 1000 = 1วินาที

-- รูปภาพ
Config.Image_Show         = true -- true = แสดงรูปภาพ
Config.Image_Size_H       = 0.1  -- ขนาดรูปภาพ Width
Config.Image_Size_W       = 0.2  -- ขนาดรูปภาพ Height 

-- ข้อความชื่อไอเทม
Config.Text_Show          = false      -- true = แสดงข้อคาวามชื่อไอเทม
Config.Text_Count_Show    = false      -- true = แสดงข้อคาวามจำนวนไอเทม
Config.Text_Size          = 1.0      -- ขนาดข้อความ
Config.Text_Font          = 'ThaiFont' -- Font

-- กำหนดชื่อไอเทมที่จะไม่ให้แสดง
Config.Item_BlackList = {
    --"money"
    --"bread",
    --"water"
}

--[[
    โหลดรูปภาพไอเทมเพิ่มเติม (หากใช้งานในส่วนนี้ให้ลงรูปภาพไว้ในโฟเดอ images)
    ** ชื่อไฟล์รูปต้องตรงกับชื่อไอเทมในเกม **
]]
Config.Images_Custom = {
    "money",
    
}

Config.Options = {
    ----- ผู้เล่นที่เป็นคนให้ -----
    ['source'] = {
        anim = { 
            -- อนิเมชั่น
            enabled = true, -- true = เปิดใช้งานอนิเมชั่น
            dict = 'mp_common',
            name = 'givetake1_a'
        }
    },
    ----- ผู้เล่นที่เป็นคนรับ -----
    ['target'] = {
        anim = { 
            -- อนิเมชั่น
            enabled = true, -- true = เปิดใช้งานอนิเมชั่น
            dict = 'mp_common',
            name = 'givetake1_a'
        }
    }
}