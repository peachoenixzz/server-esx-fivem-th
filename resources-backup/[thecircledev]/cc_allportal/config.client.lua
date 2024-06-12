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
        teleportname = "auto_farm_afk_tele",
        destination = vector3(-2819.929931640625, -1933.0799560546875, 6.65000009536743),
        heading = 311.67,
    },
    {
        teleportname = "gashapon_tele",
        destination = vector3(-151.02000427246097, -591.5700073242188, 167.00),
        heading = 217.85,
    },
    {
        teleportname = "arena_tele",
        destination = vector3(-3744.889892578125, -1342.27001953125, 907.280029296875),
        heading = 267.82,
    },
}

Config.npcTeleport = {
    { 
        name = "arena_tele",
        coords = vector3(-3747.429931640625, -1342.5899658203125, 905.280029296875),
        heading = 269.34,
        markersize = {
            x = 3.00,
            y = 3.00,
            z = 1.00,
        },
        markercolour = {
                    r = 255,
                    g = 204,
                    b = 0,
        },
        markertype = 1,
        drawdistance = 5,
        interactdistance = 3, --ควรเท่ากับ x และ y
    },
    {
        name = "gashapon_tele",
        coords = vector3(-139.35000610351565, -588.6199951171875, 166),
        heading = 127.91,
        markersize = {
            x = 3.00,
            y = 3.00,
            z = 1.00,
        },
        markercolour = {
                    r = 255,
                    g = 204,
                    b = 0,
        },
        markertype = 1,
        drawdistance = 5,
        interactdistance = 3, --ควรเท่ากับ x และ y
    },
    {
        name = "auto_farm_afk_tele",
        coords = vector3(-2827.610107421875, -1941.9300537109375, 4.8600001335144),
        heading = 318.25,
        markersize = {
            x = 3.00,
            y = 3.00,
            z = 1.00,
        },
        markercolour = {
                    r = 255,
                    g = 204,
                    b = 0,
        },
        markertype = 1,
        drawdistance = 5,
        interactdistance = 3, --ควรเท่ากับ x และ y
    },
}

Config.npcTeleportNoExit = {
    {
        name = "land_chicken_top",
        coords = vector3(147.7299957275391, -1095.449951171875, 28.85000038146972),
        heading = 356.31,
        markersize = {
            x = 3.00,
            y = 3.00,
            z = 1.00,
        },
        markercolour = {
                    r = 255,
                    g = 204,
                    b = 0,
        },
        markertype = 1,
        drawdistance = 5,
        interactdistance = 3, --ควรเท่ากับ x และ y
    },
    {
        name = "land_chicken_bot",
        coords = vector3(222.2299957275391, -900.52001953125, 30.11000061035156),
        heading = 66.71,
        markersize = {
            x = 3.00,
            y = 3.00,
            z = 1.00,
        },
        markercolour = {
                    r = 255,
                    g = 204,
                    b = 0,
        },
        markertype = 1,
        drawdistance = 5,
        interactdistance = 3, --ควรเท่ากับ x และ y
    },
    {
        name = "citizen_rabel",
        coords = vector3(-406.8800048828125, 1083.300048828125, 326.6000061035156),
        heading = 73.12,
        markersize = {
            x = 3.00,
            y = 3.00,
            z = 1.00,
        },
        markercolour = {
                    r = 255,
                    g = 204,
                    b = 0,
        },
        markertype = 1,
        drawdistance = 5,
        interactdistance = 3, --ควรเท่ากับ x และ y
    },
}
