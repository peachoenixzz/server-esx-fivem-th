
-- Cache to store time_current values
local cache = {}
local cacheTime = {}  -- Store the time when the cache was last updated
local playerEffects = {}
-- Time to keep cache in seconds
local cacheExpireTime = 60  -- 1 minute

ESX.RegisterServerCallback('cc_coreeffect:createDebuff', function(source, cb,closetPlayer,debuffName,time)
    local validate,image = validateDebuff(debuffName)
    if validate then
        local xPlayer = ESX.GetPlayerFromId(closetPlayer)
        --print(xPlayer.identifier)
        createDebuff(xPlayer,debuffName,time,image)
        cb()
    end
end)

ESX.RegisterServerCallback('cc_coreeffect:createDebuffPlayerByCallback', function(source, cb,debuffName)
    local validate,value = validateDebuffPlayerByItem(debuffName)
    if validate then
        local xPlayer = ESX.GetPlayerFromId(source)
        createDebuffPlayerByCallback(xPlayer,value)
        cb()
    end
end)

ESX.RegisterServerCallback('cc_coreeffect:deleteDebuffByIdentifier', function(source, cb, identifier,debuffName)
    local validate,image = validateDebuff(debuffName)
    if validate then
        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
        --print(xPlayer.identifier)
        deleteEffectByESXPlayer(xPlayer,debuffName)
        cb()
    end
end)

function deleteEffectByESXPlayer(xPlayer,debuffName)
    local stmt = [[
        DELETE FROM core_effect
            WHERE identifier = ?
            AND effect_name = ?
    ]]
    local deleteEffect = MySQL.query.await(stmt, {xPlayer.identifier,debuffName})
    if deleteEffect then
        deleteUIEffect(xPlayer,debuffName,0)
    end
end

function validateDebuffPlayerByItem(debuffName)
    for _,v in pairs(Config.debuff) do
        if v.effect_name == debuffName then return true,v end
    end
end

function validateDebuff(debuffName)
    for _,v in pairs(Config.debuff) do
        if v.effect_name == debuffName then return true,v.image end
    end
end

ESX.RegisterServerCallback('cc_coreeffect:checkitemaddcore', function(source, cb, itemName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem =   xPlayer.getInventoryItem(itemName)
    if xItem.count >= 1 then
        createEffectByEffectName(xPlayer,xItem)
        cb(true) 
        return
    end
    cb(false)
end)

function createEffectByEffectName(xPlayer, xItem)
    --print("in create effect")
    for _,v in pairs(Config.items) do
        --print(xItem.name == v.use_item)
        if xItem.name == v.use_item then
            MySQL.Async.fetchAll('SELECT effect_name FROM core_effect WHERE identifier = @identifier AND effect_name = @effect_name', {
                ['@identifier'] = xPlayer.identifier,
                ['@effect_name'] = v.effect_name
            }, function(result)
                if result[1] then
                    local updateEffect = MySQL.update.await('UPDATE core_effect SET time_current = ?, time_started = ? WHERE identifier = ? AND effect_name = ?', {
                        v.effect_time,
                        v.effect_time,
                        xPlayer.identifier,
                        v.effect_name
                    })
                    xPlayer.removeInventoryItem(xItem.name, 1)
                    startEffect(xPlayer,v.effect_name)
                end
                if not result[1] then
                    local createEffect = MySQL.insert.await('INSERT INTO `core_effect` (identifier, time_current, time_started, effect_type, effect_name, effect_in_game, calculate_type,image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
                        xPlayer.identifier,
                        v.effect_time,
                        v.effect_time,
                        v.effect_type,
                        v.effect_name,
                        v.effect_in_game,
                        v.calculate_type,
                        v.image
                    })
                    xPlayer.removeInventoryItem(xItem.name, 1)
                    startEffect(xPlayer,v.effect_name)
                end
            end)
        end
    end
end

