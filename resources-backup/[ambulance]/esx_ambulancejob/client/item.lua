helpNotify = true
local stackHeal = 0
RegisterNetEvent('esx_ambulancejob:useItem')
AddEventHandler('esx_ambulancejob:useItem', function(itemName)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        local stateEndAnimation = false
        if itemName == 'painkiller' or itemName == 'gov_painkiller' then
            stackHeal = stackHeal+1
            local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
            local playerPed = PlayerPedId()
            ESX.Streaming.RequestAnimDict(lib, function()
                isUseItemHeal = true
                showMedicBag()
                TaskPlayAnim(playerPed, lib, anim, 12.0, -8.0, -1, 0, 0, false, false, false)
                Wait(3500)
                RemoveAnimDict(lib)
                TriggerEvent('esx_ambulancejob:heal', 'big', true)
                stackHeal = stackHeal-1
                DeleteEntity(propMedic)
                if stackHeal == 0 then
                    ClearPedTasks(playerPed)
                    ClearPedSecondaryTask(playerPed)
                end
                isUseItemHeal = false
            end)
        elseif itemName == 'bandage' then
            stackHeal = stackHeal+1
            local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
            local playerPed = PlayerPedId()
            ESX.Streaming.RequestAnimDict(lib, function()
                isUseItemHeal = true
                TaskPlayAnim(playerPed, lib, anim, 12.0, -8.0, -1, 0, 0, false, false, false)
                Wait(3500)
                RemoveAnimDict(lib)
                TriggerEvent('esx_ambulancejob:heal', 'small', true)
                stackHeal = stackHeal-1
                if stackHeal == 0 then
                    ClearPedTasks(playerPed)
                    ClearPedSecondaryTask(playerPed)
                end
                isUseItemHeal = false
            end)
        end
    end
end)

RegisterNetEvent('esx_ambulancejob:useItemTraining')
AddEventHandler('esx_ambulancejob:useItemTraining', function(itemName)
    if exports.cc_training:checkInZoneTraining() then
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            local stateEndAnimation = false
            if itemName == 'r_painkiller' then
                stackHeal = stackHeal+1
                local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
                local playerPed = PlayerPedId()
                ESX.Streaming.RequestAnimDict(lib, function()
                    isUseItemHeal = true
                    showMedicBag()
                    TaskPlayAnim(playerPed, lib, anim, 12.0, -8.0, -1, 0, 0, false, false, false)
                    Wait(3500)
                    RemoveAnimDict(lib)
                    TriggerEvent('esx_ambulancejob:heal', 'big', true)
                    stackHeal = stackHeal-1
                    DeleteEntity(propMedic)
                    if stackHeal == 0 then
                        ClearPedTasks(playerPed)
                        ClearPedSecondaryTask(playerPed)
                    end
                    isUseItemHeal = false
                end)
            elseif itemName == 'r_bandage' then
                stackHeal = stackHeal+1
                local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
                local playerPed = PlayerPedId()
                ESX.Streaming.RequestAnimDict(lib, function()
                    isUseItemHeal = true
                    TaskPlayAnim(playerPed, lib, anim, 12.0, -8.0, -1, 0, 0, false, false, false)
                    Wait(3500)
                    RemoveAnimDict(lib)
                    TriggerEvent('esx_ambulancejob:heal', 'small', true)
                    stackHeal = stackHeal-1
                    if stackHeal == 0 then
                        ClearPedTasks(playerPed)
                        ClearPedSecondaryTask(playerPed)
                    end
                    isUseItemHeal = false
                end)
            end
        end
    else
        exports.nc_notify:PushNotification({
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'สนามฝึกซ้อม', -- หัวเรื่อง
            description = 'คุณไม่ได้อยู่ในพื้นที่ฝึกซ้อม', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'detail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 3000 -- ระยะเวลาการแสดง Notify
        })
    end
end)

function showMedicBag()
    DeleteEntity(propMedic)
    local playerPed = PlayerPedId()
    local boneIndex = GetPedBoneIndex(playerPed, 60309) -- hand bone
    local modelHash = GetHashKey("xm_prop_smug_crate_s_medical")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    propMedic = CreateObject(modelHash, 0.0, 0.0, 0.0, true, true, true)
    AttachEntityToEntity(propMedic, playerPed, boneIndex, 0.06, -0.06, 0.05, -110.0, 0.0, 0.0, true, true, false, true, 1, true)
end

