-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

local NumberCharset, Charset = {}, {}
for i = 48,  57 do NumberCharset[#NumberCharset + 1] = string.char(i) end
for i = 65,  90 do Charset[#Charset + 1] = string.char(i) end
for i = 97, 122 do Charset[#Charset + 1] = string.char(i) end
local function GetRandomNumber(length)
	return length > 0 and (GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]) or ''
end
local function GetRandomLetter(length)
	return length > 0 and (GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]) or ''
end

-- mixing async with sync tasks
function IsPlateTaken(plate)
		MySQL.scalar('SELECT plate FROM owned_vehicles WHERE plate = ?', {plate},
				function(result)
					if result then
						return true
					else
						return false
					end
				end)
end

function GeneratePlate()
	local plate = string.upper('P'.. GetRandomLetter(2) .. 'K' .. GetRandomNumber(3))
	local isTaken = IsPlateTaken(plate)
	if isTaken then
		return GeneratePlate()
	end
	return plate
end


Config.DatabaseAddVehicle = function(xPlayer, model)
	while true do
		local plate = GeneratePlate()
		local result = MySQL.rawExecute.await('INSERT IGNORE INTO `owned_vehicles` (`owner`, `plate`, `vehicle`, `stored`, `job`) VALUES (?, ?, ?, ?, ?)', { xPlayer.identifier, plate, json.encode({ model = GetHashKey(model), plate = plate, engineHealth = 999.5, fuelLevel = 99.5, modTurbo = 1, modArmor = 4, modEngine = 3, modTransmission = 2, modBrakes = 2, modSuspension = 3 }), 1 , 'player' })
		if result.affectedRows == 1 then
			-- nc_vehiclekey
			pcall(function() exports.nc_vehiclekey:ReloadVehicleKey(plate) end)

			-- nc_garage
			pcall(function() 
				exports.nc_garage:ReloadVehicleOwner(plate)
				exports.nc_garage:SetVehicleStored(plate, 'main')
			end)

			-- nc_inventory
			pcall(function() exports.nc_inventory:AddItem(xPlayer.source, { name = plate, type = 'vehicle_key' }) end)
			
			return plate
		end
	end
end