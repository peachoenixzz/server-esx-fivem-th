TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterUsableItem('gov_vest', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.job.name == "police" then
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'UseVestGov',
				content = ('%s ทำการกดใช้ชุดเกราะ %s'):format(xPlayer.name, "gov_vest"),
				source = xPlayer.source,
			})
		end) -- End log
		TriggerClientEvent("armor:addGovermentVest", _source)
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'PlayerWearGovermentVest',
				content = ('%s อาชีพ %s ได้ทำการสวมใส่ gov_vest สำเร็จ'):format(xPlayer.name, xPlayer.job.name),
				source = xPlayer.source,
			})
		end) -- End log
	else
		exports.nc_notify:PushNotification(source,{
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบเกราะหน่วยงาน', -- หัวเรื่อง
			description = 'สามารถใช้ได้เฉพาะหน่วยงานเท่านั้น', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_group', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	end
end)

ESX.RegisterUsableItem('vest', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem("vest")
	if xPlayer then
		if xItem.count >= 1 then
			pcall(function() -- Start log
				exports['azael_dc-serverlogs']:insertData({
					event = 'UseArmorVest',
					content = ('%s ทำการกดใช้ %s มี %s ในกระเป๋าจำนวน %s ตัว'):format(xPlayer.name, "vest", "vest", xPlayer.getInventoryItem("vest").count),
					source = xPlayer.source,
				})
			end) -- End log
			TriggerClientEvent("cc_armor:vestPlayer", xPlayer.source,100,xItem.name)
			pcall(function() -- Start log
				exports['azael_dc-serverlogs']:insertData({
					 event = 'PlayerWearArmorVest',
					 content = ('%s อาชีพ %s ได้ทำการสวมใส่ %s สำเร็จ'):format(xPlayer.name, xPlayer.job.name, xItem.name),
					 source = xPlayer.source,
				})
			end) -- End log
		end
	end
end)

ESX.RegisterUsableItem('r_vest', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem("r_vest")
	if xPlayer then
		if xItem.count >= 1 then
			pcall(function() -- Start log
				exports['azael_dc-serverlogs']:insertData({
					event = 'UseRentalVest',
					content = ('%s ทำการกดใช้ชุดเกราะ %s'):format(xPlayer.name, "r_vest"),
					source = xPlayer.source,
				})
			end) -- End log
			TriggerClientEvent("cc_armor:vestPlayerTraining", xPlayer.source,100)
			pcall(function() -- Start log
				exports['azael_dc-serverlogs']:insertData({
					 event = 'PlayerWearRentalVest',
					 content = ('%s อาชีพ %s ได้ทำการสวมใส่ r_vest'):format(xPlayer.name, xPlayer.job.name),
					 source = xPlayer.source,
				})
			end) -- End log
		end
	end
end)

ESX.RegisterUsableItem('helmet', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem("helmet")
	if xPlayer then
		print(xItem.limit)
		if xItem.count >= 1 then
			pcall(function() -- Start log
				exports['azael_dc-serverlogs']:insertData({
					event = 'UseHelmet',
					content = ('%s ทำการกดใช้ %s มี %s ในกระเป๋าจำนวน %s ใบ'):format(xPlayer.name, "helmet",  "helmet", xPlayer.getInventoryItem("helmet").count),
					source = xPlayer.source,
				})
			end) -- End log
			TriggerClientEvent("cc_armor:useHelmet", xPlayer.source,xItem.name)
			pcall(function() -- Start log
				exports['azael_dc-serverlogs']:insertData({
					 event = 'PlayerWearHelmet',
					 content = ('%s อาชีพ %s ได้ทำการสวมใส่ %s สำเร็จ'):format(xPlayer.name, xPlayer.job.name, xItem.name),
					 source = xPlayer.source,
				})
			end) -- End log
		end
	end
end)

RegisterServerEvent('cc_armor:removeitem')
AddEventHandler('cc_armor:removeitem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(itemName, 1)
	pcall(function() -- Start log
		exports['azael_dc-serverlogs']:insertData({
			 event = 'RemoveArmourItem',
			 content = ('%s อาชีพ %s ได้สูญเสีย %s จำนวน 1 ชิ้น เหลือ %s ในกระเป๋าจำนวน %s ชิ้น'):format(xPlayer.name, xPlayer.job.name, itemName, itemName, xPlayer.getInventoryItem(itemName).count),
			 source = xPlayer.source,
		})
	end) -- End log
end)

ESX.RegisterServerCallback('cc_armor:finalcheckitem', function(source, cb, itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
    local xItem =   xPlayer.getInventoryItem(itemName)
	if xItem.count >= 1 then
		xPlayer.removeInventoryItem(xItem.name, 1)
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				 event = 'RemoveArmourItem',
				 content = ('%s อาชีพ %s ได้สูญเสีย %s จำนวน 1 ชิ้น เหลือ %s ในกระเป๋าจำนวน %s ชิ้น'):format(xPlayer.name, xPlayer.job.name, xItem.name, xItem.name, xPlayer.getInventoryItem(itemName).count),
				 source = xPlayer.source,
			})
		end) -- End log
		cb(true)
		return
	end
	cb(false)
end)
