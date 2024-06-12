ESX = nil
local ongoingfreeze = false
local nearTeleport = false
local lastStandPoint = nil
local lastStandHeading = nil
local alreadyhasLastStand = false


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
	RegisterFontFile('font4thai') -- the name of your .gfx, without .gfx
    fontId = RegisterFontId('font4thai') -- the name from the .xml
end)

local playerInArea = {}
local skinData = {
	["chain_2"] = 1,
	["glasses_2"] = 0,
	["shoes_2"] = 3,
	["face"] = 31,
	["eyebrows_3"] = 0,
	["beard_4"] = 0,
	["beard_1"] = 0,
	["bags_2"] = 0,
	["chest_3"] = 0,
	["arms_2"] = 0,
	["glasses_1"] = 17,
	["moles_1"] = 0,
	["shoes_1"] = 35,
	["chest_1"] = 0,
	["eyebrows_1"] = 8,
	["makeup_4"] = 0,
	["beard_2"] = 0,
	["watches_2"] = 0,
	["eye_color"] = 3,
	["helmet_2"] = 0,
	["age_2"] = 0,
	["eyebrows_2"] = 2,
	["hair_color_2"] = 16,
	["mask_2"] = 0,
	["makeup_2"] = 0,
	["chain_1"] = 300,
	["pants_1"] = 16,
	["blush_1"] = 0,
	["bags_1"] = 30,
	["bproof_1"] = 194,
	["lipstick_4"] = 18,
	["lipstick_3"] = 22,
	["hair_1"] = 301,
	["bracelets_2"] = 0,
	["blush_2"] = 0,
	["eyebrows_4"] = 0,
	["bproof_2"] = 0,
	["skin"] = 45,
	["watches_1"] = -1,
	["torso_1"] = 16,
	["helmet_1"] = 0,
	["lipstick_1"] = 0,
	["ears_2"] = 0,
	["bracelets_1"] = -1,
	["ears_1"] = 1,
	["decals_2"] = 0,
	["mask_1"] = 0,
	["age_1"] = 0,
	["arms"] = 10,
	["makeup_3"] = 0,
	["hair_color_1"] = 15,
	["tshirt_2"] = 0,
	["blush_3"] = 0,
	["hair_2"] = 0,
	["decals_1"] = 0,
	["moles_2"] = 0,
	["lipstick_2"] = 3,
	["makeup_1"] = 0,
	["tshirt_1"] = 25,
	["complexion_1"] = 0,
	["pants_2"] = 0,
	["torso_2"] = 0,
	["chest_2"] = 0,
	["beard_3"] = 0,
	["complexion_2"] = 0,
	-- ["sex"] = 0, -- This key is missing in the provided replacement data
}

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker = false
		for _,v in pairs(Config.npcTeleport) do
			if(GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, false) < v.drawdistance) then
				DrawMarker(v.markertype, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0,
						v.markersize.x, v.markersize.y, v.markersize.z, v.markercolour.r, v.markercolour.g, v.markercolour.b, 100,
						false, true, 2, false, false, false, false)
				Draw3DText(v.coords.x, v.coords.y, v.coords.z+2, 0.5,"กด ~y~[E]~w~ เพื่อเปิดเมนูเทเลพอร์ต")
				sleep = 0
			end

			if(GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, false) < v.interactdistance) then
				isInMarker = true
				if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) then
					tereloportMenu()
				end
			end
		end

		for _,v in pairs(Config.npcTeleportNoExit) do
			if(GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, false) < v.drawdistance) then
				DrawMarker(v.markertype, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0,
						v.markersize.x, v.markersize.y, v.markersize.z, v.markercolour.r, v.markercolour.g, v.markercolour.b, 100,
						false, true, 2, false, false, false, false)
				Draw3DText(v.coords.x, v.coords.y, v.coords.z+2, 0.5,"กด ~y~[E]~w~ เพื่อเปิดเมนูเทเลพอร์ต")
				sleep = 0
			end

			if(GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, false) < v.interactdistance) then
				isInMarker = true
				if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) then
					tereloportMenuNoExit()
				end
			end
		end

		if not isInMarker then
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'teleport_menu')
			ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'teleport_menu_noexit')
		end
		Citizen.Wait(sleep)
    end
end)

function tereloportMenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'teleport_menu', {
                title    = 'Teleport Menu',
                align    = 'top-right',
                elements = {
                    {label = "ตกหมึกและนั่งฌาน (AFK)", name = 'auto_farm_afk_tele'},
                    {label = "ห้องเปิดกาชา", name = 'gashapon_tele'},
					{label = "เทรนนิ่ง - อารีน่า", name = 'arena_tele'},
					{label = "ออก", name = 'exit'},
                }
    },  function(data, menu)
            if data.current.name == 'auto_farm_afk_tele' then
				menu.close()
				validateTeleport("auto_farm_afk_tele")
            end
            if data.current.name == 'gashapon_tele' then
				menu.close()
				validateTeleport("gashapon_tele")
            end
			if data.current.name == 'arena_tele' then
				menu.close()
				validateTeleport("arena_tele")
            end
			if data.current.name == 'exit' then
				menu.close()
				validateTeleport("exit")
            end
        end, function(data, menu)
            menu.close()
    end)
end

function tereloportMenuNoExit()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'teleport_menu_noexit', {
                title    = 'Teleport Menu',
                align    = 'top-right',
                elements = {
                    {label = "ตกหมึกและนั่งฌาน (AFK)", name = 'auto_farm_afk_tele'},
                    {label = "ห้องเปิดกาชา", name = 'gashapon_tele'},
					{label = "เทรนนิ่ง - อารีน่า", name = 'arena_tele'},
                }
    },  function(data, menu)
            if data.current.name == 'auto_farm_afk_tele' then
				menu.close()
				validateTeleport("auto_farm_afk_tele")
            end
            if data.current.name == 'gashapon_tele' then
				menu.close()
				validateTeleport("gashapon_tele")
            end
			if data.current.name == 'arena_tele' then
				menu.close()
				validateTeleport("arena_tele")
            end
        end, function(data, menu)
            menu.close()
    end)
end

local function freezePlayer(id, freeze)
	local player = id
	SetPlayerControl(player, not freeze, false)

	local ped = GetPlayerPed(player)

	if not freeze then
		-- if not IsEntityVisible(ped) then
		-- 	SetEntityVisible(ped, true)
		-- end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		--SetCharNeverTargetted(ped, false)
		SetPlayerInvincible(player, false)
	else
		-- if IsEntityVisible(ped) then
		-- 	SetEntityVisible(ped, false)
		-- end

		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		--SetCharNeverTargetted(ped, true)
		SetPlayerInvincible(player, true)
		--RemovePtfxFromPed(ped)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end

function validateTeleport(teleportname)
	TriggerServerEvent('cc_training:exittraining')
	for _,v in pairs(Config.teleportInfo) do
		if v.teleportname == teleportname then
			if not alreadyhasLastStandlastStandPoint then
				lastStandPoint = GetEntityCoords(PlayerPedId())
				lastStandHeading = GetEntityHeading(PlayerPedId())
				alreadyhasLastStandlastStandPoint = true
			end

			if v.teleportname == 'gashapon_tele' then
				local tokenAuth = exports.cc_authlogin:tokenCollect()
				ESX.TriggerServerCallback('checkPermissionAndPlayerGacha', function(stateTeleportGacha)
					if stateTeleportGacha then
						startTeleport(teleportname)
					else
						return
					end
				end,v.destination,tokenAuth)
			else
				startTeleport(teleportname)
			end
		end

	end

	if teleportname == 'exit' then
		startExit()
	end
end

function startExit()
	local ped = PlayerPedId()
	local currentHealth = GetEntityHealth(ped)
	local currentArmor = GetPedArmour(ped)
	local finaldestination = vector3(194.52000427246097, -942.0900268554688, 30.69000053405761)
	local finalheading = 143.00
	if lastStandPoint ~= nil then
		finaldestination = lastStandPoint
		finalheading = lastStandHeading
	end

	SwitchOutPlayer(ped,0,1)
	Citizen.Wait(1000)
	freezePlayer(PlayerId(), true)
	-- preload collisions for the spawnpoint
	RequestCollisionAtCoord(finaldestination.x, finaldestination.y, finaldestination.z)
	-- spawn the player
			
	SetEntityCoordsNoOffset(ped, finaldestination.x, finaldestination.y, finaldestination.z+1, false, false, false)
	NetworkResurrectLocalPlayer(finaldestination.x, finaldestination.y, finaldestination.z+1, finalheading, true, true, false)
	SetGameplayCamRelativeHeading(0.0)
	SetEntityHeading(ped, finalheading)
	SetEntityHealth(ped, currentHealth)
	SetPedArmour(ped, currentArmor)

	Citizen.Wait(1000)
	local time = GetGameTimer()
	while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 30000) do
		RequestCollisionAtCoord(finaldestination.x, finaldestination.y, finaldestination.z)
		Citizen.Wait(0)
	end
	SwitchInPlayer(ped)
	ongoingfreeze = true
	unFreeze()
	lastStandPoint = nil
	lastStandHeading = nil
	alreadyhasLastStandlastStandPoint = false
	--Wait(2000)
	--freezePlayer(PlayerId(), false)
