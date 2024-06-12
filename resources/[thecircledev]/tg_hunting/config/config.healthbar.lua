-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

Config = Config or {}

Config.HealthBar = {
    Enable = false,      -- เปิดให้แสดงหลอดเลือดของสัตว์หรือไม่ (หากเปิด Resmon ฝั่ง Client จะมากขึ้น)

    Setting = {
        render_distance = 5.0,     -- ระยะการมองเห็นหลอดเลือดบนหัวสัตว์ (ไม่แนะนำให้ปรับเกิน 7.0)
        width = 0.055,       -- ความกว้างของหลอดเลือด
        height = 0.0070,        -- ความสูงของหลอดเลือด
        head_offset = 0.4,      -- ความสูงของหลอดเลือดจากสัตว์
        border = 2     -- ความหนาของขอบหลอดเลือด
    },

    Color = {
        background = { 
            r = 18,     -- สีของพื้นหลังหลอดเลือด (Red) 
            g = 20,     -- สีของพื้นหลังหลอดเลือด (Green) 
            b = 23,     -- สีของพื้นหลังหลอดเลือด (Blue)         
            a = 150     -- สีของพื้นหลังหลอดเลือด (Alpha) 
        },
        full_health = { 
            r = 46,     -- สีของหลอดเลือด (Red) เมื่อเลือดสัตว์ 100%
            g = 255,        -- สีของหลอดเลือด (Green) เมื่อเลือดสัตว์ 100% 
            b = 0       -- สีของหลอดเลือด (Blue) เมื่อเลือดสัตว์ 100%
        },
        half_health = { 
            r = 255,        -- สีของหลอดเลือด (Blue) เมื่อเลือดสัตว์ 31% - 70% 
            g = 213,        -- สีของหลอดเลือด (Blue) เมื่อเลือดสัตว์ 31% - 70% 
            b = 0       -- สีของหลอดเลือด (Blue) เมื่อเลือดสัตว์ 31% - 70% 
        },
        low_health = { 
            r = 255,         -- สีของหลอดเลือด (Blue) เมื่อเลือดสัตว์น้อยกว่า 30% 
            g = 0,       -- สีของหลอดเลือด (Blue) เมื่อเลือดสัตว์น้อยกว่า 30%
            b = 0        -- สีของหลอดเลือด (Blue) เมื่อเลือดสัตว์น้อยกว่า 30%
        }
    }
}