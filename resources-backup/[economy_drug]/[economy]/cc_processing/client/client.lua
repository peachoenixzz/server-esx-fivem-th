local IsProcessing, IsOpenMenu = false, false
local realItems = nil
local IsInMarkerProcess  = false
local detailProcess = true
local helpNotify = true
local callBackDetail = true
local ongoingProcess = false
local IsDead = false
local CurrentZone = nil
local collectUserItems = {
	itemName = {},
	baseItem = {}
}

local oldCount = nil
Citizen.CreateThread(function()
	for _,v in pairs(Config.ProcessingZone) do
		if v.NPCopen then
			RequestModel(GetHashKey(v.NPC))
			while not HasModelLoaded(GetHashKey(v.NPC)) do
				Wait(1)
			end
		end
	end

	for _,v in pairs(Config.ProcessingZone) do
		if v.NPCopen then
			ped =  CreatePed(4, v.NPC,v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z-1, 3374176, false, true)
			SetEntityHeading(ped, v.Marker.Pos.h)
			FreezeEntityPosition(ped, true)
			SetEntityInvincible(ped, true)
			SetBlockingOfNonTemporaryEvents(ped, true)
			TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
		end	
	end	
end)

--function Animation(CurrentZone)
--	IsProcessing = true
--	--ESX.ShowHelpNotification(CurrentZone.Text.ProcessText)
--	--local timeLeft = CurrentZone.WaitProcessing / 1000
--	local playerPed = PlayerPedId()
--	local ObjectSpawn = nil
--	if CurrentZone.Prop ~= nil then
--		ObjectSpawn = CreateObject(GetHashKey(CurrentZone.Prop.Object), CurrentZone.Prop.Location.x, CurrentZone.Prop.Location.y, CurrentZone.Prop.Location.z, CurrentZone.Prop.isNetwork, false, true)
--		SetEntityHeading(ObjectSpawn, CurrentZone.Prop.Location.h)
--		PlaceObjectOnGroundProperly(ObjectSpawn)
--	end
--
--	-- Play Animation
--	if CurrentZone.Animation.Scenario then
--		TaskStartScenarioInPlace(playerPed, CurrentZone.Animation.AnimationScene, 0, false)
--	else
--		ESX.Streaming.RequestAnimDict(CurrentZone.Animation.AnimationDirect, function()
--			TaskPlayAnim(GetPlayerPed(-1), CurrentZone.Animation.AnimationDirect, CurrentZone.Animation.AnimationScene, 8.0, -8.0, -1, 0, 0, false, false, false)
--		end)
--	end
--
--	ClearPedTasks(playerPed)
--
--	if CurrentZone.Prop ~= nil then
--		if ObjectSpawn ~= nil then
--			ESX.Game.DeleteObject(ObjectSpawn)
--		end
--	end
--
--	local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
--	local object = GetClosestObjectOfType(position.x, position.y, position.z, 15.0, GetHashKey("prop_fish_slice_01"), false, false, false)
--	if object ~= 0 then
--		Wait(800)
--		ESX.Game.DeleteObject(object)
--	end
--	Wait(CurrentZone.WaitProcessing)
--	--IsProcessing = false
--end

RegisterNetEvent("cc_process:processDetailUI")
AddEventHandler("cc_process:processDetailUI", function(count,itemDetail)
	if callBackDetail then
		collectUserItems.baseItem = {count = count}
		callBackDetail = false
		if detailProcess and IsProcessing then
			exports.process_ui:showProcessDetail(count,itemDetail)
			oldCount = count
			detailProcess = false
			return
		end
	end

	if not IsProcessing then
		exports.process_ui:hideProcessDetail()
		detailProcess = true
		callBackDetail = true
		return
	end
end)

function collectUserItem(count,itemName,ecoCoreEffect)
	Citizen.CreateThread(function()
		Citizen.Wait(7)
		print("item from sv : ", itemName)
		if collectUserItems.itemName[itemName] == nil then
			print("empty value itemName")
			collectUserItems.itemName[itemName] = {  giveItemName = itemName ,giveCount = count,round = 1,type="basic"}
			collectUserItems.baseItem.count = collectUserItems.baseItem.count - (realItems.Items[1].ItemCount*ecoCoreEffect) -- here to fix
			print(collectUserItems.itemName[itemName].giveItemName)
			print(collectUserItems.itemName[itemName].giveCount)
			print("base item : ", collectUserItems.baseItem.count)
			exports.process_ui:updateProcessDetail(itemName,collectUserItems.itemName[itemName].giveCount,collectUserItems.baseItem.count)
			pcall(function() -- Start Log
				exports['azael_dc-serverlogs']:insertData({
					event = 'ProcessOnGoing',
					content = ('ผู้เล่นกำลังทำ Process'):format(),
				})
			end) -- End Log
			return
		end

		if collectUserItems.itemName[itemName] ~= nil then
			print("not empty value itemName")
			collectUserItems.itemName[itemName].giveCount =  collectUserItems.itemName[itemName].giveCount + count
			collectUserItems.itemName[itemName].round =  collectUserItems.itemName[itemName].round + 1
			collectUserItems.baseItem.count = collectUserItems.baseItem.count - (realItems.Items[1].ItemCount*ecoCoreEffect) -- here to fix
			print("base item : ", collectUserItems.baseItem.count)
			print(collectUserItems.itemName[itemName].giveItemName)
			print(collectUserItems.itemName[itemName].giveCount)
			exports.process_ui:updateProcessDetail(itemName,collectUserItems.itemName[itemName].giveCount,collectUserItems.baseItem.count)
			return
		end
	end)
