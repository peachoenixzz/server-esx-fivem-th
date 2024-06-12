Keys = {
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

local firstSpawn = true
local blipsAmbulance = {}
local canTalk = false
isDead, isSearched, medic = false, false, 0
propMedic = nil
local ongoingfreeze = false
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
  ESX.PlayerLoaded = false
  firstSpawn = true
end)

AddEventHandler('esx:onPlayerSpawn', function()
  isDead = false
  ClearTimecycleModifier()
  SetPedMotionBlur(PlayerPedId(), false)
  ClearExtraTimecycleModifier()
  SetPedDropsWeaponsWhenDead(PlayerPedId(),false)
  SetPedCanLosePropsOnDamage(PlayerPedId(),false,0)
  SetPedConfigFlag(
          PlayerPedId() --[[ Ped ]],
          35 --[[ integer ]],
          false --[[ boolean ]]
  )
  if GetPedMaxHealth(GetPlayerPed(-1)) ~= 200 then
    SetPedMaxHealth(GetPlayerPed(-1),200)
    SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) + 25)
  end
  SetPlayerHealthRechargeLimit(PlayerId(), 0.0)
  SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
  endDeathScreen()
  if firstSpawn then
    firstSpawn = false

    if Config.SaveDeathStatus then
      while not ESX.PlayerLoaded do
        Wait(1000)
      end

      ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(shouldDie)
        if shouldDie then
          Wait(1000)
          SetEntityHealth(PlayerPedId(), 0)
          return
        end
      end)
      TriggerServerEvent('esx_ambulancejob:spawned')
    end
  end

  local modelHash = GetHashKey("v_club_vu_pills")
  RequestModel(modelHash)
  while not HasModelLoaded(modelHash) do
    -- print("cant load model")
    Citizen.Wait(0)
  end
end)



-- Create blips
CreateThread(function()
  while true do
    local Sleep = 1500

    if isDead then
      Sleep = 0
      --ProcessCamControls()
      local playerPed = PlayerPedId()
      DisableAllControlActions(0)
      if IsPauseMenuActive() then
        EnableControlAction(0, 200, true)
      end
      EnableControlAction(0, 10, true)
      EnableControlAction(0, 0, true)
      EnableControlAction(0, Keys['G'], true)
      EnableControlAction(0, Keys['V'], true)
      EnableControlAction(0, Keys['X'], true)
      EnableControlAction(0, Keys['ENTER'], true)
      EnableControlAction(0, 1, true)
      EnableControlAction(0, 2, true)
      EnableControlAction(0, 236, true)
      EnableControlAction(0, 320, true)
      EnableControlAction(0, 325, true)

      if canTalk then
        EnableControlAction(0, 249, true) -- N
      end

      if isSearched then
        --local ped = GetPlayerPed(GetPlayerFromServerId(medic))
        isSearched = false
        --AttachEntityToEntity(playerPed, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        --Wait(1000)
        --DetachEntity(playerPed, true, false)
        --local playerPed = PlayerPedId()
        local configFlag --[[ boolean ]] = GetPedConfigFlag(
                playerPed --[[ Ped ]],
                71 --[[ integer ]],
                true --[[ boolean ]]
        )
        if IsEntityPlayingAnim(playerPed, 'missarmenian2', 'corpse_search_exit_ped', 3) or configFlag then
          TaskPlayAnim(playerPed, 'anim@amb@luxury_suite@drinks_enter@female_maid@female_player', 'cam_champagne_bepassed_normal', 8.0, 0, -1, 1, 0.0, false, false, false)
          goto endState
        end
        ClearPedTasksImmediately(playerPed)
      end
      ::endState::
    end
    Wait(Sleep)
  end
end)

RegisterNetEvent('esx_ambulancejob:clsearch')
AddEventHandler('esx_ambulancejob:clsearch', function(medicId)
  local playerPed = PlayerPedId()
  if isDead then
    local coords = GetEntityCoords(playerPed)
    local playersInArea = ESX.Game.GetPlayersInArea(coords, 50.0)

    for i = 1, #playersInArea, 1 do
      local player = playersInArea[i]
      if player == GetPlayerFromServerId(medicId) then
        medic = tonumber(medicId)
        isSearched = true
        break
      end
    end
  end
end)

function OnPlayerDeath()
  isDead = true
  TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)
  ClearPedTasksImmediately(GetPlayerPed(-1))
  IsDeadView()

  if not exports.cc_training:checkInZoneTraining() then
    startDeathScreen()
  end

  if exports.cc_training:checkInZoneTraining() then
    startDeathScreen(0.1)
  end

  if isBusy then
    TriggerEvent("mythic_progbar:client:cancel")
  end
