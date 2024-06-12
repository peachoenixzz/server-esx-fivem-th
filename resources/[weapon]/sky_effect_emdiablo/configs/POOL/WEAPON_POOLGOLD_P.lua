local Weapon = {
    WeaponName = "WEAPON_POOLGOLD_P",
    -- EffectBone = {
    --     {	
    --         particleDictionary = 'penguin_fireloop_black_yl',
    --         particleName = 'penguin_sky_fireloop_black_yl',
    --         scale = 0.2,
    --         Bone = 57005,
    --         xPos = 0.11,
    --         yPos = -0.03,
    --         zPos = -0.04,
    --         xRot = 0.0,
    --         yRot = 0.0,
    --         zRot = 0.0
    --     },
    -- },
    EffectOrder1 = {
        [1] = {
            {
                wait = 800,
                particleDictionary = 'penguin_bloodspark_purple',
                particleName = 'penguin_sky_bloodspark_purple',
                scale = 1.0,
                Bone = 57005,
                xPos = 0.03,
                yPos = -0.08,
                zPos = -0.01,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
        },
        [2] = {
            {
                wait = 800,
                particleDictionary = 'penguin_bloodspark_purple',
                particleName = 'penguin_sky_bloodspark_purple',
                scale = 1.0,
                Bone = 57005,
                xPos = 0.11,
                yPos = 0.06,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
        },
        [3] = {
            {
                wait = 800,
                particleDictionary = 'penguin_bloodspark_purple',
                particleName = 'penguin_sky_bloodspark_purple',
                scale = 1.0,
                Bone = 57005,
                xPos = 0.16,
                yPos = 0.22,
                zPos = 0.01,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
        },
        [4] = {
            {
                wait = 800,
                particleDictionary = 'penguin_bloodspark_purple',
                particleName = 'penguin_sky_bloodspark_purple',
                scale = 1.0,
                Bone = 57005,
                xPos = 0.23,
                yPos = 0.33,
                zPos = 0.03,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
        },
        [5] = {
            {
                wait = 800,
                particleDictionary = 'penguin_bloodspark_purple',
                particleName = 'penguin_sky_bloodspark_purple',
                scale = 1.0,
                Bone = 57005,
                xPos = 0.28,
                yPos = 0.52,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0
            },
        },
    },
}

table.insert(Config.WeaponEffect, Weapon)