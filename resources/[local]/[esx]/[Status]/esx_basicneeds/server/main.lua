
Work = false  --prop_cs_burger_01

RegisterServerEvent('esx_basicneeds:removeItem')
AddEventHandler('esx_basicneeds:removeItem', function(item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem(item, 1)
end)

RegisterServerEvent('esx_basicneeds:updateStatus')
AddEventHandler('esx_basicneeds:updateStatus', function(type, count)
	TriggerClientEvent('esx_status:add', source, type, count)
end)

