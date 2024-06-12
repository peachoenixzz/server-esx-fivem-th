ESX.RegisterUsableItem('ad_bell', function(source)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("ad_bell")
    if xItem.count > 0 then
        TriggerClientEvent("cc_blessingbell:initGetAroundPlayer", xPlayer.source)
    end
end)


ESX.RegisterServerCallback('cc_blessingbell:validatePlayer', function(source, cb,selectedPlayer)
    local xPlayer	= ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("ad_bell")
    if xItem.count > 0 then
        xPlayer.removeInventoryItem(xItem.name, 1)
        for _,v in pairs(selectedPlayer) do
            local xTarget = ESX.GetPlayerFromId(v)
            if xTarget then
                exports.cc_coreeffect:createEffectByEffectTypeValidateByScript(xTarget,xItem)
            end
        end
        exports.cc_coreeffect:createEffectByEffectTypeValidateByScript(xPlayer,xItem)
        cb(true)
        return
    end
    cb(false)
end)