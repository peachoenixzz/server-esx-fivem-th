local responded = false
local blockrequests = false
local source, time, title, message, trigger, ClientOrServer, parameters, parametersNum

-- Request
RegisterNetEvent('okokRequests:ShowMenu')
AddEventHandler('okokRequests:ShowMenu', function(sourceS, timeS, titleS, messageS, triggerS, ClientOrServerS, parametersS, parametersNumS)
	source, time, title, message, trigger, ClientOrServer, parameters, parametersNum = sourceS, timeS, titleS, messageS, triggerS, ClientOrServerS, parametersS, parametersNumS
	if not blockrequests then
		SetNuiFocus(false, false)
		SendNUIMessage({
			action = 'open',
			title = title,
			message = message,
		})
		responded = false

		local targetTime = GetGameTimer() + 60000
			while GetGameTimer() < targetTime do
				if IsControlJustPressed(0,20) then
					responded = true
					if GetPlayerServerId(PlayerId()) ~= source then
						TriggerServerEvent("okokRequests:AcceptedMessage", source)
					end
					exports.nc_notify:PushNotification({
						scale = 1.2,  -- ปรับขนาดของ Notify
						title = 'ระบบ Request',  -- หัวเรื่อง
						description = 'คุณยอมรับ คำขอ แล้ว',  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
						type = 'success',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
						position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
						direction = 'center',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
						priority = 'medium',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
						icon = 'detail',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
						duration = 5000  -- ระยะเวลาการแสดง Notify
					})
					SendNUIMessage({
						action = 'close',
					})
					SetNuiFocus(false, false)
					if ClientOrServer:lower() == "server" then
						if parametersNum == 0 or parameters == nil or parametersNum == nil then
							TriggerServerEvent(trigger)
						elseif parametersNum == 1 then
							TriggerServerEvent(trigger, parameters)
						elseif parametersNum == 2 then
							local param1, param2 = parameters:match("([^,]+),([^,]+)")
							TriggerServerEvent(trigger, param1, param2)
						elseif parametersNum == 3 then
							local param1, param2, param3 = parameters:match("([^,]+),([^,]+),([^,]+)")
							TriggerServerEvent(trigger, param1, param2, param3)
						elseif parametersNum == 4 then
							local param1, param2, param3, param4 = parameters:match("([^,]+),([^,]+),([^,]+),([^,]+)")
							TriggerServerEvent(trigger, param1, param2, param3, param4)
						elseif parametersNum == 5 then
							local param1, param2, param3, param4, param5 = parameters:match("([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)")
							TriggerServerEvent(trigger, param1, param2, param3, param4, param5)
						end
					else
						TriggerServerEvent("okokRequests:ExecuteClient",source, trigger, parameters, parametersNum)
					end
				end
				if IsControlJustPressed(0,73) then
					break
				end
				if responded then
					break
				end
				Wait(0)
			end
		if not responded then
			TriggerServerEvent("okokRequests:ExpiredMessage", source)
			exports.nc_notify:PushNotification({
				scale = 1.2,  -- ปรับขนาดของ Notify
				title = 'ระบบ Request',  -- หัวเรื่อง
				description = 'คุณไม่ได้ตอบรับ คำขอ',  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
				type = 'warning',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
				position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
				direction = 'center',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
				priority = 'medium',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
				icon = 'detail',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
				duration = 5000  -- ระยะเวลาการแสดง Notify
			})
			SetNuiFocus(false, false)
			SendNUIMessage({
				action = 'close',
			})
		end
	else
		TriggerServerEvent("okokRequests:BlockedMessage", source)
		TriggerServerEvent("okokRequests:SomeoneTriedMessage", source)
	end
end)