end

IsDeadView = function()
  Citizen.CreateThread(function()
    local view = 0
    while true do
      Citizen.Wait(7)
      if isDead then
        if IsControlJustReleased(0, Keys["V"])  then
          view = view + 1
          if view == 1 then
            SetFollowPedCamViewMode(4)
          elseif view == 2 then
            SetFollowPedCamViewMode(0)
          elseif view == 3 then
            SetFollowPedCamViewMode(1)
          elseif view == 4 then
            view = 0
            SetFollowPedCamViewMode(2)
          end
        end
      else
        break
      end
    end
  end)
end

function SendDistressSignal()
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)
  if not exports.cc_training:checkInZoneTraining() then
    if exports.cc_bodybag:checkStatusBodyBag() then
      --ESX.TriggerServerCallback('esx_ambulancejob:playerCoords', function(formattedCoords)
      TriggerServerEvent('esx_addons_gcphone:startCall', 'police', 'หมดสติ (โดนห่อศพ)', coords, {
        PlayerCoords = { x = coords.x, y = coords.y, z = coords.z },
      })
      --end)
    end

    if not exports.cc_bodybag:checkStatusBodyBag() then
      --ESX.TriggerServerCallback('esx_ambulancejob:playerCoords', function(formattedCoords)
      TriggerServerEvent('esx_addons_gcphone:startCall', 'police', 'หมดสติ', coords, {
        PlayerCoords = { x = coords.x, y = coords.y, z = coords.z },
      })
      --end)
    end

    if not exports.cc_bodybag:checkStatusBodyBag() then
      TriggerEvent("Porpy_policealert:alertNet", "dead")
    end

    if exports.cc_bodybag:checkStatusBodyBag() then
      TriggerEvent("Porpy_policealert:alertNet", "dead2")
    end
  end

  --TriggerServerEvent('esx_ambulancejob:onPlayerDistress')
end

function GetClosestRespawnPoint()
  local PlyCoords = GetEntityCoords(PlayerPedId())
  local ClosestDist, ClosestHospital, ClosestCoord = 10000, {}, nil
  for k, v in pairs(Config.RespawnPoints) do
    local Distance = #(PlyCoords - vector3(v.coords.x, v.coords.y, v.coords.z))
    if Distance <= ClosestDist then
      ClosestDist = Distance
      ClosestHospital = v
      ClosestCoord = vector3(v.coords.x, v.coords.y, v.coords.z)
    end
  end
  return ClosestCoord, ClosestHospital
end

local function freezePlayer(id, freeze)
  local player = id
  SetPlayerControl(player, not freeze, false)

  local ped = GetPlayerPed(player)

  if not freeze then
    -- if not IsEntityVisible(ped) then
    --   SetEntityVisible(ped, true)
    -- end

    if not IsPedInAnyVehicle(ped) then
      SetEntityCollision(ped, true)
    end

    FreezeEntityPosition(ped, false)
    --SetCharNeverTargetted(ped, false)
    SetPlayerInvincible(player, false)
  else
    -- if IsEntityVisible(ped) then
    --   SetEntityVisible(ped, false)
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

