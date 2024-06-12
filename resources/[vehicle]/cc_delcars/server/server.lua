ESX = nil
local breakDelCar = false
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand(cfg['command'], function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then
        local Text = args[1]
        local xTime = args[2]
    local time = args[1]
    if time == nil then
        TriggerClientEvent('General:DelCar', -1, cfg['deltime'])
    else
        TriggerClientEvent('General:DelCar', -1, time)
    end
end
end, true)



RegisterCommand('dvserver', function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'admin' then
        SendStartAirDrop(args[1])
    end
end)

RegisterCommand('svserver', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then

        MySQL.update('UPDATE owned_vehicles SET `stored` = @stored',
                {
                    ['@stored']     = true,
                })
    end
end)

RegisterCommand('ccdvserver', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then
        breakDelCar = true
        TriggerClientEvent("General:stopDelCar",-1)
    end
end)

function SendStartAirDrop(timez)
    Timecooldown = timez
    local numsend = 1

    while true do
        if breakDelCar then
            breakDelCar = false
            break
        end
        Timecooldown = Timecooldown - 1

        if Timecooldown > 30 then
            numsend = numsend + 1
        else
            numsend = 0
        end

        if numsend == 0 then

            TriggerClientEvent('General:DelCar', -1, Timecooldown)

        end

        if numsend > 10 then

            TriggerClientEvent('General:DelCar', -1, Timecooldown)
            numsend = 1
        end
        
        Wait(1000)
        if Timecooldown <= 0 then

            Citizen.Wait(5000)
            -- Restart()

            break
        end
    end

end


function delcar()
    SetTimeout(1000, function()
        local date_local = os.date('%H:%M:%S', os.time())        
        for i=1, #cfg['timer'], 1 do
            local start_time = cfg['timer'][i]..':00'
            if date_local == start_time then
                SendStartAirDrop(cfg['deltime'])
            end
        end 
        delcar()   
	end)
end

delcar()