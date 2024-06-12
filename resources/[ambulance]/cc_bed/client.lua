local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Dv_Hunter                   = GetCurrentResourceName()
local currentZone = nil
local onSleep = false
local heal = false
local restHealthy = false
local alreadyAttach = false
local isDead = false
local restorePlayer = false
local polyZones = {
    {
        coords = {
            vector3(371.7000122070313, -1387.1800537109375, 32.52999877929687),
            vector3(359.55999755859375, -1377.0899658203125, 32.52999877929687),
            vector3(353.3299865722656, -1384.4000244140625, 32.52999877929687),
            vector3(365.3399963378906, -1394.8599853515625, 32.52999877929687)
        },
        name = "ward_1"
    },
    {
        coords = {
            vector3(354.1682, -1381.6727, 32.5110),
            vector3(342.2266, -1371.6282, 32.5110),
            vector3(348.2611, -1364.5938, 32.5110),
            vector3(360.4720, -1374.7600, 32.5110)
        },
        name = "ward_2"
    },
    {
        coords = {
            vector3(337.1799926757813, -1422.9100341796875, 32.36000061035156),
            vector3(326.04998779296875, -1436.0699462890625, 32.36000061035156),
            vector3(317.3500061035156, -1428.8299560546875, 32.36000061035156),
            vector3(326.1799926757813, -1418.3699951171875, 32.36000061035156)
        },
        name = "ward_3"
    },
    {
        coords = {
            vector3(344.1000061035156, -1428.5, 32.5099983215332),
            vector3(332.760009765625, -1441.5799560546875, 32.5099983215332),
            vector3(341.7200012207031, -1448.75, 32.5099983215332),
            vector3(352.6199951171875, -1435.719970703125, 32.5099983215332)
        },
        name = "ward_4"
    },
    {
        coords = {
            vector3(1819.6800, 3668.5500, 34.2900),
            vector3(1815.25, 3676.4099, 34.2900),
            vector3(1823.4133, 3681.0974, 34.2929),
            vector3(1828.0326, 3673.3027, 34.2923)
        },
        name = "sandyshore"
    },
    -- Add more zones if needed
}

for _, zone in ipairs(polyZones) do
    local myZone = PolyZone:Create(zone.coords, {
        name = zone.name,
        debugPoly = false
    })

    myZone:onPlayerInOut(function(isPointInside, point)
        if isPointInside then
            currentZone = myZone.name
            --print("Entered: " .. myZone.name .. " at " .. point.x .. ", " .. point.y .. ", " .. point.z)
        else
            currentZone = nil
            --print("Exited: " .. myZone.name .. " at " .. point.x .. ", " .. point.y .. ", " .. point.z)
        end
    end)
end


RegisterNetEvent('cc_bed:confirmPlayerToBed')
AddEventHandler('cc_bed:confirmPlayerToBed', function(state)
    if onSleep then return end
    checkBedActive(state)
    pcall(function() -- Start Log
        exports['azael_dc-serverlogs']:insertData({
            event = 'ComfirmPlayerToBed',
            content = ('ผู้เล่นกำลังได้รับการรักษาประเภท %s ที่เตียงของโรงพยาบาล'):format(state),
        })
    end) -- End Log		
end)

RegisterNetEvent('cc_bed:cancelPlayerFromBed')
AddEventHandler('cc_bed:cancelPlayerFromBed', function()
    cancelActiveOnBed()
end)

function cancelActiveOnBed()
    if currentZone ~= nil then
        local playerPed = PlayerPedId()
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Wait(0)
        end
        DoScreenFadeIn(800)
        ClearPedTasks(playerPed)
        ClearPedSecondaryTask(playerPed)
        RequestAnimDict('switch@franklin@bed')
        while not HasAnimDictLoaded('switch@franklin@bed') do
            Wait(50)
        end
        SetEntityHeading(playerPed, GetEntityHeading(playerPed) + 90.0)
        TaskPlayAnim(playerPed, 'switch@franklin@bed', 'sleep_getup_rubeyes', -8.0, 8.0, 5000, 0, 0, 0, 0, 0)
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
        DetachEntity(playerPed,true, false)
        FreezeEntityPosition(playerPed, false)
        onSleep = false
        heal = false
        restHealthy = false
        restorePlayer = false
    end