end

-- สร้างโพลเสส
Citizen.CreateThread(function()
	-- for _,v in pairs(Config.ProcessingZone) do
	-- 	if(v.Blips.Blipopen == true) then
	-- 		v.blip = AddBlipForCoord(v.Marker.Pos.x, v.Marker.Pos.y,  v.Marker.Pos.z)
	-- 		SetBlipSprite(v.blip, v.Blips.Id)
	-- 		SetBlipDisplay(v.blip, 4)
	-- 		SetBlipScale(v.blip, v.Blips.Size)
	-- 		SetBlipAsShortRange(v.blip, true)
	-- 		BeginTextCommandSetBlipName("STRING")
	-- 		AddTextComponentString(v.Blips.Text)
	-- 		EndTextCommandSetBlipName(v.blip)
	-- 	end
	-- end

	while true do
		Citizen.Wait(0)
		local coords = GetPlayerCoordsAsync()
		local playerPed = PlayerPedId()
		local canSleep = true
		for k,v in pairs(Config.ProcessingZone) do
			if(v.Marker.Type ~= 2 and GetDistanceBetweenCoords(coords, v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z, true) < 3) and not IsPedInAnyVehicle(PlayerPedId(), false) then
				DrawMarker(v.Marker.Type, v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.Size.x, v.Marker.Size.y, v.Marker.Size.z, v.Marker.Color.r, v.Marker.Color.g, v.Marker.Color.b, v.Marker.Color.a, 1,0, 0,1)
				canSleep = false
			end
		end

		for k,v in pairs(Config.ProcessingZone) do
			if(GetDistanceBetweenCoords(coords, v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z, true) < 3) and not IsPedInAnyVehicle(PlayerPedId(), false) then
				IsInMarkerProcess  = true
				ongoingProcess = true
				posx = v.Marker.Pos.x
				posy = v.Marker.Pos.y
				posz = v.Marker.Pos.z
				sizemark = v.Marker.SizeMark
				CurrentZone = v
				realItems = v
				WaitingTime = v.WaitProcessing
			end
		end

		if IsInMarkerProcess and IsPedOnFoot(playerPed) and not IsProcessing and not IsOpenMenu and not IsDead and not IsPedInAnyVehicle(PlayerPedId(), false) then
			if helpNotify then
				exports.helpnotify:showHelpNotification("กด","E","เพื่อแปรรูป")
				helpNotify = false
				for zoneName,v in pairs(Config.ProcessingZone) do -- For Log Purpose
					if(GetDistanceBetweenCoords(coords, v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z, true) < 3) and not IsPedInAnyVehicle(PlayerPedId(), false) then
						pcall(function() -- Start Log 
							exports['azael_dc-serverlogs']:insertData({
							event = 'InProcessZone',
							content = ('ผู้เล่นได้เข้า Zone Process ที่ %s'):format(zoneName),
							})
						end) -- End Log
					end
				end	-- End Log
			end

			
			if IsControlJustPressed(0, Config.Key['E']) then
				-- FreezeEntityPosition(PlayerPedId(), true)
				-- IsOpenMenu = true
				-- IsProcessing = true
				ESX.TriggerServerCallback('cc_processing:checkItemCount', function(stateProcess)
					if not stateProcess then
						--onNoItemToProcess() --
						return
					end
					if exports.Dv_Hunter_Check:CheckPolice(CurrentZone.PoliceCount) or CurrentZone.PoliceCount == 0 then
						FreezeEntityPosition(PlayerPedId(), true)
						IsOpenMenu = true
						IsProcessing = true
						helpNotify = true
						giveitem(CurrentZone,posx,posy,posz,sizemark)
						Citizen.Wait(WaitingTime)
						pcall(function() -- Start Log
							exports['azael_dc-serverlogs']:insertData({
								event = 'ProcessStart',
								content = ('ผู้เล่นได้ทำการกด E เพื่อเริ่มทำ Process'):format(),
							})
						end) -- End Log
					else
						IsProcessing = false
						IsOpenMenu = false
						onNotEnoughPolice()
					end
				end,CurrentZone)
			end
		end
		if canSleep then
			if CurrentZone ~= nil then
				exports.helpnotify:hideHelpNotification()
			end
			IsInMarkerProcess = false
			ongoingProcess = false
			CurrentZone = nil
			realItems = nil
			helpNotify = true
			Wait(500)
		end
	end
end)

