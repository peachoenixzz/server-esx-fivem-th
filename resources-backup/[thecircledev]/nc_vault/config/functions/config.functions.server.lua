-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

---------------------------------------------------
------------------- Server Side -------------------
---------------------------------------------------

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นใส่สิ่งของประเภทเงินเข้าตู้เซฟ (ก่อนใส่สิ่งของเข้าตู้เซฟ)
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | isOwner: เป็นเจ้าของตู้หรือไม่ ]
-- [ xPlayer: xPlayer ของผู้เล่น | accountName: ชื่อชนิดของเงิน | accountAmount: จำนวนเงิน ]
Config.ServerPlayerWillPutAccount = function(vaultType, vaultGroup, vaultId, vaultExp, xPlayer, accountName, accountAmount, isOwner)
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'VaultPutMoneyIn',
	content = ('%s อาชีพ %s ยศ %s ได้นำ %s จำนวน $%s เข้าตู้เซฟหมายเลข %s เป็นเจ้าของตู้ %s'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, accountName, accountAmount, vaultId, isOwner),
	source = xPlayer.source,
	options = {
		important = (accountAmount >= 100000 and true)
	}
	}) -- End log
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นใส่สิ่งของประเภทเงินเข้าตู้เซฟสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นใส่สิ่งของประเภทเงินเข้าตู้เซฟสำเร็จ
end
-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นใส่สิ่งของประเภทเงินเข้าตู้เซฟ (หลังใส่สิ่งของเข้าตู้เซฟสำเร็จ)
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | isOwner: เป็นเจ้าของตู้หรือไม่ ]
-- [ xPlayer: xPlayer ของผู้เล่น | accountName: ชื่อชนิดของเงิน | accountAmount: จำนวนเงิน ]
Config.ServerPlayerPutAccount = function(vaultType, vaultGroup, vaultId, vaultExp, xPlayer, accountName, accountAmount, isOwner)
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'VaultPutMoneyInRemove',
	content = ('%s อาชีพ %s ยศ %s ได้นำ %s จำนวน $%s เข้าตู้เซฟหมายเลข %s เป็นเจ้าของตู้ %s สูญเสีย %s จำนวน $%s เหลือเงินในกระเป๋าจำนวน $%s และเงินผิดกฏหมายจำนวน $%s'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, accountName, accountAmount, vaultId, isOwner, accountName, accountAmount, ESX.Math.GroupDigits(xPlayer.getMoney()), ESX.Math.GroupDigits(xPlayer.getAccount("black_money").money), isOwner),
	source = xPlayer.source,
	options = {
		important = (accountAmount >= 100000 and true)
	}
	}) -- End log
end

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นดึงสิ่งของประเภทเงินออกจากตู้เซฟ (ก่อนย้ายสิ่งของสำเร็จ)
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | isOwner: เป็นเจ้าของตู้หรือไม่ ]
-- [ xPlayer: xPlayer ของผู้เล่น | accountName: ชื่อชนิดของเงิน | accountAmount: จำนวนเงิน ]
Config.ServerPlayerWillTakeAccount = function(vaultType, vaultGroup, vaultId, vaultExp, xPlayer, accountName, accountAmount, isOwner)
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'VaultTakeMoneyOut',
	content = ('%s อาชีพ %s ยศ %s ได้นำ %s จำนวน $%s ออกจากตู้เซฟหมายเลข %s เป็นเจ้าของตู้ %s'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, accountName, accountAmount, vaultId, isOwner),
	source = xPlayer.source,
	options = {
		important = (accountAmount >= 100000 and true)
	}
	}) -- End log
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นดึงสิ่งของประเภทเงินออกจากตู้เซฟสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นดึงสิ่งของประเภทเงินออกจากตู้เซฟสำเร็จ
end
-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นดึงสิ่งของประเภทเงินออกจากตู้เซฟ (หลังย้ายสิ่งของสำเร็จ)
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | isOwner: เป็นเจ้าของตู้หรือไม่ ]
-- [ xPlayer: xPlayer ของผู้เล่น | accountName: ชื่อชนิดของเงิน | accountAmount: จำนวนเงิน ]
Config.ServerPlayerTookAccount = function(vaultType, vaultGroup, vaultId, vaultExp, xPlayer, accountName, accountAmount, isOwner)
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'VaultTakeMoneyOutAdd',
	content = ('%s อาชีพ %s ยศ %s ได้นำ %s จำนวน $%s ออกตู้เซฟหมายเลข %s เป็นเจ้าของตู้ %s ได้รับ %s จำนวน $%s เหลือเงินในกระเป๋าจำนวน $%s และเงินผิดกฏหมายจำนวน $%s'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, accountName, accountAmount, vaultId, isOwner, accountName, accountAmount, ESX.Math.GroupDigits(xPlayer.getMoney()), ESX.Math.GroupDigits(xPlayer.getAccount("black_money").money)),
	source = xPlayer.source,
	options = {
		important = (accountAmount >= 100000 and true)
	}
	}) -- End log
