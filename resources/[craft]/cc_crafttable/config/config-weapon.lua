-- ░█──░█ ░█▀▀▀ ─█▀▀█ ░█▀▀█ ░█▀▀▀█ ░█▄─░█  ▀▀█▀▀ ─█▀▀█ ░█▀▀█ ░█─── ░█▀▀▀ --
-- ░█░█░█ ░█▀▀▀ ░█▄▄█ ░█▄▄█ ░█──░█ ░█░█░█  ─░█── ░█▄▄█ ░█▀▀▄ ░█─── ░█▀▀▀ --
-- ░█▄▀▄█ ░█▄▄▄ ░█─░█ ░█─── ░█▄▄▄█ ░█──▀█  ─░█── ░█─░█ ░█▄▄█ ░█▄▄█ ░█▄▄▄ --
weapon_table = {
    -- Protect
    {
        specific_name = "pt_all",
        name = "pt_all", -- ตรงกับชื่อไอเทม name db
        label = "บัตรประกันอาวุธ",
        type = "general",
        currency = "money",
        category = "protect",
        label_category = "บัตรประกัน",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 50000,
        material = {
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 50,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    -- Bat
    {
        specific_name = "weapon_bat_1h",
        name = "WEAPON_BAT_1H", -- ตรงกับชื่อไอเทม name db
        label = "ไม้เบสบอล Lv.1",
        type = "weapon",
        currency = "money",
        category = "bat",
        label_category = "ไม้เบสบอล",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 5000,
        material = {
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
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
        specific_name = "weapon_bat_1h_2",
        name = "WEAPON_BAT_1H_2", -- ตรงกับชื่อไอเทม name db
        label = "ไม้เบสบอล Lv.2",
        type = "weapon",
        currency = "money",
        category = "bat",
        label_category = "ไม้เบสบอล",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.75, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_BAT_1H", -- ตรงกับชื่อไอเทม name db
                label = "ไม้เบสบอล Lv.1",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 10,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 10000,
        material = {
            {
                name = "WEAPON_BAT_1H", -- ตรงกับชื่อไอเทม name db
                label = "ไม้เบสบอล Lv.1",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 1,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 10,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 30,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_bat",
        name = "WEAPON_BAT", -- ตรงกับชื่อไอเทม name db
        label = "ไม้เบสบอล Lv.3",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "bat",
        label_category = "ไม้เบสบอล",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.5, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_BAT_1H", -- ตรงกับชื่อไอเทม name db
                label = "ไม้เบสบอล Lv.1",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_broken = true, --เปิดใช้กันแตก
        protect_broken_items = {
            {
                name = "heart_100", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 100%",
                protect_percent = 1.0,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_90", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 90%",
                protect_percent = 0.9,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_70", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 70%",
                protect_percent = 0.7,
                type = "general",
                quantity = 1,
            },
        },
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 15,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 20000, 10000 },
        material = {
            {
                name = "WEAPON_BAT_1H_2", -- ตรงกับชื่อไอเทม name db
                label = "ไม้เบสบอล Lv.2",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 1,
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
                quantity = 60,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    -- Golfclub
    {
        specific_name = "weapon_golfclub_1h",
        name = "WEAPON_GOLFCLUB_1H", -- ตรงกับชื่อไอเทม name db
        label = "ไม้กอล์ฟ Lv.1",
        type = "weapon",
        currency = "money",
        category = "golfclub",
        label_category = "ไม้กอล์ฟ",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 5000,
        material = {
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
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
        specific_name = "weapon_golfclub_1h_2",
        name = "WEAPON_GOLFCLUB_1H_2", -- ตรงกับชื่อไอเทม name db
        label = "ไม้กอล์ฟ Lv.2",
        type = "weapon",
        currency = "money",
        category = "golfclub",
        label_category = "ไม้กอล์ฟ",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.75, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_GOLFCLUB_1H", -- ตรงกับชื่อไอเทม name db
                label = "ไม้กอล์ฟ Lv.1",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 10,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 10000,
        material = {
            {
                name = "WEAPON_GOLFCLUB_1H", -- ตรงกับชื่อไอเทม name db
                label = "ไม้กอล์ฟ Lv.1",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 1,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 10,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 30,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_golfclub",
        name = "WEAPON_GOLFCLUB", -- ตรงกับชื่อไอเทม name db
        label = "ไม้กอล์ฟ Lv.3",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "golfclub",
        label_category = "ไม้กอล์ฟ",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.5, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_GOLFCLUB_1H", -- ตรงกับชื่อไอเทม name db
                label = "ไม้กอล์ฟ Lv.1",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_broken = true, --เปิดใช้กันแตก
        protect_broken_items = {
            {
                name = "heart_100", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 100%",
                protect_percent = 1.0,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_90", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 90%",
                protect_percent = 0.9,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_70", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 70%",
                protect_percent = 0.7,
                type = "general",
                quantity = 1,
            },
        },
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 15,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 20000, 10000 },
        material = {
            {
                name = "WEAPON_GOLFCLUB_1H_2", -- ตรงกับชื่อไอเทม name db
                label = "ไม้กอล์ฟ Lv.2",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 1,
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
                quantity = 60,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    -- Knuckle
    {
        specific_name = "weapon_knuckle",
        name = "WEAPON_KNUCKLE", -- ตรงกับชื่อไอเทม name db
        label = "สนับมือ Lv.1",
        type = "weapon",
        currency = "money",
        category = "knuckle",
        label_category = "สนับมือ",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 1.0, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 5000,
        material = {
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
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
        specific_name = "weapon_knuckle_2",
        name = "WEAPON_KNUCKLE_2", -- ตรงกับชื่อไอเทม name db
        label = "สนับมือ Lv.2",
        type = "weapon",
        currency = "money",
        category = "knuckle",
        label_category = "สนับมือ",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.75, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_KNUCKLE", -- ตรงกับชื่อไอเทม name db
                label = "สนับมือ Lv.1",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 10,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = 10000,
        material = {
            {
                name = "WEAPON_KNUCKLE", -- ตรงกับชื่อไอเทม name db
                label = "สนับมือ Lv.1",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 1,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 10,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 30,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_knuckle_3",
        name = "WEAPON_KNUCKLE_3", -- ตรงกับชื่อไอเทม name db
        label = "สนับมือ Lv.3",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "knuckle",
        label_category = "สนับมือ",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.5, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_KNUCKLE", -- ตรงกับชื่อไอเทม name db
                label = "สนับมือ Lv.1",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_broken = true, --เปิดใช้กันแตก
        protect_broken_items = {
            {
                name = "heart_100", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 100%",
                protect_percent = 1.0,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_90", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 90%",
                protect_percent = 0.9,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_70", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 70%",
                protect_percent = 0.7,
                type = "general",
                quantity = 1,
            },
        },
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 15,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 20000, 10000 },
        material = {
            {
                name = "WEAPON_KNUCKLE_2", -- ตรงกับชื่อไอเทม name db
                label = "สนับมือ Lv.2",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 1,
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
                quantity = 60,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_knuckle_4",
        name = "WEAPON_KNUCKLE_4", -- ตรงกับชื่อไอเทม name db
        label = "สนับมือ Lv.4",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "knuckle",
        label_category = "สนับมือ",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.25, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_KNUCKLE_2", -- ตรงกับชื่อไอเทม name db
                label = "สนับมือ Lv.2",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_broken = true, --เปิดใช้กันแตก
        protect_broken_items = {
            {
                name = "heart_100", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 100%",
                protect_percent = 1.0,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_90", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 90%",
                protect_percent = 0.9,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_70", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 70%",
                protect_percent = 0.7,
                type = "general",
                quantity = 1,
            },
        },
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 25,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 30000, 10000 },
        material = {
            {
                name = "WEAPON_KNUCKLE_3", -- ตรงกับชื่อไอเทม name db
                label = "สนับมือ Lv.3",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 1,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 30,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 100,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_knuckle_5",
        name = "WEAPON_KNUCKLE_5", -- ตรงกับชื่อไอเทม name db
        label = "สนับมือ Lv.5",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "knuckle",
        label_category = "สนับมือ",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.1, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_KNUCKLE_3", -- ตรงกับชื่อไอเทม name db
                label = "สนับมือ Lv.3",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_broken = true, --เปิดใช้กันแตก
        protect_broken_items = {
            {
                name = "heart_100", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 100%",
                protect_percent = 1.0,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_90", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 90%",
                protect_percent = 0.9,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_70", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 70%",
                protect_percent = 0.7,
                type = "general",
                quantity = 1,
            },
        },
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
        price = { 30000, 10000 },
        material = {
            {
                name = "WEAPON_KNUCKLE_4", -- ตรงกับชื่อไอเทม name db
                label = "สนับมือ Lv.4",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 1,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 40,
            },
            {
                name = "alloy", -- ตรงกับชื่อไอเทม name db
                label = "อัลลอย",
                type = "general",
                quantity = 1,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 120,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    -- Machete
    {
        specific_name = "weapon_machete",
        name = "WEAPON_MACHETE", -- ตรงกับชื่อไอเทม name db
        label = "มาเชเต้ Lv.1",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "machete",
        label_category = "มาเชเต้",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.75, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 25,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 10000, 10000 },
        material = {
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 2,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 10,
            },
            {
                name = "alloy", -- ตรงกับชื่อไอเทม name db
                label = "อัลลอย",
                type = "general",
                quantity = 5,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 30,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_machete_2",
        name = "WEAPON_MACHETE_2", -- ตรงกับชื่อไอเทม name db
        label = "มาเชเต้ Lv.2",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "machete",
        label_category = "มาเชเต้",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.5, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_MACHETE", -- ตรงกับชื่อไอเทม name db
                label = "มาเชเต้ Lv.1",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 10,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 20000, 10000 },
        material = {
            {
                name = "WEAPON_MACHETE", -- ตรงกับชื่อไอเทม name db
                label = "มาเชเต้ Lv.1",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 2,
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
                quantity = 60,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_machete_3",
        name = "WEAPON_MACHETE_3", -- ตรงกับชื่อไอเทม name db
        label = "มาเชเต้ Lv.3",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "machete",
        label_category = "มาเชเต้",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.25, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_MACHETE", -- ตรงกับชื่อไอเทม name db
                label = "มาเชเต้ Lv.1",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_broken = true, --เปิดใช้กันแตก
        protect_broken_items = {
            {
                name = "heart_100", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 100%",
                protect_percent = 1.0,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_90", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 90%",
                protect_percent = 0.9,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_70", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 70%",
                protect_percent = 0.7,
                type = "general",
                quantity = 1,
            },
        },
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 15,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 30000, 10000 },
        material = {
            {
                name = "WEAPON_MACHETE_2", -- ตรงกับชื่อไอเทม name db
                label = "มาเชเต้ Lv.2",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 2,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 30,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 100,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    -- Bottle
    {
        specific_name = "weapon_bottle",
        name = "WEAPON_BOTTLE", -- ตรงกับชื่อไอเทม name db
        label = "ปากฉลาม Lv.1",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "bottle",
        label_category = "ปากฉลาม",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.75, -- 0.9 = 90%
        failed_items = nil, -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 25,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 10000, 10000 },
        material = {
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 2,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 10,
            },
            {
                name = "alloy", -- ตรงกับชื่อไอเทม name db
                label = "อัลลอย",
                type = "general",
                quantity = 5,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 30,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_bottle_2",
        name = "WEAPON_BOTTLE_2", -- ตรงกับชื่อไอเทม name db
        label = "ปากฉลาม Lv.2",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "bottle",
        label_category = "ปากฉลาม",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.5, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_BOTTLE", -- ตรงกับชื่อไอเทม name db
                label = "ปากฉลาม Lv.1",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 10,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 20000, 10000 },
        material = {
            {
                name = "WEAPON_BOTTLE", -- ตรงกับชื่อไอเทม name db
                label = "ปากฉลาม Lv.1",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 2,
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
                quantity = 60,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_bottle_3",
        name = "WEAPON_BOTTLE_3", -- ตรงกับชื่อไอเทม name db
        label = "ปากฉลาม Lv.3",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "bottle",
        label_category = "ปากฉลาม",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.25, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_BOTTLE", -- ตรงกับชื่อไอเทม name db
                label = "ปากฉลาม Lv.1",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_broken = true, --เปิดใช้กันแตก
        protect_broken_items = {
            {
                name = "heart_100", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 100%",
                protect_percent = 1.0,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_90", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 90%",
                protect_percent = 0.9,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_70", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 70%",
                protect_percent = 0.7,
                type = "general",
                quantity = 1,
            },
        },
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 15,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 30000, 10000 },
        material = {
            {
                name = "WEAPON_BOTTLE_2", -- ตรงกับชื่อไอเทม name db
                label = "ปากฉลาม Lv.2",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 2,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 30,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 100,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    -- Knife
    {
        specific_name = "weapon_knife",
        name = "WEAPON_KNIFE", -- ตรงกับชื่อไอเทม name db
        label = "Knife Lv.1",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "knife",
        label_category = "Knife",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.5, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_BOTTLE_3", -- ตรงกับชื่อไอเทม name db
                label = "ปากฉลาม Lv.3",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
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
        price = { 10000, 10000 },
        material = {
            {
                name = "WEAPON_BOTTLE_3", -- ตรงกับชื่อไอเทม name db
                label = "ปากฉลาม Lv.3",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 3,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 30,
            },
            {
                name = "alloy", -- ตรงกับชื่อไอเทม name db
                label = "อัลลอย",
                type = "general",
                quantity = 10,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 50,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_knife_2",
        name = "WEAPON_KNIFE_2", -- ตรงกับชื่อไอเทม name db
        label = "Knife Lv.2",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "knife",
        label_category = "Knife",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.25, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_KNIFE", -- ตรงกับชื่อไอเทม name db
                label = "Knife Lv.1",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 15,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 30000, 10000 },
        material = {
            {
                name = "WEAPON_KNIFE", -- ตรงกับชื่อไอเทม name db
                label = "Knife",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 3,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 40,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 100,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_knife_3",
        name = "WEAPON_KNIFE_3", -- ตรงกับชื่อไอเทม name db
        label = "Knife Lv.3",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "knife",
        label_category = "Knife",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.1, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_KNIFE", -- ตรงกับชื่อไอเทม name db
                label = "Knife Lv.1",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_broken = true, --เปิดใช้กันแตก
        protect_broken_items = {
            {
                name = "heart_100", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 100%",
                protect_percent = 1.0,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_90", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 90%",
                protect_percent = 0.9,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_70", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 70%",
                protect_percent = 0.7,
                type = "general",
                quantity = 1,
            },
        },
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 25,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 50000, 10000 },
        material = {
            {
                name = "WEAPON_KNIFE_2", -- ตรงกับชื่อไอเทม name db
                label = "Knife Lv.2",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 3,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 50,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 120,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    -- Dagger
    {
        specific_name = "weapon_dagger",
        name = "WEAPON_DAGGER", -- ตรงกับชื่อไอเทม name db
        label = "Dagger Lv.1",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "dagger",
        label_category = "Dagger",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.5, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_BOTTLE_3", -- ตรงกับชื่อไอเทม name db
                label = "ปากฉลาม Lv.3",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
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
        price = { 10000, 10000 },
        material = {
            {
                name = "WEAPON_BOTTLE_3", -- ตรงกับชื่อไอเทม name db
                label = "ปากฉลาม Lv.3",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 3,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 30,
            },
            {
                name = "alloy", -- ตรงกับชื่อไอเทม name db
                label = "อัลลอย",
                type = "general",
                quantity = 10,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 50,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_dagger_2",
        name = "WEAPON_DAGGER_2", -- ตรงกับชื่อไอเทม name db
        label = "Dagger Lv.2",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "dagger",
        label_category = "Dagger",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.25, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_DAGGER", -- ตรงกับชื่อไอเทม name db
                label = "Dagger Lv.1",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 15,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 30000, 10000 },
        material = {
            {
                name = "WEAPON_DAGGER", -- ตรงกับชื่อไอเทม name db
                label = "Dagger Lv.1",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 3,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 40,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 100,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_dagger_3",
        name = "WEAPON_DAGGER_3", -- ตรงกับชื่อไอเทม name db
        label = "Dagger Lv.3",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "dagger",
        label_category = "Dagger",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.1, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_DAGGER", -- ตรงกับชื่อไอเทม name db
                label = "Dagger Lv.1",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_broken = true, --เปิดใช้กันแตก
        protect_broken_items = {
            {
                name = "heart_100", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 100%",
                protect_percent = 1.0,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_90", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 90%",
                protect_percent = 0.9,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_70", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 70%",
                protect_percent = 0.7,
                type = "general",
                quantity = 1,
            },
        },
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 25,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 50000, 10000 },
        material = {
            {
                name = "WEAPON_DAGGER_2", -- ตรงกับชื่อไอเทม name db
                label = "Dagger Lv.2",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 3,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 50,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 120,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    -- Poolcue
    {
        specific_name = "weapon_poolcue_b",
        name = "WEAPON_POOLCUE", -- ตรงกับชื่อไอเทม name db
        label = "ไม้พูล Lv.1",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "poolcue",
        label_category = "ไม้พูล",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.5, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_BAT", -- ตรงกับชื่อไอเทม name db
                label = "ไม้เบสบอล Lv.3",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
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
        price = { 10000, 10000 },
        material = {
            {
                name = "WEAPON_BAT", -- ตรงกับชื่อไอเทม name db
                label = "ไม้เบสบอล Lv.3",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 3,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 30,
            },
            {
                name = "alloy", -- ตรงกับชื่อไอเทม name db
                label = "อัลลอย",
                type = "general",
                quantity = 10,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 50,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_poolcue_g",
        name = "WEAPON_POOLCUE", -- ตรงกับชื่อไอเทม name db
        label = "ไม้พูล Lv.1",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "poolcue",
        label_category = "ไม้พูล",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.5, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_GOLFCLUB", -- ตรงกับชื่อไอเทม name db
                label = "ไม้กอล์ฟ Lv.3",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
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
        price = { 10000, 10000 },
        material = {
            {
                name = "WEAPON_GOLFCLUB", -- ตรงกับชื่อไอเทม name db
                label = "ไม้กอล์ฟ Lv.3",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 3,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 30,
            },
            {
                name = "alloy", -- ตรงกับชื่อไอเทม name db
                label = "อัลลอย",
                type = "general",
                quantity = 10,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 50,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_poolcue_2",
        name = "WEAPON_POOLCUE_2", -- ตรงกับชื่อไอเทม name db
        label = "ไม้พูล Lv.2",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "poolcue",
        label_category = "ไม้พูล",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.25, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_POOLCUE", -- ตรงกับชื่อไอเทม name db
                label = "ไม้พูล Lv.1",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 15,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 30000, 10000 },
        material = {
            {
                name = "WEAPON_POOLCUE", -- ตรงกับชื่อไอเทม name db
                label = "ไม้พูล",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 3,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 40,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 100,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_poolcue_3",
        name = "WEAPON_POOLCUE_3", -- ตรงกับชื่อไอเทม name db
        label = "ไม้พูล Lv.3",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "poolcue",
        label_category = "ไม้พูล",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.1, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_POOLCUE", -- ตรงกับชื่อไอเทม name db
                label = "ไม้พูล Lv.1",
                type = "weapon",
                quantity = 1,
            }
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_broken = true, --เปิดใช้กันแตก
        protect_broken_items = {
            {
                name = "heart_100", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 100%",
                protect_percent = 1.0,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_90", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 90%",
                protect_percent = 0.9,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_70", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 70%",
                protect_percent = 0.7,
                type = "general",
                quantity = 1,
            },
        },
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 25,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 50000, 10000 },
        material = {
            {
                name = "WEAPON_POOLCUE_2", -- ตรงกับชื่อไอเทม name db
                label = "ไม้พูล Lv.2",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 3,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 50,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 120,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    -- Revolver
    {
        specific_name = "WEAPON_REVOLVER_V1",
        name = "WEAPON_REVOLVER_V1", -- ตรงกับชื่อไอเทม name db
        label = "Revolver Mk.I",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "revolver",
        label_category = "ปืน",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.8, -- 0.9 = 90%
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
        price = { 50000, 50000 },
        material = {
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 10,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 50,
            },
            {
                name = "alloy", -- ตรงกับชื่อไอเทม name db
                label = "อัลลอย",
                type = "general",
                quantity = 10,
            },
            {
                name = "revolver_1", -- ตรงกับชื่อไอเทม name db
                label = "Cylinder",
                type = "general",
                quantity = 1,
            },
            {
                name = "revolver_2", -- ตรงกับชื่อไอเทม name db
                label = "Grip",
                type = "general",
                quantity = 1,
            },
            {
                name = "revolver_3", -- ตรงกับชื่อไอเทม name db
                label = "Trigger",
                type = "general",
                quantity = 1,
            },
            {
                name = "gun_screw", -- ตรงกับชื่อไอเทม name db
                label = "Screw",
                type = "general",
                quantity = 1,
            },
            {
                name = "gun_mold", -- ตรงกับชื่อไอเทม name db
                label = "Gun Mold",
                type = "general",
                quantity = 1,
            },
            {
                name = "gun_sight", -- ตรงกับชื่อไอเทม name db
                label = "Gun Sight",
                type = "general",
                quantity = 1,
            },
            {
                name = "gun_permit", -- ตรงกับชื่อไอเทม name db
                label = "Gun Permit",
                type = "general",
                quantity = 1,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 100,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "WEAPON_REVOLVER_V2",
        name = "WEAPON_REVOLVER_V2", -- ตรงกับชื่อไอเทม name db
        label = "Revolver Mk.II",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "revolver",
        label_category = "ปืน",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.6, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_REVOLVER_V1", -- ตรงกับชื่อไอเทม name db
                label = "Revolver MK.I",
                type = "weapon",
                quantity = 1,
            },
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        protect_broken = true, --เปิดใช้กันแตก
        protect_broken_items = {
            {
                name = "heart_100", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 100%",
                protect_percent = 1.0,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_90", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 90%",
                protect_percent = 0.9,
                type = "general",
                quantity = 1,
            },
            {
                name = "heart_70", -- ตรงกับชื่อไอเทม name db
                label = "กันแตก 70%",
                protect_percent = 0.7,
                type = "general",
                quantity = 1,
            },
        },
        protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
        protect_remove_items = {
            {
                name = "cron", -- ตรงกับชื่อไอเทม name db
                label = "หินมงคล",
                type = "general",
                quantity = 100,
            },
        },
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 50000, 50000 },
        material = {
            {
                name = "WEAPON_REVOLVER_V1", -- ตรงกับชื่อไอเทม name db
                label = "Revolver Mk.I",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 10,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 50,
            },
            {
                name = "alloy", -- ตรงกับชื่อไอเทม name db
                label = "อัลลอย",
                type = "general",
                quantity = 10,
            },
            {
                name = "revolver_1", -- ตรงกับชื่อไอเทม name db
                label = "Cylinder",
                type = "general",
                quantity = 1,
            },
            {
                name = "revolver_2", -- ตรงกับชื่อไอเทม name db
                label = "Grip",
                type = "general",
                quantity = 1,
            },
            {
                name = "revolver_3", -- ตรงกับชื่อไอเทม name db
                label = "Trigger",
                type = "general",
                quantity = 1,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 200,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    -- {
    --     specific_name = "weapon_revolver_V3",
    --     name = "WEAPON_REVOLVER_V3", -- ตรงกับชื่อไอเทม name db
    --     label = "Revolver Mk.III",
    --     type = "weapon",
    --     currency = { "money", "black_money" },
    --     category = "revolver",
    --     label_category = "ปืน",
    --     max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
    --     success_rate = 0.3, -- 0.9 = 90%
    --     failed_items = {
    --         {
    --             name = "WEAPON_REVOLVER_V1", -- ตรงกับชื่อไอเทม name db
    --             label = "Revolver MK.I",
    --             type = "weapon",
    --             quantity = 1,
    --         },
    --         {
    --             name = "box_gunpart", -- ตรงกับชื่อไอเทม name db
    --             label = "กล่องสุ่มวัสดุปืน",
    --             type = "general",
    --             quantity = 1,
    --         }
    --     } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
    --     protect_broken = true, --เปิดใช้กันแตก
    --     protect_broken_items = {
    --         {
    --             name = "heart_100", -- ตรงกับชื่อไอเทม name db
    --             label = "กันแตก 100%",
    --             protect_percent = 1.0,
    --             type = "general",
    --             quantity = 1,
    --         },
    --         {
    --             name = "heart_90", -- ตรงกับชื่อไอเทม name db
    --             label = "กันแตก 90%",
    --             protect_percent = 0.9,
    --             type = "general",
    --             quantity = 1,
    --         },
    --         {
    --             name = "heart_70", -- ตรงกับชื่อไอเทม name db
    --             label = "กันแตก 70%",
    --             protect_percent = 0.7,
    --             type = "general",
    --             quantity = 1,
    --         },
    --     },
    --     protect_remove = true, -- เปิดใช้ไม่ลบไอเทม
    --     protect_remove_items = {
    --         {
    --             name = "cron", -- ตรงกับชื่อไอเทม name db
    --             label = "หินมงคล",
    --             type = "general",
    --             quantity = 150,
    --         },
    --     },
    --     crafting_time = 7, -- หน่วยเป็นวินาที
    --     price = { 100000, 100000 },
    --     material = {
    --         {
    --             name = "WEAPON_REVOLVER_V2", -- ตรงกับชื่อไอเทม name db
    --             label = "Revolver Mk.II",
    --             type = "weapon",
    --             quantity = 1,
    --         },
    --         {
    --             name = "weapon_box", -- ตรงกับชื่อไอเทม name db
    --             label = "กล่องตีอาวุธ",
    --             type = "general",
    --             quantity = 10,
    --         },
    --         {
    --             name = "diamond", -- ตรงกับชื่อไอเทม name db
    --             label = "เพชร",
    --             type = "general",
    --             quantity = 50,
    --         },
    --         {
    --             name = "alloy", -- ตรงกับชื่อไอเทม name db
    --             label = "อัลลอย",
    --             type = "general",
    --             quantity = 10,
    --         },
    --         {
    --             name = "revolver_1", -- ตรงกับชื่อไอเทม name db
    --             label = "Cylinder",
    --             type = "general",
    --             quantity = 1,
    --         },
    --         {
    --             name = "revolver_2", -- ตรงกับชื่อไอเทม name db
    --             label = "Grip",
    --             type = "general",
    --             quantity = 1,
    --         },
    --         {
    --             name = "revolver_3", -- ตรงกับชื่อไอเทม name db
    --             label = "Trigger",
    --             type = "general",
    --             quantity = 1,
    --         },
    --         {
    --             name = "exp", -- ตรงกับชื่อไอเทม name db
    --             label = "EXP",
    --             type = "general",
    --             quantity = 300,
    --         },
    --     },
    --     status = true,
    --     play_sound = true,
    --     req = {
    --     },
    -- },

    -- top-tier
    {
        specific_name = "weapon_gutknifegold_knife",
        name = "WEAPON_GUTKNIFELPGOLD", -- ตรงกับชื่อไอเทม name db
        label = "มีดเทพ",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "toptier",
        label_category = "Top-Tier",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.03, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_KNIFE_3", -- ตรงกับชื่อไอเทม name db
                label = "Knife Lv.3",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "coin_unlucky", -- ตรงกับชื่อไอเทม name db
                label = "ชิปหาย",
                type = "general",
                quantity = 1,
            },
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
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
        price = { 100000, 100000 },
        material = {
            {
                name = "WEAPON_KNIFE_3", -- ตรงกับชื่อไอเทม name db
                label = "Knife Lv.3",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 20,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 100,
            },
            {
                name = "alloy", -- ตรงกับชื่อไอเทม name db
                label = "อัลลอย",
                type = "general",
                quantity = 20,
            },
            {
                name = "microchip", -- ตรงกับชื่อไอเทม name db
                label = "ไมโครชิพ",
                type = "general",
                quantity = 50,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 200,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_gutknifegold_dagger",
        name = "WEAPON_GUTKNIFELPGOLD", -- ตรงกับชื่อไอเทม name db
        label = "มีดเทพ",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "toptier",
        label_category = "Top-Tier",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.03, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_DAGGER_3", -- ตรงกับชื่อไอเทม name db
                label = "Dagger Lv.3",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "coin_unlucky", -- ตรงกับชื่อไอเทม name db
                label = "ชิปหาย",
                type = "general",
                quantity = 1,
            },
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
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
        price = { 100000, 100000 },
        material = {
            {
                name = "WEAPON_DAGGER_3", -- ตรงกับชื่อไอเทม name db
                label = "Dagger Lv.3",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 20,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 100,
            },
            {
                name = "alloy", -- ตรงกับชื่อไอเทม name db
                label = "อัลลอย",
                type = "general",
                quantity = 20,
            },
            {
                name = "microchip", -- ตรงกับชื่อไอเทม name db
                label = "ไมโครชิพ",
                type = "general",
                quantity = 50,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 200,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "weapon_knucklegold",
        name = "WEAPON_KNUCKLEGOLD", -- ตรงกับชื่อไอเทม name db
        label = "สนับมือเทพ",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "toptier",
        label_category = "Top-Tier",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.03, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_KNUCKLE_5", -- ตรงกับชื่อไอเทม name db
                label = "สนับมือ Lv.5",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "coin_unlucky", -- ตรงกับชื่อไอเทม name db
                label = "ชิปหาย",
                type = "general",
                quantity = 1,
            },
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
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
        price = { 100000, 100000 },
        material = {
            {
                name = "WEAPON_KNUCKLE_5", -- ตรงกับชื่อไอเทม name db
                label = "สนับมือ Lv.5",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "weapon_box", -- ตรงกับชื่อไอเทม name db
                label = "กล่องตีอาวุธ",
                type = "general",
                quantity = 20,
            },
            {
                name = "diamond", -- ตรงกับชื่อไอเทม name db
                label = "เพชร",
                type = "general",
                quantity = 100,
            },
            {
                name = "alloy", -- ตรงกับชื่อไอเทม name db
                label = "อัลลอย",
                type = "general",
                quantity = 20,
            },
            {
                name = "microchip", -- ตรงกับชื่อไอเทม name db
                label = "ไมโครชิพ",
                type = "general",
                quantity = 50,
            },
            {
                name = "exp", -- ตรงกับชื่อไอเทม name db
                label = "EXP",
                type = "general",
                quantity = 200,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },

    -- ชิปหาย

    {
        specific_name = "unlucky_gutknifegold_knife",
        name = "WEAPON_GUTKNIFELPGOLD", -- ตรงกับชื่อไอเทม name db
        label = "มีดเทพ",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "unlucky",
        label_category = "ชิปหาย",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.05, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_KNIFE_3", -- ตรงกับชื่อไอเทม name db
                label = "Knife Lv.3",
                type = "weapon",
                quantity = 1,
            },
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 100, 100 },
        material = {
            {
                name = "WEAPON_KNIFE_3", -- ตรงกับชื่อไอเทม name db
                label = "Knife Lv.3",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "coin_unlucky", -- ตรงกับชื่อไอเทม name db
                label = "ชิปหาย",
                type = "general",
                quantity = 10,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "unlucky_gutknifegold_dagger",
        name = "WEAPON_GUTKNIFELPGOLD", -- ตรงกับชื่อไอเทม name db
        label = "มีดเทพ",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "unlucky",
        label_category = "ชิปหาย",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.05, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_DAGGER_3", -- ตรงกับชื่อไอเทม name db
                label = "Dagger Lv.3",
                type = "weapon",
                quantity = 1,
            },
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 100, 100 },
        material = {
            {
                name = "WEAPON_DAGGER_3", -- ตรงกับชื่อไอเทม name db
                label = "Dagger Lv.3",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "coin_unlucky", -- ตรงกับชื่อไอเทม name db
                label = "ชิปหาย",
                type = "general",
                quantity = 10,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
    {
        specific_name = "unlucky_knucklegold",
        name = "WEAPON_KNUCKLEGOLD", -- ตรงกับชื่อไอเทม name db
        label = "สนับมือเทพ",
        type = "weapon",
        currency = { "money", "black_money" },
        category = "unlucky",
        label_category = "ชิปหาย",
        max_quantity = 1, -- จำนวนสูงสุดที่สามารถคราฟได้ต่อครั้ง
        success_rate = 0.05, -- 0.9 = 90%
        failed_items = {
            {
                name = "WEAPON_KNUCKLE_5", -- ตรงกับชื่อไอเทม name db
                label = "สนับมือ Lv.5",
                type = "weapon",
                quantity = 1,
            },
        } , -- กรณีมีไอเทมล้มเหลว "coin_unlucky" ไม่มีใส่ nil
        crafting_time = 7, -- หน่วยเป็นวินาที
        price = { 100, 100 },
        material = {
            {
                name = "WEAPON_KNUCKLE_5", -- ตรงกับชื่อไอเทม name db
                label = "สนับมือ Lv.5",
                type = "weapon",
                quantity = 1,
            },
            {
                name = "coin_unlucky", -- ตรงกับชื่อไอเทม name db
                label = "ชิปหาย",
                type = "general",
                quantity = 10,
            },
        },
        status = true,
        play_sound = true,
        req = {
        },
    },
}