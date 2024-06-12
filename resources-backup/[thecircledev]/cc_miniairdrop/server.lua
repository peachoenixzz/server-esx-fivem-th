ESX                 = nil
local CrateData    = {}

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    local playerId = source
	if xPlayer then
		TriggerClientEvent(scriptName..':LoadCrateData', xPlayer.source, CrateData)
	end
end)

RegisterCommand(Config["Command"]["Create"],function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and args[1] then
        if Config["Command"]["AdminClass"][xPlayer.group] then --Config["Command"]["Whitelist"][xPlayer.identifier]
            if Config["Crate"][args[1]] then
                local ped = GetPlayerPed(source)
                local coords = GetEntityCoords(ped)
                local Index = ""..math.modf(coords.x).."-"..math.modf(coords.y)..""
                if not CrateData[Index] then
                    CrateData[Index] = {
                        coords = coords,
                        data = Config["Crate"][args[1]],
                    }
                    TriggerClientEvent(scriptName..':UpdateCrateData', -1 , Index, CrateData[Index])
                end
            end
        end
    end
end)

RegisterServerEvent(scriptName..':GetCrate')
AddEventHandler(scriptName..':GetCrate', function(code)
    if CrateData[code] then
        local xPlayer = ESX.GetPlayerFromId(source)
        calculateitemMiniAirdrop(CrateData[code].data.items, xPlayer)
        calculateitemBonusMiniAirdrop(CrateData[code].data.itemsBonus, xPlayer)
        CrateData[code] = nil
        TriggerClientEvent(scriptName..':DeleteCrate', -1 , code)
    else
        TriggerClientEvent(scriptName..':DeleteCrate', source , code)
    end
end)

RegisterCommand(Config["Command"]["Delete"],function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if Config["Command"]["AdminClass"][xPlayer.group] and Config["Command"]["Whitelist"][xPlayer.identifier] then
            local ped = GetPlayerPed(source)
            local coords = GetEntityCoords(ped)
            local Index = ""..math.modf(coords.x).."-"..math.modf(coords.y)..""
            if CrateData[Index] then
                TriggerClientEvent(scriptName..':DeleteCrate', -1 , Index)
                CrateData[Index] = nil
            end
        end
    end
end)

function calculateitemMiniAirdrop(itemInfo, xPlayer)
    if itemInfo ~= nil then
        for _,v in pairs(itemInfo) do
            local getitemCount = math.random(v.quantity[1], v.quantity[2])
            if v.itemName == 'money' or v.itemName == 'black_money' then
                xPlayer.addAccountMoney(v.itemName, getitemCount)
            else
                xPlayer.addInventoryItem(v.itemName, getitemCount)
            end
        end
    end
end

function calculateitemBonusMiniAirdrop(inteminfoBonus, xPlayer)
    if inteminfoBonus ~= nil then
        local xItemBonusRate = math.random(1, 100000)/100000
        print(xItemBonusRate)
        local matchingItems = {}
        local minMatchingPercent = 1.0
                
        for _, v in pairs(inteminfoBonus) do
            if xItemBonusRate <= v.percent then
                table.insert(matchingItems, v)
                if v.percent < minMatchingPercent then
                       minMatchingPercent = v.percent
                end
            end
        end
                
        local finalMatchingItems = {}
        for _, v in pairs(matchingItems) do
            if v.percent == minMatchingPercent then
                table.insert(finalMatchingItems, v)
            end
        end
                
                
        if #finalMatchingItems > 0 then
            local randomIndex = math.random(1, #finalMatchingItems)
            local randomItem = finalMatchingItems[randomIndex]
            local getitemCount = math.random(randomItem.quantity[1], randomItem.quantity[2])
            if randomItem.itemName == 'money' or randomItem.itemName == 'black_money' then
                xPlayer.addAccountMoney(randomItem.itemName, getitemCount)
            else
                xPlayer.addInventoryItem(randomItem.itemName, getitemCount)
            end
        end
    end
end