end

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นใส่สิ่งของเข้าตู้เซฟ (ก่อนใส่สิ่งของเข้าตู้เซฟ)
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | isOwner: เป็นเจ้าของตู้หรือไม่ ]
-- [ xPlayer: xPlayer ของผู้เล่น | itemName: ชื่อสิ่งของ | itemCount: จำนวนสิ่งของ ]
Config.ServerPlayerWillPutItem = function(vaultType, vaultGroup, vaultId, vaultExp, xPlayer, itemName, itemCount, isOwner)
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'VaultPutItemIn',
	content = ('%s อาชีพ %s ยศ %s ได้นำ %s จำนวน %s ชิ้น เข้าตู้เซฟหมายเลข %s เป็นเจ้าของตู้ %s'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, itemName, itemCount, vaultId, isOwner),
	source = xPlayer.source,
	}) -- End log
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นใส่สิ่งของทั่วไปเข้าตู้เซฟสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นใส่สิ่งของทั่วไปเข้าตู้เซฟสำเร็จ
end
-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นใส่สิ่งของเข้าตู้เซฟ (หลังใส่สิ่งของเข้าตู้เซฟสำเร็จ)
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | isOwner: เป็นเจ้าของตู้หรือไม่ ]
-- [ xPlayer: xPlayer ของผู้เล่น | itemName: ชื่อสิ่งของ | itemCount: จำนวนสิ่งของ ]
Config.ServerPlayerPutItem = function(vaultType, vaultGroup, vaultId, vaultExp, xPlayer, itemName, itemCount, isOwner)

end

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นดึงสิ่งของออกจากตู้เซฟ (ก่อนย้ายสิ่งของสำเร็จ)
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | isOwner: เป็นเจ้าของตู้หรือไม่ ]
-- [ xPlayer: xPlayer ของผู้เล่น | itemName: ชื่อสิ่งของ | itemCount: จำนวนสิ่งของ ]
Config.ServerPlayerWillTakeItem = function(vaultType, vaultGroup, vaultId, vaultExp, xPlayer, itemName, itemCount, isOwner)
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'VaultTakeItemOut',
	content = ('%s อาชีพ %s ยศ %s ได้นำ %s จำนวน %s ชิ้น ออกจากตู้เซฟหมายเลข %s เป็นเจ้าของตู้ %s'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, itemName, itemCount, vaultId, isOwner),
	source = xPlayer.source,
	}) -- End log
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นดึงสิ่งของทั่วไปออกจากตู้เซฟสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นดึงสิ่งของทั่วไปออกจากตู้เซฟสำเร็จ
end
-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นดึงสิ่งของออกจากตู้เซฟ (หลังย้ายสิ่งของสำเร็จ)
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | isOwner: เป็นเจ้าของตู้หรือไม่ ]
-- [ xPlayer: xPlayer ของผู้เล่น | itemName: ชื่อสิ่งของ | itemCount: จำนวนสิ่งของ ]
Config.ServerPlayerTookItem = function(vaultType, vaultGroup, vaultId, vaultExp, xPlayer, itemName, itemCount, isOwner)

