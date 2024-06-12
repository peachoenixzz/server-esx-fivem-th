--global variable
local dizzyState = false
local ongoingfreeze = false


--start zone
RegisterNetEvent('core_effect_start:scuba')
AddEventHandler('core_effect_start:scuba', function()
    local playerPed  = PlayerPedId()
    SetPedDiesInWater(playerPed, false)
end)

RegisterNetEvent('core_effect_start:gov_scuba')
AddEventHandler('core_effect_start:gov_scuba', function()
    local playerPed  = PlayerPedId()
    SetPedDiesInWater(playerPed, false)
end)


RegisterNetEvent('core_effect_start:dizzy')
AddEventHandler('core_effect_start:dizzy', function(effectInGame)
    --print("start dizzy time")
    --print(effectInGame)
    dizzyState = true
    effectInGame = ESX.Math.Round(effectInGame, 1)
    local playerPed = PlayerPedId()
    SetTimecycleModifier("Drunk")
    SetTimecycleModifierStrength(effectInGame * 0.2);
    ShakeGameplayCam("DRUNK_SHAKE", effectInGame * 0.2)
    SetPedMotionBlur(playerPed, true)
    RequestAnimSet("move_m@drunk@verydrunk")
    SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
end)

RegisterNetEvent('core_effect_start:adrenaline')
AddEventHandler('core_effect_start:adrenaline', function()
    SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
end)

RegisterNetEvent('core_effect_start:r_adrenaline')
AddEventHandler('core_effect_start:r_adrenaline', function()
    SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
end)

RegisterNetEvent('core_effect_start:gov_adrenaline')
AddEventHandler('core_effect_start:gov_adrenaline', function()
    SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
end)


RegisterNetEvent('core_effect_start:escape_prison_gps')
AddEventHandler('core_effect_start:escape_prison_gps', function()
    --print("core gps start")--
end)

RegisterNetEvent('core_effect_start:house_rob_time')
AddEventHandler('core_effect_start:house_rob_time', function()
    --print("core gps start")--
end)

--stop zone

RegisterNetEvent('core_effect_stop:adrenaline')
AddEventHandler('core_effect_stop:adrenaline', function()
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
end)

RegisterNetEvent('core_effect_stop:gov_adrenaline')
AddEventHandler('core_effect_stop:gov_adrenaline', function()
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
end)

RegisterNetEvent('core_effect_stop:r_adrenaline')
AddEventHandler('core_effect_stop:r_adrenaline', function()
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
end)

RegisterNetEvent('core_effect_stop:auto_farm')
AddEventHandler('core_effect_stop:auto_farm', function()
end)

RegisterNetEvent('core_effect_stop:gov_scuba')
AddEventHandler('core_effect_stop:gov_scuba', function()
    local playerPed  = PlayerPedId()
    SetPedDiesInWater(playerPed, true)
end)

RegisterNetEvent('core_effect_stop:scuba')
AddEventHandler('core_effect_stop:scuba', function()
    local playerPed  = PlayerPedId()
    SetPedDiesInWater(playerPed, true)
end)

RegisterNetEvent('core_effect_stop:dizzy')
AddEventHandler('core_effect_stop:dizzy', function()
    dizzyState = false
    local playerPed = PlayerPedId()
    ResetPedMovementClipset(playerPed, 0)
    ResetPedWeaponMovementClipset(playerPed)
    ResetPedStrafeClipset(playerPed)
    SetTimecycleModifier("default")
    SetTimecycleModifierStrength(0.0);
    SetPedMotionBlur(playerPed, false)
    ShakeGameplayCam("DRUNK_SHAKE", 0)
end)

RegisterNetEvent('core_effect_stop:ad_clipper')
AddEventHandler('core_effect_stop:ad_clipper', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end)

RegisterNetEvent('core_effect_stop:ad_spray')
AddEventHandler('core_effect_stop:ad_spray', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end)


