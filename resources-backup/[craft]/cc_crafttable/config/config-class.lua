
class_table = {
    {
        specific_name = "card_merchant_2",
        name = "card_merchant_2", -- ตรงกับชื่อไอเทม name db
        label = "Circle Member 2",
        type = "general",
        currency = "money",
        category = "member",
        label_category = "สมาชิกสมาคม",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 10, -- หน่วยเป็นวินาที
        price = 100000,
        material = {
            {
                name = "card_merchant_1", -- ตรงกับชื่อไอเทม name db
                label = "Circle Member",
                type = "general",
                quantity = 1,
            },
            {
                name = "old_compass", -- ตรงกับชื่อไอเทม name db
                label = "เข็มทิศโบราณ",
                type = "general",
                quantity = 1,
            },
            {
                name = "old_cup", -- ตรงกับชื่อไอเทม name db
                label = "แก้วโบราณ",
                type = "general",
                quantity = 1,
            },
            {
                name = "old_lamp", -- ตรงกับชื่อไอเทม name db
                label = "ตะเกียงโบราณ",
                type = "general",
                quantity = 1,
            },
            {
                name = "old_anvil", -- ตรงกับชื่อไอเทม name db
                label = "ทั่งตีเหล็กโบราณ",
                type = "general",
                quantity = 1,
            },
            {
                name = "old_book", -- ตรงกับชื่อไอเทม name db
                label = "คำภีร์โบราณ",
                type = "general",
                quantity = 1,
            },
        },
        status = true,
        once_require = false, -- true ถ้าหากต้องการใช้แค่อย่างใดอย่างนึงใน req item
        req = {
        },
    },
    {
        specific_name = "card_merchant_3",
        name = "card_merchant_3", -- ตรงกับชื่อไอเทม name db
        label = "Circle Member 3",
        type = "general",
        currency = "money",
        category = "member",
        label_category = "สมาชิกสมาคม",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 10, -- หน่วยเป็นวินาที
        price = 150000,
        material = {
            {
                name = "card_merchant_2", -- ตรงกับชื่อไอเทม name db
                label = "Circle Member 2",
                type = "general",
                quantity = 1,
            },
            {
                name = "old_compass", -- ตรงกับชื่อไอเทม name db
                label = "เข็มทิศโบราณ",
                type = "general",
                quantity = 2,
            },
            {
                name = "old_cup", -- ตรงกับชื่อไอเทม name db
                label = "แก้วโบราณ",
                type = "general",
                quantity = 2,
            },
            {
                name = "old_lamp", -- ตรงกับชื่อไอเทม name db
                label = "ตะเกียงโบราณ",
                type = "general",
                quantity = 2,
            },
            {
                name = "old_anvil", -- ตรงกับชื่อไอเทม name db
                label = "ทั่งตีเหล็กโบราณ",
                type = "general",
                quantity = 2,
            },
            {
                name = "old_book", -- ตรงกับชื่อไอเทม name db
                label = "คำภีร์โบราณ",
                type = "general",
                quantity = 2,
            },
        },
        status = true,
        once_require = false, -- true ถ้าหากต้องการใช้แค่อย่างใดอย่างนึงใน req item
        req = {
        },

    },
    {
        specific_name = "card_merchant_4",
        name = "card_merchant_4", -- ตรงกับชื่อไอเทม name db
        label = "Circle Member 4",
        type = "general",
        currency = "money",
        category = "member",
        label_category = "สมาชิกสมาคม",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 10, -- หน่วยเป็นวินาที
        price = 200000,
        material = {
            {
                name = "card_merchant_3", -- ตรงกับชื่อไอเทม name db
                label = "Circle Member 3",
                type = "general",
                quantity = 1,
            },
            {
                name = "old_compass", -- ตรงกับชื่อไอเทม name db
                label = "เข็มทิศโบราณ",
                type = "general",
                quantity = 3,
            },
            {
                name = "old_cup", -- ตรงกับชื่อไอเทม name db
                label = "แก้วโบราณ",
                type = "general",
                quantity = 3,
            },
            {
                name = "old_lamp", -- ตรงกับชื่อไอเทม name db
                label = "ตะเกียงโบราณ",
                type = "general",
                quantity = 3,
            },
            {
                name = "old_anvil", -- ตรงกับชื่อไอเทม name db
                label = "ทั่งตีเหล็กโบราณ",
                type = "general",
                quantity = 3,
            },
            {
                name = "old_book", -- ตรงกับชื่อไอเทม name db
                label = "คำภีร์โบราณ",
                type = "general",
                quantity = 3,
            },
        },
        status = true,
        once_require = false, -- true ถ้าหากต้องการใช้แค่อย่างใดอย่างนึงใน req item
        req = {
        },
    },
    -- cart
    {
        specific_name = "cart_merchant_1",
        name = "cart_merchant_1", -- ตรงกับชื่อไอเทม name db
        label = "Cart",
        type = "general",
        currency = "money",
        category = "member",
        label_category = "สมาชิกสมาคม",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 10, -- หน่วยเป็นวินาที
        price = 20000,
        material = {
            {
               name = "box_steel", -- ตรงกับชื่อไอเทม name db
               label = "กล่องเหล็กแท่ง",
               type = "general",
               quantity = 10,
            },
            {
               name = "box_gold", -- ตรงกับชื่อไอเทม name db
               label = "กล่องทองแท่ง",
               type = "general",
               quantity = 2,
            },
            {
                name = "old_anvil", -- ตรงกับชื่อไอเทม name db
                label = "ทั่งตีเหล็กโบราณ",
                type = "general",
                quantity = 1,
            },
        },
        status = true,
        once_require = true, -- true ถ้าหากต้องการใช้แค่อย่างใดอย่างนึงใน req item
        req = {
            {
               req_name = "card_merchant_1",
               req_label = "Circle Member",
            },
            {
               req_name = "card_merchant_2",
               req_label = "Circle Member 2",
            },
            {
               req_name = "card_merchant_3",
               req_label = "Circle Member 3",
            },
            {
               req_name = "card_merchant_4",
               req_label = "Circle Member 4",
            },
        },

    },
    {
        specific_name = "cart_merchant_2",
        name = "cart_merchant_2", -- ตรงกับชื่อไอเทม name db
        label = "Cart 2",
        type = "general",
        currency = "money",
        category = "member",
        label_category = "สมาชิกสมาคม",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 10, -- หน่วยเป็นวินาที
        price = 30000,
        material = {
            {
                name = "cart_merchant_1", -- ตรงกับชื่อไอเทม name db
                label = "Cart",
                type = "general",
                quantity = 1,
            },
            {
                name = "box_steel", -- ตรงกับชื่อไอเทม name db
                label = "กล่องเหล็กแท่ง",
                type = "general",
                quantity = 20,
            },
            {
                name = "box_gold", -- ตรงกับชื่อไอเทม name db
                label = "กล่องทองแท่ง",
                type = "general",
                quantity = 4,
            },
            {
                name = "old_anvil", -- ตรงกับชื่อไอเทม name db
                label = "ทั่งตีเหล็กโบราณ",
                type = "general",
                quantity = 1,
            },
            {
                name = "old_book", -- ตรงกับชื่อไอเทม name db
                label = "คำภีร์โบราณ",
                type = "general",
                quantity = 1,
            },
        },
        status = true,
        once_require = true, -- true ถ้าหากต้องการใช้แค่อย่างใดอย่างนึงใน req item
        req = {
            {
                req_name = "card_merchant_1",
                req_label = "Circle Member",
            },
            {
                req_name = "card_merchant_2",
                req_label = "Circle Member 2",
            },
            {
                req_name = "card_merchant_3",
                req_label = "Circle Member 3",
            },
            {
                req_name = "card_merchant_4",
                req_label = "Circle Member 4",
            },
        },

     },
     {
        specific_name = "cart_merchant_3",
        name = "cart_merchant_3", -- ตรงกับชื่อไอเทม name db
        label = "Cart 3",
        type = "general",
        currency = "money",
        category = "member",
        label_category = "สมาชิกสมาคม",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 10, -- หน่วยเป็นวินาที
        price = 40000,
        material = {
            {
                name = "cart_merchant_2", -- ตรงกับชื่อไอเทม name db
                label = "Cart 2",
                type = "general",
                quantity = 1,
            },
            {
                name = "box_steel", -- ตรงกับชื่อไอเทม name db
                label = "กล่องเหล็กแท่ง",
                type = "general",
                quantity = 30,
            },
            {
                name = "box_gold", -- ตรงกับชื่อไอเทม name db
                label = "กล่องทองแท่ง",
                type = "general",
                quantity = 6,
            },
            {
                name = "old_compass", -- ตรงกับชื่อไอเทม name db
                label = "เข็มทิศโบราณ",
                type = "general",
                quantity = 1,
            },
            {
                name = "old_lamp", -- ตรงกับชื่อไอเทม name db
                label = "ตะเกียงโบราณ",
                type = "general",
                quantity = 1,
            },
        },
        status = true,
        once_require = true, -- true ถ้าหากต้องการใช้แค่อย่างใดอย่างนึงใน req item
        req = {
            {
                req_name = "card_merchant_1",
                req_label = "Circle Member",
            },
            {
                req_name = "card_merchant_2",
                req_label = "Circle Member 2",
            },
            {
                req_name = "card_merchant_3",
                req_label = "Circle Member 3",
            },
            {
                req_name = "card_merchant_4",
                req_label = "Circle Member 4",
            },
        },

     },
     {
        specific_name = "cart_merchant_4",
        name = "cart_merchant_4", -- ตรงกับชื่อไอเทม name db
        label = "Cart 4",
        type = "general",
        currency = "money",
        category = "member",
        label_category = "สมาชิกสมาคม",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 10, -- หน่วยเป็นวินาที
        price = 50000,
        material = {
            {
                name = "cart_merchant_3", -- ตรงกับชื่อไอเทม name db
                label = "Cart 3",
                type = "general",
                quantity = 1,
            },
            {
                name = "box_steel", -- ตรงกับชื่อไอเทม name db
                label = "กล่องเหล็กแท่ง",
                type = "general",
                quantity = 40,
            },
            {
                name = "box_gold", -- ตรงกับชื่อไอเทม name db
                label = "กล่องทองแท่ง",
                type = "general",
                quantity = 8,
            },
            {
                name = "old_anvil", -- ตรงกับชื่อไอเทม name db
                label = "ทั่งตีเหล็กโบราณ",
                type = "general",
                quantity = 1,
            },
            {
                name = "old_compass", -- ตรงกับชื่อไอเทม name db
                label = "เข็มทิศโบราณ",
                type = "general",
                quantity = 1,
            },
            {
                name = "old_cup", -- ตรงกับชื่อไอเทม name db
                label = "แก้วโบราณ",
                type = "general",
                quantity = 1,
            },
        },
        status = true,
        once_require = true, -- true ถ้าหากต้องการใช้แค่อย่างใดอย่างนึงใน req item
        req = {
            {
                req_name = "card_merchant_1",
                req_label = "Circle Member",
            },
            {
                req_name = "card_merchant_2",
                req_label = "Circle Member 2",
            },
            {
                req_name = "card_merchant_3",
                req_label = "Circle Member 3",
            },
            {
                req_name = "card_merchant_4",
                req_label = "Circle Member 4",
            },
        },

     },
}