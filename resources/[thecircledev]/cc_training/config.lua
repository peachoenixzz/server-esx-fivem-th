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

Config.trainingPoly = { 
    {
        coords = {
            vector3(-3610.694580, -1225.503296, 906.245362),
            vector3(-3783.758300, -1226.663696, 906.245362),
            vector3(-3779.142822, -1463.367066, 906.245362),
            vector3(-3614.703370, -1459.081298, 906.245362),
        },
        name = "training",
        debug = false,
        minZ = 904,
        maxZ = 925,
    },
}

Config.Clothes = {
    blue = {
        male = {
            tshirt_1 = 19,  -- blue
            tshirt_2 = 0,
            torso_1 = 16,
            torso_2 = 5,
            arms = 4,
            pants_1 = 16,
            pants_2 = 4,
            shoes_1 = 35,
            shoes_2 = 0,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        },
        female = {
            tshirt_1 = 17, -- blue
            tshirt_2 = 0,
            torso_1 = 16,
            torso_2 = 4,
            arms = 1,
            pants_1 = 16,
            pants_2 = 4,
            shoes_1 = 13,
            shoes_2 = 0,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        }
    },
    red = {
        male = {
            tshirt_1 = 19,  -- red
            tshirt_2 = 0,
            torso_1 = 16,
            torso_2 = 3,
            arms = 4,
            pants_1 = 16,
            pants_2 = 2,
            shoes_1 = 35,
            shoes_2 = 0,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        },
        female = {
            tshirt_1 = 17, -- red
            tshirt_2 = 0,
            torso_1 = 16,
            torso_2 = 2,
            arms = 1,
            pants_1 = 16,
            pants_2 = 2,
            shoes_1 = 13,
            shoes_2 = 0,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        }
    },
    green = {
        male = {
            tshirt_1 = 19,  -- green
            tshirt_2 = 0,
            torso_1 = 16,
            torso_2 = 4,
            arms = 4,
            pants_1 = 16,
            pants_2 = 3,
            shoes_1 = 35,
            shoes_2 = 0,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        },
        female = {
            tshirt_1 = 17, -- green
            tshirt_2 = 0,
            torso_1 = 16,
            torso_2 = 3,
            arms = 1,
            pants_1 = 16,
            pants_2 = 3,
            shoes_1 = 13,
            shoes_2 = 0,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        }
    },
    black = {
        male = {
            tshirt_1 = 19,  -- black
            tshirt_2 = 0,
            torso_1 = 16,
            torso_2 = 1,
            arms = 4,
            pants_1 = 16,
            pants_2 = 0,
            shoes_1 = 35,
            shoes_2 = 0,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        },
        female = {
            tshirt_1 = 17, -- black
            tshirt_2 = 0,
            torso_1 = 16,
            torso_2 = 0,
            arms = 1,
            pants_1 = 16,
            pants_2 = 0,
            shoes_1 = 13,
            shoes_2 = 0,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        }
    },
    white = {
        male = {
            tshirt_1 = 19,  -- white
            tshirt_2 = 0,
            torso_1 = 16,
            torso_2 = 2,
            arms = 4,
            pants_1 = 16,
            pants_2 = 1,
            shoes_1 = 35,
            shoes_2 = 0,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        },
        female = {
            tshirt_1 = 17, -- white
            tshirt_2 = 0,
            torso_1 = 16,
            torso_2 = 1,
            arms = 1,
            pants_1 = 16,
            pants_2 = 1,
            shoes_1 = 13,
            shoes_2 = 0,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        }
    },
    avr = {
        male = {
            tshirt_1 = 15,  -- AVR
            tshirt_2 = 0,
            torso_1 = 18,
            torso_2 = 6,
            arms = 1,
            pants_1 = 29,
            pants_2 = 0,
            shoes_1 = 33,
            shoes_2 = 0,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        },
        female = {
            tshirt_1 = 3, -- AVR
            tshirt_2 = 0,
            torso_1 = 18,
            torso_2 = 6,
            arms = 3,
            pants_1 = 25,
            pants_2 = 0,
            shoes_1 = 30,
            shoes_2 = 0,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        }
    },
    xx = {
        male = {
            tshirt_1 = 20,  -- XX
            tshirt_2 = 0,
            torso_1 = 17,
            torso_2 = 5,
            arms = 4,
            pants_1 = 16,
            pants_2 = 5,
            shoes_1 = 30,
            shoes_2 = 0,
            chain_1 = 138,
            chain_2 = 2,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        },
        female = {
            tshirt_1 = 176, -- XX
            tshirt_2 = 0,
            torso_1 = 16,
            torso_2 = 5,
            arms = 5,
            pants_1 = 16,
            pants_2 = 5,
            shoes_1 = 16,
            shoes_2 = 9,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        }
    },
    bvl =  {
        male = {
            tshirt_1 = 19,  -- BVL
            tshirt_2 = 0,
            torso_1 = 16,
            torso_2 = 3,
            arms = 4,
            pants_1 = 16,
            pants_2 = 3,
            shoes_1 = 19,
            shoes_2 = 1,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        },
        female = {
            tshirt_1 = 17, -- BVL
            tshirt_2 = 0,
            torso_1 = 17,
            torso_2 = 3,
            arms = 3,
            pants_1 = 16,
            pants_2 = 3,
            shoes_1 = 13,
            shoes_2 = 0,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        }
    },
    dzt = {
        male = {
            tshirt_1 = 19,  -- DZT
            tshirt_2 = 0,
            torso_1 = 16,
            torso_2 = 2,
            arms = 4,
            pants_1 = 16,
            pants_2 = 2,
            shoes_1 = 19,
            shoes_2 = 1,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        },
        female = {
            tshirt_1 = 17, -- DZT
            tshirt_2 = 0,
            torso_1 = 17,
            torso_2 = 2,
            arms = 3,
            pants_1 = 16,
            pants_2 = 2,
            shoes_1 = 13,
            shoes_2 = 0,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        }
    },
    gbt = {
        male = {
            tshirt_1 = 15,  -- GBT
            tshirt_2 = 0,
            torso_1 = 0,
            torso_2 = 2,
            arms = 0,
            pants_1 = 35,
            pants_2 = 0,
            shoes_1 = 177,
            shoes_2 = 1,
            chain_1 = 0,
            bproof_1 = 67,
            bags_1 = 0,
            bracelets_1 = -1,
        },
        female = {
            tshirt_1 = 41, -- GBT
            tshirt_2 = 5,
            torso_1 = 5,
            torso_2 = 7,
            arms = 10,
            pants_1 = 14,
            pants_2 = 0,
            shoes_1 = 180,
            shoes_2 = 1,
            chain_1 = 0,
            bproof_1 = 79,
            bags_1 = 0,
            bracelets_1 = -1,
        }
    },
    rv = {
        male = {
            tshirt_1 = 19,  -- RV
            tshirt_2 = 0,
            torso_1 = 16,
            torso_2 = 7,
            arms = 4,
            pants_1 = 16,
            pants_2 = 7,
            shoes_1 = 19,
            shoes_2 = 1,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        },
        female = {
            tshirt_1 = 17, -- RV
            tshirt_2 = 0,
            torso_1 = 17,
            torso_2 = 7,
            arms = 3,
            pants_1 = 16,
            pants_2 = 7,
            shoes_1 = 13,
            shoes_2 = 0,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        }
    },
    smk = {
        male = {
            tshirt_1 = 19,  -- SMK
            tshirt_2 = 0,
            torso_1 = 16,
            torso_2 = 8,
            arms = 4,
            pants_1 = 16,
            pants_2 = 8,
            shoes_1 = 19,
            shoes_2 = 1,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        },
        female = {
            tshirt_1 = 17, -- SMK
            tshirt_2 = 0,
            torso_1 = 17,
            torso_2 = 8,
            arms = 3,
            pants_1 = 16,
            pants_2 = 8,
            shoes_1 = 13,
            shoes_2 = 0,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        }
    },
    bg = {
        male = {
            tshirt_1 = 19,  -- BG
            tshirt_2 = 0,
            torso_1 = 17,
            torso_2 = 6,
            arms = 4,
            pants_1 = 16,
            pants_2 = 6,
            shoes_1 = 30,
            shoes_2 = 1,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        },
        female = {
            tshirt_1 = 17, -- BG
            tshirt_2 = 0,
            torso_1 = 16,
            torso_2 = 6,
            arms = 3,
            pants_1 = 16,
            pants_2 = 6,
            shoes_1 = 16,
            shoes_2 = 1,
            chain_1 = 0,
            bproof_1 = 0,
            bags_1 = 0,
            bracelets_1 = -1,
        }
    },
}


