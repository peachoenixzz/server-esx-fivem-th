local SafeCodes = {}
-----ANTI CHEAT
local script_name = GetCurrentResourceName()

ServerEvent = {
    [1] = ':server:PYtakeMoney_cashier'..math.random(100),
	[2] = ':server:PYgetItem_SafeReward'..math.random(100)
}

local auth = "Rpg!@7!8!9!10"

GetConfigList = {}
RegisterServerEvent(script_name .. ':server:LoadConfig')
AddEventHandler(script_name .. ':server:LoadConfig', function()
    local _source = source
	if(GetConfigList[_source]) then 
        local xPlayer = ESX.GetPlayerFromId(_source)
        local sendDiscord = xPlayer.name.. "("..xPlayer.identifier..")\n Fake Trigger Event Load Config: " ..script_name..""
		TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'fakeevent', sendDiscord, xPlayer.source, '^2')
    end
	GetConfigList[_source]  = true
    TriggerClientEvent(script_name .. ':client:GetConfig', _source, {se = ServerEvent, tk = tokencheck, cf = Config})
end)


local CHKCashier = {
	[1] = {cd = false},
	[2] = {cd = false},
	[3] = {cd = false},
	[4] = {cd = false},
	[5] = {cd = false},
	[6] = {cd = false},
	[7] = {cd = false},
	[8] = {cd = false},
	[9] = {cd = false},
	[10] = {cd = false},
	[11] = {cd = false},
	[12] = {cd = false},
	[13] = {cd = false},
	[14] = {cd = false},
	[15] = {cd = false},
	[16] = {cd = false},
} 

local CHKSafe = {
	[1] = {cd = false},
	[2] = {cd = false},
	[3] = {cd = false},
	[4] = {cd = false},
	[5] = {cd = false},
	[6] = {cd = false},
	[7] = {cd = false},
	[8] = {cd = false},
	[9] = {cd = false},
	[10] = {cd = false},
} 

local locations = {
	[1] = {position = vector3(-47.24, -1757.65, 29.53), id = 1},
	[2] = {position = vector3(-48.58, -1759.21, 29.59), id = 2},
	[3] = {position = vector3(-1486.26, -378.0, 40.16), id = 3},
	[4] = {position = vector3(-1222.03, -908.32, 12.32), id = 4},
	[5] = {position = vector3(-706.08, -915.42, 19.21), id = 5},
	[6] = {position = vector3(-706.16, -913.5, 19.21), id = 6},
	[7] = {position = vector3(24.47, -1344.99, 29.49), id = 7},
	[8] = {position = vector3(24.45, -1347.37, 29.49), id = 8},
	[9] = {position = vector3(1134.15, -982.53, 46.41), id = 9},
	[10] = {position = vector3(1165.05, -324.49, 69.2), id = 10},
	[11] = {position = vector3(1164.7, -322.58, 69.2), id = 11},
	[12] = {position = vector3(373.14, 328.62, 103.56), id = 12},
	[13] = {position = vector3(372.57, 326.42, 103.56), id = 13},
	[14] = {position = vector3(-1818.9, 792.9, 138.08), id = 14},
	[15] = {position = vector3(-1820.17, 794.28, 138.08), id = 15},
	[16] = {position = vector3(-2966.46, 390.89, 15.04), id = 16}
}

Citizen.CreateThread(function()
    while true do 
        SafeCodes = {
            [1] = math.random(1000, 9999),
            [2] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
            [3] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
            [4] = math.random(1000, 9999),
            [5] = math.random(1000, 9999),
            [6] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
            [7] = math.random(1000, 9999),
            [8] = math.random(1000, 9999),
           	[9] = math.random(1000, 9999),
            [10] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
			--[[[11] = math.random(1000, 9999),
            [12] = math.random(1000, 9999),
            [13] = math.random(1000, 9999),
            [14] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
            [15] = math.random(1000, 9999),
            [16] = math.random(1000, 9999),
            [17] = math.random(1000, 9999),
            [18] = {math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149), math.random(150.0, 359.0), math.random(1, 149)},
            [19] = math.random(1000, 9999),]]
        }
        Citizen.Wait((1000 * 60) * 45)
    end
end)


