

RegisterServerEvent('Giant_skinui:saveCloth')
AddEventHandler('Giant_skinui:saveCloth', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() < 500 then
        return
    end
    xPlayer.removeMoney(500)
end)