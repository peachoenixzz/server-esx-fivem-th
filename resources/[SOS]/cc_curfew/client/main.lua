ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("cc_curfew:showMenu")
AddEventHandler("cc_curfew:showMenu", function(...)
	local texts = { ... }
	local textJS = table.concat(texts, " ")
    SendNUIMessage({
        action = "showMenu",
        text = textJS,
    })
    
    print("Text2:", texts)
end)



RegisterNetEvent("cc_curfew:hideMenu")
AddEventHandler("cc_curfew:hideMenu", function()
		SendNUIMessage({
			action = "hideMenu",
			text = "",
		})
end)


