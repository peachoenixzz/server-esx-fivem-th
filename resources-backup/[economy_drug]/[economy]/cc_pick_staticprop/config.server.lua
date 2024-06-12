Config = {}

Config.JobInfoServer = {
    wood = {
        polyname = "wood_zone",

        coreEffect = false,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
        coreEffectMining = true,

        jobBuff = true,

        useItem = true,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน
        useItemName = 'work_kit',                   -- ชื่อไอเทมที่ใช้เริ่มงาน
        itemBrokenRate = 0.03,                      -- โอกาศที่อุปกร์แตก

        getItemName = {'wood_1'},                     -- ชื่อไอเทมที่ได้รับ
        getItemCount = {2, 3},                      -- จำนวนไอเทมที่ได้รับ

        getItemBonus = {
                {
                    itemName = 'exp',
                    percent = 0.05,
                }, 
                {
                    itemName = 'bonus_mining',
                    percent = 0.007,
                },                         
        },
        getItemBonusSecondPercent = 0.0001,         -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
        getItemBonusSecond = nil,                   -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    },

    copper = {
        polyname = "copper_zone",

        coreEffect = false,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
        coreEffectMining = true,

        jobBuff = true,

        useItem = true,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน
        useItemName = 'work_kit',                    -- ชื่อไอเทมที่ใช้เริ่มงาน
        itemBrokenRate = 0.03,                      -- โอกาศที่อุปกร์แตก

        getItemName = {'copper_1'},           -- ชื่อไอเทมที่ได้รับ
        getItemCount = {2, 3},                      -- จำนวนไอเทมที่ได้รับ

        getItemBonus = {
            {
                itemName = 'exp',
                percent = 0.05,
            }, 
            {
                itemName = 'bonus_mining',
                percent = 0.007,
            },                         
        },

        getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
        getItemBonusSecond = nil, -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    },

    steel = {
        polyname = "steel_zone",

        coreEffect = false,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
        coreEffectMining = true,

        jobBuff = true,

        useItem = true,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน
        useItemName = 'work_kit',                     -- ชื่อไอเทมที่ใช้เริ่มงาน
        itemBrokenRate = 0.03,                      -- โอกาศที่อุปกร์แตก

        getItemName = {'steel_1'},                     -- ชื่อไอเทมที่ได้รับ
        getItemCount = {2, 3},                      -- จำนวนไอเทมที่ได้รับ

        getItemBonus = {
            {
                itemName = 'exp',
                percent = 0.05,
            }, 
            {
                itemName = 'bonus_mining',
                percent = 0.007,
            }, 
        },
        -- โบนัสไอเทม

        getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
        getItemBonusSecond = nil,                   -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    },

    ore = {
        polyname = "gold_zone",

        coreEffect = false,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
        coreEffectMining = true,

        jobBuff = true,

        useItem = true,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน
        useItemName = 'work_kit',                     -- ชื่อไอเทมที่ใช้เริ่มงาน
        itemBrokenRate = 0.02,                      -- โอกาศที่อุปกร์แตก

        getItemName = {'gold_1'},                      -- ชื่อไอเทมที่ได้รับ
        getItemCount = {2, 3},                      -- จำนวนไอเทมที่ได้รับ

        getItemBonus = {
            {
                itemName = 'exp',
                percent = 0.05,
            }, 
            {
                itemName = 'bonus_mining',
                percent = 0.007,
            }, 
        },
        -- โบนัสไอเทม

        getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
        getItemBonusSecond = nil,                    -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    },

    crystal = {
        polyname = "crystal_zone",

        coreEffect = false,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
        coreEffectMining = true,

        jobBuff = true,

        useItem = true,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน
        useItemName = 'work_kit',                     -- ชื่อไอเทมที่ใช้เริ่มงาน
        itemBrokenRate = 0.02,                      -- โอกาศที่อุปกร์แตก

        getItemName = {'crystal'},                      -- ชื่อไอเทมที่ได้รับ
        getItemCount = {2, 3},                      -- จำนวนไอเทมที่ได้รับ

        getItemBonus = {
            {
                itemName = 'exp',
                percent = 0.05,
            }, 
            {
                itemName = 'bonus_mining',
                percent = 0.007,
            }, 
        },
        -- โบนัสไอเทม

        getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
        getItemBonusSecond = nil,                    -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    },

    weed = {
        polyname = "weed_zone",

        coreEffect = false,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
        coreEffectMining = true,

        jobBuff = true,

        useItem = false,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน
        useItemName = 'work_kit',                     -- ชื่อไอเทมที่ใช้เริ่มงาน
        itemBrokenRate = 0.02,                      -- โอกาศที่อุปกร์แตก

        getItemName = {'weed'},                      -- ชื่อไอเทมที่ได้รับ
        getItemCount = {2, 3},                      -- จำนวนไอเทมที่ได้รับ

        getItemBonus = {
            {
                itemName = 'exp',
                percent = 0.05,
            }, 
            {
                itemName = 'bonus_mining',
                percent = 0.007,
            }, 
        },
        -- โบนัสไอเทม

        getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
        getItemBonusSecond = nil,                    -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    },

    rice = {
        polyname = "rice_zone",

        coreEffect = true,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
        coreEffectMining = false,

        jobBuff = true,

        useItem = true,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน
        useItemName = 'work_kit',                     -- ชื่อไอเทมที่ใช้เริ่มงาน
        itemBrokenRate = 0.03,                      -- โอกาศที่อุปกร์แตก

        getItemName = {'rice_1'},                      -- ชื่อไอเทมที่ได้รับ
        getItemCount = {2, 3},                      -- จำนวนไอเทมที่ได้รับ

        getItemBonus = {
            {
                itemName = 'exp',
                percent = 0.05,
            }, 
            {
                itemName = 'bonus_eco',
                percent = 0.007,
            }, 
        },
        -- โบนัสไอเทม

        getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
        getItemBonusSecond = nil, -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    },

    cabbage = {
        polyname = "cabbage_zone",

        coreEffect = true,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
        coreEffectMining = false,

        jobBuff = true,

        useItem = true,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน
        useItemName = 'work_kit',                     -- ชื่อไอเทมที่ใช้เริ่มงาน
        itemBrokenRate = 0.03,                      -- โอกาศที่อุปกร์แตก

        getItemName = {'cabbage_1'},                      -- ชื่อไอเทมที่ได้รับ
        getItemCount = {2, 3},                      -- จำนวนไอเทมที่ได้รับ

        getItemBonus = {
            {
                itemName = 'exp',
                percent = 0.05,
            }, 
            {
                itemName = 'bonus_eco',
                percent = 0.007,
            }, 
        },
        -- โบนัสไอเทม

        getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
        getItemBonusSecond = nil, -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    },
    
    milk = {
        polyname = "milk_zone",

        coreEffect = true,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
        coreEffectMining = false,

        jobBuff = true,

        useItem = true,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน
        useItemName = 'work_kit',                     -- ชื่อไอเทมที่ใช้เริ่มงาน
        itemBrokenRate = 0.03,                      -- โอกาศที่อุปกร์แตก

        getItemName = {'milk_1'},                      -- ชื่อไอเทมที่ได้รับ
        getItemCount = {2, 3},                      -- จำนวนไอเทมที่ได้รับ

        getItemBonus = {
            {
                itemName = 'exp',
                percent = 0.05,
            }, 
            {
                itemName = 'bonus_eco',
                percent = 0.007,
            }, 
        },
        -- โบนัสไอเทม

        getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
        getItemBonusSecond = nil, -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    },

    pork = {
        polyname = "pork_zone",

        coreEffect = true,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
        coreEffectMining = false,

        jobBuff = true,

        useItem = true,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน
        useItemName = 'work_kit',                     -- ชื่อไอเทมที่ใช้เริ่มงาน
        itemBrokenRate = 0.03,                      -- โอกาศที่อุปกร์แตก

        getItemName = {'pork_1'},                      -- ชื่อไอเทมที่ได้รับ
        getItemCount = {2, 3},                      -- จำนวนไอเทมที่ได้รับ

        getItemBonus = {
            {
                itemName = 'exp',
                percent = 0.05,
            }, 
            {
                itemName = 'bonus_eco',
                percent = 0.007,
            }, 
        },
        -- โบนัสไอเทม

        getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
        getItemBonusSecond = nil, -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    },

    chicken = {
        polyname = "chicken_zone",

        coreEffect = true,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
        coreEffectMining = false,

        jobBuff = true,

        useItem = true,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน
        useItemName = 'work_kit',                     -- ชื่อไอเทมที่ใช้เริ่มงาน
        itemBrokenRate = 0.03,                      -- โอกาศที่อุปกร์แตก

        getItemName = {'chicken_1'},                      -- ชื่อไอเทมที่ได้รับ
        getItemCount = {2, 3},                      -- จำนวนไอเทมที่ได้รับ

        getItemBonus = {
            {
                itemName = 'exp',
                percent = 0.05,
            }, 
            {
                itemName = 'bonus_eco',
                percent = 0.007,
            }, 
        },
        -- โบนัสไอเทม

        getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
        getItemBonusSecond = nil, -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    },


    -- coconut = {
    --     polyname = "coconut_zone",

    --     coreEffect = true,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
    --     coreEffectMining = false,

    --     jobBuff = true,

    --     useItem = true,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน
    --     useItemName = 'kukri',                      -- ชื่อไอเทมที่ใช้เริ่มงาน

    --     getItemName = {'coconut'},                  -- ชื่อไอเทมที่ได้รับ
    --     getItemCount = {2, 3},                      -- จำนวนไอเทมที่ได้รับ
    --     itemBrokenRate = 0.03,                      -- โอกาศที่อุปกร์แตก

    --     getItemBonus = {
    --         --{
    --         --    itemName = 'gift_box',
    --         --    percent = 0.03,
    --         --},
    --         {
    --             itemName = 'old_anvil',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_book',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_compass',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_cup',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_lamp',
    --             percent = 0.001,
    --         },
    --     },
    --     -- โบนัสไอเทม

    --     getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    --     getItemBonusSecond = {"bonus_t", "bonus_h", "bonus_e", "bonus_c", "bonus_i", "bonus_r", "bonus_l"}, -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    -- },


    -- ore = {
    --     polyname = "ore_zone",

    --     coreEffect = false,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
    --     coreEffectMining = true,

    --     jobBuff = true,

    --     useItem = true,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน
    --     useItemName = 'hammer',                     -- ชื่อไอเทมที่ใช้เริ่มงาน
    --     itemBrokenRate = 0.02,                      -- โอกาศที่อุปกร์แตก

    --     getItemName = {'ore'},                      -- ชื่อไอเทมที่ได้รับ
    --     getItemCount = {2, 3},                      -- จำนวนไอเทมที่ได้รับ

    --     getItemBonus = {
    --         --{
    --         --    itemName = 'gift_box',
    --         --    percent = 0.03,
    --         --},
    --         {
    --             itemName = 'rare_gem_healing',
    --             percent = 0.00002,
    --         },
    --         {
    --             itemName = 'old_anvil',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_book',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_compass',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_cup',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_lamp',
    --             percent = 0.001,
    --         },
    --     },
    --     -- โบนัสไอเทม

    --     getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    --     getItemBonusSecond = nil,                    -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    -- },

    -- rice = {
    --     polyname = "rice_zone",

    --     coreEffect = true,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
    --     coreEffectMining = false,

    --     jobBuff = true,

    --     useItem = true,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน
    --     useItemName = 'sickle',                     -- ชื่อไอเทมที่ใช้เริ่มงาน
    --     itemBrokenRate = 0.03,                      -- โอกาศที่อุปกร์แตก

    --     getItemName = {'rice'},                      -- ชื่อไอเทมที่ได้รับ
    --     getItemCount = {2, 3},                      -- จำนวนไอเทมที่ได้รับ

    --     getItemBonus = {
    --         --{
    --         --    itemName = 'gift_box',
    --         --    percent = 0.03,
    --         --},
    --         {
    --             itemName = 'old_anvil',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_book',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_compass',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_cup',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_lamp',
    --             percent = 0.001,
    --         },
    --     },
    --     -- โบนัสไอเทม

    --     getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    --     getItemBonusSecond = {"bonus_t", "bonus_h", "bonus_e", "bonus_c", "bonus_i", "bonus_r", "bonus_l"}, -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    -- },

    -- scrap = {
    --     polyname = "scrap_zone",

    --     coreEffect = false,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
    --     coreEffectMining = true,

    --     jobBuff = true,

    --     useItem = true,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน
    --     useItemName = 'welder',                     -- ชื่อไอเทมที่ใช้เริ่มงาน
    --     itemBrokenRate = 0.03,                      -- โอกาศที่อุปกร์แตก

    --     getItemName = {'steel'},                     -- ชื่อไอเทมที่ได้รับ
    --     getItemCount = {2, 3},                      -- จำนวนไอเทมที่ได้รับ

    --     getItemBonus = {
    --         --{
    --         --    itemName = 'gift_box',
    --         --    percent = 0.03,
    --         --},
    --         {
    --             itemName = 'old_anvil',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_book',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_compass',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_cup',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_lamp',
    --             percent = 0.001,
    --         },
    --     },
    --     -- โบนัสไอเทม

    --     getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    --     getItemBonusSecond = nil,                   -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    -- },

    -- stone = {
    --     polyname = "stone_zone",

    --     coreEffect = false,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
    --     coreEffectMining = true,

    --     jobBuff = true,

    --     useItem = true,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน
    --     useItemName = 'pickaxe',                    -- ชื่อไอเทมที่ใช้เริ่มงาน
    --     itemBrokenRate = 0.03,                      -- โอกาศที่อุปกร์แตก

    --     getItemName = {'stone_pro_1'},           -- ชื่อไอเทมที่ได้รับ
    --     getItemCount = {2, 3},                      -- จำนวนไอเทมที่ได้รับ

    --     getItemBonus = {
    --         --{
    --         --    itemName = 'gift_box',
    --         --    percent = 0.03,
    --         --},
    --         {
    --             itemName = 'sulfer',
    --             percent = 0.15,
    --         },
    --         {
    --             itemName = 'old_anvil',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_book',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_compass',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_cup',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_lamp',
    --             percent = 0.001,
    --         },
    --     },
    --     -- โบนัสไอเทม


    --     getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    --     getItemBonusSecond = nil, -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    -- },

    -- wood = {
    --     polyname = "wood_zone",

    --     coreEffect = true,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
    --     coreEffectMining = false,

    --     jobBuff = true,

    --     useItem = true,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน
    --     useItemName = 'axe',                        -- ชื่อไอเทมที่ใช้เริ่มงาน
    --     itemBrokenRate = 0.03,                      -- โอกาศที่อุปกร์แตก

    --     getItemName = {'wood'},                     -- ชื่อไอเทมที่ได้รับ
    --     getItemCount = {2, 3},                      -- จำนวนไอเทมที่ได้รับ

    --     getItemBonus = {
    --         --{
    --         --    itemName = 'gift_box',
    --         --    percent = 0.03,
    --         --},
    --         {
    --             itemName = 'rare_staff_broken',
    --             percent = 0.00002,
    --         },
    --         {
    --             itemName = 'old_anvil',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_anvil',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_book',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_compass',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_cup',
    --             percent = 0.001,
    --         },
    --         {
    --             itemName = 'old_lamp',
    --             percent = 0.001,
    --         },
    --     },
    --     -- โบนัสไอเทม

    --     getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    --     getItemBonusSecond = {"bonus_t", "bonus_h", "bonus_e", "bonus_c", "bonus_i", "bonus_r", "bonus_l"}, -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    -- },

    -- haloween = {
    --     polyname = "haloween_zone",

    --     coreEffect = false,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
    --     coreEffectMining = false,

    --     jobBuff = true,

    --     useItem = false,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน

    --     getItemName = {'coffin'},                     -- ชื่อไอเทมที่ได้รับ
    --     getItemCount = {1, 2},                      -- จำนวนไอเทมที่ได้รับ

    --     getItemBonus = {
    --         {
    --             itemName = 'fang',
    --             percent = 0.03,
    --         },
    --     },
    --     -- โบนัสไอเทม

    --     getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน   
    --     getItemBonusSecond = nil, -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    -- },

    -- weed = {
    --     polyname = "weed_zone",

    --     coreEffect = false,                          -- คำนวณบัพจาก coreEffect เช่น *2 หรือ ลดระยะเวลา
    --     coreEffectMining = false,

    --     jobBuff = true,

    --     useItem = false,                             -- เปิดปิดการใช้ไอเทมเพื่อมเริ่มงาน

    --     getItemName = {'weed'},                     -- ชื่อไอเทมที่ได้รับ
    --     getItemCount = {1, 2},                      -- จำนวนไอเทมที่ได้รับ

    --     getItemBonus = nil,
    --     -- โบนัสไอเทม

    --     getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน   
    --     getItemBonusSecond = nil, -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    -- },
}