
local guiEnabled = false
local success = false
local action = nil
local trigger = nil
local npins = 3


function DisplayNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

RegisterNetEvent('minigame_lockpick:StartLockpickfo')
AddEventHandler('minigame_lockpick:StartLockpickfo', function(cb)

	TriggerEvent("mythic_progbar:client:progress", {
		name = "preparing_lockpick",
		duration = 3000,
		label = "Lockpick ! ! ! !",
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = false,
		},
		animation = {
			animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
			anim = "machinic_loop_mechandplayer",
			flags = 49,
		}
	}, function(status)
		if not status then
			SetNuiFocus(true)
			guiEnabled = true
			SendNUIMessage({
				type = "enableui",
				pins = 3,
				enable = true,
			})
			Citizen.CreateThread(function()
				while true do
					if action == 'success' then
						action = nil
						cb(true)
						break
					elseif action == 'failed' then
						action = nil
						cb(false)
						break
					end
					Citizen.Wait(0)
				end
			end)

		end
	end)    


end)


RegisterNetEvent('minigame_lockpick:StartLockpickfoCustompin')
AddEventHandler('minigame_lockpick:StartLockpickfoCustompin', function(cb, pins)

	TriggerEvent("mythic_progbar:client:progress", {
		name = "preparing_lockpick",
		duration = 3000,
		label = "Lockpick ! ! ! !",
		useWhileDead = false,
		canCancel = false,
		controlDisables = {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = false,
		},
		animation = {
			animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
			anim = "machinic_loop_mechandplayer",
			flags = 49,
		}
	}, function(status)
		if not status then
			SetNuiFocus(true)
			guiEnabled = true
			SendNUIMessage({
				type = "enableui",
				pins = 1,
				enable = true,
			})
			Citizen.CreateThread(function()
				while true do
					if action == 'success' then
						action = nil
						cb(true)
						break
					elseif action == 'failed' then
						action = nil
						cb(false)
						break
					end
					Citizen.Wait(0)
				end
			end)

		end
	end)    
end)

RegisterNUICallback('escape', function(data, cb)
    SetNuiFocus(false)
    guiEnabled = false
    cb('ok')
end)

RegisterNUICallback('removepin', function(data, cb)
    TriggerServerEvent('lsrp-lockpickfo:removePin')
    cb('ok')
end)

RegisterNUICallback('process', function(data, cb)
    SetNuiFocus(false)
    guiEnabled = false
    if data.state then
        action = 'success'
    else
        action = 'failed'
    end
    cb('ok')
end)

Citizen.CreateThread(function()
    while true do
        if guiEnabled then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown
            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride

            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click",
                    pins = npins
                })
            end
        end
        Citizen.Wait(0)
    end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	if guiEnabled then
		SetNuiFocus(false)
		guiEnabled = false
		action = 'failed'
	end
end)

-- RegisterCommand("xz", function()
-- 	SetNuiFocus(true)
-- 	SendNUIMessage({
-- 		type = "enableui",
-- 		pins = 3,
-- 		enable = true,
-- 	})
-- end)