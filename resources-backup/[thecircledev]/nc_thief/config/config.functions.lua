-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

---------------------------------------------------
------------------- Server Side -------------------
---------------------------------------------------

-- Function นี้จะถูกเรียกใช้ก่อนให้ผู้เล่นเปิดกระเป๋า(ปล้น)ผู้อื่น [ โดยจะส่งค่ามาเป็น xRobber: xPlayer ของผู้ปล้น | xTarget: xPlayer ของผู้ถูกปล้น ]
Config.ServerWillRobPlayer = function(xRobber, xTarget)
	exports['azael_dc-serverlogs']:insertData({
		event = 'RobPlayer',
		content = ('%s ได้ทำการปล้น %s'):format(xRobber.name, xTarget.name),
		source = xRobber.source,
	})
	return true			-- true: เมื่อ "ต้องการ" ให้ผู้เล่นเปิดกระเป๋า(ปล้น)ผู้อื่นได้ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นเปิดกระเป๋า(ปล้น)ผู้อื่นได้
end

-- Function นี้จะถูกเรียกใช้เมื่อผู้เล่นสามารถเปิดกระเป๋า(ปล้น)ผู้อื่นได้ [ โดยจะส่งค่ามาเป็น xRobber: xPlayer ของผู้ปล้น | xTarget: xPlayer ของผู้ถูกปล้น ]
Config.ServerRobPlayer = function(xRobber, xTarget)
	exports['azael_dc-serverlogs']:insertData({
		event = 'GotRobbed',
		content = ('%s ได้ถูก %s ปล้น'):format(xTarget.name, xRobber.name),
		source = xTarget.source,
	})
	onGotRobbed(xTarget.source)
end

function onGotRobbed(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบปล้น', -- หัวเรื่อง
        description = 'คุณกำลังถูกปล้นไม่สามารถขยับตัวได้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'theif', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 5000 -- ระยะเวลาการแสดง Notify
    })
end

---------------------------------------------------
------------------- Client Side -------------------
---------------------------------------------------

-- Function นี้จะถูกเรียกใช้ก่อนให้ผู้เล่นสามารถเปิดกระเป๋า(ปล้น)ผู้อื่น [ โดยจะส่งค่ามาเป็น targetId: PlayerId ของผู้ถูกปล้น ]
Config.ClientWillRobPlayer = function(targetId)
	--TriggerEvent('Porpy_policealert:alertNet', 'thief')
	exports['Porpy_policealert']:alertNet("thief")
	Anim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer", {
		["flag"] = 2,["speed"] = 8.0
	})
	pcall(function()
		local duration = 6000
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบปล้น', -- หัวเรื่อง
			description = 'กำลังค้นกระเป๋าผู้เล่นอื่น', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'theif', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
		Citizen.Wait(duration)
	end)
	return true			-- true: เมื่อ "ต้องการ" ให้ผู้เล่นสามารถเปิดกระเป๋า(ปล้น)ผู้อื่นได้ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นสามารถเปิดกระเป๋า(ปล้น)ผู้อื่นได้
end

-- Function นี้จะถูกเรียกใช้เมื่อผู้เล่นกำลังจะเปิดกระเป๋า(ปล้น)ผู้อื่น [ โดยจะส่งค่ามาเป็น targetId: PlayerId ของผู้ถูกปล้น ]
Config.ClientRobPlayer = function(targetId)
	-- สามารถเขียนแจ้งเตือนหน่วยงานได้ที่ Function นี้
	--TriggerEvent('Porpy_policealert:alertNet', 'thief')
	exports['azael_dc-serverlogs']:insertData({
		event = 'DoRobbery',
		content = ('ผู้เล่นได้ทำการปล้น %s'):format(GetPlayerName(GetPlayerFromServerId(targetId))),
	})
end

-- Function นี้จะถูกเรียกใช้เมื่อผู้เล่นปิดกระเป๋า(หยุดปล้น)ผู้อื่น [ โดยจะส่งค่ามาเป็น targetId: PlayerId ของผู้ถูกปล้น ]
Config.ClientStoppedRobPlayer = function(targetId)
	exports['azael_dc-serverlogs']:insertData({
		event = 'StopRobbery',
		content = ('ผู้เล่นได้ทำการหยุดปล้น %s'):format(GetPlayerName(GetPlayerFromServerId(targetId))),
	})
end

-- Function นี้จะถูกเรียกใช้งานเมื่อถูกปล้น
-- ระวัง!! Function นี้จะถูกเรียกใช้ทุก Frame เมื่อกำลังถูกปล้น
Config.ClientBeRobbingEveryFrame = function()
	DisableAllControlActions(0)
	EnableControlAction(0, 1, true)
	EnableControlAction(0, 2, true)
	EnableControlAction(0, 249, true)
end

-- Function นี้จะถูกเรียกใช้งานเมื่อมี Error
-- errAction จะมี 'general' => ทั่วไป | 'rob_player' => ปล้นผู้อื่น
-- errType ที่ถูกส่งมาจะมีอยู่ 2 ชนิดคือ 'error' และ 'warning'
-- errText ที่จะถูกส่งมาในรูปแบบต่างๆดังนี้
-- outside_range					=> ทั่วไป - คุณอยู่นอกระยะปล้น
-- player_on_protection				=> ปล้นผู้อื่น - เนื่องจากคนๆนี้มีสิ่งของป้องกันการถูกปล้น
-- not_enough_jobs					=> ปล้นผู้อื่น - จำนวนหน่วยงานที่อยู่ในเมืองไม่เพียงพอ
-- account_blacklist				=> ปล้นผู้อื่น - เงินชนิดนี้ไม่สามารถเคลื่อนย้ายได้
-- item_blacklist					=> ปล้นผู้อื่น - ของสิ่งนี้ไม่สามารถเคลื่อนย้ายได้
-- weapon_blacklist					=> ปล้นผู้อื่น - อาวุธชนิดนี้ไม่สามารถเคลื่อนย้ายได้
Config.ClientNotificationError = function(errAction, errType, errText)
	-- ตัวอย่างการเขียน Notification ต่างๆ
	-- outside_range					=> 'error' - คุณอยู่นอกระยะปล้น
	-- not_enough_jobs					=> 'error' - จำนวนหน่วยงานที่อยู่ในเมืองไม่เพียงพอ
	-- player_on_protection				=> 'error' - เนื่องจากคนๆนี้มีสิ่งของป้องกันการถูกปล้น
	-- account_blacklist				=> 'error' - เงินชนิดนี้ไม่สามารถเคลื่อนย้ายได้
	-- item_blacklist					=> 'error' - ของสิ่งนี้ไม่สามารถเคลื่อนย้ายได้
	-- weapon_blacklist					=> 'error' - อาวุธชนิดนี้ไม่สามารถเคลื่อนย้ายได้
	if errText == 'outside_range' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบปล้น', -- หัวเรื่อง
			description = 'ไม่พบบุคคลในระยะใกล้เคียง', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_area', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'not_enough_jobs' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบปล้น', -- หัวเรื่อง
			description = 'ไม่สามารถขโมยของผู้อื่นได้เจ้าหน้าที่ในเมืองไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_cop', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	end
end