ESX             = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local sellDrugID = {}
local npcs = {}
local NPC = {
    {position=vector3(299.2699890136719, -776.489990234375, 29.30999946594238), head=247.43 ,id=1},
    {position=vector3(-61.77999877929687, -93.86000061035156, 57.77000045776367), head=122.4,id=2},
    {position=vector3(-1048.9100341796875, -1619.72998046875, 4.38999986648559), head=128.71,id=3},
    {position=vector3(-262.0400085449219, -1357.0400390625, 31.30999946594238), head=89.59,id=4},
    {position=vector3(263.8900146484375, -2085.06005859375, 16.89999961853027), head=137.76,id=5},
    {position=vector3(905.0499877929688, -2312.409912109375, 30.55999946594238), head=268.19,id=6},
    {position=vector3(947.2100219726564, -1778.260009765625, 31.21999931335449), head=312.16,id=7},
    {position=vector3(9.14999961853027, -776.0399780273438, 31.71999931335449), head=334.62,id=8},
    {position=vector3(441.8599853515625, -684.0499877929688, 28.73999977111816), head=0.2,id=9},
    {position=vector3(-648.510009765625, -164.2400054931641, 37.72999954223633), head=300.29,id=10},
    {position=vector3(650.75, -1718.3800048828125, 29.29999923706054), head=175.24,id=11},
    {position=vector3(-1742.8499755859375, -401.8200073242188, 44.29999923706055), head=251.18,id=12},
    {position=vector3(-1408.02001953125, -938.47998046875, 10.93000030517578), head=301.43,id=13},
    {position=vector3(-1279.1700439453125, -1210.3699951171875, 4.73000001907348), head=109.17,id=14},
    {position=vector3(-1224.3599853515625, -1356.800048828125, 4.01999998092651), head=160.66,id=15},
    {position=vector3(-1303.75, -919.4000244140624, 11.27000045776367), head=287.49,id=16},
    {position=vector3(-1538.1400146484375, -655.2000122070312, 28.79999923706054), head=183.91,id=17},
    {position=vector3(-1281.300048828125, -563.3800048828125, 31.70999908447265), head=310.94,id=18},
    {position=vector3(-1339.97998046875, -424.1400146484375, 35), head=124.31,id=19},
    {position=vector3(-1129.739990234375, -277.5, 37.77999877929687), head=128.89,id=20},
    {position=vector3(-1047.93994140625, -384.05999755859375, 37.77999877929687), head=27.81,id=21},
    {position=vector3(-1399.31005859375, -36.70999908447265, 52.59000015258789), head=138.27,id=22},
    {position=vector3(-996.0999755859376, 42.43999862670898, 51.4000015258789), head=299.29,id=23},
    {position=vector3(-528.77001953125, 269.8599853515625, 82.95999908447266), head=144.26,id=24},
    {position=vector3(-210.67999267578128, 245.77999877929688, 91.9800033569336), head=15.02,id=25},
    {position=vector3(41.52000045776367, 307.510009765625, 110.9499969482422), head=245.7,id=26},
    {position=vector3(596.5599975585938, 225.08999633789065, 102.66999816894533), head=349.78,id=27},
    {position=vector3(-3.54999995231628, 8.7200002670288, 70.95999908447266), head=331.17,id=28},
    {position=vector3(1.57000005245208, -301.57000732421875, 46.2400016784668), head=272.48,id=29},

    {position=vector3(107.6500015258789, -511.0400085449219, 43.15999984741211), head=250.58,id=30},
    {position=vector3(491.010009765625, -1190.3699951171875, 29.29000091552734), head=267.83,id=31},
    {position=vector3(811.6400146484375, -1289.6300048828125, 26.29000091552734), head=88.57,id=32},
    {position=vector3(915.97998046875, -1450.3199462890625, 31.15999984741211), head=358.68,id=33},
    {position=vector3(1374.3800048828125, -1526.510009765625, 56.68999862670898), head=193.33,id=34},
    {position=vector3(810.5900268554688, -1963.81005859375, 29.25), head=80.34,id=35},
    {position=vector3(1044.3499755859375, -2425.47998046875, 28.95999908447265), head=82.24,id=36},
    {position=vector3(432.2200012207031, -1811.22998046875, 28.14999961853027), head=319.82,id=37},
    {position=vector3(619.8099975585938, -2068.679931640625, 29.30999946594238), head=353.01,id=38},
    {position=vector3(525.280029296875, -2521.280029296875, 5.78000020980835), head=147.59,id=39},
    {position=vector3(177.55999755859375, -2584.530029296875, 6.55000019073486), head=357.32,id=40},
    {position=vector3(115.69000244140624, -1949.050048828125, 20.67000007629394), head=53.4,id=41},
    {position=vector3(-27.17000007629394, -1381.4300537109375, 29.29999923706054), head=348.54,id=42},
    {position=vector3(-619.89, -645.35,31.64), head=141.22,id=43},
    {position=vector3(525.5999755859375, -2520.820068359375, 5.76999998092651), head=144.15,id=44}
}


