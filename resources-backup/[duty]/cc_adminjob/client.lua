local isDead = false



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

ESX.RegisterInput("circle:adminjob", "(ESX adminjob) Quick Actions", "keyboard", "F6", function()
    if not ESX.PlayerData.job or (ESX.PlayerData.job.name ~= 'admin') or isDead then
        return
    end
    openAdminMenu()
end)

local reflectMode = false
function openAdminMenu()
    ESX.UI.Menu.CloseAll()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'circle_menu',
                {
                    title    = 'Admin Menu',
                    align    = 'top-right',
                    elements = {
                        { label = 'ตรวจสอบประชาชน',	value = 'citizen_interaction'},
                        { label = 'ค้นตัว',	value = 'body_search'},
                        { label = 'ระบุจำนวนบิลค่า', value = "fine" },
                        { label = 'เปิดตู้แอดมิน', value = "vault" },
                        { label = 'ฮีลทุกอย่างให้ตนเอง', value = "heal" },
                        { label = 'เปิดโหมดสะท้อนกลับ', value = "reflect" },
                        { label = 'ปลดล็อคมือตัวเอง', value = "unrest" },
                    }
                },
                function(data, menu)
                    local selectedAction = data.current.value
                    if selectedAction == "fine" then
                        if closestPlayer ~= -1 and closestDistance <= 3.0 then
                            OpenFineMenu(closestPlayer)
                            menu.close()
                        end
                    end
                    if selectedAction == "vault" then
                        ExecuteCommand("openvault 3")
                        menu.close()
                    end
                    if selectedAction == "heal" then
                        TriggerEvent('esx_status:remove','stress',3000000)
                        TriggerEvent('esx_status:add','thirst',3000000)
                        TriggerEvent('esx_status:add','hunger',3000000)
                        SetPedArmour(PlayerPedId(),100)
                        SetEntityHealth(PlayerPedId(), 200)
                    end
                    if selectedAction == "citizen_interaction" then
                        pcall(function()
                            exports.cc_checkidentify:getIdentifyPlayer(GetPlayerServerId(closestPlayer))
                        end )
                        menu.close()
                    end
                    if selectedAction == "body_search" then
                            exports.nc_inventory:SearchInventory(GetPlayerServerId(closestPlayer), 'admin')
                            menu.close()
                    end
                    if selectedAction == "reflect" then
                        reflectMode = not reflectMode
                        menu.close()
                    end
                    if selectedAction == "unrest" then
                        TriggerEvent('esx_policejob:unrestrain')
                    end
                end,
                function(data, menu)
                    menu.close()
                end
        )
    end



RegisterNetEvent('cc_admin:reloadPlayerBug')
AddEventHandler('cc_admin:reloadPlayerBug', function()
    local ped = PlayerPedId()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        ESX.TriggerServerCallback('esx_ambulancejob:playerCoords', function(formattedCoords)
            SetEntityCoordsNoOffset(ped, formattedCoords.x, formattedCoords.y, formattedCoords.z, false, false, false)
            NetworkResurrectLocalPlayer(formattedCoords.x, formattedCoords.y, formattedCoords.z, 0.0, true, false)
            SetPlayerInvincible(ped, false)
            ClearPedBloodDamage(ped)
            TriggerServerEvent('esx:onPlayerSpawn')
            TriggerEvent('esx:onPlayerSpawn')
            TriggerEvent('playerSpawned')
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
    end)
end)


RegisterNetEvent('cc_adminjob:cc_clipper')
AddEventHandler('cc_adminjob:cc_clipper', function()
    TriggerEvent('skinchanger:getSkin', function(skin)
        Wait(1000)
        skin.hair_1 = 0
        skin.hair_2 = 0
        if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin)
        else
            TriggerEvent('skinchanger:loadClothes', skin)
        end
    end)
end)

RegisterNetEvent('cc_adminjob:ad_spray')
AddEventHandler('cc_adminjob:ad_spray', function()
    TriggerEvent('skinchanger:getSkin', function(skin)
        Wait(1000)
        skin.skin = 35
        if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin)
        else
            TriggerEvent('skinchanger:loadClothes', skin)
        end
    end)
