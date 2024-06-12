-- ▒█▀▀█ ░█▀▀█ ▒█▄░▒█ ▒█▀▀█  ▀▀█▀▀ ░█▀▀█ ▒█▀▀█ ▒█░░░ ▒█▀▀▀ --
-- ▒█░▄▄ ▒█▄▄█ ▒█▒█▒█ ▒█░▄▄  ░▒█░░ ▒█▄▄█ ▒█▀▀▄ ▒█░░░ ▒█▀▀▀ --
-- ▒█▄▄█ ▒█░▒█ ▒█░░▀█ ▒█▄▄█  ░▒█░░ ▒█░▒█ ▒█▄▄█ ▒█▄▄█ ▒█▄▄▄ --
gang_table = {
    -- Key
    {
       specific_name = "key_gang",
       name = "key_gang", -- ตรงกับชื่อไอเทม name db
       label = "กุญแจมงคล",
       type = "general",
       currency = "black_money",
       category = "gang",
       label_category = "แก๊ง",
       max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
       success_rate = 1.0, -- 0.9 = 90%
       failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
       crafting_time = 7, -- หน่วยเป็นวินาที
       price = 50000,
       material = {
           {
               name = "gold_2", -- ตรงกับชื่อไอเทม name db
               label = "ทองแท่ง",
               type = "general",
               quantity = 20,
           },
           {
               name = "steel_2", -- ตรงกับชื่อไอเทม name db
               label = "เหล็กแท่ง",
               type = "general",
               quantity = 50,
           },
           {
            name = "exp", -- ตรงกับชื่อไอเทม name db
            label = "EXP",
            type = "general",
            quantity = 50,
            },
       },
       status = true,
       once_require = true, -- true ถ้าหากต้องการใช้แค่อย่างใดอย่างนึงใน req item
       req = {
            {
                req_name = "card_gang",
                req_label = "บัตรแก๊ง",
            },
            {
                req_name = "card_family",
                req_label = "บัตรครอบครัว",
            },
       },
    },
    {
        specific_name = "tag_gang",
        name = "tag_gang", -- ตรงกับชื่อไอเทม name db
        label = "Gang Tag",
        type = "general",
        currency = "money",
        category = "gang",
        label_category = "แก๊ง",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 1000,
        material = {
            {
             name = "exp", -- ตรงกับชื่อไอเทม name db
             label = "EXP",
             type = "general",
             quantity = 10,
             },
        },
        status = true,
        once_require = true, -- true ถ้าหากต้องการใช้แค่อย่างใดอย่างนึงใน req item
        req = {
            --  {
            --      req_name = "card_gang",
            --      req_label = "บัตรแก๊ง",
            --  },
            --  {
            --      req_name = "card_family",
            --      req_label = "บัตรครอบครัว",
            --  },
        },
     },
    -- Equipment
    {
        specific_name = "fight_pack",
        name = "fight_pack", -- ตรงกับชื่อไอเทม name db
        label = "Fight Pack",
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
                name = "painkiller", -- ตรงกับชื่อไอเทม name db
                label = "เพนคิลเลอร์",
                type = "general",
                quantity = 20,
            },
            {
                name = "vest", -- ตรงกับชื่อไอเทม name db
                label = "เกราะ",
                type = "general",
                quantity = 20,
            },
            {
                name = "aed", -- ตรงกับชื่อไอเทม name db
                label = "AED",
                type = "general",
                quantity = 3,
            },
        },
        status = true,
        once_require = true, -- true ถ้าหากต้องการใช้แค่อย่างใดอย่างนึงใน req item
        req = {
             {
                 req_name = "card_gang",
                 req_label = "บัตรแก๊ง",
             },
             {
                 req_name = "card_family",
                 req_label = "บัตรครอบครัว",
             },
        },
    },
    {
        specific_name = "radio",
        name = "radio", -- ตรงกับชื่อไอเทม name db
        label = "วิทยุสื่อสาร",
        type = "general",
        currency = "money",
        category = "equipment",
        label_category = "อุปกรณ์",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 10000,
        material = {
            {
                name = "gold_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแท่ง",
                type = "general",
                quantity = 20,
            },
            {
                name = "copper_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแดงแท่ง",
                type = "general",
                quantity = 40,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 5,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 10,
            },
        },
        status = true,
        once_require = true, -- true ถ้าหากต้องการใช้แค่อย่างใดอย่างนึงใน req item
        req = {
             {
                 req_name = "card_gang",
                 req_label = "บัตรแก๊ง",
             },
             {
                 req_name = "card_family",
                 req_label = "บัตรครอบครัว",
             },
        },
    },
    {
        specific_name = "radio_board",
        name = "radio", -- ตรงกับชื่อไอเทม name db
        label = "วิทยุสื่อสาร (ซ่อม)",
        type = "general",
        currency = "money",
        category = "equipment",
        label_category = "อุปกรณ์",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 10000,
        material = {
            {
                name = "radio_board", -- ตรงกับชื่อไอเทม name db
                label = "วงจรวิทยุ",
                type = "general",
                quantity = 3,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 10,
            },
        },
        status = true,
        once_require = true, -- true ถ้าหากต้องการใช้แค่อย่างใดอย่างนึงใน req item
        req = {
             {
                 req_name = "card_gang",
                 req_label = "บัตรแก๊ง",
             },
             {
                 req_name = "card_family",
                 req_label = "บัตรครอบครัว",
             },
        },
    },
    {
        specific_name = "adrenaline",
        name = "adrenaline", -- ตรงกับชื่อไอเทม name db
        label = "อะดรีนาลีน",
        type = "general",
        currency = { "money", "black_money" },
        category = "equipment",
        label_category = "อุปกรณ์",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = { 1000, 1000 },
        material = {
            {
                name = "weed_pack", -- ตรงกับชื่อไอเทม name db
                label = "กัญชาแพ็ค",
                type = "general",
                quantity = 10,
            },
            {
                name = "amp_g", -- ตรงกับชื่อไอเทม name db
                label = "แอมป์เขียว",
                type = "general",
                quantity = 1,
            },
        },
        status = true,
        once_require = true, -- true ถ้าหากต้องการใช้แค่อย่างใดอย่างนึงใน req item
        req = {
             {
                 req_name = "card_gang",
                 req_label = "บัตรแก๊ง",
             },
             {
                 req_name = "card_family",
                 req_label = "บัตรครอบครัว",
             },
        },
    },
     -- Drug
    {
        specific_name = "meth_b",
        name = "meth_b", -- ตรงกับชื่อไอเทม name db
        label = "เมทแอมเฟตามีน",
        type = "general",
        currency = "black_money",
        category = "drug",
        label_category = "ยาเสพติด",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "meth_a", -- ตรงกับชื่อไอเทม name db
                label = "ไอซ์แพ็ค",
                type = "general",
                quantity = 1,
            },
            {
                name = "amp_b", -- ตรงกับชื่อไอเทม name db
                label = "แอมป์ฟ้า",
                type = "general",
                quantity = 1,
            },
        },
        status = true,
        once_require = true, -- true ถ้าหากต้องการใช้แค่อย่างใดอย่างนึงใน req item
        req = {
             {
                 req_name = "card_gang",
                 req_label = "บัตรแก๊ง",
             },
             {
                 req_name = "card_family",
                 req_label = "บัตรครอบครัว",
             },
        },
    },
    {
        specific_name = "heroine",
        name = "heroine", -- ตรงกับชื่อไอเทม name db
        label = "แป๊ะ",
        type = "general",
        currency = "black_money",
        category = "drug",
        label_category = "ยาเสพติด",
        max_quantity = 10, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 100,
        material = {
            {
                name = "meth_a", -- ตรงกับชื่อไอเทม name db
                label = "ไอซ์แพ็ค",
                type = "general",
                quantity = 1,
            },
            {
                name = "cocaine_2", -- ตรงกับชื่อไอเทม name db
                label = "โคเคนแพ็ค",
                type = "general",
                quantity = 1,
            },
            {
                name = "amp_r", -- ตรงกับชื่อไอเทม name db
                label = "แอมป์แดง",
                type = "general",
                quantity = 1,
            },
            {
                name = "amp_g", -- ตรงกับชื่อไอเทม name db
                label = "แอมป์เขียว",
                type = "general",
                quantity = 1,
            },
        },
        status = true,
        once_require = true, -- true ถ้าหากต้องการใช้แค่อย่างใดอย่างนึงใน req item
        req = {
             {
                 req_name = "card_gang",
                 req_label = "บัตรแก๊ง",
             },
             {
                 req_name = "card_family",
                 req_label = "บัตรครอบครัว",
             },
        },
    },
     -- Gun Parts
    {
        specific_name = "revolver_1",
        name = "revolver_1", -- ตรงกับชื่อไอเทม name db
        label = "Cylinder",
        type = "general",
        currency = "black_money",
        category = "gun",
        label_category = "ชิ้นส่วนปืน",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.75, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 1000,
        material = {
            {
                name = "gun_pin", -- ตรงกับชื่อไอเทม name db
                label = "Pin",
                type = "general",
                quantity = 1,
            },
            {
                name = "gold_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแท่ง",
                type = "general",
                quantity = 100,
            },
            {
                name = "steel_2", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 200,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 20,
            },
        },
        status = true,
        play_sound = true,
        req = {
            {
                req_name = "key_gang",
                req_label = "กุญแจมงคล",
            },
        },
    },
    {
        specific_name = "revolver_2",
        name = "revolver_2", -- ตรงกับชื่อไอเทม name db
        label = "Grip",
        type = "general",
        currency = "black_money",
        category = "gun",
        label_category = "ชิ้นส่วนปืน",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.75, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 1000,
        material = {
            {
                name = "gun_barrel", -- ตรงกับชื่อไอเทม name db
                label = "Barrel",
                type = "general",
                quantity = 1,
            },
            {
                name = "gold_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแท่ง",
                type = "general",
                quantity = 100,
            },
            {
                name = "steel_2", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 200,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 20,
            },
        },
        status = true,
        play_sound = true,
        req = {
            {
                req_name = "key_gang",
                req_label = "กุญแจมงคล",
            },
        },
    },
    {
        specific_name = "revolver_3",
        name = "revolver_3", -- ตรงกับชื่อไอเทม name db
        label = "Trigger",
        type = "general",
        currency = "black_money",
        category = "gun",
        label_category = "ชิ้นส่วนปืน",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.75, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 1000,
        material = {
            {
                name = "gun_spring", -- ตรงกับชื่อไอเทม name db
                label = "Spring",
                type = "general",
                quantity = 1,
            },
            {
                name = "gold_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแท่ง",
                type = "general",
                quantity = 100,
            },
            {
                name = "steel_2", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 200,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 20,
            },
        },
        status = true,
        play_sound = true,
        req = {
            {
                req_name = "key_gang",
                req_label = "กุญแจมงคล",
            },
        },
    },
    {
        specific_name = "gun_screw",
        name = "gun_screw", -- ตรงกับชื่อไอเทม name db
        label = "Screw",
        type = "general",
        currency = "black_money",
        category = "gun",
        label_category = "ชิ้นส่วนปืน",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.75, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 1000,
        material = {
            {
                name = "gold_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแท่ง",
                type = "general",
                quantity = 100,
            },
            {
                name = "steel_2", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 200,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 20,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 20,
            },
        },
        status = true,
        play_sound = true,
        req = {
            {
                req_name = "key_gang",
                req_label = "กุญแจมงคล",
            },
        },
    },
    {
        specific_name = "gun_permit",
        name = "gun_permit", -- ตรงกับชื่อไอเทม name db
        label = "Gun Permit",
        type = "general",
        currency = "black_money",
        category = "gun",
        label_category = "ชิ้นส่วนปืน",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.75, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 1000,
        material = {
            {
                name = "wood_2", -- ตรงกับชื่อไอเทม name db
                label = "ไม้แท่ง",
                type = "general",
                quantity = 100,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 20,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 20,
            },
        },
        status = true,
        play_sound = true,
        req = {
            {
                req_name = "key_gang",
                req_label = "กุญแจมงคล",
            },
        },
    },
    {
        specific_name = "gun_sight",
        name = "gun_sight", -- ตรงกับชื่อไอเทม name db
        label = "Gun Sight",
        type = "general",
        currency = "black_money",
        category = "gun",
        label_category = "ชิ้นส่วนปืน",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 1000,
        material = {
            {
                name = "alloy", -- ตรงกับชื่อไอเทม name db
                label = "อัลลอย",
                type = "general",
                quantity = 5,
            },
            {
                name = "gold_2", -- ตรงกับชื่อไอเทม name db
                label = "ทองแท่ง",
                type = "general",
                quantity = 100,
            },
            {
                name = "steel_2", -- ตรงกับชื่อไอเทม name db
                label = "เหล็กแท่ง",
                type = "general",
                quantity = 200,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 20,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 20,
            },
        },
        status = true,
        req = {
            {
                req_name = "key_gang",
                req_label = "กุญแจมงคล",
            },
        },
    },
    {
        specific_name = "gun_mold",
        name = "gun_mold", -- ตรงกับชื่อไอเทม name db
        label = "Gun Mold",
        type = "general",
        currency = "black_money",
        category = "gun",
        label_category = "ชิ้นส่วนปืน",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 5, -- หน่วยเป็นวินาที
        price = 1000,
        material = {
            {
                name = "wood_2", -- ตรงกับชื่อไอเทม name db
                label = "ไม้แท่ง",
                type = "general",
                quantity = 300,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 100,
            },
        },
        status = true,
        req = {
            {
                req_name = "key_gang",
                req_label = "กุญแจมงคล",
            },
        },
    },
}