local totalNPC = Config.NPCCount

Citizen.CreateThread( function ()
    Citizen.Wait(1000)
    if #npcs ~= totalNPC then
        for i=1,totalNPC do
            local position,head,id = checkPosition()
            Citizen.Wait(500)
            npcs[i] =  { positionNPC = position , alreadySell = false, id=id , heading = head,deleteState = false ,blip = nil} --,blip=blip
        end
        print("CREATED DRUG NPC SUCCESS")
        print("CREATED DRUG NPC SUCCESS")
        print("CREATED DRUG NPC SUCCESS")
        print("CREATED DRUG NPC SUCCESS")
        print("CREATED DRUG NPC SUCCESS")
    end
end)


ESX.RegisterServerCallback('cc_selldrug:requestDataSellDrug', function(source, cb)
    cb(npcs)
end)

function checkPosition()
    local NPCPosition = NPC[math.random(#NPC)]
    for _,v in pairs(npcs) do
        if v.id == NPCPosition.id then
            return checkPosition()
        end
    end
    return NPCPosition.position,NPCPosition.head,NPCPosition.id
end

ESX.RegisterServerCallback('cc_selldrug:canSellDrug', function(source, cb, npcKey)
    Wait(100)
    if sellDrugID[npcKey] then
        cb(false)
        return
    end
    if sellDrugID[npcKey] == nil then
        sellDrugID[npcKey] = true
    end
    if not sellDrugID[npcKey] then
        sellDrugID[npcKey] = true
    end
    npcs[npcKey].alreadySell = true
    Wait(300)
    TriggerClientEvent('cc_selldrug:updateDataNPCtoUser',-1)
    cb(true)
end)

RegisterServerEvent('cc_selldrug:playerFailMiniGame')
AddEventHandler('cc_selldrug:playerFailMiniGame', function(npcKey)
    sellDrugID[npcKey] = false
    npcs[npcKey].alreadySell = false
    Wait(200)
    TriggerClientEvent('cc_selldrug:updateDataNPCtoUser',-1)
end)

-- Improved deleteDrugSeller function
RegisterServerEvent('cc_selldrug:deleteDrugSeller')
AddEventHandler('cc_selldrug:deleteDrugSeller', function(npcKey)
    if not npcKey then return end -- Exit if npc doesn't exist
    npcs[npcKey].alreadySell = true
    npcs[npcKey].deleteState = true
    sellDrugID[npcKey] = nil

    -- Use a single delay instead of multiple
    Citizen.Wait(500)

    TriggerClientEvent('cc_selldrug:updateDataNPCtoUser', -1)
    TriggerClientEvent('cc_selldrug:updateBlip', -1)
    createNewDrugSeller(npcKey)
end)

 function createNewDrugSeller(npcKey)
    Citizen.CreateThread(function()
        print("start create NPC")
        local randTimeSpawn = math.random(300000, 350000)
        local targetTime = GetGameTimer() + randTimeSpawn

        print("waiting", randTimeSpawn, "ms to spawn npc")

        while GetGameTimer() < targetTime do
            -- Use a long delay to avoid consuming resources unnecessarily
            Citizen.Wait(1000) -- Check every second
        end

        print("create new npc")

        local position, head, id = checkPosition()
        Citizen.Wait(500)
        npcs[npcKey] = {
            positionNPC = position,
            alreadySell = false,
            id = id,
            heading = head,
            deleteState = false,
            blip = nil
        }
        print("CREATED DRUG NEW NPC SUCCESS")
        print("CREATED DRUG NEW NPC SUCCESS")
        -- Trigger update after a small delay
        Citizen.Wait(500)
        TriggerClientEvent('cc_selldrug:updateDataNPCtoUser', -1)
        TriggerClientEvent('cc_selldrug:updateBlip', -1)
    end)
end



AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        npcs = {}
    end
end)

