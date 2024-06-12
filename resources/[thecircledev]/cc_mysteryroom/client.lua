ESX = nil
local playerInGachapon = {}
local helpNotify = true
local ongoingfreeze = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
--==============================================================================================================================================================
--==============================================================Teleport========================================================================================
--==============================================================================================================================================================
-- local npcPed = nil
-- local skinData = {
--     ["chain_2"] = 0,
--     ["watches_1"] = -1,
--     ["lipstick_2"] = 0,
--     ["tshirt_1"] = 19,
--     ["pants_2"] = 1,
--     ["beard_2"] = 10,
--     ["beard_1"] = 0,
--     ["tshirt_2"] = 0,
--     ["glasses_2"] = 0,
--     ["hair_color_1"] = 29,
--     ["beard_4"] = 0,
--     ["shoes_2"] = 0,
--     ["helmet_2"] = 0,
--     ["age_1"] = 0,
--     ["bracelets_1"] = -1,
--     ["decals_1"] = 0,
--     ["torso_1"] = 16,
--     ["chest_1"] = 0,
--     ["ears_2"] = 0,
--     ["beard_3"] = 0,
--     ["bproof_2"] = 0,
--     ["hair_1"] = 0,
--     ["lipstick_4"] = 0,
--     ["lipstick_1"] = 0,
--     ["bags_2"] = 0,
--     ["decals_2"] = 0,
--     ["shoes_1"] = 32,
--     ["bproof_1"] = 0,
--     ["makeup_1"] = 0,
--     ["eyebrows_4"] = 0,
--     ["moles_1"] = 0,
--     ["makeup_2"] = 0,
--     ["mask_1"] = 0,
--     ["hair_2"] = 0,
--     ["chest_3"] = 0,
--     ["torso_2"] = 0,
--     ["face"] = 0,
--     ["blush_2"] = 0,
--     ["chest_2"] = 0,
--     ["pants_1"] = 16,
--     ["complexion_1"] = 0,
--     ["glasses_1"] = 5,
--     ["blush_1"] = 0,
--     ["blush_3"] = 0,
--     ["moles_2"] = 0,
--     ["eyebrows_3"] = 0,
--     ["lipstick_3"] = 0,
--     ["makeup_4"] = 0,
--     ["mask_2"] = 0,
--     ["chain_1"] = 0,
--     ["bracelets_2"] = 0,
--     ["arms_2"] = 0,
--     ["complexion_2"] = 0,
--     ["skin"] = 0,
--     ["arms"] = 4,
--     ["helmet_1"] = -1,
--     ["hair_color_2"] = 0,
--     ["sex"] = 0,
--     ["makeup_3"] = 0,
--     ["eyebrows_1"] = 0,
--     ["ears_1"] = -1,
--     ["eye_color"] = 0,
--     ["bags_1"] = 0,
--     ["watches_2"] = 0,
--     ["age_2"] = 0,
--     ["eyebrows_2"] = 10
-- }