function respawnPedToHospital(ped, coords, heading)
    SwitchOutPlayer(ped,0,1)
    Citizen.Wait(1000)
    freezePlayer(PlayerId(), true)
    -- preload collisions for the spawnpoint
    RequestCollisionAtCoord(coords.x, coords.y, coords.z)
    -- spawn the player
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z+1.0, false, false, false, true)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, true, false)
    SetGameplayCamRelativeHeading(heading)
    SetEntityHeading(ped, heading)
    --SetPlayerInvincible(ped, false)
    ClearPedBloodDamage(ped)
    FreezeEntityPosition(ped, true)
    Citizen.Wait(1000)
    local time = GetGameTimer()
    while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 30000) do
      RequestCollisionAtCoord(coords.x, coords.y, coords.z)
      Citizen.Wait(0)
    end
    FreezeEntityPosition(ped, true)
    TriggerServerEvent('esx:onPlayerSpawn')
    TriggerEvent('esx:onPlayerSpawn')
    TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
    FreezeEntityPosition(ped, true)
    SwitchInPlayer(ped)
    ongoingfreeze = true
    unFreeze()
    TriggerEvent("Porpy_policealert:alertNet", "bleeding")
end

function respawnPedToDeadRoom(ped)
  local coords = vector3(-426.5199890136719, 1091.93994140625, 317.3599853515625)
  SwitchOutPlayer(ped,0,1)
  Citizen.Wait(1000)
  freezePlayer(PlayerId(), true)
  -- preload collisions for the spawnpoint
  RequestCollisionAtCoord(coords.x, coords.y, coords.z)
  -- spawn the player
  SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z+0.7, false, false, false, true)
  NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, true, false)
  SetGameplayCamRelativeHeading(0.0)
  SetEntityHeading(ped, 166.03)
  --SetPlayerInvincible(ped, false)
  ClearPedBloodDamage(ped)
  FreezeEntityPosition(ped, true)
  Citizen.Wait(1000)
  local time = GetGameTimer()
  while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 30000) do
    RequestCollisionAtCoord(coords.x, coords.y, coords.z)
    Citizen.Wait(0)
  end
  FreezeEntityPosition(ped, true)
  TriggerServerEvent('esx:onPlayerSpawn')
  TriggerEvent('esx:onPlayerSpawn')
  TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
  FreezeEntityPosition(ped, true)
  SwitchInPlayer(ped)
  ongoingfreeze = true
	unFreeze()
  TriggerEvent("Porpy_policealert:alertNet", "bleeding_shroud")
end

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

function RemoveItemsAfterRPDeath(choice)
  if choice == "normal" then
    local alreadyBodyBag = exports.cc_bodybag:checkStatusBodyBag()
    TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
    CreateThread(function()
      ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
        if not alreadyBodyBag then
          local RespawnCoords, ClosestHospital = GetClosestRespawnPoint()
          respawnPedToHospital(PlayerPedId(), RespawnCoords, ClosestHospital.heading)
          TriggerEvent("esx_status:set" ,  "thirst" , 1500000)
          TriggerEvent("esx_status:set" ,  "hunger" , 1500000)
          TriggerEvent("esx_status:set" ,  "stress" , 0)
        end
        if alreadyBodyBag then
          respawnPedToDeadRoom(PlayerPedId())
          TriggerEvent("esx_status:set" ,  "thirst" , 1500000)
          TriggerEvent("esx_status:set" ,  "hunger" , 1500000)
          TriggerEvent("esx_status:set" ,  "stress" , 0)
          exports.cc_bodybag:cancelBodyBag()
        end
        --ESX.SetPlayerData('loadout', {})
      end,alreadyBodyBag)
    end)
  end

  if choice == "training" and exports.cc_training:checkInZoneTraining() then
    CreateThread(function()
      local ped = PlayerPedId()
      ESX.TriggerServerCallback('esx_ambulancejob:playerCoords', function(formattedCoords)
        TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
        SetEntityCoordsNoOffset(ped, formattedCoords, false, false, false)
        NetworkResurrectLocalPlayer(formattedCoords, true, false)
        SetPlayerInvincible(ped, false)
        ClearPedBloodDamage(ped)
        ClearPedEnvDirt(ped)
        TriggerServerEvent('esx:onPlayerSpawn')
        TriggerEvent('esx:onPlayerSpawn')
        TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
        TriggerEvent("esx_status:set" ,  "thirst" , 1000000)
        TriggerEvent("esx_status:set" ,  "hunger" , 1000000)
        TriggerEvent("esx_status:set" ,  "stress" , 1500000)
        local radiusToFloat = 100.0 + 0.0
        -- WTF?: User reports that this native actually clears dead peds compared to
        -- ClearArea? Weird considering Gottfried updated this native from _CLEAR_AREA_OF_EVERYTHING
        -- after found nativedb info. Maybe needs research lmao?
        ClearAreaLeaveVehicleHealth(formattedCoords, radiusToFloat, false, false, false, false, false)
        isDead = false
      end)
    end)
  end