RegisterNUICallback("action", function(data, cb)
	if data.action == "acceptRequest" then
		responded = true
		if GetPlayerServerId(PlayerId()) ~= source then
			TriggerServerEvent("okokRequests:AcceptedMessage", source)
		end
		exports.nc_notify:PushNotification({
			scale = 1.2,  -- ปรับขนาดของ Notify
			title = 'ระบบ Request',  -- หัวเรื่อง
			description = 'คุณยอมรับ คำขอ แล้ว',  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'success',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'center',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'detail',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 5000  -- ระยะเวลาการแสดง Notify
		})
		SetNuiFocus(false, false)
		if ClientOrServer:lower() == "server" then
			if parametersNum == 0 or parameters == nil or parametersNum == nil then
				TriggerServerEvent(trigger)
			elseif parametersNum == 1 then
				TriggerServerEvent(trigger, parameters)
			elseif parametersNum == 2 then
				local param1, param2 = parameters:match("([^,]+),([^,]+)")
				TriggerServerEvent(trigger, param1, param2)
			elseif parametersNum == 3 then
				local param1, param2, param3 = parameters:match("([^,]+),([^,]+),([^,]+)")
				TriggerServerEvent(trigger, param1, param2, param3)
			elseif parametersNum == 4 then
				local param1, param2, param3, param4 = parameters:match("([^,]+),([^,]+),([^,]+),([^,]+)")
				TriggerServerEvent(trigger, param1, param2, param3, param4)
			elseif parametersNum == 5 then
				local param1, param2, param3, param4, param5 = parameters:match("([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)")
				TriggerServerEvent(trigger, param1, param2, param3, param4, param5)
			end
		else
			TriggerServerEvent("okokRequests:ExecuteClient",source, trigger, parameters, parametersNum)
		end
	elseif data.action == "declineRequest" or data.action == "closeEsc" then
		responded = true
		TriggerServerEvent("okokRequests:DeniedMessage", source)
		exports.nc_notify:PushNotification({
			scale = 1.2,  -- ปรับขนาดของ Notify
			title = 'ระบบ Request',  -- หัวเรื่อง
			description = 'คุณปฎิเสธ คำขอ แล้ว',  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'danger',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'center',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'detail',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 5000  -- ระยะเวลาการแสดง Notify
		})
		SetNuiFocus(false, false)
	elseif data.action == "saveBlockRequest" then
		SetNuiFocus(false, false)
		if data.status == "disabled" then
			blockrequests = true
			exports.nc_notify:PushNotification({
				scale = 1.2,  -- ปรับขนาดของ Notify
				title = 'ระบบ Request',  -- หัวเรื่อง
				description = 'ปิดการรับ คำขอ แล้ว',  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
				type = 'success',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
				position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
				direction = 'center',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
				priority = 'medium',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
				icon = 'detail',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
				duration = 5000  -- ระยะเวลาการแสดง Notify
			})
		elseif data.status == "enabled" then
			blockrequests = false
			exports.nc_notify:PushNotification({
				scale = 1.2,  -- ปรับขนาดของ Notify
				title = 'ระบบ Request',  -- หัวเรื่อง
				description = 'เปิดการรับ คำขอ แล้ว',  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
				type = 'success',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
				position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
				direction = 'center',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
				priority = 'medium',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
				icon = 'detail',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
				duration = 5000  -- ระยะเวลาการแสดง Notify
			})
		end
	elseif data.action == "closeBlockRequest" or data.action == "closeBlockEsc" then
		SetNuiFocus(false, false)
	end
	cb('ok')
end)

-- Block Request
RegisterCommand("requests", function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'openblock',
		status = blockrequests,
	})
end, false)

-- Triggers
function requestMenu(id, time, title, message, trigger, side, parameters, parametersNum)
	TriggerServerEvent('okokRequests:ShowMenuData', id, time, title, message, trigger, side, parameters, parametersNum)
	exports.nc_notify:PushNotification({
		scale = 1.2,  -- ปรับขนาดของ Notify
		title = 'ระบบ Request',  -- หัวเรื่อง
		description = 'ข้อความส่งถึงผู้รับเรียบร้อยแล้ว',  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'success',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'center',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'detail',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 5000  -- ระยะเวลาการแสดง Notify
	})
end

RegisterNetEvent('okokRequests:RequestMenu')
AddEventHandler('okokRequests:RequestMenu', function(id, time, title, message, trigger, side, parameters, parametersNum)
	requestMenu(id, time, title, message, trigger, side, parameters, parametersNum)
end)