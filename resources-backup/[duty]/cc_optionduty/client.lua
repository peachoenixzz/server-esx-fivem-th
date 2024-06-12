-- client/main.lua

ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)


function checkOnDutyPlayer(job)
   print(job)
    if ESX.PlayerData.job and ESX.PlayerData.job.name == job then
        ESX.TriggerServerCallback('cc_optionduty:checkPlayerAlive', function(players)
            displayPlayerMenu(players)
        end,job)
    end
end

function displayPlayerMenu(players)
    local elements = {}
    for i=1, #players, 1 do
        table.insert(elements, {label = i..") "..players[i].name, value = "close"})
    end

    ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'on_duty_player_list',
            {
                title    = 'On Duty Player',
                align    = 'top-right',
                elements = elements
            },
            function(data, menu)
                local selectedPlayer = data.current.value
                if selectedPlayer == "close" then
                    menu.close()
                end
            end,
            function(data, menu)
                menu.close()
            end
    )
end