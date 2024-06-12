-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

---------------------------------------------------
------------------- Server Side -------------------
---------------------------------------------------

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นใส่สิ่งของประเภทเงินเข้าช่องเก็บของยานพาหนะ (ก่อนใส่สิ่งของเข้าช่องเก็บของยานพาหนะ)
-- [ storageType: ชนิดของช่องเก็บของยานพาหนะ | plate: ทะเบียนของยานพาหนะ | model: Model Hash ของยานพาหนะ | class: Class ของยานพาหนะ ]
-- [ xPlayer: xPlayer ของผู้เล่น | accountName: ชื่อชนิดของเงิน | accountAmount: จำนวนเงิน | isOwner: เป็นเจ้าของยานพาหนะนี้หรือไม่ ]
Config.ServerPlayerWillPutAccount = function(storageType, plate, model, class, xPlayer, accountName, accountAmount, isOwner)
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นใส่สิ่งของประเภทเงินเข้าช่องเก็บของยานพาหนะสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นใส่สิ่งของประเภทเงินเข้าช่องเก็บของยานพาหนะสำเร็จ
end
-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นใส่สิ่งของประเภทเงินเข้าช่องเก็บของยานพาหนะ (หลังใส่สิ่งของเข้าช่องเก็บของยานพาหนะสำเร็จ)
-- [ storageType: ชนิดของช่องเก็บของยานพาหนะ | plate: ทะเบียนของยานพาหนะ | model: Model Hash ของยานพาหนะ | class: Class ของยานพาหนะ ]
-- [ xPlayer: xPlayer ของผู้เล่น | accountName: ชื่อชนิดของเงิน | accountAmount: จำนวนเงิน | isOwner: เป็นเจ้าของยานพาหนะนี้หรือไม่ ]
Config.ServerPlayerPutAccount = function(storageType, plate, model, class, xPlayer, accountName, accountAmount, isOwner)
	pcall(function() -- Start log
		exports['azael_dc-serverlogs']:insertData({
			event = 'PutAccountVehicleTrunk',
			content = ('ผู้เล่น %s ทำการใส่ของในรถทะเบียน %s รถชื่อ %s สิ่งของที่ใส่ %s จำนวน %s ความเป็นเจ้าของรถ (%s)'):format(xPlayer.name, plate, model, accountName, accountAmount, isOwner),
			source = xPlayer.source,
		})
	end) -- End log
end

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นดึงสิ่งของประเภทเงินออกจากช่องเก็บของยานพาหนะ (ก่อนย้ายสิ่งของสำเร็จ)
-- [ storageType: ชนิดของช่องเก็บของยานพาหนะ | plate: ทะเบียนของยานพาหนะ | model: Model Hash ของยานพาหนะ | class: Class ของยานพาหนะ ]
-- [ xPlayer: xPlayer ของผู้เล่น | accountName: ชื่อชนิดของเงิน | accountAmount: จำนวนเงิน | isOwner: เป็นเจ้าของยานพาหนะนี้หรือไม่ ]
Config.ServerPlayerWillTakeAccount = function(storageType, plate, model, class, xPlayer, accountName, accountAmount, isOwner)
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นดึงสิ่งของประเภทเงินออกจากช่องเก็บของยานพาหนะสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นดึงสิ่งของประเภทเงินออกจากช่องเก็บของยานพาหนะสำเร็จ
end
-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นดึงสิ่งของประเภทเงินออกจากช่องเก็บของยานพาหนะ (หลังย้ายสิ่งของสำเร็จ)
-- [ storageType: ชนิดของช่องเก็บของยานพาหนะ | plate: ทะเบียนของยานพาหนะ | model: Model Hash ของยานพาหนะ | class: Class ของยานพาหนะ ]
-- [ xPlayer: xPlayer ของผู้เล่น | accountName: ชื่อชนิดของเงิน | accountAmount: จำนวนเงิน | isOwner: เป็นเจ้าของยานพาหนะนี้หรือไม่ ]
Config.ServerPlayerTookAccount = function(storageType, plate, model, class, xPlayer, accountName, accountAmount, isOwner)
	pcall(function() -- Start log
		exports['azael_dc-serverlogs']:insertData({
			event = 'TookAccountVehicleTrunk',
			content = ('ผู้เล่น %s ทำการใส่ของในรถทะเบียน %s รถชื่อ %s สิ่งของออก %s จำนวน %s ความเป็นเจ้าของรถ (%s)'):format(xPlayer.name, plate, model, accountName, accountAmount, isOwner),
			source = xPlayer.source,
		})
	end) -- End log
