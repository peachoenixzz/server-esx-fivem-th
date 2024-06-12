Citizen.CreateThread(function()
    if(GetResourceState("ox_target") ~= "missing") then
        exports['ox_target']:addModel(TxhModels, {
            {
                name = 'useTexas',
                icon = 'fa-solid fa-coins',
                label = _L("use_table"),
                onSelect = function(resp)
                    TriggerEvent("sf-txh:onUse", resp.entity)
                end,
                canInteract = function(entity)
                    return GetTxhId({ coords = GetEntityCoords(entity), model = GetEntityModel(entity) }) ~= nil
                end
            },
        })
    elseif(GetResourceState("qtarget") ~= "missing") then
        exports['qtarget']:AddTargetModel(TxhModels, {
            options = {
                {
                    name = 'useTexas',
                    icon = 'fa-solid fa-coins',
                    label = _L("use_table"),
                    action = function(resp)
                        TriggerEvent("sf-txh:onUse", type(resp) == "number" and resp or resp.entity)
                    end,
                    canInteract = function(entity)
                        return GetTxhId({ coords = GetEntityCoords(entity), model = GetEntityModel(entity) }) ~= nil
                    end
                }
            },
            distance = 2.0
        })
    elseif(GetResourceState("qb-target") ~= "missing") then
        exports['qb-target']:AddTargetModel(TxhModels, {
            options = {
                {
                    name = 'useTexas',
                    icon = 'fa-solid fa-coins',
                    label = _L("use_table"),
                    action = function(resp)
                        TriggerEvent("sf-txh:onUse", type(resp) == "number" and resp or resp.entity)
                    end,
                    canInteract = function(entity)
                        return GetTxhId({ coords = GetEntityCoords(entity), model = GetEntityModel(entity) }) ~= nil
                    end
                }
            },
            distance = 2.0
        })
    else
        RegisterKeys()
        EnsureTcpDetectionThread()
    end
end)

local detectedTables = {}
local closestIndex = -1
local closestDist = 99999
local input = string.gsub(string.format("~INPUT_%s~", string.upper(string.format("%x", joaat("+usetxh")))), "FFFFFFFF", "")

function EnsureTcpDetectionThread()
    Citizen.Wait(500)
    local lastRefresh = 0
    local waitTime = 1000
    local playerCoords = GetEntityCoords(PlayerPedId())
    local dist = 99999
    while true do
        waitTime = 1000
        closestIndex = -1
        closestDist = 99999
        playerCoords = GetEntityCoords(PlayerPedId())
        if(CurrentTable.coords) then
            goto continue
        end
        if(GetGameTimer() - lastRefresh > 10000) then
            RefreshObjectPool()
            lastRefresh = GetGameTimer()
        end
        for k, v in ipairs(detectedTables) do
            dist = #(playerCoords - v.coords)
            if(dist < closestDist) then
                closestDist = dist
                closestIndex = k
            end
        end
        if(closestDist < 3.0) then
            waitTime = 75
            ShowHelpNotification(_L("use_txh_help", input), false, false, 500)
        elseif(closestDist < 6.0) then
            waitTime = 75
        elseif(closestDist < 30.0) then
            waitTime = math.floor(closestDist * 15)
        end
        ::continue::
        Citizen.Wait(waitTime)
    end
end

function RefreshObjectPool()
    detectedTables = {}
    local models = {}
    for k, v in pairs(TxhModels) do
        models[v] = true
    end
    local objects = GetGamePool("CObject")
    for k, v in ipairs(objects) do
        if(models[GetEntityModel(v)]) then
            table.insert(detectedTables, { coords = GetEntityCoords(v), entity = v })
        end
        if(k % 50 == 0) then
            Citizen.Wait(0)
        end
    end
end

function RegisterKeys()
    RegisterKeyMapping('+usetxh', "Use poker", 'keyboard', "E")
    RegisterCommand('+usetxh', function()

    end, false)
    RegisterCommand('-usetxh', function()
        if(closestIndex ~= -1 and closestDist < 3.0 and detectedTables[closestIndex]) then
            TriggerEvent("sf-txh:onUse", detectedTables[closestIndex].entity)
        end
    end, false)
end