-- Citizen.CreateThread(function()
--     local npcHash = GetHashKey("mp_m_freemode_01") -- NPC model (can be any valid ped model)
--     RequestModel(npcHash)
--     while not HasModelLoaded(npcHash) do
--         Wait(1)
--     end
--     npcPed = CreatePed(4, npcHash,  -418.114288, 1219.661500, 325.634400, 164.409454, false, true)
--     SetEntityAsMissionEntity(npcPed, true, true)
--     SetBlockingOfNonTemporaryEvents(npcPed, true)
--     PlaceObjectOnGroundProperly(npcPed)
--     FreezeEntityPosition(npcPed, true)
--     SetEntityInvincible(npcPed, true)
--     --TaskPlayAnim(npcPed,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
--     -- Apply appearance changes from ESX data
--     ApplyCustomAppearance(npcPed, skinData)
-- end)

-- function ApplyCustomAppearance(ped, data)
--     SetPedHeadBlendData(ped,
--             data["face"],
--             data["face"],
--             data["face"],
--             data["skin"],
--             data["skin"],
--             data["skin"],
--             data["shape_mix"],
--             data["skin_mix"],
--             data["skin_mix"],
--             true
--     )

--     SetPedHeadOverlay(ped, 1, data["beard_1"], data["beard_2"] / 10) -- beard
--     SetPedHeadOverlay(ped, 2, data["eyebrows_1"], data["eyebrows_2"] / 10) -- eyebrows
--     SetPedHeadOverlay(ped, 3, data["age_1"], data["age_2"] / 10) -- age
--     SetPedHeadOverlay(ped, 4, data["makeup_1"], data["makeup_2"] / 10) -- makeup
--     SetPedHeadOverlay(ped, 5, data["blush_1"], data["blush_2"] / 10) -- blush
--     SetPedHeadOverlay(ped, 6, data["complexion_1"], data["complexion_2"] / 10) -- complexion
--     --SetPedHeadOverlay(ped, 7, data["sun_damage_1"], data["sun_damage_2"] / 10) -- sun damage
--     SetPedHeadOverlay(ped, 8, data["lipstick_1"], 1/10) -- lipstick
--     SetPedHeadOverlay(ped, 9, data["moles_1"], data["moles_2"] / 10) -- moles
--     --SetPedHeadOverlay(ped, 10, data["chest_hair_1"], data["chest_hair_2"] / 10) -- chest hair
--     --SetPedHeadOverlay(ped, 11, data["body_blemishes_1"], data["body_blemishes_2"] / 10) -- body blemishes

--     SetPedHeadOverlayColor(ped, 1, 1, data["beard_color"], data["beard_color"])
--     SetPedHeadOverlayColor(ped, 2, 1, data["eyebrows_color"], data["eyebrows_color"])
--     SetPedHeadOverlayColor(ped, 4, 2, data["makeup_color"], data["makeup_color"])
--     SetPedHeadOverlayColor(ped, 5, 2, data["blush_color"], data["blush_color"])
--     SetPedHeadOverlayColor(ped, 6, 0, data["complexion_color"], data["complexion_color"])
--     SetPedHeadOverlayColor(ped, 8, 2, data["lipstick_color"], data["lipstick_color"])
--     SetPedHeadOverlayColor(ped, 10, 0, data["chest_hair_color"], data["chest_hair_color"])
--     SetPedHeadOverlayColor(ped, 11, 0, data["body_blemishes_color"], data["body_blemishes_color"])

--     SetPedComponentVariation(ped, 2, data["hair_1"], data["hair_2"], 2) -- hair style
--     SetPedHairColor(ped, data["hair_color_1"], data["hair_color_2"]) -- hair color

--     SetPedComponentVariation(ped, 10, data["decals_1"], data["decals_2"], 2) -- decals

--     SetPedComponentVariation(ped, 3, data["arms"], data["arms_2"], 2) -- arms
--     SetPedComponentVariation(ped, 4, data["pants_1"], data["pants_2"], 2) -- pants
--     SetPedComponentVariation(ped, 6, data["shoes_1"], data["shoes_2"], 2) -- shoes
--     SetPedComponentVariation(ped, 7, data["shirt"], data["shirt_2"], 2) -- shirt
--     --SetPedComponentVariation(ped, 8, data["undershirt"], data["undershirt_2"], 2) -- undershirt
--     SetPedComponentVariation(ped, 11, data["torso_1"], data["torso_2"], 2) -- torso
--     SetPedComponentVariation(ped, 8, data["tshirt_1"], 0, 2) -- t-shirt


--     --SetPedPropIndex(ped, 0, data["hat"], data["hat_2"], true) -- hat
--     --SetPedPropIndex(ped, 1, data["glasses"], data["glasses_2"], true) -- glasses
--     SetPedPropIndex(ped, 2, data["ear_accessories"], data["ear_accessories_2"], true) -- ear accessories
--     SetPedPropIndex(ped, 6, data["watches_1"], data["watches_2"], true) -- watches
--     SetPedPropIndex(ped, 7, data["bracelets_1"], data["bracelets_2"], true) -- bracelets
--     SetPedComponentVariation(ped, 1, 21, 0 / 10) -- mask
-- end

-- Citizen.CreateThread(function()
--     while true do
--         local sleep = 1000
-- 		local coords = GetEntityCoords(PlayerPedId())
-- 		for _,v in pairs(Config.teleporGachapontInfo) do
-- 			if(GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, false) < v.drawdistance) then
-- 				DrawMarker(v.markertype, v.coords.x, v.coords.y, v.coords.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0,
-- 						v.markersize.x, v.markersize.y, v.markersize.z, v.markercolour.r, v.markercolour.g, v.markercolour.b, 100,
-- 						false, true, 2, false, false, false, false)
--                 if type(v.id_entrance) ~= "nil" then
--                     if type(playerInGachapon[v.id_entrance]) ~= "nil" then
--                         Draw3DText(v.coords.x, v.coords.y, v.coords.z,0.5,"Players In Area "..playerInGachapon[v.id_entrance].."/10")
--                     end
--                 end
-- 				sleep = 0
-- 			end

-- 			if(GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, false) < v.interactdistance) then
-- 				if IsControlJustReleased(0, 38) and IsPedOnFoot(PlayerPedId()) then
--                     if type(v.id_entrance) ~= "nil" then
--                         local tokenAuth = exports.cc_authlogin:tokenCollect()
--                         ESX.TriggerServerCallback('checkPermissionAndPlayerGacha', function(stateTeleportGacha)
-- 							if stateTeleportGacha then
-- 								startTeleport(v.name)
--                                 pcall(function() -- Start log
--                                     exports['azael_dc-serverlogs']:insertData({
--                                         event = 'EnterGachponRoom',
--                                         content = ('ผู้เล่นได้ทำการกด E เพื่อใช้วาป %s'):format(v.name),
--                                     })
--                                 end) -- End log
-- 							end
-- 						end,v.destination,tokenAuth)
-- 						goto endState
--                     end
--                     startTeleport(v.name)
--                     pcall(function() -- Start log
--                         exports['azael_dc-serverlogs']:insertData({
--                             event = 'ExitGachponRoom',
--                             content = ('ผู้เล่นได้ทำการกด E เพื่อใช้วาป %s'):format(v.name),
--                         })
--                     end) -- End log
-- 				end
-- 			end
-- 		end
--         ::endState::
-- 		Citizen.Wait(sleep)
--     end
-- end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		local sleep = 5000
-- 		local coords = GetEntityCoords(PlayerPedId())
-- 		for _,v in pairs(Config.teleporGachapontInfo) do
-- 			if(GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, false) < v.drawdistance) then
-- 				if type(v.id_entrance) ~= "nil" then
-- 					ESX.TriggerServerCallback('checkPlayerGachapon', function(countPlayerGacha)
-- 						playerInGachapon[v.id_entrance] = countPlayerGacha
-- 					end,v.destination)
-- 				end
-- 			end
-- 		end
-- 		Citizen.Wait(sleep)
-- 	end
-- end)

