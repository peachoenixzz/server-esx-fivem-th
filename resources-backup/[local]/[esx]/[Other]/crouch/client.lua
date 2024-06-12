local pointing = false
local oldval = false
local oldvalped = false
local handsup = false
local crouched = false

RegisterCommand('pointing', function()
    if exports.cc_bodybag:checkStatusBodyBag() then return end
    local configFlag --[[ boolean ]] = GetPedConfigFlag(
            PlayerPedId() --[[ Ped ]],
            71 --[[ integer ]],
            true --[[ boolean ]]
    )
    if IsEntityPlayingAnim(playerPed, 'missarmenian2', 'corpse_search_exit_ped', 3) or configFlag then return end
    local player = PlayerPedId()
    local incarkeyx = IsPedInAnyVehicle(player, true)
    if GetSelectedPedWeapon(player) == GetHashKey("weapon_unarmed") then
        if not incarkeyx then
            if not pointing then
                pointing = true
                Citizen.CreateThread(function()
                    while pointing do
                        Citizen.Wait(0)
                        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
                            if not IsPedOnFoot(PlayerPedId()) then
                                stopPointing()
                            else
                                local ped = PlayerPedId()
                                local camPitch = GetGameplayCamRelativePitch()
                                if camPitch < -70.0 then
                                    camPitch = -70.0
                                elseif camPitch > 42.0 then
                                    camPitch = 42.0
                                end
                                camPitch = (camPitch + 70.0) / 112.0

                                local camHeading = GetGameplayCamRelativeHeading()
                                local cosCamHeading = Cos(camHeading)
                                local sinCamHeading = Sin(camHeading)
                                if camHeading < -180.0 then
                                    camHeading = -180.0
                                elseif camHeading > 180.0 then
                                    camHeading = 180.0
                                end
                                camHeading = (camHeading + 180.0) / 360.0

                                local blocked = 0
                                local nn = 0

                                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                                nn,blocked,coords,coords = GetRaycastResult(ray)

                                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

                            end
                        end
                    end
                end)
                startPointing()
            elseif pointing then
                Citizen.CreateThread(function()
                    while pointing do
                        Citizen.Wait(0)

                        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not pointing then
                            stopPointing()
                        end
                    end
                end)
                stopPointing()
                pointing = false
            end
        end
    end
end, false)

RegisterKeyMapping('pointing', 'Pointing', 'keyboard', 'B')  --ปุ่มกด
--------- [Right Stick] on GamePad

function startPointing()
    --print(1)
    local ped = PlayerPedId()
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Citizen.Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

function stopPointing()
    --print(2)
    local ped = PlayerPedId()
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

function checkPedCanRob()
    return exports.nc_thief:OnAnimation()
end
function clearPedTask()
    if checkPedCanRob() then
        return
    end
    ClearPedTasks(GetPlayerPed(-1))
end

--RegisterCommand('handsup', function()
--    clearPedTask()
--end, false)
--RegisterKeyMapping('handsup', 'Hands Up', 'keyboard', 'X')  --ปุ่มกด

Crouched = false
CrouchedForce = false
Aimed = false
Cooldown = false
PlayerInfo = {
    playerPed = PlayerPedId(),
    playerID = GetPlayerIndex(),
    nextCheck = GetGameTimer() + 20
}
CoolDownTime = 10 -- in ms

NormalWalk = function()
    SetPedMaxMoveBlendRatio(PlayerInfo.playerPed, 1.0)
    ResetPedMovementClipset(PlayerInfo.playerPed, 0.55)
    ResetPedStrafeClipset(PlayerInfo.playerPed)
    SetPedCanPlayAmbientAnims(PlayerInfo.playerPed, true)
    SetPedCanPlayAmbientBaseAnims(PlayerInfo.playerPed, true)
    ResetPedWeaponMovementClipset(PlayerInfo.playerPed)
    Crouched = false
end

SetupCrouch = function()
    while not HasAnimSetLoaded('move_ped_crouched') do
        Citizen.Wait(5)
        RequestAnimSet('move_ped_crouched')
    end
end

RemoveCrouchAnim = function()
    RemoveAnimDict('move_ped_crouched')
end

CanCrouch = function()
    if IsPedOnFoot(PlayerInfo.playerPed) and not IsPedInAnyVehicle(PlayerInfo.playerPed, false) and not IsPedJumping(PlayerInfo.playerPed) and not IsPedFalling(PlayerInfo.playerPed) and not IsPedDeadOrDying(PlayerInfo.playerPed) then
        return true
    else
        return false
    end
end

CrouchPlayer = function()
    SetPedUsingActionMode(PlayerInfo.playerPed, false, -1, "DEFAULT_ACTION")
    SetPedMovementClipset(PlayerInfo.playerPed, 'move_ped_crouched', 0.55)
    SetPedStrafeClipset(PlayerInfo.playerPed, 'move_ped_crouched_strafing') -- it force be on third person if not player will freeze but this func make player can shoot with good anim on crouch if someone know how to fix this make request :D
    SetWeaponAnimationOverride(PlayerInfo.playerPed, "Ballistic")
    Crouched = true
    Aimed = false
end

SetPlayerAimSpeed = function()
    SetPedMaxMoveBlendRatio(PlayerInfo.playerPed, 0.2)
    Aimed = true
end

IsPlayerFreeAimed = function()
    if IsPlayerFreeAiming(PlayerInfo.playerID) or IsAimCamActive() or IsAimCamThirdPersonActive() then
        return true
    else
        return false
    end
end

CrouchLoop = function()
    SetupCrouch()
    while CrouchedForce do
        DisableFirstPersonCamThisFrame()

        local now = GetGameTimer()
        if now >= PlayerInfo.nextCheck then
            PlayerInfo.playerPed = PlayerPedId()
            PlayerInfo.playerID = GetPlayerIndex()
            PlayerInfo.nextCheck = now + 20
        end

        local CanDo = CanCrouch()
        if CanDo and Crouched and IsPlayerFreeAimed() then
            SetPlayerAimSpeed()
        elseif CanDo and (not Crouched or Aimed) then
            CrouchPlayer()
        elseif not CanDo and Crouched then
            CrouchedForce = false
            NormalWalk()
        end

        Citizen.Wait(5)
    end
    NormalWalk()
    RemoveCrouchAnim()
end

RegisterCommand('crouch', function()
    DisableControlAction(0, 36, true) -- magic
    if not Cooldown then
        CrouchedForce = not CrouchedForce

        if CrouchedForce then
            CreateThread(CrouchLoop) -- Magic Part 2 lamo
        end

        Cooldown = true
        SetTimeout(CoolDownTime, function()
            Cooldown = false
        end)
    end
end, false)

RegisterKeyMapping('crouch', 'Crouch', 'keyboard', 'LCONTROL') -- now its better player can change to any bottom they want


-- Exports --
IsCrouched = function()
    return Crouched
end

exports("IsCrouched", IsCrouched)

--Citizen.CreateThread(function()
--	while true do
--		Citizen.Wait(7)
--		DisableControlAction(0, 36, true)
--	end
--end)
