
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('cc_coreeffect_ui:updateEffectTime')
AddEventHandler('cc_coreeffect_ui:updateEffectTime', function(effectName, currentTime, effectType, image)
    --print("update UI : ",effectName,currentTime,effectType,image)
    SendNUIMessage({
        action = 'update',
        effectName = effectName,
        currentTime = currentTime,
        effectType = effectType,
        image = image
    })
end)

RegisterNetEvent('cc_coreeffect_ui:deleteEffectTime')
AddEventHandler('cc_coreeffect_ui:deleteEffectTime', function(effectName)
    --print("delete UI : ", effectName)
    SendNUIMessage({
        action = 'delete',
        effectName = effectName,
    })
end)