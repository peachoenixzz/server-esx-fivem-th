
local isCooldownActive = false
local ad = "missheistfbi3b_ig6_v2"
local anim = "rubble_slide_gunman"

Citizen.CreateThread(function()
	Wait(0)
	RequestAnimDict(ad)
	while not HasAnimDictLoaded(ad) do
		Citizen.Wait(100)
	end
end)
RegisterCommand('perform_action_slide', function()
	-- Check if Left Shift or Right Shift is being held down
	local isShiftPressed = IsControlPressed(0, 155) -- 21 is the control ID for Shift
	if isShiftPressed and not isCooldownActive then
		isCooldownActive = true
		PerformCustomAction()

		-- Cooldown for 10 seconds
		Citizen.SetTimeout(10000, function()
			isCooldownActive = false
		end)
	elseif isShiftPressed then
		-- Optional: Notify the player that the action is on cooldown
	end
end, false)

function PerformCustomAction()
	local ped = PlayerPedId()
	if IsPedOnFoot(ped) and not exports.esx_policejob:getStatusHandcuffed() and not IsPedRagdoll(ped) then
		SetPedMoveRateOverride(ped, 1.25)
		ClearPedSecondaryTask(ped)
		TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
		ApplyForceToEntityCenterOfMass(ped, 1, 0, 12.8, 0.8, true, true, true, true)
		Wait(250)
		TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
		ClearPedSecondaryTask(ped)
	end

	if not IsPedOnFoot(ped) or exports.esx_policejob:getStatusHandcuffed() or IsPedRagdoll(ped) then
		isCooldownActive = false
	end
end

RegisterKeyMapping('perform_action_slide', 'Perform Action Slide', 'keyboard', 'H')

