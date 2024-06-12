--ESX = nil
--
--Citizen.CreateThread(function()
--    while ESX == nil do
--        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--        Citizen.Wait(0)
--    end
--    Citizen.Wait(100)
--end)
local positions = {
	[2] = { position = vector3(1818.3599853515625, 3672.8701171875, 33.29000091552734), heading = 299.77 },
	[1] = { position = vector3(357.2099914550781, -1381.449951171875, 31.5099983215332), heading = 229.8 },
}

local inProgress = false
local helpNotify = true
local HasAlreadyEnteredMarker = false
local skinData = {
	["lipstick_3"] = 33,
	["eye_color"] = 6,
	["glasses_2"] = 3,
	["chest_3"] = 0,
	["lipstick_4"] = 63,
	["moles_2"] = 0,
	["ears_2"] = 2,
	["ears_1"] = 13,
	["complexion_2"] = 0,
	["hair_1"] = 218,
	["pants_1"] = 17,
	["tshirt_2"] = 0,
	["bags_2"] = 2,
	["beard_3"] = 0,
	["blush_1"] = 0,
	["shoes_2"] = 3,
	["moles_1"] = 0,
	["decals_2"] = 0,
	["chest_2"] = 0,
	["blush_2"] = 6,
	["helmet_1"] = -1,
	["torso_1"] = 20,
	["beard_2"] = 0,
	["bproof_2"] = 7,
	["skin"] = 45,
	["helmet_2"] = 0,
	["torso_2"] = 0,
	["watches_2"] = 0,
	["hair_color_2"] = 12,
	["watches_1"] = -1,
	["pants_2"] = 0,
	["mask_2"] = 0,
	["makeup_1"] = 0,
	["lipstick_2"] = 2,
	["lipstick_1"] = 3,
	["sex"] = 1,
	["bracelets_2"] = 0,
	["eyebrows_3"] = 63,
	["beard_4"] = 0,
	["hair_2"] = 0,
	["chain_1"] = 0,
	["arms_2"] = 0,
	["arms"] = 16,
	["makeup_3"] = 0,
	["mask_1"] = 0,
	["age_2"] = 0,
	["eyebrows_1"] = 30,
	["chest_1"] = 4,
	["chain_2"] = 0,
	["complexion_1"] = 11,
	["bproof_1"] = 196,
	["glasses_1"] = 2,
	["bags_1"] = 33,
	["eyebrows_4"] = 63,
	["eyebrows_2"] = 10,
	["decals_1"] = 0,
	["face"] = 40,
	["blush_3"] = 25,
	["makeup_2"] = 0,
	["age_1"] = 0,
	["makeup_4"] = 0,
	["bracelets_1"] = -1,
	["shoes_1"] = 35,
	["beard_1"] = 0,
	["hair_color_1"] = 15,
	["tshirt_1"] = 15,
}
--==========================================================================================================================================================================================
--===================================================================================sell bodybag npc=======================================================================================
--==========================================================================================================================================================================================
local fontId
Citizen.CreateThread(function()
	RegisterFontFile('font4thai') -- the name of your .gfx, without .gfx
	fontId = RegisterFontId('font4thai') -- the name from the .xml
end)


function DrawText3Ds(x,y,z, text,mul)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
	local scale = (1/dist)*2
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov *mul
	if onScreen then
		SetTextScale(0.0*scale, 0.55*scale)
		SetTextFont(fontId)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end


Citizen.CreateThread(function()
	local npcnplayertradecarHash = GetHashKey("mp_f_freemode_01")
	RequestModel(npcnplayertradecarHash)
	while not HasModelLoaded(npcnplayertradecarHash) do
		Wait(1)
	end
	for _,v in pairs(positions)  do
		local npcnplayertradeCar = CreatePed(4, npcnplayertradecarHash, v.position.x, v.position.y, v.position.z, v.heading, false, true)
		SetEntityAsMissionEntity(npcnplayertradeCar, true, true)
		SetBlockingOfNonTemporaryEvents(npcnplayertradeCar, true)
		FreezeEntityPosition(npcnplayertradeCar, true)
		SetEntityInvincible(npcnplayertradeCar, true)
		ApplyCustomAppearance(npcnplayertradeCar, skinData)
	end
end)