end

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นใส่อาวุธเข้าตู้เซฟ (ก่อนใส่อาวุธเข้าตู้เซฟ)
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | isOwner: เป็นเจ้าของตู้หรือไม่ ]
-- [ xPlayer: xPlayer ของผู้เล่น | weaponName: ชื่อของอาวุธ | weaponAmmo: จำนวนกระสุน ]
Config.ServerPlayerWillPutWeapon = function(vaultType, vaultGroup, vaultId, vaultExp, xPlayer, weaponName, weaponAmmo, isOwner)
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'VaultPutWeaponIn',
	content = ('%s อาชีพ %s ยศ %s ได้นำ %s จำนวน %s ชิ้น จำนวนกระสุน %s นัด เข้าตู้เซฟหมายเลข %s เป็นเจ้าของตู้ %s'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, weaponName, weaponName.count, weaponAmmo, vaultId, isOwner, playerCoords),
	source = xPlayer.source,
	}) -- End log
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นใส่อาวุธเข้าตู้เซฟสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นใส่อาวุธเข้าตู้เซฟสำเร็จ
end
-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นใส่อาวุธเข้าตู้เซฟ (หลังใส่อาวุธเข้าตู้เซฟสำเร็จ)
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | isOwner: เป็นเจ้าของตู้หรือไม่ ]
-- [ xPlayer: xPlayer ของผู้เล่น | weaponName: ชื่อของอาวุธ | weaponAmmo: จำนวนกระสุน ]
Config.ServerPlayerPutWeapon = function(vaultType, vaultGroup, vaultId, vaultExp, xPlayer, weaponName, weaponAmmo, isOwner)

end

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นดึงอาวุธออกจากตู้เซฟ (ก่อนย้ายอาวุธสำเร็จ)
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | isOwner: เป็นเจ้าของตู้หรือไม่ ]
-- [ xPlayer: xPlayer ของผู้เล่น | weaponName: ชื่อของอาวุธ | weaponAmmo: จำนวนกระสุน ]
Config.ServerPlayerWillTakeWeapon = function(vaultType, vaultGroup, vaultId, vaultExp, xPlayer, weaponName, weaponAmmo, isOwner)
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'VaultTakeWeaponOut',
	content = ('%s อาชีพ %s ยศ %s ได้นำ %s จำนวน จำนวน %s ชิ้น จำนวนกระสุน %s นัด ออกจากตู้เซฟหมายเลข %s เป็นเจ้าของตู้ %s'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, weaponName, weaponName.count, weaponAmmo, vaultId, isOwner),
	source = xPlayer.source,
	}) -- End log
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นดึงอาวุธออกจากตู้เซฟสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นดึงอาวุธออกจากตู้เซฟสำเร็จ
end
-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นดึงอาวุธออกจากตู้เซฟ (หลังย้ายอาวุธสำเร็จ)
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | isOwner: เป็นเจ้าของตู้หรือไม่ ]
-- [ xPlayer: xPlayer ของผู้เล่น | weaponName: ชื่อของอาวุธ | weaponAmmo: จำนวนกระสุน ]
Config.ServerPlayerTookWeapon = function(vaultType, vaultGroup, vaultId, vaultExp, xPlayer, weaponName, weaponAmmo, isOwner)

end

