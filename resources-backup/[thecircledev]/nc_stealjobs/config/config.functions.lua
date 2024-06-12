-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

---------------------------------------------------
------------------- Server Side -------------------
---------------------------------------------------

-- Function นี้จะถูกเรียกใช้เพื่อตรวจสอบพื้นที่ว่างสำหรับเก็บ Item ต่างๆในกระเป๋า
Config.ServerValidateCanCarryItem = function(xPlayer, itemName, itemType, itemCount)
	-- xPlayer		=>	xPlayer ของผู้รับของ
	-- itemName		=>	ชื่อสิ่งของ/อาวุธ
	-- itemType		=>	ชนิดของสิ่งของ (account|item)
	-- itemCount	=>	จำนวนสิ่งของที่จะได้รับ
	if itemType == 'account' then
		return itemCount
	elseif itemType == 'item' then
		local xItem = xPlayer.getInventoryItem(itemName)
		if xItem then
			local itemLimit = xItem.limit or -1
			local itemWeight = xItem.weight or 0
			local currentWeight = xPlayer.getWeight and xPlayer.getWeight() or 0
			local maxWeight = xPlayer.getMaxWeight and xPlayer.getMaxWeight() or 0
			pcall(function()
				local result = exports.nc_inventory:Transaction({
					{ name = 'GetItemLimit', values = { itemName } },
					{ name = 'GetItemWeight', values = { itemName } },
					{ name = 'GetInventoryWeight', values = { xPlayer.source } }
				})
				itemLimit, itemWeight, currentWeight, maxWeight = result[1][1], result[2][1], result[3][1], result[3][2]
			end)
			local countByLimit, countByWeight = itemCount, itemCount
			if itemLimit ~= -1 and xItem.count + itemCount > itemLimit then
				countByLimit = itemLimit - xItem.count
			end
			if itemWeight > 0 and itemWeight * itemCount > maxWeight - currentWeight then
				countByWeight = math.floor((maxWeight - currentWeight) / itemWeight)
			end
			return math.min(countByLimit, countByWeight)
		end
	end
	return 0		-- return กลับไปเป็นจำนวนที่อนุญาตให้เก็บเข้ากระเป๋า (return 0 เมื่อไม่ต้องการให้การกระทำนี้สำเร็จ)
end

Config.ServerNotificationUseItem = function(xPlayer, itemName, itemType, itemCount)
	-- xPlayer		=>	xPlayer ของผู้เล่น
	-- itemName		=>	ชื่อสิ่งของที่ใช้งาน
	-- itemType		=>	ชนิดของสิ่งของที่ใช้งาน
	-- itemCount	=>	จำนวนสิ่งของที่ใช้งาน
	pcall(function() -- Start log
		exports['azael_dc-serverlogs']:insertData({
			 event = 'RemoveUseItem',
			 content = ('%s ได้สูญเสีย %s จำนวน %s ชิ้น เหลือ %s จำนวน %s ชิ้นในกระเป๋า'):format(xPlayer.name, itemName, itemCount, itemName, xPlayer.getInventoryItem(itemName).count),
			 source = xPlayer.source,
		 })
	 end) -- End log
end

Config.ServerNotificationGetRewards = function(xPlayer, itemList)
	-- xPlayer		=>	xPlayer ของผู้เล่น
	-- itemList		=>	{
	--						{ key = ชื่อสิ่งของ, label = ป้ายชื่อสิ่งของ, quantity = จำนวน, type = 'add' },
	--						{ key = ชื่อสิ่งของ, label = ป้ายชื่อสิ่งของ, quantity = จำนวน, type = 'add' },
	--						...
	--					}
	for _, item in ipairs(itemList) do
		if item.key == 'money' then
			pcall(function() -- Start log
				exports['azael_dc-serverlogs']:insertData({
					 event = 'StealTrash',
					 content = ('%s ได้รับ %s จำนวน $%s จากการจกขยะ'):format(xPlayer.name, item.key, item.quantity),
					 source = xPlayer.source,
				 })
			end) -- End log
		end
		if item.key == 'exp' then
			pcall(function() -- Start log
				exports['azael_dc-serverlogs']:insertData({
					 event = 'StealExp',
					 content = ('%s ได้รับ %s จำนวน %s ชิ้นจากการจกขยะหรือ ขโมยปูน'):format(xPlayer.name, item.key, item.quantity),
					 source = xPlayer.source,
				 })
			 end) -- End log
		end
		if item.key == 'cement' then
			pcall(function() -- Start log
				exports['azael_dc-serverlogs']:insertData({
					 event = 'StealCement',
					 content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการขโมยปูน'):format(xPlayer.name, item.key, item.quantity),
					 source = xPlayer.source,
				 })
			 end) -- End log
		end
	end
end


---------------------------------------------------
------------------- Client Side -------------------
---------------------------------------------------

