local playersHealing, deadPlayers,playersReviver = {}, {}, {}
local blockItem = {
	"card_reskin",
	"card_lastname",
	"auto_1h",
	"gum_mining",
	"gum_eco",
	"card_vip",
	"card_vault",
	"exp_vault",
	"cron",
	"heart_100",
	"rental_3d",
	"rental_7d",
	"rental_15d",
	"gacha_5",
	"gacha_5_1",
	"gacha_5_2",
	"gacha_5_3",
	"gacha_5_4",
	"ad_blessing",
	"ad_bell",
	"ad_clipper",
	"ad_spray",
	"vault_master",
	"ad_bag",
	"busker",
	"starter_kit",
	"box_rcar",
	"gacha_support",
	"gacha_event",
	"fashion_0",
	"baby1",
	"baby2",
	"baby3",
	"baby4",
	"baby5",
	"baby6",
	"baby7",
	"baby8",
	"spacpup",
	"spacpupb",
	"spacpupc",
	"spacpupd",
	"spacpupe",
	"spacpupf",
	"summersocute1",
	"summersocute2",
	"summersocute3",
	"summersocute4",
	"summersocute5",
	"summersocute6",
	"vault_md",
	"vault_pd",
	"card_gang",
	"card_family",
	"megaphone",
	"coin_killer",
	"exp_gang",
	"t1_box_knuckle",
	"t1_box_machete",
	"t1_box_bottle",
	"t1_box_poolcue",
	"t1_player",
	"player_mask",
	"card_id",
	"card_nplayer",
	"vehicle_key",
	"vault_key",
	"exp",
	"key_gang",
	"booster1",
	"booster2",
	"booster3",
	"card_wvault",
	"box_exp",
}


local weapons = {
	["WEAPON_BAT_1H"] = "pt_all",
	["WEAPON_BAT_1H_2"] = "pt_all",
	["WEAPON_BAT"] = "pt_all",
	["WEAPON_GOLFCLUB_1H"] = "pt_all",
	["WEAPON_GOLFCLUB_1H_2"] = "pt_all",
	["WEAPON_GOLFCLUB"] = "pt_all",
	["WEAPON_KNUCKLE"] = "pt_all",
	["WEAPON_KNUCKLE_2"] = "pt_all",
	["WEAPON_KNUCKLE_3"] = "pt_all",
	["WEAPON_KNUCKLE_4"] = "pt_all",
	["WEAPON_KNUCKLE_5"] = "pt_all",
	["WEAPON_MACHETE"] = "pt_all",
	["WEAPON_MACHETE_2"] = "pt_all",
	["WEAPON_MACHETE_3"] = "pt_all",
	["WEAPON_BOTTLE"] = "pt_all",
	["WEAPON_BOTTLE_2"] = "pt_all",
	["WEAPON_BOTTLE_3"] = "pt_all",
	["WEAPON_KNIFE"] = "pt_all",
	["WEAPON_KNIFE_2"] = "pt_all",
	["WEAPON_KNIFE_3"] = "pt_all",
	["WEAPON_DAGGER"] = "pt_all",
	["WEAPON_DAGGER_2"] = "pt_all",
	["WEAPON_DAGGER_3"] = "pt_all",
	["WEAPON_POOLCUE"] = "pt_all",
	["WEAPON_POOLCUE_2"] = "pt_all",
	["WEAPON_POOLCUE_3"] = "pt_all",
	["WEAPON_REVOLVER"] = "pt_all",
	["WEAPON_REVOLVER_MK2"] = "pt_all",
	["WEAPON_REVOLVER_MK3"] = "pt_all",
}