AddEventHandler('playerSpawned', function(spawn)
	IsDead = false
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	IsDead = true
	auto = false
	workon = false
	helpNotify = true
	IsOpenMenu = false
	detailProcess = true
	callBackDetail = true
	FreezeEntityPosition(PlayerPedId(),false)
	exports.helpnotify:hideHelpNotification()
	exports.process_ui:hideProcessDetail()
	if IsProcessing then
		doneProcess()
		TriggerEvent("mythic_progbar:client:cancel")
	end
	IsProcessing = false
end)

RegisterNetEvent("cc_process:animation")
AddEventHandler("cc_process:animation", function(animation)
	IsProcessing = true
	local playerPed = PlayerPedId()
	TaskStartScenarioInPlace(playerPed, animation, false, false)
	Citizen.Wait(1000)
	--IsProcessing = false
	ClearPedTasks(playerPed)
end)

function giveitem(CurrentZone,posx,posy,posz,sizemark)
	Zone = CurrentZone
	Posx = posx
	Posy = posy
	Posz = posz
	Sizemark = sizemark
	if Zone.Items.auto then
		workon = true
		auto = true
		ESX.TriggerServerCallback('cc_processing:checkCard', function(calculateProtime)
			--print(calculateProtime)
			TriggerEvent("mythic_progbar:client:progress",{
				name = "unique_action_name",
				duration = calculateProtime,
				label = CurrentZone.Text.ProcessText,
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = CurrentZone.Animation.AnimationDirect,
					anim = CurrentZone.Animation.AnimationScene,
					flags = CurrentZone.Animation.flags,
				},
			}
			, function(status)
						if not status then
							TriggerServerEvent('cc_process:process',Zone.Items,collectUserItems,oldCount)
						end
					end)
		end, CurrentZone)
	else
		workon = true
		--Animation(Zone)
		ESX.TriggerServerCallback('cc_processing:checkCard', function(calculateProtime)
			--print(calculateProtime)
			TriggerEvent("mythic_progbar:client:progress",{
				name = "unique_action_name",
				duration = calculateProtime,
				label = CurrentZone.Text.ProcessText,
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = CurrentZone.Animation.AnimationDirect,
					anim = CurrentZone.Animation.AnimationScene,
					flags = CurrentZone.Animation.flags,
				},
			}
			, function(status)
						if not status then
							TriggerServerEvent('cc_process:process',Zone.Items,collectUserItems,oldCount)
						end
					end)
		end, CurrentZone)
	end
end

function autoProcess(CurrentZone)
	ESX.TriggerServerCallback('cc_processing:checkCard', function(calculateProtime)
		--print(calculateProtime)
		TriggerEvent("mythic_progbar:client:progress",{
			name = "unique_action_name",
			duration = calculateProtime,
			label = CurrentZone.Text.ProcessText,
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {
				animDict = CurrentZone.Animation.AnimationDirect,
				anim = CurrentZone.Animation.AnimationScene,
				flags = CurrentZone.Animation.flags,
			},
		}, function(status)
			if not status then
				TriggerServerEvent('cc_process:process',Zone.Items,collectUserItems,oldCount)
			end
		end)
	end, CurrentZone)
end

RegisterNetEvent("cc_process:giveBonusItems")
AddEventHandler("cc_process:giveBonusItems", function(itemName,count)
	Citizen.CreateThread(function()
		Citizen.Wait(7)
		print("item from sv : ", itemName)
		if collectUserItems.itemName[itemName] == nil then
			print("empty value itemName")
			collectUserItems.itemName[itemName] = {  giveItemName = itemName ,giveCount = count,round = 1,type="bonus"}
			print(collectUserItems.itemName[itemName].giveItemName)
			print(collectUserItems.itemName[itemName].giveCount)
			exports.process_ui:updateProcessDetail(itemName,collectUserItems.itemName[itemName].giveCount)
			return
		end

		if collectUserItems.itemName[itemName] ~= nil then
			print("not empty value itemName")
			collectUserItems.itemName[itemName].giveCount =  collectUserItems.itemName[itemName].giveCount + count
			print(collectUserItems.itemName[itemName].round)
			print(collectUserItems.itemName[itemName].giveItemName)
			print(collectUserItems.itemName[itemName].giveCount)
			exports.process_ui:updateProcessDetail(itemName,collectUserItems.itemName[itemName].giveCount)
			return
		end
	end)
end)


