-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

---------------------------------------------------
------------------- Client Side -------------------
---------------------------------------------------

-- Function นี้จะถูกเรียกใช้งานเมื่อมีการโหลดข้อมูลครั้งแรก (ในฝั่ง Client)
Config.ClientOnFirstLoaded = function()
	
end

-- Function นี้จะถูกเรียกใช้งานก่อนเปิดกระเป๋า (secondaryName จะมีค่าเมื่อเปิดกระเป๋าสอง)
Config.ClientWillOpenInventory = function(secondaryName)
	return true				-- return true เมื่อต้องการให้เปิดกระเป๋า
end

-- Function นี้จะถูกเรียกใช้งานเมื่อเปิดกระเป๋าสำเร็จ (secondaryName จะมีค่าเมื่อเปิดกระเป๋าสอง)
Config.ClientOpenedInventory = function(secondaryName)
	exports['azael_dc-serverlogs']:insertData({
		event = 'OpenSecondaryBackSuccess',
		content = ('เปิดกระเป๋าที่สองสำเร็จ'),
		source = serverId,
		color = 7,
		options = {
			public = false,
			important = false
		}
	})
end

-- Function นี้จะถูกเรียกใช้งานเมื่อปิดกระเป๋าสำเร็จ (secondaryName จะมีค่าเมื่อปิดกระเป๋าสอง)
Config.ClientClosedInventory = function(secondaryName)
	if secondaryName == 'trunk' or secondaryName == 'vault' then
		TriggerEvent('nc_inventory_bridge:CloseInventory')
	end
end

-- Function นี้จะถูกเรียกใช้งานก่อนผู้เล่นใช้งานสิ่งของ
-- shortcut จะส่งมาเป็นเลขของช่องที่ใช้งานสิ่งของ หากไม่ได้ใช้งานสิ่งของผ่าน Shortcut จะส่งมาเป็น nil
Config.ClientWillUseItem = function(itemName, itemType, shortcut)
	if exports.esx_policejob:getStatusHandcuffed() then return false end
	if itemName == 'card_gang' then
		exports.cc_uicard_gang:showIDCardGang()
		return false
	end
	if itemName == 'card_id' then
		exports.cc_uicard:showIDCard()
		return false
	end
	if itemName == 'card_reskin' then
		exports.nc_inventory:CloseInventory()
		return true
	end
	if itemType == 'vehicle_key' then
		pcall(function() exports.nc_vehiclekey:ToggleLockVehicle(itemName) end)
		return false
	end
	return true				-- return true เมื่อต้องการให้ใช้งานสิ่งของ
end

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นใช้งานสิ่งของสำเร็จ
-- shortcut จะส่งมาเป็นเลขของช่องที่ใช้งานสิ่งของ หากไม่ได้ใช้งานสิ่งของผ่าน Shortcut จะส่งมาเป็น nil
Config.ClientUsedItem = function(itemName, itemType, shortcut)
	
end

-- Function นี้จะถูกเรียกใช้งานก่อนผู้เล่นทิ้งสิ่งของ
-- optionType จะถูกส่งมาเมื่อ itemType == 'accessory' โดยเป็นชนิดของเครื่องประดับ 'player_glasses', 'player_mask', ...
-- สำหรับ Extended Item หาก return true จำนวนจะลดลงเมื่อทิ้งของ
Config.ClientWillDropItem = function(itemName, itemLabel, itemCount, itemType, optionType)
	if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
		return false
	end
	if itemType == 'accessory' then return false  end
	exports.nc_notify:PushNotification( {
		category = 'item',  -- หมวดหมู่ของ Notify * หากไม่ใส่จะเป็น 'message'
		list = {  -- List Items ที่จะแสดง (category ต้องเป็น 'item' เท่านั้น)
			{ key = itemName, label =itemLabel, quantity = itemCount, type = 'remove' },
		},
		title = 'ระบบทิ้งของ',  -- หัวเรื่อง
		description = 'กำลังทิ้งของ',  -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning',  -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top',  -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right',  -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'high',  -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'

		duration = 60000  -- ระยะเวลาการแสดง Notify
	})

	Citizen.Wait(60000)
	return true				-- return true เมื่อต้องการให้ทิ้งสิ่งของ
