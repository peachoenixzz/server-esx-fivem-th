function Notification(text)

end

split = function(str, sep)
	local result = {}
	local regex = ("([^%s]+)"):format(sep)
	for each in str:gmatch(regex) do
	   table.insert(result, each)
	end
	return result
end

function CheckHasItem(itemname)
	local inventory = ESX.GetPlayerData().inventory 

	for i=1,#inventory do 
		if inventory[i].name == itemname and inventory[i].count >= 1 then 
			return true 
		end
	end

	return false 
end

function CheckMoney(need_to_pay)
	local player_money = ESX.GetPlayerData().money
	if (player_money >= need_to_pay) then
		return true
	end
	return false
end