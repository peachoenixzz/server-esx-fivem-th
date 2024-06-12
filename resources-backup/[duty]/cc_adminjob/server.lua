
RegisterCommand('reloadplayer', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin'  then
        if args[1] then
            local playerId = tonumber(args[1])
            if playerId and ESX.GetPlayerFromId(playerId) then
                TriggerClientEvent('cc_admin:reloadPlayerBug', playerId)
            else
                TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
            end
        else
            TriggerClientEvent('cc_admin:reloadPlayerBug', source)
        end
    end
end,true)

RegisterCommand('resetp', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin'  then
        if args[1] then
            local playerId = tonumber(args[1])
            if playerId and ESX.GetPlayerFromId(playerId) then
                TriggerClientEvent('cc_selldrug:unFreezePlayerSellDrug', playerId)
            else
                TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
            end
        else
            TriggerClientEvent('cc_selldrug:unFreezePlayerSellDrug', source)
        end
    end
end,true)

RegisterCommand('fevertime', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin'  then
        exports.cc_coreeffect:createDebuffGlobal('fever_time_event',3600000 ,'fever_time_event','show')
    end
end,true)

RegisterCommand('resetallp', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin'  then
        local playerPed = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(playerPed)
        local xPlayers = ESX.OneSync.GetPlayersInArea(playerCoords, 300.0)
        for _, player in pairs(xPlayers) do
            if player.id == xPlayer.source then goto endState end
            local xTarget =  ESX.GetPlayerFromId(player.id)
            TriggerClientEvent('cc_adminjob:resetallplayer',xTarget.source)
            ::endState::
        end
    end
end,true)

ESX.RegisterServerCallback('cc_adminjob:reflectPlayer', function(source, cb,attacker)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin'  then
        TriggerClientEvent('cc_adminjob:reflect', attacker)
        cb(true)
        return
    end
    cb(false)
end)

ESX.RegisterUsableItem('ad_blessing', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin'  then
        local playerPed = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(playerPed)
        local xPlayers = ESX.OneSync.GetPlayersInArea(playerCoords, 5.0)
        for _, player in pairs(xPlayers) do
            TriggerClientEvent('esx_ambulancejob:reviveAdmin',player.id)
        end
    end
end)

ESX.RegisterUsableItem('ad_clipper', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin'  then
        local playerPed = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(playerPed)
        local xPlayers = ESX.OneSync.GetPlayersInArea(playerCoords, 2.0)
        for _, player in pairs(xPlayers) do
            if player.id == xPlayer.source then goto endState end
            local xTarget =  ESX.GetPlayerFromId(player.id)
            exports.cc_coreeffect:createDebuff(xTarget,'ad_clipper',300000,'ad_clipper','show')
            TriggerClientEvent('cc_adminjob:cc_clipper',xTarget.source)
            ::endState::
        end
    end
end)

ESX.RegisterUsableItem('ad_spray', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin'  then
        local playerPed = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(playerPed)
        local xPlayers = ESX.OneSync.GetPlayersInArea(playerCoords, 2.0)
        for _, player in pairs(xPlayers) do
            if player.id == xPlayer.source then goto endState end
            local xTarget =  ESX.GetPlayerFromId(player.id)
            exports.cc_coreeffect:createDebuff(xTarget,'ad_spray',300000,'ad_spray','show')
            TriggerClientEvent('cc_adminjob:ad_spray',xTarget.source)
            ::endState::
        end
    end
end)