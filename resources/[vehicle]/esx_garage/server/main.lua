RegisterServerEvent('esx_garage:updateOwnedVehicle')
AddEventHandler('esx_garage:updateOwnedVehicle', function(stored, parking, Impound, data, spawn)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	MySQL.update('UPDATE owned_vehicles SET `stored` = @stored, `parking` = @parking, `pound` = @Impound, `vehicle` = @vehicle WHERE `plate` = @plate AND `owner` = @identifier',
			{
				['@identifier'] = xPlayer.identifier,
				['@vehicle'] 	= json.encode(data.vehicleProps),
				['@plate'] 		= data.vehicleProps.plate,
				['@stored']     = stored,
				['@parking']    = parking,
				['@Impound']    = Impound,
			})
	--print(data.vehicleProps.model)
	--print(json.encode(data.vehicleProps))
	if stored then
		onVehicleStored(source)
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(source), false)
		if DoesEntityExist(vehicle) then
			DeleteEntity(vehicle)
		end
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'StoredVehicleInGarage',
				content = ('%s อาชีพ %s ยศ %s ได้ทำการเก็บ %s ทะเบียน %s เข้าโรงรถ %s '):format(xPlayer.name,xPlayer.job.name, xPlayer.job.grade_name, data.vehicleProps.model ,data.vehicleProps.plate, parking),
				source = xPlayer.source,
			})
		end) -- End log
	end
end)

RegisterServerEvent('esx_garage:vehiclePound')
AddEventHandler('esx_garage:vehiclePound', function(stored, parking, Impound, data, spawn)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	MySQL.update('UPDATE owned_vehicles SET  stored = @stored WHERE `plate` = @plate AND `owner` = @identifier',
			{
				['@identifier'] = xPlayer.identifier,
				['@plate'] 		= data.vehicleProps.plate,
				['@stored']     = stored,
			})
	pcall(function() -- Start log
		exports['azael_dc-serverlogs']:insertData({
			event = 'ImPoundVehicle',
			content = ('%s อาชีพ %s ยศ %s ได้ทำการอิมพาว %s ทะเบียน %s จากโรงรถ %s'):format(xPlayer.name,xPlayer.job.name, xPlayer.job.grade_name, data.vehicleProps.model ,data.vehicleProps.plate, parking),
			source = xPlayer.source,
		})
	end) -- End log
end)

ESX.RegisterServerCallback('esx_garage:openTrunk', function(source,cb,vehData)
	-- เปิดช่องเก็บของ (ระบบจะสั่งเปิดหน้ากระเป๋าเองอัตโนมัติ)
	local xPlayer  = ESX.GetPlayerFromId(source)
	--print(vehData.plate)
	exports.nc_vehiclestorage:OpenStorage(xPlayer, "trunk", vehData.plate, true)
	-- xPlayer: object คือ xPlayer ของผู้เล่น
	-- storageType: string คือชนิดของช่องเก็บของ (inside|trunk)
	-- plate: string คือทะเบียนยานพาหนะ
	-- checkOwner: boolean คือการตรวจสอบความเป็นเจ้าของยานพาหนะทะเบียนนั้นๆ
	cb()
end)

ESX.RegisterServerCallback('esx_garage:vehicleOutGarage', function(source,cb,stored, parking, Impound, data, spawn)
	local xPlayer  = ESX.GetPlayerFromId(source)
	--ESX.OneSync.SpawnVehicle(data.vehicleProps.model, spawn, data.spawnPoint.heading,data.vehicleProps, function(vehicle)
	--	local vehicle = NetworkGetEntityFromNetworkId(vehicle)
	MySQL.update.await('UPDATE owned_vehicles SET  stored = @stored WHERE `plate` = @plate AND `owner` = @identifier',
			{
				['@identifier'] = xPlayer.identifier,
				['@plate'] 		= data.vehicleProps.plate,
				['@stored']     = stored,
			})
	MySQL.single('SELECT `vehicle`,`job` FROM `owned_vehicles` WHERE `owner` = @identifier AND `plate` = @plate ',
			{
				['@identifier'] 	= xPlayer.identifier,
				['@plate'] = data.vehicleProps.plate,
			}, function(result)
				exports.nc_vehiclekey:ReloadVehicleKey(data.vehicleProps.plate)
				cb(json.decode(result.vehicle),result.job)
			end)
	--Wait(300)
	--SetVehicleEngineHealth(vehicle, data.vehicleProps.engineHealth)
	--SetVehicleFuelLevel(vehicle, data.vehicleProps.fuelLevel)
	pcall(function() -- Start log
		exports['azael_dc-serverlogs']:insertData({
			event = 'GetVehicleOutGarage',
			content = ('%s อาชีพ %s ยศ %s ได้นำ %s ทะเบียน %s ออกจากโรงรถ %s'):format(xPlayer.name,xPlayer.job.name, xPlayer.job.grade_name, data.vehicleProps.model ,data.vehicleProps.plate, parking),
			source = xPlayer.source,
		})
	end) -- End log
end)
--end)

