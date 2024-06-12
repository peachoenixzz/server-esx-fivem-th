

ESX.RegisterUsableItem('gov_tablet', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    print(xPlayer.phoneNumber)
    if xPlayer.getJob().name == "ambulance" or xPlayer.getJob().name == "police" or xPlayer.getJob().name == "admin" then
        TriggerClientEvent('cc_tablet:openTablet', xPlayer.source)
    end
end)
