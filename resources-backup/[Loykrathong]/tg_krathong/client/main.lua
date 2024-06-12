-- This resource was scripted by TG DEVELOPER
-- Discord : https://discord.gg/yT9ySxbM9Y

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.EventRoute.GetSharedObject, function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

local krathongProp
local useKrathong = false
local isPickingUp = false
local showText = false
local sleep = true
local stat = {}

-- Font 

RegisterFontFile(Config.PrayText.Font)
fontId = RegisterFontId(Config.PrayText.Font)

-- Create Blips

Citizen.CreateThread(function()

    if Config.Blips.Krathong.Enable then
        
        local KrathongBlip = AddBlipForCoord(Config.Blips.Krathong.Coords)

        SetBlipSprite (KrathongBlip, Config.Blips.Krathong.Id)
        SetBlipDisplay(KrathongBlip, 4)
        SetBlipScale  (KrathongBlip, Config.Blips.Krathong.Size)
        SetBlipColour (KrathongBlip, Config.Blips.Krathong.Color)
        SetBlipAsShortRange(KrathongBlip, true)

        AddTextEntry(Config.Blips.Krathong.Text, Config.Blips.Krathong.Text)
        BeginTextCommandSetBlipName(Config.Blips.Krathong.Text)
        EndTextCommandSetBlipName(KrathongBlip)

    end

end)

-- Krathong

Citizen.CreateThread(function()
	while true do

        Citizen.Wait(0)

        sleep = true 

        local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

        for k, v in pairs(Config.Krathong) do

            if GetDistanceBetweenCoords(GetEntityCoords(ped), v.Coords, true) < Config.Marker.Krathong.RenderDistance and not isPickingUp then

                sleep = false
                DrawMarker(Config.Marker.Krathong.Type, v.Coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.Krathong.Scale.X, Config.Marker.Krathong.Scale.Y, Config.Marker.Krathong.Scale.Z, Config.Marker.Krathong.Color.Red, Config.Marker.Krathong.Color.Green, Config.Marker.Krathong.Color.Blue, Config.Marker.Krathong.Color.Alpha, true, true, 2, false, false, false, false)
            
                if GetDistanceBetweenCoords(GetEntityCoords(ped), v.Coords, true) < 2.5 and not isPickingUp then

                    ESX.ShowHelpNotification(Config.Locale.Notification.LoyKrathong)

                        if IsControlJustReleased(1, 38) then
                            
                            ESX.TriggerServerCallback('tg_krathong:checkItem', function(hasItem)

                                if hasItem then

                                    CreateKrathong()

                                    isPickingUp = true  

                                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog_pray',
                                    {
                                        title = "ใส่คำอธิษฐาน",
                                    },  function(data, menu)

                                        if data.value == nil then
                                            Config.ClientNotification('error', Config.Locale.Krathong.NoPrayText)

                                            useKrathong = false
                                            isPickingUp = false

                                            DeleteObject(krathongProp)
                                            ClearPedTasks(ped)

                                            menu.close()
                                        else
                                            menu.close()
                                            SetEntityHeading(ped, v.Heading)

                                            TriggerServerEvent('tg_krathong:prayNotification', data.value)

                                            if Config.EnablePrayText then
                                                TriggerServerEvent('tg_krathong:prayStatus', data.value)
                                            end

                                            AnimationKrathong()
                                            
                                            TriggerServerEvent('tg_krathong:removeItem', 'krathong')

                                            Citizen.Wait(v.Duration * 1000)

                                            TriggerServerEvent('tg_krathong:addItem', 'krathong')

                                            Citizen.Wait(v.RemoveTime * 1000)

                                            useKrathong = false
                                            isPickingUp = false

                                            --DeleteObject(krathongProp) 
                                        end

                                    end, function(data, menu)

                                        useKrathong = false
                                        isPickingUp = false

                                        DeleteObject(krathongProp)
                                        ClearPedTasks(ped)

                                        menu.close()
                                    end)

                                else

                                    Config.ClientNotification('error', Config.Locale.Krathong.NoItem)

                                end

                            end)

                        end
                end

            end

            if Config.EnablePrayText then
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.PrayText.Coords, true) < Config.PrayText.CoordsRadius then
                    showText = true
                else
                    showText = false
                end
            end
            
        end

        if sleep then Citizen.Wait(500) end

	end
