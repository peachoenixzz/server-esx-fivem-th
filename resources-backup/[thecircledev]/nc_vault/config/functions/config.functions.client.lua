-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

---------------------------------------------------
------------------- Client Side -------------------
---------------------------------------------------

-- Function นี้จะถูกเรียกใช้งานเมื่อไม่พบผู้เล่นในระยะในการแชร์ตู้เซฟ
Config.ClientNoNearbyPlayers = function()

end

-- Function นี้จะถูกเรียกใช้เมื่อเข้าใกล้ตู้เซฟต่างๆ
-- [ vaultType: ชนิดของตู้เซฟ ในที่นี้จะส่งมาเป็น 'group' เสมอ | vaultGroup: ชื่อกลุ่มของตู้เซฟ ]
Config.ClientEnteredVaultZone = function(vaultType, vaultGroup)
	exports.helpnotify:showHelpNotification("กด","E","เพื่อเปิดตู้")
end
-- Function นี้จะถูกเรียกใช้เมื่อออกจากระยะตู้เซฟต่างๆ
-- [ vaultType: ชนิดของตู้เซฟ ในที่นี้จะส่งมาเป็น 'group' เสมอ | vaultGroup: ชื่อกลุ่มของตู้เซฟ ]
Config.ClientExitedVaultZone = function(vaultType, vaultGroup)
	exports.helpnotify:hideHelpNotification()
end

-- Function นี้จะถูกเรียกใช้ก่อนจะเปิดหน้าต่างตู้เซฟ
-- [ vaultType: ชนิดของตู้เซฟ ในที่นี้จะส่งมาเป็น 'group' เสมอ | vaultGroup: ชื่อกลุ่มของตู้เซฟ ]
Config.ClientWillOpenVault = function(vaultType, vaultGroup)
	exports['azael_dc-serverlogs']:insertData({
		event = 'VaultOpenMenu',
		content = ('ผู้เล่นได้ทำการกด E เพื่อเปิดเมนูตู้เซฟ'):format(),
	})
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นสามารถเปิดหน้าต่างตู้เซฟได้ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นสามารถเปิดหน้าต่างตู้เซฟได้
end
-- Function นี้จะถูกเรียกใช้หลังเปิดหน้าต่างตู้เซฟสำเร็จ
-- [ vaultType: ชนิดของตู้เซฟ ในที่นี้จะส่งมาเป็น 'group' เสมอ | vaultGroup: ชื่อกลุ่มของตู้เซฟ ]
Config.ClientOpenedVault = function(vaultType, vaultGroup)
	Anim("anim@amb@office@boss@vault@right@female@","open", {
		["flag"] = 16,["speed"] = 8.0
	})
end

-- Function นี้จะถูกเรียกใช้หลังจากหน้าต่างตู้เซฟถูกปิด
-- [ vaultType: ชนิดของตู้เซฟ ในที่นี้จะส่งมาเป็น 'group' เสมอ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | onInventory: คือเปิดหน้าต่างกระเป๋าหรือไม่ ]
Config.ClientClosedVault = function(vaultType, vaultGroup, onInventory)
	exports['azael_dc-serverlogs']:insertData({
		event = 'VaultCloseMenu',
		content = ('ผู้เล่นได้ทำการปิดเมนูตู้เซฟ'):format(),
	})
	Anim("anim@amb@office@boss@vault@right@female@","close", {
		["flag"] = 49,["speed"] = 8.0
	})
	Wait(1000)
	ClearPedTasks(GetPlayerPed(-1))
end

