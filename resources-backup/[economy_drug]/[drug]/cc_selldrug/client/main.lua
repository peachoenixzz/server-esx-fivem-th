stateDrug = false
npcKey = nil
sessionNPC = nil
totalNPC = Config.NPCCount
playerDoingSell = false
isDead = false
local nearCords = nil
local helpState = true

function failedNotifyDrug()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบขายยา', -- หัวเรื่อง
        description = 'คุณขายยาไม่สำเร็จ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function failedNotifyPolice()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบขายยา', -- หัวเรื่อง
        description = 'มีตำรวจไม่เพียงพอในประเทศ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_cop', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

RegisterNetEvent("cc_selldrug:updateDataNPCtoUser")
AddEventHandler("cc_selldrug:updateDataNPCtoUser", function()
    ESX.TriggerServerCallback('cc_selldrug:requestDataSellDrug', function(data)
        npcs = data
        Wait(200)
    end)
end)

RegisterNetEvent("cc_selldrug:updateBlip")
AddEventHandler("cc_selldrug:updateBlip", function()
    ESX.TriggerServerCallback('cc_selldrug:requestDataSellDrug', function(data)
        npcs = data
        Wait(500)
        handleBlip()
    end)
end)

RegisterNetEvent("cc_selldrug:unFreezePlayerSellDrug")
AddEventHandler("cc_selldrug:unFreezePlayerSellDrug", function()
    playerDoingSell = false
    FreezeEntityPosition(PlayerPedId(), false)
end)

RegisterNetEvent("cc_selldrug:failedToSell")
AddEventHandler("cc_selldrug:failedToSell", function()
    failedNotifyDrug()
    sellDrugFail()
end)

RegisterNetEvent("cc_selldrug:successToSell")
AddEventHandler("cc_selldrug:successToSell", function()
    sellDrugSuccess()
    pcall(function() -- Start log 
        exports['azael_dc-serverlogs']:insertData({
            event = 'DrugSellingSuccess',
            content = ('ผู้เล่นได้ทำการขายสิ่งเสพติดได้สำเร็จ'):format(),
        })
    end) -- End log
    deleteNPC()
end)

function sellDrugSuccess()
    local playerPed = PlayerPedId()
    Anim("amb@world_human_cheering@female_a", "base", {
        ["flag"] = 9,
        ["speed"] = 0.4
    })
    --AnimNPC("timetable@mime@ig_4", "very_fucking_funny", {
    --    ["flag"] = 9,
    --    ["speed"] = 0.4
    --}, sessionNPC)
    Wait(2000)
    playerDoingSell = false
    ClearPedTasks(playerPed)
    TriggerServerEvent("cc_selldrug:getDataNPC")
    openMenu = false
    nearCords = nil
    FreezeEntityPosition(PlayerPedId(), false)
end

Citizen.CreateThread(function()
    while true do
        ::startState::
        Citizen.Wait(0)
        if nearCords == nil and stateDrug then
            -- print("before")
            if #npcs ~= totalNPC then
                goto startState
            end
            -- print("after")
            for k, v in pairs(npcs) do
                local coords = GetPlayerCoordsAsync()
                if GetDistanceBetweenCoords(coords, v.positionNPC, true) < 20.0 and not v.alreadySell then
                    --print("get key")
                        nearCords = v.positionNPC
                        npcKey = k
                end
                if nearCords ~= nil and GetDistanceBetweenCoords(coords, v.positionNPC, true) < 3.0 and not v.alreadySell then
                    --print("can sell")
                    exports.helpnotify:showHelpNotification("กด", "E",
                            "เพื่อขายสิ่งเสพติด")
                    goto endState
                end
            end
            Citizen.Wait(500)
        end
        Citizen.Wait(300)
        ::endState::
    end
end)

Citizen.CreateThread(function()
    while true do
        ::reCheck::
        Citizen.Wait(0)
        if nearCords ~= nil then
            checkStateSellDrug()
            if IsControlJustReleased(0, 38) and not npcs[npcKey].alreadySell and not playerDoingSell and not IsPedInAnyVehicle(PlayerPedId())  then
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'PlayerSellingDrug',
                        content = ('ผู้เล่นได้ทำการกด E เพื่อทำการรขายสิ่งเสพติด'):format(),
                    })
                end) -- End log
                if not exports.Dv_Hunter_Check:CheckPolice(Config.itemSetting[itemNameState].cops) then
                    failedNotifyPolice()
                    goto reCheck
                end
                --print(npcKey)
                ESX.TriggerServerCallback('cc_selldrug:canSellDrug', function(canSell)
                    if canSell then
                        exports.helpnotify:hideHelpNotification()
                        playerDoingSell = true
                        miniGame()
                    end
                end,npcKey)
            end
        end
        if nearCords == nil then
            Citizen.Wait(1000)
        end
    end
end)

function deBuffPlayer()
    local playerPed = PlayerPedId()
    FreezeEntityPosition(PlayerPedId(), true)
    Anim("switch@trevor@head_in_sink", "trev_sink_exit", {
        ["flag"] = 9,
        ["speed"] = 0.4
    })
    TriggerEvent("Porpy_policealert:alertNet", "drug")
    local targetTime = GetGameTimer() + 12000
    while GetGameTimer() < targetTime do
        if isDead then
            break
        end
        Citizen.Wait(1000) -- Check every second
    end
    playerDoingSell = false
    ClearPedTasks(playerPed)
    FreezeEntityPosition(PlayerPedId(), false)
