

RegisterNetEvent('cc_ammosystem:playerAnimation')
AddEventHandler('cc_ammosystem:playerAnimation', function()
	local playerPed = GetPlayerPed(-1)
    RequestAnimDict("anim@weapons@pistol@revolver_str")
    while not HasAnimDictLoaded("anim@weapons@pistol@revolver_str") do
	
        Citizen.Wait(100)
		
    end
	
    TaskPlayAnim(GetPlayerPed(PlayerId()), "anim@weapons@pistol@revolver_str", "reload_aim", 1.0, -1, -1, 50, 0, 0, 0, 0)
    Citizen.Wait(1000)
    StopAnimTask(PlayerPedId(), "anim@weapons@pistol@revolver_str", "reload_aim", 1.0)
end)