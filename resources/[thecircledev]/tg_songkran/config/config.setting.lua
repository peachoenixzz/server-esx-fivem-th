-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

Config = Config or {}

Config.Command = 'delwatergun'      -- คำสั่งลบ Prop ปืนฉีดน้ำ

Config.Watergun = {
    ItemName = 'sk_1',     -- ชื่อไอเทมของปืนฉีดน้ำ
    Remove = false,      -- เปิดให้ลบไอเทมเมื่อกดใช้หรือไม่
    WaterTank = 75,     -- จำนวนน้ำในกระบอกปืน (ยิ่งเยอะยิ่งใช้งานได้นาน)

    Model = {
        name = 'prop_monitor_01d',     -- ชื่อ Prop ของปืนฉีดน้ำ     
        time_load = 0,        -- ระยะเวลารอโหลด Prop (หน่วยเป็นวินาที)
        bone = 28422,       -- เลข ID ฺBone (ดูได้ที่เว็บ https://wiki.gtanet.work/index.php?title=Bones)
        position = {
            x = 0.40,       -- ตำแหน่งแกน X ของ Prop
            y = -0.04,      -- ตำแหน่งแกน Y ของ Prop 
            z = 0.0     -- ตำแหน่งแกน Z ของ Prop       
        },
        rotation = {
            x = 270.0,      -- หมุนแกน X ของ Prop      
            y = 0.0,        -- หมุนแกน Y ของ Prop
            z = 0.0     -- หมุนแกน Z ของ Prop
        }
    },
    
    Animation = {
        hold = {dict = 'weapons@rifle@lo@pump_stealth', name = 'aim_med_loop', flag = 50},        -- ชื่อ Animation ถือปืน
    },

    Particle = {
        effect = {dict = 'core', name = 'water_cannon_jet'},     -- ชื่อ Effect
        scale = 0.5,     -- ขนาดของ Effect 

        position = {
            x = 0.0,       -- ตำแหน่งแกน X ของ Effect
            y = 0.0,      -- ตำแหน่งแกน Y ของ Effect 
            z = 0.2     -- ตำแหน่งแกน Z ของ Effect       
        },

        rotation = {
            x = 0.0,      -- หมุนแกน X ของ Effect      
            y = -95.0,        -- หมุนแกน Y ของ Effect
            z = -90.0     -- หมุนแกน Z ของ Effect
        }

    }
}

Config.Flour = {
    ItemName = 'sk_2',     -- ชื่อไอเทมของถังปะแป้ง
    Remove = true,      -- เปิดให้ลบไอเทมเมื่อกดใช้หรือไม่
    Duration = 60,       -- ระยะเวลาที่แป้งบนใบหน้าจะหายไป (หน่วยเป็นวินาที)

    Model = {
        name = 'prop_mouse_02',     -- ชื่อ Prop ของถังปะแป้ง 
        bone = 57005,       -- เลข ID ฺBone (ดูได้ที่เว็บ https://wiki.gtanet.work/index.php?title=Bones)
        position = {
            x = 0.0,       -- ตำแหน่งแกน X ของ Prop
            y = 0.0,      -- ตำแหน่งแกน Y ของ Prop 
            z = -0.5     -- ตำแหน่งแกน Z ของ Prop       
        },
        rotation = {
            x = 0.0,      -- หมุนแกน X ของ Prop      
            y = 0.0,        -- หมุนแกน Y ของ Prop
            z = 0.0     -- หมุนแกน Z ของ Prop
        }
    },

    Animation = {
        first = {dict = 'reaction@intimidation@1h', name = 'intro', flag = 48},        -- ชื่อ Animation แรก (หากไม่ต้องการใช้ให้ใส่ nil เช่น first = nil)
        second = {dict = 'anim@mp_player_intincarjazz_handslow@ds@', name = 'exit', flag = 49}     -- ชื่อ Animation ที่สอง (หากไม่ต้องการใช้ให้ใส่ nil เช่น second = nil)
    }
}

Config.RefillWater = {
    Coords = {
        vector3(-288.1199951171875, -902.780029296875, 31.34000015258789),       -- land yellow
        vector3(-293.8399963378906, -917.0499877929688, 31.34000015258789),        -- land yellow
        vector3(-317.7000122070313, -915.4299926757812, 31.34000015258789),        -- land yellow
        vector3(-351.8299865722656, -893.530029296875, 31.34000015258789),        -- land yellow
        vector3(-319.1900024414063, -880.4000244140625, 31.34000015258789),        -- land yellow
        vector3(-362.1400146484375, -924.780029296875, 31.34000015258789),        -- land yellow
        vector3(-351.6000061035156, -942.4099731445312, 31.34000015258789),        -- land yellow
        vector3(-338.55999755859375, -975.239990234375, 31.34000015258789),        -- land yellow
        vector3(-304.0299987792969, -974.8400268554688, 31.34000015258789),        -- land yellow
        vector3(-325.5299987792969, -948, 31.34000015258789),        -- land yellow
        vector3(250.60000610351565, -865.4600219726562, 29.47999954223632),     -- Land กลาง
        vector3(242.35000610351565, -863.8400268554688, 29.68000030517578),     -- Land กลาง
        vector3(234.1300048828125, -861.6099853515625, 29.8799991607666),     -- Land กลาง
        vector3(209.2299957275391, -938.97998046875, 30.70999908447265),     -- Land กลาง
        vector3(204.8800048828125, -945.4600219726564, 30.70999908447265),     -- Land กลาง
    },

    Duration = 3,        -- ระยะเวลารอเติมน้ำ (หน่วยเป็นวินาที)
    RenderDistance = 20.0,      -- ระยะการมองเห็น
    ActionArea = 1.5,       -- ระยะที่จะสามารถกดปุ่มได้

    Checking = { -- เช็คไอเทมหรือเงินก่อนเติมน้ำ (ต้องเปิดอย่างใดอย่างนึงเท่านั้น หรือหากไม่ต้องการให้เช็คใส่ nil ทั้งคู่ได้เลย)
        item = nil,     -- หากต้องการเช็คไอเทมให้ใส่ item = {name = 'ขื่อไอเทม' (str), count = จำนวน (int) , remove = ต้องการให้ลบไอเทมหรือไม่ (bool)}, (หากไม่ต้องการให้ใส่ nil เช่น item = nil)  
        money = {count = 100, remove = true}        -- หากต้องการเช็คเงินให้ใส่ money = {count = จำนวนเงิน (int), remove = ต้องการให้ลบเงินหรือไม่ (bool)} (หากไม่ต้องการให้ใส่ nil เช่น money = nil)  
    },

    Marker = {
        type = 1,       -- ประเภทของ Marker
        scale = {x = 4.0, y = 4.0, z = 1.0},        -- ขนาดของ Marker
        color = {r = 255, g = 204, b = 0, a = 100}     -- สีของ Marker
    },

    Animation = {
        refill = {dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', name = 'machinic_loop_mechandplayer', flag = 49},      -- ชื่อ Animation เติมน้ำ (หากไม่ต้องการใช้ให้ใส่ nil เช่น refil = nil)
    },
}