ESX             = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local alreadyInit = false
local npcs = {}
local firstSendData = {}
local alreadyNetworkID = {}
local models = {
    "s_f_y_stripper_02", "csb_stripper_01","csb_bogdan","mp_m_bogdangoon"
}
local animRandom = {
    { dict = 'amb@world_human_drug_dealer_hard@male@base', anim = 'base'},
    { dict = 'amb@world_human_drug_dealer_hard@male@exit', anim = 'exit'},
    { dict = 'amb@world_human_drug_dealer_hard@male@enter', anim = 'enter'},
    {dict = 'trevor_2_int-0',anim = 'ig_nervousron-0'}
}



local NPC = {
    {position=vector3(4265.0400390625, -4559.02001953125, 4.21000003814697), head=247.43, id=1,group="MAGE_MONSTER"},
    {position=vector3(4269.580078125, -4561.990234375, 4.38999986648559), head=122.4, id=2,group="MAGE_MONSTER"},
    {position=vector3(4274.14990234375, -4567.10986328125, 4.19000005722045), head=128.71, id=3,group="MAGE_MONSTER"},
    {position=vector3(4280.58984375, -4572.83984375, 4.17999982833862), head=89.59, id=4,group="MAGE_MONSTER"},
    {position=vector3(4289.68994140625, -4570.18017578125, 4.17999982833862), head=137.76, id=5,group="MAGE_MONSTER"},
    {position=vector3(4295.18017578125, -4570.64013671875, 4.17999982833862), head=268.19, id=6,group="MAGE_MONSTER"},
    {position=vector3(4302.39990234375, -4568.080078125, 4.17999982833862), head=312.16, id=7,group="MAGE_MONSTER"},
    {position=vector3(4308, -4560.0498046875, 4.17999982833862), head=334.62, id=8,group="MAGE_MONSTER"},
    {position=vector3(4306.56982421875, -4553.419921875, 4.19000005722045), head=0.2, id=9,group="MAGE_MONSTER"},
    {position=vector3(4297.43994140625, -4560.8701171875, 4.17999982833862), head=300.29, id=10,group="MAGE_MONSTER"},
}




