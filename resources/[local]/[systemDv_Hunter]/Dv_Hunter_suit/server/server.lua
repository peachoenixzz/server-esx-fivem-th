Dv_Hunter                   = GetCurrentResourceName()
red 			  		= 16711680

for k,v in pairs(Config.suitList) do
	ESX.RegisterUsableItem(v.itemname, function(source)  
		TriggerClientEvent(Dv_Hunter..'suit', source,v)
	end)
end

------------------------------------------------------------------------
