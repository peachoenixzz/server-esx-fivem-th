Config 						= {}

Config.ItemAllBox = {
    -- {
    --     name = "test", -- databse item name
    --     maxuse = 1, -- limit max use
    --     getItem = { -- ใส่ nil, หากไม่มีไอเทม
    --         {
    --             itemName = 'test', quantity = 100, type = "item",
    --         },
    --     },
    --     getItemBonus = { -- ใส่ nil, หากไม่มีโบนัสไอเทม
    --         {
    --         itemName = 'test', percent = 1.0, quantity = 1, type = "item",
    --         },
    --     }
    -- },

    {
        name = "weapon_box",
        maxuse = 1,
        getItem = {
            {
                itemName = 'cement', quantity = 5, type = "item",
            },
            {
                itemName = 'gold_2', quantity = 10, type = "item",
            },
            {
                itemName = 'steel_2', quantity = 20, type = "item",
            },
            {
                itemName = 'copper_2', quantity = 15, type = "item",
            },
            {
                itemName = 'wood_2', quantity = 15, type = "item",
            },
        },
        getItemBonus = nil,
    },
    {
        name = "box_cement",
        maxuse = 1,
        getItem = {
            {
                itemName = 'cement', quantity = 100, type = "item",
            },
        },
        getItemBonus = nil,
    },
    {
        name = "box_diamond",
        maxuse = 1,
        getItem = {
            {
                itemName = 'diamond', quantity = 100, type = "item",
            },
        },
        getItemBonus = nil,
    },
    {
        name = "box_ruby",
        maxuse = 1,
        getItem = {
            {
                itemName = 'ruby', quantity = 100, type = "item",
            },
        },
        getItemBonus = nil,
    },
    {
        name = "box_wood",
        maxuse = 1,
        getItem = {
            {
                itemName = 'wood_2', quantity = 100, type = "item",
            },
        },
        getItemBonus = nil,
    },
    {
        name = "box_copper",
        maxuse = 1,
        getItem = {
            {
                itemName = 'copper_2', quantity = 100, type = "item",
            },
        },
        getItemBonus = nil,
    },
    {
        name = "box_steel",
        maxuse = 1,
        getItem = {
            {
                itemName = 'steel_2', quantity = 100, type = "item",
            },
        },
        getItemBonus = nil,
    },
    {
        name = "box_gold",
        maxuse = 1,
        getItem = {
            {
                itemName = 'gold_2', quantity = 100, type = "item",
            },
        },
        getItemBonus = nil,
    },
    {
        name = "fight_pack",
        maxuse = 1,
        getItem = {
            {
                itemName = 'aed', quantity = 3, type = "item",
            },
            {
                itemName = 'painkiller', quantity = 20, type = "item",
            },
            {
                itemName = 'vest', quantity = 20, type = "item",
            },
        },
        getItemBonus = nil,
    },

}