local downgradeWeapon = {
	["WEAPON_BAT_1H_2"] = "WEAPON_BAT_1H",
	["WEAPON_BAT"] = "WEAPON_BAT_1H_2",
	["WEAPON_GOLFCLUB_1H_2"] = "WEAPON_GOLFCLUB_1H",
	["WEAPON_GOLFCLUB"] = "WEAPON_GOLFCLUB_1H_2",
	["WEAPON_KNUCKLE_2"] = "WEAPON_KNUCKLE",
	["WEAPON_KNUCKLE_3"] = "WEAPON_KNUCKLE_2",
	["WEAPON_KNUCKLE_4"] = "WEAPON_KNUCKLE_3",
	["WEAPON_KNUCKLE_5"] = "WEAPON_KNUCKLE_4",
	["WEAPON_MACHETE_2"] = "WEAPON_MACHETE",
	["WEAPON_MACHETE_3"] = "WEAPON_MACHETE_2",
	["WEAPON_BOTTLE_2"] = "WEAPON_BOTTLE",
	["WEAPON_BOTTLE_3"] = "WEAPON_BOTTLE_2",
	["WEAPON_KNIFE"] = "WEAPON_BOTTLE_3",
	["WEAPON_KNIFE_2"] = "WEAPON_KNIFE",
	["WEAPON_KNIFE_3"] = "WEAPON_KNIFE_2",
	["WEAPON_DAGGER"] = "WEAPON_BOTTLE_3",
	["WEAPON_DAGGER_2"] = "WEAPON_DAGGER",
	["WEAPON_DAGGER_3"] = "WEAPON_DAGGER_2",
	["WEAPON_POOLCUE"] = "WEAPON_BAT",
	["WEAPON_POOLCUE_2"] = "WEAPON_POOLCUE",
	["WEAPON_POOLCUE_3"] = "WEAPON_POOLCUE_2",
	["WEAPON_REVOLVER"] = {
		"gun_pin",
		"gun_spring",
		"gun_barrel",
	},
	["WEAPON_REVOLVER_MK2"] = "WEAPON_REVOLVER",
	["WEAPON_REVOLVER_MK3"] = "WEAPON_REVOLVER_MK2",
	["T1_WEAPON_KNUCKLE"] = "T1_WEAPON_KNUCKLE",
	["T1_WEAPON_MACHETE"] = "T1_WEAPON_MACHETE",
	["T1_WEAPON_BOTTLE"] = "T1_WEAPON_BOTTLE",
	["T1_WEAPON_POOLCUE"] = "T1_WEAPON_POOLCUE",
}

if GetResourceState("esx_phone") ~= 'missing' then
	TriggerEvent('esx_phone:registerNumber', 'police', TranslateCap('alert_ambulance'), true, true)
end

if GetResourceState("esx_society") ~= 'missing' then
	TriggerEvent('esx_society:registerSociety', 'police', 'SOS แพทย์สนาม', 'society_ambulance', 'society_ambulance',
		'society_ambulance', { type = 'public' })
