Config = {}

Config.FishingInfoServer = {
    {
        name = "normal_fishing_zone",
        useItemRod = {
            itemName = "fishing_rod",
            itemCount = 1,
            brokenRate = 0.03,
            brokenRateFail = 0.05,
        },
        useItemBait = {
            itemName = "fishing_bait",
            itemCount = 1,
        },

        useitemSpecial = {
            enable = false,
            itemName = nil,
            itemCount = nil,
            brokenRate = nil,
            brokenRateFail = nil,
        },

        jobBuff = true,

        getItem = {
            {
                itemName = "fish_1",
                percent = 1.0,
                quantity = {1, 2}
            },
            {
                itemName = "fish_2", 
                percent = 1.0,
                quantity = {1, 2}
            },
            {
                itemName = "fish_3", 
                percent = 1.0,
                quantity = {1, 2}
            },
        },

        getItemBonus = {
            {
                itemName = "amp_g", 
                percent = 0.10,
                quantity = {1, 1}
            },
            {
                itemName = "exp", 
                percent = 0.05,
                quantity = {1, 1}
            },
            {
                itemName = "bonus_eco",
                percent = 0.01,
                quantity = {1, 1}
            },
        },
    },

    -- {
    --     name = "squid_fishing_zone",

    --     useItemRod = {
    --         itemName = "adv_fishing_rod",
    --         itemCount = 1,
    --         brokenRate = 0.02,
    --         brokenRateFail = 0.04,
    --     },
    --     useItemBait = {
    --         itemName = "fishing_bait",
    --         itemCount = 1,
    --     },

    --     useitemSpecial = {
    --         enable = true,
    --         itemName = "light_bulb",
    --         itemCount = 1,
    --         brokenRate = 0.006,
    --         brokenRateFail = 0.006,
    --     },

    --     jobBuff = true,

    --     getItem = {
    --         {
    --             itemName = "squid_1", --หมึกกระดอง
    --             percent = 0.7,
    --             quantity = {1, 2}
    --         },
    --         {
    --             itemName = "squid_2", --หมึกกล้วย
    --             percent = 0.5,
    --             quantity = {1, 2}
    --         },
    --         {
    --             itemName = "squid_3", --หมึกยัก
    --             percent = 0.3,
    --             quantity = {1, 2}
    --         },
    --         {
    --             itemName = "squid_4", --แมงกะพรุน
    --             percent = 1.0,
    --             quantity = {1, 2}
    --         },
    --         {
    --             itemName = "squid_ink", --น้ำหมึก
    --             percent = 0.08,
    --             quantity = {1, 1}
    --         },
    --         {
    --             itemName = "bonus_squid",
    --             percent = 0.05,
    --             quantity = {1,1}
    --         },
    --         {
    --             itemName = "amp_g", --amp_g
    --             percent = 0.06,
    --             quantity = {1, 2}
    --         },
    --         {
    --             itemName = "rare_emblem_healing", --amp_g
    --             percent = 0.00004,
    --             quantity = {1, 1}
    --         },
    --     },

    --     getItemBonus = {
    --         {
    --             itemName = "lucky_box", 
    --             percent = 0.03,
    --             quantity = {1, 2}
    --         },
    --         {
    --             itemName = "squid_ink", --น้ำหมึก
    --             percent = 0.03,
    --             quantity = {1, 1}
    --         },
    --     },
    -- },
}