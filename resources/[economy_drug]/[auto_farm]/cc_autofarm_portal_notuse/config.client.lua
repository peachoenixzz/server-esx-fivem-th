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

Config.teleportInfo = {
    {
        portalname = "Entrance Auto Farm 1",
        id_entrance = "id_1",
        coords = vector3(-414.514282, 1226.980224, 325.634400),
        destination = vector3(4670.3798828125, -1314.0400390625, 2024.530029296875),
        heading = 182.29,
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
        drawdistance = 5,
        interactdistance = 1, --ควรเท่ากับ x และ y
    },
    {
        portalname = "Exit Auto Farm 1",
        id_exit = "id_1",
        coords = vector3(4682.9599609375, -1313.510009765625, 2022.530029296875),
        destination = vector3(-414.514282, 1226.980224, 325.634400),
        heading = 252.283462,
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
        drawdistance = 5,
        interactdistance = 1, --ควรเท่ากับ x และ y
    },
}

Config.npcTeleport = {
    {
        coords = vector3(-416.083526, 1227.283570, 325.634400),
        heading = 158.740158,
    },
    {
        coords = vector3(4684.2900390625, -1313.5, 2021.530029296875),
        heading = 89.58,
    },
}
