local alreadyProcess = {}
local baseItemAmount = {}
local baseItemName = {}
local baseProcessAmount = {}
local getProcessAmount = {}
local bonusAmount = {}
local bonusPlusAmount = {}

function validateConfig(ZoneProcessingClient)
	for _,v in pairs(Config.ProcessingZone) do
		if v.Items[1].ItemName == ZoneProcessingClient.Items[1].ItemName and ZoneProcessingClient.Items[1].Get.ItemName == v.Items[1].Get.ItemName then
			return true,v
		end
	end
	return false,nil
end

function initServerProcess(xPlayer,xItem,itemProcessZone)
	alreadyProcess[xPlayer.source] = true
	baseItemAmount[xPlayer.source] = xItem.count
	baseItemName[xPlayer.source] = xItem.name
	baseProcessAmount[xPlayer.source] = 0
	getProcessAmount[xPlayer.source] = {}
	bonusAmount[xPlayer.source] = {}
	bonusPlusAmount[xPlayer.source] = {}
	table.insert(getProcessAmount[xPlayer.source],{itemName = itemProcessZone.Items[1].Get.ItemName, count = 0})
	--print(json.encode(getProcessAmount[xPlayer.source]))
	if itemProcessZone.Items[1].Get.Bonus ~= nil then
		for _,v in pairs(itemProcessZone.Items[1].Get.Bonus) do
			table.insert(bonusAmount[xPlayer.source], {itemName = v.ItemName , count = 0})
			--print(json.encode(bonusAmount[xPlayer.source]))
		end
	end
	if itemProcessZone.Items[1].Get.BonusPlus ~= nil then
		for _,v in pairs(itemProcessZone.Items[1].Get.BonusPlus) do
			table.insert(bonusPlusAmount[xPlayer.source], {itemName = v.ItemName , count = 0})
			--print(json.encode(bonusPlusAmount[xPlayer.source]))
		end
	end
end

function doneServerProcess(xPlayer)
	alreadyProcess[xPlayer.source] = false
	baseItemAmount[xPlayer.source] = 0
	baseProcessAmount[xPlayer.source] = 0
	baseItemName[xPlayer.source] = nil
	getProcessAmount[xPlayer.source] = nil
	bonusAmount[xPlayer.source] = nil
	bonusPlusAmount[xPlayer.source] = nil
	collectgarbage("collect")
end

ESX.RegisterServerCallback('cc_processing:checkItemCount', function(source, cb,CurrentZone)
	local xPlayer = ESX.GetPlayerFromId(source)
	local stateValidate,itemProcessZone = validateConfig(CurrentZone)
	local ecoCoreEffect = 1
	if itemProcessZone.Items.coreEffect then
		if exports.cc_coreeffect:coreEffectCalculateEcoNormal(xPlayer) ~= 1   then
			ecoCoreEffect = exports.cc_coreeffect:coreEffectCalculateEcoNormal(xPlayer)
		end
	end

	if itemProcessZone.Items.coreEffectMining then
		if exports.cc_coreeffect:coreEffectCalculateMiningNormal(xPlayer) ~= 1   then
			ecoCoreEffect = exports.cc_coreeffect:coreEffectCalculateMiningNormal(xPlayer)
		end
	end

	if alreadyProcess[xPlayer.source] then
		doneServerProcess(xPlayer)
		cb(false)
		return
	end

	if stateValidate then
		local xItem = xPlayer.getInventoryItem(itemProcessZone.Items[1].ItemName)
		--print("first step check item count",xItem.count)
		if xItem.count >= CurrentZone.Items[1].ItemCount * ecoCoreEffect then
			initServerProcess(xPlayer,xItem,itemProcessZone)
			pcall(function() -- Start log
				exports['azael_dc-serverlogs']:insertData({
					event = 'CheckProcessItem',
					content = ('%s มี %s จำนวน %s ในกระเป๋าเพื่อใช้ในการ process'):format(xPlayer.name, xItem.name, xItem.count),
					source = xPlayer.source,
				 })
			end) -- End log
			cb(true)
			return
		end
		onNoItemToProcess(source)
		doneServerProcess(xPlayer)
		cb(false)
		return
	end
	doneServerProcess(xPlayer)
	cb(false)
end)

