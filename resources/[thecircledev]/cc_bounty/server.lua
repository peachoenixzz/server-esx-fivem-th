
local trackedPlayers = {}  -- List to track players in a bodybag state.
local isBlipUpdaterActive = false
local cacheExpireTime = 60  -- 1 minute
local cacheTime = 0
function initCoreEffectGPS(xPlayer, timer)
    local gpsTime = exports.cc_coreeffect:coreEffectCheckTimeRealTime(xPlayer,'bounty_hunter')
    if gpsTime <= 0 then
        exports.cc_coreeffect:createDebuff(xPlayer,'bounty_hunter',timer,'bounty_hunter','show')
        table.insert(trackedPlayers, xPlayer.source)
        startBlipUpdater()
    end
end

function removeBounty(xTarget)
    exports.cc_coreeffect:deleteEffectByESXPlayer(xTarget,'bounty_hunter')
    unTrackBlipBounty(xTarget.source)
    onUnTrackGps(source)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(player, xPlayer)
    local gpstime = exports.cc_coreeffect:coreEffectCheckTimeRealTime(xPlayer,'bounty_hunter')
    if gpstime > 0 then
        Citizen.Wait(1500)
        table.insert(trackedPlayers, xPlayer.source)
        startBlipUpdater()
    end
end)

RegisterCommand('bounty', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin' then
        if args[1] and args[2] then
            local playerId = tonumber(args[1])
            local timer = tonumber(args[2]) * 60000
            local xTarget = ESX.GetPlayerFromId(playerId)
            if playerId and xTarget then
                onTracking(xTarget.source)
                initCoreEffectGPS(xTarget, timer)
            else
                TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
            end
        end
    end
end,true)

RegisterCommand('rbounty', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin'  then
        if args[1] then
            local playerId = tonumber(args[1])
            local xTarget = ESX.GetPlayerFromId(playerId)
            if playerId and xTarget then
                removeBounty(xTarget)
            else
                TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
            end
        end
    end
end,true)

local function getPlayerCoords(playerId)
    local playerPed = GetPlayerPed(playerId)
    if playerPed then
        return GetEntityCoords(playerPed)
    end
    return nil
end

function startBlipUpdater()
    if isBlipUpdaterActive then
        return
    end
    isBlipUpdaterActive = true
    Citizen.CreateThread(function()
        while isBlipUpdaterActive do
            Citizen.Wait(1500)
            local playersData = {}
            for _, playerId in ipairs(trackedPlayers) do
                local coords = getPlayerCoords(playerId)
                if coords then
                    table.insert(playersData, {
                        id = playerId,
                        coords = coords
                    })
                end
            end

            TriggerClientEvent('cc_bounty:updateBountyGpsBlips', -1, playersData)

            local currentTime = os.time()
            if (currentTime - cacheTime) > cacheExpireTime then
                for _, playerId in ipairs(trackedPlayers) do
                    local xPlayer = ESX.GetPlayerFromId(playerId)
                    if xPlayer then
                        local timer = exports.cc_coreeffect:coreEffectCheckTimeRealTime(xPlayer,'bounty_hunter')
                        if timer <= 0 then
                            unTrackBlipBounty(xPlayer.source)
                            onUnTrackGps(xPlayer.source)
                        end
                    end
                end
                cacheTime = currentTime
            end

            if #trackedPlayers == 0 then
                isBlipUpdaterActive = false
            end
        end
    end)
end

function unTrackBlipBounty(target)
    for i = #trackedPlayers, 1, -1 do
        if target == trackedPlayers[i] then
            table.remove(trackedPlayers, i)
        end
    end

    local playersData = {}
    for _, playerId in ipairs(trackedPlayers) do
        local coords = getPlayerCoords(playerId)
        if coords then
            table.insert(playersData, {
                id = playerId,
                coords = coords
            })
        end
    end

    TriggerClientEvent('cc_bounty:updateBountyGpsBlips', -1, playersData)
end

AddEventHandler('esx:playerDropped', function(playerId)
    unTrackBlipBounty(playerId)
end)

function onTracking(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบล่าค่าหัว', -- หัวเรื่อง
        description = 'คุณถูกตั้งค่าหัว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'cooldown', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function onUnTrackGps(source)
    exports.nc_notify:PushNotification(source,{
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบล่าค่าหัว', -- หัวเรื่อง
        description = 'หลบหนีสำเร็จปลดสัญญาณเรียบร้อยแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'cooldown', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end
