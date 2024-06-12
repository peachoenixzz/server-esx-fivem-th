ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local blipInfo = { --ใส่เวลาให้น้อยกว่าเวลาจริงในสคิปที่เรียกใช้มาเช่น nc_stealjobs 30 วิ ให้ใส่ในนี้ 27 วิ เป็นต้น
    drugbox1 = {
		name = "drug_box_1",
		oncooldown = false,
        time = 120000,
		coords = vector3(-50.9000015258789, -792.1300048828125, 44.22999954223633),
		Id = 209,
		Size = 0.7,
		Text = '<font face="font4thai">จุดเก็บกล่องยา</font>',
	},

	drugbox2 = {
		name = "drug_box_2",
		oncooldown = false,
        time = 120000,
		coords = vector3(-262.9100036621094, -1896.760009765625, 27.76000022888183),
		Id = 209,
		Size = 0.7,
		Text = '<font face="font4thai">จุดเก็บกล่องยา</font>',
	},
}

local resetblipInfo = { --ใส่ข้อมูลให้ตรงกับข้อมูลใน local blipInfo
    drugbox1 = {
		name = "drug_box_1",
        time = 120000,
	},

	drugbox2 = {
		name = "drug_box_2",
        time = 120000,
	},
}

RegisterNetEvent('esx:onPlayerSpawn') --playerLoaded
AddEventHandler('esx:onPlayerSpawn',function() --player, xPlayer
    TriggerClientEvent('cc_blip:updateConfigBlip', source, blipInfo) --xPlayer.source
end)

RegisterServerEvent('cc_blip:sucessStealJobs')
AddEventHandler('cc_blip:sucessStealJobs', function()
    TriggerClientEvent('cc_blip:checknearblip', source)
end)

RegisterServerEvent('cc_blip:addblipcooldown')
AddEventHandler('cc_blip:addblipcooldown', function(name)
    addCoolDown(name)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        for _,v in pairs(blipInfo) do
            if v.oncooldown then
                if v.time > 0 then
                    v.time = v.time - 60000
                else
                    removeCoolDown(v.name)
                end
            end
        end
    end
end)   

function addCoolDown(name)
    for _,v in pairs(blipInfo) do
        if v.name == name then
            v.oncooldown = true
            TriggerClientEvent('cc_blip:updateConfigBlip', -1, blipInfo)
        end
    end
end

function removeCoolDown(name)
    for _,v in pairs(resetblipInfo) do
        if v.name == name then
            for _,a in pairs(blipInfo) do
                if a.name == name then
                    a.oncooldown = false
                    a.time = v.time
                    TriggerClientEvent('cc_blip:updateConfigBlip', -1, blipInfo)
                end
            end
        end
    end
end