RegisterServerEvent('cc_process:process')
AddEventHandler('cc_process:process', function(Zone,collectUserItems,countItem)
	local datasource = source
	local xPlayer = ESX.GetPlayerFromId(datasource)
	local ItemMustUse = xPlayer.getInventoryItem(Zone[1].ItemName)
	local ItemMustUseCount = Zone[1].ItemCount
	local stateValidate = validateItemUser(ItemMustUse,ItemMustUseCount,collectUserItems,xPlayer,Zone,countItem)
	if stateValidate then
		checkItems(collectUserItems,Zone,xPlayer)
	end
end)

function validateItemUser(ItemMustUse,ItemMustUseCount,collectUserItems,xPlayer,Zone,oldCountItem)
		--local weight = xPlayer.getWeight()
		--local baseItemInInventory = xPlayer.getInventoryItem(Zone[1].ItemName)
		local getItemProcess = xPlayer.getInventoryItem(Zone[1].Get.ItemName)
		--print("item name : ", getItemProcess.name)
		--print("weight items : ",getItemProcess.weight)
		--local userWeightWithGetItems = xPlayer.getWeight() + getItemProcess.weight
		--print("player weight now : " , xPlayer.getWeight())
		--print("cal get item : ",xPlayer.getWeight() + getItemProcess.weight)
		--print("base weight : ",ESX.GetConfig().MaxWeight)
		--print("weight player : " ,exports.cc_weight:playerCalculateWeight(xPlayer.source))
		--print("old count items :" ,oldCountItem)
		--print("item must use count :" ,ItemMustUseCount)
		--print("item count in collector",collectUserItems.baseItem.count)
		--print("base server count item",ItemMustUse.count)
		--print("weight cal : ",userWeightWithGetItems)

		local ecoCoreEffect = 1
	if Zone.coreEffect then
		if exports.cc_coreeffect:coreEffectCalculateEcoNormal(xPlayer) ~= 1  then
			--local stableCount = collectUserItems.baseItem.count
			ecoCoreEffect = exports.cc_coreeffect:coreEffectCalculateEcoNormal(xPlayer)
			--print("core effect multi", ecoCoreEffect)
			ItemMustUseCount = ecoCoreEffect * ItemMustUseCount
			--print("item count after cal coreeffect",collectUserItems.baseItem.count)
			--if stableCount == ItemMustUseCount then
			--	collectUserItems.baseItem.count = stableCount
			--end
		end
	end

	--coreEffectCalculateMiningNormal
	if Zone.coreEffectMining then
		if exports.cc_coreeffect:coreEffectCalculateMiningNormal(xPlayer) ~= 1  then
			--local stableCount = collectUserItems.baseItem.count
			ecoCoreEffect = exports.cc_coreeffect:coreEffectCalculateMiningNormal(xPlayer)
			--print("core effect multi", ecoCoreEffect)
			ItemMustUseCount = ecoCoreEffect * ItemMustUseCount
			--print("item count after cal coreeffect",collectUserItems.baseItem.count)
			--if stableCount == ItemMustUseCount then
			--	collectUserItems.baseItem.count = stableCount
			--end
		end
	end

		-- ตรวจสอบการเปลี่ยนแปลงของไอเทม
		if baseItemAmount[xPlayer.source] ~= ItemMustUse.count then
			onInventoryItemChange(xPlayer.source)
			TriggerClientEvent("cc_process:autofalse", xPlayer.source)
			pcall(function() -- Start Log
				exports['azael_dc-serverlogs']:insertData({
					event = 'ProcessFailItemSuddenlyChange',
					content = ('%s ไม่สามารถทำ Process ได้เนื่องจากจำนวนไอเทมในกระเป๋ามีการเปลี่ยนแปลงกะทันหัน'):format(xPlayer.name),
					source = xPlayer.source,
				})
			end) -- End Log
			doneServerProcess(xPlayer)
			return false
		end


		--ตรวจสอบน้ำหนัก
		--if ESX.Math.Round(tonumber(userWeightWithGetItems)) >  ESX.Math.Round(tonumber(exports.cc_weight:playerCalculateWeight(xPlayer.source))) then
		--	onMaxWeight(xPlayer.source)
		--	TriggerClientEvent("cc_process:autofalse", xPlayer.source)
		--	pcall(function() -- Start Log
		--		exports['azael_dc-serverlogs']:insertData({
		--			event = 'ProcessFailOverWeight',
		--			content = ('%s ไม่สามารถทำ Process ได้เนื่องจากน้ำหนักไม่เพียงพอต่อการได้รับไอเทมจากการ Process'):format(xPlayer.name),
		--			source = xPlayer.source,
		--		})
		--	end) -- End Log
		--	return false
		--end


		if next(collectUserItems.baseItem) ~= nil then
			--print("collect base count",collectUserItems.baseItem.count)
			--print("muse use count",ItemMustUseCount)
			if collectUserItems.baseItem.count < ItemMustUseCount then
				onNoItemToProcess(xPlayer.source)
				TriggerClientEvent("cc_process:doneProcess", xPlayer.source)
				TriggerClientEvent("cc_process:autofalse", xPlayer.source)
				doneProcess(xPlayer.source)
				pcall(function() -- Start Log
					exports['azael_dc-serverlogs']:insertData({
						event = 'ProcessFailFirstTime',
						content = ('%s ไม่สามารถทำ Process ครั้งแรกได้เนื่องจากไม่มี Item เพื่อใช้ในการ Process'):format(xPlayer.name),
						source = xPlayer.source,
					})
				end) -- End Log
				doneServerProcess(xPlayer)
				return false
			end
		end

		if ItemMustUse.count < ItemMustUseCount then
			onNoItemToProcess(xPlayer.source)
			TriggerClientEvent("cc_process:doneProcess", xPlayer.source)
			TriggerClientEvent("cc_process:autofalse", xPlayer.source)
			doneProcess(xPlayer.source)
			pcall(function() -- Start Log
				exports['azael_dc-serverlogs']:insertData({
					event = 'ProcessFailNoItem',
					content = ('%s ไม่สามารถทำ Process ได้เนื่องจากไม่มี Item เพื่อใช้ในการ Process '):format(xPlayer.name),
					source = xPlayer.source,
				})
			end) -- End Log
			doneServerProcess(xPlayer)
			return false
		end
		pcall(function() -- Start Log --ยังไม่เสร็จ
			exports['azael_dc-serverlogs']:insertData({
				event = 'ProcessEachItem',
				content = ('%s ได้ทำการ Process %s เป็น %s แล้วจำนวน ชิ้น'):format(xPlayer.name, ItemMustUse.name, getItemProcess.name),
				source = xPlayer.source,
			})
		end) -- End Log
		return true