end

function RespawnPed(ped, coords, heading)
  SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false)
  NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
  SetPlayerInvincible(ped, false)
  ClearPedBloodDamage(ped)
  TriggerServerEvent('esx:onPlayerSpawn')
  TriggerEvent('esx:onPlayerSpawn')
  TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
  --endDeathScreen()
end

function startDeathScreen(custom)
  custom = custom or 40.0
  if not exports.cc_training:checkInZoneTraining() then
    SendNUIMessage({
      action = "openDeathScreen",
      playerid = GetPlayerServerId(PlayerId()),
      medic_count = exports.Dv_Hunter_Check:CheckPoliceToScoreboard(),
      time = custom,
      trainingZone = false
    })
    SetNuiFocus(true, false)
    SetNuiFocusKeepInput(true)
  end

  if exports.cc_training:checkInZoneTraining() then
    SendNUIMessage({
      action = "openDeathScreen",
      playerid = GetPlayerServerId(PlayerId()),
      medic_count = exports.Dv_Hunter_Check:CheckPoliceToScoreboard(),
      time = custom,
      trainingZone = true
    })
    SetNuiFocus(true, false)
    SetNuiFocusKeepInput(true)
  end

end

function endDeathScreen()
  SendNUIMessage({
    action = "closeAll",
  })
  SetNuiFocusKeepInput(false)
  SetNuiFocus(false, false)
end

function allowTalk()
  Citizen.CreateThread(function()
    Wait(0)
    local targetTime = GetGameTimer() + 60000
    canTalk = true
    while GetGameTimer() < targetTime do
      Citizen.Wait(1000) -- Check every second
    end
    canTalk = false
  end)
end

RegisterNetEvent('esx_ambulancejob:requestTalk')
AddEventHandler('esx_ambulancejob:requestTalk', function()
  allowTalk()
end)


RegisterNUICallback("respawnPlayer", function(data, cb)
  RemoveItemsAfterRPDeath(data.choice)
  endDeathScreen()
  canTalk = false
  cb("ok")
end)

RegisterNUICallback("requestToTalk", function(data, cb)
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  if closestPlayer ~= -1 and closestDistance <= 4.0 then
    if not IsEntityDead(GetPlayerPed(closestPlayer)) then
      exports['okokRequests']:requestMenu(GetPlayerServerId(closestPlayer), 60000, "คำขอจากผู้หมดสติ", "ผู้หมดสติขอพูดคุยกับคุณ", "esx_ambulancejob:requestTalk", "client")
      cb(true)
      return
    end
  end
  cb(false)
end)

RegisterNUICallback("resetDeadBody", function(data, cb)
  local playerPed = PlayerPedId()
  local configFlag --[[ boolean ]] = GetPedConfigFlag(
          playerPed --[[ Ped ]],
          71 --[[ integer ]],
          true --[[ boolean ]]
  )
  if IsEntityPlayingAnim(playerPed, 'missarmenian2', 'corpse_search_exit_ped', 3) or configFlag then
    TaskPlayAnim(playerPed, 'anim@amb@luxury_suite@drinks_enter@female_maid@female_player', 'cam_champagne_bepassed_normal', 8.0, 0, -1, 1, 0.0, false, false, false)
    cb("ok")
    return
  end
    ClearPedTasksImmediately(playerPed)
    cb("ok")
end)

