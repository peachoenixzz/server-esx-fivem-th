Config = {}
------ อันไหน Trigger ไปเซิฟเวอร์ให้ใช้ 
--    TriggerEvent('abc')
------ อันไหน Trigger ไป Client ให้ใช้ 
--    TriggerClientEvent('abc')
Config.AutoEven = {

    ["resetBattlepass"] = {
        day = 'Everyday',
        time = "23:00:00", 
        event = function()
            TriggerEvent('zc:resmission')
        end
    },


    ["Waron"] = {
        day = 'Monday',
        time = "20:00:00", 
        event = function()
            TriggerEvent('Zc_ZoneWar:timeAttack',true)
        end
    },
    ["Waroff"] = {
        day = 'Monday',
        time = "23:00:00", 
        event = function()
            TriggerEvent('Zc_ZoneWar:timeAttack',false)
        end
    },


    ["car"] = {
        day = 'Tuesday',
        time = "07:59:45", 
        event = function()
            TriggerClientEvent('Dm_Triathlon:StartGamePhaseone', -1, 'car')
            TriggerEvent('resetscore')

        end
    },
    ["jetski"] = {
        day = 'Wednesday',
        time = "10:49:00", 
        event = function()
            TriggerClientEvent('Dm_Triathlon:StartGamePhaseone', -1, 'jetski')
            TriggerEvent('resetscore')
        end
    },

    ["Bountyx1"] = {
        day = 'Monday',
        time = "11:49:00", 
        event = function()
            TriggerEvent("randombountynumber")
        end
    },
    ["Bountyx2"] = {
        day = 'Tuesday',
        time = "12:49:00", 
        event = function()
            TriggerEvent("randombountynumber")
        end
    },

    ["Scorekill1"] = {
        day = 'Saturday',
        time = "01:43:00", 
        event = function()
            TriggerEvent('Zc_Scorekill:starteven', 300)

        end
    },
    ["Scorekill2"] = {
        day = 'Sunday',
        time = "12:49:00", 
        event = function()
            TriggerEvent('Zc_Scorekill:starteven', 500)

        end
    },

}


