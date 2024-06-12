RegisterServerEvent('cc_weight:set')
AddEventHandler('cc_weight:set', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    activateWeight(xPlayer)
end)

function activateWeight(xPlayer)
    local defaultMaxWeight = ESX.GetConfig().MaxWeight

    local maxWeight = 0
    local alreadyStack = false

    for _, item in ipairs(Config.Items) do
        if not item.can_stack then
            if item.required_item and #item.required_item > 0 then
                local has_required_item = false
                for _, req_item in ipairs(item.required_item) do
                    --print(req_item)
                    local xItem = xPlayer.getInventoryItem(req_item)
                    if xItem and xItem.count > 0 then
                        has_required_item = true
                        break
                    end
                end
                local xItem = xPlayer.getInventoryItem(item.name)
                if has_required_item and item.weight > maxWeight and xItem.count >= 1 then
                    maxWeight = item.weight
                end
            end
        end
    end

    for _,item in pairs(Config.Items) do
        if not alreadyStack then
            defaultMaxWeight = defaultMaxWeight + maxWeight
            alreadyStack = true
        end

        local xItem = xPlayer.getInventoryItem(item.name)
        if xItem then
            if item.can_stack and xItem.count >= 1 and item.weight then
                defaultMaxWeight = defaultMaxWeight+item.weight
            end
        end
    end

    local stmtStr = [[
        SELECT tlw.weight  FROM TB_PLAYER_WEIGHT tpw
        INNER JOIN TB_LEVEL_WEIGHT tlw
        ON tpw.weight_level=tlw.weight_level
        WHERE tpw.discord_id = ?
    ]]
    local response = MySQL.query.await(stmtStr, {
        xPlayer.identifier,
    })
    if response then
        for i=1, #response, 1 do
            defaultMaxWeight = defaultMaxWeight+response[i].weight
        end
    end
    xPlayer.setMaxWeight(defaultMaxWeight)
end

function playerCalculateWeight(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    local defaultMaxWeight = ESX.GetConfig().MaxWeight
    for _,v in pairs(Config.Items) do
        --print(v.name,v.weight)
        local xItem = xPlayer.getInventoryItem(v.name)
        --print(xItem.count)
        if xItem.count >= 1 then
            local backpackModifier = v.weight
            if backpackModifier then
                --print(defaultMaxWeight + backpackModifier)
                return defaultMaxWeight + backpackModifier
            else
                --print(defaultMaxWeight)
                return defaultMaxWeight
            end
        end
    end
    return defaultMaxWeight
end



RegisterCommand('reloadbag', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    activateWeight(xPlayer)
end)