function createEffectByEffectTypeValidateByScript(xPlayer, xItem)
    --print("in create effect")
    for _,v in pairs(Config.items) do
        --print(xItem.name == v.use_item)
        if xItem.name == v.use_item then
            MySQL.Async.fetchAll('SELECT effect_name FROM core_effect WHERE identifier = @identifier AND effect_type = @effect_type', {
                ['@identifier'] = xPlayer.identifier,
                ['@effect_type'] = v.effect_type
            }, function(result)
                if result[1] then
                    local updateEffect = MySQL.update.await('UPDATE core_effect SET time_current = ?, time_started = ? WHERE identifier = ? AND effect_type = ?', {
                        v.effect_time,
                        v.effect_time,
                        xPlayer.identifier,
                        v.effect_type
                    })
                    --xPlayer.removeInventoryItem(xItem.name, 1)
                    startEffect(xPlayer,v.effect_name)
                end
                if not result[1] then
                    local createEffect = MySQL.insert.await('INSERT INTO `core_effect` (identifier, time_current, time_started, effect_type, effect_name, effect_in_game, calculate_type,image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
                        xPlayer.identifier,
                        v.effect_time,
                        v.effect_time,
                        v.effect_type,
                        v.effect_name,
                        v.effect_in_game,
                        v.calculate_type,
                        v.image
                    })
                    --xPlayer.removeInventoryItem(xItem.name, 1)
                    startEffect(xPlayer,v.effect_name)
                end
            end)
        end
    end
end

function createEffectByEffectType(xPlayer, xItem)
    --print("in create effect")
    for _,v in pairs(Config.items) do
        --print(xItem.name == v.use_item)
        if xItem.name == v.use_item then
            MySQL.Async.fetchAll('SELECT effect_name FROM core_effect WHERE identifier = @identifier AND effect_type = @effect_type', {
                ['@identifier'] = xPlayer.identifier,
                ['@effect_type'] = v.effect_type
            }, function(result)
                if result[1] then
                    local updateEffect = MySQL.update.await('UPDATE core_effect SET time_current = ?, time_started = ? WHERE identifier = ? AND effect_type = ?', {
                        v.effect_time,
                        v.effect_time,
                        xPlayer.identifier,
                        v.effect_type
                    })
                    xPlayer.removeInventoryItem(xItem.name, 1)
                    startEffect(xPlayer,v.effect_name)
                end
                if not result[1] then
                    local createEffect = MySQL.insert.await('INSERT INTO `core_effect` (identifier, time_current, time_started, effect_type, effect_name, effect_in_game, calculate_type,image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
                        xPlayer.identifier,
                        v.effect_time,
                        v.effect_time,
                        v.effect_type,
                        v.effect_name,
                        v.effect_in_game,
                        v.calculate_type,
                        v.image
                    })
                    xPlayer.removeInventoryItem(xItem.name, 1)
                    startEffect(xPlayer,v.effect_name)
                end
            end)
        end
    end
end

function createDebuffPlayerByCallback(xPlayer,value)
    MySQL.Async.fetchAll('SELECT effect_name,time_current,effect_in_game FROM core_effect WHERE identifier = @identifier AND effect_name = @effect_name', {
        ['@identifier'] = xPlayer.identifier,
        ['@effect_name'] = value.effect_name
    }, function(result)
        if result[1] then
            if value.can_stack then
                local updateEffect = MySQL.update.await('UPDATE core_effect SET time_current = ?, time_started = ?,effect_in_game = ? WHERE identifier = ? AND effect_name = ?', {
                    value.effect_time + result[1].time_current,
                    value.effect_time,
                    result[1].effect_in_game + 1,
                    xPlayer.identifier,
                    value.effect_name
                })
                updateUIEffect(xPlayer,value.effect_name,value.effect_time,"debuff_player",value.image)
                startEffect(xPlayer,value.effect_name,result[1].effect_in_game)
            end
            if not value.can_stack then
                local updateEffect = MySQL.update.await('UPDATE core_effect SET time_current = ?, time_started = ?,effect_in_game = ? WHERE identifier = ? AND effect_name = ?', {
                    value.effect_time,
                    value.effect_time,
                    value.effect_in_game,
                    xPlayer.identifier,
                    value.effect_name
                })
                updateUIEffect(xPlayer,value.effect_name,value.effect_time,"debuff_player",value.image)
            end
        end
        if not result[1] then
            local createEffect = MySQL.insert.await('INSERT INTO `core_effect` (identifier, time_current, time_started, effect_in_game, effect_type, effect_name, image) VALUES (?, ?, ?, ?, ?, ?, ?)', {
                xPlayer.identifier,
                value.effect_time,
                value.effect_time,
                value.effect_in_game,
                value.effect_type,
                value.effect_name,
                value.image
            })
            updateUIEffect(xPlayer, value.effect_name,value.effect_time,"debuff_player",value.image)
            startEffect(xPlayer,value.effect_name,value.effect_in_game)
        end
    end)
    return