end)


function CreateBilling(player)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog_createbill',
            {
                title = "ใส่ชื่อบิล",
            }, function(data, menu)
                --local length = string.len(data.value)
                if data.value == nil then
                    onNoInfo()
                else
                    createBillingAdmin(player, data.value)
                    menu.close()
                end
            end, function(data, menu)
                menu.close()
            end)
end

function createBillingAdmin(player, value)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog_createbill_price',
            {
                title = "ใส่จำนวนเงิน",
            }, function(data2, menu2)
                --local length = string.len(data.value)
                if tonumber(data2.value) then
                    ESX.TriggerServerCallback('esx_billing:sendBill', function()
                        onSendBill()
                    end,GetPlayerServerId(player), 'admin',"Fine: "..value, tonumber(data2.value),'admin')
                    menu2.close()
                else
                    onNoFineMoney()
                end
            end, function(data2, menu2)
                menu2.close()
            end)
end

function OpenFineMenu(player)
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine',
            {
                title    = "สั่งจ่ายบิล",
                align    = 'top-right',
                elements = {
                    {label = "สร้างบิล",   value = 'create_bills'}
                }
            }, function(data, menu)
                CreateBilling(player)
                -- OpenFineCategoryMenu(player, data.current.value)
            end, function(data, menu)
                menu.close() end)
end

function openIdentifyCard(player)
    ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
        TriggerEvent("cc_uicard:showCardClosetPlayer",data)
    end, GetPlayerServerId(player))
end

AddEventHandler('esx:onPlayerSpawn', function(spawn)
    isDead = false
    --TriggerEvent('esx_policejob:unrestrain')
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    isDead = true
end)

function onNoInfo()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบบิล', -- หัวเรื่อง
        description = 'กรุณาใส่รายละเอียด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'detail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end


function onNoFineMoney()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบบิล', -- หัวเรื่อง
        description = 'กรุณาใส่จำนวนเงิน', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'bill', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end


function onSendBill()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบบิล', -- หัวเรื่อง
        description = 'สร้างบิลเรียบร้อยแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'bill', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function adminMessage(text,duration)
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบ Admin', -- หัวเรื่อง
        description = text, -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'bill', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = duration -- ระยะเวลาการแสดง Notify
    })
end


AddEventHandler('gameEventTriggered', function(event, args)
    --print(reflectMode)
    if event == "CEventNetworkEntityDamage" and reflectMode then
        local playerPed = PlayerPedId()
        --print(reflectMode)
        if args[1] == playerPed and reflectMode then
            ESX.TriggerServerCallback('cc_adminjob:reflectPlayer', function(status)
                if status then return end
            end,GetPlayerServerId(NetworkGetPlayerIndexFromPed(args[2])))
        end
    end
end)


RegisterNetEvent('cc_adminjob:reflect')
AddEventHandler('cc_adminjob:reflect', function()
    local playerPed = PlayerPedId()
    adminMessage("กรรมกำลังเดินทางไปถึงท่าน",5000)
    Citizen.CreateThread(function()
        for i = 1, 15 do
            SetTimecycleModifierStrength(1.0)
            SetTimecycleModifier("BeastIntro02")
            SetPedToRagdoll(playerPed, 5000, 5000, 0, 0, 0, 0)
            Citizen.Wait(500)
        end
        SetTimecycleModifierStrength(0.0)
        SetTimecycleModifier("default")
    end)
    Wait(5000)
    local health = GetEntityHealth(playerPed)
    local newHealth = health - 30
    SetEntityHealth(playerPed,newHealth)
end)

RegisterNetEvent('cc_adminjob:resetallplayer')
AddEventHandler('cc_adminjob:resetallplayer', function()
    local playerPed = PlayerPedId()
    --adminMessage("กรรมกำลังเดินทางไปถึงท่าน",5000)
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        SwitchInPlayer(ped)
    end)
    --Wait(5000)
    --local health = GetEntityHealth(playerPed)
    --local newHealth = health - 30
    --SetEntityHealth(playerPed,newHealth)
end)