end

function startTeleport(teleportname)
	for _,v in pairs(Config.teleportInfo) do
		if v.teleportname == teleportname then


			local ped = PlayerPedId()
			local currentHealth = GetEntityHealth(ped)
			local currentArmor = GetPedArmour(ped)

			SwitchOutPlayer(ped,0,1)
			Citizen.Wait(1000)
			freezePlayer(PlayerId(), true)
			-- preload collisions for the spawnpoint
			RequestCollisionAtCoord(v.destination.x, v.destination.y, v.destination.z)
			-- spawn the player
			
			SetEntityCoordsNoOffset(ped, v.destination.x, v.destination.y, v.destination.z, false, false, false)
			NetworkResurrectLocalPlayer(v.destination.x, v.destination.y, v.destination.z, v.heading, true, true, false)
			SetGameplayCamRelativeHeading(0.0)
			SetEntityHeading(ped, v.heading)
			SetEntityHealth(ped, currentHealth)
			SetPedArmour(ped, currentArmor)

			Citizen.Wait(1000)
			local time = GetGameTimer()
			while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 30000) do
				RequestCollisionAtCoord(v.destination.x, v.destination.y, v.destination.z)
				Citizen.Wait(0)
			end
			SwitchInPlayer(ped)
			ongoingfreeze = true
			unFreeze()
			--Wait(2000)
			--freezePlayer(PlayerId(), false)
		end
	end
end

function unFreeze()
	Citizen.Wait(5000)
	exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิกแช่แข็ง")
	if ongoingfreeze then
		Citizen.CreateThread(function()
			while ongoingfreeze do
				Citizen.Wait(0)
				if IsControlJustReleased(0, 73) then
					exports.helpnotify:hideHelpNotification()
					freezePlayer(PlayerId(), false)
					ongoingfreeze = false
				end
			end
		end)
	end
end


function Draw3DText(x, y, z, scl_factor, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local p = GetGameplayCamCoords()
	local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	local scale = (1 / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov * scl_factor
	if onScreen then
		SetTextScale(0.0, scale)
		SetTextFont(fontId)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x, _y)
	end
end



Citizen.CreateThread(function()
	for _,v in pairs(Config.npcTeleport) do
		local npcPortalHash = GetHashKey("mp_m_freemode_01") -- NPC model (can be any valid ped model)
		RequestModel(npcPortalHash)
		while not HasModelLoaded(npcPortalHash) do
			Wait(1)
		end

		local npcPortal = CreatePed(4, npcPortalHash, v.coords.x, v.coords.y, v.coords.z, v.heading, false, true) 
		SetEntityAsMissionEntity(npcPortal, true, true)
		SetBlockingOfNonTemporaryEvents(npcPortal, true)
		FreezeEntityPosition(npcPortal, true)
		SetEntityInvincible(npcPortal, true)
		--TaskPlayAnim(npcPortal,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
		-- Apply appearance changes from ESX data
		ApplyCustomAppearance(npcPortal, skinData)
	end
	for _,v in pairs(Config.npcTeleportNoExit) do
		local npcPortalHash = GetHashKey("mp_m_freemode_01") -- NPC model (can be any valid ped model)
		RequestModel(npcPortalHash)
		while not HasModelLoaded(npcPortalHash) do
			Wait(1)
		end

		local npcPortal = CreatePed(4, npcPortalHash, v.coords.x, v.coords.y, v.coords.z, v.heading, false, true) 
		SetEntityAsMissionEntity(npcPortal, true, true)
		SetBlockingOfNonTemporaryEvents(npcPortal, true)
		FreezeEntityPosition(npcPortal, true)
		SetEntityInvincible(npcPortal, true)
		--TaskPlayAnim(npcPortal,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
		-- Apply appearance changes from ESX data
		ApplyCustomAppearance(npcPortal, skinData)
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
	SetPedPropIndex(ped, 1, data["glasses_1"], 0, true) -- glasses
	SetPedPropIndex(ped, 2, data["ear_accessories"], data["ear_accessories_2"], true) -- ear accessories
	SetPedPropIndex(ped, 6, data["watches_1"], data["watches_2"], true) -- watches
	SetPedPropIndex(ped, 7, data["bracelets_1"], data["bracelets_2"], true) -- bracelets
	--SetPedComponentVariation(ped, 1, 54, 0 / 10)
end



