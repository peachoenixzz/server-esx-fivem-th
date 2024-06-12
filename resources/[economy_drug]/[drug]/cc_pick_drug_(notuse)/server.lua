ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('cc_pick_drug:checkZoneDrug', function(source, cb)
    circleDrugZones = {
        {
            coords = vector3(3406.85009765625, 5504.77001953125, 26.2800006866455),
            name = "weed_zone",
            distance = 30,
            debug = false,
            enable = true,
        },
        -- {
        --     coords = vector3(2822.3701, -1482.0899, 11.6700),
        --     name = "cocaine_zone",
        --     distance = 30,
        --     debug = false,
        --     enable = true,
        -- },
    }
    cb(circleDrugZones)
end)

ESX.RegisterServerCallback('cc_pick_drug:checkSpawnDrug', function(source, cb)
    circleSpawnDrugZones = {
        weed = {
            polyname = "weed_zone",

            spawnPropPos = { 
                x = 3406.85009765625, y = 5504.77001953125, z = 26.2800006866455     
            },
            spawnPropDistance = 12,

            placeOnjectOnGround = true,
            objectName = "prop_weed_01",
            objectCount = 6,
        },
        -- cocaine = {
        --     polyname = "cocaine_zone",

        --     spawnPropPos = { 
        --         x = 2822.3701, y = -1482.0899, z = 13.5700        
        --     },
        --     spawnPropDistance = 12,

        --     placeOnjectOnGround = true,
        --     objectName = "ex_office_swag_drugbag2",
        --     objectCount = 6,
        -- },
    }
    cb(circleSpawnDrugZones)
end)

RegisterServerEvent('giveDrugItem')
AddEventHandler('giveDrugItem', function(currentdrugZone)
    for _,v in pairs(Config.DrugInfoServer) do
		if v.polyname == currentdrugZone then
            local xPlayer	= ESX.GetPlayerFromId(source)
            local xItemCount = math.random(v.getItemCount[1], v.getItemCount[2])
            if xPlayer.canCarryItem(v.getItemName, xItemCount) then
                xPlayer.addInventoryItem(v.getItemName, xItemCount)
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                         event = 'PickUpIllegalItem',
                         content = ('%s อาชีพ %s ได้รับ %s จำนวน 1 ชิ้น จากการเก็บ %s'):format(xPlayer.name, xPlayer.job.name, v.getItemName, v.getItemName),
                         source = xPlayer.source,
                     }) -- End log 
                 end)
            else
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                         event = 'IllegalItemOverWeight',
                         content = ('%s อาชีพ %s ไม่สามารถได้รับ %s จำนวน 1 ชิ้น ได้เนื่องจากน้ำหนักกระเป๋าเต็ม'):format(xPlayer.name, xPlayer.job.name, v.getItemName),
                         source = xPlayer.source,
                     }) -- End log 
                 end)
                exports.nc_notify:PushNotification(source,{
                    scale = 1.0, 
                    title = 'ระบบน้ำหนัก', 
                    description = 'น้ำหนักกระเป๋าของคุณไม่เพียงพอ', 
                    type = 'warning', 
                    position = 'top', 
                    direction = 'right',
                    priority = 'medium', 
                    icon = 'inventory_max',
                    duration = 3000 
                })
            end
        end
    end
end)