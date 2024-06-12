local authKey = nil
local alreadyLogin = false
--SetNuiFocus(true, true)
function showLoginPanel()
    SetNuiFocus(true, true)
    SendNUIMessage({
            action = 'showLoginPanel',
    })
end

function hideLoginPanel()
        SendNUIMessage({
            action = 'hideLoginPanel'
        })
end

function closeGui()
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = 'hideLoginPanel'
        })
end


RegisterNUICallback('login', function(data, cb)
    if authKey ~= nil and not alreadyLogin then
        alreadyLogin = false
        TriggerEvent('esx:spawnCirclePlayer')
        closeGui()
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'unmutedVideo'
        })
        authLogin()
end)

function authLogin()
    ESX.TriggerServerCallback('cc_authlogin:checkLogin', function(tokenKey)
        authKey = tokenKey
        print(authKey)
        if authKey == nil then
            Wait(500)
            return authLogin()
        end
        enableLogin()
    end)
end

function tokenCollect()
    return authKey
end

function enableLogin()
    SendNUIMessage({
        action = 'enableLoginButton',
    })
end