function handleItemPlayer(xPlayer)
	for _,v in pairs(Config.cashierItem) do
		if v.getItemName ~= nil then
			local matchingItems = {}

			for _,v in pairs(v.getItemName) do
				table.insert(matchingItems, v)
			end

			if #matchingItems > 0 then
				local randomIndex = math.random(1, #matchingItems)
				local randomItemSet = matchingItems[randomIndex]
				for i, itemName in ipairs(randomItemSet.itemName) do
					if itemName == "black_money" or itemName == "money" then
						local amount = math.random(randomItemSet.moneyCount[1], randomItemSet.moneyCount[2])
						xPlayer.addAccountMoney(itemName, tonumber(amount))
						pcall(function() -- Start log
							exports['azael_dc-serverlogs']:insertData({
								 event = 'ReceivedStoreRobberyMoney',
								 content = ('%s ได้รับ %s จำนวน $%s จากการงัดร้านค้า มีเงินผิดกฏหมายในกระเป๋าจำนวน $%s และเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, itemName, tonumber(amount), xPlayer.getAccount("black_money").money, ESX.Math.GroupDigits(xPlayer.getMoney())),
								 source = xPlayer.source,
							})
						end) -- End log
					end
					if itemName ~= "black_money" and itemName ~= "money" then
						local itemCount = math.random(randomItemSet.itemCount[1],randomItemSet.itemCount[2])
						xPlayer.addInventoryItem(itemName, itemCount)
						pcall(function() -- Start log
							exports['azael_dc-serverlogs']:insertData({
								 event = 'ReceivedStoreRobberyItem',
								 content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการงัดร้านค้า มีเงินผิดกฏหมายในกระเป๋าจำนวน $%s และเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, itemName, itemCount, xPlayer.getAccount("black_money").money, ESX.Math.GroupDigits(xPlayer.getMoney())),
								 source = xPlayer.source,
							})
						end) -- End log
					end
				end
			end
		end

		if v.getItemBonusSecond ~= nil then
			--print(v.getItemBonusSecond)
			xItemBonusSecondRate = math.random(1, 100000)/100000
			tblSecond = v.getItemBonusSecond
			itemBonusSecondRand = tblSecond[math.random(1, #tblSecond)]
			xItemBonusSecond = xPlayer.getInventoryItem(itemBonusSecondRand)
			--print('BonusSecondRate  '..xItemBonusSecondRate)
		end

		if v.getItemBonus ~= nil then
			local xItemBonusRate = math.random(1, 100000)/100000
			print(xItemBonusRate)
			local matchingItems = {}
			local minMatchingPercent = 1.0

			for _, v in pairs(v.getItemBonus) do
				if xItemBonusRate <= v.percent then
					table.insert(matchingItems, v)
					if v.percent < minMatchingPercent then
						minMatchingPercent = v.percent
					end
				end
			end

			local finalMatchingItems = {}
			for _, v in pairs(matchingItems) do
				if v.percent == minMatchingPercent then
					table.insert(finalMatchingItems, v)
				end
			end


			if #finalMatchingItems > 0 then
				local randomIndex = math.random(1, #finalMatchingItems)
				local randomItemSet = finalMatchingItems[randomIndex]
				for i, itemName in ipairs(randomItemSet.itemName) do
					local itemCount = randomItemSet.itemCount[i]
					if itemName == "black_money" then
						local amount =  math.random(randomItemSet.itemCount[1],randomItemSet.itemCount[2])
						xPlayer.addAccountMoney(itemName, tonumber(amount))
						pcall(function() -- Start log
							exports['azael_dc-serverlogs']:insertData({
								 event = 'ReceivedStoreRobberyBlackMoney',
								 content = ('%s ได้รับ %s จำนวน $%s จากการงัดร้านค้า มีเงินผิดกฏหมายในกระเป๋าจำนวน $%s'):format(xPlayer.name, itemName, tonumber(amount), xPlayer.getAccount("black_money").money),
								 source = xPlayer.source,
							})
						end) -- End log
						return
					end

					if itemName == "money" then
						local amount =  math.random(randomItemSet.itemCount[1],randomItemSet.itemCount[2])
						xPlayer.addAccountMoney(itemName, tonumber(amount))
						pcall(function() -- Start log
							exports['azael_dc-serverlogs']:insertData({
								 event = 'ReceivedStoreRobberyMoney',
								 content = ('%s ได้รับ %s จำนวน $%s จากการงัดร้านค้า มีเงินในกระเป๋าจำนวน $%s'):format(xPlayer.name, itemName, tonumber(amount), ESX.Math.GroupDigits(xPlayer.getMoney())),
								 source = xPlayer.source,
							})
						end) -- End log
						return
					end
					xPlayer.addInventoryItem(itemName, itemCount)
					pcall(function() -- Start log
						exports['azael_dc-serverlogs']:insertData({
							 event = 'ReceivedStoreRobberyItem',
							 content = ('%s ได้รับ %s จำนวน %s ชิ้น จากการงัดร้านค้า'):format(xPlayer.name, itemName, itemCount),
							 source = xPlayer.source,
						})
					end) -- End log
				end
			end
		end
	end
end

ESX.RegisterServerCallback('cc_storerobbery:giveItem', function(source, cb, basicAuth)
	local isFarFromPosition = false
	local ped = GetPlayerPed(source)
	local playerCoords = GetEntityCoords(ped) -- Gets the player's current coordinates
	for _, pos in ipairs(locations) do
		-- Check if the distance is greater than 10 units
		if  #(playerCoords - pos.position) > 10 then
			isFarFromPosition = true
		end
		isFarFromPosition = false
	end
	if isFarFromPosition then
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				event = 'Exploit',
				content = ('ผู้เล่นพยายาม Trigger การงัดร้านอย่างผิดวิธี'):format(),
				source = source,
			})
		end) -- End log
	end
	if basicAuth == auth and not isFarFromPosition then
		local xPlayer = ESX.GetPlayerFromId(source)
		handleItemPlayer(xPlayer)
	end
	cb()
end)

RegisterServerEvent('cc_storerobbery:server:setSafeStatus')
AddEventHandler('cc_storerobbery:server:setSafeStatus', function(safe)
	if not Config.Safes[safe].robbed then
		TriggerClientEvent('cc_storerobbery:client:setSafeStatus', -1, safe, true)
		Config.Safes[safe].robbed = true
		SetTimeout(45 * (60 * 1000), function()
			TriggerClientEvent('cc_storerobbery:client:setSafeStatus', -1, safe, false)
			Config.Safes[safe].robbed = false
			CHKSafe[safe].cd = false
		end)
	end
end)

RegisterServerEvent(script_name .. ServerEvent[2])
AddEventHandler(script_name .. ServerEvent[2], function(safe, token)
    local src   = source
    local xPlayer = ESX.GetPlayerFromId(src)
	local discord = "Player : " ..xPlayer.name.." ("..xPlayer.identifier..") \n type : Safe"
	local rvitem = false
	if token == tokencheck and CHKSafe[safe] ~= nil and not CHKSafe[safe].cd then
		for k,v in pairs(SvConfig.ItemSafe) do
			math.randomseed(GetGameTimer()+math.random(1111,9999))
			local luck = math.random(1, 100)
			if luck <= v.rate then
				rvitem = true
				if v.item == "cash" then
					xPlayer.addMoney(v.amount)
					discord = discord.."\n Add Money : $".. v.amount ..""
					TriggerClientEvent('what_notify:message',src,{
						msg = 'You received $'.. ESX.Math.GroupDigits(v.amount) ..' from the Safe.!',
						type = 1,
						wait = 3,
					})
				
				elseif v.item == "black_money" then
					xPlayer.addAccountMoney('black_money', v.amount)
					discord = discord.."\n Add Black Money : $".. v.amount ..""

					TriggerClientEvent('what_notify:message',src,{
						msg = 'You received $'.. ESX.Math.GroupDigits(v.amount) ..' Dirty money from the Safe.!',
						type = 1,
						wait = 3,
					})
				
				else
					if xPlayer.canCarryItem(v.item, v.amount) then
						xPlayer.addInventoryItem(v.item, v.amount)
						discord = discord.."\n Add ItemInventory : ".. v.item .."(".. v.amount .."), "
					else
						TriggerClientEvent('what_notify:message',src,{
							msg = 'You are overweight!',
							type = 2,
							wait = 3,
						})
					end
				end
			end
			
			Citizen.Wait(100)
		end
		CHKSafe[safe].cd = true
		if rvitem then
			discord = discord.." "
			TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'storeSafe', discord, xPlayer.source, '^3')
		end
	else
		local sendDiscord = xPlayer.name.. "("..xPlayer.identifier..")\n fail token script: " .. script_name .. "\n Safe No. : "..safe.."\n Safe stat : "..Config.Safes[safe].robbed..""
		TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'token', sendDiscord, xPlayer.source, '^3')
	end