end)

local location = {}

-- Collect Krathong

if Config.EnableCollectKrathong then 
    Citizen.CreateThread(function()
        while true do

            Citizen.Wait(0)

            sleep = true 

            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)

            if #location > 0 then
                for k, v in pairs(location) do

                    if GetDistanceBetweenCoords(GetEntityCoords(ped), v, true) < Config.Marker.Krathong.RenderDistance and not isPickingUp then

                        sleep = false
                    
                        if GetDistanceBetweenCoords(GetEntityCoords(ped), v, true) < 1.5 and not isPickingUp then

                            ESX.ShowHelpNotification(Config.Locale.Notification.CollectKrathong)

                                if IsControlJustReleased(1, 38) then
                                    
                                    ESX.TriggerServerCallback('tg_krathong:checkPick', function(hasItem)

                                        if hasItem then
                                            isPickingUp = true  

                                            TriggerEvent(Config.ProgressBar, {
                                                name = "pickup",
                                                duration = 5000,
                                                label = "Picking Up",
                                                useWhileDead = false,
                                                canCancel = false,
                                                controlDisables = {
                                                    disableMovement = true,
                                                    disableCarMovement = true,
                                                    disableMouse = false,
                                                    disableCombat = true,
                                                },
                                                animation = {
                                                    animDict = Config.Setup.Animation.CollectKrathong.AnimationDict,
                                                    anim = Config.Setup.Animation.CollectKrathong.AnimationName
                                                }
                                            }, function(cancelled)
                                                isPickingUp = false 
                                                
                                                local object = GetClosestObjectOfType(v.x, v.y, v.z, 3.0, GetHashKey(Config.Setup.Props.Krathong.Name), false, false, false)
                                                
                                                TriggerServerEvent('tg_krathong:addItem', 'collect_krathong')
                                                TriggerServerEvent('tg_krathong:removePoint', v)
                                                DeleteEntity(object)
                                            end)
                                        else
                                            isPickingUp = false  
                                            Config.ClientNotification('error', Config.Locale.Krathong.SomeoneCollecting)
                                        end
                                    end,v)
                                end
                        end
                    end
                end
            end
            if sleep then Citizen.Wait(500) end
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        sleep = true

        if showText then
            
            sleep = false

            for _, id in ipairs(GetActivePlayers()) do
                local ped = GetPlayerPed(id)
                local MyCamCoords = GetGameplayCamCoords()
                local localFPS = 1 / GetFrameTime()
                local playerHead = GetPedBoneCoords(ped, 1.2844e4, 0, 0, 0) + vector3(0, 0, 1.1) + GetEntityVelocity(ped) / localFPS
                local distance = math.floor(#(MyCamCoords - playerHead))

                if distance < Config.PrayText.PlayerRadius and World3dToScreen2d(playerHead.x, playerHead.y, playerHead.z) then

                    SetDrawOrigin(playerHead, false)

                    local sizeOffset = math.max(1 - distance / 10, 0.5)
                    SetTextFont(fontId)
                    SetTextScale(0, Config.PrayText.Scale * sizeOffset)
                    SetTextCentre(true)
                    SetTextOutline()
                    SetTextEntry"STRING"

                    for k, v in pairs(stat) do 
                        if GetPlayerServerId(id) == v["Id"] then
                            AddTextComponentString(v["Text"])
                        end
                    end
                    
                    DrawText(0, 0)
                    ClearDrawOrigin()
                end
            end
        end

        if sleep then Citizen.Wait(500) end
    end 
end)