end

function createDebuff(xPlayer,debuffName,time,image,effect_show)
    effect_show = effect_show or "show"
    MySQL.Async.fetchAll('SELECT effect_name FROM core_effect WHERE identifier = @identifier AND effect_name = @effect_name', {
        ['@identifier'] = xPlayer.identifier,
        ['@effect_name'] = debuffName
    }, function(result)
        if result[1] then
            local updateEffect = MySQL.update.await('UPDATE core_effect SET time_current = ?, time_started = ? WHERE identifier = ? AND effect_name = ?', {
                time,
                time,
                xPlayer.identifier,
                debuffName
            })
            if effect_show == "hide" then return end
            updateUIEffect(xPlayer,debuffName,time,"debuff",image)
        end
        if not result[1] then
            local createEffect = MySQL.insert.await('INSERT INTO `core_effect` (identifier, time_current, time_started, effect_type, effect_name, image, effect_show) VALUES (?, ?, ?, ?, ?, ?, ?)', {
                xPlayer.identifier,
                time,
                time,
                "debuff",
                debuffName,
                image,
                effect_show
            })
            if effect_show == "hide" then return end
            updateUIEffect(xPlayer,debuffName,time,"debuff",image)
        end
    end)
end

function createDebuffGlobal(debuffName,time,image,effect_show)
    MySQL.Async.fetchAll('SELECT effect_name,effect_show FROM core_effect WHERE identifier = @identifier AND effect_name = @effect_name', {
        ['@identifier'] = "all",
        ['@effect_name'] = debuffName
    }, function(result)
        if result[1] then
            return
        end
        if not result[1] then
            local createEffect = MySQL.insert.await('INSERT INTO `core_effect` (identifier, time_current, time_started, effect_type, effect_name, image, effect_show) VALUES (?, ?, ?, ?, ?, ?, ?)', {
                "all",
                time,
                time,
                "debuff",
                debuffName,
                image,
                effect_show
            })
            if effect_show == "hide" then return end
            --updateUIEffectGlobal("all",debuffName,time,"debuff",image)
        end
    end)
end

function coreEffectCheckTimeRealTime(xPlayer, effect_name)
    -- If not in cache or cache is expired, query the database
    local response = MySQL.query.await('SELECT time_current FROM core_effect WHERE identifier = ? AND effect_name = ?', {
        xPlayer.identifier,
        effect_name
    })

    if response then
        if #response == 0 then
            -- Update cache and cacheTime
            return 0
        end
        return response[1].time_current
    else
        -- Handle error case
        print("Database query failed")
        return 0
    end
end