end

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(playerId,itemName)
	playerId = tonumber(playerId)
	local xPlayer = source and ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)
	if xItem.count <= 0 then return end
	if xPlayer and xPlayer.job.name == 'police' then
		local xTarget = ESX.GetPlayerFromId(playerId)
		if xTarget then
			if deadPlayers[playerId] then
				if Config.ReviveReward > 0 then
					xPlayer.addMoney(Config.ReviveReward, "Revive Reward")
					xTarget.triggerEvent('esx_ambulancejob:revive')
					pcall(function() -- Start Log
						exports['azael_dc-serverlogs']:insertData({
							event = 'AmbulanceRevive',
							content = ('%s อาชีพ %s ยศ %s ได้ทำการชุบชีวิต %s ขึ้นมา '):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, xTarget.name),
							source = xPlayer.source,
						})
					end) -- End Log
				else
					xTarget.triggerEvent('esx_ambulancejob:revive')
					pcall(function() -- Start Log
						exports['azael_dc-serverlogs']:insertData({
							event = 'AmbulanceRevive',
							content = ('%s อาชีพ %s ยศ %s ได้ทำการชุบชีวิต %s ขึ้นมา '):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name),
							source = xPlayer.source,
						})
					end) -- End Log
				end
				local Ambulance = ESX.GetExtendedPlayers("job", "police")

				--for _, xPlayer in pairs(Ambulance) do
				--	if xPlayer.job.name == 'police' then
				--		xPlayer.triggerEvent('esx_ambulancejob:PlayerNotDead', playerId)
				--	end
				--end
				deadPlayers[playerId] = nil
				--collectgarbage("collect")
			else
				--xPlayer.showNotification(TranslateCap('player_not_unconscious'))
			end
		else
			--xPlayer.showNotification(TranslateCap('revive_fail_offline'))
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:citizenRevive')
AddEventHandler('esx_ambulancejob:citizenRevive', function(playerId,itemName)
	playerId = tonumber(playerId)
	print(itemName)
	local xPlayer = source and ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)
	if xItem.count <= 0 then return end

	if xPlayer and itemName == 'aed' or itemName == 'gov_aed' or itemName == 'r_aed'  then
		local xTarget = ESX.GetPlayerFromId(playerId)
		if xTarget then
			if deadPlayers[playerId] then
					xTarget.triggerEvent('esx_ambulancejob:citizenRevive')
					pcall(function() -- Start Log
						exports['azael_dc-serverlogs']:insertData({
							event = 'AmbulanceCitizenRevive',
							content = ('%s อาชีพ %s ได้ทำการชุบชีวิต %s ขึ้นมา'):format(xPlayer.name, xPlayer.job.name, xTarget.name),
							source = xPlayer.source,
						})
					end) -- End Log
				--local Ambulance = ESX.GetExtendedPlayers("job", "police")
				--for _, xPlayer in pairs(Ambulance) do
				--	if xPlayer.job.name == 'police' then
				--		xPlayer.triggerEvent('esx_ambulancejob:PlayerNotDead', playerId)
				--	end
				--end
				deadPlayers[playerId] = nil
				--collectgarbage("collect")
			else
				--xPlayer.showNotification(TranslateCap('player_not_unconscious'))
			end
		else
			--xPlayer.showNotification(TranslateCap('revive_fail_offline'))
		end
	end
end)

AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
	if GetInvokingResource() ~= "monitor" or type(eventData) ~= "table" or type(eventData.id) ~= "number" then
		return
	end
	if deadPlayers[eventData.id] then
		TriggerClientEvent('esx_ambulancejob:revive', eventData.id)
		--local Ambulance = ESX.GetExtendedPlayers("job", "police")
		--for _, xPlayer in pairs(Ambulance) do
		--	if xPlayer.job.name == 'police' then
		--		xPlayer.triggerEvent('esx_ambulancejob:PlayerNotDead', eventData.id)
		--	end
		--end
		deadPlayers[eventData.id] = nil
		--collectgarbage("collect")
	end
end)

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	local source = source
	deadPlayers[source] = 'dead'
	--local Ambulance = ESX.GetExtendedPlayers("job", "police")
	--
	--for _, xPlayer in pairs(Ambulance) do
	--	xPlayer.triggerEvent('esx_ambulancejob:PlayerDead', source)
	--end
end)


RegisterServerEvent('esx_ambulancejob:svsearch')
AddEventHandler('esx_ambulancejob:svsearch', function()
	TriggerClientEvent('esx_ambulancejob:clsearch', -1, source)
end)