RegisterNetEvent('tg_krathong:getStatus')
AddEventHandler('tg_krathong:getStatus', function(element)
    stat = element
end)





RegisterNetEvent('tg_krathong:setPoint:cl')
AddEventHandler('tg_krathong:setPoint:cl', function(point)
    table.insert(location,point)
end)

RegisterNetEvent('tg_krathong:removePoint:cl')
AddEventHandler('tg_krathong:removePoint:cl', function(point)
    for i,v in pairs(location) do
        if v == point then 

            table.remove(location,i)
            break
        end

    end
   
end)




function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end
  
function AnimationKrathong()
    for k, v in pairs(Config.Krathong) do
        LoadAnimDict(Config.Setup.Animation.Krathong.AnimationDict)
        TaskPlayAnim(PlayerPedId(), Config.Setup.Animation.Krathong.AnimationDict, Config.Setup.Animation.Krathong.AnimationName, 8.0, -8.0, -1, 1, 0, false, false, false)

        TriggerEvent(Config.ProgressBar, {
            name = "unique_action_name",
            duration = v.Duration * 1000,
            label = Config.Locale.ProgressBar.Pray,
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
        }, function(status)
            if not status then
                DeleteObject(krathongProp) 
                useKrathong = true
                KrathongAnimation()
                Citizen.Wait(100)
            end
        end)
    end
end

function CreateKrathong()

    local ped = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(ped))
    local boneIndex = GetPedBoneIndex(ped, 24817)

    krathongProp = CreateObject(GetHashKey(Config.Setup.Props.Krathong.Name), x, y, z + 0.0, true, true, true)

    AttachEntityToEntity(krathongProp, ped, boneIndex, -0.090, 0.5, 0.0, 0.0, 90.0, 0.0, true, true, false, true, 1, true)

    LoadAnimDict("impexp_int-0")    
    TaskPlayAnim(ped, "impexp_int-0", "mp_m_waremech_01_dual-0", 8.0, 8.0, -1, 50, 0, false, false, false)
   
end

function KrathongAnimation()

    local ped = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(ped))

    krathongProp = CreateObject(GetHashKey(Config.Setup.Props.Krathong.Name), x + - 0.5, y + - 0.5, z + - 0.5, true, true, true)

    local kcrood = GenerateCoords()
    while useKrathong do 
        Citizen.Wait(7)
        SlideObject(krathongProp, kcrood, 0.006, 0.006, 0.006, true)
    end

    TriggerServerEvent('tg_krathong:setPoint',GetEntityCoords(krathongProp))
end


function GenerateCoords()
	while true do
		Citizen.Wait(1)

		local CoordX, CoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-10, 10)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-10, 10)

		CoordX = Config.KrathongEndCoords.x + modX
		CoordY = Config.KrathongEndCoords.y + modY

	
        local coord = vector3(CoordX, CoordY, Config.KrathongEndCoords.z)
        
	
		return coord
		
	end
end


-- Lantern

local useLantern = false
local lanternProp

RegisterNetEvent('tg_krathong:useLantern')
AddEventHandler('tg_krathong:useLantern', function ()

    if not useLantern then

        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog_pray',
        {
            title = "ใส่คำอธิษฐาน",
        },  function(data, menu)

            if data.value == nil then
                Config.ClientNotification('error', Config.Locale.Krathong.NoPrayText)

                useLantern = false
                DeleteObject(lanternProp) 

                menu.close()
            else
                menu.close()
                useLantern = true

                TriggerServerEvent('tg_krathong:prayNotification', data.value)

                if Config.EnablePrayText then
                    TriggerServerEvent('tg_krathong:prayStatus', data.value)
                end

                UseLantern()
                TriggerServerEvent('tg_krathong:removeItem', 'lantern')
                CreateLantern()

                Citizen.Wait(Config.Lantern.RemoveTime * 1000)

                useLantern = false
                DeleteObject(lanternProp) 
            end

        end, function(data, menu)

            useLantern = false
            DeleteObject(lanternProp) 

            menu.close()
        end)

    end

