local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX                           = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

local vaultType = {}

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function OpenVaultInventoryMenu(data)
	if data.job == ESX.PlayerData.job.name or data.job == 'vault' then
		print(data.needItemLicense)
		vaultType = data
		ESX.TriggerServerCallback("esx_vault:getVaultInventory",
			function(inventory)
				if not inventory then
					exports.pNotify:SendNotification({text=(Config.Text.NoLicense),type="error"})
				else
					TriggerEvent("esx_inventoryhud:openVaultInventory", inventory)
				end
			end,
			data
		)
	else
		exports.pNotify:SendNotification({text=(Config.Text.Nojobs),type="error"})
		Citizen.Wait(8000)
	end
end

Citizen.CreateThread(function()
    while ESX == nil or ESX.PlayerData == nil or ESX.PlayerData.job == nil do
        Citizen.Wait(1000)
    end
    print('Object Vault Working')
    for k,v in pairs(Config.Vault) do
		ESX.Game.SpawnLocalObject(Config.VaultBox, v.coords, function(obj)
			SetEntityHeading(obj, v.heading)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
		end)
	end
    
end)
--[[
-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Vault) do
			local dist = GetDistanceBetweenCoords(coords, v.coords, true)
			if dist < 2 then
				DrawText3Ds(v.coords.x,v.coords.y, v.coords.z + 1.0, "[~g~E~w~]-Open Safe ~y~"..k)
				
				if IsControlJustReleased(0, Keys['E']) then
					ESX.TriggerServerCallback('esx_vault:checkcard', function(card)
						if card then
							OpenVaultInventoryMenu({job = k, needItemLicense = v.needItemLicense, InfiniteLicense = v.InfiniteLicense})
						else
							TriggerEvent('pNotify:SendNotification',{
							text = "<b style='color:#ffffff'>คุณไม่มี บัตรดำ ในการเปิดตู้เซฟ!</b>",
							type = "error",
							timeout = (3000),
							layout = "bottomRight",
							queue = "global"
							})
						end
					end
				else
					break
				end
			end
		end
		
	end
end)
]]--
-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Vault) do
			local dist = GetDistanceBetweenCoords(coords, v.coords, true)
			if dist < 2 then
				--ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ Open Safe Pattaya")
				DrawText3Ds(v.coords.x,v.coords.y, v.coords.z + 1.0, "[~g~E~w~]-Open ~y~"..k)
				
				if IsControlJustReleased(0, Keys['E']) then
					OpenVaultInventoryMenu({job = k, needItemLicense = v.needItemLicense, InfiniteLicense = v.InfiniteLicense})
					
				else
					break
				end
			end
		end
		
	end
end)

function getMonsterVaultLicense()
	return vaultType
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.3, 0.3)
    SetTextFont(6)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 450
    DrawRect(_x, _y + 0.0110, 0.015 + factor, 0.03, 41, 11, 41, 100)
end
