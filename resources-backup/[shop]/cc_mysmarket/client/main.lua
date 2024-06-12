local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local isDead = false
function showCashShopMenu()
	local tokenAuth = exports.cc_authlogin:tokenCollect()
	SendNUIMessage({
		action = "openCashShop",
		data = { ["auth"] = tokenAuth },
	})
	Wait(100)
	SendNUIMessage({
		action = "setVisible",
		data = true,
	})
	SetNuiFocus(true, true)
end

function closeUI()
	SetNuiFocus(false, false)
	SendNUIMessage({
		action = "setVisible",
		data = false,
	})
end


RegisterNUICallback('hideFrame', function()
	closeUI()
end)

--local npcPed = nil
--local skinData = {
--    ["hair_1"] = 3,
--    ["glasses_2"] = 6,
--    ["arms_2"] = 0,
--    ["makeup_1"] = 0,
--    ["tshirt_2"] = 0,
--    ["ears_2"] = 4,
--    ["watches_2"] = 0,
--    ["blush_2"] = 0,
--    ["chain_2"] = 0,
--    ["torso_1"] = 365,
--    ["chest_3"] = 0,
--    ["helmet_2"] = 0,
--    ["lipstick_1"] = 0,
--    ["hair_color_1"] = 35,
--    ["eyebrows_3"] = 0,
--    ["skin"] = 0,
--    ["beard_4"] = 0,
--    ["decals_2"] = 0,
--    ["helmet_1"] = 83,
--    ["complexion_1"] = 0,
--    ["age_2"] = 0,
--    ["bproof_1"] = 0,
--    ["beard_2"] = 6,
--    ["chest_2"] = 0,
--    ["bags_2"] = 0,
--    ["chest_1"] = 0,
--    ["tshirt_1"] = 15,
--    ["moles_2"] = 0,
--    ["blush_1"] = 0,
--    ["decals_1"] = 0,
--    ["makeup_2"] = 0,
--    ["glasses_1"] = 69,
--    ["lipstick_3"] = 0,
--    ["complexion_2"] = 0,
--    ["eye_color"] = 0,
--    ["pants_1"] = 35,
--    ["bracelets_1"] = -1,
--    ["makeup_3"] = 0,
--    ["makeup_4"] = 0,
--    ["beard_3"] = 0,
--    ["chain_1"] = 32,
--    ["shoes_1"] = 12,
--    ["arms"] = 20,
--    ["bproof_2"] = 0,
--    ["sex"] = 0,
--    ["mask_1"] = -1,
--    ["age_1"] = 0,
--    ["blush_3"] = 0,
--    ["eyebrows_1"] = 0,
--    ["beard_1"] = 10,
--    ["hair_2"] = 0,
--    ["ears_1"] = 22,
--    ["mask_2"] = 0,
--    ["face"] = 22,
--    ["torso_2"] = 1,
--    ["watches_1"] = 16,
--    ["eyebrows_2"] = 0,
--    ["hair_color_2"] = 0,
--    ["shoes_2"] = 6,
--    ["bracelets_2"] = 0,
--    ["eyebrows_4"] = 0,
--    ["moles_1"] = 0,
--    ["lipstick_2"] = 0,
--    ["bags_1"] = 66,
--    ["lipstick_4"] = 0,
--    ["pants_2"] = 3
--}
--
--
--Citizen.CreateThread(function()
--    local npcHash = GetHashKey("mp_m_freemode_01") -- NPC model (can be any valid ped model)
--    RequestModel(npcHash)
--    while not HasModelLoaded(npcHash) do
--        Wait(1)
--    end
--    npcPed = CreatePed(4, npcHash,  -406.6499938964844, 1096.93994140625, 326.80999755859375, 165.89, false, true)
--    SetEntityAsMissionEntity(npcPed, true, true)
--    SetBlockingOfNonTemporaryEvents(npcPed, true)
--    PlaceObjectOnGroundProperly(npcPed)
--    FreezeEntityPosition(npcPed, true)
--    SetEntityInvincible(npcPed, true)
--    --TaskPlayAnim(npcPed,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
--    -- Apply appearance changes from ESX data
--    ApplyCustomAppearance(npcPed, skinData)
--end)
--
--function ApplyCustomAppearance(ped, data)
--    SetPedHeadBlendData(ped,
--            data["face"],
--            data["face"],
--            data["face"],
--            data["skin"],
--            data["skin"],
--            data["skin"],
--            data["shape_mix"],
--            data["skin_mix"],
--            data["skin_mix"],
--            true
--    )
--
--    SetPedHeadOverlay(ped, 1, data["beard_1"], data["beard_2"] / 10) -- beard
--    SetPedHeadOverlay(ped, 2, data["eyebrows_1"], data["eyebrows_2"] / 10) -- eyebrows
--    SetPedHeadOverlay(ped, 3, data["age_1"], data["age_2"] / 10) -- age
--    SetPedHeadOverlay(ped, 4, data["makeup_1"], data["makeup_2"] / 10) -- makeup
--    SetPedHeadOverlay(ped, 5, data["blush_1"], data["blush_2"] / 10) -- blush
--    SetPedHeadOverlay(ped, 6, data["complexion_1"], data["complexion_2"] / 10) -- complexion
--    --SetPedHeadOverlay(ped, 7, data["sun_damage_1"], data["sun_damage_2"] / 10) -- sun damage
--    SetPedHeadOverlay(ped, 8, data["lipstick_1"], 1/10) -- lipstick
--    SetPedHeadOverlay(ped, 9, data["moles_1"], data["moles_2"] / 10) -- moles
--    --SetPedHeadOverlay(ped, 10, data["chest_hair_1"], data["chest_hair_2"] / 10) -- chest hair
--    --SetPedHeadOverlay(ped, 11, data["body_blemishes_1"], data["body_blemishes_2"] / 10) -- body blemishes
--
--    SetPedHeadOverlayColor(ped, 1, 1, data["beard_color"], data["beard_color"])
--    SetPedHeadOverlayColor(ped, 2, 1, data["eyebrows_color"], data["eyebrows_color"])
--    SetPedHeadOverlayColor(ped, 4, 2, data["makeup_color"], data["makeup_color"])
--    SetPedHeadOverlayColor(ped, 5, 2, data["blush_color"], data["blush_color"])
--    SetPedHeadOverlayColor(ped, 6, 0, data["complexion_color"], data["complexion_color"])
--    SetPedHeadOverlayColor(ped, 8, 2, data["lipstick_color"], data["lipstick_color"])
--    SetPedHeadOverlayColor(ped, 10, 0, data["chest_hair_color"], data["chest_hair_color"])
--    SetPedHeadOverlayColor(ped, 11, 0, data["body_blemishes_color"], data["body_blemishes_color"])
--
--    SetPedComponentVariation(ped, 2, data["hair_1"], data["hair_2"], 2) -- hair style
--    SetPedHairColor(ped, data["hair_color_1"], data["hair_color_2"]) -- hair color
--
--    SetPedComponentVariation(ped, 10, data["decals_1"], data["decals_2"], 2) -- decals
--
--    SetPedComponentVariation(ped, 3, data["arms"], data["arms_2"], 2) -- arms
--    SetPedComponentVariation(ped, 4, data["pants_1"], data["pants_2"], 2) -- pants
--    SetPedComponentVariation(ped, 6, data["shoes_1"], data["shoes_2"], 2) -- shoes
--    SetPedComponentVariation(ped, 7, data["shirt"], data["shirt_2"], 2) -- shirt
--    --SetPedComponentVariation(ped, 8, data["undershirt"], data["undershirt_2"], 2) -- undershirt
--    SetPedComponentVariation(ped, 11, data["torso_1"], data["torso_2"], 2) -- torso
--    SetPedComponentVariation(ped, 8, data["tshirt_1"], 0, 2) -- t-shirt
--
--
--    --SetPedPropIndex(ped, 0, data["hat"], data["hat_2"], true) -- hat
--    --SetPedPropIndex(ped, 1, data["glasses"], data["glasses_2"], true) -- glasses
--    SetPedPropIndex(ped, 2, data["ear_accessories"], data["ear_accessories_2"], true) -- ear accessories
--    SetPedPropIndex(ped, 6, data["watches_1"], data["watches_2"], true) -- watches
--    SetPedPropIndex(ped, 7, data["bracelets_1"], data["bracelets_2"], true) -- bracelets
--    SetPedComponentVariation(ped, 1, 8, 0 / 10) -- mask
--end

--local inzonerecycle = false

--
--local recycleZone = PolyZone:Create({
--	vector3(-407.5400085449219, 1097.9000244140625, 327.80999755859375),
--	vector3(-408.010009765625, 1096.239990234375, 327.6000061035156),
--	vector3(-405.94000244140625, 1095.6300048828125, 327.6000061035156),
--	vector3(-405.3200073242188, 1097.0799560546875, 327.80999755859375),
--},{
--    name = "recycle_zone",
--    debugPoly = false,
--    minZ = 326,
--    maxZ = 330,
--})
--
--recycleZone:onPlayerInOut(function(isPointInside, point)
--    if isPointInside then
--        inzonerecycle = true
--		exports.helpnotify:showHelpNotification("กด","E","เพื่อคุย")
--    else
--        inzonerecycle = false
--		exports.helpnotify:hideHelpNotification()
--    end
--end)


ESX.RegisterInput("circle:mysteryMan", "Mystery Man Circle Hotkey", "keyboard", "F10", function()
	if not isDead then
		showCashShopMenu()
	end
end)


AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
	closeUI()
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)