end)

function CreateLantern()

    local ped = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(ped))
    local boneIndex = GetPedBoneIndex(ped, 24817)

    lanternProp = CreateObject(GetHashKey(Config.Setup.Props.Larntern.Name), x, y, z + 0.0, true, true, true)
    AttachEntityToEntity(lanternProp, ped, boneIndex, -0.5, 0.455, 0.08, 0.0, 90.0, 0.0, true, true, false, true, 1, true)
    
    LoadAnimDict(Config.Setup.Animation.Larntern.AnimationDict)
    TaskPlayAnim(ped, Config.Setup.Animation.Larntern.AnimationDict, Config.Setup.Animation.Larntern.AnimationName, 8.0, -8.0, -1, 1, 0, false, false, false)
    
    Citizen.Wait(Config.Lantern.Duration * 1000)
    ClearPedTasks(ped)

end

function LanternAnimation()

    useLantern = true

    local ped = PlayerPedId()
    local heal = GetEntityHeading(ped)  

    local x5,y5,z5 = table.unpack(GetEntityCoords(ped))
    local boneIndex = GetPedBoneIndex(ped, 24817)


    lanternProp = CreateObject(GetHashKey(Config.Setup.Props.Larntern.Name), x5,y5,z5 , true, true, true)

    local x1,y2,z3 = table.unpack(GetEntityCoords(lanternProp))

    while useLantern do 
        Citizen.Wait(7)

        SlideObject(lanternProp, x1,y2,z3+500 ,0.007,0.007,0.007,true)

    end

end

function UseLantern()
    TriggerEvent(Config.ProgressBar, {
        name = "unique_action_name",
        duration = Config.Lantern.Duration * 1000,
        label = Config.Locale.ProgressBar.Lantern,
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(status)
        if not status then
            useLantern = true
            DeleteObject(lanternProp) 
            TriggerServerEvent('tg_krathong:addItem', 'lantern')
            LanternAnimation()
            Citizen.Wait(100)
        end
    end)
end

-- Small Firework

local smallFireworkProp
local useSmallFirework = false
local particleDict = "scr_indep_fireworks"

RegisterNetEvent('tg_krathong:useSmallFirework')
AddEventHandler('tg_krathong:useSmallFirework', function()
    if not useSmallFirework then
        useSmallFirework = true
        
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.5, -1.02))
        
        LoadAnimDict(Config.Setup.Animation.SmallFirework.AnimationDict)
        TaskPlayAnim(ped, Config.Setup.Animation.SmallFirework.AnimationDict, Config.Setup.Animation.SmallFirework.AnimationName, 8.0, -1, -1, 0, 0, false, false, false)

        Wait(1250)
        ClearPedSecondaryTask(ped)

        smallFireworkProp = CreateObject(GetHashKey(Config.Setup.Props.SmallFirework.Name), x, y, z, true, false, true)

        SetEntityHeading(smallFireworkProp, GetEntityHeading(ped))
        PlaceObjectOnGroundProperly(smallFireworkProp)

        Wait(10000)
        TriggerServerEvent("tg_krathong:syncSmallFireworkSV", x, y, z)
        useSmallFirework = false
        Wait(8500)
        DeleteObject(smallFireworkProp)
    end
end)

RegisterNetEvent("tg_krathong:syncSmallFireworkCL")
AddEventHandler("tg_krathong:syncSmallFireworkCL", function(x, y, z)
    RequestNamedPtfxAsset(particleDict)
    while not HasNamedPtfxAssetLoaded(particleDict) do
        Wait(1)
    end
    UseParticleFxAssetNextCall(particleDict)
    StartParticleFxNonLoopedAtCoord("scr_indep_firework_starburst", x, y, z, 0.0, 0.0, 0.0, 2.5, false, false, false, false)
end)