Config.spotlights = {
    {
        posX = -3762.909912109375,
        posY = -1445.9000244140625,
        posZ = 910.219970703125,
        dirX = 300.0,
        dirY = 300.0,
        dirZ = -1.0,
        colorR = 255,
        colorG = 255,
        colorB = 255,
        distance = 300.0,
        brightness = 60.0,
        hardness = 2.0,
        radius = 300.0,
        falloff = 300.0
    },
    {
        posX = -3637.429931640625, posY = -1236.3599853515625, posZ = 910.2100219726564,
        dirX = -300.0,
        dirY = -300.0,
        dirZ = -1.0,
        colorR = 255,
        colorG = 255,
        colorB = 255,
        distance = 300.0,
        brightness = 60.0,
        hardness = 2.0,
        radius = 300.0,
        falloff = 300.0
    },
    -- Add more spotlight data here as needed
    {
        posX = -621.8200073242188,  -- stage airdrop ปชช.
        posY = -5756.7998046875,
        posZ = 1138.52001953125,
        dirX = 300.0,
        dirY = 300.0,
        dirZ = -1.0,
        colorR = 255,
        colorG = 255,
        colorB = 255,
        distance = 300.0,
        brightness = 60.0,
        hardness = 2.0,
        radius = 300.0,
        falloff = 300.0
    },
    {
        posX = -498.489990234375,  -- stage airdrop ปชช.
        posY = -5544.5498046875,
        posZ = 1138.52001953125,
        dirX = -300.0,
        dirY = -300.0,
        dirZ = -1.0,
        colorR = 255,
        colorG = 255,
        colorB = 255,
        distance = 300.0,
        brightness = 60.0,
        hardness = 2.0,
        radius = 300.0,
        falloff = 300.0
    },
    {
        posX = -3305.469970703125,  -- stage airdrop gang
        posY = -2973.489990234375,
        posZ = 756.3400268554688,
        dirX = 300.0,
        dirY = 300.0,
        dirZ = -1.0,
        colorR = 255,
        colorG = 255,
        colorB = 255,
        distance = 300.0,
        brightness = 60.0,
        hardness = 2.0,
        radius = 300.0,
        falloff = 300.0
    },
    {
        posX = -3181.080078125,  -- stage airdrop gang
        posY = -2761.909912109375,
        posZ = 756.3400268554688,
        dirX = -300.0,
        dirY = -300.0,
        dirZ = -1.0,
        colorR = 255,
        colorG = 255,
        colorB = 255,
        distance = 300.0,
        brightness = 60.0,
        hardness = 2.0,
        radius = 300.0,
        falloff = 300.0
    },
    {
        posX = -3808.64990234375,  -- stage airdrop family
        posY = 190.11000061035156,
        posZ = 1237.8199462890625,
        dirX = 300.0,
        dirY = 300.0,
        dirZ = -1.0,
        colorR = 255,
        colorG = 255,
        colorB = 255,
        distance = 300.0,
        brightness = 60.0,
        hardness = 2.0,
        radius = 300.0,
        falloff = 300.0
    },
    {
        posX = -3684.56005859375,  -- stage airdrop family
        posY = 402.0400085449219,
        posZ = 1237.8199462890625,
        dirX = -300.0,
        dirY = -300.0,
        dirZ = -1.0,
        colorR = 255,
        colorG = 255,
        colorB = 255,
        distance = 300.0,
        brightness = 60.0,
        hardness = 2.0,
        radius = 300.0,
        falloff = 300.0
    },
}