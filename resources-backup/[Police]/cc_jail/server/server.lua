
local firstSpawnPlayer = {}
local playerInJail = {}
local newInit = {}


ESX.RegisterServerCallback('cc_jail:checkTeleportPlayer', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local disruptorTime = exports.cc_coreeffect:coreEffectCheckTimeRealTime(xPlayer,'anonymous_gps')
    if disruptorTime > 0  then
        cb(false)
        return
    end
    cb(true)
end)

ESX.RegisterServerCallback('cc_jail:checkDisruptor', function(source, cb, targetSrc)
    local xPlayer = ESX.GetPlayerFromId(targetSrc)
    local xPlayerIdentifier = xPlayer.identifier
    local disruptorTime = exports.cc_coreeffect:coreEffectCheckTimeRealTime(xPlayer,'anonymous_gps')
    if disruptorTime > 0  then
        cb(true, xPlayerIdentifier)
        return
    end
    cb(false)
end)

RegisterServerEvent("cc_jail:initPlayerToJail")
AddEventHandler("cc_jail:initPlayerToJail", function(targetSrc, jailReason, jailName, position)
    position = position or nil
    local xPlayer = ESX.GetPlayerFromId(targetSrc)

    GetRPName(targetSrc, function(Firstname, Lastname)
        local fal = "ชื่อ : "
        local msg = "ติดคุกในคดี : "
        TriggerClientEvent('chat:addMessage', -1,{
            template = '<div style="padding: 7px; margin-bottom: 8px; background-image: linear-gradient(to right, rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.5)); border-radius: 7px; width: 605px; display: flex; align-items: center; font-size: 18px;"/><img src="https://img2.pic.in.th/pic/law21f999d810eca28a.png" style="width: 20px; height: 20px; padding-right: 7px; padding-left: 7px;" />'..Firstname..' '..Lastname..' {1} '..jailReason..'<br></div>',
            args = {fal, msg}
        })
    end)
    xPlayer.triggerEvent('cc_jail:sendPlayerToJail', jailName, position)
    Citizen.Wait(2000)
    checkPlayerTimeInJail(xPlayer)
end)

function GetRPName(playerId, data)
    local Identifier = ESX.GetPlayerFromId(playerId).identifier
    MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)
        data(result[1].firstname, result[1].lastname)
    end)
end

function checkPlayerTimeInJail(xPlayer)
    Citizen.CreateThread( function()
        if exports.cc_coreeffect:coreEffectCheckTimeRealTime(xPlayer,'in_jail') > 0 then
            --print("alway check")
            newInit[xPlayer.source] = true
            playerInJail[xPlayer.source] = true
            Citizen.Wait(10000)
            return checkPlayerTimeInJail(xPlayer)
        end
        if exports.cc_coreeffect:coreEffectCheckTimeRealTime(xPlayer,'in_jail') <= 0 then
            --print("not jail")
            xPlayer.triggerEvent('cc_jail:releasePlayer','police_station')
            newInit[xPlayer.source] = nil
            playerInJail[xPlayer.source] = nil
        end
    end)
end


function changeCloth(xPlayer)
    if exports.cc_coreeffect:coreEffectCheckTime(xPlayer,'in_jail') > 0  then
        xPlayer.triggerEvent('cc_jail:returnClothPrison')
    end
end


function firstTimeLoginCheck(xPlayer)
    if exports.cc_coreeffect:coreEffectCheckTime(xPlayer,'in_jail') > 0  then
        print("in jail")
        playerInJail[xPlayer.source] = true
        xPlayer.triggerEvent('cc_jail:backPlayerToJail','main_prison')
        checkPlayerTimeInJail(xPlayer)
    end
end

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if firstSpawnPlayer[xPlayer.source] == nil then
        --print("init spawnplayer")
        firstSpawnPlayer[xPlayer.source] = true
        firstTimeLoginCheck(xPlayer)
    end
    --changeCloth(xPlayer)
end)

AddEventHandler('playerDropped', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        firstSpawnPlayer[xPlayer.source] = nil
        playerInJail[xPlayer.source] = nil
        newInit[xPlayer.source] = nil
    end
end)

AddEventHandler('esx:playerDropped', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        firstSpawnPlayer[xPlayer.source] = nil
        playerInJail[xPlayer.source] = nil
        newInit[xPlayer.source] = nil
    end
end)