function GetClosestPlayer(radius, cb)
    local playerped = PlayerPedId()
    local playercoord = GetEntityCoords(playerped)
    local playerlist = ESX.Game.GetPlayersInArea(playercoord, radius)

    local checklist = {}
    local asyncTasks = {}

    for index, player in pairs(playerlist) do
        table.insert(asyncTasks, function(cb)
            local ped = GetPlayerPed(player)
            local serverid = GetPlayerServerId(player)
            local EntityCoord = GetEntityCoords(ped)
            local Distance = GetDistanceBetweenCoords(playercoord, EntityCoord, true)

            GetDeathStatus(serverid, function(data)
                local deathstatus = 0
                if data == true then
                    deathstatus = 1
                end

                table.insert(checklist, { serverid, Distance, deathstatus, data, player })
                cb()
            end)
        end)
    end



    Async.parallel(asyncTasks, function(results)

        table.sort(checklist, function(a, b)
            return a[2] < b[2]
        end)

        table.sort(checklist, function(a, b)
            return a[3] > b[3]
        end)

        cb(checklist)
    end)
end

function GetDeathStatus(target, cb)
    local targetped = GetPlayerFromServerId(target)
    local deathstatus = Entity(GetPlayerPed(targetped)).state.isDead

    if deathstatus ~= nil then
        cb(deathstatus)
    else
        local asyncTasks = {}
        table.insert(asyncTasks, function(cb)
            ESX.TriggerServerCallback('carry_cc:getdeathstatus', function(data)
                if data == nil then
                    cb(false)
                else
                    cb(data)
                end
            end, target)
        end)

        Async.parallel(asyncTasks, function(results)
            cb(results[1])
        end)
    end

end

RegisterNetEvent('esx_ambulancejob:useItemRevive')
AddEventHandler('esx_ambulancejob:useItemRevive', function(itemName)
    GetClosestPlayer(3, function(list)
        if list[1] == nil then return end
        local player = list[1]
        local closestPlayer = player[5]
        if closestPlayer ~= -1 and not IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) and not IsPedInAnyVehicle(PlayerPedId()) and not isBusy then
            local target = player[1]
            validateItemRevive(itemName,closestPlayer)
            pcall(function() -- Start Log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AmbulanceUseItemRevive',
                    content = ('ผู้เล่นได้ทำการกดใช้ %s เพื่อทำการชุบชีวิต'):format(itemName),
                })
            end) -- End Log
            return
        end
        if closestPlayer == -1 then
            exports.nc_notify:PushNotification({
                scale = 1.0, -- ปรับขนาดของ Notify
                title = 'ระบบชุบ', -- หัวเรื่อง
                description = 'ไม่มีผู้เล่นในบริเวณนี้', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                icon = 'no_player', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                duration = 5000 -- ระยะเวลาการแสดง Notify
            })
        end
        if isBusy then
            exports.nc_notify:PushNotification({
                scale = 1.0, -- ปรับขนาดของ Notify
                title = 'ระบบชุบ', -- หัวเรื่อง
                description = 'คุณทำการกระทำอื่นอยู่', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                icon = 'cooldown', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                duration = 5000 -- ระยะเวลาการแสดง Notify
            })
        end
    end)
end)