RegisterNetEvent('esx_ambulancejob:onPlayerDistress')
AddEventHandler('esx_ambulancejob:onPlayerDistress', function()
	--local source = source
	--local injuredPed = GetPlayerPed(source)
	--local injuredCoords = GetEntityCoords(injuredPed)
	--
	--if deadPlayers[source] then
	--	deadPlayers[source] = 'distress'
	--	local Ambulance = ESX.GetExtendedPlayers("job", "police")
	--	for _, xPlayer in pairs(Ambulance) do
	--		xPlayer.triggerEvent('esx_ambulancejob:PlayerDistressed', source, injuredCoords)
	--		pcall(function() -- Start Log
	--			exports['azael_dc-serverlogs']:insertData({
	--				event = 'AmbulanceDistressCall',
	--				content = ('%s อาชีพ %s ยศ %s ได้รับการแจ้งเคสของหมอ พิกัดของผู้บาดเจ็บ %s '):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, injuredCoords),
	--				source = xPlayer.source,
	--			})
	--		end) -- End Log
	--	end
	--end
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	local source = source
	if deadPlayers[source] then
		deadPlayers[source] = nil
		--local Ambulance = ESX.GetExtendedPlayers("job", "police")
		--for _, xPlayer in pairs(Ambulance) do
		--	xPlayer.triggerEvent('esx_ambulancejob:PlayerNotDead', source)
		--end
		--collectgarbage("collect")
	end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
		--local Ambulance = ESX.GetExtendedPlayers("job", "police")
		--for _, xPlayer in pairs(Ambulance) do
		--	if xPlayer.job.name == 'police' then
		--		xPlayer.triggerEvent('esx_ambulancejob:PlayerNotDead', playerId)
		--	end
		--end
		--collectgarbage("collect")
	end
