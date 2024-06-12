Config = {}

Config.Key = {
    -- https://docs.fivem.net/docs/game-references/controls/#controls
    playKey = 38, -- E
    leaderboardKey = 47, -- G
}

Config.MiniGame = 'Normal' -- | Easy | Normal | Hard

Config.Target = {
    status = false, -- [Optional] If you set this value to true, the target will works. (true or false)
    type = "" -- ox, qb, other // example: type = "ox"
}

Config.Payment = {
    status = true, -- If you set this value to false, the punchmachine will be free. (true or false)
    price = 300,
}

Config.Blips = {
    status = false, -- If you set this value to false, the blips will not be displayed. (true or false)
    sprite = 311,
    color = 1,
    scale = 0.2,
}

Config.Coords = {
    -- When you add a new location make sure the id is uniq 3,4,5 etc
    -- If the prop top in your location, decrease the z value by 1 or 2

-- Land Chicken [TOP]
    [1] = {
        coords = vector4(218.63999938964844, -891.7000122070312, 31.10000038146972, 67.14),
        models = {
            baseModel ='box_machine2',
            punchModel = 'bm_uc',
        },
    },
-- Land Chicken [TOP]
    [2] = {
        coords = vector4(220.1999969482422, -888.760009765625, 31.1299991607666, 63.88),
        models = {
            baseModel ='box_machine2',
            punchModel = 'bm_uc',
        },
    },
-- Land Chicken [BOTTOM]
    [3] = {
        coords = vector4(157.3428, -1083.8645, 29.5050, 2.0678),
        models = {
            baseModel ='box_machine2',
            punchModel = 'bm_uc',
        },
    },
-- Yellow
    [4] = {
        coords = vector4(-292.8618, -921.3204, 31.0806, 160.6304),
        models = {
            baseModel ='box_machine2',
            punchModel = 'bm_uc',
        },
    },
-- Green
    [5] = {
        coords = vector4(300.1100, -276.4459, 54.1665, 161.0321),
        models = {
            baseModel ='box_machine2',
            punchModel = 'bm_uc',
        },
    },
-- Pink
    [6] = {
        coords = vector4(1032.9595, -763.2772, 57.9861, 242.2140),
        models = {
            baseModel ='box_machine2',
            punchModel = 'bm_uc',
        },
    },
-- Red
    [7] = {
        coords = vector4(70.8917, -1567.6365, 29.5946, 230.1000),
        models = {
            baseModel ='box_machine2',
            punchModel = 'bm_uc',
        },
    },
-- Blue
    [8] = {
        coords = vector4(-1508.0389, -420.7477, 35.5919, 321.4966),
        models = {
            baseModel ='box_machine2',
            punchModel = 'bm_uc',
        },
    },
}

Config.Lang = {
    lang_drawtext = '~INPUT_CONTEXT~ Punch ~n~~INPUT_DETONATE~ Leaderboard',
    lang_nomoney = 'You do not have enough cash',
    lang_truemachine = 'This is currently in use, please wait for it to finish',
    lang_blipname = 'Punch Machine',
    lang_target_punch = "Punch",
    lang_target_leaderboard = "Leaderboard",
}