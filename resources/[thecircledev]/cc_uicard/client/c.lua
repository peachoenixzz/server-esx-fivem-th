local cardActivate = false

function showIDCard()
    if not cardActivate then
        local closestPlayer, distance = ESX.Game.GetClosestPlayer()
        if distance <= 5.0 and distance ~= -1 then
            TriggerServerEvent('cc_uicard:showCardClosetPlayer', GetPlayerServerId(closestPlayer))
        end
        cardActivate = true
        TriggerServerEvent('cc_uicard:showCardYourself')
        return
    end
    if cardActivate then
        hideIDCard()
        return
    end
end

RegisterNetEvent("cc_uicard:showCardClosetPlayer")
AddEventHandler("cc_uicard:showCardClosetPlayer", function(ownerCard)
        SendNUIMessage({
            action = 'showIDCard',
            dateOfBirth = ownerCard.dob,
            name = ownerCard.name,
            height = ownerCard.height,
            sex = ownerCard.sex,
            job = ownerCard.job,
            position = ownerCard.position,
            image = "",
        })
end)

RegisterNetEvent("cc_uicard:showCardYourself")
AddEventHandler("cc_uicard:showCardYourself", function(ownerCard)
    SendNUIMessage({
        action = 'showIDCard',
        dateOfBirth = ownerCard.dob,
        name = ownerCard.name,
        height = ownerCard.height,
        sex = ownerCard.sex,
        job = ownerCard.job,
        position = ownerCard.position,
        image = "",
    })
end)

function hideIDCard()
        SendNUIMessage({
            action = 'hideIDCard'
        })
    cardActivate=false
end

local closeGui =  function()
    SendNUIMessage({
        action = 'hideIDCard'
    })
    cardActivate=false
end


RegisterKeyMapping('+escIDCard' , 'Hide ID Card'  , 'keyboard'    , 'BACK')
RegisterCommand('-escIDCard', closeGui)
RegisterCommand('+escIDCard', closeGui)