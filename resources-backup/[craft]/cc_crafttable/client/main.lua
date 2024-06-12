local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local PlayerData              = {}
local helpNotify = true
local isDead = false
local onUse = false
local skinData = {
    ["chain_1"] = 0,
    ["bracelets_1"] = -1,
    ["shoes_1"] = 22,
    ["bags_2"] = 0,
    ["mask_1"] = -1,
    ["makeup_2"] = 10,
    ["makeup_1"] = 94,
    ["glasses_2"] = 0,
    ["eyebrows_4"] = 63,
    ["decals_1"] = 0,
    ["bags_1"] = 0,
    ["moles_2"] = 0,
    ["beard_2"] = 0,
    ["beard_3"] = 0,
    ["blush_1"] = 0,
    ["chest_3"] = 0,
    ["makeup_4"] = 28,
    ["watches_2"] = 0,
    ["arms_2"] = 0,
    ["age_1"] = 0,
    ["lipstick_1"] = 4,
    ["hair_1"] = 65,
    ["pants_1"] = 16,
    ["beard_4"] = 0,
    ["helmet_2"] = 0,
    ["eye_color"] = 7,
    ["beard_1"] = 0,
    ["blush_2"] = 7,
    ["ears_2"] = 0,
    ["ears_1"] = 11,
    ["torso_1"] = 68,
    ["lipstick_4"] = 0,
    ["lipstick_2"] = 10,
    ["lipstick_3"] = 51,
    ["complexion_2"] = 0,
    ["age_2"] = 0,
    ["bracelets_2"] = 0,
    ["hair_color_2"] = 11,
    ["decals_2"] = 0,
    ["shoes_2"] = 2,
    ["pants_2"] = 0,
    ["sex"] = 1,
    ["glasses_1"] = 21,
    ["tshirt_1"] = 7,
    ["moles_1"] = 0,
    ["hair_color_1"] = 28,
    ["blush_3"] = 25,
    ["mask_2"] = 0,
    ["skin"] = 45,
    ["complexion_1"] = 11,
    ["tshirt_2"] = 0,
    ["makeup_3"] = 63,
    ["helmet_1"] = -1,
    ["hair_2"] = 0,
    ["chain_2"] = 0,
    ["eyebrows_3"] = 63,
    ["bproof_2"] = 0,
    ["torso_2"] = 1,
    ["eyebrows_2"] = 10,
    ["chest_2"] = 0,
    ["face"] = 40,
    ["chest_1"] = 0,
    ["watches_1"] = -1,
    ["eyebrows_1"] = 30,
    ["arms"] = 44,
    ["bproof_1"] = 59
}


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('cc_crafttable:playSound')
AddEventHandler('cc_crafttable:playSound', function()
    SendNUIMessage({message = "playsound"})
    if onUse then return end
    SetNuiFocus(false, false)
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    PlayerData = ESX.GetPlayerData()
    --ESX.TriggerServerCallback('esx_shops:requestDBItems', function(ShopItems)
    --    for k,v in pairs(ShopItems) do
    --        if (Config.Zones[k] ~= nil) then
    --            Config.Zones[k].Items = v
    --        end
    --    end
    --end)
end)

function LoadAnimationDictionary(animationD)
    while(not HasAnimDictLoaded(animationD)) do
        RequestAnimDict(animationD)
        Citizen.Wait(1)
    end
end

function OpenCraftTable(zone)
    PlayerData = ESX.GetPlayerData()

    if Config.Zones[zone].job  ~= nil then
        if Config.Zones[zone].job ~= ESX.PlayerData.job.name then
            exports.nc_notify:PushNotification({
                scale = 1.0, -- ปรับขนาดของ Notify
                title = 'ระบบโต๊ะคราฟ', -- หัวเรื่อง
                description = 'ไม่มีสิทธิในการใช้โต๊ะคราฟ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                icon = 'no_result', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                duration = 3000 -- ระยะเวลาการแสดง Notify
            })
            return
        end
    end

    onUse = true

    SendNUIMessage({
        message = "show",
        clear = true
    })

    Citizen.Wait(200)

    local items = Config.Zones[zone].Items

        SendNUIMessage({
            message = "add",
            itemList = items, -- Assuming 'item.name' represents the item identifier
            loc = zone
        })


    SetTimecycleModifier('hud_def_blur') -- blur
    SetTimecycleModifierStrength(1.0)

    ESX.SetTimeout(200, function()
        SetNuiFocus(true, true)
    end)
end



function enteredZone(zone)
    CurrentAction     = 'craft_menu'
    ESX.UI.Menu.CloseAll()
    CurrentActionData = {zone = zone}
end

function exitZone()
    CurrentAction = nil
    ESX.UI.Menu.CloseAll()
    closeGui()
end


-- Display markers
local swieczkaHadesa = false
local czas = 1000

local fontId
Citizen.CreateThread(function()
    RegisterFontFile('font4thai') -- the name of your .gfx, without .gfx
    fontId = RegisterFontId('font4thai') -- the name from the .xml
end)

