-- LOOK ID ON NC_VAULT
local Departments = {
	police = {vaultId = 5, receiverSplit = 0.99},
	ambulance = {vaultId = 1, receiverSplit = 0.99},
	admin = {vaultId = 3, receiverSplit = 0.0}
}

ESX.RegisterServerCallback('esx_billing:sendBill', function(source, cb, playerId, sharedAccountName, label, amount, department)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not xPlayer then
		cb(nil)
		return
	end

	local function insertBilling(targetIdentifier, targetType)
		local query = [[
            INSERT INTO billing (target, sender, label, amount, department)
            VALUES (@target, @sender, @label, @amount, @department)
        ]]

		MySQL.Async.execute(query, {
			['@target'] = targetIdentifier,
			['@sender'] = xPlayer.identifier,
			--['@target_type'] = targetType,
			['@label'] = label,
			['@amount'] = amount,
			['@department'] = department
		}, function(rowsChanged)
			onReceivedBill(playerId)
			onCreateBill(xPlayer.source)
			-- Log the billing event
			local xTarget = ESX.GetPlayerFromId(playerId)  -- Get player object for logging
			if xTarget then
				pcall(function()
					exports['azael_dc-serverlogs']:insertData({
						event = 'ReceivedBills',
						content = string.format('%s อาชีพ %s ได้รับบิล %s จำนวน $%s ของหน่วยงาน %s จาก %s อาชีพ %s',
								xTarget.name, xTarget.job.name, label, amount, department, xPlayer.name, xPlayer.job.name),
						source = xTarget.source,
					})
				end)
			end
		end)
	end

	-- Handle shared accounts or direct player billing
	if sharedAccountName and sharedAccountName ~= '' then
		TriggerEvent('esx_addonaccount:getSharedAccount', sharedAccountName, function(account)
			if account then
				insertBilling(sharedAccountName, 'society')
			else
				local xTarget = ESX.GetPlayerFromId(playerId)
				if xTarget then
					insertBilling(xTarget.identifier, 'player')
				end
			end
		end)
	else
		local xTarget = ESX.GetPlayerFromId(playerId)
		if xTarget then
			insertBilling(xTarget.identifier, 'player')
		end
	end
end)

ESX.RegisterServerCallback('esx_billing:getBills', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT id,target, sender, label, amount FROM billing WHERE target = @target', {
		['@target'] = xPlayer.identifier
	}, function(result)
		local bills = {}

		for i=1, #result, 1 do
			table.insert(bills, {
				id         = result[i].id,
				target 		= result[i].target,
				sender     = result[i].sender,
				label      = result[i].label,
				amount     = result[i].amount
			})
		end
		cb(bills)
	end)
end)

ESX.RegisterServerCallback('esx_billing:payBill', function(source, cb, id)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT target, sender, amount, department FROM billing WHERE id = @id', {['@id'] = id}, function(result)
		if #result == 0 then
			cb()
			return
		end

		local bill = result[1]
		local sender = bill.sender
		local target = bill.target
		local amount = bill.amount
		local department = bill.department
		local foundPlayer = ESX.GetPlayerFromIdentifier(sender)
		local departmentConfig = Departments[department]
		if xPlayer.getAccount('bank').money >= amount then
			xPlayer.removeAccountMoney('bank', amount)

			if foundPlayer then
				local playerGetMoney = amount * departmentConfig.receiverSplit
				foundPlayer.addAccountMoney('bank', playerGetMoney)
			end

			if foundPlayer == nil or not foundPlayer then
				MySQL.Async.execute('DELETE from billing WHERE id = @id', {
					['@id'] = id
				}, function(rowsChanged)
					xPlayer.removeAccountMoney('bank',  ESX.Math.Round(amount))
					pcall(function() -- Start log
						exports['azael_dc-serverlogs']:insertData({
							event = 'PayAdminBillsNoSender',
							content = ('%s อาชีพ %s ได้ทำการจ่ายบิลจำนวน $%s เหลือเงินในบัญชีจำนวน $%s'):format(xPlayer.name, xPlayer.job.name, ESX.Math.Round(amount), ESX.Math.GroupDigits(xPlayer.getAccount('bank').money)),
							source = xPlayer.source,
						})
					end) -- End log
					local playerGetMoney = amount * departmentConfig.receiverSplit

					MySQL.Async.fetchAll('SELECT accounts FROM users WHERE identifier = @identifier', { ["@identifier"] = target }, function(res)
						if res[1] ~= nil then
							local accs = json.decode(res[1].accounts)

							accs.bank = ESX.Math.Round(accs.bank + playerGetMoney)

							MySQL.Async.execute("UPDATE users SET accounts = @newBank WHERE identifier = @identifier",
									{
										["@identifier"] = target,
										["@newBank"] = json.encode(accs)
									}
							)
						end
					end)
				end)
			end

			local departmentGetMoney = amount * (1 - departmentConfig.receiverSplit)
			local vault = exports.nc_vault:GetVault(departmentConfig.vaultId)
			local addedAmount = vault.addAccount("money", ESX.Math.Round(departmentGetMoney))
			vault.saveStorage(addedAmount)

			MySQL.Async.execute('DELETE from billing WHERE id = @id', {['@id'] = id})
			logBillingAction(xPlayer, amount, department, "payBillSuccess")  -- Assuming a function for logging
			cb()
			return
		else
			onPayBillNoMoney(source)
			cb()
			return
		end
	end)
