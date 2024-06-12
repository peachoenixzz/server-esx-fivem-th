Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function unJailMenu()
    local elements = {}
    ESX.TriggerServerCallback("cc_unjail:retrieveJailedPlayers", function(playerArray)

        if #playerArray == 0 then
            return
        end

        for i = 1, #playerArray, 1 do
            table.insert(elements, {label = "Prisoner: " .. playerArray[i].name .. " | Jail Time: " .. playerArray[i].jailTime .. " minutes", value = playerArray[i].identifier })
        end

        ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'jail_unjail_menu',
                {
                    title = "Unjail Player",
                    align = "center",
                    elements = elements
                },
                function(data, menu)

                    local action = data.current.value

                    ESX.TriggerServerCallback('cc_coreeffect:deleteDebuffByIdentifier', function() end,action,"in_jail")
                    ESX.TriggerServerCallback('cc_coreeffect:deleteDebuffByIdentifier', function() end,action,"escape_prison_gps")
                    ESX.TriggerServerCallback('cc_coreeffect:deleteDebuffByIdentifier', function() end,action,"anonymous_gps")
                    TriggerServerEvent('cc_prisongps:untrackprisonGpsBlipFormUnjail', action)
                    menu.close()
                    onUnjailPlayer()
                    pcall(function() -- Start log
                        exports['azael_dc-serverlogs']:insertData({
                            event = 'PoliceUnjail',
                            content = ('ผู้เล่นได้ทำการยกเลิกจำคุก %s แล้ว'):format(data.current.label),
                        })
                    end) -- End log
                end, function(data, menu)
                    menu.close()
                end)
    end)

end


function onUnjailPlayer()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบตำรวจ', -- หัวเรื่อง
        description = 'ยกเลิกจำคุกเรียบร้อย', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'unjail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end