end



function positionAttach(closestEntity,state)
	local playerPed = PlayerPedId()
    if state == "heal" then
        heal = true
        --print(heal)
    end
    if state == "healthy" then
        restHealthy = true
        --print(restHealthy)
    end
    if state == "restorePlayer" then
        restorePlayer = true
        --print(restHealthy)
    end
    AttachEntityToEntity(playerPed, closestEntity, 9816,0, 0.1, 1.4, 0, 0, 0, false, false, false, false, 2, false)
    FreezeEntityPosition(playerPed, true)
    onSleep = true
end

function playAnim()
    local playerPed = PlayerPedId()
    DisableAllControlActions(0)
    EnableControlAction(0,0,true)
    EnableControlAction(0,1,true)
    EnableControlAction(0,29,true)

    local dict = "amb@code_human_in_car_idles@low@ps@"
    LoadAnimationDictionary("amb@world_human_sunbathe@female@back@base")
    TaskPlayAnim(playerPed, "amb@world_human_sunbathe@female@back@base", "base", 8.0, -8, -1, 1, 2.0, false, false, false)
end


function LoadAnimationDictionary(animationD)
	while(not HasAnimDictLoaded(animationD)) do
		RequestAnimDict(animationD)
		Citizen.Wait(1)
	end
end

function checkBedActive(state)
    if currentZone == nil then return end
    Citizen.CreateThread(function()
            repeat
            Wait(0)
                local playerPed = PlayerPedId()
                local coords    = GetEntityCoords(playerPed)
                local closestDistance = -1 --
                local closestEntity   = nil --
                local objCoords = nil --
                local modelname = Config.BedList
                for i=1, #modelname, 1 do
                    local object = GetClosestObjectOfType(coords, 2.0, GetHashKey(modelname[i].name), false, false, false)
                    if DoesEntityExist(object) then
                        objCoords = GetEntityCoords(object)
                        local distance  = GetDistanceBetweenCoords(coords, objCoords, true)
                        if closestDistance == -1 or closestDistance > distance then
                            closestDistance = distance
                            closestEntity   = object
                        end
                    end
                end
                --local inAreaPlayer = ESX.Game.GetPlayersInArea(objCoords, 1.3)
                --print(#inAreaPlayer)
                if closestDistance ~= -1 and closestDistance <= 2.0 and not IsPedDeadOrDying(playerPed, true)  then --and #inAreaPlayer == 0 then
                        positionAttach(closestEntity,state)
                        playAnim()
                        setUniform(playerPed, playerPed)
                end

                if heal then
                    local health = GetEntityHealth(playerPed)
                    --print(health)
                    SetEntityHealth(playerPed, health+9)
                    if health >= 199 then
                        heal = false
                    end
                    Wait(2000)
                end
                if restHealthy then
                    --print(restHealthy)
                        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
                            if status.val >= 3000000 then
                                restHealthy = false
                            end
                            TriggerEvent("esx_status:add" ,  "thirst" , 150000)
                        end)
                    Wait(2000)
                end
                if restorePlayer then
                    --print(restHealthy)
                    local HealthyNow = 0
                    local health = GetEntityHealth(playerPed)
                    TriggerEvent('esx_status:getStatus', 'thirst', function(status)
                        HealthyNow = status.val
                        TriggerEvent("esx_status:add" ,  "thirst" , 150000)
                    end)
                    SetEntityHealth(playerPed, health+9)
                    if health >= 199 and HealthyNow >= 3000000 then
                        restorePlayer = false
                    end
                    Wait(2000)
                end
        until onSleep == false or isDead == true
    end)
end



function setUniform()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject
		if skin.sex == 0 then
			uniformObject = Config.Uniforms.Sick_person.male
		else
			uniformObject = Config.Uniforms.Sick_person.female
		end

		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
		else
			ESX.ShowNotification(('no_outfit'))
		end
	end)
end

AddEventHandler('esx:onPlayerSpawn', function()
    isDead = false
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    if onSleep then
        local playerPed = PlayerPedId()
        DetachEntity(playerPed)
        ClearPedTasksImmediately(playerPed)
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
    end
    onSleep = false
    alreadyAttach = false
    heal = false
    restHealthy = false
    restorePlayer = false
    isDead = true
end)