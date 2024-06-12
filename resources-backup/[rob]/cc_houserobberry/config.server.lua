Config = {}

Config.keycard = { -- เรียงลำดับจากสิ่งที่อยากให้ใช้มากไปหาน้อย ลำดับต้องตรงกับ Config ไขตู้เซฟ
    {
        itemName = "keycard_red",
        getkeyName = "house_red",
    },
    {
        itemName = "keycard_gold",
        getkeyName = "house_gold",
    },
    {
        itemName = "keycard_silver",
        getkeyName = "house_silver",
    },
}

Config.HouseRobSafe = {
    {
        keyName = "house_red",
        getItem = {
            {
                itemName = "black_money", quantity = {3000, 5000},
            },
            {
                itemName = "meth_a", quantity = {1, 1}, 
            },
            {
                itemName = "vest", quantity = {3, 5}, 
            },
        },
        randomItem = { --สุ่มเปอร์เรียงอัน
            {
                itemName = "gun_barrel", quantity = 1, percent = 0.06
            },
            {
                itemName = "gun_pin", quantity = 1, percent = 0.06
            },
            {
                itemName = "gun_spring", quantity = 1, percent = 0.06
            },
            {
                itemName = "cron", quantity = 1, percent = 0.06
            },
        },
    },

    {
        keyName = "house_gold",
        getItem = {
            {
                itemName = "black_money", quantity = {2000, 4000},
            },
            {
                itemName = "meth_a", quantity = {1, 1}, 
            },
            {
                itemName = "vest", quantity = {2, 4}, 
            },
        },
        randomItem = { --สุ่มเปอร์เรียงอัน
            {
                itemName = "gun_barrel", quantity = 1, percent = 0.04
            },
            {
                itemName = "gun_pin", quantity = 1, percent = 0.04
            },
            {
                itemName = "gun_spring", quantity = 1, percent = 0.04
            },
        },
    },

    {
        keyName = "house_silver",
        getItem = {
            {
                itemName = "black_money", quantity = {1000, 3000},
            },
            {
                itemName = "meth_a", quantity = {1, 1}, 
            },
            {
                itemName = "vest", quantity = {1, 2}, 
            },
        },
        randomItem = { --สุ่มเปอร์เรียงอัน
            {
                itemName = "gun_barrel", quantity = 1, percent = 0.02
            },
            {
                itemName = "gun_pin", quantity = 1, percent = 0.02
            },
            {
                itemName = "gun_spring", quantity = 1, percent = 0.02
            },
        },
    },
}

Config.HouseRobSearch = {
    {
        itemName = "black_money", quantity = {1000, 1000}, percent = 1.0,
    },
    {
        itemName = "Phone", quantity = {1, 1}, percent = 1.0, 
    },
    {
        itemName = "cocaine_1", quantity = {1, 1}, percent = 1.0, 
    },
    {
        itemName = "meth_a", quantity = {1, 1}, percent = 1.0, 
    },
    {
        itemName = "vest", quantity = {1, 2}, percent = 1.0, 
    },
}