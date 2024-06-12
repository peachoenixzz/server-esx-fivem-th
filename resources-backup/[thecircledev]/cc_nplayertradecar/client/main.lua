--ESX = nil
--
--Citizen.CreateThread(function()
--    while ESX == nil do
--        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--        Citizen.Wait(0)
--    end
--    Citizen.Wait(100)
--end)
Config = {}
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true
local position = vector3(171.07000732421875, -993.4500122070312, 29.09000015258789)
local NumberCharset = {}
local Charset = {}
local helpNotify = true
local HasAlreadyEnteredMarker = false

local skinData = {
	["chain_2"] = 0,
	["glasses_2"] = 1,
	["shoes_2"] = 0,
	["face"] = 5,
	["eyebrows_3"] = 0,
	["beard_4"] = 0,
	["beard_1"] = 10,
	["bags_2"] = 0,
	["chest_3"] = 0,
	["arms_2"] = 0,
	["glasses_1"] = 21,
	["moles_1"] = 0,
	["shoes_1"] = 19,
	["chest_1"] = 0,
	["eyebrows_1"] = 0,
	["makeup_4"] = 0,
	["beard_2"] = 9,
	["watches_2"] = 0,
	["eye_color"] = 0,
	["helmet_2"] = 0,
	["age_2"] = 0,
	["eyebrows_2"] = 0,
	["hair_color_2"] = 0,
	["mask_2"] = 0,
	["makeup_2"] = 0,
	["chain_1"] = 0,
	["pants_1"] = 16,
	["blush_1"] = 0,
	["bags_1"] = 0,
	["bproof_1"] = 0,
	["lipstick_4"] = 0,
	["lipstick_3"] = 53,
	["hair_1"] = 15,
	["bracelets_2"] = 0,
	["blush_2"] = 0,
	["eyebrows_4"] = 0,
	["bproof_2"] = 0,
	["skin"] = 0,
	["watches_1"] = -1,
	["torso_1"] = 16,
	["helmet_1"] = -1,
	["lipstick_1"] = 0,
	["ears_2"] = 0,
	["bracelets_1"] = -1,
	["ears_1"] = 5,
	["decals_2"] = 0,
	["mask_1"] = 0,
	["age_1"] = 0,
	["arms"] = 4,
	["makeup_3"] = 0,
	["hair_color_1"] = 0,
	["tshirt_2"] = 0,
	["blush_3"] = 0,
	["hair_2"] = 0,
	["decals_1"] = 0,
	["moles_2"] = 0,
	["lipstick_2"] = 0,
	["makeup_1"] = 0,
	["tshirt_1"] = 19,
	["complexion_1"] = 0,
	["pants_2"] = 1,
	["torso_2"] = 0,
	["chest_2"] = 0,
	["beard_3"] = 0,
	["complexion_2"] = 0,
}
--==========================================================================================================================================================================================
--===================================================================================sell bodybag npc=======================================================================================
--==========================================================================================================================================================================================

local fontId
Citizen.CreateThread(function()
	RegisterFontFile('font4thai') -- the name of your .gfx, without .gfx
	fontId = RegisterFontId('font4thai') -- the name from the .xml
end)

function DrawText3D(x,y,z, text,mul)
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
	local npcnplayertradecarHash = GetHashKey("mp_m_freemode_01")
	RequestModel(npcnplayertradecarHash)
	while not HasModelLoaded(npcnplayertradecarHash) do
		Wait(1)
	end

	local npcnplayertradeCar = CreatePed(4, npcnplayertradecarHash, 171.22000122070312, -993.52001953125, 29.09000015258789, 66.8, false, false)
	SetEntityAsMissionEntity(npcnplayertradeCar, true, true)
	SetBlockingOfNonTemporaryEvents(npcnplayertradeCar, true)
	FreezeEntityPosition(npcnplayertradeCar, true)
	SetEntityInvincible(npcnplayertradeCar, true)
	ApplyCustomAppearance(npcnplayertradeCar, skinData)
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
	SetPedPropIndex(ped, 1, data["glasses_1"], 0, true) -- glasses
	SetPedPropIndex(ped, 2, data["ear_accessories"], data["ear_accessories_2"], true) -- ear accessories
	SetPedPropIndex(ped, 6, data["watches_1"], data["watches_2"], true) -- watches
	SetPedPropIndex(ped, 7, data["bracelets_1"], data["bracelets_2"], true) -- bracelets
	--SetPedComponentVariation(ped, 1, 54, 0 / 10)
end


function handleSelectUI()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'card_menu',
			{
				title    = '',
				align    = 'top-right',
				elements = {
					{ label = 'แลกรถ',	value = 'beginner_vehicle'},
				}
			},
			function(data, menu)
				local selectedAction = data.current.value
				if selectedAction == "beginner_vehicle" then
					local newPlate = GeneratePlate()
					ESX.TriggerServerCallback('cc_nplayertradecar:beginner_vehicle', function(status)
						if status then
							menu.close()
						end
						--TODO
					end,newPlate)
				end
			end,
			function(data, menu)
				menu.close()
				pcall(function() -- Start Log
					exports['azael_dc-serverlogs']:insertData({
						event = 'CloseTradeCarMenu',
						content = ('ผู้เล่นได้ทำการปิดเมนูแลกการ์ด'):format(),
					})
				end) -- End Log
			end
	)
end


Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local isInMarker  = false
		local coords = GetEntityCoords(PlayerPedId())
		if(GetDistanceBetweenCoords(coords, position.x, position.y, position.z, true) < 20) then
			DrawText3D(position.x,position.y,position.z + 2.1,"~w~ จุดแลกรถผู้เล่นใหม่", 2.0)
			sleep = 0
		end
		if(GetDistanceBetweenCoords(coords, position.x, position.y, position.z, true) < 3) then
			if helpNotify  then
				exports.helpnotify:showHelpNotification("กด","E","เพื่อแลกการ์ด")
				helpNotify = false
			end
			if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
				handleSelectUI()
				pcall(function() -- Start Log
					exports['azael_dc-serverlogs']:insertData({
						event = 'OpenTradeCarMenu',
						content = ('ผู้เล่นได้ทำการกด E เพื่อเปิดเมนูแลกการ์ด'):format(),
					})
				end) -- End Log
			end
			isInMarker  = true
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


for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	math.randomseed(GetGameTimer())

	local generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. (Config.PlateUseSpace and ' ' or '') .. GetRandomNumber(Config.PlateNumbers))
	print("generate here")
	local isTaken = IsPlateTaken(generatedPlate)
	if isTaken then
		return GeneratePlate()
	end

	return generatedPlate
end

-- mixing async with sync tasks
function IsPlateTaken(plate)
	local p = promise.new()

	ESX.TriggerServerCallback('esx_vehicleshop:isPlateTaken', function(isPlateTaken)
		p:resolve(isPlateTaken)
	end, plate)

	return Citizen.Await(p)
end

function GetRandomNumber(length)
	Wait(0)
	return length > 0 and GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)] or ''
end

function GetRandomLetter(length)
	Wait(0)
	return length > 0 and GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)] or ''
end
