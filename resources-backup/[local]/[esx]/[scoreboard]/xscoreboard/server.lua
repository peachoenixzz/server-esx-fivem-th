

ESX.RegisterServerCallback('xscoreboard:server:getdata', function(source, cb)
    local xPlayer =  ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @iden LIMIT 0,1', {
            ['@iden'] = xPlayer.identifier
        }, function(result)
            if not (result[1] == nil) then
                local data = {}
                data =  {
                    my_phonenmumber = result[1].phone_number,
                    my_fullname = result[1].firstname .. " " .. result[1].lastname,
                    my_job = ESX.GetPlayerFromId(source).job.label,
                    my_jobb = ESX.GetPlayerFromId(source).job.grade_label,
                    my_ping = 0,
                }
                cb(data)
            else
                cb(nil)
            end
        end)
    end
end)