end

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นใส่สิ่งของเข้าช่องเก็บของยานพาหนะ (ก่อนใส่สิ่งของเข้าช่องเก็บของยานพาหนะ)
-- [ storageType: ชนิดของช่องเก็บของยานพาหนะ | plate: ทะเบียนของยานพาหนะ | model: Model Hash ของยานพาหนะ | class: Class ของยานพาหนะ ]
-- [ xPlayer: xPlayer ของผู้เล่น | itemName: ชื่อสิ่งของ | itemCount: จำนวนสิ่งของ | isOwner: เป็นเจ้าของยานพาหนะนี้หรือไม่ ]
Config.ServerPlayerWillPutItem = function(storageType, plate, model, class, xPlayer, itemName, itemCount, isOwner)
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นใส่สิ่งของทั่วไปเข้าช่องเก็บของยานพาหนะสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นใส่สิ่งของทั่วไปเข้าช่องเก็บของยานพาหนะสำเร็จ
end
-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นใส่สิ่งของเข้าช่องเก็บของยานพาหนะ (หลังใส่สิ่งของเข้าช่องเก็บของยานพาหนะสำเร็จ)
-- [ storageType: ชนิดของช่องเก็บของยานพาหนะ | plate: ทะเบียนของยานพาหนะ | model: Model Hash ของยานพาหนะ | class: Class ของยานพาหนะ ]
-- [ xPlayer: xPlayer ของผู้เล่น | itemName: ชื่อสิ่งของ | itemCount: จำนวนสิ่งของ | isOwner: เป็นเจ้าของยานพาหนะนี้หรือไม่ ]
Config.ServerPlayerPutItem = function(storageType, plate, model, class, xPlayer, itemName, itemCount, isOwner)
	pcall(function() -- Start log
		exports['azael_dc-serverlogs']:insertData({
			event = 'PutItemVehicleTrunk',
			content = ('ผู้เล่น %s ทำการใส่ของในรถทะเบียน %s รถชื่อ %s สิ่งของที่ใส่ %s จำนวน %s ความเป็นเจ้าของรถ (%s)'):format(xPlayer.name, plate, model, itemName, itemCount, isOwner),
			source = xPlayer.source,
		})
	end) -- End log
end

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นดึงสิ่งของออกจากช่องเก็บของยานพาหนะ (ก่อนย้ายสิ่งของสำเร็จ)
-- [ storageType: ชนิดของช่องเก็บของยานพาหนะ | plate: ทะเบียนของยานพาหนะ | model: Model Hash ของยานพาหนะ | class: Class ของยานพาหนะ ]
-- [ xPlayer: xPlayer ของผู้เล่น | itemName: ชื่อสิ่งของ | itemCount: จำนวนสิ่งของ | isOwner: เป็นเจ้าของยานพาหนะนี้หรือไม่ ]
Config.ServerPlayerWillTakeItem = function(storageType, plate, model, class, xPlayer, itemName, itemCount, isOwner)
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นดึงสิ่งของทั่วไปออกจากช่องเก็บของยานพาหนะสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นดึงสิ่งของทั่วไปออกจากช่องเก็บของยานพาหนะสำเร็จ
end
-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นดึงสิ่งของออกจากช่องเก็บของยานพาหนะ (หลังย้ายสิ่งของสำเร็จ)
-- [ storageType: ชนิดของช่องเก็บของยานพาหนะ | plate: ทะเบียนของยานพาหนะ | model: Model Hash ของยานพาหนะ | class: Class ของยานพาหนะ ]
-- [ xPlayer: xPlayer ของผู้เล่น | itemName: ชื่อสิ่งของ | itemCount: จำนวนสิ่งของ | isOwner: เป็นเจ้าของยานพาหนะนี้หรือไม่ ]
Config.ServerPlayerTookItem = function(storageType, plate, model, class, xPlayer, itemName, itemCount, isOwner)
	pcall(function() -- Start log
		exports['azael_dc-serverlogs']:insertData({
			event = 'TookItemVehicleTrunk',
			content = ('ผู้เล่น %s ทำการใส่ของในรถทะเบียน %s รถชื่อ %s สิ่งของออก %s จำนวน %s ความเป็นเจ้าของรถ (%s)'):format(xPlayer.name, plate, model, itemName, itemCount, isOwner),
			source = xPlayer.source,
		})
	end) -- End log
