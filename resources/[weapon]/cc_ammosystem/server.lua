
function weaponCheckList(xPlayer)
	local weaponHash = { -- เรียงตามลำดับ index arrs ในการค้นหา
		---1045183535,
		---879347409,
		1286532276,
		987777303,
		1604948645,
	}

	local weaponName = {
		--"WEAPON_REVOLVER",
		--"WEAPON_REVOLVER_MK2",
		"WEAPON_REVOLVER_V1",
		"WEAPON_REVOLVER_V2",
		"WEAPON_REVOLVER_V3",
	}

	local ped = GetPlayerPed(xPlayer.source)
	local pedWeapon = GetSelectedPedWeapon(ped)
	for i=1,#weaponHash,1 do
		if pedWeapon == weaponHash[i] then
			if xPlayer.hasWeapon(weaponName[i]) then
				return weaponName[i], true
			end
			if not xPlayer.hasWeapon(weaponName[i]) then
				exports.nc_notify:PushNotification(xPlayer.source,{
					scale = 1.0,  -- ปรับขนาดของ Notify
					title = 'ระบบเติมกระสุน',  -- หัวเรื่อง
					description = 'กรุณาใช้กระสุนกับปืนรีโวลเวอร์เท่านั้น',  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
					type = 'error',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
					position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
					direction = 'right',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
					priority = 'medium',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
					icon = 'inventory_max',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
					duration = 1000  -- ระยะเวลาการแสดง Notify
				})
				return weaponName[i], false
			end
		end
	end
end

ESX.RegisterUsableItem('speed_loader', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xItem = xPlayer.getInventoryItem("speed_loader")
	local weaponName, isHaveWeapon = weaponCheckList(xPlayer)
	if isHaveWeapon and xItem.count > 0 then
		local _, weapon = xPlayer.getWeapon(weaponName)
		local oldAmmo = weapon.ammo
		xPlayer.removeInventoryItem("speed_loader",1)
		for i=1,6,1 do
			xPlayer.addWeaponAmmo(weaponName, 1)
			xPlayer.triggerEvent("cc_ammosystem:playerAnimation")
			exports.nc_notify:PushNotification(xPlayer.source,{
				scale = 1.0,  -- ปรับขนาดของ Notify
				title = 'ระบบเติมกระสุน',  -- หัวเรื่อง
				description = ('เติมกระสุนเรียบร้อยแล้ว มีกระสุนทั้งหมด %s ลูก'):format(oldAmmo+i),  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
				type = 'success',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
				position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
				direction = 'right',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
				priority = 'medium',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
				icon = 'inventory_max',  -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
				duration = 1000  -- ระยะเวลาการแสดง Notify
			})
			pcall(function() -- Start log
				exports['azael_dc-serverlogs']:insertData({
					event = 'reloadAmmoSuccess',
					content = ('ผู้เล่น %s ใส่กระสุนสำเร็จ กระสุนเดิม %s กระสุนใหม่'):format(xPlayer.name, oldAmmo, oldAmmo+i),
					source = xPlayer.source,
				})
			end) -- End log
			Wait(2000)
		end
	end
end)