-- local function freezePlayer(id, freeze)
--     local player = id
--     SetPlayerControl(player, not freeze, false)

--     local ped = GetPlayerPed(player)

--     if not freeze then
--         -- if not IsEntityVisible(ped) then
--         --     SetEntityVisible(ped, true)
--         -- end

--         if not IsPedInAnyVehicle(ped) then
--             SetEntityCollision(ped, true)
--         end

--         FreezeEntityPosition(ped, false)
--         --SetCharNeverTargetted(ped, false)
--         SetPlayerInvincible(player, false)
--     else
--         -- if IsEntityVisible(ped) then
--         --     SetEntityVisible(ped, false)
--         -- end

--         SetEntityCollision(ped, false)
--         FreezeEntityPosition(ped, true)
--         --SetCharNeverTargetted(ped, true)
--         SetPlayerInvincible(player, true)
--         --RemovePtfxFromPed(ped)

--         if not IsPedFatallyInjured(ped) then
--             ClearPedTasksImmediately(ped)
--         end
--     end
-- end

-- function startTeleport(teloportname)
-- 	for _,v in pairs(Config.teleporGachapontInfo) do
-- 		if v.name == teloportname then
--             local ped = PlayerPedId()
--             SwitchOutPlayer(ped,0,1)
--             Citizen.Wait(1000)
--             freezePlayer(PlayerId(), true)
--             -- preload collisions for the spawnpoint
--             RequestCollisionAtCoord(v.destination.x, v.destination.y, v.destination.z)
--             -- spawn the player
--             if type(v.id_entrance) ~= "nil" then
--                 SetEntityCoordsNoOffset(ped, v.destination.x, v.destination.y, v.destination.z+0.3, false, false, false, true)
--                 NetworkResurrectLocalPlayer(v.destination.x, v.destination.y, v.destination.z, v.heading, true, true, false)
--                 SetGameplayCamRelativeHeading(0.0)
--                 SetEntityHeading(ped, v.heading)
--             else
--                 SetEntityCoordsNoOffset(ped, v.destination.x, v.destination.y, v.destination.z+0.3, false, false, false)
--                 NetworkResurrectLocalPlayer(v.destination.x, v.destination.y, v.destination.z, v.heading, true, true, false)
--                 SetGameplayCamRelativeHeading(0.0)
--                 SetEntityHeading(ped, v.heading)
--             end
-- 			Citizen.Wait(1000)
--             local time = GetGameTimer()
--             while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 30000) do
--                 RequestCollisionAtCoord(v.destination.x, v.destination.y, v.destination.z)
--                 Citizen.Wait(0)
--             end
--             SwitchInPlayer(ped)
--             ongoingfreeze = true
-- 			unFreeze()
--             --Wait(2000)
--             --freezePlayer(PlayerId(), false)
-- 		end
-- 	end
-- end

-- function unFreeze()
-- 	Citizen.Wait(5000)
-- 	exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิกแช่แข็ง")
-- 	if ongoingfreeze then
-- 		Citizen.CreateThread(function()
-- 			while ongoingfreeze do
-- 				Citizen.Wait(0)
-- 				if IsControlJustReleased(0, 73) then
-- 					exports.helpnotify:hideHelpNotification()
-- 					freezePlayer(PlayerId(), false)
-- 					ongoingfreeze = false
-- 				end
-- 			end
-- 		end)
-- 	end
-- end

