
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local carrying = {}
--carrying[source] = targetSource, source is carrying targetSource
local carried = {}
--carried[targetSource] = source, targetSource is being carried by source
local DragSource = {}
local DeathStatus = {}

RegisterServerEvent("CarryPeople:sync")
AddEventHandler("CarryPeople:sync", function(targetSrc)
    local source = source
    local sourcePed = GetPlayerPed(source)
    local sourceCoords = GetEntityCoords(sourcePed)
    local targetPed = GetPlayerPed(targetSrc)
    local targetCoords = GetEntityCoords(targetPed)
    if #(sourceCoords - targetCoords) <= 9 then
        Entity(targetPed).state.dragesource = true
        print("success drag")
        DragSource[targetSrc] = true
        TriggerClientEvent("CarryPeople:syncTarget", targetSrc, source)
        table.insert(carrying,targetSrc)
        table.insert(carried,source)
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'AmbulanceCarryPeople',
                content = ('%s อาชีพ %s ยศ %s ได้ทำการอุ้ม %s ที่หมดสติอยู่'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, xTarget.name),
                source = xPlayer.source,
            })
        end) -- End Log
    end
end)


RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function()
    local playerPed = GetPlayerPed(source)
    Entity(playerPed).state.isDead = true
    Entity(playerPed).state.dragesource = false
    DeathStatus[source] = true
    DragSource[source] = false
end)

--ESX.RegisterServerCallback('cc_ambulancecarry:checkAlreadyDragPlayer', function (source, cb, target)
--    print(target)
--    for i=0, #carrying do
--        if carrying[i] == target then
--            cb(true)
--        end
--    end
--end)

ESX.RegisterServerCallback('cc_ambulancecarry:checkAlreadyDragPlayer', function (source, cb, target)
    local ped = GetPlayerPed(target)
    Entity(ped).state.dragesource = DragSource[target]
    print("[CALLBACK GETDRAGSOURCE] Playerid: ".. target .. " DragSource: ".. json.encode(DragSource[target]))
    cb(DragSource[target])
end)

ESX.RegisterServerCallback('cc_ambulancecarry:checkPlayerAlreadyDead', function (source, cb, target)
    local ped = GetPlayerPed(target)
    Entity(ped).state.isDead = DeathStatus[target]
    print("[CALLBACK GETDEATH] Playerid: ".. target .. " DeathStatus: ".. json.encode(DeathStatus[target]))
    print(DeathStatus[target])
    cb(DeathStatus[target])
end)

RegisterServerEvent('cc_ambulancecarry:setdeathstatus')
AddEventHandler('cc_ambulancecarry:setdeathstatus', function(status)
    local playerPed = GetPlayerPed(source)
    Entity(playerPed).state.isDead = status
    DeathStatus[source] = status
end)


RegisterServerEvent("CarryPeople:stop")
AddEventHandler("CarryPeople:stop", function(targetSrc)
    local source = source
    local targetPed = GetPlayerPed(targetSrc)
    DragSource[targetSrc] = false
    Entity(targetPed).state.dragesource = false
    for i=0, #carrying do
        if carrying[i] == targetSrc then
            print("carrying by carrying",carrying[i])
            print("carried by carrying",carried[i])
            --carry.InProgress = false
            local playerped = GetPlayerPed(targetSrc)
            local playerCoords = GetEntityCoords(playerped)
            SetEntityCoords(playerped, playerCoords, false, false, false)
            TriggerClientEvent("CarryPeople:cl_stop", targetSrc)
            carrying[i] = nil -- Remove the player from the targets array
            pcall(function() -- Start Log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AmbulanceGotReleaseFromCarry',
                    content = ('%s ได้ถูก %s อาชีพ %s ยศ %s วางลงจากการอุ้มแล้ว'):format(xTarget.name, xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name),
                    source = xTarget.source,
                })
            end) -- End Log
        end
    end

    for i=0, #carried do
        if carried[i] == source then
            --carry.InProgress = false
            print("carrying by carried",carrying[i])
            print("carried by carried",carried[i])
            local playerped = GetPlayerPed(targetSrc)
            local playerCoords = GetEntityCoords(playerped)
            SetEntityCoords(playerped, playerCoords, false, false, false)
            carried[i] = nil -- Remove the player from the targets array
            pcall(function() -- Start Log
                exports['azael_dc-serverlogs']:insertData({
                    event = 'AmbulanceStopCarryingPeople',
                    content = ('%s อาชีพ %s ยศ %s ได้วาง %s ลงจากการอุ้มแล้ว'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, xTarget.name),
                    source = xPlayer.source,
                })
            end) -- End Log
        end
    end
end)


AddEventHandler('playerDropped', function(reason)
    local source = source

    for i=0, #carrying do
        if carried[i] == source then
            print("carrying",carrying[i])
            print("carried",carried[i])
            --carry.InProgress = false
            TriggerClientEvent("CarryPeople:cl_stop", carrying[i])
            carrying[i] = nil -- Remove the player from the targets array
        end
    end
end)


