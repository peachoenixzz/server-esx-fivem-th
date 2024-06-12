


function initSound(soundType, type)
	type = type or nil
	if type == "local" then
		playSound(soundType)
		return
	end
	ESX.TriggerServerCallback('cc_sound:initSound', function()

	end,soundType)
end

function playSound(soundType)
	soundType = nil or soundType
	if soundType then
		SendNUIMessage(
				{
					Type = "playSound",
					File = soundType..".mp3",
					Volume = 0.2
				}
		)
	end
end

RegisterNetEvent('cc_sound:playSound')
AddEventHandler('cc_sound:playSound', function(soundType)
	soundType = nil or soundType
	if soundType then
		SendNUIMessage(
				{
					Type = "playSound",
					File = soundType..".mp3",
					Volume = 0.2
				}
		)
	end
end)