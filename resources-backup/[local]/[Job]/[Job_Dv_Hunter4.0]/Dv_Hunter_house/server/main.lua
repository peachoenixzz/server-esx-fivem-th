ESX = nil 
Dv_Hunter = GetCurrentResourceName()
 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 

RegisterServerEvent(Dv_Hunter..'AddItem')
AddEventHandler(Dv_Hunter..'AddItem', function()
    local xPlayer	= ESX.GetPlayerFromId(source)
	local name		= xPlayer.name
	local xItem = xPlayer.getInventoryItem(Config.itemname)
    local xItemCount = math.random(Config.ItemCount[1], Config.ItemCount[2])
	
if Config.Setting["ระบบ"] == "limit" then 		
	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		Inventoryfull()
	else
		if xItem.limit ~= -1 and (xItem.count + xItemCount) > xItem.limit then
			xPlayer.setInventoryItem(xItem.name, xItem.limit)
		else
			xPlayer.addInventoryItem(xItem.name, xItemCount)
		end

		if Config.ItemBonus ~= nil then
			for k,v in pairs(Config.ItemBonus) do
				if math.random(1, 100) <= v.Percent then
					local xItemZ = xPlayer.getInventoryItem(v.ItemName)
					if xItemZ.limit ~= -1 and xItemZ.count >= xItemZ.limit then
						Inventoryfull2()
					else
						xPlayer.addInventoryItem(v.ItemName, v.ItemCount)
					end
				end
			end
		end
	end
	elseif Config.Setting["ระบบ"] == "weight" then	
		if xPlayer.canCarryItem(xItem.name, xItemCount) then
			xPlayer.addInventoryItem(xItem.name, xItemCount)
		else
			Inventoryfullweight()
		end
		if Config.ItemBonus ~= nil then
				for k,v in pairs(Config.ItemBonus) do
					if math.random(1, 100) <= v.Percent then
						local xItemZ = xPlayer.getInventoryItem(v.ItemName)
						if xItemZ.limit ~= -1 and xItemZ.count >= xItemZ.limit then
						if xPlayer.canCarryItem(v.ItemName, v.ItemCount) then
							xPlayer.addInventoryItem(v.ItemName, v.ItemCount)
						else
							InventoryfullBonusweight()
						end
					end
				end
			end		
		end	
	end
end)