-- Function นี้จะถูกเรียกใช้ก่อนจะเปิดกระเป๋า
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: ค่า EXP ของตู้เซฟ | isOwner: เป็นเจ้าของตู้หรือไม่ ]
Config.ClientWillOpenInventory = function(vaultType, vaultGroup, vaultId, vaultExp, isOwner)
	exports['azael_dc-serverlogs']:insertData({
		event = 'VaultOpenInventory',
		content = ('ผู้เล่นได้ทำการเปิดใช้งานตู้เซฟ'):format(),
	})
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นสามารถเปิดตู้เซฟ(หน้าต่างกระเป๋า)ได้ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นสามารถเปิดตู้เซฟ(หน้าต่างกระเป๋า)ได้
end
-- Function นี้จะถูกเรียกใช้เพื่อเปิดกระเป๋า
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: ค่า EXP ของตู้เซฟ | vaultItems: สิ่งของต่างๆในตู้เซฟ | vaultData: ข้อมูลต่างๆของตู้เซฟ | isOwner: เป็นเจ้าของตู้หรือไม่ ]
Config.ClientOpenInventory = function(vaultType, vaultGroup, vaultId, vaultExp, vaultItems, vaultData, isOwner)
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
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: ค่า EXP ของตู้เซฟ | isOwner: เป็นเจ้าของตู้หรือไม่ ]
Config.ClientWillCloseInventory = function(vaultType, vaultGroup, vaultId, vaultExp, isOwner)
	exports['azael_dc-serverlogs']:insertData({
		event = 'VaultCloseInventory',
		content = ('ผู้เล่นได้ทำการปิดการใช้งานตู้เซฟ'):format(),
	})
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นสามารถปิดหน้าต่างกระเป๋าได้ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นสามารถปิดหน้าต่างกระเป๋าได้
end
-- Function นี้จะถูกเรียกใช้หลังปิดกระเป๋าสำเร็จ
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: ค่า EXP ของตู้เซฟ | isOwner: เป็นเจ้าของตู้หรือไม่ ]
Config.ClientCloseInventory = function(vaultType, vaultGroup, vaultId, vaultExp, isOwner)

end

-- Function นี้จะถูกเรียกเมื่อมีการเปลี่ยนแปลงสิ่งของในตู้เซฟเมื่อผู้เล่นเปิดตู้เซฟอยู่
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: ค่า EXP ของตู้เซฟ | updateData: ข้อมูลการอัพเดท ]
Config.ClientUpdateInventory = function(vaultType, vaultGroup, vaultId, vaultExp, updateData)
	-- ตัวอย่างการส่งค่าของ updateData
	-- updateData =	{
	-- 					itemType	= ชนิดของสิ่งของ account|item|weapon [string],
	-- 					itemName	= ชื่อสิ่งของ [string],
	-- 					itemCount	= จำนวนสิ่งของ/จำนวนกระสุน [number],
	-- 					weaponKey	= Key ของอาวุธ (จะมีค่าเมื่อสิ่งของเป็นอาวุธ) [string],
	-- 					totalCount	= จำนวน สิ่งของ(ตามชนิดของ itemType) ที่มีทั้งหมดในตู้เซฟ [number],
	-- 					totalSlot	= จำนวนช่องที่ใช้ไป [number],
	-- 					totalWeight	= น้ำหนักของสิ่งของรวมทั้งหมดในตู้เซฟ [number]
	-- 				}

end

-- Function นี้จะถูกเรียกเมื่อข้อมูลตู้เซฟมีการเปลี่ยนแปลง (เมื่อผู้เล่นกำลังใช้งานตู้เซฟอยู่)
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: ค่า EXP ของตู้เซฟ (ก่อนอัพเกรด) | vaultData: ข้อมูลต่างๆของตู้เซฟ ]
Config.ClientUpdateVaultData = function(vaultType, vaultGroup, vaultId, vaultExp, vaultData)
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

-- Function นี้จะถูกเรียกใช้ก่อนจะอัพเกรดตู้เซฟ
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: Exp ของตู้เซฟ (หลังอัพเกรด) | itemList: รายชื่อสิ่งของต่างๆพร้อมจำนวน ]
Config.ClientWillUpgradeVault = function(vaultType, vaultGroup, vaultId, vaultExp, itemList)
	-- ตัวอย่างการส่งค่าของ itemList
	-- itemList	=	{
	-- 					{ itemType, itemName, itemCount },
	-- 					...
	-- 				}
	-- *itemType: ชนิดของสิ่งของ account|item, itemName: ชื่อสิ่งของ | itemCount: จำนวนสิ่งของ

	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นสามารถอัพเกรดตู้เซฟได้ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นสามารถอัพเกรดตู้เซฟได้
end
-- Function นี้จะถูกเรียกใช้หลังจากอัพเกรดตู้เซฟสำเร็จ
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: ค่า EXP ของตู้เซฟ ]
Config.ClientUpgradedVault = function(vaultType, vaultGroup, vaultId, vaultExp)

end

-- Function นี้จะถูกเรียกใช้ก่อนจะเปลี่ยนชื่อตู้เซฟ
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vvaultId: หมายเลขตู้เซฟ | vaultExp: Exp ของตู้เซฟ | newName: ชื่อตู้เซฟใหม่ ]
Config.ClientWillChangeVaultName = function(vaultType, vaultGroup, vaultId, vaultExp, newName)

	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นสามารถเปลี่ยนชื่อตู้เซฟได้ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นสามารถเปลี่ยนชื่อตู้เซฟได้
