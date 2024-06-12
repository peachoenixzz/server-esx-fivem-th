ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    PlayerData = ESX.GetPlayerData()
    --print("Player Inventory",PlayerData.inventory)
    --print("Player Accounts",PlayerData.accounts)
    --print(PlayerData.accounts.money)
    --print(PlayerData.accounts.bank)
    --print(PlayerData.accounts.black)
end)

SetNuiFocus(true, true)
function showPolicePanel(policePlayer,closetPlayer,nameLabel,jobLabel,sexLabel,player)
    SetNuiFocus(true, true)
    local tokenAuth = exports.cc_authlogin:tokenCollect()
    SendNUIMessage({
            action = 'showPolicePanel',
            closetPlayer = closetPlayer,
            policePlayer = GetPlayerName(PlayerId()),
            nameLabel = nameLabel,
            jobLabel = jobLabel,
            sexLabel = sexLabel,
            player = player,
            token = tokenAuth
        })
end

function hidePolicePanel()
        SendNUIMessage({
            action = 'hidePolicePanel'
        })
end

function closeGui()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'hidePolicePanel'
    })
end

RegisterNUICallback('notify', function(data, cb)
    
end)

RegisterNUICallback('quit', function(data, cb)
    closeGui()
    cb('ok')
end)

RegisterNUICallback('fine', function(data, cb)
    ESX.TriggerServerCallback('esx_billing:sendBill', function()
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PoliceSendBills',
                content = ('ผู้เล่นได้ทำการสั่งจ่ายบิลให้กับ %s ข้อหา %s ค่าปรับจำนวน $%s'):format(GetPlayerName(data.closet_player), data.title, tonumber(data.fine)),
            })
        end) -- End log
        onSendPlayerToJail()

    end,GetPlayerServerId(data.closet_player), 'police',"LSPD : ค่าปรับ", tonumber(data.fine),"police")
end)

RegisterNUICallback('policeStation', function(data, cb)
    ESX.TriggerServerCallback('cc_coreeffect:createDebuff', function()
        TriggerServerEvent("cc_jail:initPlayerToJail", GetPlayerServerId(data.closet_player), data.title,"police_station")
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PoliceSendPlayerToPDJail',
                content = ('ผู้เล่นได้ทำการส่ง %s ไปคุกใต้ส.น. ข้อหา %s เป็นเวลา %s นาที'):format(GetPlayerName(data.closet_player), data.title, data.jail_time),
            })
        end) -- End log
        onSendPlayerToJail()
    end,GetPlayerServerId(data.closet_player),"in_jail",(data.jail_time*1000)*60)
    --TriggerServerEvent("esx-qalle-jail:jailPlayer", GetPlayerServerId(data.closet_player), data.jail_time, data.title)
    if data.fine ~= 0 then
        ESX.TriggerServerCallback('esx_billing:sendBill', function()
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'PoliceSendBills',
                    content = ('ผู้เล่นได้ทำการสั่งจ่ายบิลให้กับ %s ข้อหา %s ค่าปรับจำนวน $%s'):format(GetPlayerName(data.closet_player), data.title, tonumber(data.fine)),
                })
            end) -- End log
            onSendPlayerToJail()

        end,GetPlayerServerId(data.closet_player), 'police',"LSPD : "..data.title, tonumber(data.fine),"police")
    end
end)

RegisterNUICallback('bolingbrokePenitentiary', function(data, cb)
    -- GetPlayerServerId(data.closet_player)
    --TriggerServerEvent("esx-qalle-jail3:jailPlayer", GetPlayerServerId(data.closet_player), data.jail_time, data.title)
    local position = data.position
    ESX.TriggerServerCallback('cc_jail:checkDisruptor', function(success, xPlayerIdentifier)
        if success then
            ESX.TriggerServerCallback('cc_coreeffect:deleteDebuffByIdentifier', function() end,xPlayerIdentifier,"anonymous_gps")
        end
    end,GetPlayerServerId(data.closet_player))
    ESX.TriggerServerCallback('cc_coreeffect:createDebuff', function()
        TriggerServerEvent("cc_jail:initPlayerToJail", GetPlayerServerId(data.closet_player), data.title,"main_prison",position)
        pcall(function() -- Start log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PoliceSendPlayerToMainJail',
                content = ('ผู้เล่นได้ทำการส่ง %s ไปคุกใหญ่ ข้อหา %s เป็นเวลา %s นาที'):format(GetPlayerName(data.closet_player), data.title, data.jail_time),
            })
        end) -- End log
        onSendPlayerToJail()
    end,GetPlayerServerId(data.closet_player),"in_jail",(data.jail_time*1000)*60)
    if data.fine ~= 0 then
        ESX.TriggerServerCallback('esx_billing:sendBill', function()
            pcall(function() -- Start log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'PoliceSendBills',
                    content = ('ผู้เล่นได้ทำการสั่งจ่ายบิลให้กับ %s ข้อหา %s ค่าปรับจำนวน $%s'):format(GetPlayerName(data.closet_player), data.title, tonumber(data.fine)),
                })
            end) -- End log
        end,GetPlayerServerId(data.closet_player), 'police',"LSPD : "..data.title, tonumber(data.fine),"police")
    end
end)


function onSendPlayerToJail()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบตำรวจ', -- หัวเรื่อง
        description = 'สรุปคดีเรียบร้อยแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success',
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'jail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end