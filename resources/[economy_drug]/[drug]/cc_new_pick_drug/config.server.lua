Config = {}
Config.newDrugInfo = {
    meth = {
        type = 'basic_drug',
        name = 'pick_meth', 
        getItem = {'meth'},
        getItemCount = {2, 3},
        getItemBonus = {
            {
                itemName = 'exp',
                percent = 0.10,
                quantity = {1, 1}
            },
            {
                itemName = 'meth_a',
                percent = 0.01,
                quantity = {1, 1}
            },
        },
    },
    coke = {
        type = 'basic_drug',
        name = 'pick_coke', 
        getItem = {'cocaine_1'},
        getItemCount = {2, 3},
        getItemBonus = {
            {
                itemName = 'exp',
                percent = 0.10,
                quantity = {1, 1}
            },
            {
                itemName = 'cocaine_2',
                percent = 0.01,
                quantity = {1, 1}
            },
        },
    },
}