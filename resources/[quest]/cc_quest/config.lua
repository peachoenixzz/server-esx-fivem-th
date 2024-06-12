Config = {}
Config.questBonus = {
  [1] = {
    getItemName =
    {
      
    },

    getItemBonus = {
       {
         itemName = {'exp_vault'},
         itemCount = {1,1},
         percent = 0.1,
       },
       {
         itemName = {'exp'},
         itemCount = {1,3},
         percent = 1.0,
       },
    },
    -- โบนัสไอเทม

    getItemBonusSecondPercent = 0.0001,          -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
    getItemBonusSecond = nil, -- โบนัสไอเทมรูปแบบที่เปอร์เซนเท่ากัน
  }
}