function coreEffectCheckTimeGlobal(effect_name)
    local cacheKey = "global:" .. effect_name
    local currentTime = os.time()

    -- Check if the value is in cache and if it is still valid
    if cache[cacheKey] and (currentTime - cacheTime[cacheKey]) < cacheExpireTime then
        return cache[cacheKey]
    end

    local response = MySQL.query.await('SELECT time_current FROM core_effect WHERE identifier = ? AND effect_name = ?', {
        "all",
        effect_name
    })

    if response then
        if #response == 0 then
            -- Update cache and cacheTime
            cache[cacheKey] = 0
            cacheTime[cacheKey] = currentTime
            return 0
        end

        -- Update cache and cacheTime
        cache[cacheKey] = response[1].time_current
        cacheTime[cacheKey] = currentTime

        return response[1].time_current
    else
        -- Handle error case
        print("Database query failed")
        return 0
    end
end

function coreEffectCheckTimeRealTimeGlobal(effect_name,time)
    local response = MySQL.query.await([[SELECT
    COUNT(1) >= 1 AS result
    FROM
    core_effect ce
    WHERE
    ce.effect_name = ?
    AND ce.identifier = ?
    AND TIMESTAMPDIFF(SECOND, ce.created_at, NOW()) >= ?
    GROUP BY ce.effect_name, ce.identifier, ce.created_at]], {
        effect_name,
        "all",
        time,
    })
    return not (response and #response > 0)
end


function coreEffectCheckTime(xPlayer, effect_name)
    local cacheKey = xPlayer.source .. ":" .. effect_name
    local currentTime = os.time()

    -- Check if the value is in cache and if it is still valid
    if cache[cacheKey] and (currentTime - cacheTime[cacheKey]) < cacheExpireTime then
        return cache[cacheKey]
    end

    -- If not in cache or cache is expired, query the database
    local response = MySQL.query.await('SELECT time_current FROM core_effect WHERE identifier = ? AND effect_name = ?', {
        xPlayer.identifier,
        effect_name
    })

    if response then
        if #response == 0 then
            -- Update cache and cacheTime
            cache[cacheKey] = 0
            cacheTime[cacheKey] = currentTime
            return 0
        end

        -- Update cache and cacheTime
        cache[cacheKey] = response[1].time_current
        cacheTime[cacheKey] = currentTime

        -- Store the effect_name for the player
        if not playerEffects[xPlayer.source] then
            playerEffects[xPlayer.source] = {}
        end
        playerEffects[xPlayer.source][effect_name] = true

        return response[1].time_current
    else
        -- Handle error case
        print("Database query failed")
        return 0
    end
end


function updateUIEffectGlobal(xPlayer,effectName,currentTime,effectType,image)
    xPlayer.triggerEvent('cc_coreeffect_ui:updateEffectTime',effectName,currentTime,effectType,image)
end

function deleteUIEffectGlobal(xPlayer,effectName)
    xPlayer.triggerEvent('cc_coreeffect_ui:deleteEffectTime',effectName)
end

function stopEffectGlobal(xPlayer,effectName)
    xPlayer.triggerEvent('core_effect_stop:'..effectName)
end

function startEffectGlobal(xPlayer,effectName,effectInGame)
    xPlayer.triggerEvent('core_effect_start:'..effectName,effectInGame)
end

function updateUIEffect(xPlayer,effectName,currentTime,effectType,image)
    --print(effectName,currentTime,effectType,image)
    xPlayer.triggerEvent('cc_coreeffect_ui:updateEffectTime',effectName,currentTime,effectType,image)
end

function deleteUIEffect(xPlayer,effectName)
    xPlayer.triggerEvent('cc_coreeffect_ui:deleteEffectTime',effectName)
end

function stopEffect(xPlayer,effectName)
    xPlayer.triggerEvent('core_effect_stop:'..effectName)
end

function startEffect(xPlayer,effectName,effectInGame)
    xPlayer.triggerEvent('core_effect_start:'..effectName,effectInGame)
end

function coreEffectCalculateEcoSpecific(xPlayer, ecoZone)
    local cacheKey = xPlayer.source .. ":ecoSpecific:" .. ecoZone
    local effectName = ":ecoSpecific:" .. ecoZone
    local currentTime = os.time()

    -- Check cache
    if cache[cacheKey] and (currentTime - cacheTime[cacheKey]) < cacheExpireTime then
        return cache[cacheKey]
    end

    MySQL.Async.fetchAll('SELECT effect_in_game,calculate_type FROM core_effect WHERE identifier = @identifier and effect_name = @effect_name', {
        ['@identifier'] = xPlayer.identifier,
        ['@effect_name'] = ecoZone
    }, function(result)
        local effect_count = 1
        if result[1] then
            for i=1, #result, 1 do
                effect_count = effect_count + result[i].effect_in_game
            end
            -- Store the effect_name for the player
            if not playerEffects[xPlayer.source] then
                playerEffects[xPlayer.source] = {}
            end
            playerEffects[xPlayer.source][effectName] = true
            cache[cacheKey] = effect_count
            cacheTime[cacheKey] = currentTime
            return effect_count
        end
        -- Store the effect_name for the player
        if not playerEffects[xPlayer.source] then
            playerEffects[xPlayer.source] = {}
        end
        playerEffects[xPlayer.source][effectName] = true
        cache[cacheKey] = effect_count
        cacheTime[cacheKey] = currentTime
        return effect_count
    end)
end

function coreEffectCalculateEcoNormal(xPlayer)
    local cacheKey = xPlayer.source .. ":ecoNormal"
    local currentTime = os.time()

    -- Check cache
    if cache[cacheKey] and (currentTime - cacheTime[cacheKey]) < cacheExpireTime then
        return cache[cacheKey]
    end

    local response = MySQL.query.await('SELECT effect_in_game FROM core_effect WHERE identifier = ? and effect_type = "economy"', {
        xPlayer.identifier,
    })
    if response then
        local effect_count = 0
        for i=1, #response, 1 do
            effect_count = effect_count + response[i].effect_in_game
            if i == #response then
                -- Store the effect_name for the player
                if not playerEffects[xPlayer.source] then
                    playerEffects[xPlayer.source] = {}
                end
                playerEffects[xPlayer.source]["ecoNormal"] = true
                cache[cacheKey] = effect_count
                cacheTime[cacheKey] = currentTime
                return effect_count
            end
        end
    end
    -- Store the effect_name for the player
    if not playerEffects[xPlayer.source] then
        playerEffects[xPlayer.source] = {}
    end
    playerEffects[xPlayer.source]["ecoNormal"] = true
    cache[cacheKey] = 1
    cacheTime[cacheKey] = currentTime
    return 1
end

function coreEffectCalculateMiningNormal(xPlayer)
    local cacheKey = xPlayer.source .. ":miningNormal"
    local currentTime = os.time()

    -- Check cache
    if cache[cacheKey] and (currentTime - cacheTime[cacheKey]) < cacheExpireTime then
        return cache[cacheKey]
    end

    local response = MySQL.query.await('SELECT effect_in_game FROM core_effect WHERE identifier = ? and effect_type = "mining"', {
        xPlayer.identifier,
    })
    if response then
        local effect_count = 0
        for i=1, #response, 1 do
            effect_count = effect_count + response[i].effect_in_game
            if i == #response then
                cache[cacheKey] = effect_count
                cacheTime[cacheKey] = currentTime
                -- Store the effect_name for the player
                if not playerEffects[xPlayer.source] then
                    playerEffects[xPlayer.source] = {}
                end
                playerEffects[xPlayer.source]["miningNormal"] = true
                return effect_count
            end
        end
    end
    -- Store the effect_name for the player
    if not playerEffects[xPlayer.source] then
        playerEffects[xPlayer.source] = {}
    end
    playerEffects[xPlayer.source]["miningNormal"] = true
    cache[cacheKey] = 1
    cacheTime[cacheKey] = currentTime
    return 1
end

local function handleExpiredItems(xPlayer)
    MySQL.Async.fetchAll('SELECT player_id, expire_timestamp, item_name FROM items_expire WHERE player_id = @player_id',
            {['@player_id'] = xPlayer.identifier},
            function(result)
                if result[1] then
                    local dbTimestamp = result[1].expire_timestamp
                    local currentTime = os.time()

                    if math.floor(dbTimestamp / 1000) < currentTime then
                        local itemName = result[1].item_name
                        local xItem = xPlayer.getInventoryItem(itemName)
                        xPlayer.removeInventoryItem(itemName, xItem.count)
                        if xItem.count <= 0 and xItem then
                            MySQL.Async.execute('DELETE FROM items_expire WHERE player_id = @id AND item_name = @item', {
                                ['@id'] = xPlayer.identifier,
                                ['@item'] = itemName
                            })
                        end
                        TriggerClientEvent('esx:showNotification', xPlayer.source, 'This item has expired.')
                    end
                end
            end)


    local stmtDeleteVehicle = [[
        DELETE FROM owned_vehicles
        WHERE owner = @identifier
        AND expire_date IS NOT NULL
        AND expire_date < CURDATE();
    ]]

    MySQL.Async.execute(stmtDeleteVehicle, {
        ['@identifier'] = xPlayer.identifier,
    })
end

local function deleteEffectGlobal(effectName)
    MySQL.query.await('DELETE FROM `core_effect` WHERE `identifier` = "all" AND `effect_name` = ?', {effectName})
end

local function updateEffectGlobal(effectName, newTime)
    MySQL.update.await('UPDATE core_effect SET time_current = ? WHERE identifier = "all" AND `effect_name` = ?', {
        newTime,
        effectName
    })
end

local function giveItemsToPlayer(xPlayer)
    MySQL.query('SELECT item_name, quantity FROM TB_GIVE_PLAYERS_ITEMS WHERE identifier = @player_id',
            {['@player_id'] = xPlayer.identifier},
            function(result)
                for i = 1, #result do
                    local itemName = result[i].item_name
                    local quantity = result[i].quantity
                    if itemName and quantity then
                        xPlayer.addInventoryItem(itemName, quantity)
                        pcall(function() -- Start log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'CoreSystemGiveItem',
                                content = ('มีการให้ไอเทม %s จำนวน %s จากระบบ GiveItem'):format(xPlayer.name, items.name),
                                source = xPlayer.source,
                            })
                        end) -- End log
                        MySQL.Async.execute('DELETE FROM TB_GIVE_PLAYERS_ITEMS WHERE identifier = @id and item_name = @item', {
                            ['@id'] = xPlayer.identifier,
                            ['@item'] = itemName
                        })
                    end
                end
            end)
