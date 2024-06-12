
class_table = {

-- parts

    {
        specific_name = "wheel_g",
        name = "wheel_g", -- ตรงกับชื่อไอเทม name db
        label = "Gold Wheel",
        type = "general",
        currency = "money",
        category = "part",
        label_category = "อะไหล่",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.75, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 50,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 1000,
        material = {
            {
                name = "wheel", -- ตรงกับชื่อไอเทม name db
                label = "Wheel",
                type = "general",
                quantity = 1,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 25,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "gear_g",
        name = "gear_g", -- ตรงกับชื่อไอเทม name db
        label = "Gold Gear",
        type = "general",
        currency = "money",
        category = "part",
        label_category = "อะไหล่",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.75, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 50,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 1000,
        material = {
            {
                name = "gear", -- ตรงกับชื่อไอเทม name db
                label = "Gear",
                type = "general",
                quantity = 1,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 25,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "steering_g",
        name = "steering_g", -- ตรงกับชื่อไอเทม name db
        label = "Gold Steering",
        type = "general",
        currency = "money",
        category = "part",
        label_category = "อะไหล่",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.75, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 50,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 1000,
        material = {
            {
                name = "steering", -- ตรงกับชื่อไอเทม name db
                label = "Steering",
                type = "general",
                quantity = 1
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 25,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "engine_g",
        name = "engine_g", -- ตรงกับชื่อไอเทม name db
        label = "Gold Engine",
        type = "general",
        currency = "money",
        category = "part",
        label_category = "อะไหล่",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.75, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 50,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 1000,
        material = {
            {
                name = "engine", -- ตรงกับชื่อไอเทม name db
                label = "Engine",
                type = "general",
                quantity = 1,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 25,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "turbo_g",
        name = "turbo_g", -- ตรงกับชื่อไอเทม name db
        label = "Gold Turbo",
        type = "general",
        currency = "money",
        category = "part",
        label_category = "อะไหล่",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.75, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 50,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 1000,
        material = {
            {
                name = "turbo", -- ตรงกับชื่อไอเทม name db
                label = "Turbo",
                type = "general",
                quantity = 1,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 25,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },

-- vehicle

    {
        specific_name = "box_brawler",
        name = "box_brawler", -- ตรงกับชื่อไอเทม name db
        label = "Brawler",
        type = "general",
        currency = "money",
        category = "vehicle",
        label_category = "รถกาชาปอง",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 10000,
        material = {
            {
                name = "wheel", -- ตรงกับชื่อไอเทม name db
                label = "Wheel",
                type = "general",
                quantity = 4,
            },
            {
                name = "gear", -- ตรงกับชื่อไอเทม name db
                label = "Gear",
                type = "general",
                quantity = 1,
            },
            {
                name = "steering", -- ตรงกับชื่อไอเทม name db
                label = "Steering",
                type = "general",
                quantity = 1,
            },
            {
                name = "engine", -- ตรงกับชื่อไอเทม name db
                label = "Engine",
                type = "general",
                quantity = 1,
            },
            {
                name = "turbo", -- ตรงกับชื่อไอเทม name db
                label = "Turbo",
                type = "general",
                quantity = 1,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "box_trophy",
        name = "box_trophy", -- ตรงกับชื่อไอเทม name db
        label = "Trophy Truck",
        type = "general",
        currency = "money",
        category = "vehicle",
        label_category = "รถกาชาปอง",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 10000,
        material = {
            {
                name = "wheel_g", -- ตรงกับชื่อไอเทม name db
                label = "Gold Wheel",
                type = "general",
                quantity = 4,
            },
            {
                name = "gear_g", -- ตรงกับชื่อไอเทม name db
                label = "Gold Gear",
                type = "general",
                quantity = 1,
            },
            {
                name = "steering_g", -- ตรงกับชื่อไอเทม name db
                label = "Gold Steering",
                type = "general",
                quantity = 1,
            },
            {
                name = "engine_g", -- ตรงกับชื่อไอเทม name db
                label = "Gold Engine",
                type = "general",
                quantity = 1,
            },
            {
                name = "turbo_g", -- ตรงกับชื่อไอเทม name db
                label = "Gold Turbo",
                type = "general",
                quantity = 1,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
}