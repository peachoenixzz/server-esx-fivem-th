local Weapon = {
    WeaponName = "WEAPON_KNUCKLEGOLD_G",
    EffectBone = {
        -- {	
        --     particleDictionary = 'penguin_fireloop_black_yl',
        --     particleName = 'penguin_sky_fireloop_black_yl',
        --     scale = 0.2,
        --     Bone = 57005,
        --     xPos = 0.15,
        --     yPos = 0.05,
        --     zPos = 0.0,
        --     xRot = 0.0,
        --     yRot = 0.0,
        --     zRot = 0.0
        -- },
        {	
            particleDictionary = 'penguin_bloodspark_green',
            particleName = 'penguin_sky_bloodspark_green',
            scale = 0.6,
            Bone = 57005,
            xPos = 0.1,
            yPos = 0.0,
            zPos = 0.0,
            xRot = 0.0,
            yRot = 0.0,
            zRot = 0.0
        },
    },
}

table.insert(Config.WeaponEffect, Weapon)