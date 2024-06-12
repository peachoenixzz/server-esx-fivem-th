Config = {}
Config.ampInfo = {
    meth = {
        type = 'basic_amp',
        name = 'pick_amp', 
        getItem = {'exp'},
        getItemCount = {1, 1},
        getItemBonus = {
            {
                itemName = "amp_r",
                percent = 1.00,
                quantity = {1, 1}
            },
            {
                itemName = "amp_b",
                percent = 1.00,
                quantity = {1, 1}
            },
            {
                itemName = "amp_g",
                percent = 0.20,
                quantity = {1, 1}
            },
        },
    },
}