RegisterServerEvent('esx_garage:setImpound')
AddEventHandler('esx_garage:setImpound', function(Impound, vehicleProps)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	MySQL.update('UPDATE owned_vehicles SET `stored` = @stored, `pound` = @Impound, `vehicle` = @vehicle WHERE `plate` = @plate AND `owner` = @identifier',
			{
				['@identifier'] = xPlayer.identifier,
				['@vehicle'] 	= json.encode(vehicleProps),
				['@plate'] 		= vehicleProps.plate,
				['@stored']     = 2,
				['@Impound']    	= Impound
			})
	--xPlayer.showNotification(TranslateCap('veh_impounded'))
end)

ESX.RegisterServerCallback('esx_garage:getVehiclesInParking', function(source, cb, parking)
	local xPlayer  = ESX.GetPlayerFromId(source)
	--print(xPlayer.identifier)
	MySQL.query('SELECT vehicle,plate FROM `owned_vehicles` WHERE `owner` = @identifier AND `stored` = 1 AND `job` = "player" AND `type` = "car"  ',
			{
				['@identifier'] 	= xPlayer.identifier,
			}, function(result)
				local vehicles = {}
				for i = 1, #result, 1 do
					table.insert(vehicles, {
						vehicle 	= json.decode(result[i].vehicle),
						plate 		= result[i].plate
					})
				end
				cb(vehicles)
			end)
end)

ESX.RegisterServerCallback('esx_garage:getVehiclesInParkingCustom', function(source, cb, parking)
	local xPlayer  = ESX.GetPlayerFromId(source)
	--print(xPlayer.identifier)
	MySQL.query('SELECT vehicle,plate FROM `owned_vehicles` WHERE `owner` = @identifier AND `stored` = 1 AND `type` = "car"  ',
			{
				['@identifier'] 	= xPlayer.identifier,
			}, function(result)
				local vehicles = {}
				for i = 1, #result, 1 do
					table.insert(vehicles, {
						vehicle 	= json.decode(result[i].vehicle),
						plate 		= result[i].plate
					})
				end
				cb(vehicles)
			end)
end)

ESX.RegisterServerCallback('esx_garage:getVehiclesInTrunk', function(source, cb, parking)
	local xPlayer  = ESX.GetPlayerFromId(source)
	--print(xPlayer.identifier)
	MySQL.query('SELECT vehicle,plate FROM `owned_vehicles` WHERE `owner` = @identifier AND `stored` = 1 AND `type` = "car"  ',
			{
				['@identifier'] 	= xPlayer.identifier,
			}, function(result)
				local vehicles = {}
				for i = 1, #result, 1 do
					table.insert(vehicles, {
						vehicle 	= json.decode(result[i].vehicle),
						plate 		= result[i].plate
					})
				end
				cb(vehicles)
			end)
end)

ESX.RegisterServerCallback('esx_garage:getVehiclesInParkingBoat', function(source, cb, parking)
	local xPlayer  = ESX.GetPlayerFromId(source)
	--print(xPlayer.identifier)
	MySQL.query('SELECT vehicle,plate FROM `owned_vehicles` WHERE `owner` = @identifier AND `stored` = 1 AND `job` = "player" AND `type` = "boat" ',
			{
				['@identifier'] 	= xPlayer.identifier,
			}, function(result)
				local vehicles = {}
				for i = 1, #result, 1 do
					table.insert(vehicles, {
						vehicle 	= json.decode(result[i].vehicle),
						plate 		= result[i].plate
					})
				end
				cb(vehicles)
			end)
end)

ESX.RegisterServerCallback('esx_garage:getVehiclesInParkingPolice', function(source, cb, parking)
	local xPlayer  = ESX.GetPlayerFromId(source)
	--print(xPlayer.identifier)
	MySQL.query('SELECT vehicle,plate FROM `owned_vehicles` WHERE `owner` = @identifier AND `stored` = 1 AND `job` = "sos" and `type` != "helicopter"  ',
			{
				['@identifier'] 	= xPlayer.identifier,
			}, function(result)
				local vehicles = {}
				for i = 1, #result, 1 do
					table.insert(vehicles, {
						vehicle 	= json.decode(result[i].vehicle),
						plate 		= result[i].plate
					})
				end
				cb(vehicles)
			end)
end)

