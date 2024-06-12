
ESX.RegisterServerCallback('lsrp-lockpickfo:getBobbyPins', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local bobbypins = xPlayer.getInventoryItem('bobbypin')
    local screwdriver = xPlayer.getInventoryItem('screwdriver')
        if bobbypins == nil and screwdriver == nil then
            cb(0, 0)
        else
            cb(bobbypins.count, screwdriver.count)
        end
end)

RegisterServerEvent('lsrp-lockpickfo:removePin')
AddEventHandler('lsrp-lockpickfo:removePin', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('bobbypin', 1)
end)