RegisterNetEvent('core_effect_stop:dead_by_shroud')
AddEventHandler('core_effect_stop:dead_by_shroud', function()
    local playerPed = PlayerPedId()
    local coords = {
        vector3(1082.6117, -788.6505, 58.2627), -- ชมพู
        vector3(973.7130, -731.8982, 57.8518), -- ชมพู
        vector3(-1559.0342, -415.5915, 38.0969), --ฟ้า
        vector3(-1458.6096, -376.2415, 38.9369), --ฟ้า
        vector3(276.9068, -310.7269, 49.8643), --เขียว
        vector3(333.9918, -153.5195, 62.1484), --เขียว
        vector3(-343.3384, -1028.4535, 36.3510), --เหลือง
        vector3(-285.8518, -776.0845, 38.7810), --เหลือง
        vector3(98.2505, -1589.8661, 36.1487), --แดง
        vector3(-38.2091, -1523.3495, 31.3187), --แดง
        vector3(1211.9838, -3295.3076, 13.4026), --ท่าเรือ
        vector3(1279.2144, -3252.5891, 5.9016), --ท่าเรือ
        vector3(-349.4149, -44.2029, 54.4231), --อู๋
    }
    local i = math.random(1,#coords)
    SwitchOutPlayer(playerPed,0,1)
    Citizen.Wait(1000)
    freezePlayer(PlayerId(), true)
    RequestCollisionAtCoord(coords[i].x, coords[i].y, coords[i].z)
    SetEntityCoordsNoOffset(playerPed, coords[i].x, coords[i].y, coords[i].z+0.3, false, false, false)
    NetworkResurrectLocalPlayer(coords[i].x, coords[i].y, coords[i].z, 0.0, true, true, false)
    SetGameplayCamRelativeHeading(0.0)
    SetEntityHeading(playerPed, 0.0)
    Citizen.Wait(1000)
    local time = GetGameTimer()
    while (not HasCollisionLoadedAroundEntity(playerPed) and (GetGameTimer() - time) < 30000) do
        RequestCollisionAtCoord(coords[i].x, coords[i].y, coords[i].z)
        Citizen.Wait(0)
    end
    SwitchInPlayer(playerPed)
    ongoingfreeze = true
	unFreeze()
end)

RegisterNetEvent('core_effect_stop:escape_prison_gps')
AddEventHandler('core_effect_stop:escape_prison_gps', function()
    --print("core gps stop")
    TriggerServerEvent('cc_prisongps:untrackprisonGpsBlip')
end)

RegisterNetEvent('core_effect_stop:house_rob_time')
AddEventHandler('core_effect_stop:house_rob_time', function()
    exports.cc_houserobberry:forceExit()
end)


--function callback
function checkDizzyState()
    return dizzyState
end

--local func

function unFreeze()
	Citizen.Wait(5000)
	exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิกแช่แข็ง")
	if ongoingfreeze then
		Citizen.CreateThread(function()
			while ongoingfreeze do
				Citizen.Wait(0)
				if IsControlJustReleased(0, 73) then
					exports.helpnotify:hideHelpNotification()
					freezePlayer(PlayerId(), false)
					ongoingfreeze = false
				end
			end
		end)
	end
end

function freezePlayer(id, freeze)
    local player = id
    SetPlayerControl(player, not freeze, false)

    local ped = GetPlayerPed(player)

    if not freeze then
        -- if not IsEntityVisible(ped) then
        --     SetEntityVisible(ped, true)
        -- end

        if not IsPedInAnyVehicle(ped) then
            SetEntityCollision(ped, true)
        end

        FreezeEntityPosition(ped, false)
        --SetCharNeverTargetted(ped, false)
        SetPlayerInvincible(player, false)
    else
        -- if IsEntityVisible(ped) then
        --     SetEntityVisible(ped, false)
        -- end

        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        --SetCharNeverTargetted(ped, true)
        SetPlayerInvincible(player, true)
        --RemovePtfxFromPed(ped)

        if not IsPedFatallyInjured(ped) then
            ClearPedTasksImmediately(ped)
        end
    end
end

RegisterNetEvent('cc_coreeffect:useitem')
AddEventHandler('cc_coreeffect:useitem', function (itemName)	
    processuseitemCoreEffect(itemName)
end)

function processuseitemCoreEffect(itemName)
    TriggerEvent("mythic_progbar:client:progress",{
        name = "useitem",
        duration = 3000,
        label = "กำลังใช้งาน",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = false,
        },
    }, function(status)
        if not status then
            ESX.TriggerServerCallback('cc_coreeffect:checkitemaddcore', function(success)
                if not success then
                    notinoitemtoaddcoreEffect()
                end
            end, itemName)
        end
    end)
end

function notinoitemtoaddcoreEffect() --
	exports.nc_notify:PushNotification({
		scale = 1.0, -- ปรับขนาดของ Notify
		title = 'คุณไม่มีสิ่งของที่กำหนด', -- หัวเรื่อง
		description = 'คุณไม่มีสิ่งของที่กำหนด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
		type = 'warning',
		position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
		direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
		priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
		icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
		duration = 3000 -- ระยะเวลาการแสดง Notify
	})
end
