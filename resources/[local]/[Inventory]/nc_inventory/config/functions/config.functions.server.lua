-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

---------------------------------------------------
------------------- Server Side -------------------
---------------------------------------------------

-- Function นี้จะถูกเรียกใช้งานเมื่อมีการโหลดข้อมูลครั้งแรก (ในฝั่ง Server)
Config.ServerOnFirstLoaded = function()

end

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นใช้งานกุญแจต่างๆ
-- กุญแจยานพาหนะจะมี itemName เป็นเลขทะเบียน และ itemType เป็น 'vehicle_key'
-- กุญแจบ้านจะมี itemName เป็น id และ itemType เป็น 'house_key'
Config.ServerUseKey = function(xPlayer, itemName, itemType)
	if itemType == 'vehicle_key' then

	elseif itemType == 'house_key' then

	end
end

-- Function นี้จะถูกเรียกใช้งานก่อนผู้เล่นทิ้งสิ่งของ
-- itemType ที่ส่งมาจะเป็น account|item|weapon|key|accessory
Config.ServerWillDropItem = function(xPlayer, itemName, itemCount, itemType, optionType)
	return true				-- return true เมื่อต้องการให้ทิ้งสิ่งของ
end

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นทิ้งของสำเร็จ
-- itemType ที่ส่งมาจะเป็น account|item|weapon|key|accessory
Config.ServerDroppedItem = function(xPlayer, itemName, itemCount, itemType, optionType)

end