Citizen.CreateThread(function()
    local checkInterval = 1500
    local playerPed
    local coords
    local isInMarker
    local currentZone
    local helpNotifyDisplayed = false

    while true do
        checkInterval = 1500
        playerPed = PlayerPedId()
        coords = GetEntityCoords(playerPed)
        isInMarker = false
        currentZone = nil

        for k, v in pairs(Config.Zones) do
            for i = 1, #v.Pos, 1 do
                local dist = GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true)

                if dist < 5 then
                    checkInterval = 0 -- More frequent checks when near a marker

                    if dist < 2 then
                        if v.isMark then
                            DrawMarker(Config.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
                        end

                        if not helpNotifyDisplayed then
                            exports.helpnotify:showHelpNotification("กด", "E", "เพื่อใช้งาน")
                            helpNotifyDisplayed = true
                        end
                        isInMarker = true
                        ShopItems = v.Items
                        currentZone = k
                        LastZone = k
                    end

                    DrawText3D(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z + 1.1, "~w~ " .. v.name, 2.0)
                end
            end
        end

        if isInMarker and not HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = true
            enteredZone(currentZone)
        end

        if not isInMarker and HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = false
            exports.helpnotify:hideHelpNotification()
            helpNotifyDisplayed = false
            exitZone()
        end

        if not isInMarker then
        end
        Citizen.Wait(checkInterval)
    end
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
    while true do
        if czas == 0 then
            Citizen.Wait(5000)
            czas = 1000
        else
            Citizen.Wait(5000)
        end
    end
end)

-- Key Controls
Citizen.CreateThread(function()
    local slp = 1500
    while true do
        Citizen.Wait(slp)
        if CurrentAction ~= nil then
            slp = 0
            if IsControlJustReleased(0, 38) then
                if CurrentAction == 'craft_menu' then
                    exports.helpnotify:hideHelpNotification()
                    OpenCraftTable(CurrentActionData.zone)
                    pcall(function() -- Start log
                        exports['azael_dc-serverlogs']:insertData({
                            event = 'PlayerUseCraftTable',
                            content = ('ผู้เล่นได้ทำการกด E เพื่อทำการใช้งานโต๊ะคราฟ'):format(),
                        })
                    end) -- End Log
                end
                --CurrentAction = nil
                --elseif IsControlJustReleased (0, 44) then
                --	ESX.SetTimeout(200, function()
                --		SetNuiFocus(false, false)
                --	end)
            end
        else
            slp = 1500
        end
    end
end)

RegisterNUICallback("checkMaterial", function(data, cb)
    local materialName = data.item
    local type = data.type
    --print("in lua check",materialName)
    ESX.TriggerServerCallback('cc_crafttable:checkMaterial', function(materialCount)
        cb(materialCount)
    end,materialName,type)
end)

RegisterNUICallback("checkCanCraft", function(data, cb)
    --print("in lua check Can Craft",data.item,data.amount)
    ESX.TriggerServerCallback('cc_crafttable:checkCanCraft', function(status)
        LoadAnimationDictionary("timetable@gardener@filling_can")
        TaskPlayAnim(PlayerPedId(), 'timetable@gardener@filling_can', 'gar_ig_5_filling_can', 8.0, 8.0, -1, 17, 0.0, false, false, false)
        cb(status)
    end,data)
end)

RegisterNUICallback("successCraft", function(data, cb)
    --print("in lua check Can Craft",data.item,data.amount)
    ESX.TriggerServerCallback('cc_crafttable:successCraft', function(craftStatus)
        ClearPedTasksImmediately(PlayerPedId())
        cb(craftStatus)
    end,data)
end)

function closeGui()
    SendNUIMessage({message = "hide"})
    SetNuiFocus(false, false)
    onUse = false
    if not isDead then
        ClearPedTasks(PlayerPedId())
    end
    SetTimecycleModifier('default') -- blur
end

AddEventHandler('esx:onPlayerDeath', function(data)
    CurrentAction = nil
    helpNotify = false
    isDead = true
    exports.helpnotify:hideHelpNotification()
    closeGui()
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
    helpNotify = true
end)

RegisterNUICallback('quit', function(data, cb)
    ClearPedTasksImmediately(PlayerPedId())
    closeGui()
    helpNotify = true
    cb('ok')
    pcall(function() -- Start log
        exports['azael_dc-serverlogs']:insertData({
            event = 'CloseCraftTableMenu',
            content = ('ผู้เล่นได้ทำการปิดเมนูโต๊ะคราฟ'):format(),
        })
    end) -- End Log
    ESX.TriggerServerCallback('cc_crafttable:clearMemory', function()

    end)
end)

local npcPed = nil

Citizen.CreateThread(function()
    local npcHash = GetHashKey("mp_f_freemode_01") -- NPC model (can be any valid ped model)
    RequestModel(npcHash)
    while not HasModelLoaded(npcHash) do
        Wait(1)
    end
    npcPed = CreatePed(4, npcHash,  130.47000122070312, -758.0599975585938, 250.1499938964844, 348.13, false, true)
    SetEntityAsMissionEntity(npcPed, true, true)
    SetBlockingOfNonTemporaryEvents(npcPed, true)
    PlaceObjectOnGroundProperly(npcPed)
    FreezeEntityPosition(npcPed, true)
    SetEntityInvincible(npcPed, true)
    --TaskPlayAnim(npcPed,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    -- Apply appearance changes from ESX data
    ApplyCustomAppearance(npcPed, skinData)
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


    --SetPedPropIndex(ped, 0, data["hat"], data["hat_2"], true) -- hat
    --SetPedPropIndex(ped, 1, data["glasses"], data["glasses_2"], true) -- glasses
    SetPedPropIndex(ped, 2, data["ear_accessories"], data["ear_accessories_2"], true) -- ear accessories
    SetPedPropIndex(ped, 6, data["watches_1"], data["watches_2"], true) -- watches
    SetPedPropIndex(ped, 7, data["bracelets_1"], data["bracelets_2"], true) -- bracelets
    --SetPedComponentVariation(ped, 1, 55, 0 / 10) -- mask
end
