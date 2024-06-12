-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

---------------------------------------------------
------------------ Database Keys ------------------
---------------------------------------------------

-- Function นี้จะถูกเรียกใช้งานเพื่อดึงค่ากุญแจต่างๆจาก Database (Sync Function)
-- กุญแจยานพาหนะจะมี itemType เป็น 'vehicle_key'
-- กุญแจบ้านจะมี itemType เป็น 'house_key'
Config.DatabaseLoadOwnedKeys = function(xPlayer, itemType)
	if itemType == 'vehicle_key' then
		local result = MySQL.query.await('SELECT `plate` AS `name`, `plate` AS `label` FROM `owned_vehicles` WHERE `owner` = ? AND `expire_date` IS NULL', { xPlayer.identifier })
		return result			-- Function จะส่งค่า name, label กลับไป
		-- elseif itemType == 'house_key' then
		-- 	local result = MySQL.query.await('SELECT `id` AS `name`, `name` AS `label` FROM `owned_properties` WHERE `owner` = ?', { xPlayer.identifier })
		-- 	return result			-- Function จะส่งค่า name, label กลับไป
	end
end

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นมอบกุญแจต่างๆให้ผู้อื่น (Sync Function)
-- กุญแจยานพาหนะจะมี itemName เป็นเลขทะเบียน และ itemType เป็น 'vehicle_key'
-- กุญแจบ้านจะมี itemName เป็น id และ itemType เป็น 'house_key'
Config.DatabaseGiveKey = function(xPlayer, xTarget, itemName, itemType)
	if itemType == 'vehicle_key' then
		local tradeXPlayer = xPlayer.getInventoryItem('card_transfer').count
			local tradeTarget = xTarget.getInventoryItem('card_transfer').count
			if tradeXPlayer > 0  and tradeTarget > 0 then
				local count = MySQL.prepare.await('UPDATE `owned_vehicles` SET `owner` = ? WHERE `owner` = ? AND `plate` = ?', { xTarget.identifier, xPlayer.identifier, itemName })
				xPlayer.removeInventoryItem('card_transfer', 1)
				xTarget.removeInventoryItem('card_transfer', 1)
				exports.nc_notify:PushNotification(xPlayer.source,{
					scale = 1.0, -- ปรับขนาดของ Notify
					title = 'ระบบโอนรถ', -- หัวเรื่อง
					description = 'ทำรายการโอนรถสำเร็จ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
					type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
					position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
					direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
					priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
					icon = 'carkey', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
					duration = 3000 -- ระยะเวลาการแสดง Notify
				})

				exports.nc_notify:PushNotification(xTarget.source,{
					scale = 1.0, -- ปรับขนาดของ Notify
					title = 'ระบบโอนรถ', -- หัวเรื่อง
					description = 'ทำรายการรับรถสำเร็จ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
					type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
					position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
					direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
					priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
					icon = 'carkey', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
					duration = 3000 -- ระยะเวลาการแสดง Notify
				})
				return count > 0	-- return true หากมีการอัพเดทค่าใน Database
			end


			if tradeXPlayer == 0 then

				exports.nc_notify:PushNotification(xPlayer.source,{
					scale = 1.0, -- ปรับขนาดของ Notify
					title = 'ระบบโอนรถ', -- หัวเรื่อง
					description = 'ไม่สามารถทำรายการได้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
					type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
					position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
					direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
					priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
					icon = 'no_carkey', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
					duration = 3000 -- ระยะเวลาการแสดง Notify
				})

				exports.nc_notify:PushNotification(xTarget.source,{
					scale = 1.0, -- ปรับขนาดของ Notify
					title = 'ระบบโอนรถ', -- หัวเรื่อง
					description = 'คุณไม่มีบัตรโอนรถ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
					type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
					position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
					direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
					priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
					icon = 'no_carkey', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
					duration = 3000 -- ระยะเวลาการแสดง Notify
				})
				return false
			end

			if tradeTarget == 0 then

				exports.nc_notify:PushNotification(xPlayer,{
					scale = 1.0, -- ปรับขนาดของ Notify
					title = 'ระบบโอนรถ', -- หัวเรื่อง
					description = 'คุณไม่มีบัตรโอนรถ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
					type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
					position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
					direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
					priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
					icon = 'no_carkey', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
					duration = 3000 -- ระยะเวลาการแสดง Notify
				})

				exports.nc_notify:PushNotification(xTarget,{
					scale = 1.0, -- ปรับขนาดของ Notify
					title = 'ระบบโอนรถ', -- หัวเรื่อง
					description = 'ไม่สามารถทำรายการได้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
					type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
					position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
					direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
					priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
					icon = 'no_carkey', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
					duration = 3000 -- ระยะเวลาการแสดง Notify
				})
				return false
			end

			return false
			-- local count = MySQL.prepare.await('UPDATE `owned_vehicles` SET `owner` = ? WHERE `owner` = ? AND `plate` = ?', { xTarget.identifier, xPlayer.identifier, itemName })
			-- return count > 0	-- return true หากมีการอัพเดทค่าใน Database
			-- elseif itemType == 'house_key' then
			-- 	local count = MySQL.prepare.await('UPDATE `owned_properties` SET `owner` = ? WHERE `owner` = ? AND `id` = ?', { xTarget.identifier, xPlayer.identifier, itemName })
			-- 	return count > 0	-- return true หากมีการอัพเดทค่าใน Database
	end