function Draw3DText(x, y, z, scl_factor, text)
	local onScreenGacha, _x, _y = World3dToScreen2d(x, y, z)
	local p = GetGameplayCamCoords()
	local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	local scale = (1 / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov * scl_factor
	if onScreenGacha then
		SetTextScale(0.0, scale)
		SetTextFont(0)
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

function openGachapon()
    local tokenAuth = exports.cc_authlogin:tokenCollect()
    SendNUIMessage({
        action = "openGachapon",
        auth = tokenAuth
    })
    Citizen.Wait(200)
    SetTimecycleModifier('Bloom') -- blur
    SetTimecycleModifierStrength(1.5)
    ESX.SetTimeout(200, function()
        SetNuiFocus(true, true)
    end)

end

function LoadAnimationDictionary(animationD)
    while(not HasAnimDictLoaded(animationD)) do
        RequestAnimDict(animationD)
        Citizen.Wait(1)
    end
end

function closeGui()
    SendNUIMessage({action = "closeAll"})
    SetNuiFocus(false, false)
    SetTimecycleModifier('default') -- blur
    ClearPedTasks(PlayerPedId())
    helpNotify = true
end


RegisterNUICallback('open', function(data, cb)
    local tokenAuth = exports.cc_authlogin:tokenCollect()
    ESX.TriggerServerCallback('cc_gachapon:openGachapon', function(status,response)
        if status then
            cb(response)
        end
    end,tokenAuth,data)
    pcall(function() -- Start log
        exports['azael_dc-serverlogs']:insertData({
            event = 'OpeningGachapon',
            content = ('ผู้เล่นได้ทำการกดเปิด Gachapon จากเมนูกาชาปอง'):format(),
        })
    end) -- End log
end)

RegisterNUICallback('getItem', function(data, cb)
    ESX.TriggerServerCallback('cc_gachapon:getItem', function(status)
        cb(status)
    end,data)
    pcall(function() -- Start log
        exports['azael_dc-serverlogs']:insertData({
            event = 'GetItemFromGachapon',
            content = ('ผู้เล่นได้ทำการกดรับของจากเมนูกาชาปอง'):format(),
        })
    end) -- End log
end)

RegisterNUICallback('validateGachapon', function(data, cb)
    ESX.TriggerServerCallback('cc_gachapon:validateGachapon', function(status)
        cb(status)
    end,data)
end)


RegisterNUICallback('NUIFocusOff', function(data, cb)
    closeGui()
    helpNotify = true
    cb('ok')
    pcall(function() -- Start log
        exports['azael_dc-serverlogs']:insertData({
            event = 'StopOpenGachapon',
            content = ('ผู้เล่นได้ทำการปิดเมนูกาชาปอง'):format(),
        })
    end) -- End log
end)


--==============================================================================================================================================================
--==============================================================Gachapon Check In Zone========================================================================================
--==============================================================================================================================================================
local inzonegachapon = false


for _,v in pairs(Config.GachaponPolyZone) do
    local gachaponZone = PolyZone:Create(v.coords, {
        name = v.name,
        debugPoly = v.debug,
        minZ = v.minZ,
        maxZ = v.maxZ,
    })

    gachaponZone:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            inzonegachapon = true
        else
            inzonegachapon = false
            helpNotify = true
            exports.helpnotify:hideHelpNotification()
        end
    end)
end

-- Player Press E
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if inzonegachapon == true then
            if helpNotify then
                exports.helpnotify:showHelpNotification("กด","E","เพื่อเปิดกาชา")
                helpNotify = false
            end
            if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) then
                ESX.TriggerServerCallback('cc_gachapon:savePlayer', function(status)
                    if status then
                        LoadAnimationDictionary("misslamar1leadinout")
                        TaskPlayAnim(PlayerPedId(), 'misslamar1leadinout', 'yoga_02_idle', 8.0, 8.0, -1, 17, 0.0, false, false, false)
                        exports.helpnotify:hideHelpNotification()
                        openGachapon()
                        pcall(function() -- Start log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'StartOpenGachapon',
                                content = ('ผู้เล่นได้ทำการกด E เพื่อเปิดเมนูกาชาปอง'):format(),
                            })
                        end) -- End log
                    end
                end)
            end
        else 
            Citizen.Wait(500)
        end
    end
end)


AddEventHandler('esx:onPlayerDeath', function(data)
    exports.helpnotify:hideHelpNotification()
    closeGui()
    helpNotify = true
end)