RegisterNUICallback("sendMessage", function(data, cb)
  SendDistressSignal()
  cb("ok")
end)

--RegisterNetEvent('esx_phone:loaded')
--AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
--  local specialContact = {
--    name       = 'Ambulance',
--    number     = 'ambulance',
--    base64Icon = 'data:image/png;base64,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'
--  }
--  TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
--end)

AddEventHandler('esx:onPlayerDeath', function(data)
  if not isDead then
    OnPlayerDeath()
  end

  if propMedic ~= nil then
    DeleteEntity(propMedic)
  end

  if isBusy then
    onProcess = false
    isBusy = false
    helpNotify = true
  end
end)

function StartDeathCam()
  ClearFocus()
  local playerPed = PlayerPedId()
  cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", GetEntityCoords(playerPed), 0, 0, 0, GetGameplayCamFov())
  SetCamActive(cam, true)
  RenderScriptCams(true, true, 1000, true, false)
end

-- destroy camera
function EndDeathCam()
  ClearFocus()
  RenderScriptCams(false, false, 0, true, false)
  DestroyCam(cam, false)
  cam = nil
end

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function()
  local playerPed = PlayerPedId()
  TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
  Citizen.CreateThread(function()
    DoScreenFadeOut(800)
    while not IsScreenFadedOut() do
      Wait(50)
    end
    --local formattedCoords = {x = ESX.Math.Round(coords.x, 1), y = ESX.Math.Round(coords.y, 1), z = ESX.Math.Round(coords.z, 1)}
    exports.cc_bodybag:cancelBodyBag()
    ESX.TriggerServerCallback('esx_ambulancejob:playerCoords', function(formattedCoords)
      RespawnPed(playerPed, formattedCoords, 0.0)
    end)
    isDead = false
    --ClearTimecycleModifier()
    --SetPedMotionBlur(playerPed, false)
    --ClearExtraTimecycleModifier()
    --EndDeathCam()
    DoScreenFadeIn(800)
    Wait(1000)

    TriggerEvent("esx_status:set" ,  "hunger" , 600000)

    TriggerEvent('esx_status:getStatus', 'stress', function(status)
      local stress = status.val - 300000
      TriggerEvent("esx_status:set" ,  "stress" , stress)
    end)

    TriggerEvent('esx_status:getStatus', 'thirst', function(status)
      local thirst = status.val - 300000
      if thirst <= 0 then
        TriggerEvent("esx_status:set" ,  "thirst" , 300000)
      end
      if thirst >= 0 then
        TriggerEvent("esx_status:set" ,  "thirst" , thirst)
      end
    end)
    SetEntityHealth(PlayerPedId(), 110)
  end)
end)

RegisterNetEvent('esx_ambulancejob:reviveAllByAmbulance')
AddEventHandler('esx_ambulancejob:reviveAllByAmbulance', function()
  local playerPed = PlayerPedId()
  TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
  Citizen.CreateThread(function()
    DoScreenFadeOut(800)
    while not IsScreenFadedOut() do
      Wait(50)
    end
    --local formattedCoords = {x = ESX.Math.Round(coords.x, 1), y = ESX.Math.Round(coords.y, 1), z = ESX.Math.Round(coords.z, 1)}
    exports.cc_bodybag:cancelBodyBag()
    ESX.TriggerServerCallback('esx_ambulancejob:playerCoords', function(formattedCoords)
      RespawnPed(playerPed, formattedCoords, 0.0)
    end)
    isDead = false
    --ClearTimecycleModifier()
    --SetPedMotionBlur(playerPed, false)
    --ClearExtraTimecycleModifier()
    --EndDeathCam()
    DoScreenFadeIn(800)
    Wait(1000)

    TriggerEvent("esx_status:set" ,  "hunger" , 1500000)
    TriggerEvent('esx_status:getStatus', 'stress', function(status)
      local stress = status.val - 300000
      TriggerEvent("esx_status:set" ,  "stress" , stress)
    end)
    TriggerEvent("esx_status:set" ,  "thirst" , 3000000)
    SetEntityHealth(PlayerPedId(), 200)
  end)
end)