-- Function นี้จะถูกเรียกใช้เพื่อตรวจสอบพื้นที่ว่างสำหรับเก็บ Item ต่างๆในกระเป๋า
Config.ClientValidateCanCarryItem = function(quantity, itemName, itemType, itemCount, itemLimit, itemWeight, currentWeight, maxWeight)
	-- quantity		=>	จำนวนสิ่งของที่จะได้รับ
	-- itemName		=>	ชื่อสิ่งของ/อาวุธ
	-- itemType		=>	ชนิดของสิ่งของ (account|item)
	-- itemCount	=>	จำนวนสิ่งของที่มีอยู่
	-- itemLimit	=>	จำนวนสิ่งของสูงสุด (-1 คือไม่จำกัด)
	-- itemWeight	=>	น้ำหนักสิ่งของ (หากไม่มีจะเท่ากับ 0.0)
	-- maxWeight	=>	น้ำหนักกระเป๋า (หากไม่มีจะเท่ากับ 0.0)
	if itemType == 'account' then
		return quantity
	elseif itemType == 'item' then
		pcall(function()
			local result = exports.nc_inventory:Transaction({
				{ name = 'GetItemLimit', values = { itemName } },
				{ name = 'GetItemWeight', values = { itemName } },
				{ name = 'GetInventoryWeight' }
			})
			itemLimit, itemWeight, currentWeight, maxWeight = result[1][1], result[2][1], result[3][1], result[3][2]
		end)
		local countByLimit, countByWeight = quantity, quantity
		if itemLimit ~= -1 and itemCount + quantity > itemLimit then
			countByLimit = itemLimit - itemCount
		end
		if itemWeight * quantity > maxWeight - currentWeight then
			countByWeight = math.floor((maxWeight - currentWeight) / itemWeight)
		end
		return math.min(countByLimit, countByWeight)
	end
	return 0		-- return กลับไปเป็นจำนวนที่อนุญาตให้เก็บเข้ากระเป๋า (return 0 เมื่อไม่ต้องการให้การกระทำนี้สำเร็จ)
end

-- Function นี้จะถูกเรียกใช้งานเมื่อกำลังขโมยสิ่งของ
-- ระวัง!! Function นี้จะถูกเรียกใช้ทุก Frame เมื่อกำลังขโมยสิ่งของ
Config.ClientOnStealingEveryFrame = function()
	DisableAllControlActions(0)
	EnableControlAction(0, 1, true)
	EnableControlAction(0, 2, true)
	EnableControlAction(0, 249, true)
end

-- Function นี้จะถูกเรียกใช้งานเมื่อมี Error
-- errValue ที่ถูกส่งมาคือค่าต่างๆของ Error นั้นๆ
Config.ClientNotificationError = function(errText, errValue, errValueType)
	-- ตัวอย่างการเขียน Notification จาก errText ต่างๆ
	-- no_cops						=>	จำนวนตำรวจไม่เพียงพอ (errValue = จำนวนตำรวจที่ต้องการ)
	-- source_inventory_full		=>	พื้นที่ในกระเป๋าของผู้เล่นไม่เพียงพอที่จะเก็บของที่ต้องการจะขโมยมาได้
	-- source_no_use_item			=>	คุณมีสิ่งของสำหรับการขโมยของไม่เพียงพอ (errValue = ชื่อสิ่งของ, errValueType = ชนิดของสิ่งของ account|item)
	if errText == 'no_cops' and  errValue == 6 then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบขโมยปูน', -- หัวเรื่อง
			description = 'ไม่สามารถขโมยของสิ่งนี้ได้เจ้าหน้าที่ในเมืองไม่เพียงพอ',-- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning',
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_cop', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 4000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'no_cops' and  errValue == 7 then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบงัดร้าค้า', -- หัวเรื่อง
			description = 'ไม่สามารถขโมยของสิ่งนี้ได้เจ้าหน้าที่ในเมืองไม่เพียงพอ',-- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning',
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_cop', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 4000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'source_inventory_full' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบน้ำหนัก', -- หัวเรื่อง
			description = 'น้ำหนักกระเป๋าของคุณไม่เพียงพอ',-- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning',
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'inventory_max', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 4000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'source_no_use_item' and errValue == 'screwdv' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ไม่สามารถขโมยของสิ่งนี้ได้', -- หัวเรื่อง
			description = 'คุณมี ไขควง ไม่เพียงพอสำหรับขโมยของสิ่งนี้',-- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning',
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 4000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'source_no_use_item' and errValue == 'letter' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบส่งจดหมาย', -- หัวเรื่อง
			description = 'คุณมี จดหมาย ไม่เพียงพอสำหรับการส่งจดหมาย',-- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning',
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 4000 -- ระยะเวลาการแสดง Notify
		})
	end	
end