end)

RegisterServerEvent('cc_storerobbery:server:removeitem')
AddEventHandler('cc_storerobbery:server:removeitem', function()
    local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem("screwdv")
	if xItem.count > 0 then
		xPlayer.removeInventoryItem('screwdv', 1)
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				 event = 'ScrewDriverBroken',
				 content = ('%s ได้สูญเสีย %s จำนวน 1 ชิ้น จากการงัดร้าน'):format(xPlayer.name, xItem.name),
				 source = xPlayer.source,
			})
		end) -- End log
		xPlayer.addInventoryItem('screwdv_broken', 1)
		pcall(function() -- Start log
			exports['azael_dc-serverlogs']:insertData({
				 event = 'ReceivedBrokenScrewDriver',
				 content = ('%s ได้รับ screwdv_broken จำนวน 1 ชิ้น จากการงัดร้าน'):format(xPlayer.name),
				 source = xPlayer.source,
			})
		end) -- End log
	end
end)

Citizen.CreateThread(function()
    while true do
        for k, v in pairs(Config.Registers) do
            if Config.Registers[k].time > 0 and (Config.Registers[k].time - SvConfig.tickInterval) >= 0 then
                Config.Registers[k].time = Config.Registers[k].time - SvConfig.tickInterval
            else
                Config.Registers[k].time = 0
                Config.Registers[k].robbed = false
				CHKCashier[k].cd = false
                TriggerClientEvent('cc_storerobbery:client:setRegisterStatus', -1, k, false)
            end
			Citizen.Wait(100)
        end
        Citizen.Wait(SvConfig.tickInterval)
    end
end)

ESX.RegisterServerCallback('cc_storerobbery:server:isCombinationRight', function(source, cb, safe)
    cb(SafeCodes[safe])
end)

ESX.RegisterServerCallback('cc_storerobbery:server:getPadlockCombination', function(source, cb, safe)
    cb(SafeCodes[safe])
end)

ESX.RegisterServerCallback('cc_storerobbery:server:getRegisterStatus', function(source, cb)
    cb(Config.Registers)
end)

ESX.RegisterServerCallback('cc_storerobbery:server:getSafeStatus', function(source, cb)
    cb(Config.Safes)
end)

exports("handleItemPlayer",handleItemPlayer)