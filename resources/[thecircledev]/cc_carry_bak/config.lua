Config                  = {}
Config.Locale           = 'en'
Config.UseKeymapping    = true
Config.Animation    = {
    ['dragdeath'] = {
        index = 1,
        label = "Carry Corpse",
        lib = 'missfinale_c2mcs_1',
        lib2 = 'nm',
        anim1 = 'fin_c2_mcs_1_camman',
        anim2 = 'firemans_carry',
        distans = 0.15,
        distans2 = 0.27,
        height = 0.63,
        spin = 0.0,		
        length = 100000,
        controlFlagMe = 49,
        controlFlagTarget = 33,
        animFlagTarget = 1,
        deathonly = true,
    },
    ['carrypeople'] = {
        index = 2,
        label = "Carry People",
        lib = 'missfinale_c2mcs_1',
        anim1 = 'fin_c2_mcs_1_camman',
        lib2 = 'nm',
        anim2 = 'firemans_carry',
        distans = 0.15,
        distans2 = 0.27,
        height = 0.63,
        spin = 0.0,
        length = 100000,
        controlFlagMe = 49,
        controlFlagTarget = 33,
        animFlagTarget = 1,
        blockdeath = true,
    },
    ['piggyback'] = {
        index = 3,
        label = "Piggy Back",
        lib = 'anim@arena@celeb@flat@paired@no_props@',
        lib2 = 'anim@arena@celeb@flat@paired@no_props@',
        anim1 = 'piggyback_c_player_a',
        anim2 = 'piggyback_c_player_b',
        distans = -0.07,
        distans2 = 0.0,
        height = 0.45,
        spin = 0.0,		
        length = 100000,
        controlFlagMe = 49,
        controlFlagTarget = 33,
        animFlagTarget = 1,
        blockdeath = true,
    },
    ["carrypeopleadmin"] = {
        label = "Carry People",
        lib = 'anim@arena@celeb@flat@paired@no_props@',
        lib2 = 'mp_cop_miss',
        anim1 = 'piggyback_c_player_a',
        anim2 = 'dazed',
        distans = -0.07,
        distans2 = 0.0,
        height = 0.45,
        spin = 0.0,
        length = -1,
        controlFlagMe = 49,
        controlFlagTarget = 33,
        animFlagTarget = 1,
        hide = true,
        blockdeath = true,
    },
}