RegisterNetEvent("cc_process:doneProcess")
AddEventHandler("cc_process:doneProcess", function()
	--print("done process")
	--TriggerServerEvent('cc_process:doneProcess',collectUserItems.itemName,Zone.Items,oldCount)
	collectUserItems = {
		itemName = {},
		baseItem = {}
	}
end)
--it's a bad idea because i dont know how to use trigger become func in LUA sry :(
function doneProcess()
	TriggerServerEvent('cc_process:doneProcess')
	collectUserItems = {
		itemName = {},
		baseItem = {}
	}
end


-- use after setting auto = true
RegisterNetEvent("cc_process:auto")
AddEventHandler("cc_process:auto", function(count,itemName,ecoCoreEffect)
	auto = true
	Citizen.Wait(7)

	if (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Posx, Posy, Posz, true) < Sizemark) then
		if workon then
			collectUserItem(count,itemName,ecoCoreEffect)
			autoProcess(Zone)
		end
	else
		onOutOfZone()
		auto = false
		workon = false
		IsOpenMenu = false
		IsProcessing = false
		helpNotify = true
		IsOpenMenu = false
		IsProcessing = false
		detailProcess = true
		callBackDetail = true
		FreezeEntityPosition(PlayerPedId(),false)
		exports.process_ui:hideProcessDetail()
		exports.helpnotify:hideHelpNotification()
		doneProcess()
		pcall(function() -- Start Log
			exports['azael_dc-serverlogs']:insertData({
				event = 'ProcessFailOutOfRange',
				content = ('ผู้เล่นได้พยายาม Process แต่อยู่นอกจุด Process'),
			})
		end) -- End Log
	end
end)

Citizen.CreateThread(function()
	while true do
		::reCheck::
		Citizen.Wait(0)
		if not ongoingProcess then
			Citizen.Wait(1500)
			goto reCheck
		end

		if ongoingProcess and not IsDead then
			local playerPed = PlayerPedId()

				if helpNotify and IsProcessing then
					exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
					helpNotify = false
				end

			if IsProcessing then
				DisableControlAction(0,Config.Key['G'], true)
				DisableControlAction(0, Config.Key['T'], true)
				DisableControlAction(0, Config.Key['E'], true)
				EnableControlAction(0, Config.Key['X'], true)
				DisableControlAction(0, Config.Key['DELETE'], true)
				DisableControlAction(0, Config.Key['F2'], true)
			end

			if IsControlJustPressed(0,73) and IsProcessing then
				exports.process_ui:hideProcessDetail()
				exports.helpnotify:hideHelpNotification()
				TriggerEvent("mythic_progbar:client:cancel")
				FreezeEntityPosition(playerPed,false)
				Wait(100)
				auto = false
				workon = false
				helpNotify = true
				IsOpenMenu = false
				IsProcessing = false
				detailProcess = true
				callBackDetail = true
				doneProcess() 						
				pcall(function() -- Start Log
					exports['azael_dc-serverlogs']:insertData({
						event = 'ProcessCancel',
						content = ('ผู้เล่นได้ทำการกด x ยกเลิกการทำ Process'),
					})
				end) -- End Log		
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)
		local playerPed = PlayerPedId()
		if IsInMarkerProcess and IsPedOnFoot(playerPed) and realItems ~= nil and callBackDetail then
			TriggerServerEvent('cc_process:checkItem',realItems)
			Citizen.Wait(1500)
		end
	end
end)


RegisterNetEvent("cc_process:autofalse")
AddEventHandler("cc_process:autofalse", function()
	IsProcessing = false
	auto = false
	workon = false
	helpNotify = true
	IsOpenMenu = false
	IsProcessing = false
	detailProcess = true
	callBackDetail = true
	collectUserItems = {
		itemName = {},
		baseItem = {}
	}
	FreezeEntityPosition(PlayerPedId(),false)
	exports.helpnotify:hideHelpNotification()
	exports.process_ui:hideProcessDetail()
end)


function GetPlayerCoordsAsync()
	return Citizen.InvokeNative(0x3FEF770D40960D5A, PlayerPedId(), Citizen.ReturnResultAnyway(), Citizen.ResultAsVector())
end


function onNotEnoughPolice()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบ Process', -- หัวเรื่อง
        description = 'จำนวนตำรวจไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_cop', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function onNoItemToProcess()
	exports.nc_notify:PushNotification({
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

function onOutOfZone()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบ Process', -- หัวเรื่อง
        description = 'คุณอยู่นอกพื้นที่', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_area', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end