function ApplyCustomAppearance(ped, data)
	SetPedHeadBlendData(ped,
			data["face"],
			data["face"],
			data["face"],
			data["skin"],
			data["skin"],
			data["skin"],
			data["shape_mix"],
			data["skin_mix"],
			data["skin_mix"],
			true
	)

	SetPedHeadOverlay(ped, 1, data["beard_1"], data["beard_2"] / 10) -- beard
	SetPedHeadOverlay(ped, 2, data["eyebrows_1"], data["eyebrows_2"] / 10) -- eyebrows
	SetPedHeadOverlay(ped, 3, data["age_1"], data["age_2"] / 10) -- age
	SetPedHeadOverlay(ped, 4, data["makeup_1"], data["makeup_2"] / 10) -- makeup
	SetPedHeadOverlay(ped, 5, data["blush_1"], data["blush_2"] / 10) -- blush
	SetPedHeadOverlay(ped, 6, data["complexion_1"], data["complexion_2"] / 10) -- complexion
	--SetPedHeadOverlay(ped, 7, data["sun_damage_1"], data["sun_damage_2"] / 10) -- sun damage
	SetPedHeadOverlay(ped, 8, data["lipstick_1"], 1/10) -- lipstick
	SetPedHeadOverlay(ped, 9, data["moles_1"], data["moles_2"] / 10) -- moles
	--SetPedHeadOverlay(ped, 10, data["chest_hair_1"], data["chest_hair_2"] / 10) -- chest hair
	--SetPedHeadOverlay(ped, 11, data["body_blemishes_1"], data["body_blemishes_2"] / 10) -- body blemishes

	SetPedHeadOverlayColor(ped, 1, 1, data["beard_color"], data["beard_color"])
	SetPedHeadOverlayColor(ped, 2, 1, data["eyebrows_color"], data["eyebrows_color"])
	SetPedHeadOverlayColor(ped, 4, 2, data["makeup_color"], data["makeup_color"])
	SetPedHeadOverlayColor(ped, 5, 2, data["blush_color"], data["blush_color"])
	SetPedHeadOverlayColor(ped, 6, 0, data["complexion_color"], data["complexion_color"])
	SetPedHeadOverlayColor(ped, 8, 2, data["lipstick_color"], data["lipstick_color"])
	SetPedHeadOverlayColor(ped, 10, 0, data["chest_hair_color"], data["chest_hair_color"])
	SetPedHeadOverlayColor(ped, 11, 0, data["body_blemishes_color"], data["body_blemishes_color"])

	SetPedComponentVariation(ped, 2, data["hair_1"], data["hair_2"], 2) -- hair style
	SetPedHairColor(ped, data["hair_color_1"], data["hair_color_2"]) -- hair color

	SetPedComponentVariation(ped, 10, data["decals_1"], data["decals_2"], 2) -- decals

	SetPedComponentVariation(ped, 3, data["arms"], data["arms_2"], 2) -- arms
	SetPedComponentVariation(ped, 4, data["pants_1"], data["pants_2"], 2) -- pants
	SetPedComponentVariation(ped, 6, data["shoes_1"], data["shoes_2"], 2) -- shoes
	SetPedComponentVariation(ped, 7, data["shirt"], data["shirt_2"], 2) -- shirt
	--SetPedComponentVariation(ped, 8, data["undershirt"], data["undershirt_2"], 2) -- undershirt
	SetPedComponentVariation(ped, 11, data["torso_1"], data["torso_2"], 2) -- torso
	SetPedComponentVariation(ped, 8, data["tshirt_1"], 0, 2) -- t-shirt


	SetPedPropIndex(ped, 0, -1, 0, true) -- hat
	SetPedPropIndex(ped, 1, data["glasses_1"], 3, true) -- glasses
	SetPedPropIndex(ped, 2, data["ear_accessories"], data["ear_accessories_2"], true) -- ear accessories
	SetPedPropIndex(ped, 6, data["watches_1"], data["watches_2"], true) -- watches
	SetPedPropIndex(ped, 7, data["bracelets_1"], data["bracelets_2"], true) -- bracelets
	--SetPedComponentVariation(ped, 1, 54, 0 / 10)
end