RegisterNetEvent('esx_ambulancejob:reviveAdmin')
AddEventHandler('esx_ambulancejob:reviveAdmin', function()
  local playerPed = PlayerPedId()
  TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
  Citizen.CreateThread(function()
    DoScreenFadeOut(800)
    while not IsScreenFadedOut() do
      Wait(50)
    end
    --local formattedCoords = {x = ESX.Math.Round(coords.x, 1), y = ESX.Math.Round(coords.y, 1), z = ESX.Math.Round(coords.z, 1)}
    exports.cc_bodybag:cancelBodyBag()
    ESX.TriggerServerCallback('esx_ambulancejob:playerCoords', function(formattedCoords)
      RespawnPed(playerPed, formattedCoords, 0.0)
    end)
    local armor = 0
    if not isDead then
       armor = GetPedArmour(playerPed)
    end
    isDead = false
    --ClearTimecycleModifier()
    --SetPedMotionBlur(playerPed, false)
    --ClearExtraTimecycleModifier()
    --EndDeathCam()
    DoScreenFadeIn(800)
    Wait(1000)

    TriggerEvent("esx_status:set" ,  "hunger" , 3000000)
    TriggerEvent("esx_status:set" ,  "stress" , 0)
    TriggerEvent("esx_status:set" ,  "thirst" , 3000000)
    SetPedArmour(playerPed, armor)
    SetEntityHealth(PlayerPedId(), 200)
  end)
end)

RegisterNetEvent('esx_ambulancejob:healPlayerEvent')
AddEventHandler('esx_ambulancejob:healPlayerEvent', function()
    local playerPed = PlayerPedId()
    TriggerEvent("esx_status:set" ,  "hunger" , 3000000)
    TriggerEvent("esx_status:set" ,  "stress" , 0)
    TriggerEvent("esx_status:set" ,  "thirst" , 3000000)
    Wait(1000)
    SetEntityHealth(playerPed, 200)
end)



RegisterNetEvent('esx_ambulancejob:citizenRevive')
AddEventHandler('esx_ambulancejob:citizenRevive', function()
  local playerPed = PlayerPedId()
  TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
  Citizen.CreateThread(function()
    DoScreenFadeOut(800)
    while not IsScreenFadedOut() do
      Wait(50)
    end

    --local formattedCoords = {x = ESX.Math.Round(coords.x, 1), y = ESX.Math.Round(coords.y, 1), z = ESX.Math.Round(coords.z, 1)}
    exports.cc_bodybag:cancelBodyBag()
    ESX.TriggerServerCallback('esx_ambulancejob:playerCoords', function(formattedCoords)
      RespawnPed(playerPed, formattedCoords, 0.0)
    end)
    isDead = false
    --ClearTimecycleModifier()
    --SetPedMotionBlur(playerPed, false)
    --ClearExtraTimecycleModifier()
    --EndDeathCam()
    DoScreenFadeIn(800)
    Wait(1000)

    TriggerEvent("esx_status:set" ,  "hunger" , 1500000)

    TriggerEvent('esx_status:getStatus', 'stress', function(status)
      local stress = status.val - 300000
      TriggerEvent("esx_status:set" ,  "stress" , stress)
    end)

    TriggerEvent('esx_status:getStatus', 'thirst', function(status)
      local thirst = status.val - 300000
      if thirst <= 0 then
        TriggerEvent("esx_status:set" ,  "thirst" , 300000)
      end
      if thirst >= 0 then
        TriggerEvent("esx_status:set" ,  "thirst" , thirst)
      end
    end)
    SetEntityHealth(PlayerPedId(), 150)
  end)
end)


-- Load unloaded IPLs
if Config.LoadIpl then
  RequestIpl('Coroner_Int_on') -- Morgue
end