

ESX.RegisterUsableItem('radio', function(source)
	TriggerClientEvent('mail3ee-radio:startRadio', source)
end)

ESX.RegisterUsableItem('gov_radio', function(source)
	TriggerClientEvent('mail3ee-radio:startRadio', source)
end)

ESX.RegisterUsableItem('gov_radio', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('mail3ee-radio:startRadio', source)
end)