-- Function นี้จะถูกเรียกก่อนจะสร้างตู้เซฟ [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | xPlayer: xPlayer ของผู้เล่น ]
Config.ServerWillCreateVault = function(vaultType, vaultGroup, xPlayer)
	exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบตู้เซฟ', -- หัวเรื่อง
        description = 'สร้างตู้เซฟสำเร็จ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'vault', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'VaultCreating',
	content = ('%s กำลังทำการสร้างตู้เซฟชนิด %s'):format(xPlayer.name, vaultType),
	source = xPlayer.source,
	}) -- End log
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นสร้างตู้เซฟสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นสร้างตู้เซฟสำเร็จ
end
-- Function นี้จะถูกเรียกใช้หลังจากสร้างตู้เซฟสำเร็จ [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | xPlayer: xPlayer ของผู้เล่น ]
Config.ServerCreatedVault = function(vaultType, vaultGroup, vaultId, xPlayer)
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'VaultCreated',
	content = ('%s ได้ทำการสร้างตู้เซฟชนิด %s ตู้เซฟหมายเลข %s สำเร็จ'):format(xPlayer.name, vaultType, vaultId),
	source = xPlayer.source,
	}) -- End log
end

-- Function นี้จะถูกเรียกก่อนจะลบตู้เซฟ [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: Exp ของตู้เซฟ | xPlayer: xPlayer ของผู้เล่น ]
Config.ServerWillRemoveVault = function(vaultType, vaultGroup, vaultId, vaultExp, xPlayer)
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นลบตู้เซฟสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นลบตู้เซฟสำเร็จ
end
-- Function นี้จะถูกเรียกใช้หลังจากลบตู้เซฟสำเร็จ [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: Exp ของตู้เซฟ | xPlayer: xPlayer ของผู้เล่น ]
Config.ServerRemovedVault = function(vaultType, vaultGroup, vaultId, vaultExp, xPlayer)

end

-- Function นี้จะถูกเรียกใช้ก่อนจะเปิดกระเป๋า [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: Exp ของตู้เซฟ | xPlayer: xPlayer ของผู้เล่น ]
Config.ServerWillOpenInventory = function(vaultType, vaultGroup, vaultId, vaultExp, xPlayer)
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นเปิดตู้เซฟ(หน้าต่างกระเป๋า)สำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นเปิดตู้เซฟ(หน้าต่างกระเป๋า)สำเร็จ
end
-- Function นี้จะถูกเรียกใช้เพื่อเปิดกระเป๋า
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: Exp ของตู้เซฟ ]
-- [ vaultItems: สิ่งของต่างๆในตู้เซฟ | vaultData: ข้อมูลต่างๆของตู้เซฟ | xPlayer: xPlayer ของผู้เล่น ]
Config.ServerOpenInventory = function(vaultType, vaultGroup, vaultId, vaultExp, vaultItems, vaultData, xPlayer)
	-- ตัวอย่างการส่งค่าของ vaultItems
	-- vaultItems =	{
	-- 					accounts		= ข้อมูล เงินต่างๆ [object],
	-- 					items			= ข้อมูล สิ่งของทั่วไป [object],
	-- 					weapons			= ข้อมูล อาวุธ [object]
	-- 				}

	-- ตัวอย่างการส่งค่าของ vaultData
	-- vaultData =	{
	-- 					slot			= จำนวนช่องที่ใช้ไป [number],
	-- 					maxSlot			= จำนวนช่องทั้งหมดที่สามารถที่ใช้งานได้ [number],
	-- 					weight			= น้ำหนักของสิ่งของรวมทั้งหมดในตู้เซฟ [number],
	-- 					maxWeight		= น้ำหนักสูงสุดที่สามารถเก็บสิ่งของได้ [number],
	-- 					accountsCount	= จำนวน เงินต่างๆ ทั้งหมดที่มีในตู้เซฟ [number],
	-- 					itemsCount		= จำนวน สิ่งของทั่วไป ทั้งหมดที่มีในตู้เซฟ [number],
	-- 					weaponsCount	= จำนวน อาวุธ ทั้งหมดที่มีในตู้เซฟ [number],
	-- 					maxAccountLimit	= จำนวน เงินต่างๆ สูงสุดที่สามารถเก็บได้ในตู้เซฟ [number],
	-- 					maxItemLimit	= จำนวน สิ่งของทั่วไป สูงสุดที่สามารถเก็บได้ในตู้เซฟ [number],
	-- 					maxWeaponLimit	= จำนวน อาวุธ สูงสุดที่สามารถเก็บได้ในตู้เซฟ [number],
	-- 					allowAccounts	= การอนุญาตให้เก็บ เงินต่างๆ [boolean],
	-- 					allowItems		= การอนุญาตให้เก็บ สิ่งของทั่วไป [boolean],
	-- 					allowWeapons	= การอนุญาตให้เก็บ อาวุธ [boolean]
	-- 				}