end

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นทิ้งสิ่งของสำเร็จ
-- optionType จะถูกส่งมาเมื่อ itemType == 'accessory' โดยเป็นชนิดของเครื่องประดับ 'player_glasses', 'player_mask', ...
Config.ClientDroppedItem = function(itemName, itemLabel, itemCount, itemType, optionType)
	exports['azael_dc-serverlogs']:insertData({
		event = 'DeleteItemSuccess',
		content = ('ทิ้งสิ่งของสำเร็จ สิ่งที่ทิ้ง คือ %s จำนวน %s'):format(itemName,itemCount),
		source = serverId,
		color = 7,
		options = {
			public = false,
			important = false
		}
	})
	return true
end

-- Function นี้จะถูกเรียกใช้งานก่อนผู้เล่นมอบสิ่งของ
-- optionType จะถูกส่งมาเมื่อ itemType == 'accessory' โดยเป็นชนิดของเครื่องประดับ 'player_glasses', 'player_mask', ...
-- สำหรับ Extended Item หาก return true จำนวนจะลดลงเมื่อมอบของให้ผู้อื่น (แต่ระบบกระเป๋าจะไม่มีการเพิ่มของชิ้นนี้ให้กับผู้อื่น)
Config.ClientWillGiveItem = function(targetId, itemName, itemLabel, itemCount, itemType, optionType)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetId))
	--print(targetPed)

	if itemName == 'T1_WEAPON_BOTTLE' or itemName == 'T1_WEAPON_POOLCUE' or itemName == 'T1_WEAPON_MACHETE' or itemName == 'T1_WEAPON_KNUCKLE' then
		if exports.cc_tradecar:checkZoneGiveT1Weapon() then
			return true
		end
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบโอนอาวุธ', -- หัวเรื่อง
			description = 'คุณไม่ได้อยู่ภายในพื้นที่', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
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
	if itemType == 'vehicle_key' then
		if exports.cc_tradecar:checkZoneTradeCar() then
			exports.nc_inventory:UpdateItems('vehicle_key')
			local typesMap = { account = 'item_account', item = 'item_standard', weapon = 'item_weapon' }
			local originalType = typesMap[itemType]
			if originalType then
				TriggerEvent('xzero_giveui:client:On_GiveItem', {
					number = itemCount,
					player = targetId,
					item = {
						type = originalType,
						name = itemName,
						label = itemLabel,
						count = itemCount
					}
				})
			end
			return true
		end
		return false
	end
	if IsPedInAnyVehicle(targetPed, true) or IsPedInAnyVehicle(PlayerPedId(), true) then
		exports.nc_inventory:UpdateItems('vehicle_key')
		exports['azael_dc-serverlogs']:insertData({
			event = 'GiveItemFalse',
			content = ('มอบสิ่งของไม่สำเร็จ สิ่งที่มอบไม่สำเร็จ คือ %s คนที่ไม่ได้รับ คือ %s จำนวน %s'):format(itemName, GetPlayerName(GetPlayerFromServerId(targetId)), itemCount),
			source = serverId,
			options = {
				public = false,
				important = false
			}
		})
		return false
	end
	if itemType == 'accessory' then return false  end
	exports['azael_dc-serverlogs']:insertData({
		event = 'GiveItemSuccess',
		content = ('มอบสิ่งของสำเร็จ สิ่งที่ได้รับ คือ %s คนที่ได้รับ คือ %s จำนวน %s'):format(itemName, GetPlayerName(GetPlayerFromServerId(targetId)), itemCount),
		source = serverId,
		options = {
			public = false,
			important = false
		}
	})
	local typesMap = { account = 'item_account', item = 'item_standard', weapon = 'item_weapon' }
	local originalType = typesMap[itemType]
	if originalType then
		TriggerEvent('xzero_giveui:client:On_GiveItem', {
			number = itemCount,
			player = targetId,
			item = {
				type = originalType,
				name = itemName,
				label = itemLabel,
				count = itemCount
			}
		})
	end
	return true				-- return true เมื่อต้องการให้มอบสิ่งของ
end

-- Function นี้จะถูกเรียกใช้งานเมื่อผู้เล่นมอบสิ่งของสำเร็จ
-- optionType จะถูกส่งมาเมื่อ itemType == 'accessory' โดยเป็นชนิดของเครื่องประดับ 'player_glasses', 'player_mask', ...
Config.ClientGaveItem = function(targetId, itemName, itemLabel, itemCount, itemType, optionType)

