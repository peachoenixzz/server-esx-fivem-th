ESX = nil --
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('cc_soidow:checkItem', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local haveStick = xPlayer.getInventoryItem("lkt_stick")
    if haveStick.count > 0 then
        cb(true)
        return
    end
    cb(false)
end)

ESX.RegisterServerCallback('cc_soidow:doneSoidow', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local haveStick = xPlayer.getInventoryItem("lkt_stick")
    if haveStick.count > 0 then
        xPlayer.removeInventoryItem("lkt_stick", 1)
        calculateSoidow(xPlayer)
        cb(true)
        return
    end
    cb(false)
end)

function calculateSoidow(xPlayer)
    local xItemBonusRate = math.random(1, 100000)/100000
    local matchingItems = {}
    local minMatchingPercent = 1.0

    for _, v in pairs(Config.Soidow) do
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
        local addItemCount = math.random(randomItem.quantity[1], randomItem.quantity[2])
        if randomItem.itemName == 'money' or randomItem.itemName == 'black_money' then
            xPlayer.addAccountMoney(randomItem.itemName, addItemCount)        
        else
            xPlayer.addInventoryItem(randomItem.itemName, addItemCount)         
        end
    end

end




