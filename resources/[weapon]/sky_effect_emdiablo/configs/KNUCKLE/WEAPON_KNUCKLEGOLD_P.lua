local Weapon = {
    WeaponName = "WEAPON_KNUCKLEGOLD_P",
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
            particleDictionary = 'penguin_bloodspark_purple',
            particleName = 'penguin_sky_bloodspark_purple',
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