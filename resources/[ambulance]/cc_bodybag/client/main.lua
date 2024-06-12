ESX = nil


local bodyBag = nil
local onBodyBag = false
local attached = false
local deadCheck = false


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    Citizen.Wait(100)
end)

RegisterNetEvent('cc_bodybag:useItem')
AddEventHandler('cc_bodybag:useItem', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local targetPed = GetPlayerPed(closestPlayer)
    --print(closestPlayer,closestDistance,targetPed,IsEntityDead(targetPed))
    if closestPlayer ~= -1 and closestDistance <= 3.0 and IsEntityDead(targetPed) then
        TriggerServerEvent('RRP_BODYBAG:Trigger', GetPlayerServerId(closestPlayer))
    end
end)

function PutInBodyBag()
    local playerPed = PlayerPedId()
    --local playerCoords = GetEntityCoords(playerPed)
    deadCheck = IsEntityDead(playerPed)
    --print(deadCheck)
    if deadCheck and not attached then
        --SetEntityVisible(playerPed, false, false)
        --RequestModel(Config.bag_model)
        --while not HasModelLoaded(Config.bag_model) do
        --    Citizen.Wait(1)
        --end
        --bodyBag = CreateObject(Config.bag_hash, playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)
        --AttachEntityToEntity(bodyBag, playerPed, 0,0.27, 0.15, 0.23, 360.0, 360.0, 10.0, false, false, false, false, 2, false)
        setUniform("playerNormal", playerPed)
        --AttachEntityToEntity(playerPed, targetPed, 0, carry.dragdeath.distans2, carry.dragdeath.distans, carry.dragdeath.height, 0.5, 0.5, carry.dragdeath.spin, false, false, false, false, 2, false)
        exports['esx_ambulancejob']:startDeathScreen()
        attached = true
    end
end

function setUniform(uniform, playerPed)
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject

        if skin.sex == 0 then
            uniformObject = Config.Uniforms[uniform].male
        else
            uniformObject = Config.Uniforms[uniform].female
        end

        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end

function cancelBodyBag()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
        bodyBag = nil
        attached = false
end

RegisterNetEvent('RRP_BODYBAG:success')
AddEventHandler('RRP_BODYBAG:success', PutInBodyBag)

RegisterNetEvent('RRP_BODYBAG:successCustom')
AddEventHandler('RRP_BODYBAG:successCustom',function(time)
    local playerPed = PlayerPedId()
    deadCheck = IsEntityDead(playerPed)
    if deadCheck and not attached then
        setUniform("playerNormal", playerPed)
        exports['esx_ambulancejob']:startDeathScreen(time)
        attached = true
    end
end)

RegisterNetEvent('RRP_BODYBAG:processBodyBag')
AddEventHandler('RRP_BODYBAG:processBodyBag', function(target)
    Citizen.CreateThread(function()
        onBodyBag = true
        checkState()
        TriggerEvent("mythic_progbar:client:progress",{
            name = "bodyBag",
            duration = 4000,
            label = "bodyBag",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "anim@gangops@facility@servers@bodysearch@",
                anim = "player_search",
                flags = 1
            },
        }, function(status)
            if not status then
                onBodyBag = false
                exports.helpnotify:hideHelpNotification()
                TriggerServerEvent('RRP_BODYBAG:success', target)
            end
        end)
    end)
end)





function checkState()
    exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
    Citizen.CreateThread(function()
        while onBodyBag do
            Citizen.Wait(0)
            if onBodyBag then
                --DisableControlAction(0,Config.Key['F'], true)
                DisableControlAction(0, 288, true) --F1
                DisableControlAction(0, 74, true) --H
                DisableControlAction(0, 74, true) --E
                --DisableControlAction(0,Config.Key['LEFTSHIFT'], true)
                --DisableControlAction(0, 75, true) --ลงรถ
                DisableControlAction(0, 104, true) --สไลด์
                DisableControlAction(0, 155, true) --สไลด์
                --DisableControlAction(0, 24, true)
            end

            if IsControlJustPressed(0,73) and onBodyBag then
                exports.helpnotify:hideHelpNotification()
                TriggerEvent("mythic_progbar:client:cancel")
                onBodyBag = false
                pcall(function() -- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'BodyBagCancel',
                        content = ('ผู้เล่นได้ทำการกด X เพื่อยกเลิกการห่อศพ'):format(),
                    })
                end) -- End Log
            end
        end
    end)
end

function checkStatusBodyBag()
    return attached
end

--==========================================================================================================================================================================================
--===================================================================================sell bodybag npc=======================================================================================
--==========================================================================================================================================================================================

-- Citizen.CreateThread(function()
-- 	local npcSellBodyBagHash = GetHashKey("ig_priest") 
-- 	RequestModel(npcSellBodyBagHash)
-- 	while not HasModelLoaded(npcSellBodyBagHash) do
-- 		Wait(1)
-- 	end
 
-- 	local npcSellBodyBag = CreatePed(4, npcSellBodyBagHash, -1685.02001953125, -291.75, 50.88999938964844, 142.09, false, true) 
-- 	SetEntityAsMissionEntity(npcSellBodyBag, true, true)
-- 	SetBlockingOfNonTemporaryEvents(npcSellBodyBag, true)
-- 	FreezeEntityPosition(npcSellBodyBag, true)
-- 	SetEntityInvincible(npcSellBodyBag, true)

-- end)

-- local inzoneSellBodyBag = false

-- local sellBodyBagZone = PolyZone:Create({
--     vector3(-1683.9100341796875, -292.05999755859375, 51.88999938964844), 
--     vector3(-1684.780029296875, -293.29998779296875, 51.88999938964844),
--     vector3(-1686.6800537109375, -291.989990234375, 51.88999938964844),
--     vector3(-1685.7900390625, -290.75, 51.88999938964844),
-- },{
--     name = "sell_body_bag",
--     debugPoly = false,
--     minZ = 50,
--     maxZ = 54,
-- })

-- sellBodyBagZone:onPlayerInOut(function(isPointInside, point)
--     if isPointInside then
--         inzoneSellBodyBag = true
--         exports.helpnotify:showHelpNotification("กด","E","เพื่อซื้อถุงห่อศพ")
--     else
--         inzoneSellBodyBag = false
--         exports.helpnotify:hideHelpNotification()
--     end
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(1)
--         if inzoneSellBodyBag == true then
--             if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) then
--                 exports.helpnotify:hideHelpNotification()
--                 pcall(function() -- Start log
--                     exports['azael_dc-serverlogs']:insertData({
--                         event = 'TalkToBodyBagNpc',
--                         content = ('ผู้เล่นได้ทำการกด E เพื่อคุยกับ Npc ขายถุงห่อศพ'):format(),
--                     })
--                 end) -- End log
--                 putamounttoBuy()
--             end
--         else 
--             Citizen.Wait(500)
--         end
--     end
-- end)

-- function putamounttoBuy()
--     ESX.UI.Menu.CloseAll()
--     ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog_createamount_buybodybag',
--     {
--         title = "จำนวนถุงห่อศพที่ต้องการซื้อ (มากสุด 10 ถุง)",
--     }, function(data, menu)
--         if inzoneSellBodyBag then     
--             if tonumber(data.value) <= 10 and tonumber(data.value) > 0 then
--                 TriggerServerEvent('sellBodyBug:calculate', tonumber(data.value))
--                 menu.close()
--             else
--                 menu.close()
--             end
--         else    
--             menu.close()
--         end
--     end, function(data, menu)
--         menu.close()
--     end)
-- end