end

-- Define functions for database operations
local function updateEffectTime(identifier, effectName, newTime)
    MySQL.update.await('UPDATE core_effect SET time_current = ? WHERE identifier = ? AND effect_name = ?', {
        newTime,
        identifier,
        effectName
    })
end

local function deleteEffect(identifier, effectName)
    MySQL.query.await('DELETE FROM core_effect WHERE identifier = ? AND effect_name = ?', {
        identifier,
        effectName
    })
end

local function processPlayerEffects(xPlayer)
    local xPlayerIdentifier = xPlayer.identifier

    local xPlayerEffects = MySQL.query.await('SELECT time_current, effect_name, effect_type, image, effect_in_game, effect_show FROM core_effect WHERE identifier = ?', {xPlayerIdentifier})

    for _, effectData in ipairs(xPlayerEffects) do
        local newTime = tonumber(effectData.time_current) - 60000

        if newTime <= 0 then
            deleteEffect(xPlayerIdentifier, effectData.effect_name)
            if effectData.effect_show == "show" then
                deleteUIEffect(xPlayer, effectData.effect_name, newTime)
            end
            stopEffect(xPlayer, effectData.effect_name)
            clearPlayerCache(xPlayer.source)
        else
            updateEffectTime(xPlayerIdentifier, effectData.effect_name, newTime)
            if effectData.effect_show == "show" then
                updateUIEffect(xPlayer, effectData.effect_name, newTime, effectData.effect_type, effectData.image)
            end
            startEffect(xPlayer, effectData.effect_name, effectData.effect_in_game)
        end
    end
