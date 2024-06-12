ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- Define the skin data
local skinData = {
    ["torso_2"] = 0,
    ["shoes_1"] = 19,
    ["pants_2"] = 0,
    ["complexion_2"] = 0,
    ["tshirt_2"] = 1,
    ["beard_1"] = 0,
    ["eyebrows_1"] = 33,
    ["skin"] = 21,
    ["lipstick_3"] = 51,
    ["bproof_1"] = 0,
    ["arms_2"] = 0,
    ["decals_1"] = 0,
    ["chain_1"] = 36,
    ["torso_1"] = 17,
    ["helmet_1"] = -1,
    ["pants_1"] = 16,
    ["moles_2"] = 0,
    ["ears_2"] = 0,
    ["beard_4"] = 0,
    ["bproof_2"] = 0,
    ["blush_1"] = 3,
    --["sex"] = 0,
    ["chest_1"] = 0,
    ["ears_1"] = -1,
    ["tshirt_1"] = 18,
    ["makeup_2"] = 4,
    ["watches_2"] = 0,
    ["chest_2"] = 0,
    ["bracelets_1"] = -1,
    ["chest_3"] = 0,
    ["beard_3"] = 0,
    ["blush_3"] = 0,
    ["eyebrows_2"] = 10,
    ["bags_2"] = 0,
    ["complexion_1"] = 0,
    ["helmet_2"] = 0,
    ["lipstick_1"] = 3,
    ["hair_color_2"] = 61,
    ["glasses_2"] = 1,
    ["decals_2"] = 0,
    ["blush_2"] = 3,
    ["mask_2"] = 0,
    ["mask_1"] = -1,
    ["bags_1"] = 0,
    ["eyebrows_4"] = 0,
    ["hair_color_1"] = 55,
    ["eyebrows_3"] = 0,
    ["lipstick_4"] = 0,
    ["age_1"] = 0,
    ["age_2"] = 0,
    ["face"] = 45,
    ["hair_2"] = 0,
    ["watches_1"] = -1,
    ["bracelets_2"] = 0,
    ["chain_2"] = 0,
    ["hair_1"] = 112,
    ["lipstick_2"] = 3,
    ["glasses_1"] = 24,
    ["arms"] = 12,
    ["shoes_2"] = 0,
    ["beard_2"] = 0,
    ["moles_1"] = 0,
    ["makeup_4"] = 2,
    ["makeup_1"] = 13,
    ["eye_color"] = 3,
    ["makeup_3"] = 2
}

RegisterNetEvent('cc_quest:handleMenuByCommand')
AddEventHandler('cc_quest:handleMenuByCommand', function(command)
    if command == "openquest" then
        local tokenAuth = exports.cc_authlogin:tokenCollect()
        SendNUIMessage({
            action = "openSubQuestMenu",
            auth = tokenAuth
        })
    end
    if command == "closequest" then
        local tokenAuth = exports.cc_authlogin:tokenCollect()
        SendNUIMessage({
            action = "closeSubQuest",
            auth = tokenAuth
        })
    end
    if command == "refreshquest" then
        local tokenAuth = exports.cc_authlogin:tokenCollect()
        SendNUIMessage({
            action = "refreshSubQuest",
            auth = tokenAuth
        })
    end
end)