local totalNPC = 10
Citizen.CreateThread( function ()
    Citizen.Wait(5000)
    if #npcs ~= totalNPC then
        for i=1,totalNPC do
            local model = models[math.random(#models)]
            local position,head,group,id = checkPosition()
            ESX.OneSync.SpawnPed(model,position, head, function(NetId)
                local animRand = animRandom[math.random(#animRandom)]
                npcs[i] = { positionNPC = position , sessionNPC = NetworkGetEntityFromNetworkId(NetId), alreadySell = false,
                            npcNetworkId=NetId ,dict = animRand.dict,group=group, anim = animRand.anim,alreadyAnim = false ,id=id}--,blip=blip
                --TaskCombatPed(npcs[i].sessionNPC, -1, 0, 16)
                --FreezeEntityPosition(npcs[i].sessionNPC, true)
                Citizen.Wait(500)
            end)
            Citizen.Wait(500)
        end
        print("CREATED MOSTER NPC SUCCESS")
        alreadyInit = true
        TriggerClientEvent('pedenemy:collectNPC',-1,npcs)
        TriggerClientEvent('pedenemy:updateDataNPCtoUser',-1,npcs)
    end
end)

function reCreateNPC(key)
    local model = models[math.random(#models)]
    local position,head,group,id = checkPosition()
    local modelHash = GetHashKey(model)
    ESX.OneSync.SpawnPed(modelHash,position, head, function(NetId)
        local animRand = animRandom[math.random(#animRandom)]
        npcs[key] = { positionNPC = position , sessionNPC = NetworkGetEntityFromNetworkId(NetId), alreadySell = false,
                    npcNetworkId=NetId ,dict = animRand.dict,group=group, anim = animRand.anim,alreadyAnim = false ,id=id}--,blip=blip
        --FreezeEntityPosition(npcs[key].sessionNPC, true)
        Citizen.Wait(100)
        TriggerClientEvent('pedenemy:collectNPC',-1,npcs)
        TriggerClientEvent('pedenemy:updateDataNPCtoUser',-1,npcs)
    end)
end

function checkPosition()
    local NPCPosition = NPC[math.random(#NPC)]
    for _,v in pairs(npcs) do
        if v.id == NPCPosition.id then
            return checkPosition()
        end
    end
    return NPCPosition.position,NPCPosition.head,NPCPosition.group,NPCPosition.id
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if not alreadyInit then goto endState end
        for k,v in ipairs(npcs) do
            if not DoesEntityExist(v.sessionNPC) then
                npcs[k] = nil
                reCreateNPC(k)
            end
            if DoesEntityExist(v.sessionNPC) then
                local targetCoords = GetEntityCoords(v.sessionNPC)
                if #(v.positionNPC - targetCoords) >= 150 then
                    SetEntityCoords(v.sessionNPC,v.positionNPC, false, false, false, false)
                end
                if GetEntityHealth(v.sessionNPC) <= 0 then
                    givePlayerItems(k,v)
                end
            end
        end
        ::endState::
    end
end)

function givePlayerItems(key,value)
    if alreadyNetworkID[value.sessionNPC] == value.sessionNPC then return end
    alreadyNetworkID[value.sessionNPC] = value.sessionNPC
    local entityLastKillID = GetPedSourceOfDeath(value.sessionNPC)
    local sourceID = NetworkGetEntityOwner(entityLastKillID)
    local xPlayer = ESX.GetPlayerFromId(sourceID)
    if type(xPlayer) == "nil" then return end
    local rand = math.random(1, 100000) / 100000
    local selectedGroup = nil
    local selectedItems = nil
    local numItemsToReceive = nil
    local itemNameRand = nil
    local itemQuantityRand = nil
    DeleteEntity(value.sessionNPC)
    npcs[key] = nil
    reCreateNPC(key)

    for i=1,#Config.ItemsDrop[value.group],1 do
        --print(Config.ItemsDrop[value.group][i].percent)
        if ESX.Math.Round(rand,5) <=  ESX.Math.Round(Config.ItemsDrop[value.group][i].percent,5) and Config.ItemsDrop[value.group][i].specialGroup then
            --print("==========")
            --print(ESX.Math.Round(rand,5))
            selectedGroup = i
            --print("percent ", ESX.Math.Round(Config.ItemsDrop[value.group][i].percent,5))
            --print("key in group < 0.30:", i)
            --print("========== \n < 0.30 end")
            break
        end
        if  ESX.Math.Round(rand,5) > ESX.Math.Round(0.30,5) and not Config.ItemsDrop[value.group][i].specialGroup then
            --print("==========")
            --print(ESX.Math.Round(rand,5))
            selectedGroup = i
            --print("percent ", ESX.Math.Round(Config.ItemsDrop[value.group][i].percent,5))
            --print("key in group > 0.30:",selectedGroup)
            --print("========== \n > 0.30 end")
            break
        end
    end
    if selectedGroup then
        selectedItems = Config.ItemsDrop[value.group][selectedGroup].items
        --print("CheckItemsInGroup: " .. #selectedItems)
        numItemsToReceive = math.random(1, #selectedItems)
        --print("randItemIndex: " .. numItemsToReceive)
        itemNameRand = selectedItems[numItemsToReceive].ItemName
        itemQuantityRand = selectedItems[numItemsToReceive].quantity
        if itemNameRand == "money" then
            xPlayer.addMoney(itemQuantityRand)
            --print("Item Name :",itemNameRand)
            return
        end
        --print("Item Name :",itemNameRand)
        xPlayer.addInventoryItem(itemNameRand, itemQuantityRand)
    end

end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        TriggerClientEvent('pedenemy:collectNPC',-1,npcs)
        TriggerClientEvent('pedenemy:updateDataNPCtoUser',-1,npcs)
    end
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
    local source = source
    firstSendData[source] = false
    while not firstSendData[source] do
        Citizen.Wait(5000)
        if #npcs >= totalNPC then
            TriggerClientEvent('pedenemy:collectNPC',source,npcs)
            TriggerClientEvent('pedenemy:updateDataNPCtoUser',source,npcs)
            firstSendData[source] = true
            print("SEND FIRST TIME DATA TO PLAYER SUCCESS")
        end
        --print("waiting for send data dealer drug to user")
    end
    firstSendData[source] = nil
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        for _,v in ipairs(npcs) do
            if DoesEntityExist(v.sessionNPC) then
                DeleteEntity(v.sessionNPC)
                --RemoveBlip(v.blip)
            end
        end
        npcs = {}
        firstSendData = {}
    end
end)

AddEventHandler("esx:playerDropped", function(playerId)
    firstSendData[playerId] = nil
end)