end

Citizen.CreateThread(function()
    Citizen.Wait(10000)
    while true do
        local xPlayers = ESX.GetExtendedPlayers()
        local response = MySQL.query.await('SELECT effect_name, time_current, effect_type, image, effect_in_game, effect_show FROM core_effect WHERE identifier = @identifier', {
            ['@identifier'] = "all",
        })

        if response then
            for i = 1, #response do
                local newTime = tonumber(response[i].time_current) - 60000
                if newTime <= 0 then
                    deleteEffectGlobal(response[i].effect_name)
                    if response[i].effect_show == "show" then
                        for _, xPlayer in pairs(xPlayers) do
                            deleteUIEffectGlobal(xPlayer, response[i].effect_name, newTime)
                        end
                    end
                else
                    --print("pick new drug : ", newTime)
                    updateEffectGlobal(response[i].effect_name, newTime)
                    if response[i].effect_show == "show" then
                        for _, xPlayer in pairs(xPlayers) do
                            updateUIEffectGlobal(xPlayer, response[i].effect_name, newTime, response[i].effect_type, response[i].image)
                        end
                    end
                end
            end
        end
        Citizen.Wait(58000)
    end
end)


Citizen.CreateThread(function()
    Citizen.Wait(10000)
    while true do
        local xPlayers = ESX.GetExtendedPlayers()
        for _, xPlayer in pairs(xPlayers) do
            giveItemsToPlayer(xPlayer)
            Citizen.Wait(200) -- Adjust this delay if needed
            handleExpiredItems(xPlayer)
            Citizen.Wait(200) -- Adjust this delay if needed
        end
        Citizen.Wait(80000)
    end
end)


