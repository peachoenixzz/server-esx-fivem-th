Config = {}

Config.Key 					= {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Config.JobPolyZone ={
    {
        coords = vector3(339.2000122070313, 3571.050048828125, 33.41999816894531),
        distance = 30,
        name = "wood_zone",
        debug = false,
        enable = true,
    },
    {
        coords = vector3(2950.3200, 2790.9499, 41.0200),
        distance = 30,
        name = "copper_zone",
        debug = false,
        enable = true,
    },
    {
        coords = vector3(-1603.5600, 3091.5800, 33.56),
        distance = 30,
        name = "steel_zone",
        debug = false,
        enable = true,
    },
    {
        coords = vector3(-434.2226, 2934.3403, 13.8616),
        distance = 30,
        name = "gold_zone",
        debug = false,
        enable = true,
    },
    {
        coords = vector3(-2775.9304, 2510.7009, 2.6821),
        distance = 30,
        name = "crystal_zone",
        debug = false,
        enable = true,
    },
    {
        coords = vector3(56.1011, 3713.9563, 39.7496),
        distance = 20,
        name = "weed_zone",
        debug = false,
        enable = true,
    },
    {
        coords = vector3(2524.1270, 4342.5234, 39.3629),
        distance = 20,
        name = "rice_zone",
        debug = false,
        enable = true,
    },
    {
        coords = vector3(2825.4617, 4603.9556, 46.4379),
        distance = 20,
        name = "cabbage_zone",
        debug = false,
        enable = true,
    },
    {
        coords = vector3(2490.4666, 4737.4658, 34.3039),
        distance = 20,
        name = "milk_zone",
        debug = false,
        enable = true,
    },
    {
        coords = vector3(1449.51, 1067.44, 114.33),
        distance = 15,
        name = "pork_zone",
        debug = false,
        enable = true,
    },
    {
        coords = vector3(2378.6298828125, 5053.43994140625, 46.43999862670898),
        distance = 15,
        name = "chicken_zone",
        debug = false,
        enable = true,
    },
}

Config.CoordZ = { 6.0, 33.29,34.0,35.0, 36.0, 37.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0, 100.0,130.0,135.0 }
Config.JobInfoClient = {
    wood = {
        polyname = "wood_zone",

        enableautoFarm = true,
        autoMarkerPos = { x = 339.20, y = 3571.05, z = 33.41},

        spawnPropPos ={                             -- จุดกึ่งกลางเมื่อ spawn object
            x = 339.20, y = 3571.05, z = 33.41
        },
        spawnPropDistance = 15,                     -- ระยะ spawn object จากจุดกึ่งกลาง
        placeOnjectOnGround = true,                 -- วาง Object โดยจับจากพื้น
        objectName = "meow_wood",           -- object ที่จะแสดง
        objectCount = 8,

        pickTime = 3000,                            -- ระยะเวลาเก็บ
        pickDistance = 2.5,                         -- ระยะห่างจาก object

        animDict = "melee@large_wpn@streamed_core",
        anim = "car_side_attack_a",
        flags = 9 ,
    },

    copper = {
        polyname = "copper_zone",

        enableautoFarm = true,
        autoMarkerPos = { x = 2950.3200, y = 2790.9499, z = 41.0200,},

        spawnPropPos ={                             -- จุดกึ่งกลางเมื่อ spawn object
            x = 2950.3200, y = 2790.9499, z = 41.0200
        },
        spawnPropDistance = 12,                     -- ระยะ spawn object จากจุดกึ่งกลาง
        placeOnjectOnGround = true,                 -- วาง Object โดยจับจากพื้น
        objectName = "meow_bronze",           -- object ที่จะแสดง
        objectCount = 8,

        pickTime = 3000,                            -- ระยะเวลาเก็บ
        pickDistance = 2.5,                         -- ระยะห่างจาก object

        animDict = "melee@large_wpn@streamed_core",
        anim = "ground_attack_0",
        flags = 9 ,
    },

    steel = {
        polyname = "steel_zone",

        enableautoFarm = true,
        autoMarkerPos = { x = -1603.5600, y = 3091.5800, z = 32.56,},

        spawnPropPos ={                             -- จุดกึ่งกลางเมื่อ spawn object
            x = -1603.5600, y = 3091.5800, z = 33.5699
        },
        spawnPropDistance = 10,                     -- ระยะ spawn object จากจุดกึ่งกลาง
        placeOnjectOnGround = true,                 -- วาง Object โดยจับจากพื้น
        objectName = "meow_silverbar",           -- object ที่จะแสดง
        objectCount = 8,

        pickTime = 3000,                            -- ระยะเวลาเก็บ
        pickDistance = 2.5,                         -- ระยะห่างจาก object

        animDict = "amb@world_human_welding@male@base",
        anim = "base",
        flags = 9 ,
    },

    gold = {
        polyname = "gold_zone",

        enableautoFarm = true,
        autoMarkerPos = { x = -434.2226, y = 2934.3403, z = 13.8616,},

        spawnPropPos ={                             -- จุดกึ่งกลางเมื่อ spawn object
            x = -434.22, y = 2934.34, z = 13.86
        },
        spawnPropDistance = 10,                     -- ระยะ spawn object จากจุดกึ่งกลาง
        placeOnjectOnGround = true,                -- วาง Object โดยจับจากพื้น
        objectName = "meow_gold",            -- object ที่จะแสดง
        objectCount = 8,

        pickTime = 3000,                            -- ระยะเวลาเก็บ
        pickDistance = 2.5,                         -- ระยะห่างจาก object

        animDict = "melee@large_wpn@streamed_core",
        anim = "car_down_attack",
        flags = 9 ,
    },

    crystal = {
        polyname = "crystal_zone",

        enableautoFarm = true,
        autoMarkerPos = { x = -2775.9304, y = 2510.7009, z = 2.68216,},

        spawnPropPos ={                             -- จุดกึ่งกลางเมื่อ spawn object
            x = -2775.9304, y = 2510.7009, z = 2.68216
        },
        spawnPropDistance = 10,                     -- ระยะ spawn object จากจุดกึ่งกลาง
        placeOnjectOnGround = true,                -- วาง Object โดยจับจากพื้น
        objectName = "meow_crystal",            -- object ที่จะแสดง
        objectCount = 8,

        pickTime = 3000,                            -- ระยะเวลาเก็บ
        pickDistance = 2.5,                         -- ระยะห่างจาก object

        animDict = "melee@large_wpn@streamed_core",
        anim = "car_down_attack",
        flags = 9 ,
    },

    weed = {
        polyname = "weed_zone",

        enableautoFarm = true,
        autoMarkerPos = { x = 56.1011, y = 3713.9563, z = 39.7496},

        spawnPropPos ={                             -- จุดกึ่งกลางเมื่อ spawn object
            x = 56.1011, y = 3713.9563, z = 39.7496
        },
        spawnPropDistance = 8,                     -- ระยะ spawn object จากจุดกึ่งกลาง
        placeOnjectOnGround = true,                -- วาง Object โดยจับจากพื้น
        objectName = "meow_cute_weed",            -- object ที่จะแสดง
        objectCount = 6,

        pickTime = 3000,                            -- ระยะเวลาเก็บ
        pickDistance = 2.5,                         -- ระยะห่างจาก object

        animDict = "amb@world_human_gardener_plant@female@base",
        anim = "base_female",
        flags = 9 ,
    },

    rice = {
        polyname = "rice_zone",

        enableautoFarm = true,
        autoMarkerPos = { x = 2524.1270, y = 4342.5234, z = 39.3629,},

        spawnPropPos ={                             -- จุดกึ่งกลางเมื่อ spawn object
            x = 2524.1270, y = 4342.5234, z = 39.3629
        },
        spawnPropDistance = 12,                     -- ระยะ spawn object จากจุดกึ่งกลาง
        placeOnjectOnGround = true,                 -- วาง Object โดยจับจากพื้น
        objectName = "meow_cute_rice",           -- object ที่จะแสดง
        objectCount = 10,

        pickTime = 3000,                            -- ระยะเวลาเก็บ
        pickDistance = 2.5,                         -- ระยะห่างจาก object

        animDict = "amb@world_human_gardener_plant@female@base",
        anim = "base_female",
        flags = 9 ,
    },

    cabbage = {
        polyname = "cabbage_zone",

        enableautoFarm = true,
        autoMarkerPos = { x = 2825.4617, y = 4603.9556, z = 46.4379,},

        spawnPropPos ={                             -- จุดกึ่งกลางเมื่อ spawn object
            x = 2825.4617, y = 4603.9556, z = 46.4379
        },
        spawnPropDistance = 12,                     -- ระยะ spawn object จากจุดกึ่งกลาง
        placeOnjectOnGround = true,                 -- วาง Object โดยจับจากพื้น
        objectName = "meow_cute_cabbage",           -- object ที่จะแสดง
        objectCount = 9,

        pickTime = 3000,                            -- ระยะเวลาเก็บ
        pickDistance = 2.5,                         -- ระยะห่างจาก object

        animDict = "amb@world_human_gardener_plant@female@base",
        anim = "base_female",
        flags = 9 ,
    },

    milk = {
        polyname = "milk_zone",

        enableautoFarm = true,
        autoMarkerPos = { x = 2490.4666, y = 4737.4658, z = 34.3039,},

        spawnPropPos ={                             -- จุดกึ่งกลางเมื่อ spawn object
            x = 2490.4666, y = 4737.4658, z = 34.3039
        },
        spawnPropDistance = 12,                     -- ระยะ spawn object จากจุดกึ่งกลาง
        placeOnjectOnGround = true,                 -- วาง Object โดยจับจากพื้น
        objectName = "meow_cute_cow",           -- object ที่จะแสดง
        objectCount = 9,

        pickTime = 3000,                            -- ระยะเวลาเก็บ
        pickDistance = 2.5,                         -- ระยะห่างจาก object

        animDict = "amb@world_human_gardener_plant@female@base",
        anim = "base_female",
        flags = 9 ,
    },

    pork = {
        polyname = "pork_zone",

        enableautoFarm = true, 
        autoMarkerPos = { x = 1450.3788, y = 1067.2555, z = 114.3339,},

        spawnPropPos ={                             -- จุดกึ่งกลางเมื่อ spawn object
            x = 1450.3788, y = 1067.2555, z = 114.3339
        },
        spawnPropDistance = 7,                     -- ระยะ spawn object จากจุดกึ่งกลาง
        placeOnjectOnGround = true,                 -- วาง Object โดยจับจากพื้น
        objectName = "meow_cute_pig",           -- object ที่จะแสดง
        objectCount = 5,

        pickTime = 3000,                            -- ระยะเวลาเก็บ
        pickDistance = 2.5,                         -- ระยะห่างจาก object

        animDict = "amb@world_human_gardener_plant@female@base",
        anim = "base_female",
        flags = 9 ,
    },

    chicken = {
        polyname = "chicken_zone",

        enableautoFarm = true,
        autoMarkerPos = { x = 2378.6294, y = 5053.4399, z = 46.4407,},

        spawnPropPos ={                             -- จุดกึ่งกลางเมื่อ spawn object
            x = 2378.6294, y = 5053.4399, z = 46.4407
        },
        spawnPropDistance = 7,                     -- ระยะ spawn object จากจุดกึ่งกลาง
        placeOnjectOnGround = true,                 -- วาง Object โดยจับจากพื้น
        objectName = "meow_cute_chickenegg",           -- object ที่จะแสดง
        objectCount = 5,

        pickTime = 3000,                            -- ระยะเวลาเก็บ
        pickDistance = 2.5,                         -- ระยะห่างจาก object

        animDict = "amb@world_human_gardener_plant@female@base",
        anim = "base_female",
        flags = 9 ,
    },

}