end

function checkItems(collectUserItems,baseItem,xPlayer)
	local random = math.random(baseItem[1].Get.ItemCount[1], baseItem[1].Get.ItemCount[2])
	local getItemProcess = baseItem[1].Get.ItemName
	local ecoCoreEffect = 1
	if baseItem.coreEffect then
		if exports.cc_coreeffect:coreEffectCalculateEcoNormal(xPlayer) ~= 1 then
			random = exports.cc_coreeffect:coreEffectCalculateEcoNormal(xPlayer) * random
			ecoCoreEffect = exports.cc_coreeffect:coreEffectCalculateEcoNormal(xPlayer)
		end
	end
	--coreEffectCalculateMiningNormal
	if baseItem.coreEffectMining then
		if exports.cc_coreeffect:coreEffectCalculateMiningNormal(xPlayer) ~= 1 then
			random = exports.cc_coreeffect:coreEffectCalculateMiningNormal(xPlayer) * random
			ecoCoreEffect = exports.cc_coreeffect:coreEffectCalculateMiningNormal(xPlayer)
		end
	end

	-- cal for validate
	-- pain code but can use for cal eco normal
	if collectUserItems.itemName[getItemProcess] == nil then
		if baseItem[1].Get.Bonus ~= nil then
			local getBonus = bonusItem(baseItem,xPlayer,ecoCoreEffect)
			--print("get bonus return : ", getBonus)
			calculateBaseItem(xPlayer,baseItem,ecoCoreEffect,random,getBonus)
			if getBonus then random = 0 end
			TriggerClientEvent("cc_process:auto", xPlayer.source,random,getItemProcess,ecoCoreEffect)
			return
		end
		calculateBaseItem(xPlayer,baseItem,ecoCoreEffect,random)
		TriggerClientEvent("cc_process:auto", xPlayer.source,random,getItemProcess,ecoCoreEffect)
		return
	end

	if baseItem.auto then
		if baseItem[1].Get.Bonus ~= nil then
			local getBonus = bonusItem(baseItem,xPlayer,ecoCoreEffect)
			--print("get bonus return : ", getBonus)
			calculateBaseItem(xPlayer,baseItem,ecoCoreEffect,random,getBonus)
			if getBonus then random = 0 end
			TriggerClientEvent("cc_process:auto", xPlayer.source,random,getItemProcess,ecoCoreEffect)
			return
		end
		calculateBaseItem(xPlayer,baseItem,ecoCoreEffect,random)
		TriggerClientEvent("cc_process:auto", xPlayer.source,random,getItemProcess,ecoCoreEffect)
	end