Citizen.CreateThread(function()
    Citizen.Wait(10000)
    while true do
        local xPlayers = ESX.GetExtendedPlayers()
        for _, xPlayer in pairs(xPlayers) do
            processPlayerEffects(xPlayer)
        end
        Citizen.Wait(60000)
    end
end)

-- handle memory leak
function clearPlayerCache(playerId)
    if  playerEffects[playerId] == nil then
        print("player have no cache")
        return
    end

    for effect_name, _ in pairs(playerEffects[playerId]) do
        local cacheKey = playerId .. ":" .. effect_name
        print("clear cache : " ..cacheKey)
        cache[cacheKey] = nil
        cacheTime[cacheKey] = nil
        print("clear cache result : " ..type(cache[cacheKey]) .." ".. type(cacheTime[cacheKey]))
    end

    -- Clear the player's effect list
    playerEffects[playerId] = nil
    --collectgarbage("collect")
    print("clear cache playerEffect result : " .. type(playerEffects[playerId]))
end

AddEventHandler('esx:playerDropped', function(playerId)
    playerId = tonumber(playerId)
    clearPlayerCache(playerId)
end)

AddEventHandler('playerDropped', function()
    local playerId = tonumber(source)
    clearPlayerCache(playerId)
end)

exports("createEffectByEffectTypeValidateByScript",createEffectByEffectTypeValidateByScript)
exports("coreEffectCalculateMiningNormal",coreEffectCalculateMiningNormal)
exports("createDebuffGlobal",createDebuffGlobal)
exports("createDebuff",createDebuff)
exports("coreEffectCheckTimeGlobal",coreEffectCheckTimeGlobal)
exports("coreEffectCheckTimeRealTimeGlobal",coreEffectCheckTimeRealTimeGlobal)
exports("coreEffectCheckTime",coreEffectCheckTime)
exports("coreEffectCheckTimeRealTime",coreEffectCheckTimeRealTime)
exports("coreEffectCalculateEcoNormal",coreEffectCalculateEcoNormal)
exports("coreEffectCalculateEcoSpecific",coreEffectCalculateEcoSpecific)
exports("deleteEffectByESXPlayer",deleteEffectByESXPlayer)