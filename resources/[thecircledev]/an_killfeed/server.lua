-- Join Discord for Support: https://discord.gg/KxdPzC5EeJ

-- Variables --
local cachedPeds = {}

-- Main Event --
RegisterNetEvent('an_killfeed:add')
AddEventHandler('an_killfeed:add', function(killer, victim, image, noScoped, headshot, driveBy, showDist)
    local killerEntity = nil
    local victimEntity = nil

    if killer.netId ~= 0 then
        if not cachedPeds[killer.netId] then
            if killer.type == "player" then
                --local xPlayer	= ESX.GetPlayerFromId(killer.sourceId)
                --xPlayer.addAccountMoney('money', 3000)
                killer.name = GetPlayerNameByServerId(killer.sourceId)
            elseif killer.type == "npc" then
                killerEntity = NetworkGetEntityFromNetworkId(killer.netId)
                if Config.randomNPCNames then
                    killer.name = GetRandomName(killerEntity, killer.pedType, killer.gender)
                else
                    killer.name = killerEntity
                end
                cachedPeds[killer.netId] = killer.name
            end
        else
            killer.name = cachedPeds[killer.netId]
        end

        if showDist then
            if killerEntity == nil then
                killerEntity = NetworkGetEntityFromNetworkId(killer.netId)
            end
            victimEntity = NetworkGetEntityFromNetworkId(victim.netId)
            showDist = #(GetEntityCoords(killerEntity) - GetEntityCoords(victimEntity))
            if Config.distanceUnit == "ft" then
                showDist = math.floor((showDist * 3.2808399) + 0.5).." ft"
            else
                showDist = math.floor(showDist + 0.5).." m"
            end
        end
    else
        killer.name = nil
        showDist = false
    end

    if not cachedPeds[victim.netId] then
        if victim.type == "player" then
            victim.name = GetPlayerNameByServerId(victim.sourceId)
        elseif victim.type == "npc" then
            victimEntity = NetworkGetEntityFromNetworkId(victim.netId)
            if Config.randomNPCNames then
                victim.name = GetRandomName(victimEntity, victim.pedType, victim.gender)
            else
                victim.name = victimEntity
            end
            cachedPeds[victim.netId] = victim.name
            CDRemCachedName(victim.netId)
        end
    else
        victim.name = cachedPeds[victim.netId]
    end

    local players = {}
    local playerList = GetPlayers()
    for index, playerId in pairs(playerList) do
        players[index] = tonumber(playerId)
    end

    TriggerClientEvent('an_killfeed:addCL', -1, killer, victim, image, noScoped, headshot, driveBy, showDist)
    if Config.enableLog then
        local killerLog = "`N/A`"
        if killer.netId then
            if type(killer.type) ~= "string" then
                killer.type = "`N/A`"
            end
            killerLog = killer.name .. " [ " .. string.upper(killer.type) .. " ]"
        end
        local victimLog = "`N/A`"
        victimLog = victim.name .. " [ " .. string.upper(victim.type) .. " ]"
        local isNS, isHS, isDB, isDist = "❌", "❌", "❌", "`N/A`"
        if noScoped then
            isNS = ":white_check_mark:"
        end
        if headshot then
            isHS = ":white_check_mark:"
        end
        if driveBy then
            isDB = ":white_check_mark:"
        end
        if showDist then
            isDist = showDist
        end
        local message = "Killer: **" .. killerLog .. "**\n Victim: **" .. victimLog .. "** \n Reason: **".. image .. "** \n Headshot: **".. isHS .. "** \n DriveBy: **".. isDB .. "**\n Distance: **".. isDist .. "**\n No Scope: **".. isNS .. "**"
        --
        PerformHttpRequest(
            Config.webhook,
            function(err, text, headers) end,
            'POST',
            json.encode(
                {
                    username = "AN Kill Feed Logger",
                    embeds = {
                        {
                            ["color"] = "15532063",
                            ["author"] = {
                                ["name"] = "AN Kill Feed",
                                ["icon_url"] = "https://media.discordapp.net/attachments/1056799706690359397/1056811100554940456/red-squared.png",
                            },
                            ["description"] = "".. message .."",
                            ["footer"] = {
                                ["text"] = "© AN Kill Feed - "..os.date("%x %X %p"),
                                ["icon_url"] = "https://media.discordapp.net/attachments/1056799706690359397/1056811100554940456/red-squared.png",
                            },
                        },
                    },
                }
            ),
            { ['Content-Type'] = 'application/json' }
        )
    end
end)


-- Functions --
function GetPlayerNameByServerId(playerId)
    -- here you can add your own framework integration for the player name
    return GetPlayerName(playerId)
end

function GetAnimalType(ped)
    local model = GetEntityModel(ped)
    return Config.animalTypes[model]
end

function GetRandomName(ped, pedType, gender)
    if pedType == "animal" then
        local animalType = GetAnimalType(ped)
        local index = math.random(1, #Config.NPCNames.animal[animalType])
        local name = Config.NPCNames.animal[animalType][index]
		name = name..Config.animalLabels[animalType]

        if Config.AnimalText then
            name = Config.AnimalTextLabel..name
        end

        return name
    end

    local index = math.random(1, #Config.NPCNames[pedType][gender])
    local name = Config.NPCNames[pedType][gender][index]
    
    if Config.NPCText then
        name = Config.NPCTextLabel..name
    end

    return name
end

function CDRemCachedName(id)
    Citizen.CreateThread(function()
        Citizen.Wait(10000)
        cachedPeds[id] = nil
    end)
end