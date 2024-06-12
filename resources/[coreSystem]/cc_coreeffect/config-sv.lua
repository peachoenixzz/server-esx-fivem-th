Config = {}
Config.items = {
    unlimit_bag = {
        image = "unlimit_bag",
        use_item = "unlimit_bag",
        effect_time = 14400000, -- millisecond
        effect_name = "unlimit_bag",
        effect_type = "auto_farm_stack", -- type of working in game such as economy,process
    },
    ad_bell = {
        image = "ad_bell",
        use_item = "ad_bell",
        effect_time = 3600000, -- millisecond
        effect_name = "ad_bell",
        effect_type = "ad_bell", -- type of working in game such as economy,process
    },
    auto_farm = {
        image = "auto_farm",
        use_item = "auto_farm",
        effect_time = 14400000, -- millisecond
        effect_name = "auto_farm",
        effect_type = "auto_farm", -- type of working in game such as economy,process
    },
    auto_farm_1h = {
        image = "auto_1h",
        use_item = "auto_1h",
        effect_time = 3600000, -- millisecond
        effect_name = "auto_farm",
        effect_type = "auto_farm", -- type of working in game such as economy,process
    },
    gum_eco = {
        image = "gum_eco",
        use_item = "gum_eco",
        effect_time = 3600000, -- millisecond
        effect_name = "eco_x2",
        effect_in_game = 2,
        effect_type = "economy", -- type of working in game such as economy,process
        calculate_type = "multiply", -- multiply,percentage
    },
    ticket_eco_x2 = {
        image = "ticket_eco_x2",
        use_item = "ticket_eco_x2",
        effect_time = 10800000, -- millisecond
        effect_name = "eco_x2",
        effect_in_game = 2,
        effect_type = "economy", -- type of working in game such as economy,process
        calculate_type = "multiply", -- multiply,percentage
    },
    gum_mining = {
        image = "gum_mining",
        use_item = "gum_mining",
        effect_time = 3600000, -- millisecond
        effect_name = "mining_x2",
        effect_in_game = 2,
        effect_type = "mining", -- type of working in game such as economy,process
        calculate_type = "multiply", -- multiply,percentage
    },
    scuba = {
        image = "scuba",
        use_item = "scuba",
        effect_time = 300000, -- millisecond
        effect_name = "scuba",
        effect_in_game = 0,
        effect_type = "effect_scuba", -- type of working in game such as economy,process
        calculate_type = "normal", -- multiply,percentage
    },
    gov_scuba = {
        image = "gov_scuba",
        use_item = "gov_scuba",
        effect_time = 300000, -- millisecond
        effect_name = "gov_scuba",
        effect_in_game = 0,
        effect_type = "effect_scuba", -- type of working in game such as economy,process
        calculate_type = "normal", -- multiply,percentage
    },
    adrenaline = {
        image = "adrenaline",
        use_item = "adrenaline",
        effect_time = 80000, -- millisecond
        effect_name = "adrenaline",
        effect_in_game = 0,
        effect_type = "effect_adrenaline", -- type of working in game such as economy,process
        calculate_type = "normal", -- multiply,percentage
    },
    r_adrenaline = {
        image = "r_adrenaline",
        use_item = "r_adrenaline",
        effect_time = 80000, -- millisecond
        effect_name = "r_adrenaline",
        effect_in_game = 0,
        effect_type = "r_adrenaline", -- type of working in game such as economy,process
        calculate_type = "normal", -- multiply,percentage
    },
    gov_adrenaline = {
        image = "gov_adrenaline",
        use_item = "gov_adrenaline",
        effect_time = 80000, -- millisecond
        effect_name = "gov_adrenaline",
        effect_in_game = 0,
        effect_type = "gov_adrenaline", -- type of working in game such as economy,process
        calculate_type = "normal", -- multiply,percentage
    },
}

-- use for validate about security
Config.debuff = {
    -- optional by time
    in_jail = {
        image = "in_jail",
        effect_name = "in_jail"
    },

    dead_by_shroud =  {
        image = "dead_by_shroud",
        effect_name = "dead_by_shroud"
    },

    block_pick_basic_drug = {
        image = "block_pick_basic_drug",
        effect_name = "block_pick_basic_drug",
    },

    ad_clipper = {
        image = "ad_clipper",
        effect_name = "ad_clipper",
    },

    ad_spray = {
        image = "ad_spray",
        effect_name = "ad_spray",
    },

    escape_prison_gps = {
        image = "escape_prison_gps",
        effect_name = "escape_prison_gps",
    },

    anonymous_gps = {
        image = "anonymous_gps",
        effect_name = "anonymous_gps",
    },

    -- full debuff
    dizzy_drug_cocaine = {
        image = "dizzy",
        can_stack = true,
        effect_name = "dizzy",
        effect_time = 180000,
        effect_in_game = 1,
        effect_type = "debuff_player", -- type of working in game such as economy,process
        calculate_type = "normal", -- multiply,percentage
    },
}