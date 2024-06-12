onEating = false

RegisterNetEvent('useMeal')
AddEventHandler('useMeal', function (xItem)	
    for _,v in pairs(Config.AllMeal) do
        if v.ItemName == xItem then
            onEating = true
            processMeal(v.Hunger, v.Health, v.Stress, v.AnimDict, v.Anim ,v.Prop, v.PropBone, v.PropCoord, v.PropRotation, v.time, v.ItemName)
            onGoingeat()
            pcall(function() -- Start Log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'PlayerEatingMeal',
                    content = ('ผู้เล่นกำลังกิน %s'):format(v.ItemName),
                })
            end) -- End Log
            break
        end
    end
end)


function processMeal(hungerCount, healthCount, stressCount, AnimationDict, Animation, Prop, PropBone, PropCoord, PropRotation, time, ItemName)
    local tbl = time
    local eatTime = tbl[math.random(1, #tbl)]	
    TriggerEvent("mythic_progbar:client:progress",{
        name = "useIcecream",
        duration = eatTime,
        label = "กำลังกินราเม็ง",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = AnimationDict,
            anim = Animation,
            flags = 49
        },
        prop = {
            model = Prop, 
            bone = PropBone,
            coords = PropCoord,
            rotation = PropRotation,
        }
    }, function(status)
        if not status then
            onEating = false
            exports.helpnotify:hideHelpNotification()
            ESX.TriggerServerCallback('cc_useallmeal:checkitem', function(success)
                if success then
                    TriggerEvent('esx_status:add', 'hunger', hungerCount)
                    TriggerEvent('esx_status:add', 'thirst', healthCount)
                    TriggerEvent('esx_status:remove', 'stress', stressCount)
                    pcall(function() -- Start Log
                        exports['azael_dc-serverlogs']:insertData({
                            event = 'DoneEatingMeal',
                            content = ('ผู้เล่นได้กินอาหารสำเร็จ'):format(),
                        })
                    end) -- End Log
                else
                    noMeal()
                end
            end, ItemName)
        end
    end)
end

function onGoingeat()
    exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
    Citizen.CreateThread(function()
        while onEating do
            Citizen.Wait(0)
            if onEating then
                DisableControlAction(0,Config.Key['F'], true)
                DisableControlAction(0,Config.Key['F1'], true)
                DisableControlAction(0,Config.Key['H'], true)
                DisableControlAction(0,Config.Key['E'], true)
                DisableControlAction(0, 75, true) --ลงรถ
                DisableControlAction(0, 101, true) -- บล็อกสไลด์
                DisableControlAction(0, 104, true) -- บล็อกสไลด์
                DisableControlAction(0, 304	, true) -- บล็อกสไลด์
            end
            if IsControlJustPressed(0,73) and onEating then
                exports.helpnotify:hideHelpNotification()
                TriggerEvent("mythic_progbar:client:cancel")
                onEating = false
                pcall(function() -- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'CancelEatingMeal',
                        content = ('ผู้เล่นได้ทำการกด X เพื่อ ยกเลิกการกินอาหาร'):format(),
                    })
                end) -- End Log	
            end 
            if IsControlJustPressed(0,105) and onEating then
                exports.helpnotify:hideHelpNotification()
                TriggerEvent("mythic_progbar:client:cancel")
                onEating = false
                pcall(function() -- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'CancelEatingMeal',
                        content = ('ผู้เล่นได้ทำการกด X เพื่อ ยกเลิกการกินอาหาร'):format(),
                    })
                end) -- End Log	
            end
            if IsControlJustPressed(0,120) and onEating then
                exports.helpnotify:hideHelpNotification()
                TriggerEvent("mythic_progbar:client:cancel")
                onEating = false
                pcall(function() -- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'CancelEatingMeal',
                        content = ('ผู้เล่นได้ทำการกด X เพื่อ ยกเลิกการกินอาหาร'):format(),
                    })
                end) -- End Log	
            end 
            if IsControlJustPressed(0,337) and onEating then
                exports.helpnotify:hideHelpNotification()
                TriggerEvent("mythic_progbar:client:cancel")
                onEating = false
                pcall(function() -- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'CancelEatingMeal',
                        content = ('ผู้เล่นได้ทำการกด X เพื่อ ยกเลิกการกินอาหาร'):format(),
                    })
                end) -- End Log	
            end 
            if IsControlJustPressed(0,345) and onEating then
                exports.helpnotify:hideHelpNotification()
                TriggerEvent("mythic_progbar:client:cancel")
                onEating = false
                pcall(function() -- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'CancelEatingMeal',
                        content = ('ผู้เล่นได้ทำการกด X เพื่อ ยกเลิกการกินอาหาร'):format(),
                    })
                end) -- End Log	
            end 
            if IsControlJustPressed(0,354) and onEating then
                exports.helpnotify:hideHelpNotification()
                TriggerEvent("mythic_progbar:client:cancel")
                onEating = false
                pcall(function() -- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'CancelEatingMeal',
                        content = ('ผู้เล่นได้ทำการกด X เพื่อ ยกเลิกการกินอาหาร : พิกัด %s'):format(GetEntityCoords(PlayerPedId())),
                    })
                end) -- End Log	
            end 
            if IsControlJustPressed(0,357) and onEating then
                exports.helpnotify:hideHelpNotification()
                TriggerEvent("mythic_progbar:client:cancel")
                onEating = false
                pcall(function() -- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'CancelEatingMeal',
                        content = ('ผู้เล่นได้ทำการกด X เพื่อ ยกเลิกการกินอาหาร : พิกัด %s'):format(GetEntityCoords(PlayerPedId())),
                    })
                end) -- End Log	
            end 
        end
    end)
end

AddEventHandler('esx:onPlayerDeath', function() 
	if onEating then
		onEating = false
        TriggerEvent("mythic_progbar:client:cancel")
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PlayerDeadWhileEatingMeal',
                content = ('ผู้เล่นได้ตาย ระหว่างการกินอาหาร'):format(),
            })
        end) -- End Log	
	end
end)

function noMeal()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบกินอาหาร', -- หัวเรื่อง
        description = 'คุณไม่มีอาหาร', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end



