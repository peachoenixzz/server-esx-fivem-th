-- ░█▀▄▀█ ░█▀▀▀ ░█▀▀▄ ▀█▀ ░█▀▀█  ▀▀█▀▀ ─█▀▀█ ░█▀▀█ ░█─── ░█▀▀▀ --
-- ░█░█░█ ░█▀▀▀ ░█─░█ ░█─ ░█───  ─░█── ░█▄▄█ ░█▀▀▄ ░█─── ░█▀▀▀ --
-- ░█──░█ ░█▄▄▄ ░█▄▄▀ ▄█▄ ░█▄▄█  ─░█── ░█─░█ ░█▄▄█ ░█▄▄█ ░█▄▄▄ --
medic_table = {
    {
        specific_name = "ginseng_md",
        name = "ginseng_md", -- ตรงกับชื่อไอเทม name db
        label = "โสมสกัด",
        type = "general",
        currency = "money",
        category = "health",
        label_category = "ยารักษา",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 50,
        material = {
            {
                name = "ginseng", -- ตรงกับชื่อไอเทม name db
                label = "โสม",
                type = "general",
                quantity = 5,
            },
        },
        status = true,
        req = {
        },
    },
    {
        specific_name = "bandage",
        name = "bandage", -- ตรงกับชื่อไอเทม name db
        label = "ผ้าพันแผล",
        type = "general",
        currency = "money",
        category = "health",
        label_category = "ยารักษา",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "ginseng", -- ตรงกับชื่อไอเทม name db
                label = "โสม",
                type = "general",
                quantity = 5,
            },
            {
                name = "guseng", -- ตรงกับชื่อไอเทม name db
                label = "โทรม",
                type = "general",
                quantity = 5,
            },
        },
        status = true,
        req = {
        },
    },
    {
        specific_name = "gov_holiday",
        name = "gov_holiday", -- ตรงกับชื่อไอเทม name db
        label = "บัตรลาพักร้อน",
        type = "general",
        currency = "money",
        category = "sos",
        label_category = "SOS",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "gov_medal", -- ตรงกับชื่อไอเทม name db
                label = "เหรียญกล้าหาญ",
                type = "general",
                quantity = 30,
            },
        },
        status = true,
        req = {
        },
    },
    {
        specific_name = "weapon_box_unt",
        name = "weapon_box_unt", -- ตรงกับชื่อไอเทม name db
        label = "เซ็ตตีอาวุธ",
        type = "general",
        currency = "money",
        category = "sos",
        label_category = "SOS",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 2000,
        material = {
            {
                name = "gov_medal", -- ตรงกับชื่อไอเทม name db
                label = "เหรียญกล้าหาญ",
                type = "general",
                quantity = 15,
            },
        },
        status = true,
        req = {
        },
    },
}