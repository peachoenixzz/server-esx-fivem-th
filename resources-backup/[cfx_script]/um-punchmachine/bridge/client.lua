if GetResourceState('es_extended') == 'started' then 

    ESX = exports.es_extended:getSharedObject()
    
    AddEventHandler('playerSpawned', function()
        TriggerServerEvent('um-punchmachine:server:requestCurrentData')
    end)

    function GetScoreNui()
        ESX.TriggerServerCallback('um-punchmachine:server:getScoreNui', function(result)
            SetNuiFocus(true, false)
            SendNUIMessage({status = "scorelist", result = result})
        end)
    end

    function GetMoney(id)
        ESX.TriggerServerCallback('um-punchmachine:server:getMoney', function(result)
            if result >= Config.Payment.price then
                TriggerServerEvent('um-punchmachine:server:SetPlayerMachine', id)
            else
                ShowNotification(Config.Lang.lang_nomoney .. ' $' .. Config.Payment.price)
            end
        end)
    end
    
    function ShowNotification(text)
        ESX.ShowNotification(text)
    end

    RegisterNetEvent('um-punchmachine:client:Notify', function(text)
        ShowNotification(text)
    end)
    
elseif GetResourceState('qb-core') == 'started' then 

    QBCore = exports['qb-core']:GetCoreObject()

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        TriggerServerEvent('um-punchmachine:server:requestCurrentData')
    end)

    function GetScoreNui()
        QBCore.Functions.TriggerCallback('um-punchmachine:server:getScoreNui', function(result)
            SetNuiFocus(true, false)
            SendNUIMessage({status = "scorelist", result = result})
        end)
    end

    function GetMoney(id)
        QBCore.Functions.TriggerCallback('um-punchmachine:server:getMoney', function(result)
            if result >= Config.Payment.price then
                TriggerServerEvent('um-punchmachine:server:SetPlayerMachine', id)
            else
                ShowNotification(Config.Lang.lang_nomoney .. ' $' .. Config.Payment.price)
            end
        end)
    end
    
    function ShowNotification(text)
        QBCore.Functions.Notify(text)
    end

    RegisterNetEvent('um-punchmachine:client:Notify', function(text)
        ShowNotification(text)
    end)
    
else
    print('No ESX or QB-Core found')
    print('Standalone')
end