function validateItemRevive(itemName,closestPlayer)
    --print("validate zone : ", itemName)
    --print(IsPedDeadOrDying(GetPlayerPed(closestPlayer), 1))
    ESX.TriggerServerCallback('esx_ambulancejob:checkDeadPlayer', function(playerDead)
        if not IsPedInAnyVehicle(PlayerPedId(), false) and not isBusy and playerDead then
            if itemName == 'gov_aed' then
                isBusy = true
                local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
                local playerPed = PlayerPedId()
                exports.nc_notify:PushNotification({
                    scale = 1.0, -- ปรับขนาดของ Notify
                    title = 'ระบบชุบ', -- หัวเรื่อง
                    description = 'เริ่มต้นชุบผู้เล่น', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                    type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                    position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                    direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                    priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                    icon = 'medkit', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                    duration = 5000 -- ระยะเวลาการแสดง Notify
                })
                ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                    if quantity > 0 then
                        processReviveCitizen(9000,closestPlayer,itemName)
                        for i = 1, 18 do
                            Wait(500)
                            ESX.Streaming.RequestAnimDict(lib, function()
                                TaskPlayAnim(playerPed, lib, anim, 12.0, -8.0, -1, 0, 0.0, false, false, false)
                                RemoveAnimDict(lib)
                            end)
                            if not isBusy then
                                ClearPedTasksImmediately(PlayerPedId())
                                break
                            end
                        end
                    end
                end, 'gov_aed')
            end
            if itemName == 'aed' then
                isBusy = true
                local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
                local playerPed = PlayerPedId()
                exports.nc_notify:PushNotification({
                    scale = 1.0, -- ปรับขนาดของ Notify
                    title = 'ระบบชุบ', -- หัวเรื่อง
                    description = 'เริ่มต้นชุบผู้เล่น', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                    type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                    position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                    direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                    priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                    icon = 'medkit', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                    duration = 5000 -- ระยะเวลาการแสดง Notify
                })
                ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                    if quantity > 0 then
                        processReviveCitizen(9000,closestPlayer,itemName)
                        for i = 1, 18 do
                            Wait(500)
                            ESX.Streaming.RequestAnimDict(lib, function()
                                TaskPlayAnim(playerPed, lib, anim, 12.0, -8.0, -1, 0, 0.0, false, false, false)
                                RemoveAnimDict(lib)
                            end)
                            if not isBusy then
                                ClearPedTasksImmediately(PlayerPedId())
                                break
                            end
                        end
                    end
                end, 'aed')
            end
            if itemName == 'r_aed' then
                if exports.cc_training:checkInZoneTraining() then
                    isBusy = true
                    local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
                    local playerPed = PlayerPedId()
                    exports.nc_notify:PushNotification({
                        scale = 1.0, -- ปรับขนาดของ Notify
                        title = 'ระบบชุบ', -- หัวเรื่อง
                        description = 'เริ่มต้นชุบผู้เล่น', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                        type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                        icon = 'medkit', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                        duration = 5000 -- ระยะเวลาการแสดง Notify
                    })
                    ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
                        if quantity > 0 then
                            processReviveCitizen(9000,closestPlayer,itemName)
                            for i = 1, 18 do
                                Wait(500)
                                ESX.Streaming.RequestAnimDict(lib, function()
                                    TaskPlayAnim(playerPed, lib, anim, 12.0, -8.0, -1, 0, 0.0, false, false, false)
                                    RemoveAnimDict(lib)
                                end)
                                if not isBusy then
                                    ClearPedTasksImmediately(PlayerPedId())
                                    break
                                end
                            end
                        end
                    end, 'r_aed')
                else
                    exports.nc_notify:PushNotification({
                        scale = 1.0, -- ปรับขนาดของ Notify
                        title = 'สนามฝึกซ้อม', -- หัวเรื่อง
                        description = 'คุณไม่ได้อยู่ในพื้นที่ฝึกซ้อม', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                        icon = 'detail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                        duration = 3000 -- ระยะเวลาการแสดง Notify
                    })
                end
            end
        end

        if not isBusy and not playerDead then
            exports.nc_notify:PushNotification({
                scale = 1.0, -- ปรับขนาดของ Notify
                title = 'ระบบชุบ', -- หัวเรื่อง
                description = 'ผู้เล่นท่านนี้ไม่ได้หมดสติ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
                position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                icon = 'no_player', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                duration = 5000 -- ระยะเวลาการแสดง Notify
            })
        end
    end,GetPlayerServerId(closestPlayer))
end

function processReviveCitizen(time,closestPlayer,itemName)
    onProcess = true
    helpNotify = false
    exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
    TriggerEvent("mythic_progbar:client:progress",{
        name = "RevivePlayer",
        duration = time,
        label = "กำลังดำเนินการ",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = false,
        },
        animation = {
            animDict = "mini@cpr@char_a@cpr_str",
            anim = "cpr_pumpchest",
            flags = 33,
        },
    }, function(status)
        --print(status)
        if not status then
            TriggerServerEvent('esx_ambulancejob:citizenRevive', GetPlayerServerId(closestPlayer),itemName)
            exports.helpnotify:hideHelpNotification()
            helpNotify = true
            onProcess = false
            --print("process Zone",itemName)
            if itemName ~= "r_aed" then
                TriggerServerEvent('esx_ambulancejob:removeItem', itemName)
            end
            isBusy = false
        end
        isBusy = false
    end)
end

Citizen.CreateThread(function()
    --cpr
    --For Log Purpose
    --local playerPed = PlayerPedId()
    -- End Log
    while true do
        --print("busy",isBusy)
        --print("onprocess",onProcess)
        --print("help",helpNotify)
            if isBusy and not onProcess then
                --DisableControlAction(0, 245, true) -- T
                DisableControlAction(0, 73, true) -- X
            end

            if onProcess then
                --DisableControlAction(0, 245, true) -- T
            end

            if IsControlJustPressed(0,73) and onProcess and not helpNotify and isBusy then
                exports.helpnotify:hideHelpNotification()
                TriggerEvent("mythic_progbar:client:cancel")
                onProcess = false
                helpNotify = true
                isBusy = false
                pcall(function() -- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'AmbulanceActionCancel',
                        content = ('ผู้เล่นได้ทำการกด X เพื่อหยุดการทำใช้ item เกี่ยวกับหมอ'):format(),
                    })
                end) -- End Log
            end
            Citizen.Wait(0)
    end

    Citizen.Wait(0)
end)

Citizen.CreateThread(function()
    while true do

        if isUseItemHeal then
            DisableControlAction(0, 73, true) -- X
        end

        Citizen.Wait(0)
    end
    Citizen.Wait(0)
end)