end

-- Function นี้จะถูกเรียกใช้ก่อนจะปิดกระเป๋า
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: Exp ของตู้เซฟ | xPlayer: xPlayer ของผู้เล่น ]
Config.ServerWillCloseInventory = function(vaultType, vaultGroup, vaultId, vaultExp, xPlayer)
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นปิดหน้าต่างกระเป๋าสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นปิดหน้าต่างกระเป๋าสำเร็จ
end
-- Function นี้จะถูกเรียกใช้หลังปิดกระเป๋าสำเร็จ
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: Exp ของตู้เซฟ | xPlayer: xPlayer ของผู้เล่น ]
Config.ServerCloseInventory = function(vaultType, vaultGroup, vaultId, vaultExp, xPlayer)

end

-- Function นี้จะถูกเรียกใช้ก่อนจะอัพเกรดตู้เซฟ
-- [ vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | itemList: รายชื่อสิ่งของต่างๆพร้อมจำนวน | vaultExp: ค่า EXP ของตู้เซฟ (ก่อนอัพเกรด) | xPlayer: xPlayer ของเจ้าของตู้เซฟ ]
Config.ServerWillUpgradeVault = function(vaultGroup, vaultId, itemList, vaultExp, xOwner)
	-- ตัวอย่างการส่งค่าของ itemList
	-- itemList	=	{
	-- 					{ itemType, itemName, itemCount },
	-- 					...
	-- 				}
	-- *itemType: ชนิดของสิ่งของ account|item, itemName: ชื่อสิ่งของ | itemCount: จำนวนสิ่งของ
	for _, item in ipairs(itemList) do -- For Log Purpose
        local itemType = item[1]
        local itemName = item[2]
        local itemCount = item[3]
		exports['azael_dc-serverlogs']:insertData({ -- Start log
		event = 'UpgardeVault',
		content = ('%s ได้ทำการอัพเกรดตู้เซฟ ID %s สูญเสีย %s จำนวน %s ชิ้น Discord ID: %s'):format(xOwner.name, vaultId, itemName, itemCount, xOwner.identifier),
		source = xOwner.source,
		}) -- End log
	end -- End Log

	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นอัพเกรดตู้เซฟสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นอัพเกรดตู้เซฟสำเร็จ
end
-- Function นี้จะถูกเรียกใช้หลังจากอัพเกรดตู้เซฟสำเร็จ
-- [ vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: ค่า EXP ของตู้เซฟ (หลังอัพเกรด) | xOwner: xPlayer ของเจ้าของตู้เซฟ ]
Config.ServerUpgradedVault = function(vaultGroup, vaultId, vaultExp, xOwner)
	exports['azael_dc-serverlogs']:insertData({ -- Start log
	event = 'VaultUpgraded',
	content = ('%s ได้ทำการอัพเกรดตู้เซฟ ID %s สำเร็จ ค่า EXP ของตู้เซฟหลังจากอัพเกรดแล้ว %s Discord ID: %s'):format(xOwner.name, vaultId, vaultExp, xOwner.identifier),
	source = xOwner.source,
	}) -- End log
end