ESX.RegisterServerCallback('esx_garage:getVehiclesInParkingAmbulance', function(source, cb, parking)
	local xPlayer  = ESX.GetPlayerFromId(source)
	--print(xPlayer.identifier)
	MySQL.query('SELECT vehicle,plate FROM `owned_vehicles` WHERE `owner` = @identifier AND `stored` = 1 AND `job` = "sos" and `type` != "helicopter" ',
			{
				['@identifier'] 	= xPlayer.identifier,
			}, function(result)
				local vehicles = {}
				for i = 1, #result, 1 do
					table.insert(vehicles, {
						vehicle 	= json.decode(result[i].vehicle),
						plate 		= result[i].plate
					})
				end
				cb(vehicles)
			end)
end)


ESX.RegisterServerCallback('esx_garage:getVehiclesInParkingCircle', function(source, cb, parking)
	local xPlayer  = ESX.GetPlayerFromId(source)
	--print(xPlayer.identifier)
	MySQL.query('SELECT vehicle,plate FROM `owned_vehicles` WHERE `owner` = @identifier AND `stored` = 1 AND `job` = "circle" and `type` != "helicopter"  ',
			{
				['@identifier'] 	= xPlayer.identifier,
			}, function(result)
				local vehicles = {}
				for i = 1, #result, 1 do
					table.insert(vehicles, {
						vehicle 	= json.decode(result[i].vehicle),
						plate 		= result[i].plate
					})
				end
				cb(vehicles)
			end)
end)

ESX.RegisterServerCallback('esx_garage:getVehiclesInParkingHelicopterCircle', function(source, cb, parking)
	local xPlayer  = ESX.GetPlayerFromId(source)
	--print(xPlayer.identifier)
	MySQL.query('SELECT vehicle,plate FROM `owned_vehicles` WHERE (`owner` = @identifier) AND `stored` = 1 AND `job` = "circle" AND `type`= "helicopter" ',
			{
				['@identifier'] 	= xPlayer.identifier,
			}, function(result)
				local vehicles = {}
				for i = 1, #result, 1 do
					table.insert(vehicles, {
						vehicle 	= json.decode(result[i].vehicle),
						plate 		= result[i].plate
					})
				end
				cb(vehicles)
			end)
end)


ESX.RegisterServerCallback('esx_garage:getVehiclesInParkingHelicopterPolice', function(source, cb, parking)
	local xPlayer  = ESX.GetPlayerFromId(source)
	--print(xPlayer.identifier)
	MySQL.query('SELECT vehicle,plate FROM `owned_vehicles` WHERE (`owner` = @identifier) AND `stored` = 1 AND `job` = "sos" AND `type`= "helicopter" ',
			{
				['@identifier'] 	= xPlayer.identifier,
			}, function(result)
				local vehicles = {}
				for i = 1, #result, 1 do
					table.insert(vehicles, {
						vehicle 	= json.decode(result[i].vehicle),
						plate 		= result[i].plate
					})
				end
				cb(vehicles)
			end)
end)

ESX.RegisterServerCallback('esx_garage:getVehiclesInParkingHelicopterAmbulance', function(source, cb, parking)
	local xPlayer  = ESX.GetPlayerFromId(source)
	--print(xPlayer.identifier)
	MySQL.query('SELECT vehicle,plate FROM `owned_vehicles` WHERE (`owner` = @identifier) AND `stored` = 1 AND `job` = "sos" AND `type`= "helicopter" ',
			{
				['@identifier'] 	= xPlayer.identifier,
			}, function(result)
				local vehicles = {}
				for i = 1, #result, 1 do
					table.insert(vehicles, {
						vehicle 	= json.decode(result[i].vehicle),
						plate 		= result[i].plate
					})
				end
				cb(vehicles)
			end)
end)

ESX.RegisterServerCallback('esx_garage:checkVehicleOwner', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	--print(xPlayer.identifier)
	MySQL.query('SELECT COUNT(*) as count FROM `owned_vehicles` WHERE `owner` = @identifier AND `plate` = @plate',
			{
				['@identifier'] 	= xPlayer.identifier,
				['@plate']     		= plate
			}, function(result)
				if tonumber(result[1].count) > 0 then
					return cb(true)
				else
					return cb(false)
				end
			end)
end)

