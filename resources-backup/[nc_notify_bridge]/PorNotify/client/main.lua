function SendNotification(options)
	pcall(function()
		exports.nc_notify:PushNotification({
			title = options.text,
			type = options.type or 'information',
			duration = options.timeout or 4000,
		})
	end)
end
exports('SendNotification', SendNotification)

RegisterNetEvent('PorNotify:SendNotification', SendNotification)