
ESX.RegisterServerCallback('cc_checkidentify:getOtherPlayerData', function(source, cb, target, notify)
    local xPlayer = ESX.GetPlayerFromId(target)

    if notify then
        --xPlayer.showNotification(TranslateCap('being_searched'))
    end

    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
        }
            data.dob = xPlayer.get('dateofbirth')
            data.height = xPlayer.get('height')

            if xPlayer.get('sex') == 'm' then data.sex = 'male' else data.sex = 'female' end
        cb(data)
        return
    end
    cb(false)
end)