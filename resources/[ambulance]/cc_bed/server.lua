local playersHealing = {}
Dv_Hunter                   = GetCurrentResourceName()


RegisterNetEvent('cc_bed:getPlayerToBedHeal')
AddEventHandler('cc_bed:getPlayerToBedHeal', function(target,state)
    local xTarget = ESX.GetPlayerFromId(target)
    print("in sv",target)
    TriggerClientEvent('cc_bed:confirmPlayerToBed',xTarget.source,state)
    pcall(function() -- Start Log
		exports['azael_dc-serverlogs']:insertData({
			event = 'PlayerRestAtHospitalBed',
			content = ('%s อาชีพ %s ยศ %s ได้นำ %s ขึ้นเตียงนอนที่โรงพยาบาลและเข้ารับการรักษา'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name ,xTarget.name),
			source = xTarget.source,
		})
	end) -- End Log
end)

RegisterNetEvent('cc_bed:cancelPlayerFromBed')
AddEventHandler('cc_bed:cancelPlayerFromBed', function(target)
    local xTarget = ESX.GetPlayerFromId(target)
    print("in sv",target)
    TriggerClientEvent('cc_bed:cancelPlayerFromBed',xTarget.source)
    pcall(function() -- Start Log
		exports['azael_dc-serverlogs']:insertData({
			event = 'PlayerCheckOutOfHospitalBed',
			content = ('%s อาชีพ %s ยศ %s ได้นำ %s ลงจากเตียงนอนที่โรงพยาบาล'):format(xPlayer.name, xPlayer.job.name, xPlayer.job.grade_name ,xTarget.name),
			source = xTarget.source,
		})
	end) -- End Log
end)
