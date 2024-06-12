
npcs = {}
local allPed = {}
local spawnPed = {}
oldNpcs = {}
--local blipEntity = {}
local animRandom = {
    { dict = 'amb@world_human_drug_dealer_hard@male@base', anim = 'base'},
    { dict = 'amb@world_human_drug_dealer_hard@male@exit', anim = 'exit'},
    { dict = 'amb@world_human_drug_dealer_hard@male@enter', anim = 'enter'},
    {dict = 'trevor_2_int-0',anim = 'ig_nervousron-0'}
}

local models = {
    "a_f_m_skidrow_01", "a_f_y_juggalo_01","a_m_y_breakdance_01","a_m_y_gay_02"
}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while #npcs < Config.NPCCount do
        Wait(5000)
        ESX.TriggerServerCallback('cc_selldrug:requestDataSellDrug', function(data)
            if #data >= Config.NPCCount then
                npcs = data
                Wait(200)
                handleBlip()
            end
        end)
    end
end)

function handleBlip()
    for _,v in pairs(oldNpcs) do
        RemoveBlip(v.blip)
    end
    createBlipToMap()
end

function createBlipToMap()
        for k,v in ipairs(npcs) do
            if not v.deleteState then
                local blip = AddBlipForCoord(v.positionNPC)
                npcs[k].blip = blip
                SetBlipSprite(
                        npcs[k].blip --[[ Blip ]],
                        51 --[[ integer ]]
                )
                SetBlipDisplay(blip, 6)
                SetBlipScale(
                        npcs[k].blip --[[ Blip ]],
                        0.4 --[[ number ]]
                )
                SetBlipColour(blip, 2)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('<font face="font4thai">ขายยา</font>')
                EndTextCommandSetBlipName(blip)
            end
        end
        oldNpcs = npcs
end

Citizen.CreateThread(function()
    for i = 1, 50 do
        allPed[i] = {}
    end
    local sleep = 1000
    local lastCoords = vector3(0, 0, 0)

    while true do
        Wait(sleep)
        local coords = GetPlayerCoordsAsync()
        if #(coords - lastCoords) > 5 then  -- Check if player moved significantly
            lastCoords = coords
            for _, v in pairs(npcs) do
                --local blip = AddBlipForCoord(
                --        v.positionNPC
                --)
                --SetBlipSprite (blip, 135)
                --SetBlipDisplay(blip, 4)
                --SetBlipScale  (blip, 0.7)
                --SetBlipColour (blip, 49)
                --SetBlipAsShortRange(blip, true)
                local dist = GetDistanceBetweenCoords(coords, v.positionNPC, true)

                if dist < 75 then
                    print(#allPed[v.id])
                    if #allPed[v.id] == 0 and not v.alreadySell and not v.deleteState then
                        local ped = CreatePed(0, models[math.random(1, #models)], v.positionNPC, v.heading, false, true)
                        SetupNPC(ped, v.positionNPC, animRandom)
                        table.insert(allPed[v.id], ped)
                    elseif v.deleteState and v.alreadySell then
                        DeleteNPCs(v.id)
                    end
                    sleep = 0
                elseif dist > 75 then
                    DeleteNPCs(v.id)
                    sleep = 1000
                end
            end
        end
    end
end)

function SetupNPC(ped, position, animations)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityCoordsNoOffset(ped, position, false, false, false)
    local anim = animations[math.random(1, #animations)]
    AnimNPC(anim.dict, anim.anim, {["flag"] = 49}, ped)
end

function DeleteNPCs(id)
    for _, npc in pairs(allPed[id]) do
        if DoesEntityExist(npc) then
            DeleteEntity(npc)
        end
    end
    allPed[id] = {}
end

Citizen.CreateThread(function()
    for _, model in pairs(models) do
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end
    end
end)

function deleteNPC()
    local key = npcKey
    TriggerServerEvent('cc_selldrug:deleteDrugSeller',key)
end

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        for i = 1 , 50 do
            for _,v in pairs(allPed[i]) do
                if DoesEntityExist(v) then
                    DeleteEntity(v)
                end
            end
        end
    end
end)
