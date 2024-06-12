-- ░█▀▀█ ░█▀▀▀ ░█▄─░█ ░█▀▀▀ ░█▀▀█ ─█▀▀█ ░█───  ▀▀█▀▀ ─█▀▀█ ░█▀▀█ ░█─── ░█▀▀▀ --
-- ░█─▄▄ ░█▀▀▀ ░█░█░█ ░█▀▀▀ ░█▄▄▀ ░█▄▄█ ░█───  ─░█── ░█▄▄█ ░█▀▀▄ ░█─── ░█▀▀▀ --
-- ░█▄▄█ ░█▄▄▄ ░█──▀█ ░█▄▄▄ ░█─░█ ░█─░█ ░█▄▄█  ─░█── ░█─░█ ░█▄▄█ ░█▄▄█ ░█▄▄▄ --
general_table = {
    -- General
    {
        specific_name = "scuba",
        name = "scuba", -- ตรงกับชื่อไอเทม name db
        label = "หน้ากากดำน้ำ",
        type = "general",
        currency = "money",
        category = "general",
        label_category = "ทั่วไป",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "steel_2", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 10,
            },
            {
                name = "copper_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแดงแท่ง",
                type = "general",
                quantity = 10,
            },
        },
        status = true,
        req = {
        },

    },
    {
        specific_name = "gadget_parachute",
        name = "GADGET_PARACHUTE", -- ตรงกับชื่อไอเทม name db
        label = "ร่มชูชีพ",
        type = "weapon",
        currency = "money",
        category = "general",
        label_category = "ทั่วไป",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 5000,
        material = {
        },
        status = true,
        req = {
        },
    },
    {
        specific_name = "toolkit",
        name = "toolkit", -- ตรงกับชื่อไอเทม name db
        label = "กล่องซ่อม",
        type = "general",
        currency = "money",
        category = "general",
        label_category = "ทั่วไป",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "steel_2", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 10,
            },
        },
        status = true,
        req = {
        },
    },
    -- Material
    {
        specific_name = "alloy",
        name = "alloy", -- ตรงกับชื่อไอเทม name db
        label = "อัลลอย",
        type = "general",
        currency = "money",
        category = "material",
        label_category = "วัสดุ",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.85, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 10000,
        material = {
            {
                name = "steel_3", -- ตรงกับชื่อไอเทม name db
                label = "เศษอัลลอย",
                type = "general",
                quantity = 10,
            },
            {
                name = "cement", -- ตรงกับชื่อไอเทม name db
                label = "ปูน",
                type = "general",
                quantity = 10,
            },
        },
        status = true,
        req = {
        },
    },
    {
        specific_name = "heart_70",
        name = "heart_70", -- ตรงกับชื่อไอเทม name db
        label = "กันแตก 70%",
        type = "general",
        currency = "money",
        category = "material",
        label_category = "วัสดุ",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 3000,
        material = {
            {
                name = "ruby", -- ตรงกับชื่อไอเทม name db
                label = "รูบี้",
                type = "general",
                quantity = 20,
            },
            {
                name = "copper_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแดงแท่ง",
                type = "general",
                quantity = 20,
            },
            {
                name = "wood_2", -- ตรงกับชื่อไอเทม name db
                label = "ไม้แท่ง",
                type = "general",
                quantity = 20,
            },
        },
        status = true,
        req = {
        },
    },
    {
        specific_name = "heart_90",
        name = "heart_90", -- ตรงกับชื่อไอเทม name db
        label = "กันแตก 90%",
        type = "general",
        currency = "money",
        category = "material",
        label_category = "วัสดุ",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 3000,
        material = {
            {
                name = "heart_70", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 70%",
                type = "general",
                quantity = 1,
            },
            {
                name = "ruby", -- ตรงกับชื่อไอเทม name db
                label = "รูบี้",
                type = "general",
                quantity = 20,
            },
            {
                name = "copper_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแดงแท่ง",
                type = "general",
                quantity = 20,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 5,
            },
        },
        status = true,
        req = {
        },
    },
    {
        specific_name = "heart_100",
        name = "heart_100", -- ตรงกับชื่อไอเทม name db
        label = "กันแตก 100%",
        type = "general",
        currency = "money",
        category = "material",
        label_category = "วัสดุ",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.75, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 5,
            },
        },
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 5000,
        material = {
            {
                name = "heart_90", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 90%",
                type = "general",
                quantity = 1,
            },
            {
                name = "ruby", -- ตรงกับชื่อไอเทม name db
                label = "รูบี้",
                type = "general",
                quantity = 20,
            },
            {
                name = "copper_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแดงแท่ง",
                type = "general",
                quantity = 20,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 10,
            },
        },
        status = true,
        req = {
        },
    },
    -- Equipment
    {
        specific_name = "lockpick",
        name = "lockpick", -- ตรงกับชื่อไอเทม name db
        label = "ล็อคปิ๊ก",
        type = "general",
        currency = "money",
        category = "equipment",
        label_category = "อุปกรณ์",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "steel_2", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 5,
            },
            {
                name = "copper_2", -- ตรงกับชื่อไอเทม name db
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
        specific_name = "vest",
        name = "vest", -- ตรงกับชื่อไอเทม name db
        label = "เกราะ",
        type = "general",
        currency = "money",
        category = "equipment",
        label_category = "อุปกรณ์",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 1000,
        material = {
            {
                name = "gold_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแท่ง",
                type = "general",
                quantity = 10,
            },
            {
                name = "steel_2", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 20,
            },
        },
        status = true,
        req = {
        },

    },
    {
        specific_name = "helmet",
        name = "helmet", -- ตรงกับชื่อไอเทม name db
        label = "หมวกกันคริ",
        type = "general",
        currency = "money",
        category = "equipment",
        label_category = "อุปกรณ์",
        max_quantity = 5, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 1000,
        material = {
            {
                name = "steel_2", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 10,
            },
            {
                name = "copper_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแดงแท่ง",
                type = "general",
                quantity = 20,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 5,
            },
        },
        status = true,
        req = {
        },

    },
    {
        specific_name = "aed_super",
        name = "aed_super", -- ตรงกับชื่อไอเทม name db
        label = "Super AED",
        type = "general",
        currency = "money",
        category = "equipment",
        label_category = "อุปกรณ์",
        max_quantity = 5, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 2500,
        material = {
            {
                name = "aed", -- ตรงกับชื่อไอเทม name db
                label = "AED",
                type = "general",
                quantity = 1,
            },
            {
                name = "microchip", -- ตรงกับชื่อไอเทม name db
                label = "ไมโครชิป",
                type = "general",
                quantity = 1,
            },
            {
                name = "copper_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแดงแท่ง",
                type = "general",
                quantity = 20,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 25,
            },
        },
        status = true,
        req = {
        },
    },
    {
        specific_name = "screwdv",
        name = "screwdv", -- ตรงกับชื่อไอเทม name db
        label = "ไขควง",
        type = "general",
        currency = "money",
        category = "equipment",
        label_category = "อุปกรณ์",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "gold_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแท่ง",
                type = "general",
                quantity = 5,
            },
            {
                name = "steel_2", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 20,
            },
            {
                name = "copper_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแดงแท่ง",
                type = "general",
                quantity = 10,
            },
        },
        status = true,
        req = {
        },
    },
    {
        specific_name = "screwdv_broken",
        name = "screwdv", -- ตรงกับชื่อไอเทม name db
        label = "ไขควง (ซ่อม)",
        type = "general",
        currency = "money",
        category = "equipment",
        label_category = "อุปกรณ์",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "screwdv_broken", -- ตรงกับชื่อไอเทม name db
                label = "ไขควง (พัง)",
                type = "general",
                quantity = 5,
            },
            {
                name = "steel_2", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 10,
            },
        },
        status = true,
        req = {
        },

    },
    {
        specific_name = "disruptor",
        name = "disruptor", -- ตรงกับชื่อไอเทม name db
        label = "เครื่องตัดสัญญาณ",
        type = "general",
        currency = { "money", "black_money" },
        category = "equipment",
        label_category = "อุปกรณ์",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = { 1000, 1000 },
        material = {
            {
                name = "steel_2", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 40,
            },
            {
                name = "copper_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแดงแท่ง",
                type = "general",
                quantity = 20,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 5,
            },
        },
        status = true,
        req = {
        },

    },
    {
        specific_name = "bullet",
        name = "bullet", -- ตรงกับชื่อไอเทม name db
        label = "กระสุน",
        type = "general",
        currency = { "money", "black_money" },
        category = "equipment",
        label_category = "อุปกรณ์",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = { 100, 100 },
        material = {
            {
                name = "coal", -- ตรงกับชื่อไอเทม name db
                label = "ผงถ่าน",
                type = "general",
                quantity = 1,
            },
            {
                name = "sulfur", -- ตรงกับชื่อไอเทม name db
                label = "ซัลเฟอร์",
                type = "general",
                quantity = 1,
            },
            {
                name = "gold_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแท่ง",
                type = "general",
                quantity = 3,
            },
            {
                name = "copper_2", -- ตรงกับชื่อไอเทม name db
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
        specific_name = "speed_loader",
        name = "speed_loader", -- ตรงกับชื่อไอเทม name db
        label = "Speed Loader",
        type = "general",
        currency = { "money", "black_money" },
        category = "equipment",
        label_category = "อุปกรณ์",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = { 100, 100 },
        material = {
            {
                name = "bullet", -- ตรงกับชื่อไอเทม name db
                label = "กระสุน",
                type = "general",
                quantity = 6,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 5,
            },
        },
        status = true,
        req = {
        },
    },
    -- Box
    {
        specific_name = "weapon_box",
        name = "weapon_box", -- ตรงกับชื่อไอเทม name db
        label = "กล่องตีอาวุธ",
        type = "general",
        currency = "money",
        category = "box",
        label_category = "กล่อง",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "cement", -- ตรงกับชื่อไอเทม name db
                label = "ปูน",
                type = "general",
                quantity = 5,
            },
            {
                name = "gold_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแท่ง",
                type = "general",
                quantity = 10,
            },
            {
                name = "steel_2", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 20,
            },
            {
                name = "copper_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแดงแท่ง",
                type = "general",
                quantity = 15,
            },
            {
                name = "wood_2", -- ตรงกับชื่อไอเทม name db
                label = "ไม้แท่ง",
                type = "general",
                quantity = 15,
            },
        },
        status = true,
        req = {
        },
    },
    {
        specific_name = "box_cement",
        name = "box_cement", -- ตรงกับชื่อไอเทม name db
        label = "กล่องปูน",
        type = "general",
        currency = "money",
        category = "box",
        label_category = "กล่อง",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "cement", -- ตรงกับชื่อไอเทม name db
                label = "ปูน",
                type = "general",
                quantity = 100,
            },
        },
        status = true,
        req = {
        },
    },
    {
        specific_name = "box_gold",
        name = "box_gold", -- ตรงกับชื่อไอเทม name db
        label = "กล่องทองแท่ง",
        type = "general",
        currency = "money",
        category = "box",
        label_category = "กล่อง",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "gold_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแท่ง",
                type = "general",
                quantity = 100,
            },
        },
        status = true,
        req = {
        },
    },
    {
        specific_name = "box_steel",
        name = "box_steel", -- ตรงกับชื่อไอเทม name db
        label = "กล่องเหล็กแท่ง",
        type = "general",
        currency = "money",
        category = "box",
        label_category = "กล่อง",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "steel_2", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 100,
            },
        },
        status = true,
        req = {
        },
    },
    {
        specific_name = "box_copper",
        name = "box_copper", -- ตรงกับชื่อไอเทม name db
        label = "กล่องทองแดงแท่ง",
        type = "general",
        currency = "money",
        category = "box",
        label_category = "กล่อง",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "copper_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแดงแท่ง",
                type = "general",
                quantity = 100,
            },
        },
        status = true,
        req = {
        },
    },
    {
        specific_name = "box_wood",
        name = "box_wood", -- ตรงกับชื่อไอเทม name db
        label = "กล่องไม้แท่ง",
        type = "general",
        currency = "money",
        category = "box",
        label_category = "กล่อง",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "wood_2", -- ตรงกับชื่อไอเทม name db
                label = "ไม้แท่ง",
                type = "general",
                quantity = 100,
            },
        },
        status = true,
        req = {
        },
    },
    {
        specific_name = "box_diamond",
        name = "box_diamond", -- ตรงกับชื่อไอเทม name db
        label = "กล่องเพชร",
        type = "general",
        currency = "money",
        category = "box",
        label_category = "กล่อง",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 100,
            },
        },
        status = true,
        req = {
        },
    },
    {
        specific_name = "box_ruby",
        name = "box_ruby", -- ตรงกับชื่อไอเทม name db
        label = "กล่องรูบี้",
        type = "general",
        currency = "money",
        category = "box",
        label_category = "กล่อง",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "ruby", -- ตรงกับชื่อไอเทม name db
                label = "รูบี้",
                type = "general",
                quantity = 100,
            },
        },
        status = true,
        req = {
        },
    },
}