Citizen.CreateThread(function()
    local time = 500
    local helpNotify = true
    while true do 
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local check = false
        for k, v in pairs(Config['ShopPosition']) do 
            for _k, _v in pairs(v) do 
                if GetDistanceBetweenCoords(_v.zone, coords, false) <= _v.rad then 
                    check = true
                    if _v.marker then
                        if helpNotify then
                            exports.helpnotify:showHelpNotification("กด","E","เพื่อใช้ร้านเสื้อผ้า")
                            helpNotify = false
                        end
                        DrawCustomMarker(_v.marker.type, _v.zone, _v.marker.size, _v.marker.color)
                    end
                    if IsControlJustPressed(0, 38) and IsPedOnFoot(ped) then
                        exports.helpnotify:hideHelpNotification()
                        OpenShop(k)
                    end
                end
            end
        end

        if check then 
            time = 0
        else
            if not helpNotify then
                helpNotify = true
                exports.helpnotify:hideHelpNotification()
            end
            time = 500
        end
        Wait(time)
    end
end)


function DrawCustomMarker(mtype, zone, size, color)
    DrawMarker(mtype, zone.x, zone.y, zone.z - 1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, size[1], size[2],  size[3], color[1], color[2], color[3], color[4], false, true, 2, false, false, false, false)
    -- DrawMarker(mtype, zone.x, zone.y, zone.z - 0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, size[1], size[2],  0.2, color[1], color[2], color[3], color[4], false, true, 2, false, false, false, false)
    -- DrawMarker(mtype, zone.x, zone.y, zone.z - 0.5, 0.0, 0.0, 0.0, 0, 0.0  -180.0, 0.0, size[1], size[2],  0.2, color[1], color[2], color[3], color[4], false, true, 2, false, false, false, false)
end

function OpenShop(k)
    if k == 'BarberShop' then 
        OpenMenuBaber({
            'beard_1', 'beard_2', 'beard_3', 'beard_4', 'hair_1', 'hair_2', 'hair_color_1',
            'hair_color_2', 'eyebrows_1', 'eyebrows_2', 'eyebrows_3', 'eyebrows_4', 'makeup_1', 'makeup_2',
            'makeup_3', 'makeup_4', 'lipstick_1', 'lipstick_2', 'lipstick_3', 'lipstick_4', 'ears_1',
            'ears_2', 'blush_1', 'blush_2', 'blush_3',
        })
    elseif k == 'ClotheShop' then
        OpenMenuClothShop({ 
            'tshirt_1',	'tshirt_2', 'torso_1', 'torso_2', 'decals_1', 'decals_2', 'arms',
            'arms_2', 'pants_1', 'pants_2', 'shoes_1', 'shoes_2', 'chain_1', 'chain_2',
            'helmet_1', 'helmet_2', 'glasses_1', 'glasses_2', 'bags_1', 'bags_2',
            'bproof_1', 'bproof_2', 'watches_1', 'watches_2', 'bracelets_1', 'bracelets_2'
        })
    elseif k == 'MaskShop' then 
        OpenMenuMaskShop({
            'mask_1', 'mask_2',
        })
    elseif k == 'Locker' then 
        OpenMenuLocker()
    end
end