-- Big Firework

local bigFireworkProp
local useBigFirework = false

RegisterNetEvent('tg_krathong:useBigFirework')
AddEventHandler('tg_krathong:useBigFirework', function()
    if not useBigFirework then

        useBigFirework = true

	    local ped = PlayerPedId()
	    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.5, -1.02))

        LoadAnimDict(Config.Setup.Animation.BigFirework.AnimationDict)
        TaskPlayAnim(ped, Config.Setup.Animation.BigFirework.AnimationDict, Config.Setup.Animation.BigFirework.AnimationName, 8.0, -1, -1, 0, 0, false, false, false)

        Wait(1250)
        ClearPedSecondaryTask(ped)

        bigFireworkProp = CreateObject(GetHashKey(Config.Setup.Props.BigFirework.Name), x, y, z, true, false, true)

        SetEntityHeading(bigFireworkProp, GetEntityHeading(ped))
        PlaceObjectOnGroundProperly(bigFireworkProp)

        Wait(10000)
        TriggerServerEvent("tg_krathong:syncBigFireworkSV", x, y, z)
        useBigFirework = false
        Wait(18000)
        DeleteObject(bigFireworkProp)
    end
end)

RegisterNetEvent("tg_krathong:syncBigFireworkCL")
AddEventHandler("tg_krathong:syncBigFireworkCL", function(x, y, z)
    
    RequestNamedPtfxAsset(particleDict)
    while not HasNamedPtfxAssetLoaded(particleDict) do
        Wait(1)
	end
	
	UseParticleFxAssetNextCall(particleDict)
	local particle = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", x, y, z, 0.0, 0.0, 0.0, math.random() * 0.5 + 0.8, false, false, false, false)
	Wait(1500)
	UseParticleFxAssetNextCall(particleDict)
	local particle2 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", x, y, z, 0.0, 0.0, 0.0, math.random() * 0.5 + 0.8, false, false, false, false)
	Wait(1500)
	UseParticleFxAssetNextCall(particleDict)
	local particle3 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", x, y, z, 0.0, 0.0, 0.0, math.random() * 0.5 + 0.8, false, false, false, false)
	Wait(1500)
	UseParticleFxAssetNextCall(particleDict)
	local particle4 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", x, y, z, 0.0, 0.0, 0.0, math.random() * 0.5 + 0.8, false, false, false, false)
	Wait(1500)
	UseParticleFxAssetNextCall(particleDict)
	local particle5 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", x, y, z, 0.0, 0.0, 0.0, math.random() * 0.5 + 0.8, false, false, false, false)
	Wait(1500)
	UseParticleFxAssetNextCall(particleDict)
	local particle6 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", x, y, z, 0.0, 0.0, 0.0, math.random() * 0.5 + 0.8, false, false, false, false)
	Wait(1500)
	UseParticleFxAssetNextCall(particleDict)
	local particle7 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", x, y, z, 0.0, 0.0, 0.0, math.random() * 0.5 + 0.8, false, false, false, false)
	Wait(1500)
	UseParticleFxAssetNextCall(particleDict)
	local particle8 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", x, y, z, 0.0, 0.0, 0.0, math.random() * 0.5 + 0.8, false, false, false, false)
	Wait(4000)
	UseParticleFxAssetNextCall(particleDict)
    local particle9 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", x, y, z, 0.0, 0.0, 0.0, math.random() * 0.5 + 1.8, false, false, false, false)
    
end)
  
AddEventHandler('onResourceStop', function(resource)
	  if resource == GetCurrentResourceName() then
          DeleteObject(lanternProp)
          DeleteObject(krathongProp)   
          DeleteObject(smallFireworkProp)  
          DeleteObject(bigFireworkProp)  
	  end
  end)
  