end

-- Function นี้จะถูกเรียกใช้งานเพื่อลบกุญแจต่างๆ (Sync Function)
-- กุญแจยานพาหนะจะมี itemName เป็นเลขทะเบียน และ itemType เป็น 'vehicle_key'
-- กุญแจบ้านจะมี itemName เป็น id และ itemType เป็น 'house_key'
Config.DatabaseDeleteKey = function(xPlayer, itemName, itemType)
	if itemType == 'vehicle_key' then
		return false
		-- local count = MySQL.prepare.await('DELETE FROM `owned_vehicles` WHERE `owner` = ? AND `plate` = ?', { xPlayer.identifier, itemName })
		-- return count > 0	-- return true หากมีการอัพเดทค่าใน Database
	elseif itemType == 'house_key' then
		local count = MySQL.prepare.await('DELETE FROM `owned_properties` WHERE `owner` = ? AND `id` = ?', { xPlayer.identifier, itemName })
		return count > 0	-- return true หากมีการอัพเดทค่าใน Database
	end
end


---------------------------------------------------
-------------- Database Accessories ---------------
---------------------------------------------------

---- Function นี้จะถูกเรียกใช้งานเพื่อดึงค่าเครื่องประดับจาก Database (Sync Function)
Config.DatabaseLoadOwnedAccessories = function(xPlayer)
	local result = MySQL.query.await('SELECT `label`, `type`, `skin` FROM `meeta_accessory_inventory` WHERE `owner` = ? ORDER BY `type`, `label`', { xPlayer.identifier })
	return result			-- Function จะส่งค่า label, type, skin กลับไป
end
--
---- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นมอบเครื่องประดับต่างๆให้ผู้อื่น (Sync Function)
Config.DatabaseGiveAccessory = function(xPlayer, xTarget, itemName, optionType)
	local count = MySQL.prepare.await('UPDATE `meeta_accessory_inventory` SET `owner` = ? WHERE `owner` = ? AND `type` = ? AND `label` = ?', { xTarget.identifier, xPlayer.identifier, optionType, itemName })
	return count > 0		-- return true หากมีการอัพเดทค่าใน Database
end
--
---- Function นี้จะถูกเรียกใช้งานเพื่อลบเครื่องประดับต่างๆ (Sync Function)
Config.DatabaseDeleteAccessory = function(xPlayer, itemName, optionType)
	local count = MySQL.prepare.await('DELETE FROM `meeta_accessory_inventory` WHERE `owner` = ? AND `type` = ? AND `label` = ?', { xPlayer.identifier, optionType, itemName })
	return count > 0		-- return true หากมีการอัพเดทค่าใน Database
end