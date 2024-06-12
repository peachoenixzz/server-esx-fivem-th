RegisterNetEvent('okokRequests:ShowMenuData', function(id, time, title, message, trigger, side, parameters, parametersNum)
	TriggerClientEvent('okokRequests:ShowMenu', id, source, time, title, message, trigger, side, parameters, parametersNum)
end)

RegisterNetEvent('okokRequests:ExecuteClient', function(id, trigger, parameters, parametersNum)
	if parametersNum == 0 or parameters == nil or parametersNum == nil then
		TriggerClientEvent(trigger, id)
	elseif parametersNum == 1 then
		TriggerClientEvent(trigger, id, parameters)
	elseif parametersNum == 2 then
		local param1, param2 = parameters:match("([^,]+),([^,]+)")
		TriggerClientEvent(trigger, id, param1, param2)
	elseif parametersNum == 3 then
		local param1, param2, param3 = parameters:match("([^,]+),([^,]+),([^,]+)")
		TriggerClientEvent(trigger, id, param1, param2, param3)
	elseif parametersNum == 4 then
		local param1, param2, param3, param4 = parameters:match("([^,]+),([^,]+),([^,]+),([^,]+)")
		TriggerClientEvent(trigger, id, param1, param2, param3, param4)
	elseif parametersNum == 5 then
		local param1, param2, param3, param4, param5 = parameters:match("([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)")
		TriggerClientEvent(trigger, id, param1, param2, param3, param4, param5)
	end
end)

RegisterNetEvent('okokRequests:AcceptedMessage', function(id)
	--TriggerClientEvent('okokNotify:Alert', id, "ACCEPTED", GetPlayerName(source).." accepted!", 5000, 'success')
	exports.nc_notify:PushNotification(id,{
		scale = 1.2,  -- ปรับขนาดของ Notify
		title = 'ระบบ Request',  -- หัวเรื่อง
		description = 'ยอมรับ คำขอ แล้ว',  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'success',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'center',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'detail',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 5000  -- ระยะเวลาการแสดง Notify
	})
end)

RegisterNetEvent('okokRequests:DeniedMessage', function(id)
	TriggerClientEvent('okokNotify:Alert', id, "DENIED", GetPlayerName(source).." denied!", 5000, 'error')
	exports.nc_notify:PushNotification(id,{
		scale = 1.2,  -- ปรับขนาดของ Notify
		title = 'ระบบ Request',  -- หัวเรื่อง
		description = 'ปฎิเสธ คำขอ แล้ว',  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'danger',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'center',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'detail',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 5000  -- ระยะเวลาการแสดง Notify
	})
end)

RegisterNetEvent('okokRequests:ExpiredMessage', function(id)
	TriggerClientEvent('okokNotify:Alert', id, "EXPIRED", GetPlayerName(source).." didn't respond!", 5000, 'warning')
	exports.nc_notify:PushNotification(id,{
		scale = 1.2,  -- ปรับขนาดของ Notify
		title = 'ระบบ Request',  -- หัวเรื่อง
		description = 'ไม่ได้ตอบรับ คำขอ',  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'danger',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'center',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'warning',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'detail',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 5000  -- ระยะเวลาการแสดง Notify
	})
end)

RegisterNetEvent('okokRequests:BlockedMessage', function(id)
	TriggerClientEvent('okokNotify:Alert', id, "REQUEST", GetPlayerName(source).." blocked requests!", 5000, 'warning')
	exports.nc_notify:PushNotification(id,{
		scale = 1.2,  -- ปรับขนาดของ Notify
		title = 'ระบบ Request',  -- หัวเรื่อง
		description = 'คำขอ ถูกกีดกันไว้',  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'danger',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'center',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'warning',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'detail',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 5000  -- ระยะเวลาการแสดง Notify
	})
end)

RegisterNetEvent('okokRequests:SomeoneTriedMessage', function(id)
	TriggerClientEvent('okokNotify:Alert', source, "REQUEST", GetPlayerName(id).." tried to send you a request! Type '/requests' to unblock.", 5000, 'info')
	exports.nc_notify:PushNotification(id,{
		scale = 1.2,  -- ปรับขนาดของ Notify
		title = 'ระบบ Request',  -- หัวเรื่อง
		description = 'มีคนพยายามส่งคำขอ หากต้องการปลดล็อคพิมพ์ /request',  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'danger',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'center',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'warning',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'detail',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 5000  -- ระยะเวลาการแสดง Notify
	})
end)