Config = {}
Config.DrawDistance               = 25.0 -- How close do you need to be for the markers to be drawn (in GTA units).
Config.MarkerType                 = {Cloakrooms = 20, Armories = 21, BossActions = 22, Vehicles = 29, Helicopters = 29}
Config.MarkerSize                 = {x = 1.0, y = 1.0, z = 1.0}
Config.MarkerColor                = {r = 0, g = 204, b = 204}
Config.CircleStation = {
    Circle = {
        Vehicles = {
            {
                Spawner = vector3(-400.312072, 1214.386840, 325.937744),
                InsideShop =vector3(-368.584626, 1256.413208, 328.549438),
                SpawnPoints = {
                    {coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0},
                    {coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0},
                    {coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0},
                    {coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0}
                }
            }
        },

        Helicopters = {
            {
                Spawner = vector3(-402.290100, 1208.017578, 325.920898),
                InsideShop = vector3(-386.254944, 1289.696656, 343.849122),
                SpawnPoints = {
                    {coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0}
                }
            }
        },
    }
}

Config.AuthorizedVehicles = {
    car = {
        cc_cadet = {
            {model = 'rhinehart', price = 1000}
        },

        cc_officer = {
            {model = 'rhinehart', price = 1000}
        },

        cc_vice = {
            {model = 'rhinehart', price = 1000}
        },

        cc_president = {
            {model = 'rhinehart', price = 1000}
        }
    },

    helicopter = {
        cc_cadet = {	
            {model = 'buzzard2', props = {modLivery = 0}, price = 1000}
        },

        cc_officer = {	
            {model = 'buzzard2', props = {modLivery = 0}, price = 1000}
        },

        cc_vice = {	
            {model = 'buzzard2', props = {modLivery = 0}, price = 1000}
        },

        cc_president = {
            {model = 'buzzard2', props = {modLivery = 0}, price = 1000}
        },
    }
}