end)

-- Function to log the billing actions
function logBillingAction(xPlayer, amount, department, actionType)
	-- Example log message construction
	local logMessage = string.format(
			"%s (%s) paid a bill of $%s in department %s. Action: %s",
			xPlayer.getName(),
			xPlayer.identifier,
			amount,
			department,
			actionType
	)

	-- Inserting the log data using a fictional logging system 'azael_dc-serverlogs'
	exports['azael_dc-serverlogs']:insertData({
		event = actionType,
		content = logMessage,
		source = xPlayer.source,
	})
end

Citizen.CreateThread(function ()
	--Citizen.Wait(180000) --180000
	while true do
		Citizen.Wait(180000)
		-- after underline is auto billing
		MySQL.query('SELECT id FROM billing ', {}, function(result)
			if result then
				for i = 1, #result do
					local idBilling = result[i].id
					local billDetail = MySQL.single.await('SELECT target, sender, amount,department FROM billing WHERE id = ?', {idBilling})
					if billDetail then
						local sender      = billDetail.sender
						local target      = billDetail.target
						local amount      = billDetail.amount
						local department = 	billDetail.department
						local foundSender = ESX.GetPlayerFromIdentifier(sender)
						local foundTarget = ESX.GetPlayerFromIdentifier(target)
						local departmentConfig = Departments[department]

						if foundSender ~= nil  and foundTarget ~= nil then
							MySQL.Async.execute('DELETE from billing WHERE id = @id', {
								['@id'] = idBilling
							}, function(rowsChanged)
								local playerGetMoney = amount * departmentConfig.receiverSplit
								foundTarget.removeAccountMoney('bank', ESX.Math.Round(amount))
								pcall(function() -- Start log
									exports['azael_dc-serverlogs']:insertData({
										event = 'PayPoliceBillsAuto',
										content = ('%s อาชีพ %s ได้ทำการจ่ายบิลจำนวน $%s เหลือเงินในบัญชีจำนวน $%s'):format(foundTarget.name, foundTarget.job.name, ESX.Math.Round(amount), ESX.Math.GroupDigits(foundTarget.getAccount('bank').money)),
										source = foundTarget.source,
									})
								end) -- End log
								pcall(function() -- Start log
									exports['azael_dc-serverlogs']:insertData({
										event = 'PoliceReceivedFineMoneyAuto',
										content = ('%s อาชีพ %s ได้รับเงินเข้าบัญชีจำนวน $%s เหลือเงินในบัญชีจำนวน $%s : พิกัด %s'):format(foundSender.name, foundSender.job.name, ESX.Math.Round(playerGetMoney), ESX.Math.GroupDigits(foundSender.getAccount('bank').money)),
										source = foundSender.source,
									})
								end) -- End log
								foundSender.addAccountMoney('bank',  ESX.Math.Round(playerGetMoney))
								local departmentGetMoney = amount * (1 - departmentConfig.receiverSplit)
								local vault = exports.nc_vault:GetVault(departmentConfig.vaultId)
								local addedAmount = vault.addAccount("money", ESX.Math.Round(departmentGetMoney))
								vault.saveStorage(addedAmount)
							end)
						end

						if foundSender == nil and foundTarget ~= nil then
							MySQL.Async.execute('DELETE from billing WHERE id = @id', {
								['@id'] = idBilling
							}, function(rowsChanged)
								foundTarget.removeAccountMoney('bank',  ESX.Math.Round(amount))
								pcall(function() -- Start log
									exports['azael_dc-serverlogs']:insertData({
										event = 'PayPoliceBillsAutoNoSender',
										content = ('%s อาชีพ %s ได้ทำการจ่ายบิลจำนวน $%s เหลือเงินในบัญชีจำนวน $%s'):format(foundTarget.name, foundTarget.job.name, idBilling, ESX.Math.Round(amount), ESX.Math.GroupDigits(foundTarget.getAccount('bank').money)),
										source = foundTarget.source,
									})
								end) -- End log
								local playerGetMoney = amount * departmentConfig.receiverSplit

								MySQL.Async.fetchAll('SELECT accounts FROM users WHERE identifier = @identifier', { ["@identifier"] = sender }, function(res)
									if res[1] ~= nil then
										local accs = json.decode(res[1].accounts)

										accs.bank = ESX.Math.Round(accs.bank + playerGetMoney)

										MySQL.Async.execute("UPDATE users SET accounts = @newBank WHERE identifier = @identifier",
												{
													["@identifier"] = sender,
													["@newBank"] = json.encode(accs)
												}
										)
									end
								end)

								local departmentGetMoney = amount * (1 - departmentConfig.receiverSplit)
								local vault = exports.nc_vault:GetVault(departmentConfig.vaultId)
								local addedAmount = vault.addAccount("money", ESX.Math.Round(departmentGetMoney))
								vault.saveStorage(addedAmount)

							end)
						end

						if foundSender == nil and foundTarget == nil then
							MySQL.Async.execute('DELETE from billing WHERE id = @id', {
								['@id'] = idBilling
							}, function(rowsChanged)
								local playerGetMoney = amount * departmentConfig.receiverSplit

								MySQL.Async.fetchAll('SELECT accounts FROM users WHERE identifier = @identifier', { ["@identifier"] = target }, function(res)
									if res[1] ~= nil then
										local accs = json.decode(res[1].accounts)

										accs.bank = ESX.Math.Round(accs.bank - amount)

										MySQL.Async.execute("UPDATE users SET accounts = @newBank WHERE identifier = @identifier",
												{
													["@identifier"] = target,
													["@newBank"] = json.encode(accs)
												}
										)
									end
								end)

								MySQL.Async.fetchAll('SELECT accounts FROM users WHERE identifier = @identifier', { ["@identifier"] = sender }, function(res)
									if res[1] ~= nil then
										local accs = json.decode(res[1].accounts)

										accs.bank = ESX.Math.Round(accs.bank + playerGetMoney)

										MySQL.Async.execute("UPDATE users SET accounts = @newBank WHERE identifier = @identifier",
												{
													["@identifier"] = sender,
													["@newBank"] = json.encode(accs)
												}
										)
									end
								end)

								local departmentGetMoney = amount * (1 - departmentConfig.receiverSplit)
								local vault = exports.nc_vault:GetVault(departmentConfig.vaultId)
								local addedAmount = vault.addAccount("money", ESX.Math.Round(departmentGetMoney))
								vault.saveStorage(addedAmount)


							end)
						end

						if foundSender ~= nil and foundTarget == nil then
							MySQL.Async.execute('DELETE from billing WHERE id = @id', {
								['@id'] = idBilling
							}, function(rowsChanged)
								local playerGetMoney = amount * departmentConfig.receiverSplit

								foundSender.addAccountMoney('bank',  ESX.Math.Round(playerGetMoney))
								pcall(function() -- Start log
									exports['azael_dc-serverlogs']:insertData({
										event = 'PoliceReceivedFineMoneyAutoNoTarget',
										content = ('%s อาชีพ %s ได้รับเงินเข้าบัญชีจำนวน $%s เหลือเงินในบัญชีจำนวน $%s'):format(foundSender.name, foundSender.job.name, ESX.Math.Round(playerGetMoney), ESX.Math.GroupDigits(foundSender.getAccount('bank').money)),
										source = foundSender.source,
									})
								end) -- End log
								MySQL.Async.fetchAll('SELECT accounts FROM users WHERE identifier = @identifier', { ["@identifier"] = target }, function(res)
									if res[1] ~= nil then
										local accs = json.decode(res[1].accounts)

										accs.bank = ESX.Math.Round(accs.bank - amount)

										MySQL.Async.execute("UPDATE users SET accounts = @newBank WHERE identifier = @identifier",
												{
													["@identifier"] = target,
													["@newBank"] = json.encode(accs)
												}
										)
									end
								end)

								local departmentGetMoney = amount * (1 - departmentConfig.receiverSplit)
								local vault = exports.nc_vault:GetVault(departmentConfig.vaultId)
								local addedAmount = vault.addAccount("money", ESX.Math.Round(departmentGetMoney))
								vault.saveStorage(addedAmount)
							end)
						end

					end
				end
			end
		end)
	end
end)

function onCreateBill(playerId)
	exports.nc_notify:PushNotification(playerId,{
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบบิล', -- หัวเรื่อง
		description = 'คุณสร้างบิลสำเร็จ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'bill', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end


function onReceivedBill(playerId)
    exports.nc_notify:PushNotification(playerId,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบบิล', -- หัวเรื่อง
        description = 'คุณได้รับบิลแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'bill', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function onPayBillNoMoney(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบบิล', -- หัวเรื่อง
        description = 'คุณมีเงินไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end