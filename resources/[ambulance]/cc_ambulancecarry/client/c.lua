Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(1)
    end
end)
local isDead = false
local deadPlayerData = {}
local carry = {
    InProgress = false,
    targets = {}, -- Array of player IDs to carry
    targetSrc = -1,
    type = "",
    personCarrying = {
        animDict = "missfinale_c2mcs_1",
        anim = "fin_c2_mcs_1_camman",
        flag = 49,
    },
    personCarried = {
        animDict = "nm",
        anim = "firemans_carry",
        attachX = 1.0,
        attachY = 1.0,
        attachZ = 2.0,
        flag = 33,
    },
   dragdeath = {
        index = 1,
        label = "Carry Corpse",
        lib = 'missfinale_c2mcs_1',
        lib2 = 'nm',
        anim1 = 'fin_c2_mcs_1_camman',
        anim2 = 'firemans_carry',
        distans = 0.15,
        distans2 = 0.27,
        height = 0.73,
        spin = 0.0,
        length = 100000,
        controlFlagMe = 49,
        controlFlagTarget = 33,
        animFlagTarget = 1,
        deathonly = true,
    },
}


local function ensureAnimDict(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(0)
        end
    end
    return animDict
end


function carryPlayer(targetSrc)
    --if not carry.InProgress then
        --local closestPlayer = GetClosestPlayer(3)
        --if closestPlayer then
    local targetServerID = GetPlayerServerId(targetSrc)
    print("number carry start",#carry.targets)
    if targetSrc ~= -1 and not dropPlayer(targetSrc) then
        print("we are here in drag")
        carry.InProgress = true
        --carry.targetSrc = targetSrc
        DetachEntity(targetSrc, false, false)
        table.insert(carry.targets, targetSrc)
        print("number carry end",#carry.targets)
        TriggerServerEvent("CarryPeople:sync",targetServerID)
        ensureAnimDict(carry.personCarrying.animDict)
        carry.type = "carrying"
        
        return
    end
        --else
        --    drawNativeNotification("~r~No one nearby to carry!")
        --end
    --else
    --    carry.InProgress = false
    Citizen.Wait(500)
        print("we are here in drop")
        --ClearPedSecondaryTask(targetSrc)
        --DetachEntity(targetSrc, true, true)
    TriggerServerEvent("CarryPeople:stop",targetServerID)
    print("number carry drop",#carry.targets)
    if #carry.targets == 0 then
        ClearPedTasksImmediately(PlayerPedId())
        DetachEntity(PlayerPedId(), true, true)
        carry.type = ""
        carry.targetSrc = 0
        carry.InProgress = false
    end
end

function dropPlayer(targetSrc)
    for i=0, #carry.targets do
        if carry.targets[i] == targetSrc then
            --carry.InProgress = false
            carry.targets[i] = nil -- Remove the player from the targets array
            return true
        end
    end
end

RegisterNetEvent("CarryPeople:syncTarget")
AddEventHandler("CarryPeople:syncTarget", function(targetSrc)
    local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
    local playerPed = PlayerPedId()
    carry.InProgress = true
    ensureAnimDict(carry.personCarried.animDict)

    if IsEntityDead(playerPed) then
        ReviveAfterDead()
    end
    ClearPedTasksImmediately(playerPed)
    Wait(100)
    AttachEntityToEntity(playerPed, targetPed, 0, carry.dragdeath.distans2, carry.dragdeath.distans, carry.dragdeath.height, 0.5, 0.5, carry.dragdeath.spin, false, false, false, false, 2, false)
    FreezeEntityPosition(playerPed, true)
    --AttachEntityToEntity(PlayerPedId(), targetPed, 0, carry.personCarried.attachX, carry.personCarried.attachY, carry.personCarried.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
    --AttachEntityToEntity(PlayerPedId(), targetPed, 0, carry.personCarried.attachX, carry.personCarried.attachY, carry.personCarried.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
    carry.type = "beingcarried"
end)

RegisterNetEvent("CarryPeople:cl_stop")
AddEventHandler("CarryPeople:cl_stop", function()
    local playerPed = PlayerPedId()
    carry.InProgress = false

    if isDead then
        SetEntityHealth(playerPed, 0)
    else
        SetPedConfigFlag(playerPed, 71, false)
    end

    FreezeEntityPosition(playerPed, false)
    DetachEntity(playerPed, true, false)
    ClearPedTasksImmediately(playerPed)
end)

RegisterNetEvent("CarryPeople:playerDropped")
AddEventHandler("CarryPeople:playerDropped", function()
    local playerPed = PlayerPedId()
    carry.InProgress = false

    if isDead then
        SetEntityHealth(playerPed, 0)
    else
        SetPedConfigFlag(playerPed, 71, false)
    end

    FreezeEntityPosition(playerPed, false)
    DetachEntity(playerPed, true, false)
    ClearPedTasksImmediately(playerPed)
end)

Citizen.CreateThread(function()
    while true do
        if carry.InProgress then
            if carry.type == "beingcarried" then
                --if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 3) then
                --    TaskPlayAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 8.0, -8.0, 100000, carry.personCarried.flag, 0, false, false, false)
                --end
                if not IsEntityPlayingAnim(PlayerPedId(), 'missarmenian2', 'corpse_search_exit_ped', 3) then
                    TaskPlayAnim(PlayerPedId(), 'missarmenian2', 'corpse_search_exit_ped', 8.0, -8, -1, 1, 0.0, false, false, false)
                end
            elseif carry.type == "carrying" then
                --if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 3) then
                --    TaskPlayAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 8.0, -8.0, 100000, carry.personCarrying.flag, 0, false, false, false)
                --end
            end
        end
        Wait(750)
    end
end)



function DisplayDeadPlayerMenu()
    local elements = {}
    for i=1, #deadPlayerData, 1 do
        if deadPlayerData[i].alreadyDrag then
            table.insert(elements, {label = deadPlayerData[i].name .."(อุ้มแล้ว)", value = deadPlayerData[i].id})
            goto endState
        end
        table.insert(elements, {label = deadPlayerData[i].name, value = deadPlayerData[i].id})
        ::endState::
    end

    ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'dead_player_list',
            {
                title    = 'Dead Players',
                align    = 'top-right',
                elements = elements
            },
            function(data, menu)
                local selectedPlayer = data.current.value
                if selectedPlayer == data.current.value then
                    carryPlayer(data.current.value)
                    menu.close()
                    GetDeadPlayersInArea()
                end
            end,
            function(data, menu)
                menu.close()
            end
    )
end

function ReviveAfterDead()
    local formattedCoords = GetEntityCoords(PlayerPedId())
    --TriggerServerEvent('esx:updateLastPosition', formattedCoords)
    RespawnAfter(PlayerPedId(), formattedCoords, 377.1)
    SetEntityHealth(PlayerPedId(), 120)
    SetEntityInvincible(PlayerPedId(), true)

    RequestAnimDict('missarmenian2')
    while not HasAnimDictLoaded('missarmenian2') do
        Citizen.Wait(0)
    end
end

function RespawnAfter(ped, coords, heading)
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z+0.2, false, false, false, true)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z+0.2, heading, true, false)
    SetPlayerInvincible(ped, false)
    ClearPedBloodDamage(ped)
    ESX.UI.Menu.CloseAll()
