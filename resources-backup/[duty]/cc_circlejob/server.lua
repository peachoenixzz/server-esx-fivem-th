-- server/main.lua

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('cc_circlejob:buyJobVehicle', function(source, cb, vehicleProps, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)
    -- For Log Purpose
    local playerped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerped)
    -- End Log

    -- vehicle model not found
    if price == 0 then
        print(('[^3WARNING^7] Player ^5%s^7 Attempted To Buy Invalid Vehicle - ^5%s^7!'):format(source, vehicleProps.model))
        cb(false)
    else
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price, "Job Vehicle Bought")
            pcall(function() -- Start Log ยังไม่เสร็จ
                exports['azael_dc-serverlogs']:insertData({
                    event = 'CircleBuyVehicle',
                    content = ('%s อาชีพ %s ยศ %s ได้ทำการซื้อรถของหน่วยงาน %s ทะเบียน %s สูญเสียเงินจำนวน $%s เหลือเงินในกระเป๋าจำนวน $%s : พิกัด %s'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name, vehicleProps.model, vehicleProps.plate, price, ESX.Math.GroupDigits(xPlayer.getMoney()), playerCoords),
                    source = xPlayer.source,
                })
            end) -- End Log

            MySQL.insert('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (?, ?, ?, ?, ?, ?)', { xPlayer.identifier, json.encode(vehicleProps), vehicleProps.plate, type, xPlayer.job.name, true},
                    function (rowsChanged)
                        exports.nc_vehiclekey:ReloadVehicleKey(vehicleProps.plate)
                        cb(true)
                    end)
        else
            cb(false)
        end
    end
end)


function getPriceFromHash(vehicleHash, jobGrade, type)
    local vehicles = Config.AuthorizedVehicles[type][jobGrade]

    for i = 1, #vehicles do
        local vehicle = vehicles[i]
        if GetHashKey(vehicle.model) == vehicleHash then
            return vehicle.price
        end
    end

    return 0
end