ESX.RegisterServerCallback('esx_garage:getCountVehicle', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)

	local countVehicleInGarage = MySQL.single.await('SELECT count(stored) as stored FROM `owned_vehicles` WHERE `owner` = ? AND `stored` = 1  AND `job` = "player"', {xPlayer.identifier})
	local countVehicleInPound = MySQL.single.await('SELECT count(stored) as stored FROM `owned_vehicles` WHERE `owner` = ? AND `stored` = 2 AND `job` = "player"', {xPlayer.identifier})
	if countVehicleInGarage and countVehicleInPound then
		--print("can count Vehicle")
		--print(countVehicleInGarage.stored,countVehicleInPound.stored)
		cb(countVehicleInGarage.stored,countVehicleInPound.stored)
		return
	end
	if not countVehicleInGarage or not countVehicleInPound then
		--print("cannot count Vehicle")
		cb(0,0)
	end
end)

ESX.RegisterServerCallback('esx_garage:getCountVehicleDepartment', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local countVehicleInGarage = MySQL.single.await('SELECT count(stored) as stored FROM `owned_vehicles` WHERE `owner` = ? AND `stored` = 1 AND `job` = "police" OR `job` = "sos"', {xPlayer.identifier})
	local countVehicleInPound = MySQL.single.await('SELECT count(stored) as stored FROM `owned_vehicles` WHERE `owner` = ? AND `stored` = 2 AND `job` = "police" OR `job` = "sos"', {xPlayer.identifier})
	if countVehicleInGarage and countVehicleInPound then
		--print("can count Vehicle")
		print(countVehicleInGarage.stored,countVehicleInPound.stored)
		cb(countVehicleInGarage.stored,countVehicleInPound.stored)
		return
	end
	if not countVehicleInGarage or not countVehicleInPound then
		--print("cannot count Vehicle")
		cb(0,0)
	end
end)

-- Pounds part
ESX.RegisterServerCallback('esx_garage:getVehiclesImpounded', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)
	MySQL.query('SELECT * FROM `owned_vehicles` WHERE `owner` = @identifier AND `stored` = 0',
			{
				['@identifier'] 	= xPlayer.identifier,
			}, function(result)
				local vehicles = {}

				for i = 1, #result, 1 do
					table.insert(vehicles, {
						vehicle 	= json.decode(result[i].vehicle),
						plate 		= result[i].plate
					})
				end

				cb(vehicles)
			end)
end)

ESX.RegisterServerCallback('esx_garage:getVehiclesInPound', function(source, cb, Impound)
	local xPlayer  = ESX.GetPlayerFromId(source)
	MySQL.query('SELECT vehicle,plate FROM `owned_vehicles` WHERE `owner` = @identifier AND `stored` = 2 and `job` = "player" AND type ="car" ',
			{
				['@identifier'] 	= xPlayer.identifier,
			}, function(result)
				local vehicles = {}

				for i = 1, #result, 1 do
					table.insert(vehicles, {
						vehicle 	= json.decode(result[i].vehicle),
						plate 		= result[i].plate
					})
				end
				cb(vehicles)
			end)
end)