end

function GetDeadPlayersInArea(cb)
    deadPlayerData = {}
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local asyncTasks = {}
    local players = ESX.Game.GetPlayersInArea(playerCoords, 5)
    table.insert(asyncTasks, function(cb)
        for i=1, #players, 1 do
            local dragStatus = false
            local deadStatus = false
            local playerId = players[i]
            local serverId = GetPlayerServerId(playerId)
            local entityCoord = GetEntityCoords(playerId)
            local distance = GetDistanceBetweenCoords(playerCoords, entityCoord, true)
            --print("player id ",playerId)
            --print("server id", serverId)
            GetDeathStatus(serverId, function(dead,drag)
                if dead then
                    deadStatus = dead
                end

                if drag then
                    dragStatus = drag
                end

                local playerData = {
                    id = playerId,
                    name = GetPlayerName(playerId),
                    isDead = deadStatus,
                    alreadyDrag = dragStatus
                }
                if playerData.isDead then
                    table.insert(deadPlayerData, playerData)
                end

                --table.insert(checklist, { serverId, distance, deadStatus, data, players[i] })
                --cb(DisplayDeadPlayerMenu())
            end)
        end
        --cb(DisplayDeadPlayerMenu())
        cb(DisplayDeadPlayerMenu())
    end)

    Async.parallel(asyncTasks, function(results)

        --table.sort(deadPlayerData, function(a, b)
        --    return a[2] < b[2]
        --end)
        --
        --table.sort(deadPlayerData, function(a, b)
        --    return a[3] > b[3]
        --end)
        --print("in pararell")
       --cb()
    end)
end

function GetDeathStatus(target, cb)
    local targetped = GetPlayerFromServerId(target)
    local deathstatus = Entity(GetPlayerPed(targetped)).state.isDead
    local dragSource = Entity(GetPlayerPed(targetped)).state.dragesource
    local deadStatus = false
    local dragStatus = false
    if deathstatus ~= nil and dragSource ~= nil then
        cb(deathstatus,dragSource)
    else
        local asyncTasks = {}
        table.insert(asyncTasks, function(cb)
            ESX.TriggerServerCallback('cc_ambulancecarry:checkPlayerAlreadyDead', function(data)
                if data == nil then
                    deadStatus = false
                else
                    deadStatus = data
                end
            end, target)

            ESX.TriggerServerCallback('cc_ambulancecarry:checkAlreadyDragPlayer', function(status)
                print("drag status return",status)
                if status == nil then
                    dragStatus = false
                else
                    dragStatus = status
                end
            end, target)
            cb(deadStatus,dragStatus)
        end)

        Async.parallel(asyncTasks, function(results)
            --cb(results[1])
        end)
    end
end

function clearDragPlayer()
    for i=0, #carry.targets do
            local targetServerID = GetPlayerServerId(carry.targets[i])
            TriggerServerEvent("CarryPeople:stop",targetServerID)
            carry.targets[i] = nil -- Remove the player from the targets array
    end
end

AddEventHandler('esx:onPlayerDeath', function()

    ESX.UI.Menu.CloseAll()
    isDead    = true
    if #carry.targets ~= 0 then
        clearDragPlayer()
    end
    --clearDragPlayer()
    --ClearPedTasksImmediately(PlayerPedId())
end)

AddEventHandler('esx:onPlayerSpawn', function()
    local playerPed = PlayerPedId()

    SetPedConfigFlag(playerPed, 71, false)

    --isPlayer2 = false
    isDead = false

    TriggerEvent('CarryPeople:cl_stop')
    TriggerServerEvent('cc_ambulancecarry:setdeathstatus', false)
end)


