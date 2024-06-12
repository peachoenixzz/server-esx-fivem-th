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

Config.silaClothInfo = {
    {
        coords = vector3(-422.1099853515625, 1092.8499755859375, 316.4200134277344),
        markersize = {
            x = 1.00,
            y = 1.00,
            z = 1.00,
        },
        markercolour = {
            r = 0,
            g = 204,
            b = 204,
        },
        markertype = 1,
        drawdistance = 10,
        interactdistance = 1, --ควรเท่ากับ x และ y
    },
}

Config.Uniforms = {
        male = {
            [1] = {
                decals_1 = 7 , decals_2 = 0,
                bproof_1 = 57 , bproof_2 = 0,
                pants_1 = 14,   pants_2 = 0,
                shoes_1 = 13, shoes_2 = 0
            },
            [2] = {
                decals_1 = 7 , decals_2 = 1,
                bproof_1 = 57, bproof_2 = 3,
                pants_1 = 14,   pants_2 = 0,
                shoes_1 = 13, shoes_2 = 0
            },
            [3] = {
                decals_1 = 7 , decals_2 = 2,
                bproof_1 = 57, bproof_2 = 3,
                pants_1 = 14,   pants_2 = 0,
                shoes_1 = 13, shoes_2 = 0
            },
            [4] = {
                decals_1 = 7 , decals_2 = 3,
                bproof_1 = 57, bproof_2 = 2,
                pants_1 = 14,   pants_2 = 0,
                shoes_1 = 13, shoes_2 = 0
            },
            [5] = {
                decals_1 = 7 , decals_2 = 4,
                bproof_1 = 57, bproof_2 = 0,
                pants_1 = 14,   pants_2 = 0,
                shoes_1 = 13, shoes_2 = 0
            },
            [6] = {
                decals_1 = 7 , decals_2 = 5,
                bproof_1 = 57, bproof_2 = 4,
                pants_1 = 14,   pants_2 = 0,
                shoes_1 = 13, shoes_2 = 0
            },
            [7] = {
                decals_1 = 7 , decals_2 = 6,
                bproof_1 = 57, bproof_2 = 1,
                pants_1 = 14,   pants_2 = 0,
                shoes_1 = 13, shoes_2 = 0
            }

        },
        female = {
            tshirt_1 = 15,  tshirt_2 = 0,
            torso_1 = 348,   torso_2 = 0,
            decals_1 = 0,   decals_2 = 0,
            arms = 17,
            pants_1 = 121,   pants_2 = 0,
            shoes_1 = 53,   shoes_2 = 0,
            helmet_1 = 157,  helmet_2 = 0,
            chain_1 = 0,    chain_2 = 0,
            ears_1 = 2,     ears_2 = 0
        }
}
