
function getIdentifyPlayer(player)
    ESX.TriggerServerCallback('cc_checkidentify:getOtherPlayerData', function(xPlayer)
        openIdentifyMenu(xPlayer)
    end, player)
end


function openIdentifyMenu(xPlayer)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'identify_menu',
            {
                title    = 'รายละเอียดเจ้าของบัตร',
                align    = 'bottom-right',
                elements = {
                    {label = xPlayer.name,	value = ''},
                    {label = xPlayer.job,	value = ''},
                    {label = xPlayer.grade,	value = ''},
                    {label = xPlayer.dob,	value = ''},
                    {label = xPlayer.height, value = ''},
                    {label = xPlayer.sex, value = ''}
                }
            },
            function(data, menu)
                menu.close()
            end
    )
end