end

function miniGame()
    TriggerEvent("Porpy_policealert:alertNet", "drug")
    pcall(function() -- Start log
        exports['azael_dc-serverlogs']:insertData({
            event = 'MiniGameDrugSell',
            content = ('ผู้เล่นได้เริ่มเล่น mini game ในการขาย สิ่งเสพติด'):format(),
        })
    end) -- End log
    local success = exports.cc_minigame:StartLockPickCircle(5,5,1,'whitespace')
    if isDead then
        failedNotifyDrug()
        miniGameFail()
        return
    end
    if success then
        ProcessPhase()
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'MiniGameDrugSellComplete',
                content = ('ผู้เล่นได้เล่น mini game สำเร็จ จากการขาย สิ่งเสพติด'):format(),
            })
        end) -- End log
    else
        failedNotifyDrug()
        miniGameFail()
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'MiniGameDrugSellFail',
                content = ('ผู้เล่นได้เล่น mini game ไม่สำเร็จ จากการขาย สิ่งเสพติด'):format(),
            })
        end) -- End log
    end
end

function sellDrugFail()
    deBuffPlayer()
    --AnimNPC("cellphone@", "cellphone_call_listen_base", {
    --    ["flag"] = 9,
    --    ["speed"] = 0.6
    --}, sessionNPC)
    --TriggerEvent("Porpy_policealert:alertNet", "drug")
    deleteNPC()
    openMenu = false
    nearCords = false
end

function miniGameFail()
    deBuffPlayer()
    --AnimNPC("cellphone@", "cellphone_call_listen_base", {
    --    ["flag"] = 9,
    --    ["speed"] = 0.6
    --}, sessionNPC)
    TriggerServerEvent('cc_selldrug:playerFailMiniGame', npcKey)
    -- Citizen.SetTimeout(7000, function() -- wait 5 sec when delete NPC
    --    deleteNPC()
    --    openMenu = false
    --    nearCords = false
    -- end)
end

function checkStateSellDrug()
    local coords = GetPlayerCoordsAsync()
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        if GetDistanceBetweenCoords(coords, nearCords, true) > 2 then
            exports.helpnotify:hideHelpNotification()
            helpState = true
            nearCords = nil
        end
    end)
end

function GetPlayerCoordsAsync()
    return Citizen.InvokeNative(0x3FEF770D40960D5A, PlayerPedId(), Citizen.ReturnResultAnyway(),
            Citizen.ResultAsVector())
end

-- Disable controls while GUI open
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DisableActions(GetPlayerPed(-1))
    end
    Citizen.Wait(0)
end)

function DisableActions(ped)
    -- if playerDoingSell then
    --    --DisableControlAction(0, 1, true) -- LookLeftRight
    --    --DisableControlAction(0, 2, true) -- LookUpDown
    --    --DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
    -- end

    if playerDoingSell then
        DisableControlAction(0, 30, true) -- disable left/right
        DisableControlAction(0, 31, true) -- disable forward/back
        DisableControlAction(0, 36, true) -- INPUT_DUCK
        DisableControlAction(0, 21, true) -- disable sprint
        DisableControlAction(0, 23, true) -- disable sprint
    end

    if playerDoingSell then
        DisableControlAction(0, 63, true) -- veh turn left
        DisableControlAction(0, 64, true) -- veh turn right
        DisableControlAction(0, 71, true) -- veh forward
        DisableControlAction(0, 72, true) -- veh backwards
        DisableControlAction(0, 75, true) -- disable exit vehicle
    end

    if playerDoingSell then
        DisablePlayerFiring(ped, true) -- Disable weapon firing
        DisableControlAction(0, 24, true) -- disable attack
        DisableControlAction(0, 25, true) -- disable aim
        DisableControlAction(1, 37, true) -- disable weapon select
        DisableControlAction(0, 47, true) -- disable weapon
        DisableControlAction(0, 58, true) -- disable weapon
        DisableControlAction(0, 140, true) -- disable melee
        DisableControlAction(0, 141, true) -- disable melee
        DisableControlAction(0, 142, true) -- disable melee
        DisableControlAction(0, 143, true) -- disable melee
        DisableControlAction(0, 263, true) -- disable melee
        DisableControlAction(0, 264, true) -- disable melee
        DisableControlAction(0, 257, true) -- disable melee
    end
end

function ProcessPhase()
    pcall(function() -- Start log
        exports['azael_dc-serverlogs']:insertData({
            event = 'PlayerDrugSellTransaction',
            content = ('ผู้เล่นกำลังทำการขายสิ่งเสพติด'):format(),
        })
    end) -- End log
    TriggerEvent("mythic_progbar:client:progress", {
        name = "ProcessPhase",
        duration = 12000,
        label = "กำลังรอผู้รับซื้อเช็คของ",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
        },
        animation = {
            animDict = "amb@prop_human_bum_bin@base", -- ท่าทางเวลาขุด
            anim = "base", -- ท่าทางเวลาขุด
            flags = 9
        }
    }, function(status)
        if not status then
            TriggerServerEvent('cc_selldrug:sellDrug',npcKey)
            TriggerServerEvent('cc_selldrug:deleteDrugSeller',npcKey)
        end
    end)
end

AddEventHandler('esx:onPlayerDeath', function(data)
    isDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
    isDead = false
end)