end
-- Function นี้จะถูกเรียกใช้หลังจากเปลี่ยนชื่อตู้เซฟสำเร็จ
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vvaultId: หมายเลขตู้เซฟ | vaultExp: Exp ของตู้เซฟ | newName: ชื่อตู้เซฟใหม่ ]
Config.ClientChangedVaultName = function(vaultType, vaultGroup, vaultId, vaultExp, newName)

end

-- Function นี้จะถูกเรียกก่อนจะสร้างตู้เซฟ
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ ]
Config.ClientWillCreateVault = function(vaultType, vaultGroup)
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นสามารถสร้างตู้เซฟได้ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นสามารถสร้างตู้เซฟได้
end
-- Function นี้จะถูกเรียกใช้หลังจากสร้างตู้เซฟสำเร็จ
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ ]
Config.ClientCreatedVault = function(vaultType, vaultGroup, vaultId)

end

-- Function นี้จะถูกเรียกก่อนจะลบตู้เซฟ
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: Exp ของตู้เซฟ ]
Config.ClientWillRemoveVault = function(vaultType, vaultGroup, vaultId, vaultExp)
	return true		-- true: เมื่อ "ต้องการ" ให้ผู้เล่นสามารถลบตู้เซฟได้ | false: เมื่อ "ไม่ต้องการ" ให้ผู้เล่นสามารถลบตู้เซฟได้
end
-- Function นี้จะถูกเรียกใช้หลังจากลบตู้เซฟสำเร็จ
-- [ vaultType: ชนิดของตู้เซฟ | vaultGroup: ชื่อกลุ่มของตู้เซฟ | vaultId: หมายเลขตู้เซฟ | vaultExp: Exp ของตู้เซฟ ]
Config.ClientRemovedVault = function(vaultType, vaultGroup, vaultId, vaultExp)

end