function handleSelectUI()
	if inProgress then
		exports.nc_notify:PushNotification({
			scale = 1.0, -- ปรับขนาดของ Notify
			title = 'ระบบหมอขี้เกียจ', -- หัวเรื่อง
			description = 'คุณรับแบบแผนการรักษาไปแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			icon = 'money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			duration = 5000 -- ระยะเวลาการแสดง Notify
		})
		return
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'heal_ambulance_menu',
			{
				title    = 'Auto Healthy',
				align    = 'top-right',
				elements = {
					-- { label = 'รักษาพิเศษ (400$)',	value = 'all_in_one'},
					-- { label = 'รักษาสุขภาพ (100$)',	value = 'healthy'},
					{ label = 'รักษาเลือด (200$)',	value = 'healpoint'},
				}
			},
			function(data, menu)
				local selectedAction = data.current.value
				-- if selectedAction == "all_in_one" then
				-- 	ESX.TriggerServerCallback('cc_npcheal:autoHeal', function(status, choice)
				-- 		if status then
				-- 			processAutoHeal(choice)
				-- 			menu.close()
				-- 		end
				-- 		--TODO
				-- 	end,"all_in_one")
				-- end
				-- if selectedAction == "healthy" then
				-- 	ESX.TriggerServerCallback('cc_npcheal:autoHeal', function(status, choice)
				-- 		if status then
				-- 			processAutoHeal(choice)
				-- 			menu.close()
				-- 		end
				-- 		--TODO
				-- 	end,"healthy")
				-- end
				if selectedAction == "healpoint" then
					ESX.TriggerServerCallback('cc_npcheal:autoHeal', function(status, choice)
						if status then
							processAutoHeal(choice)
							menu.close()
						end
						--TODO
					end,"healpoint")
				end
			end,
			function(data, menu)
				menu.close()
			end
	)
end

function processAutoHeal(choice)
	inProgress = true
	TriggerEvent("mythic_progbar:client:progress", {
		name = "autoHeal",
		duration = 90000,
		label = "กำลังรักษาสุขภาพ..",
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},
		animation = {
			animDict = "rcmfanatic1maryann_stretchidle_b",
			anim = "idle_e",
			flags = 8,
		},
	}, function(status)
		if not status then
			inProgress = false
			if choice == "healpoint" then
				local Ped = PlayerPedId()
				SetEntityHealth(Ped, 200)
				exports.nc_notify:PushNotification({
					scale = 1.0, -- ปรับขนาดของ Notify
					title = 'ระบบหมอขี้เกียจ', -- หัวเรื่อง
					description = 'รักษาสำเร็จ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
					type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
					position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
					direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
					priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
					icon = 'money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
					duration = 5000 -- ระยะเวลาการแสดง Notify
				})
			end
			-- if choice == "healthy" then
			-- 	TriggerEvent("esx_status:add" ,  "thirst" , 3000000)
			-- 	exports.nc_notify:PushNotification({
			-- 		scale = 1.0, -- ปรับขนาดของ Notify
			-- 		title = 'ระบบหมอขี้เกียจ', -- หัวเรื่อง
			-- 		description = 'รักษาสำเร็จ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			-- 		type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			-- 		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			-- 		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			-- 		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			-- 		icon = 'money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			-- 		duration = 5000 -- ระยะเวลาการแสดง Notify
			-- 	})
			-- end
			-- if choice == "all_in_one" then
			-- 	local Ped = PlayerPedId()
			-- 	SetEntityHealth(Ped, 200)
			-- 	TriggerEvent("esx_status:add" ,  "thirst" , 3000000)
			-- 	exports.nc_notify:PushNotification({
			-- 		scale = 1.0, -- ปรับขนาดของ Notify
			-- 		title = 'ระบบหมอขี้เกียจ', -- หัวเรื่อง
			-- 		description = 'รักษาสำเร็จ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
			-- 		type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
			-- 		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
			-- 		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
			-- 		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
			-- 		icon = 'money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
			-- 		duration = 5000 -- ระยะเวลาการแสดง Notify
			-- 	})
			-- end
		end
		inProgress = false
	end)

end

Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local isInMarker  = false
		local coords = GetEntityCoords(PlayerPedId())
		for _,v in pairs(positions) do
			if(GetDistanceBetweenCoords(coords, v.position.x, v.position.y, v.position.z, true) < 7) then
				DrawText3Ds(v.position.x,v.position.y,v.position.z + 2,"~w~ กด ~y~[E]~w~ เพื่อยาใจกับน้องเทียนเทียน", 1.3)
				sleep = 0
			end
			if(GetDistanceBetweenCoords(coords,v.position.x, v.position.y, v.position.z, true) < 3) then
				if helpNotify then
					exports.helpnotify:showHelpNotification("กด","E","เพื่อทำการรักษา")
					helpNotify = false
				end
				if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
					handleSelectUI()
				end
				isInMarker  = true
			end
		end
			if isInMarker and not HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = true
			end
			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				exports.helpnotify:hideHelpNotification()
				helpNotify = true
			end
		Citizen.Wait(sleep)
	end
end)