-- Function นี้จะถูกเรียกใช้งานก่อนผู้เล่นมอบสิ่งของ
-- itemType ที่ส่งมาจะเป็น account|item|weapon|key|accessory
Config.ServerWillGiveItem = function(xPlayer, xTarget, itemName, itemCount, itemType, optionType)
	if itemName == 'T1_WEAPON_BOTTLE' or itemName == 'T1_WEAPON_POOLCUE' or itemName == 'T1_WEAPON_MACHETE' or itemName == 'T1_WEAPON_KNUCKLE' then
		local xItemPlayer = xPlayer.getInventoryItem("t1_player")
		local xItemTarget = xTarget.getInventoryItem("t1_player")
		if xItemPlayer.count >= 1 and xItemTarget.count >= 1  then
			return true
		end
		exports.nc_notify:PushNotification(xPlayer.source,{
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบโอนอาวุธ', -- หัวเรื่อง
			description = 'ผู้โอนหรือผู้รับไม่มีสิทธิ์ในการเข้าแข่งขัน', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			--color  = 'rgba(0, 204, 204)',  -- สีของพื้นหลัง
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'block', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
		exports.nc_notify:PushNotification(xTarget.source,{
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบโอนอาวุธ', -- หัวเรื่อง
			description = 'ผู้โอนหรือผู้รับไม่มีสิทธิ์ในการเข้าแข่งขัน', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			--color  = 'rgba(0, 204, 204)',  -- สีของพื้นหลัง
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'block', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
		return false
	end
	return true				-- return true เมื่อต้องการให้มอบสิ่งของ
end

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นมอบของสำเร็จ
-- itemType ที่ส่งมาจะเป็น account|item|weapon|key|accessory
Config.ServerGaveItem = function(xPlayer, xTarget, itemName, itemCount, itemType, optionType)
	xPlayer.triggerEvent('nc_inventory:playAnimation')
	xTarget.triggerEvent('nc_inventory:playAnimation')
	if itemType == 'vehicle_key' then
		print(itemName, xTarget.identifier)
		exports.nc_vehiclestorage:ChangeVehicleOwner(itemName, xTarget.identifier)
		exports.nc_vehiclekey:ReloadVehicleKey(itemName)
	end
	pcall(function() -- Start Log
		exports['azael_dc-serverlogs']:insertData({
			event = 'ReceivedGiveItem',
			content = ('%s ได้รับ %s จำนวน %s จาก %s'):format(xTarget.name, itemName, itemCount, xPlayer.name),
			source = xTarget.source,
		})
	end) -- End Log
end

-- Function นี้จะถูกเรียกใช้งานก่อนเปลี่ยนแปลงข้อมูลผู้เล่นฝั่ง Server ขณะโยกย้ายสิ่งของระหว่างผู้เล่นอื่น
-- dragAction จะมี 2 ค่าคือ 'put' => ใส่ของเข้าตัวผู้เล่นท่านอื่น | 'take' => นำของออกจากตัวผู้เล่นท่านอื่น
-- itemType ที่ส่งมาจะเป็น account|item|weapon
-- หากต้องการชื่อ Job ที่ต้องการ ให้ใช้ xPlayer.job.name และตำแหน่งให้ใช้ xPlayer.job.grade_name
-- searchType คือชนิดของการค้นตัว exports.nc_inventory:SearchInventory() หากไม่ได้ใส่ค่าไว้ตอนเรียกใช้ จะมีค่าเป็น 'default'
Config.ServerWillSearchInventoryAction = function(xPlayer, xTarget, dragAction, itemName, itemCount, itemType, searchType)
	print(searchType)
	if searchType == 'thief' then
		pcall(function()
			exports['azael_dc-serverlogs']:insertData({
				 event = 'RoberStealPlayerItem',
				 content = ('%s อาชีพ %s ได้ทำการ %s ไอเทมชนิด %s คือ %s จำนวน %s จากกระเป๋าของ %s อาชีพ %s'):format(xPlayer.name, xPlayer.job.name, dragAction, itemType, itemName, itemCount, xTarget.name, xTarget.job.name),
				 source = xPlayer.source,
			 })
		 end)
		 pcall(function()
			exports['azael_dc-serverlogs']:insertData({
				 event = 'PlayerLostItem',
				 content = ('%s อาชีพ %s ได้สูญเสียไอเทมชนิด %s คือ %s จำนวน %s จากกระเป๋า | ผู้ปล้นคือ %s อาชีพ %s'):format(xTarget.name, xTarget.job.name, itemType, itemName, itemCount, xPlayer.name, xPlayer.job.name),
				 source = xTarget.source,
			 })
		 end)
		return exports.nc_thief:Action(xPlayer, xTarget, dragAction, itemName, itemCount, itemType, searchType)
	end
	pcall(function() -- Start log
		exports['azael_dc-serverlogs']:insertData({
			 event = 'SearchingInventory',
			 content = ('%s อาชีพ %s ยศ %s ได้ทำการ %s ไอเทมชนิด %s คือ %s จำนวน %s จากกระเป๋าของ %s อาชีพ %s'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, dragAction, itemType, itemName, itemCount, xTarget.name, xTarget.job.name),
			 source = xPlayer.source,
		 })
	 end) -- End log
	return true, true		-- return true, true เพื่ออนุญาตให้เปลี่ยนแปลงข้อมูล source, target * ค่าที่ return กลับไปจะมี 2 ตัวเสมอ (true: เปลี่ยนแปลง | false|nil: ไม่เปลี่ยนแปลง)
end

-- Function นี้จะถูกเรียกใช้งานเมื่อย้ายสิ่งระหว่างระหว่างผู้เล่นสำเร็จ
-- dragAction จะมี 2 ค่าคือ 'put' => ใส่ของเข้าตัวผู้เล่นท่านอื่น | 'take' => นำของออกจากตัวผู้เล่นท่านอื่น
-- itemType ที่ส่งมาจะเป็น account|item|weapon
-- หากต้องการชื่อ Job ที่ต้องการ ให้ใช้ xPlayer.job.name และตำแหน่งให้ใช้ xPlayer.job.grade_name
-- searchType คือชนิดของการค้นตัว หากไม่ได้ใส่ค่าไว้ตอนเรียกใช้ exports.nc_inventory:SearchInventory() จะมีค่าเป็น 'default'
Config.ServerSearchedInventoryAction = function(xPlayer, xTarget, dragAction, itemName, itemCount, itemType, searchType)

end