-- Function นี้จะถูกเรียกใช้งานเมื่อมี Error
-- errAction จะมี 'general' => สร้างตู้เซฟ | 'create_vault' => สร้างตู้เซฟ | 'share_vault' => แบ่งปันตู้เซฟ | 'open_inventory' => เปิดหน้าต่างกระเป๋า | 'move_item' => เคลื่อนย้ายสิ่งของ
-- และอื่นๆตามชื่อของกระเป๋ารองที่ส่งเข้ามา เช่น 'vault'
-- errType ที่ถูกส่งมาจะมีอยู่ 2 ชนิดคือ 'error' และ 'warning'
-- errText ที่จะถูกส่งมาในรูปแบบต่างๆดังนี้
-- outside_range					=> ทั่วไป - คุณอยู่นอกระยะตู้เซฟ
-- not_enough_items					=> สร้างตู้เซฟ | เปิดหน้าต่างกระเป๋า - คุณมีสิ่งของที่ต้องการไม่เพียงพอ
-- can_not_share					=> แบ่งปันตู้เซฟ - คุณมีสิ่งของที่ต้องการไม่เพียงพอ
-- action_too_quick					=> เคลื่อนย้ายสิ่งของ - คุณเคลื่อนย้ายสิ่งของเร็วเกินไป
-- player_account_no_account		=> เคลื่อนย้ายสิ่งของ - คุณไม่มีเงินชนิดนี้อยู่ในกระเป๋า
-- player_account_exceed_weight		=> เคลื่อนย้ายสิ่งของ - น้ำหนักในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บเงินชนิดนี้
-- player_item_no_item				=> เคลื่อนย้ายสิ่งของ - คุณไม่มีของสิ่งนี้อยู่ในกระเป๋า
-- player_item_exceed_limit			=> เคลื่อนย้ายสิ่งของ - พื้นที่ในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บของสิ่งนี้
-- player_item_exceed_weight		=> เคลื่อนย้ายสิ่งของ - น้ำหนักในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บของสิ่งนี้
-- player_weapon_no_weapon			=> เคลื่อนย้ายสิ่งของ - คุณไม่มีอาวุธชิ้นนี้อยู่ในกระเป๋า
-- player_weapon_exceed_weight		=> เคลื่อนย้ายสิ่งของ - น้ำหนักในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บอาวุธชิ้นนี้
-- player_weapon_already_have		=> เคลื่อนย้ายสิ่งของ - คุณมีอาวุธชนิดนี้อยู่ในกระเป๋าอยู่แล้ว
-- vault_account_blacklist			=> เคลื่อนย้ายสิ่งของ - เงินชนิดนี้ไม่สามารถเก็บในตู้เซฟนี้ได้
-- vault_account_exceed_slot		=> เคลื่อนย้ายสิ่งของ - ตู้เซฟนี้มีช่องไม่พอสำหรับเก็บเงินชนิดนี้เพิ่ม
-- vault_account_exceed_limit		=> เคลื่อนย้ายสิ่งของ - ตู้เซฟนี้มีที่ว่างไม่พอสำหรับเก็บเงินเพิ่มได้อีก
-- vault_account_exceed_weight		=> เคลื่อนย้ายสิ่งของ - น้ำหนักของเงินมากเกินไปสำหรับเก็บในตู้เซฟนี้
-- vault_account_not_allow			=> เคลื่อนย้ายสิ่งของ - ตู้เซฟนี้ไม่อนุญาตให้เก็บเงินได้
-- vault_item_blacklist				=> เคลื่อนย้ายสิ่งของ - ของสิ่งนี้ไม่สามารถเก็บในตู้เซฟนี้ได้
-- vault_item_exceed_slot			=> เคลื่อนย้ายสิ่งของ - ตู้เซฟนี้มีช่องไม่พอสำหรับเก็บสิ่งของชนิดนี้เพิ่ม
-- vault_item_exceed_limit			=> เคลื่อนย้ายสิ่งของ - ตู้เซฟนี้มีที่ว่างไม่พอสำหรับเก็บสิ่งของชิ้นนี้เพิ่มได้อีก
-- vault_item_exceed_weight			=> เคลื่อนย้ายสิ่งของ - น้ำหนักของสิ่งของมากเกินไปสำหรับเก็บในตู้เซฟนี้
-- vault_item_not_allow				=> เคลื่อนย้ายสิ่งของ - ตู้เซฟนี้ไม่อนุญาตให้เก็บสิ่งของทั่วไปได้
-- vault_weapon_blacklist			=> เคลื่อนย้ายสิ่งของ - อาวุธชนิดนี้ไม่สามารถเก็บในตู้เซฟนี้ได้
-- vault_weapon_exceed_slot			=> เคลื่อนย้ายสิ่งของ - ตู้เซฟนี้มีช่องไม่พอสำหรับเก็บอาวุธชนิดนี้เพิ่ม
-- vault_weapon_exceed_limit		=> เคลื่อนย้ายสิ่งของ - ตู้เซฟนี้มีที่ว่างไม่พอสำหรับเก็บอาวุธเพิ่มได้อีก
-- vault_weapon_exceed_weight		=> เคลื่อนย้ายสิ่งของ - น้ำหนักของอาวุธชิ้นนี้มากเกินไปสำหรับเก็บในตู้เซฟนี้
-- vault_weapon_not_allow			=> เคลื่อนย้ายสิ่งของ - ตู้เซฟนี้ไม่อนุญาตให้เก็บอาวุธได้
Config.ClientNotificationError = function(errAction, errType, errText, itemName)
	-- ตัวอย่างการเขียน Notification ต่างๆ
	-- outside_range					=> 'error' - คุณอยู่นอกระยะตู้เซฟ
	-- not_enough_items					=> 'error' - คุณมีสิ่งของที่ต้องการไม่เพียงพอ
	-- can_not_share					=> 'error' - ระดับตู้เซฟของคุณยังไม่สามารถเพิ่มรายชื่อผู้อื่นให้เข้าใช้งานได้
	-- action_too_quick					=> 'warning' - คุณเคลื่อนย้ายสิ่งของเร็วเกินไป
	-- player_account_no_account		=> 'error' - คุณไม่มีเงินชนิดนี้อยู่ในกระเป๋า
	-- player_account_exceed_weight		=> 'error' - น้ำหนักในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บเงินชนิดนี้
	-- player_item_no_item				=> 'error' - คุณไม่มีของสิ่งนี้อยู่ในกระเป๋า
	-- player_item_exceed_limit			=> 'error' - พื้นที่ในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บของสิ่งนี้
	-- player_item_exceed_weight		=> 'error' - น้ำหนักในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บของสิ่งนี้
	-- player_weapon_no_weapon			=> 'error' - คุณไม่มีอาวุธชิ้นนี้อยู่ในกระเป๋า
	-- player_weapon_exceed_weight		=> 'error' - น้ำหนักในกระเป๋าของคุณไม่เพียงพอสำหรับเก็บอาวุธชิ้นนี้
	-- player_weapon_already_have		=> 'error' - คุณมีอาวุธชนิดนี้อยู่ในกระเป๋าอยู่แล้ว
	-- vault_account_blacklist			=> 'error' - เงินชนิดนี้ไม่สามารถเก็บในตู้เซฟนี้ได้
	-- vault_account_exceed_slot		=> 'error' - ตู้เซฟนี้มีช่องไม่พอสำหรับเก็บเงินชนิดนี้เพิ่ม
	-- vault_account_exceed_limit		=> 'error' - ตู้เซฟนี้มีที่ว่างไม่พอสำหรับเก็บเงินเพิ่มได้อีก
	-- vault_account_exceed_weight		=> 'error' - น้ำหนักของเงินมากเกินไปสำหรับเก็บในตู้เซฟนี้
	-- vault_account_not_allow			=> 'error' - ตู้เซฟนี้ไม่อนุญาตให้เก็บเงินได้
	-- vault_item_blacklist				=> 'error' - ของสิ่งนี้ไม่สามารถเก็บในตู้เซฟนี้ได้
	-- vault_item_exceed_slot			=> 'error' - ตู้เซฟนี้มีช่องไม่พอสำหรับเก็บสิ่งของชนิดนี้เพิ่ม
	-- vault_item_exceed_limit			=> 'error' - ตู้เซฟนี้มีที่ว่างไม่พอสำหรับเก็บสิ่งของชิ้นนี้เพิ่มได้อีก
	-- vault_item_exceed_weight			=> 'error' - น้ำหนักของสิ่งของมากเกินไปสำหรับเก็บในตู้เซฟนี้
	-- vault_item_not_allow				=> 'error' - ตู้เซฟนี้ไม่อนุญาตให้เก็บสิ่งของทั่วไปได้
	-- vault_weapon_blacklist			=> 'error' - อาวุธชนิดนี้ไม่สามารถเก็บในตู้เซฟนี้ได้
	-- vault_weapon_exceed_slot			=> 'error' - ตู้เซฟนี้มีช่องไม่พอสำหรับเก็บอาวุธชนิดนี้เพิ่ม
	-- vault_weapon_exceed_limit		=> 'error' - ตู้เซฟนี้มีที่ว่างไม่พอสำหรับเก็บอาวุธเพิ่มได้อีก
	-- vault_weapon_exceed_weight		=> 'error' - น้ำหนักของอาวุธชิ้นนี้มากเกินไปสำหรับเก็บในตู้เซฟนี้
	-- vault_weapon_not_allow			=> 'error' - ตู้เซฟนี้ไม่อนุญาตให้เก็บอาวุธได้
	
	if errText == 'player_weapon_already_have' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบตู้เซฟ', -- หัวเรื่อง
			description = 'คุณมีอาวุธชนิดนี้อยู่ในกระเป๋าอยู่แล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_vault', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'vault_weapon_exceed_limit' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบตู้เซฟ', -- หัวเรื่อง
			description = 'ตู้เซฟมีที่ว่างไม่เพียงพอสำหรับเก็บอาวุธชิ้นนี้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_vault', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'vault_item_exceed_weight' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบตู้เซฟ', -- หัวเรื่อง
			description = 'น้ำหนักตู้เซฟเต็ม', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_vault', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	elseif errText == 'player_item_exceed_weight' then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบน้ำหนัก', -- หัวเรื่อง
			description = 'น้ำหนักกระเป๋าเต็ม', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'inventory_max', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	else
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบตู้เซฟ', -- หัวเรื่อง
			description = 'คุณไม่มีไอเทมที่กำหนด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'no_vault', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 3000 -- ระยะเวลาการแสดง Notify
		})
	end
end

Anim = function(dict, anim, settings)
	if dict then
		Citizen.CreateThread(function()
			RequestAnimDict(dict)

			while not HasAnimDictLoaded(dict) do
				Citizen.Wait(100)
			end

			if settings == nil then
				TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
			else
				local speed = 1.0
				local speedMultiplier = -1.0
				local duration = 1.0
				local flag = 0
				local playbackRate = 0

				if settings["speed"] then
					speed = settings["speed"]
				end

				if settings["speedMultiplier"] then
					speedMultiplier = settings["speedMultiplier"]
				end

				if settings["duration"] then
					duration = settings["duration"]
				end

				if settings["flag"] then
					flag = settings["flag"]
				end

				if settings["playbackRate"] then
					playbackRate = settings["playbackRate"]
				end

				TaskPlayAnim(PlayerPedId(), dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
			end

			RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(PlayerPedId(), anim, 0, true)
	end
end