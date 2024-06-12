local Result = nil
local NUI_status = false
local isDead = false

function StartLockPickCircle(circles, seconds, failure, gameType, callback)
    Result = nil
    NUI_status = true
    SendNUIMessage({
        action = 'start',
        value = circles,
		time = seconds,
        failure = failure,
        gameType = gameType
    })
    while NUI_status do
        if isDead then
            Result = false
            break
        end
        Wait(5)
        SetNuiFocus(NUI_status, false)
    end
    Wait(100)
    SetNuiFocus(false, false)
    lockpickCallback = callback
    return Result
end

RegisterNUICallback('fail', function()
        ClearPedTasks(PlayerPedId())
        Result = false
        Wait(100)
        NUI_status = false
        --print('fail')
end)

RegisterNUICallback('success', function()
	Result = true
	Wait(100)
	NUI_status = false
    SetNuiFocus(false, false)
    return Result
end)



AddEventHandler('esx:onPlayerDeath', function(data)
    isDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
    isDead = false
end)
