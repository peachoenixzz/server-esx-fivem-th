-- ░█▀▀█ ▀█▀ ░█▀▀█ ░█▀▀█ ░█─── ░█▀▀▀  ▀▀█▀▀ ─█▀▀█ ░█▀▀█ ░█─── ░█▀▀▀ --
-- ░█─── ░█─ ░█▄▄▀ ░█─── ░█─── ░█▀▀▀  ─░█── ░█▄▄█ ░█▀▀▄ ░█─── ░█▀▀▀ --
-- ░█▄▄█ ▄█▄ ░█─░█ ░█▄▄█ ░█▄▄█ ░█▄▄▄  ─░█── ░█─░█ ░█▄▄█ ░█▄▄█ ░█▄▄▄ --
circle_table = {
    {
        specific_name = "painkiller",
        name = "painkiller", -- ตรงกับชื่อไอเทม name db
        label = "เพนคิลเลอร์",
        type = "general",
        currency = "money",
        category = "merchandise",
        label_category = "สินค้า",
        max_quantity = 1000, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
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
            {
                name = "weed", -- ตรงกับชื่อไอเทม name db
                label = "กัญชา",
                type = "general",
                quantity = 2,
            },
        },
        status = true,
        req = {
        },

    },
    {
        specific_name = "aed",
        name = "aed", -- ตรงกับชื่อไอเทม name db
        label = "AED",
        type = "general",
        currency = "money",
        category = "merchandise",
        label_category = "สินค้า",
        max_quantity = 1000, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "guseng", -- ตรงกับชื่อไอเทม name db
                label = "โทรม",
                type = "general",
                quantity = 5,
            },
            {
                name = "ore_pro_1", -- ตรงกับชื่อไอเทม name db
                label = "ทองแท่ง",
                type = "general",
                quantity = 5,
            },
            {
                name = "steel_pro_1", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 10,
            },
            {
                name = "stone_pack_1", -- ตรงกับชื่อไอเทม name db
                label = "ทองแดงแท่ง",
                type = "general",
                quantity = 5,
            },
        },
        status = true,
        req = {
        },
    },
    {
        specific_name = "secret_box_ce",
        name = "secret_box", -- ตรงกับชื่อไอเทม name db
        label = "กล่องดำ",
        type = "general",
        currency = "money",
        category = "merchandise_black_box",
        label_category = "กล่องดำ",
        max_quantity = 1000, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "cement", -- ตรงกับชื่อไอเทม name db
                label = "ปูน",
                type = "general",
                quantity = 3,
            },
            {
                name = "ore_pro_1", -- ตรงกับชื่อไอเทม name db
                label = "ทองแท่ง",
                type = "general",
                quantity = 5,
            },
            {
                name = "steel_pro_1", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 10,
            },
            {
                name = "stone_pack_1", -- ตรงกับชื่อไอเทม name db
                label = "ทองแดงแท่ง",
                type = "general",
                quantity = 8,
            },
            {
                name = "wood_pro_2", -- ตรงกับชื่อไอเทม name db
                label = "ไม้เนื้อแข็ง",
                type = "general",
                quantity = 8,
            },
        },
        status = true,
        req = {
        },

    },
    {
        specific_name = "secret_box_h",
        name = "secret_box", -- ตรงกับชื่อไอเทม name db
        label = "กล่องดำ",
        type = "general",
        currency = "money",
        category = "merchandise_black_box",
        label_category = "กล่องดำ",
        max_quantity = 1000, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "cement_h", -- ตรงกับชื่อไอเทม name db
                label = "ปูนเฮียฮ้ง",
                type = "general",
                quantity = 3,
            },
            {
                name = "ore_pro_1", -- ตรงกับชื่อไอเทม name db
                label = "ทองแท่ง",
                type = "general",
                quantity = 5,
            },
            {
                name = "steel_pro_1", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 10,
            },
            {
                name = "stone_pack_1", -- ตรงกับชื่อไอเทม name db
                label = "ทองแดงแท่ง",
                type = "general",
                quantity = 8,
            },
            {
                name = "wood_pro_2", -- ตรงกับชื่อไอเทม name db
                label = "ไม้เนื้อแข็ง",
                type = "general",
                quantity = 8,
            },
        },
        status = true,
        req = {
        },

    },
    {
        specific_name = "cement_hai",
        name = "cement_h", -- ตรงกับชื่อไอเทม name db
        label = "ปูนเฮียฮ้ง",
        type = "general",
        currency = "money",
        category = "material",
        label_category = "วัสดุ",
        max_quantity = 1000, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 500,
        material = {
        },
        status = true,
        req = {
        },

    },
    {
        specific_name = "wood_pro_2",
        name = "wood_pro_2", -- ตรงกับชื่อไอเทม name db
        label = "ไม้เนื้อแข็ง",
        type = "general",
        currency = "money",
        category = "material",
        label_category = "วัสดุ",
        max_quantity = 1000, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 0,
        material = {
            {
                name = "wood_pro_1", -- ตรงกับชื่อไอเทม name db
                label = "ไม้เนื้ออ่อน",
                type = "general",
                quantity = 4,
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