ScriptName = GetCurrentResourceName()
-- Seed = math.random(100000000)
PartyList = {}
PlayerParyId = {}

PartyListProcess = {}
PlayerParyIdProcess = {}

--AddEventHandler("what_core:ClearMemory", function()
--	Citizen.CreateThread(function()
--		local rdm = math.random(100, 2000)
--		Wait(rdm)
--		collectgarbage()
--	end)
--end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem(Config.ItemUse.Create, function(source)
    if not PlayerParyId[source] then
        local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent(ScriptName..":CreateParty", source)
    end
end)

ESX.RegisterUsableItem(Config.ItemUse.Process, function(source)
    if not PlayerParyIdProcess[source] then
        local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent(ScriptName..":CreateParty:Process", source)
    end
end)

RegisterNetEvent(ScriptName..":RemoveItem")
AddEventHandler(ScriptName..":RemoveItem", function(name)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(name, 1)
end)


RegisterNetEvent(ScriptName..":CancelParty:sv")
AddEventHandler(ScriptName..":CancelParty:sv", function (Partyid)
    for i =1, #PartyList[Partyid].Players do 
        local Player = PartyList[Partyid].Players[i]
        if PlayerParyId[Player] == Partyid then 
            TriggerClientEvent(ScriptName..":CancelParty", Player)
            PlayerParyId[Player] = nil
        end
    end
    TriggerClientEvent(ScriptName..":CancelParty", PartyList[Partyid].Owner)
    PlayerParyId[PartyList[Partyid].Owner] = nil
    PartyList[Partyid] =  nil
    collectgarbage()
end)

RegisterNetEvent(ScriptName..":CancelParty:Process:sv")
AddEventHandler(ScriptName..":CancelParty:Process:sv", function (Partyid)
    for i =1, #PartyListProcess[Partyid].Players do 
        local Player = PartyListProcess[Partyid].Players[i]
        if  PlayerParyIdProcess[Player] == Partyid then 
            TriggerClientEvent(ScriptName..":CancelParty:Process", Player)
            PlayerParyIdProcess[Player] = nil
        end
    end
    TriggerClientEvent(ScriptName..":CancelParty:Process", PartyListProcess[Partyid].Owner)
    PlayerParyIdProcess[PartyListProcess[Partyid].Owner] = nil
    PartyListProcess[Partyid] =  nil
    collectgarbage()
end)

RegisterNetEvent(ScriptName..":LeftParty")
AddEventHandler(ScriptName..":LeftParty", function ()
    PlayerParyId[source] = nil
    collectgarbage()
end)

RegisterNetEvent(ScriptName..":LeftParty:Process")
AddEventHandler(ScriptName..":LeftParty:Process", function ()
    local src = source
    if PlayerParyIdProcess[src] then
        local xPlayer = ESX.GetPlayerFromId(src)
        if PartyListProcess[PlayerParyIdProcess[src]].Owner == src then
            xPlayer.addInventoryItem(Config.ItemUse.Process, 1)
        end
        PlayerParyIdProcess[src] = nil
        collectgarbage()
    end
end)


RegisterNetEvent(ScriptName..":CreateParty:s")
AddEventHandler(ScriptName..":CreateParty:s", function(plyers, Pos)
    local xPlayer = ESX.GetPlayerFromId(source)
    print(xPlayer)
    print(partyid)
    local partyid = math.random(10000, 99999)
    for i = 1,#plyers do 
        local Player = plyers[i]
        if not PlayerParyId[Player] then 
            TriggerClientEvent(ScriptName..":JoinParty", Player, partyid, Pos)
            PlayerParyId[Player] = partyid
        end
    end

    TriggerClientEvent(ScriptName..":JoinParty", source, partyid, Pos)

    PlayerParyId[source] = partyid

    PartyList[partyid] = {
        Owner = source,
        Players = plyers,
        Pos = Pos,
    }

    xPlayer.removeInventoryItem(Config.ItemUse.Create, 1)
end)


RegisterNetEvent(ScriptName..":CreateParty:Process:sv")
AddEventHandler(ScriptName..":CreateParty:Process:sv", function(plyers, Pos, Heading)
    local xPlayer = ESX.GetPlayerFromId(source)
    local partyid = math.random(10000, 99999)
    
    for i = 1,#plyers do 
        local Player = plyers[i]
        if not PlayerParyIdProcess[Player] then 
            TriggerClientEvent(ScriptName..":JoinParty:Process", Player, partyid, Pos, source, Heading)
            PlayerParyIdProcess[Player] = partyid 
        end
    end

    TriggerClientEvent(ScriptName..":JoinParty:Process", source, partyid, Pos, source, Heading)

    PlayerParyIdProcess[source] = partyid

    PartyListProcess[partyid] = {
        Owner = source,
        Players = plyers,
        Pos = Pos,
    }

    xPlayer.removeInventoryItem(Config.ItemUse.Process, 1)
end)


RegisterNetEvent(ScriptName..":GetItem")
AddEventHandler(ScriptName..":GetItem", function(Partyid)
    if PlayerParyId[source] == Partyid then 
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer.canCarryItem(Config.Item[1], Config.Item[2]) then
            print("get compass")
            xPlayer.addInventoryItem(Config.Item[1], Config.Item[2])
        else
            print("cant get compass")
            --TriggerClientEvent('what_notify:message',source,{
            --    msg = "You are overweight!",
            --    type = 2,
            --    wait = 3,
            --})
        end
    end
end)


RegisterNetEvent(ScriptName..":ProcessItem")
AddEventHandler(ScriptName..":ProcessItem", function(Partyid)

    if PlayerParyIdProcess[source] == Partyid then 
        local xPlayer = ESX.GetPlayerFromId(source)
        -- math.randomseed(os.time() * Seed)
        local item = Config.PocessItem[math.random(#Config.PocessItem)]

        if xPlayer.canSwapItem(Config.Item[1], Config.Item[2], item.name, item.amount) then
            xPlayer.removeInventoryItem(Config.Item[1], Config.Item[2])
            xPlayer.addInventoryItem(item.name, item.amount)
        else
            --TriggerClientEvent('what_notify:message', source,{
            --    msg = "You are overweight!",
            --    type = 2,
            --    wait = 3,
            --})
        end
    end
end)


RegisterNetEvent(ScriptName..":pickup:process")
AddEventHandler(ScriptName..":pickup:process", function(Partyid)
    if PlayerParyIdProcess[source] == Partyid then 
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem(Config.ItemUse.Process, 1)
    end
end)


AddEventHandler('esx:playerDropped', function(playerId, reason)
    local src = playerId
    if PlayerParyIdProcess[src] then
        local xPlayer = ESX.GetPlayerFromId(src)
        if PartyListProcess[PlayerParyIdProcess[src]].Owner == src then
            xPlayer.addInventoryItem(Config.ItemUse.Process, 1)
        end
        PlayerParyIdProcess[src] = nil
        collectgarbage()
    end
end)