-- Function นี้จะถูกเรียกใช้ก่อนจะเปลี่ยนชื่อตู้เซฟ
-- [ vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: Exp ของตู้เซฟ | lastName: ชื่อตู้เซฟเก่า | newName: ชื่อตู้เซฟใหม่ | xOwner: xPlayer ของเจ้าของตู้เซฟ ]
Config.ServerWillChangeVaultName = function(vaultGroup, vaultId, vaultExp, lastName, newName, xOwner)
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นเปลี่ยนชื่อตู้เซฟสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นเปลี่ยนชื่อตู้เซฟสำเร็จ
end
-- Function นี้จะถูกเรียกใช้หลังจากเปลี่ยนชื่อตู้เซฟสำเร็จ
-- [ vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: Exp ของตู้เซฟ | lastName: ชื่อตู้เซฟเก่า | newName: ชื่อตู้เซฟใหม่ | xOwner: xPlayer ของเจ้าของตู้เซฟ ]
Config.ServerChangedVaultName = function(vaultGroup, vaultId, vaultExp, lastName, newName, xOwner)
	exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบตู้เซฟ', -- หัวเรื่อง
        description = 'เปลี่ยนชื่อตู้เซฟสำเร็จ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'vault', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'vault', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

-- Function นี้จะถูกเรียกก่อนจะเพิ่มชื่อผู้เล่นเข้ารายชื่อการอนุญาตใช้งานตู้เซฟ
-- [ vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: Exp ของตู้เซฟ | playerIdentifier: Identifier ของผู้เล่นที่จะถูกเพิ่มเข้ารายชื่อ | xOwner: xPlayer ของเจ้าของตู้เซฟ ]
Config.ServerWillAddPlayerToVault = function(vaultGroup, vaultId, vaultExp, playerIdentifier, xOwner)
	return true		-- true: เมื่อ "ต้องการ" ให้เพิ่มรายชื่อสำเร็จ | false: เมื่อ "ไม่ต้องการ" ให้เพิ่มรายชื่อสำเร็จ
end
-- Function นี้จะถูกเรียกใช้หลังเพิ่มชื่อผู้เล่นเข้ารายชื่อการอนุญาตใช้งานตู้เซฟสำเร็จ
-- [ vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: Exp ของตู้เซฟ | playerIdentifier: Identifier ของผู้เล่นที่ถูกเพิ่มเข้ารายชื่อ | xOwner: xPlayer ของเจ้าของตู้เซฟ ]
Config.ServerAddedPlayerToVault = function(vaultGroup, vaultId, vaultExp, playerIdentifier, xOwner)

end

-- Function นี้จะถูกเรียกก่อนจะลบชื่อผู้เล่นออกจากรายชื่อการอนุญาตใช้งานตู้เซฟ
-- [ vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: Exp ของตู้เซฟ | playerIdentifier: Identifier ของผู้เล่นที่จะถูกลบออกจากรายชื่อ | xOwner: xPlayer ของเจ้าของตู้เซฟ ]
Config.ServerWillRemovePlayerFromVault = function(vaultGroup, vaultId, vaultExp, playerIdentifier, xOwner)
	return true		-- true: เมื่อ "ต้องการ" ลบรายชื่อสำเร็จ | false: เมื่อ "ไม่ต้องการ" ลบรายชื่อสำเร็จ
end
-- Function นี้จะถูกเรียกใช้หลังลบชื่อผู้เล่นออกจากรายชื่อการอนุญาตใช้งานตู้เซฟสำเร็จ
-- [ vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: Exp ของตู้เซฟ | playerIdentifier: Identifier ของผู้เล่นที่ถูกลบออกจากรายชื่อ | xOwner: xPlayer ของเจ้าของตู้เซฟ ]
Config.ServerRemovedPlayerFromVault = function(vaultGroup, vaultId, vaultExp, playerIdentifier, xOwner)

end