end

function calculateBaseItem(xPlayer,baseItem,ecoCoreEffect,coreEffectGet,getBonus)
	--print("default base : ",baseItem[1].ItemCount,ecoCoreEffect)
	local coreEffectBase = baseItem[1].ItemCount * ecoCoreEffect
	baseProcessAmount[xPlayer.source] = baseProcessAmount[xPlayer.source] + coreEffectBase

	for _,v in ipairs(getProcessAmount[xPlayer.source]) do
		if getBonus then break end
		v.count = v.count + coreEffectGet
	end

	--print("process amount server : ",baseProcessAmount[xPlayer.source])
	--print("base amount server : ",baseItemAmount[xPlayer.source])
	--print("base coreEffectBase server : ",baseProcessAmount[xPlayer.source] + coreEffectBase)
	--print("process get amount server : ",getProcessAmount[xPlayer.source])
	if baseItemAmount[xPlayer.source] < baseProcessAmount[xPlayer.source] + coreEffectBase then
		TriggerClientEvent("cc_process:autofalse", xPlayer.source)
		doneProcessNotify(xPlayer.source)
		doneProcess(xPlayer.source)
		return
	end
end

function calculateBonusItem(xPlayer,itemGive,bonusConfig,ecoCoreEffect)
	--print(ecoCoreEffect)
	for _,v in pairs(bonusAmount[xPlayer.source]) do
		local coreEffectBase = 0
		for _,vi in pairs(bonusConfig) do
			if vi.ItemName == itemGive then
				coreEffectBase = vi.ItemCount * ecoCoreEffect
			end
		end
		--print(v.itemName)
		if v.itemName == itemGive then
			v.count = v.count + coreEffectBase
		end
	end
end

--function calculateBonusItem(xPlayer,itemGive,bonusConfig,eco)
--	for _,v in pairs(bonusAmount[xPlayer.source]) do
--		--print(v.itemName)
--		if v.itemName == itemGive then
--			v.count = v.count + bonusConfig[1].ItemCount
--		end
--	end
--end

function calculateBonusPlusItem(xPlayer,itemGive,bonusConfig,ecoCoreEffect)
	for _,v in pairs(bonusPlusAmount[xPlayer.source]) do
		local coreEffectBase = bonusConfig.BonusPlusCount * ecoCoreEffect
		if v.itemName == itemGive then
			v.count = v.count + coreEffectBase
		end
	end
end

