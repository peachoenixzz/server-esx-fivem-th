local authCement = "Joi_Taokha!9!8!7!6"
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("cc_cementrobbery:BonusItem")
AddEventHandler("cc_cementrobbery:BonusItem", function(basicAuthCement)
	if basicAuthCement == authCement then
		local xPlayer = ESX.GetPlayerFromId(source)
		calculatebonusitemCement(xPlayer)
	end
end)

function calculatebonusitemCement(xPlayer)
	local xItemBonusRate = math.random(1, 100000)/100000
    --print(xItemBonusRate)
    local matchingBonusItems = {}
    local minMatchingBonusPercent = 1.0
        
    for _, v in pairs(Config.cementBonusItem) do
        if xItemBonusRate <= v.percent then
            table.insert(matchingBonusItems, v)
            if v.percent < minMatchingBonusPercent then
                minMatchingBonusPercent = v.percent
            end
        end
    end
        
    local finalMatchingBonusItems = {}
    for _, v in pairs(matchingBonusItems) do
        if v.percent == minMatchingBonusPercent then
               table.insert(finalMatchingBonusItems, v)
        end
    end
        
        
    if #finalMatchingBonusItems > 0 then
        local randomBonusIndex = math.random(1, #finalMatchingBonusItems)
        local randomBonusItem = finalMatchingBonusItems[randomBonusIndex]
        local addItemCount = math.random(randomBonusItem.quantity[1], randomBonusItem.quantity[2])
        if xPlayer.canCarryItem(randomBonusItem.itemName, addItemCount) then
            xPlayer.addInventoryItem(randomBonusItem.itemName, addItemCount)    
        end
    end
end
