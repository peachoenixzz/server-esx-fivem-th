TriggerEvent("esx:getSharedObject", function(obj)
	ESX = obj
end)

ESX.RegisterServerCallback('cc_damage:vehicleRob', function(source, cb, vehNet, vehiclePlate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local vehEnt = NetworkGetEntityFromNetworkId(vehNet)
	local vehPlateSv = GetVehicleNumberPlateText(
			vehEnt --[[ Vehicle ]]
	)
	vehPlateSv = string.gsub(vehPlateSv, "%s+$", "")
	vehiclePlate = string.gsub(vehiclePlate, "%s+$", "")
	if vehPlateSv == vehiclePlate then
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'RobVehicle',
				content = ('ผู้เล่น %s ทำการงัดรถทะเบียน %s'):format(xPlayer.name, vehPlateSv),
				source = xPlayer.source,
			})
		end) -- End log
		exports.nc_vehiclestorage:OpenStorage(xPlayer, "trunk", vehiclePlate, false)
		cb(true)
		return
	end
	cb(false)
end)