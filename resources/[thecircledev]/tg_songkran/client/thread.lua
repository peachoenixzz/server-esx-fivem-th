-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

holdingWatergun = false
usingWatergun = false
semiMode = false
water_refill = Config.Watergun.WaterTank
allPlayers = {}

-- Shooting Thread
Citizen.CreateThread(function()
    while true do
        Wait(0)

        sleep = true 

        if holdingWatergun then
            sleep = false

            if IsPedInAnyVehicle(PlayerPedId(), false) then
                TriggerEvent("tg_songkran:onUseWatergun")
                SendNUIMessage(
                    {
                        action = "close"
                    }
                )
            end

            Config.ClientOnHoldingWatergun()

            if IsControlJustPressed(0, 24) and usingWatergun == false then
                WaterBullet()
            end
        end

        if sleep then 
            Wait(500)
        end
    end
end)

-- Change Mode Thread
Citizen.CreateThread(function()
    while true do 
        Wait(0)

        sleep = true 

        if holdingWatergun then
            sleep = false
            if IsControlJustPressed(0, Keys[Config.Key.ChangeMode]) then 
                if not semiMode then 
                    semiMode = true 
                    SendNUIMessage({
                        action = 'changemode',
                        mode = "SEMI"
                    })
                else
                    semiMode = false
                    SendNUIMessage({
                        action = 'changemode',
                        mode = "AUTO"
                    })
                end
               
            end
        end

        if sleep then 
            Wait(500)
        end 
    end
end)

-- Refill Water Thread
Citizen.CreateThread(function()
    while true do
        local nearby = false
        local dstCheck = nil
        local sleep = 0

        (function()
            local local_ped = GetPlayerPed(-1)
            local coords = GetEntityCoords(local_ped)

            for _,k in pairs(Config.RefillWater.Coords) do
                dstCheck = #(k - coords)
                
                if (dstCheck > Config.RefillWater.RenderDistance) then goto done end

                nearby = true

                DrawMarker(Config.RefillWater.Marker.type,k.x, k.y, k.z-1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0,Config.RefillWater.Marker.scale.x,Config.RefillWater.Marker.scale.y,Config.RefillWater.Marker.scale.z, Config.RefillWater.Marker.color.r, Config.RefillWater.Marker.color.g,Config.RefillWater.Marker.color.b, Config.RefillWater.Marker.color.a, false, true, 2, false, false, false, false)
                
                if (dstCheck <= Config.RefillWater.ActionArea) then

                    if IsPedInAnyVehicle(local_ped, true) then goto done end
                   
                    Config.ClientActionArea()
                    
                    if IsControlJustPressed(0, Keys[Config.Key.RefillWater]) then
                        if holdingWatergun then
                            if water_refill == Config.Watergun.WaterTank then 
                                Config.ClientNotification('error', Config.Locale.Notification.water_full)
                            else
                                if Config.RefillWater.Checking.item == nil and Config.RefillWater.Checking.money ~= nil then 
                                    ESX.TriggerServerCallback('tg_songkran:checkMoney', function(haveMoney)
                                        if haveMoney then 
                                            RefillWater()
                                        else 
                                            Config.ClientNotification('error', Config.Locale.Notification.no_have_money)
                                        end
                                    end, Config.RefillWater.Checking.money.count)
                                elseif Config.RefillWater.Checking.money == nil and Config.RefillWater.Checking.item ~= nil then
                                    ESX.TriggerServerCallback('tg_songkran:checkItem', function(haveItem)
                                        if haveItem then
                                            if Config.RefillWater.Checking.item.remove then 
                                                TriggerServerEvent("tg_songkran:removeItem", Config.RefillWater.Checking.item.name, Config.RefillWater.Checking.item.count)
                                            end
                                            RefillWater()
                                        else 
                                            Config.ClientNotification('error', Config.Locale.Notification.no_item)
                                        end
                                    end, Config.RefillWater.Checking.item.name, Config.RefillWater.Checking.item.count)
                                elseif Config.RefillWater.Checking.item == nil and Config.RefillWater.Checking.money == nil then 
                                    RefillWater()
                                else 
                                    Config.ClientNotification('error', Config.Locale.Notification.cannot_check)
                                end
                            end
                        else
                            Config.ClientNotification('error', Config.Locale.Notification.no_watergun)
                        end
                    end
                end
                
                ::done::
            end 
        end)()

        if not nearby then
            Wait(dstCheck)
        else
            Wait(0)
        end  
    end
end)

-- Particle Sync Thread
if Config.ParticleSync then
    Citizen.CreateThread(function()
        while true do
            local players = ESX.Game.GetPlayers(true)
            allPlayers = {}

            if holdingWatergun then
                for _p,_v in pairs (players) do
                    local targetPed = GetPlayerPed(_v)
                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed)
                    local distTarget = GetEntityCoords(targetPed)
                    local checkerDist = #(distTarget - coords)

                    if (checkerDist <= 100) then
                        table.insert(allPlayers,GetPlayerServerId(_v))
                    end
                end
                Wait(1000)
            else
                Wait(1000)
            end
        end
    end)
end