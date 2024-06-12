ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	if Config.TimeGiveItem ~= false then		
		SetTimeout(Config.TimeGiveItem * 60000, TimeGiveItems)
	end
	if Config.TimeGiveMoney ~= false then
		SetTimeout(Config.TimeGiveMoney * 60000, TimeGiveMoney)
	end
	if Config.TimeGiveWeapon ~= false then
		SetTimeout(Config.TimeGiveWeapon * 60000, TimeGiveWeapon)
	end	
end)

function TimeGiveItems()
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])			
		for i=1, #Config.Items, 1 do
			xPlayer.addInventoryItem(Config.Items[i].name, Config.Items[i].count)	
			TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('item_msg', Config.Items[i].count, ESX.GetItemLabel(Config.Items[i].name)), 'CHAR_MP_MORS_MUTUAL', 9)
		end						
	end
	SetTimeout(Config.TimeGiveItem * 60000, TimeGiveItems)
end

function TimeGiveMoney()
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])			
		for i=1, #Config.Money, 1 do
			if Config.Money[i].account == 'money' then
				xPlayer.addMoney(Config.Money[i].amount)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('money_msg', Config.Money[i].amount), 'CHAR_MP_MORS_MUTUAL', 9)
			elseif Config.Money[i].account == 'bank' then
				xPlayer.addAccountMoney(Config.Money[i].account, Config.Money[i].amount)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('bank_msg', Config.Money[i].amount), 'CHAR_MP_MORS_MUTUAL', 9)				
			elseif Config.Money[i].account == 'black_money' then
				xPlayer.addAccountMoney(Config.Money[i].account, Config.Money[i].amount)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('black_msg', Config.Money[i].amount), 'CHAR_MP_MORS_MUTUAL', 9)						
			end
		end						
	end
	SetTimeout(Config.TimeGiveMoney * 60000, TimeGiveMoney)	
end

RegisterCommand('giveallitem', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'superadmin' then
		local xPlayers = ESX.GetPlayers()
		local item    = args[1]
		local count   = (args[2] == nil and 1 or tonumber(args[2]))
		
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if ESX.GetItemLabel(item) ~= nil then
				xPlayer.addInventoryItem(item, count)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('item_msg', count, ESX.GetItemLabel(item)), 'CHAR_MP_MORS_MUTUAL', 9)
				print('You give all players ' ..count.. 'x ' ..item)

				local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. ESX.GetItemLabel(item) .. ' จำนวน ' .. count .. ' (แอดมินใช้คำสั่งผ่าน Server Console)'
				TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'GiveAllItem', sendToDiscord, xPlayer.source, '^2')
			else
				print(_U('unknown_item'))
			end	
		end		
	end
end)

RegisterCommand('giveallmoney', function(source, args)
	if Config.EnableServerCommand then
		if source == 0 then
			local xPlayers = ESX.GetPlayers()
			local account = args[1]
			local amount  = tonumber(args[2])

			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

				if amount ~= nil then
					if account == "money" then
						xPlayer.addMoney(amount)
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('money_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
						print('You give all players $' ..amount.. ' money')
					elseif account == 'bank' then
						xPlayer.addAccountMoney(account, amount)
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('bank_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
						print('You give all players $' ..amount.. ' into bank')
					elseif account == 'black_money' then
						xPlayer.addAccountMoney(account, amount)
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('black_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
						print('You give all players $' ..amount.. ' black money')
					else
						print(_U('unknown_account', 'money、bank、black_money'))
					end
				else
					print(_U('unknown_amount'))
				end
			end	
		end
	end
end)

RegisterCommand('_giveallitem', function(source, args)
	if Config.EnableServerCommand then
		if source == 0 then
			local xPlayers = ESX.GetPlayers()
			local item    = args[1]
			local count   = (args[2] == nil and 1 or tonumber(args[2]))
			
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

				if ESX.GetItemLabel(item) ~= nil then
					xPlayer.addInventoryItem(item, count)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('item_msg', count, ESX.GetItemLabel(item)), 'CHAR_MP_MORS_MUTUAL', 9)
					print('You give all players ' ..count.. 'x ' ..item)
				else
					print(_U('unknown_item'))
				end	
			end		
		end
	end
end)


RegisterCommand('_addallmoney', function(source, args)
	if Config.EnableServerCommand then
		if source == 0 then
			local xPlayers = ESX.GetPlayers()
			local account = args[1]
			local amount  = tonumber(args[2])

			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

				if amount ~= nil then
					if account == "money" then
						xPlayer.addMoney(amount)
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('money_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
						print('You give all players $' ..amount.. ' money')
					elseif account == 'bank' then
						xPlayer.addAccountMoney(account, amount)
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('bank_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
						print('You give all players $' ..amount.. ' into bank')
					elseif account == 'black_money' then
						xPlayer.addAccountMoney(account, amount)
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('black_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
						print('You give all players $' ..amount.. ' black money')
					else
						print(_U('unknown_account', 'money、bank、black_money'))
					end
				else
					print(_U('unknown_amount'))
				end
			end	
		end
	end
end)