local npcPed = nil
local inzonelastName = false
Citizen.CreateThread(function()
    local npcHash = GetHashKey("mp_m_freemode_01") -- NPC model (can be any valid ped model)
    RequestModel(npcHash)
    while not HasModelLoaded(npcHash) do
        Wait(1)
    end

    npcPed = CreatePed(4, npcHash, 218.505494, -908.716492, 30.032226, 68.031494, false, true)
    SetEntityAsMissionEntity(npcPed, true, true)
    SetBlockingOfNonTemporaryEvents(npcPed, true)
    FreezeEntityPosition(npcPed, true)
    SetEntityInvincible(npcPed, true)
    --TaskPlayAnim(npcPed,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    -- Apply appearance changes from ESX data
    ApplyCustomAppearance(npcPed, skinData)
end)

local questZone = PolyZone:Create({
    vector3(217.41000366210935, -905.719970703125, 31.04999923706054),
    vector3(221.5800018310547, -908.1599731445312, 31.05999946594238),
    vector3(220.17999267578128, -912.1500244140624, 30.95999908447265),
    vector3(215, -910.260009765625, 31.01000022888183),
},{
    name = "quest_zone",
    minZ = 29,
    maxZ = 35,
    debugPoly = false,
})

questZone:onPlayerInOut(function(isPointInside, point)
    if isPointInside then
        inzonelastName = true
        exports.helpnotify:showHelpNotification("กด","E","เพื่อรับเควส")
    else
        inzonelastName = false
        exports.helpnotify:hideHelpNotification()
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if inzonelastName == true then
            if IsControlJustReleased(0, 38) then -- "E" key
                pcall(function()-- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'TalkToQuestNpc',
                        content = ('ผู้เล่นได้ทำการกด E เพื่อคุยกับ npc'):format(),
                    })
                end)-- End log
                ESX.TriggerServerCallback('cc_quest:savePlayer', function(status)
                    if status then
                        pcall(function()-- Start log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'AcceptQuest',
                                content = ('ผู้เล่นได้เควสจาก npc'):format(),
                            })
                        end)-- End log
                        openQuestMenu()
                        exports.helpnotify:hideHelpNotification()
                    end
                end)
            end
        else
            Citizen.Wait(500)
        end
    end
end)

-- Open the surname menu
function openQuestMenu()
    local tokenAuth = exports.cc_authlogin:tokenCollect()
    SendNUIMessage({
        action = "openQuestMenu",
        auth = tokenAuth
    })
    Citizen.Wait(200)
    SetTimecycleModifier('hud_def_blur') -- blur
    SetTimecycleModifierStrength(1.0)
    ESX.SetTimeout(200, function()
        SetNuiFocus(true, true)
    end)
end

-- Apply custom appearance to the NPC
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


    --SetPedPropIndex(ped, 0, data["hat"], data["hat_2"], true) -- hat
    SetPedPropIndex(ped, 1, data["glasses"], data["glasses_2"], true) -- glasses
    SetPedPropIndex(ped, 2, data["ear_accessories"], data["ear_accessories_2"], true) -- ear accessories
    SetPedPropIndex(ped, 6, data["watches_1"], data["watches_2"], true) -- watches
    SetPedPropIndex(ped, 7, data["bracelets_1"], data["bracelets_2"], true) -- bracelets
    SetPedComponentVariation(ped, 1, 55, 0 / 10) -- mask
end

RegisterNUICallback("update", function(data, cb)
    ESX.TriggerServerCallback('cc_quest:savePlayer', function(doneStatus)
        cb(doneStatus)
    end)
end)

RegisterNUICallback("doneWeight", function(data, cb)
    ESX.TriggerServerCallback('cc_quest:doneWeight', function(doneStatus)
        cb(doneStatus)
    end)
end)

RegisterNUICallback("doneQuest", function(data, cb)
    ESX.TriggerServerCallback('cc_quest:doneQuest', function(doneStatus)
        cb(doneStatus)
    end)
end)

RegisterNUICallback("resetQuest", function(data, cb)
    ESX.TriggerServerCallback('cc_quest:resetQuest', function(doneStatus)
        cb(doneStatus)
    end)
end)

function closeGui()
    SendNUIMessage({action = "closeAll"})
    SetNuiFocus(false, false)
    SetTimecycleModifier('default') -- blur
end

AddEventHandler('esx:onPlayerDeath', function(data)
    exports.helpnotify:hideHelpNotification()
    SendNUIMessage({action = "closeSubQuest"})
    closeGui()
end)


RegisterNUICallback('NUIFocusOff', function(data, cb)
    closeGui()
    cb('ok')
end)
