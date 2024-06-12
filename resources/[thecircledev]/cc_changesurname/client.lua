ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- Define the skin data
local skinData = {
    ["torso_2"] = 1,
    ["shoes_1"] = 19,
    ["bags_1"] = 0,
    ["complexion_2"] = 0,
    ["tshirt_2"] = 0,
    ["beard_1"] = 10,
    ["eyebrows_1"] = 30,
    ["skin"] = 4,
    ["lipstick_3"] = 24,
    ["face"] = 0,
    ["arms_2"] = 0,
    ["decals_1"] = 0,
    ["chain_1"] = 0,
    ["watches_1"] = -1,
    ["helmet_1"] = -1,
    ["chain_2"] = 0,
    ["moles_2"] = 0,
    ["ears_2"] = 0,
    ["beard_4"] = 0,
    ["bproof_2"] = 0,
    ["blush_1"] = 0,
    --["sex"] = 0,
    ["chest_1"] = 0,
    ["ears_1"] = 5,
    ["tshirt_1"] = 19,
    ["makeup_2"] = 0,
    ["watches_2"] = 0,
    ["chest_2"] = 0,
    ["bracelets_1"] = -1,
    ["chest_3"] = 0,
    ["glasses_1"] = 5,
    ["blush_3"] = 0,
    ["eyebrows_2"] = 10,
    ["bags_2"] = 0,
    ["complexion_1"] = 0,
    ["helmet_2"] = 0,
    ["lipstick_1"] = 0,
    ["hair_color_1"] = 4,
    ["glasses_2"] = 0,
    ["decals_2"] = 0,
    ["blush_2"] = 0,
    ["mask_2"] = 0,
    ["mask_1"] = 0,
    ["arms"] = 4,
    ["beard_3"] = 5,
    ["makeup_3"] = 0,
    ["eyebrows_4"] = 0,
    ["lipstick_4"] = 24,
    ["age_1"] = 0,
    ["age_2"] = 0,
    ["bproof_1"] = 0,
    ["hair_2"] = 0,
    ["shoes_2"] = 1,
    ["bracelets_2"] = 0,
    ["hair_color_2"] = 61,
    ["hair_1"] = 75,
    ["lipstick_2"] = 8,
    ["torso_1"] = 16,
    ["makeup_1"] = 0,
    ["pants_1"] = 16,
    ["beard_2"] = 8,
    ["moles_1"] = 0,
    ["makeup_4"] = 0,
    ["eye_color"] = 0,
    ["eyebrows_3"] = 0,
    ["pants_2"] = 0
}

-- local npcPed = nil
-- local inzonelastName = false
-- Citizen.CreateThread(function()
--     local npcHash = GetHashKey("mp_m_freemode_01") -- NPC model (can be any valid ped model)
--     RequestModel(npcHash)
--     while not HasModelLoaded(npcHash) do
--         Wait(1)
--     end

--     npcPed = CreatePed(4, npcHash, 214.02000427246097, -918.739990234375, 29.94000053405761, 70.1, false, true)
--     SetEntityAsMissionEntity(npcPed, true, true)
--     SetBlockingOfNonTemporaryEvents(npcPed, true)
--     FreezeEntityPosition(npcPed, true)
--     SetEntityInvincible(npcPed, true)
--     --TaskPlayAnim(npcPed,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
--     -- Apply appearance changes from ESX data
--     ApplyCustomAppearance(npcPed, skinData)
-- end)

-- local lastnameZone = PolyZone:Create({
--     vector3(211.6199951171875, -919.8800048828124, 30.92000007629394),
--     vector3(213.02999877929688, -916.27001953125, 30.95000076293945),
--     vector3(216.7299957275391, -917.989990234375, 30.89999961853027),
--     vector3(215.36000061035156, -921.3800048828124, 30.8700008392334),
-- },{
--     name = "lastname_zone",
--     minZ = 28,
--     maxZ = 34,
--     debugPoly = false,
-- })

-- lastnameZone:onPlayerInOut(function(isPointInside, point)
--     if isPointInside then
--         inzonelastName = true
--         exports.helpnotify:showHelpNotification("กด","E","เพื่อเปลี่ยนนามสกุล")
--     else
--         inzonelastName = false
--         exports.helpnotify:hideHelpNotification()
--     end
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(1)
--         if inzonelastName == true then
--             if IsControlJustReleased(0, 38) then -- "E" key
--                 OpenSurnameMenu()
--                 exports.helpnotify:hideHelpNotification()
--             end
--         else
--             Citizen.Wait(500)
--         end
--     end
-- end)

-- Open the surname menu
-- function OpenSurnameMenu()
--     local elements = {
--         { label = "ใช้เงิน 50,000$", value = "money" },
--         { label = "ใช้บัตรเปลี่ยนนามสกุล", value = "rename_card" },
--     }

--     ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'surname_menu', {
--         title = "Change Lastname",
--         align = 'top-right',
--         elements = elements
--     }, function(data, menu)
--         local action = data.current.value

--         if action == "money" then
--             CreateSurname("money")
--         end

--         if action == "rename_card" then
--             CreateSurname("rename_card")
--         end

--     end, function(data, menu)
--         menu.close()
--     end)
-- end

RegisterNetEvent('cc_changesurname:usecard')
AddEventHandler('cc_changesurname:usecard', function ()
    CreateSurname("rename_card")
end)

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

function CreateSurname(type)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog_surname',
            {
                title = "ใส่นามสกุล",
            }, function(data, menu)
                if data.value == nil then
                    exports.nc_notify:PushNotification({
                        scale = 1.0, -- ปรับขนาดของ Notify
                        title = 'ระบบเปลี่ยนนามสกุล', -- หัวเรื่อง
                        description = 'กรุณาใส่นามสกุล', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                        icon = 'detail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                        duration = 3000 -- ระยะเวลาการแสดง Notify
                    })
                end
                if string.match(data.value, "^[A-Z][a-zA-Z]*$") then
                    ESX.TriggerServerCallback('cc_changesurname:updateSurname', function(success)
                        if success then
                            -- Surname successfully updated
                            exports.nc_notify:PushNotification({
                                scale = 1.0, -- ปรับขนาดของ Notify
                                title = 'ระบบเปลี่ยนนามสกุล', -- หัวเรื่อง
                                description = 'เปลี่ยนนามสกุลสำเร็จ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                                type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                                position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                                direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                                priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                                icon = 'detail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                                duration = 3000 -- ระยะเวลาการแสดง Notify
                            })
                        else
                            -- Handle error
                            exports.nc_notify:PushNotification({
                                scale = 1.0, -- ปรับขนาดของ Notify
                                title = 'ระบบเปลี่ยนนามสกุล', -- หัวเรื่อง
                                description = 'มีข้อผิดพลาดเกิดขึ้น', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                                type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                                position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                                direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                                priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                                icon = 'detail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                                duration = 3000 -- ระยะเวลาการแสดง Notify
                            })
                        end
                        menu.close()
                    end, data.value ,type)
                    menu.close()
                else
                    exports.nc_notify:PushNotification({
                        scale = 1.0, -- ปรับขนาดของ Notify
                        title = 'ระบบเปลี่ยนนามสกุล', -- หัวเรื่อง
                        description = 'ต้องมีอักษรตัวใหญ่และไม่มีอักษรพิเศษหรือตัวเลข', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                        icon = 'detail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                        duration = 4000 -- ระยะเวลาการแสดง Notify
                    })
                end
            end, function(data, menu)
                menu.close()
            end)
end