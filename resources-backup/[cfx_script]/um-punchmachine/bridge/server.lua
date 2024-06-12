if GetResourceState('es_extended') == 'started' then

    ESX = exports.es_extended:getSharedObject()

    function RegisterCallback()
        ESX.RegisterServerCallback('um-punchmachine:server:getScoreNui', function(source, cb)
            local result = MySQL.query.await('SELECT * FROM umpunchmachine_leaderboard ORDER BY score DESC LIMIT 10', {})
             cb(result)
        end)
        ESX.RegisterServerCallback('um-punchmachine:server:getMoney', function(source, cb)
            local xPlayer = ESX.GetPlayerFromId(source)
            local money = xPlayer.getMoney()
            cb(money)
        end)
    end

    function GetPlayerName(src,score)
        local xPlayer = ESX.GetPlayerFromId(src)
        local name = xPlayer.getName()
        MySQL.insert('INSERT INTO umpunchmachine_leaderboard (name, score) VALUES (?, ?)', {name,score})
    end

    RegisterNetEvent('um-punchmachine:server:RemoveMoney', function(src,money)
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.removeMoney(money)
    end)

elseif GetResourceState('qb-core') == 'started' then

   QBCore = exports['qb-core']:GetCoreObject()

    function RegisterCallback()
        QBCore.Functions.CreateCallback('um-punchmachine:server:getScoreNui', function(source, cb)
            local result = MySQL.query.await('SELECT * FROM umpunchmachine_leaderboard ORDER BY score DESC LIMIT 3', {})
             cb(result)
        end)
        QBCore.Functions.CreateCallback('um-punchmachine:server:getMoney', function(source, cb)
            local Player = QBCore.Functions.GetPlayer(source)
            local money = Player.PlayerData.money.cash
            cb(money)
        end)
    end

    function GetPlayerName(src,score)
        local Player = QBCore.Functions.GetPlayer(src)
        local name = Player.PlayerData.charinfo.firstname  .. ' ' .. Player.PlayerData.charinfo.lastname
        MySQL.insert('INSERT INTO umpunchmachine_leaderboard (name, score) VALUES (?, ?)', {name,score})
    end

    RegisterNetEvent('um-punchmachine:server:RemoveMoney', function(src,money)
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.RemoveMoney('cash', money)
    end)

else
    print('No ESX or QB-Core found')
    print('Standalone')
end