end)

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_ambulancejob:heal', target, type)
	end
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb, alreadyBodyBag)
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.OxInventory and Config.RemoveItemsAfterRPDeath then
		exports.ox_inventory:ClearInventory(xPlayer.source)
		return cb()
	end

	local playerLoadout = {}
	if alreadyBodyBag then
		exports.cc_coreeffect:createDebuff(xPlayer,'dead_by_shroud',1800000,'dead_by_shroud','show')
		local template =
		[[
			<div style="padding: 7px; margin-bottom: 8px; background-image: linear-gradient(to right, rgba(255, 0, 0, 0.7), rgba(255, 93, 93, 0.5)); border-radius: 7px; width: 605px; display: flex; align-items: center; font-size: 18px;"/>
			<img src="https://img2.pic.in.th/pic/human-skull.png" style="width: 20px; height: 20px; padding-right: 7px; padding-left: 7px;" />{0}: {1}
			<br></div>
		]]
		local msg = xPlayer.getName() .. " เสียชีวิตโดยการห่อศพ"
		local fal = ' สัปเหร่อ'
		TriggerClientEvent('chat:addMessage', -1, {
			template = template,
			args = { fal, msg }
		})
		for _,v in pairs(xPlayer.getLoadout()) do
			local weaponName = v.name
			local isMatching = false

			local quantity = xPlayer.getInventoryItem("pt_all").count
			if quantity > 0 then
				pcall(function() -- Start Log
					exports['azael_dc-serverlogs']:insertData({
						event = 'RemoveWeaponFromDeathInBodyBag',
						content = ('%s ใช้ Protect All จำนวน : %s'):format(xPlayer.name,quantity),
						source = xPlayer.source,
					})
				end) -- End Log
				xPlayer.removeInventoryItem("pt_all",quantity)
				break
			end

			for code, name in pairs(weapons) do
				if code == weaponName and name ~= 'pt_all' then
					if quantity > 0 then
						xPlayer.removeInventoryItem(name,quantity)
						pcall(function() -- Start Log
							exports['azael_dc-serverlogs']:insertData({
								event = 'RemoveWeaponFromDeathInBodyBag',
								content = ('%s ได้สูญเสีย %s จำนวน %s ชิ้น จากการโดนอุ้มเอ๋อ'):format(xPlayer.name, name, quantity),
								source = xPlayer.source,
							})
						end) -- End Log
						isMatching = true
						break
					end
				end
			end

			if not isMatching then
				for defaultName,downgradeName in pairs(downgradeWeapon) do
					if quantity > 0 then
						break
					end
					if defaultName == weaponName then
						xPlayer.removeWeapon(weaponName)
						pcall(function() -- Start Log
							exports['azael_dc-serverlogs']:insertData({
								event = 'LoseWeaponFromDeathInBodyBag',
								content = ('%s ได้สูญเสีย %s จากการโดนอุ้มเอ๋อ'):format(xPlayer.name, weaponName),
								source = xPlayer.source,
							})
						end) -- End Log
						if defaultName == "WEAPON_REVOLVER" then
							xPlayer.addInventoryItem("gun_pin", 1)
							xPlayer.addInventoryItem("gun_spring", 1)
							xPlayer.addInventoryItem("gun_barrel", 1)
							pcall(function() -- Start Log
								exports['azael_dc-serverlogs']:insertData({
									event = 'ReceivedDownGradeWeapon',
									content = ('%s ได้รับ %s จำนวน 1 ชิ้น'):format(xPlayer.name, "gun_pin"),
									source = xPlayer.source,
								})
							end) -- End Log
							pcall(function() -- Start Log
								exports['azael_dc-serverlogs']:insertData({
									event = 'ReceivedDownGradeWeapon',
									content = ('%s ได้รับ %s จำนวน 1 ชิ้น'):format(xPlayer.name, "gun_spring"),
									source = xPlayer.source,
								})
							end) -- End Log
							pcall(function() -- Start Log
								exports['azael_dc-serverlogs']:insertData({
									event = 'ReceivedDownGradeWeapon',
									content = ('%s ได้รับ %s จำนวน 1 ชิ้น'):format(xPlayer.name, "gun_barrel"),
									source = xPlayer.source,
								})
							end) -- End Log
							goto continue
						end
						xPlayer.addWeapon(downgradeName, 1)
						pcall(function() -- Start Log
							exports['azael_dc-serverlogs']:insertData({
								event = 'ReceivedDownGradeWeapon',
								content = ('%s ได้รับ %s จำนวน 1 ชิ้น'):format(xPlayer.name, downgradeName),
								source = xPlayer.source,
							})
						end) -- End Log
					end
					 ::continue::
					if defaultName ~= weaponName then
						xPlayer.removeWeapon(weaponName)
						pcall(function() -- Start Log
							exports['azael_dc-serverlogs']:insertData({
								event = 'LoseWeaponFromDeathInBodyBag',
								content = ('%s ได้สูญเสีย %s จากการโดนอุ้มเอ๋อ'):format(xPlayer.name, weaponName),
								source = xPlayer.source,
							})
						end) -- End Log
					end
				end
			end
		end

	else -- save weapons & restore em' since spawnmanager removes them
		for i = 1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		CreateThread(function()
			Wait(5000)
			for i = 1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	if alreadyBodyBag then -- Config.RemoveCashAfterRPDeath is old config but we need to use alreadyBodyBag
		if xPlayer.getMoney() > 0 then
			local oldmoney = xPlayer.getMoney()
			xPlayer.removeMoney(xPlayer.getMoney(), "Death")
			pcall(function() -- Start Log
				exports['azael_dc-serverlogs']:insertData({
					event = 'LoseMoneyFromDeathInBodyBag',
					content = ('%s ได้สูญเสียเงินในกระเป๋าจำนวน $%s จากการโดนอุ้มเอ๋อ'):format(xPlayer.name, oldmoney),
					source = xPlayer.source,
				})
			end) -- End Log
		end

		if xPlayer.getAccount('black_money').money > 0 then
			local oldblackmoney =  xPlayer.getAccount("black_money").money
			xPlayer.setAccountMoney('black_money', 0, "Death")
			pcall(function() -- Start Log
				exports['azael_dc-serverlogs']:insertData({
					event = 'LoseBlackMoneyFromDeathInBodyBag',
					content = ('%s ได้สูญเสียเงินผิดกฏหมายในกระเป๋าจำนวน $%s จากการโดนอุ้มเอ๋อ'):format(xPlayer.name, oldblackmoney),
					source = xPlayer.source,
				})
			end) -- End Log
		end
	end

	if alreadyBodyBag then
		for i = 1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				local foundInBlockItem = false

				for _, v in ipairs(blockItem) do
					if v == xPlayer.inventory[i].name then
						foundInBlockItem = true
						break
					end
				end

				if not foundInBlockItem then
					local olditemcount = xPlayer.inventory[i].count
					xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
					if olditemcount > 0 and xPlayer.inventory[i].name == "radio" then
						xPlayer.addInventoryItem("radio_board", 1)
					end
					pcall(function() -- Start Log
						exports['azael_dc-serverlogs']:insertData({
							event = 'LoseItemFromDeathInBodyBag',
							content = ('%s ได้สูญเสีย %s จำนวน %s ชิ้นจากการโดนอุ้มเอ๋อ'):format(xPlayer.name, xPlayer.inventory[i].name, olditemcount),
							source = xPlayer.source,
						})
					end) -- End Log
				end
			end
		end
	end

	if Config.OxInventory then return cb() end
	cb()
end)