end

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นใส่อาวุธเข้าช่องเก็บของยานพาหนะ (ก่อนใส่อาวุธเข้าช่องเก็บของยานพาหนะ)
-- [ storageType: ชนิดของช่องเก็บของยานพาหนะ | plate: ทะเบียนของยานพาหนะ | model: Model Hash ของยานพาหนะ | class: Class ของยานพาหนะ ]
-- [ xPlayer: xPlayer ของผู้เล่น | weaponName: ชื่อของอาวุธ | weaponAmmo: จำนวนกระสุน | isOwner: เป็นเจ้าของยานพาหนะนี้หรือไม่ ]
Config.ServerPlayerWillPutWeapon = function(storageType, plate, model, class, xPlayer, weaponName, weaponAmmo, isOwner)
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นใส่อาวุธเข้าช่องเก็บของยานพาหนะสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นใส่อาวุธเข้าช่องเก็บของยานพาหนะสำเร็จ
end
-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นใส่อาวุธเข้าช่องเก็บของยานพาหนะ (หลังใส่อาวุธเข้าช่องเก็บของยานพาหนะสำเร็จ)
-- [ storageType: ชนิดของช่องเก็บของยานพาหนะ | plate: ทะเบียนของยานพาหนะ | model: Model Hash ของยานพาหนะ | class: Class ของยานพาหนะ ]
-- [ xPlayer: xPlayer ของผู้เล่น | weaponName: ชื่อของอาวุธ | weaponAmmo: จำนวนกระสุน | isOwner: เป็นเจ้าของยานพาหนะนี้หรือไม่ ]
Config.ServerPlayerPutWeapon = function(storageType, plate, model, class, xPlayer, weaponName, weaponAmmo, isOwner)

end

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นดึงอาวุธออกจากช่องเก็บของยานพาหนะ (ก่อนย้ายอาวุธสำเร็จ)
-- [ storageType: ชนิดของช่องเก็บของยานพาหนะ | plate: ทะเบียนของยานพาหนะ | model: Model Hash ของยานพาหนะ | class: Class ของยานพาหนะ ]
-- [ xPlayer: xPlayer ของผู้เล่น | weaponName: ชื่อของอาวุธ | weaponAmmo: จำนวนกระสุน | isOwner: เป็นเจ้าของยานพาหนะนี้หรือไม่ ]
Config.ServerPlayerWillTakeWeapon = function(storageType, plate, model, class, xPlayer, weaponName, weaponAmmo, isOwner)
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นดึงอาวุธออกจากช่องเก็บของยานพาหนะสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นดึงอาวุธออกจากช่องเก็บของยานพาหนะสำเร็จ
end
-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นดึงอาวุธออกจากช่องเก็บของยานพาหนะ (หลังย้ายอาวุธสำเร็จ)
-- [ storageType: ชนิดของช่องเก็บของยานพาหนะ | plate: ทะเบียนของยานพาหนะ | model: Model Hash ของยานพาหนะ | class: Class ของยานพาหนะ ]
-- [ xPlayer: xPlayer ของผู้เล่น | weaponName: ชื่อของอาวุธ | weaponAmmo: จำนวนกระสุน | isOwner: เป็นเจ้าของยานพาหนะนี้หรือไม่ ]
Config.ServerPlayerTookWeapon = function(storageType, plate, model, class, xPlayer, weaponName, weaponAmmo, isOwner)

end

