local cardActivate = false

function showIDCardGang()
    if not cardActivate then
        local closestPlayer, distance = ESX.Game.GetClosestPlayer()
        if distance <= 5.0 and distance ~= -1 then
            TriggerServerEvent('cc_uicard_gang:showCardClosetPlayer', GetPlayerServerId(closestPlayer))
        end
        SendNUIMessage({
            action = 'showIDCardGang',
        })
        cardActivate=true
        return
    end
    if cardActivate then
        hideIDCardGang()
    end
end

RegisterNetEvent("cc_uicard_gang:showCardClosetPlayer")
AddEventHandler("cc_uicard_gang:showCardClosetPlayer", function()
        SendNUIMessage({
            action = 'showIDCardGang'
        })
end)

function hideIDCardGang()
        SendNUIMessage({
            action = 'hideIDCardGang'
        })
    cardActivate=false
end

local closeGui =  function()
    SendNUIMessage({
        action = 'hideIDCardGang'
    })
    cardActivate=false
end


RegisterKeyMapping('+escIDCardGang' , 'Hide ID Card'  , 'keyboard'    , 'BACK')
RegisterCommand('-escIDCardGang', closeGui)
RegisterCommand('+escIDCardGang', closeGui)