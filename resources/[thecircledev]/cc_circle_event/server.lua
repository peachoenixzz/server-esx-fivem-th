ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('donePickEvent')
AddEventHandler('donePickEvent', function(currentcircleEventszone)
    local source = source
    local xPlayer =  ESX.GetPlayerFromId(source)
    for _,v in pairs(Config.geteventItemInfo) do
        if v.name == currentcircleEventszone then
            xPlayer.addInventoryItem(v.getItem, 1)
        end
    end
end)



