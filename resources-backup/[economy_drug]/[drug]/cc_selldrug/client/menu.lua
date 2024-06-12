propCase = nil
itemNameState = nil

Citizen.CreateThread(function()
    local modelHash = GetHashKey("prop_security_case_01")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        -- print("cant load model")
        Citizen.Wait(0)
    end
end)

function showSuitCase()
    DeleteEntity(propCase)
    local playerPed = PlayerPedId()
    local boneIndex = GetPedBoneIndex(playerPed, 57005) -- right hand bone
    local modelHash = GetHashKey("prop_security_case_01")
    propCase = CreateObject(modelHash, 0.0, 0.0, 0.0, true, true, true)
    AttachEntityToEntity(propCase, playerPed, boneIndex, 0.10, 0.0, 0.0, 0.0, 280.0, 53.0, true, true, false, true, 1, true)
end

function sellState()
    stateDrug = true
    -- print(stateDrug)
end

function cancelState()
    stateDrug = false
    -- print(stateDrug)
end

function suiteCaseAnim(animType)
    if animType == "use" then
        Anim("reaction@intimidation@1h", "outro", {
            ["flag"] = 48,
            ["speedMultiplier"] = -2.0
        })
    end
    if animType == "cancel" then
        Anim("reaction@intimidation@1h", "intro", {
            ["flag"] = 48,
            ["speedMultiplier"] = -2.0
        })
    end
end

Anim = function(dict, anim, settings)
    if dict then
        Citizen.CreateThread(function()
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(100)
            end

            if settings == nil then
                TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
            else
                local speed = 1.0
                local speedMultiplier = -1.0
                local duration = 1.0
                local flag = 0
                local playbackRate = 0

                if settings["speed"] then
                    speed = settings["speed"]
                end

                if settings["speedMultiplier"] then
                    speedMultiplier = settings["speedMultiplier"]
                end

                if settings["duration"] then
                    duration = settings["duration"]
                end

                if settings["flag"] then
                    flag = settings["flag"]
                end

                if settings["playbackRate"] then
                    playbackRate = settings["playbackRate"]
                end

                TaskPlayAnim(PlayerPedId(), dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
            end

            RemoveAnimDict(dict)
        end)
    else
        TaskStartScenarioInPlace(PlayerPedId(), anim, 0, true)
    end
end

AnimNPC = function(dict, anim, settings, sessionNPC)
    if dict then
        Citizen.CreateThread(function()
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(100)
            end

            if settings == nil then
                TaskPlayAnim(sessionNPC, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
            else
                local speed = 1.0
                local speedMultiplier = -1.0
                local duration = 1.0
                local flag = 0
                local playbackRate = 0

                if settings["speed"] then
                    speed = settings["speed"]
                end

                if settings["speedMultiplier"] then
                    speedMultiplier = settings["speedMultiplier"]
                end

                if settings["duration"] then
                    duration = settings["duration"]
                end

                if settings["flag"] then
                    flag = settings["flag"]
                end

                if settings["playbackRate"] then
                    playbackRate = settings["playbackRate"]
                end

                TaskPlayAnim(sessionNPC, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
            end

            RemoveAnimDict(dict)
        end)
    else
        TaskStartScenarioInPlace(sessionNPC, anim, 0, true)
    end
end

local openMenu = false

function checkItem()
    Citizen.CreateThread(function()
        while stateDrug do
            Citizen.Wait(2000)
            TriggerServerEvent('cc_selldrug:checkItem')
        end
    end)
end

RegisterNetEvent("cc_selldrug:resetStatePlayer")
AddEventHandler("cc_selldrug:resetStatePlayer", function()
    Citizen.CreateThread(function()
        stateDrug = false
        DeleteEntity(propCase)
        propCase = nil
    end)
end)

RegisterNetEvent("cc_selldrug:openMenu")
AddEventHandler("cc_selldrug:openMenu", function(labelName, itemName)
    if not openMenu then
        local elements = {{
            label = 'เสพยา',
            value = 'useDrug'
        }, {
            label = 'ขายยา',
            value = 'sellDrug'
        }, {
            label = 'ยกเลิก',
            value = 'cancel'
        }}
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'my_menu', {
            title = ('เมนูสารเสพติด %s'):format(labelName),
            align = 'top-right',
            elements = elements
        }, function(data, menu)
            if data.current.value == 'useDrug' then
                menu.close()
                exports['azael_dc-serverlogs']:insertData({
                    event = 'useDrug',
                    content = ('มีการเรียกการใช้ยาเสพติด'),
                    source = serverId,
                    color = 7,
                    options = {
                        public = false,
                        important = false
                    }
                })
                exports.cc_usedrug:useDrug(itemName)
            elseif data.current.value == 'sellDrug' then
                menu.close()
                exports['azael_dc-serverlogs']:insertData({
                    event = 'sellDrug',
                    content = ('มีการเตรียมขายยาเสพติด'),
                    source = serverId,
                    color = 7,
                    options = {
                        public = false,
                        important = false
                    }
                })
                suiteCaseAnim("use")
                sellState()
                --print(itemName)
                itemNameState = itemName
                Citizen.Wait(1000)
                ClearPedSecondaryTask(PlayerPedId())
                ClearPedTasks(PlayerPedId())
                showSuitCase()
            elseif data.current.value == 'cancel' then
                menu.close()
                exports['azael_dc-serverlogs']:insertData({
                    event = 'cancel',
                    content = ('มีการยกเลิกการใช้ยาเสพติด'),
                    source = serverId,
                    color = 7,
                    options = {
                        public = false,
                        important = false
                    }
                })
                exports.helpnotify:hideHelpNotification()
                cancelState()
                suiteCaseAnim("cancel")
                Citizen.Wait(1000)
                DeleteEntity(propCase)
                ClearPedSecondaryTask(PlayerPedId())
                ClearPedTasks(PlayerPedId())
            end
            checkItem()
        end, function(data, menu)
            menu.close()
            openMenu = false
        end)
        openMenu = true
    else
        ESX.UI.Menu.CloseAll()
        openMenu = false
    end
end)


RegisterNetEvent("cc_selldrug:openMenuDrug")
AddEventHandler("cc_selldrug:openMenuDrug", function(labelName, itemName)
    if not openMenu then
        local elements = {{
                              label = 'เสพยา',
                              value = 'useDrug'
                          }, {
                              label = 'ยกเลิก',
                              value = 'cancel'
                          }}
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'my_menu', {
            title = ('เมนูสารเสพติด %s'):format(labelName),
            align = 'top-right',
            elements = elements
        }, function(data, menu)
            if data.current.value == 'useDrug' then
                menu.close()
                exports['azael_dc-serverlogs']:insertData({
                    event = 'useDrug',
                    content = ('มีการเรียกการใช้ยาเสพติด'),
                    source = serverId,
                    color = 7,
                    options = {
                        public = false,
                        important = false
                    }
                })
                exports.cc_usedrug:useDrug(itemName)
            end
            checkItem()
        end, function(data, menu)
            menu.close()
            openMenu = false
        end)
        openMenu = true
    else
        ESX.UI.Menu.CloseAll()
        openMenu = false
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        DeleteEntity(propCase)
    end
end)

-- Handle the OnPlayerDropped event
AddEventHandler("playerDropped", function()
    DeleteEntity(propCase)
end)
