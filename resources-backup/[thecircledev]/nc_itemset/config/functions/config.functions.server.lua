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

-- Function นี้จะถูกเรียกใช้งานเมื่อมีการสุ่มสิ่งของ (ต่อครั้ง)
-- [ triggeredItem: Key ของ Itemset | xPlayer: xPlayer ของผู้เล่น | item: สิ่งของที่ได้รับ ]
Config.ServerWillGiveRandomItem = function(triggeredItem, xPlayer, item)
	-- ตัวอย่างการส่งค่าของ itemList [Object]
	-- item =	{
	-- 				type	= ชนิดของสิ่งของ [string],			-- [account|item|weapon|vehicle]
	-- 				name	= ชื่อของสิ่งของ [string],
	-- 				count	= จำนวน [number]
	-- 			}
	return true, true			-- return true, true เพื่ออนุญาตลบของที่ใช้และมอบของที่จะได้รับ willDeductTriggeredItem, willGiveResult * ค่าที่ return กลับไปจะมี 2 ตัวเสมอ (true: อนุญาต | false|nil: ไม่อนุญาต)
end

-- Function นี้จะถูกเรียกใช้งานเมื่อได้รับสิ่งของ
-- [ triggeredItem: Key ของ Itemset | xPlayer: xPlayer ของผู้เล่น | itemList: รายชื่อสิ่งของที่ได้รับ ]
Config.ServerReceivedItems = function(triggeredItem, xPlayer, itemList)
	-- ตัวอย่างการส่งค่าของ itemList [Array]
	-- itemList =	{
	-- 					{
	-- 						type	= ชนิดของสิ่งของ [string],			-- [account|item|weapon|vehicle]
	-- 						name	= ชื่อของสิ่งของ [string],
	-- 						count	= จำนวน [number],
	--						plate	= ทะเบียนของยานพาหนะ [string],
	-- 					},
	--					...
	--
	for _, item in ipairs(itemList) do
		if triggeredItem == 'box_rcar' and item.type == 'vehicle' then
			MySQL.rawExecute.await('UPDATE `owned_vehicles` SET `expire_date` = SYSDATE() + INTERVAL 7 DAY, `vehiclename` = ? WHERE `owner` = ? AND `plate` = ?', {"box_rcar" ,xPlayer.identifier, item.plate})
		end
		if triggeredItem == 'rental_3d' and item.type == 'vehicle' then
			MySQL.rawExecute.await('UPDATE `owned_vehicles` SET `expire_date` = SYSDATE() + INTERVAL 3 DAY, `vehiclename` = ? WHERE `owner` = ? AND `plate` = ?', {"rental_3d" ,xPlayer.identifier, item.plate})
		end
		if triggeredItem == 'rental_7d' and item.type == 'vehicle' then
			MySQL.rawExecute.await('UPDATE `owned_vehicles` SET `expire_date` = SYSDATE() + INTERVAL 7 DAY, `vehiclename` = ? WHERE `owner` = ? AND `plate` = ?', {"rental_7d" ,xPlayer.identifier, item.plate})
		end
		if triggeredItem == 'rental_15d' and item.type == 'vehicle' then
			MySQL.rawExecute.await('UPDATE `owned_vehicles` SET `expire_date` = SYSDATE() + INTERVAL 15 DAY, `vehiclename` = ? WHERE `owner` = ? AND `plate` = ?', {"rental_15d" ,xPlayer.identifier, item.plate})
		end
		if triggeredItem == 'starter_kit' and item.name == 'card_nplayer' then
			local stmtNewCardPlayer = [[
            		INSERT IGNORE
		            INTO items_expire (item_name,player_id,category,expire_timestamp)
		            VALUES (?, ?, ?, SYSDATE() + INTERVAL 7 DAY)
            ]]
			MySQL.rawExecute.await(stmtNewCardPlayer, {
				"card_nplayer",
				xPlayer.identifier,
				"economy",
			})
		end
	end
end