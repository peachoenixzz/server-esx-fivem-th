Config = {}

Config.AutoFarmFreeInfoServer = {    
    
    squid = {
        name = "squid_pick",
        useitem = "card_afk",
        useitemcount = 1,

        getItemName = {'afk_squid'},                  
        getItemCount = {1, 1},                      

        getItemBonus = {
            {
                itemName = 'exp',
                percent = 1.00,
            },
        },                        

        getItemBonusSecondPercent = 0.075,            
        getItemBonusSecond = nil, 
    },

}