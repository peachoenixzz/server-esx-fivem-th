-- ░█▀▄▀█ ░█▀▀▀ ░█▀▀▄ ▀█▀ ░█▀▀█  ▀▀█▀▀ ─█▀▀█ ░█▀▀█ ░█─── ░█▀▀▀ --
-- ░█░█░█ ░█▀▀▀ ░█─░█ ░█─ ░█───  ─░█── ░█▄▄█ ░█▀▀▄ ░█─── ░█▀▀▀ --
-- ░█──░█ ░█▄▄▄ ░█▄▄▀ ▄█▄ ░█▄▄█  ─░█── ░█─░█ ░█▄▄█ ░█▄▄█ ░█▄▄▄ --
medic_table = {
    {
        specific_name = "gacha_gov",
        name = "gacha_gov", -- ตรงกับชื่อไอเทม name db
        label = "กาชาปองหน่วยงาน",
        type = "general",
        currency = "money",
        category = "gov",
        label_category = "หน่วยงาน",
        max_quantity = 50, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "exp_gov", -- ตรงกับชื่อไอเทม name db
                label = "EXP หน่วยงาน",
                type = "general",
                quantity = 5,
            },
        },
        status = true,
        req = {
            {
                req_name = "gov_card",
                req_label = "ตราหน่วยงาน",
            },
       },
    },
    -- vehicles
    {
        specific_name = "box_polbmwm4",
        name = "box_polbmwm4", -- ตรงกับชื่อไอเทม name db
        label = "BMW M4",
        type = "general",
        currency = "money",
        category = "gov",
        label_category = "รถหน่วยงาน",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "gov_ticket", -- ตรงกับชื่อไอเทม name db
                label = "ตั๋วหน่วยงาน",
                type = "general",
                quantity = 30,
            },
        },
        status = true,
        req = {
            {
                req_name = "gov_card",
                req_label = "ตราหน่วยงาน",
            },
       },
    },
    {
        specific_name = "box_polr34",
        name = "box_polr34", -- ตรงกับชื่อไอเทม name db
        label = "GTR R34",
        type = "general",
        currency = "money",
        category = "gov",
        label_category = "รถหน่วยงาน",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "gov_ticket", -- ตรงกับชื่อไอเทม name db
                label = "ตั๋วหน่วยงาน",
                type = "general",
                quantity = 30,
            },
        },
        status = true,
        req = {
            {
                req_name = "gov_card",
                req_label = "ตราหน่วยงาน",
            },
       },
    },
    -- weapon
    {
        specific_name = "weapon_knife_sos",
        name = "WEAPON_KNIFE_SOS", -- ตรงกับชื่อไอเทม name db
        label = "M9",
        type = "weapon",
        currency = "money",
        category = "gov_weapon",
        label_category = "อาวุธหน่วยงาน",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100000,
        material = {
            {
                name = "gov_ticket", -- ตรงกับชื่อไอเทม name db
                label = "ตั๋วหน่วยงาน",
                type = "general",
                quantity = 20,
            },
        },
        status = true,
        req = {
            {
                req_name = "gov_card",
                req_label = "ตราหน่วยงาน",
            },
       },
    },
    {
        specific_name = "weapon_poolcue_sos",
        name = "WEAPON_POOLCUE_SOS", -- ตรงกับชื่อไอเทม name db
        label = "Poolcue",
        type = "weapon",
        currency = "money",
        category = "gov_weapon",
        label_category = "อาวุธหน่วยงาน",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100000,
        material = {
            {
                name = "gov_ticket", -- ตรงกับชื่อไอเทม name db
                label = "ตั๋วหน่วยงาน",
                type = "general",
                quantity = 20,
            },
        },
        status = true,
        req = {
            {
                req_name = "gov_card",
                req_label = "ตราหน่วยงาน",
            },
       },
    },
}