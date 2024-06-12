
Config = {}
Config.DrawDistance = 100
Config.Size         = {x = 1.00, y = 1.00, z = 1.00}
Config.Color        = {r = 0, g = 204, b = 204}
Config.Type         = 29
Config.Locale       = 'en'

-- Define craft table data
Config.CraftTables = {
    general_table = general_table,
    weapon_table = weapon_table,
    cooking_table = cooking_table,
    medic_table = medic_table,
    circle_table = circle_table,
    gang_table = gang_table,
    class_table = class_table,
    mystery_table = mystery_table,
}

-- Define craft table zones
Config.Zones =
{
    general_table = {
        name = "โต๊ะคราฟทั่วไป",
        Items = Config.CraftTables.general_table,
        isMark = false,
        job = nil,
        Pos = {
            {x = -427.0041, y = 1076.6200, z = 327.5565}, -- citizen rebel
            {x = 1078.312134, y = 3066.540772, z = 44.411010}, -- rebel
        },
    },
    weapon_table = {
        name = "โต๊ะคราฟอาวุธ",
        Items = Config.CraftTables.weapon_table,
        isMark = false,
        job = nil,
        Pos = {
            {x = -423.1613, y = 1079.0862, z = 327.5569}, -- citizen rebel
            {x = 1087.753906, y = 3031.410888, z = 44.411010}, -- rebel
        },
    },
    cooking_table = {
        name = "อาหาร",
        Items = Config.CraftTables.cooking_table,
        isMark = false,
        job = nil,
        Pos = {
            {x = -434.9207, y = 1076.0552, z = 327.5749}, -- citizen rebel
            {x = 1080.263794, y = 3059.419678, z = 44.411010}, -- rebel
        },
    },
    medic_table = {
        name = "หน่วยงาน",
        Items = Config.CraftTables.medic_table,
        isMark = false,
        job = "police",
        Pos = {
            {x = 378.4862, y = -1402.3115, z = 32.5111}, -- รพ
            {x = 483.7911, y = -987.9827, z = 30.6898}, -- สน
        },
    },
    circle_table = {
        name = "ส่วนกลาง",
      Items = Config.CraftTables.circle_table,
      isMark = false,
      job = "circle",
      Pos = {
        --   {x = -408.540650, y = 1191.758300, z = 325.634400}, -- ส่วนกลาง
      },
    },
    gang_table = {
        name = "โต๊ะคราฟแก๊ง",
      Items = Config.CraftTables.gang_table,
      isMark = false,
      Pos = {
          {x = 1085.854980, y = 3038.518798, z = 44.411010}, -- rebel
      },
    },
    class_table = {
        name = "กาชาปอง",
    Items = Config.CraftTables.class_table,
    isMark = false,
    Pos = {
            {x = -459.0403, y = 1086.8422, z = 327.5676}, -- citizen rebel
        },
    },
    mystery_table = {
        name = "โต๊ะคราฟแฟชั่น",
        Items = Config.CraftTables.mystery_table,
        isMark = false,
        Pos = {
            {x = -456.0135, y = 1081.7734, z = 327.5677}, -- citizen rebel
        },
    },
    -- Add more zone configurations if needed
}