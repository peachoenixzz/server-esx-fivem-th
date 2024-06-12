Config = {}

Config.AutoFarmInfoServer = {    
    
    gem = {
        name = "gem_pick",

        getItemName = {'afk_gem'},                  
        getItemCount = {1, 1},                      

        getItemBonus = {
            {
                itemName = 'exp',
                percent = 0.07,
            },
        },                        

        getItemBonusSecondPercent = 0.075,            
        getItemBonusSecond = nil, 
    },

    wood = {
        name = "wood_pick",

        getItemName = {'wood_2'},                  
        getItemCount = {1, 1},                      

        getItemBonus = {
            {
                itemName = 'exp',
                percent = 0.07,
            },
            {
                itemName = 'coal',
                percent = 0.10,
            },
        },                        

        getItemBonusSecondPercent = 0.50,            
        getItemBonusSecond = nil, 
    },

    copper = {
        name = "copper_pick",

        getItemName = {'copper_2'},                  
        getItemCount = {1, 1},                      

        getItemBonus =  {
            {
                itemName = 'exp',
                percent = 0.07,
            },
            {
                itemName = 'sulfur',
                percent = 0.10,
            },
        },                        

        getItemBonusSecondPercent = 0.05,            
        getItemBonusSecond = nil, 
    },

    steel = {
        name = "steel_pick",

        getItemName = {'steel_2'},                  
        getItemCount = {1, 1},                      

        getItemBonus = {
            {
                itemName = 'exp',
                percent = 0.07,
            },
            {
                itemName = 'steel_3',
                percent = 0.10,
            },
        },                     

        getItemBonusSecondPercent = 0.075,            
        getItemBonusSecond = nil, 
    },
}