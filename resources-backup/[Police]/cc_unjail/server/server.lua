TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)


ESX.RegisterServerCallback("cc_unjail:retrieveJailedPlayers", function(source, cb)
    local jailedPersons = {}
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT identifier,time_current FROM core_effect WHERE time_current > @time_current and effect_name = @effect_name", { ["@time_current"] = 0, ["@effect_name"] = "in_jail" }, function(result)
        for i = 1, #result, 1 do
            local prisonPlayer = ESX.GetPlayerFromIdentifier(result[i].identifier)
            if prisonPlayer then
                table.insert(jailedPersons, { name = prisonPlayer.getName() , jailTime = tonumber((result[i].time_current/1000)/60), identifier = result[i].identifier })
            end
        end
        cb(jailedPersons)
    end)
end)
