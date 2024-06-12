local notInjury = false
local isDead = false
RegisterNetEvent('mcard:on')
AddEventHandler('mcard:on', function()
		local playerPed= PlayerPedId()
		RequestAnimSet("move_m@injured")
		SetPedMovementClipset(playerPed, "move_m@injured", 0.2)
end)


RegisterNetEvent('mcard:off')
AddEventHandler('mcard:off', function()
	  	local playerPed= PlayerPedId()
		ResetPedMovementClipset(playerPed)
		ResetPedWeaponMovementClipset(playerPed)
		ResetPedStrafeClipset(playerPed)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		local myPed = PlayerPedId()
		local hp = GetEntityHealth(myPed)
		--local lastHp = hp
		--print(hp)
		local movementClipset = GetPedMovementClipset(myPed)
		--print(movementClipset)
		if hp <= Config.Injuryon and movementClipset ~= -650503762 and not isDead then
			--print("hp is not normal")
			TriggerEvent('mcard:on')
			exports.dpemotes:setStateEmoteWalk()
			notInjury = false
		end
		if hp > Config.Injuryon and not notInjury and not isDead then
			if exports.dpemotes:checkEmoteWalk() then goto endState end
			--print("hp is normal")
			TriggerEvent('mcard:off')
			notInjury = true
		end
		::endState::
	end
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead    = true
end)

AddEventHandler('esx:onPlayerSpawn', function()
	isDead = false
end)


