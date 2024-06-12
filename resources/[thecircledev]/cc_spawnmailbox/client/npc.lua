ESX = nil
local positionObj = {}
local oldPositionObj = {}
local saveEntity = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while #positionObj < 10 do
        Wait(10000)
        ESX.TriggerServerCallback('cc_spawnmailbox:requestDataSpawnMailbox', function(data)
            if #data >= 10 then
                positionObj = data
                deleteObject(true)
                print("done data first time")
            end
        end)
    end
end)

function createPropFromServer()
    Citizen.CreateThread(function()
        for k,v in ipairs(positionObj) do
            if not v.blip_done then
                local blip = AddBlipForCoord(v.position)
                positionObj[k].blip = blip
                SetBlipSprite(
                        positionObj[k].blip --[[ Blip ]],
                        187 --[[ integer ]]
                )
                SetBlipDisplay(blip, 4)
                SetBlipScale(
                        positionObj[k].blip --[[ Blip ]],
                        0.7 --[[ number ]]
                )
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString('<font face="font4thai">ส่งจดหมาย</font>')
                EndTextCommandSetBlipName(blip)
            end
        end
    end)
    oldPositionObj = positionObj
end

Citizen.CreateThread(function()
    for i = 1, 120 do
        saveEntity[i] = {}
    end
    local model = GetHashKey("postbox2")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end

    local lastCheck = GetGameTimer()
    while true do
        local currentTime = GetGameTimer()
        if currentTime - lastCheck > 1000 then  -- Check every 1 second instead of every frame
            lastCheck = currentTime
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)

            for _, v in pairs(positionObj) do
                local dist = GetDistanceBetweenCoords(pos, v.position)
                if dist <= 50.0 then
                    if not v.blip_done and #saveEntity[v.id] == 0 then
                        local entity = CreateObjectNoOffset(model, v.position, 0.0, false, false, false)
                        table.insert(saveEntity[v.id], entity)
                        SetEntityHeading(entity, v.head)
                        SetEntityCoordsNoOffset(entity, v.position, false, false, false)
                        PlaceObjectOnGroundProperly(entity)
                        SetModelAsNoLongerNeeded(entity)
                        SetEntityAsMissionEntity(entity)
                        FreezeEntityPosition(entity, true)
                    end
                else
                    for _, ent in pairs(saveEntity[v.id]) do
                        if DoesEntityExist(ent) then
                            DeleteEntity(ent)
                        end
                    end
                    saveEntity[v.id] = {}
                end
            end
        end
        Citizen.Wait(0)
    end
end)


function deleteObject(createBlip)
    Citizen.CreateThread(function()
        for _,v in pairs(oldPositionObj) do
            if createBlip then
                RemoveBlip(v.blip)
            end
            for _,ent in pairs(saveEntity[v.id]) do
                if DoesEntityExist(ent) then
                    DeleteEntity(ent)
                    saveEntity[v.id] = {}
                end
            end
            Wait(300)
        end
        print(createBlip)
        if createBlip then
            createPropFromServer()
        end
    end)
end

function updateBlip()
    Citizen.CreateThread(function()
        for _,v in pairs(oldPositionObj) do
            for _, bl in pairs(positionObj) do
                if #(v.position - bl.position) <= 10 then
                    if bl.blip_done then
                        RemoveBlip(v.blip)
                        Wait(500)
                    end
                end
                for _,ent in pairs(saveEntity[bl.id]) do
                    if DoesEntityExist(ent) then
                        DeleteEntity(ent)
                        saveEntity[v.id] = {}
                    end
                end
                Wait(100)
            end
            Wait(100)
        end
    end)
end

RegisterNetEvent("cc_spawnmailbox:collectData")
AddEventHandler("cc_spawnmailbox:collectData", function()
    print("send data when spawn")
    ESX.TriggerServerCallback('cc_spawnmailbox:requestDataSpawnMailbox', function(data)
        positionObj = data
        Wait(100)
        deleteObject(true)
    end)
end)

RegisterNetEvent("cc_spawnmailbox:updateBlip")
AddEventHandler("cc_spawnmailbox:updateBlip", function()
    ESX.TriggerServerCallback('cc_spawnmailbox:requestDataSpawnMailbox', function(data)
        positionObj = data
        Wait(100)
        updateBlip()
    end)
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        for _,v in pairs(positionObj) do
            RemoveBlip(v.blip)
            for _,ent in pairs(saveEntity[v.id]) do
                if DoesEntityExist(ent) then
                    DeleteEntity(ent)
                end
            end
        end
        positionObj = {}
    end
end)