if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)

	RegisterNetEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount

		--xPlayer.showNotification(TranslateCap('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		xPlayer.removeAccountMoney('bank', fineAmount, "Respawn Fine")
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count
	cb(quantity)
end)

ESX.RegisterServerCallback('esx_ambulancejob:reviveAllPlayer', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getJob().name == 'police' then
			local playerPed = GetPlayerPed(source)
			local playerCoords = GetEntityCoords(playerPed)
			local xPlayers = ESX.OneSync.GetPlayersInArea(playerCoords, 2.5)
			for _, player in pairs(xPlayers) do
				if deadPlayers[player.id] then
					deadPlayers[player.id] = nil
					local xTarget =  ESX.GetPlayerFromId(player.id)
					local query = [[
						INSERT INTO billing (target, sender, label, amount, department)
						VALUES (?, ?, ?, ?, ?)
					]]
					MySQL.rawExecute.await(query, {
						 xTarget.identifier,
						 xPlayer.identifier,
						'เกิดใหม่ต่างโลก',
						 1200,
						 'police',
					})
					onReceivedBill(player.id)
					onCreateBill(xPlayer.source)
					TriggerClientEvent('esx_ambulancejob:reviveAllByAmbulance',player.id)
				end
			end
		cb()
		return
	end
	cb()
end)

ESX.RegisterServerCallback('esx_ambulancejob:playerCoords', function(source, cb)
	local xPlayer = source and ESX.GetPlayerFromId(source)
	-- For Log Purpose
	local playerPed = GetPlayerPed(source)
	local playerCoords = GetEntityCoords(playerPed)
	--SetEntityCoords(playerped, playerCoords, false, false, false)
	pcall(function() -- Start Log ยังไม่เสร็จ
		exports['azael_dc-serverlogs']:insertData({
			event = 'reviveCoords',
			content = ('%s พิกัด %s'):format(xPlayer.name, playerCoords),
			source = xPlayer.source,
		})
	end) -- End Log
	cb(playerCoords)
end)

ESX.RegisterServerCallback('esx_ambulancejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price, "Job Vehicle Purchase")
			pcall(function() -- Start Log ยังไม่เสร็จ
				exports['azael_dc-serverlogs']:insertData({
					event = 'AmbulanceBuyVehicle',
					content = ('%s อาชีพ %s ยศ %s ได้ทำการซื้อรถของหน่วยงาน %s ทะเบียน %s สูญเสียเงินจำนวน $%s เหลือเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, vehicleProps.model, vehicleProps.plate, price, ESX.Math.GroupDigits(xPlayer.getMoney())),
					source = xPlayer.source,
				})
			end) -- End Log

			MySQL.insert('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (?, ?, ?, ?, ?, ?)',
				{ xPlayer.identifier, json.encode(vehicleProps), vehicleProps.plate, type, "sos", true },
				function(rowsChanged)
					exports.nc_vehiclekey:ReloadVehicleKey(vehicleProps.plate)
					cb(true)
				end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:storeNearbyVehicle', function(source, cb, plates)
	local xPlayer = ESX.GetPlayerFromId(source)

	local plate = MySQL.scalar.await('SELECT plate FROM owned_vehicles WHERE owner = ? AND plate IN (?) AND job = ?',
		{ xPlayer.identifier, plates, xPlayer.job.name })

	if plate then
		MySQL.update('UPDATE owned_vehicles SET `stored` = true WHERE owner = ? AND plate = ? AND job = ?',
			{ xPlayer.identifier, plate, xPlayer.job.name },
			function(rowsChanged)
				if rowsChanged == 0 then
					cb(false)
				else
					cb(plate)
				end
			end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:checkDeadPlayer', function(source, cb, target)
	if deadPlayers[target] then
		cb(true)
		return
	end
	cb(false)
end)

function getPriceFromHash(vehicleHash, jobGrade, type)
	local vehicles = Config.AuthorizedVehicles[type][jobGrade]

	for i = 1, #vehicles do
		local vehicle = vehicles[i]
		if joaat(vehicle.model) == vehicleHash then
			return vehicle.price
		end
	end

	return 0
end

RegisterNetEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)
	pcall(function() -- Start Log
		exports['azael_dc-serverlogs']:insertData({
			event = 'AmbulanceRemoveItem',
			content = ('%s อาชีพ %s ยศ %s ได้สูญเสีย %s จำนวน 1 ชิ้น'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, item),
			source = xPlayer.source,
		})
	end) -- End Log
	if item == 'bandage' then

	elseif item == 'medikit' then
		
	end
end)

RegisterNetEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name ~= 'police' then
		print(('[^2WARNING^7] Player ^5%s^7 Tried Giving Themselves -> ^5' .. itemName .. '^7!'):format(xPlayer.source))
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage') then
		print(('[^2WARNING^7] Player ^5%s^7 Tried Giving Themselves -> ^5' .. itemName .. '^7!'):format(xPlayer.source))
		return
	end

	if xPlayer.canCarryItem(itemName, amount) then
		xPlayer.addInventoryItem(itemName, amount)
	else
		--xPlayer.showNotification(TranslateCap('max_item'))
	end
end)

ESX.RegisterCommand('revive', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_ambulancejob:revive')
end, true, { help = TranslateCap('revive_help'), validate = true, arguments = {
	{ name = 'playerId', help = 'The player id', type = 'player' }
} })

ESX.RegisterCommand('reviveall', "admin", function(xPlayer, args, showError)
	TriggerClientEvent('esx_ambulancejob:revive', -1)
end, false)

ESX.RegisterUsableItem('gov_aed', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == "police" then
		if not playersReviver[source] then
			if 	GetVehiclePedIsIn(GetPlayerPed(source), false) == 0  then
				playersReviver[source] = true
				TriggerClientEvent('esx_ambulancejob:useItemRevive',source, "gov_aed")
				Wait(3000)
				playersReviver[source] = nil
			end
		end
	else
		notiNotPoliceFormedkit(source)
	end
end)

ESX.RegisterUsableItem('aed', function(source)
	if not playersReviver[source] then
			playersReviver[source] = true
			TriggerClientEvent('esx_ambulancejob:useItemRevive',source, "aed")
			Wait(3000)
			playersReviver[source] = nil
	end
end)

ESX.RegisterUsableItem('r_aed', function(source)
	if not playersReviver[source] then
			playersReviver[source] = true
			TriggerClientEvent('esx_ambulancejob:useItemRevive',source, "r_aed")
			Wait(3000)
			playersReviver[source] = nil
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		if 	GetVehiclePedIsIn(GetPlayerPed(source), false) == 0 then
			local xPlayer = ESX.GetPlayerFromId(source)
			xPlayer.removeInventoryItem('bandage', 1)

			playersHealing[source] = true
			TriggerClientEvent('esx_ambulancejob:useItem', source, 'bandage')

			Wait(3000)
			playersHealing[source] = nil
		end
	end
end)

ESX.RegisterUsableItem('painkiller', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItemGangCard = xPlayer.getInventoryItem("card_gang")
	local xItemFamilyCard = xPlayer.getInventoryItem("card_family")
	if xItemGangCard.count >= 1 or xItemFamilyCard.count >= 1 then
		if not playersHealing[source] then
			xPlayer.removeInventoryItem('painkiller', 1)

			playersHealing[source] = true
			TriggerClientEvent('esx_ambulancejob:useItem', source, 'painkiller')

			Wait(3000)
			playersHealing[source] = nil
		end
	else
		onNoCardGangUsePain(source)
	end
end)

ESX.RegisterUsableItem('gov_painkiller', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' then
		if not playersHealing[source] then
			xPlayer.removeInventoryItem('gov_painkiller', 1)

			playersHealing[source] = true
			TriggerClientEvent('esx_ambulancejob:useItem', source, 'gov_painkiller')

			Wait(3000)
			playersHealing[source] = nil
		end
	else
		onNoCardGangUsePain(source)
	end
end)

ESX.RegisterUsableItem('r_bandage', function(source)
	if not playersHealing[source] then
		if 	GetVehiclePedIsIn(GetPlayerPed(source), false) == 0 then
			local xPlayer = ESX.GetPlayerFromId(source)

			playersHealing[source] = true
			TriggerClientEvent('esx_ambulancejob:useItemTraining', source, 'r_bandage')

			Wait(3000)
			playersHealing[source] = nil
		end
	end
end)

ESX.RegisterUsableItem('r_painkiller', function(source)
	if not playersHealing[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			playersHealing[source] = true
			TriggerClientEvent('esx_ambulancejob:useItemTraining', source, 'r_painkiller')

			Wait(3000)
			playersHealing[source] = nil
		end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeadPlayers', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == "police" then
		cb(deadPlayers)
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.scalar('SELECT is_dead FROM users WHERE identifier = ?', { xPlayer.identifier }, function(isDead)
		cb(isDead)
	end)
end)

RegisterNetEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(isDead) == 'boolean' then
		MySQL.update('UPDATE users SET is_dead = ? WHERE identifier = ?', { isDead, xPlayer.identifier })
		deadPlayers[source] = isDead and 'dead' or nil
		--if not isDead then
		--	local Ambulance = ESX.GetExtendedPlayers("job", "police")
		--	for _, xPlayer in pairs(Ambulance) do
		--		xPlayer.triggerEvent('esx_ambulancejob:PlayerNotDead', source)
		--	end
		--end
	end

end)

--function updateBlip()
--	Wait(5000)
--	TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
--	return updateBlip()
--end
--
--Citizen.CreateThread(function()
--	Citizen.Wait(30000)
--	updateBlip()
--end)

--RegisterNetEvent('esx_ambulancejob:spawned')
--AddEventHandler('esx_ambulancejob:spawned', function()
--	local playerId = source
--	local xPlayer = ESX.GetPlayerFromId(playerId)
--	if xPlayer and xPlayer.job.name == 'ambulance' then
--		Wait(5000)
--		TriggerClientEvent('esx_ambulancejob:updateBlip', -1)
--	end
--end)

function notiNotPoliceFormedkit(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบ AED', -- หัวเรื่อง
        description = 'สามารถใช้ได้เฉพาะหน่วยงานเท่านั้น', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'medkit', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function onNoCardGangUsePain(source)
	exports.nc_notify:PushNotification(source,{
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบเพนคิลเลอร์', -- หัวเรื่อง
		description = 'คุณไม่มีสิทธิใช้ไอเทมนี้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
		--color  = 'rgba(0, 204, 204)',  -- สีของพื้นหลัง
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'block', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
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