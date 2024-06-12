-- ░█▀▀█ ░█▀▀▀█ ░█▀▀▀█ ░█─▄▀ ▀█▀ ░█▄─░█ ░█▀▀█  ▀▀█▀▀ ─█▀▀█ ░█▀▀█ ░█─── ░█▀▀▀ --
-- ░█─── ░█──░█ ░█──░█ ░█▀▄─ ░█─ ░█░█░█ ░█─▄▄  ─░█── ░█▄▄█ ░█▀▀▄ ░█─── ░█▀▀▀ --
-- ░█▄▄█ ░█▄▄▄█ ░█▄▄▄█ ░█─░█ ▄█▄ ░█──▀█ ░█▄▄█  ─░█── ░█─░█ ░█▄▄█ ░█▄▄█ ░█▄▄▄ --
cooking_table = {
    {
        specific_name = "meal_1",
        name = "meal_1", -- ตรงกับชื่อไอเทม name db
        label = "ข้าวราดแกง",
        type = "general",
        currency = "money",
        category = "meal",
        label_category = "อาหาร",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "rice_2", -- ตรงกับชื่อไอเทม name db
                label = "กระสอบข้าว",
                type = "general",
                quantity = 2,
            },
            {
                name = "pork_2", -- ตรงกับชื่อไอเทม name db
                label = "หมูสไลด์",
                type = "general",
                quantity = 2,
            },
            {
                name = "cabbage_2", -- ตรงกับชื่อไอเทม name db
                label = "กะหล่ำหั่น",
                type = "general",
                quantity = 1,
            },
            {
                name = "condiment", -- ตรงกับชื่อไอเทม name db
                label = "เครื่องปรุง",
                type = "general",
                quantity = 1,
            },
        },
        status = true,
        req = {
        },

    },
    {
        specific_name = "meal_2",
        name = "meal_2", -- ตรงกับชื่อไอเทม name db
        label = "กะเพราไก่",
        type = "general",
        currency = "money",
        category = "meal",
        label_category = "อาหาร",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "rice_2", -- ตรงกับชื่อไอเทม name db
                label = "กระสอบข้าว",
                type = "general",
                quantity = 1,
            },
            {
                name = "chicken_2", -- ตรงกับชื่อไอเทม name db
                label = "เนื้อไก่",
                type = "general",
                quantity = 2,
            },
            {
                name = "condiment", -- ตรงกับชื่อไอเทม name db
                label = "เครื่องปรุง",
                type = "general",
                quantity = 1,
            },
        },
        status = true,
        req = {
        },

    },
    {
        specific_name = "meal_3",
        name = "meal_3", -- ตรงกับชื่อไอเทม name db
        label = "นมจืด",
        type = "general",
        currency = "money",
        category = "meal",
        label_category = "อาหาร",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "milk_2", -- ตรงกับชื่อไอเทม name db
                label = "นมกล่อง",
                type = "general",
                quantity = 2,
            },
            {
                name = "rice_2", -- ตรงกับชื่อไอเทม name db
                label = "กระสอบข้าว",
                type = "general",
                quantity = 1,
            },
        },
        status = true,
        req = {
        },
    }
}