-- Function นี้จะถูกเรียกใช้ก่อนจะเปิดกระเป๋า
-- [ storageType: ชนิดของช่องเก็บของยานพาหนะ | plate: ทะเบียนของยานพาหนะ | model: Model Hash ของยานพาหนะ | class: Class ของยานพาหนะ ]
-- [ xPlayer: xPlayer ของผู้เล่น | isOwner: เป็นเจ้าของยานพาหนะนี้หรือไม่ ]
Config.ServerWillOpenInventory = function(storageType, plate, model, class, xPlayer, isOwner)
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นเปิดช่องเก็บของยานพาหนะ(หน้าต่างกระเป๋า)สำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นเปิดช่องเก็บของยานพาหนะ(หน้าต่างกระเป๋า)สำเร็จ
end
-- Function นี้จะถูกเรียกใช้เพื่อเปิดกระเป๋า
-- [ storageType: ชนิดของช่องเก็บของยานพาหนะ | plate: ทะเบียนของยานพาหนะ | model: Model Hash ของยานพาหนะ | class: Class ของยานพาหนะ ]
-- [ storageItems: สิ่งของต่างๆในช่องเก็บของยานพาหนะ | storageData: ข้อมูลต่างๆของช่องเก็บของยานพาหนะ | xPlayer: xPlayer ของผู้เล่น | isOwner: เป็นเจ้าของยานพาหนะนี้หรือไม่ ]
Config.ServerOpenInventory = function(storageType, plate, model, class, storageItems, storageData, xPlayer, isOwner)
	-- ตัวอย่างการส่งค่าของ storageItems
	-- storageItems =	{
	-- 					accounts		= ข้อมูล เงินต่างๆ [object],
	-- 					items			= ข้อมูล สิ่งของทั่วไป [object],
	-- 					weapons			= ข้อมูล อาวุธ [object]
	-- 				}

	-- ตัวอย่างการส่งค่าของ storageData
	-- storageData =	{
	-- 					slot			= จำนวนช่องที่ใช้ไป [number],
	-- 					maxSlot			= จำนวนช่องทั้งหมดที่สามารถที่ใช้งานได้ [number],
	-- 					weight			= น้ำหนักของสิ่งของรวมทั้งหมดในช่องเก็บของยานพาหนะ [number],
	-- 					maxWeight		= น้ำหนักสูงสุดที่สามารถเก็บสิ่งของได้ [number],
	-- 					accountsCount	= จำนวน เงินต่างๆ ทั้งหมดที่มีในช่องเก็บของยานพาหนะ [number],
	-- 					itemsCount		= จำนวน สิ่งของทั่วไป ทั้งหมดที่มีในช่องเก็บของยานพาหนะ [number],
	-- 					weaponsCount	= จำนวน อาวุธ ทั้งหมดที่มีในช่องเก็บของยานพาหนะ [number],
	-- 					maxAccountLimit	= จำนวน เงินต่างๆ สูงสุดที่สามารถเก็บได้ในช่องเก็บของยานพาหนะ [number],
	-- 					maxItemLimit	= จำนวน สิ่งของทั่วไป สูงสุดที่สามารถเก็บได้ในช่องเก็บของยานพาหนะ [number],
	-- 					maxWeaponLimit	= จำนวน อาวุธ สูงสุดที่สามารถเก็บได้ในช่องเก็บของยานพาหนะ [number],
	-- 					allowAccounts	= การอนุญาตให้เก็บ เงินต่างๆ [boolean],
	-- 					allowItems		= การอนุญาตให้เก็บ สิ่งของทั่วไป [boolean],
	-- 					allowWeapons	= การอนุญาตให้เก็บ อาวุธ [boolean]
	-- 				}

end

-- Function นี้จะถูกเรียกใช้ก่อนจะปิดกระเป๋า
-- [ storageType: ชนิดของช่องเก็บของยานพาหนะ | plate: ทะเบียนของยานพาหนะ | model: Model Hash ของยานพาหนะ | class: Class ของยานพาหนะ ]
-- [ xPlayer: xPlayer ของผู้เล่น | isOwner: เป็นเจ้าของยานพาหนะนี้หรือไม่ ]
Config.ServerWillCloseInventory = function(storageType, plate, model, class, xPlayer, isOwner)
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นปิดหน้าต่างกระเป๋าสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นปิดหน้าต่างกระเป๋าสำเร็จ
end
-- Function นี้จะถูกเรียกใช้หลังปิดกระเป๋าสำเร็จ
-- [ storageType: ชนิดของช่องเก็บของยานพาหนะ | plate: ทะเบียนของยานพาหนะ | model: Model Hash ของยานพาหนะ | class: Class ของยานพาหนะ ]
-- [ xPlayer: xPlayer ของผู้เล่น | isOwner: เป็นเจ้าของยานพาหนะนี้หรือไม่ ]
Config.ServerCloseInventory = function(storageType, plate, model, class, xPlayer, isOwner)
	
end