function bonusItem(baseItem,xPlayer,ecoCoreEffect)
	--print("bonus effect: ",ecoCoreEffect)
	--print("Bonus Count", #baseItem[1].Get.Bonus)
	local getBonus = false
    if #baseItem[1].Get.Bonus ~= 0 then
		local xItemBonus = math.random(1, 100000)/100000
		if exports.cc_coreeffect:coreEffectCheckTimeGlobal('fever_time_event') >= 0 then
			local calculateBonus = (xItemBonus/100) * 5
			xItemBonus = xItemBonus - calculateBonus
		end
		--print(xItemBonus)
		for _,v in ipairs(baseItem[1].Get.Bonus) do
			if xItemBonus <= v.Percent then -- bonusepercent
					calculateBonusItem(xPlayer,v.ItemName,baseItem[1].Get.Bonus,ecoCoreEffect)
					TriggerClientEvent("cc_process:giveBonusItems",xPlayer.source,v.ItemName, v.ItemCount * ecoCoreEffect)
					--print("new config", baseItem[1].Get.getOneItem)
					if baseItem[1].Get.getOneItem then getBonus = true end
				if v.Animation ~= nil then
					TriggerClientEvent("cc_process:animation", xPlayer.source, v.Animation)
				end
			end
		end
	end

	--print("Bonus Plus Count",#baseItem[1].Get.BonusPlus)
	if #baseItem[1].Get.BonusPlus ~= 0 then
		tblPlus = baseItem[1].Get.BonusPlus
		itemPlusRand = tblPlus[math.random(1, #tblPlus)]
		local xItemBonusPlus = xPlayer.getInventoryItem(itemPlusRand.ItemName)
		local xItemBonusSecond = math.random(1, 100000)/100000
		if exports.cc_coreeffect:coreEffectCheckTimeGlobal('fever_time_event') >= 0 then
			local calculateBonus = (xItemBonusSecond/100) * 5
			xItemBonusSecond = xItemBonusSecond - calculateBonus
		end
		if xItemBonusSecond <= baseItem[1].Get.BonusPlusPercent then -- bonusepercent
				calculateBonusPlusItem(xPlayer, xItemBonusPlus.name,baseItem[1].Get,ecoCoreEffect)
				TriggerClientEvent("cc_process:giveBonusItems", xPlayer.source, xItemBonusPlus.name, baseItem[1].Get.BonusPlusCount * ecoCoreEffect)
				if baseItem[1].Get.getOneItem then getBonus = true end
			if baseItem[1].Get.BonusPlusAnim ~= nil then
				TriggerClientEvent("cc_process:animation", xPlayer.source, baseItem[1].Get.BonusPlusAnim)
			end
		end
	end
	return getBonus
end

function doneProcess(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	for _,v in ipairs(getProcessAmount[xPlayer.source]) do
		--print("item count before give",v.count)
		local xItem = xPlayer.getInventoryItem(v.itemName)
		xPlayer.removeInventoryItem(baseItemName[xPlayer.source], baseProcessAmount[xPlayer.source])
		pcall(function() -- Start Log
			exports['azael_dc-serverlogs']:insertData({
				event = 'RemoveItemFromProcess',
				content = ('%s ได้สูญเสีย %s จำนวน %s ชิ้นจากการ process'):format(xPlayer.name, baseItemName[xPlayer.source], baseProcessAmount[xPlayer.source]),
				source = xPlayer.source,
			})
		end) -- End Log
		xPlayer.addInventoryItem(xItem.name, v.count)
		pcall(function() -- Start Log
			exports['azael_dc-serverlogs']:insertData({
				event = 'ReceivedProcessItem',
				content = ('%s ได้รับ %s จำนวน %s ชิ้นจากการ process %s'):format(xPlayer.name, xItem.name, v.count, baseItemName[xPlayer.source]),
				source = xPlayer.source,
			})
		end) -- End Log
	end

	--print("bonus amount",#bonusAmount[xPlayer.source])
	--print("bonus plus amount",#bonusPlusAmount[xPlayer.source])
	if #bonusAmount[xPlayer.source] ~= 0 then
		for _,v in pairs(bonusAmount[xPlayer.source]) do
			--print("bonus plus item count",v.count)
			xPlayer.addInventoryItem(v.itemName, v.count)
			pcall(function() -- Start Log
				exports['azael_dc-serverlogs']:insertData({
					event = 'ReceivedProcessBonusItem',
					content = ('%s ได้รับ %s จำนวน %s ชิ้นจากการ process %s'):format(xPlayer.name, v.itemName, v.count, baseItemName[xPlayer.source]),
					source = xPlayer.source,
				})
			end) -- End Log
		end
	end
	if #bonusPlusAmount[xPlayer.source] ~= 0 then
		for _,v in pairs(bonusPlusAmount[xPlayer.source]) do
			--print("bonus plus item count",v.count)
			xPlayer.addInventoryItem(v.itemName, v.count)
			pcall(function() -- Start Log
				exports['azael_dc-serverlogs']:insertData({
					event = 'ReceivedProcessBonusItemPlus',
					content = ('%s ได้รับ %s จำนวน %s ชิ้นจากการ process %s'):format(xPlayer.name, v.itemName, v.count, baseItemName[xPlayer.source]),
					source = xPlayer.source,
				})
			end) -- End Log
		end
	end
	doneServerProcess(xPlayer)
end

RegisterServerEvent('cc_process:doneProcess')
AddEventHandler('cc_process:doneProcess', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local ItemMustUse = xPlayer.getInventoryItem(baseItemName[xPlayer.source])
	-- ตรวจสอบการเปลี่ยนแปลงของไอเทม
	if baseItemAmount[xPlayer.source] ~= ItemMustUse.count then
		onInventoryItemChange(xPlayer.source)
		TriggerClientEvent("cc_process:autofalse", xPlayer.source)
		pcall(function() -- Start Log
			exports['azael_dc-serverlogs']:insertData({
				event = 'ProcessFailItemSuddenlyChange',
				content = ('%s ไม่สามารถทำ Process ได้เนื่องจากจำนวนไอเทมในกระเป๋ามีการเปลี่ยนแปลงกะทันหัน'):format(xPlayer.name),
				source = xPlayer.source,
			})
		end) -- End Log
		doneServerProcess(xPlayer)
		return false
	end
	doneProcess(source)
end)

RegisterServerEvent('cc_process:checkItem')
AddEventHandler('cc_process:checkItem', function(Zone)
	local datasource = source
	local xPlayer	= ESX.GetPlayerFromId(datasource)
	local xItem = xPlayer.getInventoryItem(Zone.Items[1].ItemName)
	TriggerClientEvent("cc_process:processDetailUI", datasource,xItem.count,Zone)
end)


ESX.RegisterServerCallback('cc_processing:checkCard', function(source, cb, CurrentZone)
	-- incident
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem("card_nplayer")
    if CurrentZone.jobBuff == true then
		if xItem.count > 0 and CurrentZone.Items[1].ItemName == "coffin" then -- เช็คการ์ดผู้เล่นใหม่ไม่มีผลกับกิจกรรมฮาโลวีน
			cb(CurrentZone.WaitProcessing)
			return
		end
        local calculateProtime = exports.cc_corejob:coreJobCalculateproTime(xPlayer, CurrentZone.WaitProcessing)
        --print(calculateProtime)
        cb(calculateProtime)
        return
    end
    cb(CurrentZone.WaitProcessing)
end)



AddEventHandler('playerDropped', function()
	local playerId = source
	if playerId then
		local xPlayer = ESX.GetPlayerFromId(playerId)
		if xPlayer then
			alreadyProcess[xPlayer.source] = nil
			baseItemAmount[xPlayer.source] = nil
			baseItemName[xPlayer.source] = nil
			baseProcessAmount[xPlayer.source] = nil
			getProcessAmount[xPlayer.source] = nil
			bonusAmount[xPlayer.source] = nil
			bonusPlusAmount[xPlayer.source] = nil
		end
		collectgarbage("collect")
	end
end)

function onNoItemToProcess(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบ Process', -- หัวเรื่อง
        description = 'คุณไม่มีสิ่งของที่กำหนด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end


function onMaxWeight(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบ Process', -- หัวเรื่อง
        description = 'น้ำหนักกระเป๋าเต็ม', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'error',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'inventory_max', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function onInventoryItemChange(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบ Process', -- หัวเรื่อง
        description = 'จำนวนเปลี่ยนแปลงกระทันหัน', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'inventory_error', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function doneProcessNotify(source)
	exports.nc_notify:PushNotification(source,{
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'ระบบ Process', -- หัวเรื่อง
		description = 'เสร็จสิ้นการ Process', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'success',
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end