end
RegisterNetEvent('nc_inventory:playAnimation')
AddEventHandler('nc_inventory:playAnimation', function()
	local settings = { flag = 48}
	PlayAnimation(PlayerPedId(), "mp_common", "givetake1_a",settings)
end)

PlayAnimation = function(ped, dict, anim, settings)
	if dict then
		Citizen.CreateThread(function()
			RequestAnimDict(dict)

			while not HasAnimDictLoaded(dict) do
				Citizen.Wait(100)
			end

			if settings == nil then
				TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
			else
				local speed = 1.0
				local speedMultiplier = -1.0
				local duration = 1.0
				local flag = 0
				local playbackRate = 0

				if settings["speed"] ~= nil then
					speed = settings["speed"]
				end

				if settings["speedMultiplier"] ~= nil then
					speedMultiplier = settings["speedMultiplier"]
				end

				if settings["duration"] ~= nil then
					duration = settings["duration"]
				end

				if settings["flag"] ~= nil then
					flag = settings["flag"]
				end

				if settings["playbackRate"] ~= nil then
					playbackRate = settings["playbackRate"]
				end

				TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
			end

			RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end
-- Function นี้จะถูกเรียกใช้งานเมื่อย้ายสิ่งระหว่างกระเป๋าหลักกับกระเป๋าสอง
-- dragAction จะมี 2 ค่าคือ 'put' => ใส่ของเข้ากระเป๋าสอง | 'take' => นำของออกจากกระเป๋าสอง
-- ตัวอย่างค่า item ที่ส่งมา
-- item = {
--     number = 3,						-- จำนวนที่กระทำครั้งนั้นๆ (อาวุธจะส่งมาเป็น 1 เสมอ)
--     type = 'account|item|weapon',	-- ชนิดของ Item
--     name = 'itemName',				-- ชื่อ Item
--     count = 10						-- จำนวนของสื่งนี้/กระสุน ที่มีในกระเป๋า
-- }
-- หากต้องการชื่อ Job ที่ต้องการให้ใช้ job.name และตำแหน่งให้ใช้ job.grade_name
-- สำหรับการค้นตัวผู้เล่น secondaryName ที่ส่งมาจะเป็น 'search'
Config.ClientSecondaryInventoryAction = function(secondaryName, dragAction, item, job)
	if secondaryName == 'trunk' or secondaryName == 'vault' then
		TriggerEvent('nc_inventory_bridge:Action', secondaryName, dragAction, item)	-- ส่งค่าเข้าตัวแปลงให้เข้ากับกระเป๋าอื่นๆ (by NC Developer)
	end
	return true				-- return true เมื่อต้องการให้ Trigger ไปเคลื่อนย้ายสิ่งของในฝั่ง Server (สำหรับ secondaryName == 'search')
end

-- Function นี้จะถูกเรียกใช้งานเมื่อกดใช้งานอาวุธที่จะทำ Animation หยิบ/เก็บ อาวุธ
-- animationType จะมี 2 ค่าคือ 'put' => เก็บอาวุธ | 'take' => หยิบอาวุธ
Config.ClientWillDoAnimationOnUseWeapon = function(animationType, weaponHash)
	return true				-- return true เมื่อต้องการให้ดำเนินการทำ Animation ต่อตามปกติ | return false เพื่อข้ามการทำ Animation
end

-- Function นี้จะถูกเรียกใช้งานเมื่อสิ้นสุด Animation หยิบ/เก็บ อาวุธ
-- animationType จะมี 2 ค่าคือ 'put' => เก็บอาวุธ | 'take' => หยิบอาวุธ
Config.ClientDoneAnimationOnUseWeapon = function(animationType, weaponHash)

end

-- Function นี้จะถูกเรียกใช้งานเมื่อน้ำหนักกระเป๋าถึงขีดจำกัด
Config.ClientInventoryOverweight = function(currentWeight, maxWeight)

end

-- Function นี้จะถูกเรียกใช้งานเมื่อน้ำหนักกระเป๋าต่ำกว่าขีดจำกัด
Config.ClientInventoryFree = function(currentWeight, maxWeight)

end

-- Function นี้จะถูกเรียกใช้งานเมื่อมีการ Spam ใช้งานสิ่งของต่างๆ
-- หากผู้เล่น Spam การใช้งาน action จะส่งมาเป็น 'use'
Config.ClientSpamAction = function(action)
	if action == 'use' then
		
	end
end

-- Function นี้จะถูกเรียกใช้งานเมื่อไม่พบผู้เล่นในระยะในการมอบสิ่งของ
Config.ClientNoNearbyPlayers = function()

end

-- Function นี้จะถูกเรียกใช้งานเมื่อมี Error
-- errAction จะมี 'give' => ผู้เล่นมอบของ | 'search' => ผู้เล่นย้ายของระหว่างกระเป๋าผู้เล่นคนอื่น | 'search_busy' => ไม่สามารถค้นกระเป๋าของผู้เล่นคนอื่นได้
-- และอื่นๆตามชื่อของกระเป๋าสองที่ส่งเข้ามา เช่น 'trunk', 'vault'
-- errType ที่ถูกส่งมาจะมีอยู่ 2 ชนิดคือ 'error' และ 'warning'
-- errText ที่จะถูกส่งมาในรูปแบบต่างๆดังนี้
-- source_account_not_enough		=>	ผู้เล่นที่เป็นคนเปิดกระเป๋า - มีเงินชนิดต่างๆไม่พอสำหรับให้ผู้อื่น
-- source_account_exceed_weight		=>	ผู้เล่นที่เป็นคนเปิดกระเป๋า - น้ำหนักเต็มจากการดึงเงินผู้อื่น
-- source_item_not_enough			=>	ผู้เล่นที่เป็นคนเปิดกระเป๋า - มีสิ่งของชนิดต่างๆไม่พอสำหรับให้ผู้อื่น
-- source_item_exceed_weight		=>	ผู้เล่นที่เป็นคนเปิดกระเป๋า - น้ำหนักเต็มจากการดึงสิ่งของผู้อื่น
-- source_item_exceed_limit			=>	ผู้เล่นที่เป็นคนเปิดกระเป๋า - จำนวนสิ่งของถึง Limit จากการดึงของจากผู้อื่น
-- source_weapon_exceed_weight		=>	ผู้เล่นที่เป็นคนเปิดกระเป๋า - น้ำหนักเต็มจากการดึงอาวุธผู้อื่น
-- source_weapon_exceed_limit		=>	ผู้เล่นที่เป็นคนเปิดกระเป๋า - คุณมีอาวุธชนิดนี้อยู่แล้ว
-- target_account_not_enough		=>	ผู้เล่นที่ถูกเปิดกระเป๋า - มีเงินชนิดต่างๆไม่พอให้คนเปิดกระเป๋าดึงออก
-- target_account_exceed_weight		=>	ผู้เล่นมอบของให้ผู้อื่น | ผู้เล่นที่ถูกเปิดกระเป๋า - น้ำหนักเต็มเมื่อคนเปิดกระเป๋าใส่เงินเข้ามา
-- target_item_not_enough			=>	ผู้เล่นที่ถูกเปิดกระเป๋า - มีสิ่งของชนิดต่างๆไม่พอให้คนเปิดกระเป๋าดึงออก
-- target_item_exceed_weight		=>	ผู้เล่นมอบของให้ผู้อื่น | ผู้เล่นที่ถูกเปิดกระเป๋า - น้ำหนักเต็มเมื่อคนเปิดกระเป๋าใส่ของเข้ามา
-- target_item_exceed_limit			=>	ผู้เล่นมอบของให้ผู้อื่น | ผู้เล่นที่ถูกเปิดกระเป๋า - จำนวนสิ่งของถึง Limit เมื่อคนเปิดกระเป๋าใส่ของเข้ามา
-- target_weapon_exceed_weight		=>	ผู้เล่นมอบของให้ผู้อื่น | ผู้เล่นที่ถูกเปิดกระเป๋า - น้ำหนักเต็มเมื่อคนเปิดกระเป๋าใส่อาวุธเข้ามา
-- target_weapon_exceed_limit		=>	ผู้เล่นมอบของให้ผู้อื่น | ผู้เล่นที่ถูกเปิดกระเป๋า - คนๆนี้มีอาวุธชนิดนี้อยู่แล้ว
-- target_block_giving				=>	ผู้เล่นมอบของให้ผู้อื่น - ปิดรับการมอบของจากผู้อื่น
-- target_being_searched			=>	ผู้เล่นที่ถูกเปิดกระเป๋า - กำลังถูกผู้อื่นค้นกระเป๋าอยู่
-- target_not_found					=>	ผู้เล่นที่ถูกเปิดกระเป๋า - ไม่พบคนที่คุณต้องการจะค้นกระเป๋า
-- ซึ่ง 'error' จะถูกส่งมาเมื่อย้ายของไม่ได้ และ 'warning' จะถูกส่งมาเมื่อเคลื่อนย้ายของได้ไม่ถึงจำนวนที่กำหนด อันเนื่องจาก เกิน limit หรือ น้ำหนักกระเป๋าไม่พอ
Config.OnError = function(errAction, errType, errText, itemName)
	-- ตัวอย่างการเขียน Notification ต่างๆ
	-- source_account_not_enough		=>	'error' - คุณไม่มีเงินในกระเป๋า | 'warning' - คุณมีเงินไม่มากพอสำหรับเงินจำนวนที่คุณต้องการ
	-- source_account_exceed_weight		=>	'error' - น้ำหนักกระเป๋าคุณเต็มแล้ว | 'warning' - นำหนักที่เหลือกระเป๋าของคุณไม่มากพอสำหรับเงินทั้งหมด
	-- source_item_not_enough			=>	'error' - คุณไม่มีของสิ่งนี้ | 'warning' - คุณมีของสิ่งนี้ไม่มากพอสำหรับในจำนวนที่คุณต้องการ
	-- source_item_exceed_weight		=>	'error' - น้ำหนักกระเป๋าคุณเต็มแล้ว | 'warning' - นำหนักที่เหลือกระเป๋าของคุณไม่มากพอสำหรับของทั้งหมด
	-- source_item_exceed_limit			=>	'error' - คุณมีของสิ่งนี้จำนวนสูงสุดแล้ว | 'warning' - พื้นที่ในกระเป๋าของคุณไม่มากพอสำหรับของจำนวนที่คุณต้องการ
	-- source_weapon_exceed_weight		=>	'error' - นำหนักที่เหลือกระเป๋าของคุณไม่เพียงพอที่จะเก็บอาวุธชิ้นนี้ได้
	-- source_weapon_exceed_limit		=>	'error' - คุณมีอาวุธชนิดนี้อยู่แล้ว
	-- target_account_not_enough		=>	'error' - คนๆนี้ไม่มีเงินในกระเป๋า | 'warning' - คนๆนี้มีเงินไม่มากพอสำหรับเงินจำนวนที่คุณต้องการ
	-- target_account_exceed_weight		=>	'error' - น้ำหนักกระเป๋าของคนๆนี้เต็มแล้ว | 'warning' - นำหนักที่เหลือกระเป๋าของคนๆนี้ไม่มากพอสำหรับเงินทั้งหมด
	-- target_item_not_enough			=>	'error' - คนๆนี้ไม่มีของสิ่งนี้ | 'warning' - คนๆนี้มีของสิ่งนี้ไม่มากพอสำหรับในจำนวนที่คุณต้องการ
	-- target_item_exceed_weight		=>	'error' - น้ำหนักกระเป๋าของคนๆนี้เต็มแล้ว | 'warning' - นำหนักที่เหลือกระเป๋าของคนๆนี้ไม่มากพอสำหรับของทั้งหมด
	-- target_item_exceed_limit			=>	'error' - คนๆนี้มีของสิ่งนี้จำนวนสูงสุดแล้ว | 'warning' - พื้นที่ในกระเป๋าของคนๆนี้ไม่มากพอสำหรับของจำนวนที่คุณต้องการ
	-- target_weapon_exceed_weight		=>	'error' - นำหนักที่เหลือกระเป๋าของคนๆนี้ไม่เพียงพอที่จะเก็บอาวุธชิ้นนี้ได้
	-- target_weapon_exceed_limit		=>	'error' - คนๆนี้มีอาวุธชนิดนี้อยู่แล้ว
	-- target_block_giving				=>	'errir' - คนๆนี้ไม่ต้องการรับของจากผู้อื่น
	-- target_being_searched			=>	'error' - คนๆนี้กำลังถูกผู้อื่นค้นกระเป๋าอยู่
	-- target_not_found					=>	'error' - ไม่พบคนที่คุณต้องการจะค้นกระเป๋า

end