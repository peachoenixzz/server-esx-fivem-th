-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

---------------------------------------------------
--------------------- Database --------------------
---------------------------------------------------

-- Function นี้จะถูกเรียกเมื่อโหลดสินค้าจาก Database (ครั้งแรกที่โหลด Script เท่านั้น)
Config.DatabaseLoadAllStorages = function()
	local result = MySQL.query.await('SELECT `identifier`, `serviceId`, `items`, `weapons` FROM `nc_booth`')
	local data = {}
	for i = 1, #result do
		local identifier, serviceId, items, weapons in result[i]
		serviceId, items, weapons = tostring(serviceId), json.decode(items), json.decode(weapons)
		data[identifier] = data[identifier] or {}
		data[identifier][serviceId] = { items, weapons }
	end
	return data
	-- ค่าที่ส่งกลับไปจะอยู่ในรูปแบบของ Object ที่มี key => serviceId และ value => { items, weapons }
end

-- Function นี้จะถูกเรียกเมื่อบันทึกสินค้าเข้า Database
-- หาก items หรือ weapons ตัวไหนไม่มีการอัพเดทจะไม่ส่งค่ามา
Config.DatabaseSaveStorage = function(identifier, serviceId, items, weapons)
	if identifier and serviceId and (items or weapons) then
		MySQL.single('SELECT 1 FROM `nc_booth` WHERE `identifier` = ? AND `serviceId` = ?', { identifier, serviceId }, function(result)
			if result then
				if items and weapons then
					MySQL.prepare('UPDATE `nc_booth` SET `items` = ?, `weapons` = ? WHERE `identifier` = ? AND `serviceId` = ?', {
						json.encode(items),
						json.encode(weapons),
						identifier,
						serviceId
					})
				elseif items then
					MySQL.prepare('UPDATE `nc_booth` SET `items` = ? WHERE `identifier` = ? AND `serviceId` = ?', {
						json.encode(items),
						identifier,
						serviceId
					})
				elseif weapons then
					MySQL.prepare('UPDATE `nc_booth` SET `weapons` = ? WHERE `identifier` = ? AND `serviceId` = ?', {
						json.encode(weapons),
						identifier,
						serviceId
					})
				end
			elseif items and weapons then
				MySQL.prepare('INSERT INTO `nc_booth` (`identifier`, `serviceId`, `items`, `weapons`) VALUES (?, ?, ?, ?)', {
					identifier,
					serviceId,
					json.encode(items),
					json.encode(weapons)
				})
			end
		end)
	end
end

-- Function นี้จะถูกเรียกลบสินค้าออกจาก Database
Config.DatabaseRemoveStorage = function(identifier, serviceId)
	MySQL.prepare('DELETE FROM `nc_booth` WHERE `identifier` = ? AND `serviceId` = ?', { identifier, serviceId })
end