ESX.RegisterServerCallback('esx_garage:getVehiclesInPoundDepartment', function(source, cb, Impound)
	local xPlayer  = ESX.GetPlayerFromId(source)
	--print(xPlayer.identifier)
	MySQL.query('SELECT vehicle,plate FROM `owned_vehicles` WHERE `owner` = @identifier  AND `stored` = 2 AND `job` IN("police","ambulance","circle","sos")',
			{
				['@identifier'] 	= xPlayer.identifier,
			}, function(result)
				local vehicles = {}
				print(#result)
				for i = 1, #result, 1 do
					table.insert(vehicles, {
						vehicle 	= json.decode(result[i].vehicle),
						plate 		= result[i].plate
					})
				end

				cb(vehicles)
			end)
end)

ESX.RegisterServerCallback('esx_garage:getVehiclesInPoundBoat', function(source, cb, Impound)
	local xPlayer  = ESX.GetPlayerFromId(source)
	--print(xPlayer.identifier)
	MySQL.query('SELECT vehicle,plate FROM `owned_vehicles` WHERE `owner` = @identifier AND `stored` = 2 AND type = "boat" ',
			{
				['@identifier'] 	= xPlayer.identifier,
			}, function(result)
				local vehicles = {}

				for i = 1, #result, 1 do
					table.insert(vehicles, {
						vehicle 	= json.decode(result[i].vehicle),
						plate 		= result[i].plate
					})
				end

				cb(vehicles)
			end)
end)

ESX.RegisterServerCallback('esx_garage:playerCoords', function(source, cb)
	local xPlayer = source and ESX.GetPlayerFromId(source)
	-- For Log Purpose
	local playerped = GetPlayerPed(source)
	local playerCoords = GetEntityCoords(playerped)
	pcall(function() -- Start Log ยังไม่เสร็จ
		exports['azael_dc-serverlogs']:insertData({
			event = 'repairCoords',
			content = ('%s พิกัด %s'):format(xPlayer.name, playerCoords),
			source = xPlayer.source,
		})
	end) -- End Log
	cb(playerCoords)
end)

ESX.RegisterServerCallback('esx_garage:checkStatePlayer', function(source, cb, amount,plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local allVeh = GetAllVehicles()
	local entity = nil
	for _,v in pairs(allVeh) do
		local vehiclePlate = splitWordWhiteSpace(GetVehicleNumberPlateText(v))
		local uiPlate = splitWordWhiteSpace(plate)
		--print(vehiclePlate == uiPlate)
		if vehiclePlate == uiPlate then
			for seat = -1, 8 do -- Loop through all possible seats
				local player = GetPedInVehicleSeat(v, seat)
				if player ~= 0 then
					onCannotImpoundCarInUse(source)
					cb(xPlayer.getMoney() >= amount,true)
					return
				end
			end
			DeleteEntity(v)
		end
	end
	cb(xPlayer.getMoney() >= amount,false)
end)


ESX.RegisterServerCallback('esx_garage:checkRepair', function(source, cb, amount, veh,vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)
	local missmoney = amount - xPlayer.getMoney()

	if xPlayer.getAccount('money').money >= amount then
		xPlayer.removeAccountMoney('money',  ESX.Math.Round(amount))
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'PayRepairFee',
				content = ('%s อาชีพ %s ยศ %s ได้ทำการจ่ายเงินค่าบริการอู่ซ่อมรถจำนวน $%s เหลือเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name,xPlayer.job.name, xPlayer.job.grade_name, amount, ESX.Math.GroupDigits(xPlayer.getMoney())),
				source = xPlayer.source,
			})
		end) -- End log
		if amount == 500 then
			TriggerClientEvent('esx_garage:repairVehicle', -1, veh,vehicleProps)
		end
		if amount == 200 then
			TriggerClientEvent('esx_garage:cleanVehicle', -1, veh,vehicleProps)
		end
		cb(xPlayer.getAccount('money').money >= amount)
		return
	end

	onNoMoneyToRepaireVehicle(source)

	pcall(function() -- Start log
		exports['azael_dc-serverlogs']:insertData({
			event = 'NoMoneyToPayRepairFee',
			content = ('%s อาชีพ %s ยศ %s มีเงินไม่เพียงพอที่จะจ่ายเงินค่าบริการอู่ซ่อมรถจำนวน $%s เหลือเงินในกระเป๋าจำนวน $%s ต้องการเงินเพิ่มอีกจำนวน $%s'):format(xPlayer.name,xPlayer.job.name, xPlayer.job.grade_name, amount, ESX.Math.GroupDigits(xPlayer.getMoney()), missmoney),
			source = xPlayer.source,
		})
	end) -- End log
	cb(xPlayer.getAccount('money').money >= amount)
end)

RegisterServerEvent("esx_garage:payPound")
AddEventHandler("esx_garage:payPound", function(amount)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)


	if xPlayer.getMoney() >= amount then
		xPlayer.removeMoney(amount, "Impound Fee")
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'PayImpoundFee',
				content = ('%s อาชีพ %s ยศ %s ได้ทำการจ่ายเงินจำนวน $%s ค่าพาวรถจากอิมพาว เหลือเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name,xPlayer.job.name, xPlayer.job.grade_name, amount, ESX.Math.GroupDigits(xPlayer.getMoney())),
				source = xPlayer.source,
			})
		end) -- End log
		--xPlayer.showNotification(TranslateCap('pay_Impound_bill', amount))
	else

	end
end)

function splitWordWhiteSpace(str)
	local words = {}
	for word in str:gmatch("%w+") do
		table.insert(words, word)
	end
	local result = table.concat(words)
	return result
end



function onVehicleStored(source)
	exports.nc_notify:PushNotification(source,{
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบโรงรถ', -- หัวเรื่อง
		description = 'เก็บยานพาหนะเรียบร้อยแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'success',
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'garage', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end

function onNoMoneyToRepaireVehicle(source)
	exports.nc_notify:PushNotification(source,{
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบซ่อมรถ', -- หัวเรื่อง
		description = 'คุณมีเงินไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning',
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'no_money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end

function onCannotImpoundCarInUse(source)
	exports.nc_notify:PushNotification(source,{
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบอิมพาว', -- หัวเรื่อง
		description = 'ไม่สามารถทำรายการได้ มีผู้ใช้งานอยู่ในขณะนี้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'no_garage', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end