ESX.RegisterUsableItem('blowpipe', function(source)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('blowpipe', 1)

	TriggerClientEvent('esx_mechanicjob:onHijack', source)
	--TriggerClientEvent('esx:showNotification', source, TranslateCap('you_used_blowtorch'))
end)

ESX.RegisterUsableItem('gov_toolkit', function(source)
	if isPlayerInVehicle(source) then
		exports.nc_notify:PushNotification(source,{
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบซ่อมรถ', -- หัวเรื่อง
			description = 'ไม่สามารถทำรายการได้ในขณะนี้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_toolkit', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
		return
	end
	TriggerClientEvent('esx_mechanicjob:checkPlayerInVehicle', source,"gov_toolkit")
	--xPlayer.removeInventoryItem('gov_toolkit', 1)
	--TriggerClientEvent('esx:showNotification', source, TranslateCap('you_used_repair_kit'))
end)

ESX.RegisterUsableItem('veh_towel', function(source)
	if isPlayerInVehicle(source) then
		exports.nc_notify:PushNotification(source,{
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบล้างรถ', -- หัวเรื่อง
			description = 'ไม่สามารถทำรายการได้ในขณะนี้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_toolkit', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
		return
	end

	TriggerClientEvent('esx_mechanicjob:checkPlayerInVehicle', source,"veh_towel")
	--TriggerClientEvent('esx:showNotification', source, TranslateCap('you_used_body_kit'))
end)

ESX.RegisterUsableItem('toolkit', function(source)
	if isPlayerInVehicle(source) then
		exports.nc_notify:PushNotification(source,{
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบซ่อมรถ', -- หัวเรื่อง
			description = 'ไม่สามารถทำรายการได้ในขณะนี้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_toolkit', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
		return
	end

	TriggerClientEvent('esx_mechanicjob:checkPlayerInVehicle', source,"toolkit")
	--TriggerClientEvent('esx:showNotification', source, TranslateCap('you_used_body_kit'))
end)

ESX.RegisterServerCallback('esx_mechanicjob:finalcheckitem', function(source, cb, itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
    local xItem =   xPlayer.getInventoryItem(itemName)
	if xItem.count >= 1 then
		xPlayer.removeInventoryItem(xItem.name, 1)
		cb(true)
		return
	end
	cb(false)
end)

ESX.RegisterServerCallback('esx_mechanicjob:validateBeforeRepair', function(source, cb, itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	--print(itemName)
	if itemName ~= "toolkit" and itemName ~= "gov_toolkit" and itemName ~= "veh_towel" then return end -- validate injection by client
	--print("here")
	local xItem = xPlayer.getInventoryItem(itemName)
	if xItem.count <= 0 then
		cb(false)
		return
	end
	if itemName == "gov_toolkit" then
		--xPlayer.removeInventoryItem('gov_toolkit', 1)
		exports['azael_dc-serverlogs']:insertData({ -- Start log
		event = 'UseToolKit',
		content = ('%s อาชีพ %s ได้ใช้ %s และสูญเสีย %s จำนวน 1 ชิ้น เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, xPlayer.job.name, itemName, itemName, itemName, xPlayer.getInventoryItem(itemName).count),
		source = xPlayer.source,
	}) -- End log
		TriggerClientEvent('esx_mechanicjob:onCarokit', source)
		cb("onCarKitGov")
		return
	end
	if itemName == "toolkit" then
		exports['azael_dc-serverlogs']:insertData({ -- Start log
			event = 'UseToolKit',
			content = ('%s อาชีพ %s ได้ใช้ %s และสูญเสีย %s จำนวน 1 ชิ้น เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, xPlayer.job.name, itemName, itemName, itemName, xPlayer.getInventoryItem(itemName).count),
			source = xPlayer.source,
		}) -- End log
		TriggerClientEvent('esx_mechanicjob:onCarokit', source)
		cb("onCarKit")
		return
	end
	if itemName == "veh_towel" then
		exports['azael_dc-serverlogs']:insertData({ -- Start log
			event = 'UseVehTowel',
			content = ('%s อาชีพ %s ได้ใช้ %s และสูญเสีย %s จำนวน 1 ชิ้น เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, xPlayer.job.name, itemName, itemName, itemName, xPlayer.getInventoryItem(itemName).count),
			source = xPlayer.source,
		}) -- End log
		cb("carWash")
		return
	end
end)

function isPlayerInVehicle(player)
	local ped = GetPlayerPed(player)
	local vehicle = GetVehiclePedIsIn(ped, false)
	print(vehicle)
	if DoesEntityExist(vehicle) then
		print("that true")
		return true
	else
		print("that false")
		return false
	end
end
