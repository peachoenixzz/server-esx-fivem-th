ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('skateboard', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		if xPlayer.getInventoryItem('skateboard').count > 0 then
            TriggerClientEvent('meow_skateboard', source, 'meow_skateboard')
        else
			TriggerClientEvent("pNotify:SendNotification", _source, {
                text = '<strong class="red-text">คุณไม่มีสเก็ตบอร์ด</strong>',
                type = "error",
                timeout = 3000,
                layout = "bottomCenter",
                queue = "global"
            })
		end
	end
end)