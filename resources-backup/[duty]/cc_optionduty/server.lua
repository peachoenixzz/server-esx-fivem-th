-- server/main.lua

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
ESX.RegisterServerCallback('cc_optionduty:checkPlayerAlive', function(source, cb,job)
    local xPlayers = ESX.GetExtendedPlayers('job', job)
    local playerName = {}
    local count = 1
    --print(job)
    for _, xPlayer in pairs(xPlayers) do
        --print(xPlayer.identifier)
        MySQL.Async.fetchAll('SELECT firstname,lastname FROM users WHERE identifier = @identifier and job = @job and is_dead = 0', {
            ['@job'] = job,
            ['@identifier'] = xPlayer.identifier
        }, function(result)
            if result[1] then
                --print("got it")
                --print( result[1].firstname .. " "..  result[1].lastname)
                table.insert(playerName, { name = result[1].firstname .." ".. result[1].lastname})
            end
            --print(#xPlayers,count)
            if #xPlayers == count then
                --print("callback")
                cb(playerName)
            end
            count = count+1
        end)
    end
end)
