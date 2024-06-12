ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local blipInfo = { --ใส่เวลาให้น้อยกว่าเวลาจริงในสคิปที่เรียกใช้มาเช่น nc_stealjobs 30 วิ ให้ใส่ในนี้ 27 วิ เป็นต้น
    drugbox1 = {
		name = "drug_box_1",
		oncooldown = false,
        time = 720000,
		coords = vector3(-50.9000015258789, -792.1300048828125, 44.22999954223633),
		Id = 209,
		Size = 0.7,
		Text = '<font face="font4thai">จุดเก็บกล่องยา</font>',
	},

	drugbox2 = {
		name = "drug_box_2",
		oncooldown = false,
        time = 720000,
		coords = vector3(-262.9100036621094, -1896.760009765625, 27.76000022888183),
		Id = 209,
		Size = 0.7,
		Text = '<font face="font4thai">จุดเก็บกล่องยา</font>',
	},

    searchbin1 = {
        name = "search_bin_1",
        oncooldown = false,
        time = 420000,
        coords = vector3(1183.0666, -1550.77087, 38.59073),
		Id = 88,
		Size = 0.6,
		Text = '<font face="font4thai">คุ้ยขยะ</font>',
	},

	searchbin2 = {
        name = "search_bin_2",
        oncooldown = false,
        time = 420000,
        coords = vector3(-458.2000, -2700.9199, 6.0700),
		Id = 88,
		Size = 0.6,
		Text = '<font face="font4thai">คุ้ยขยะ</font>',
	},

	searchbin3 = {
        name = "search_bin_3",
        oncooldown = false,
        time = 420000,
        coords = vector3(-1350.65442, -1434.5531, 3.31112),
		Id = 88,
		Size = 0.6,
		Text = '<font face="font4thai">คุ้ยขยะ</font>',
	},

	searchbin4 = {
        name = "search_bin_4",
        oncooldown = false,
        time = 420000,
        coords = vector3(-1656.36426, 85.05298, 62.8122635),
		Id = 88,
		Size = 0.6,
		Text = '<font face="font4thai">คุ้ยขยะ</font>',
	},

	searchbin5 = {
        name = "search_bin_5",
        oncooldown = false,
        time = 420000,
        coords = vector3(688.7509, 238.634888, 92.4905853),
		Id = 88,
		Size = 0.6,
		Text = '<font face="font4thai">คุ้ยขยะ</font>',
	},

    Store1 = {
        name = "store_1",
        oncooldown = false,
        time = 1620000,
        coords = vector3(-49.20000076293945, -1756.5799560546875, 29.42000007629394),
		Id = 120,
		Size = 0.5,
		Text = '<font face="font4thai">งัดร้าน</font>',
	},

	Store2 = {
        name = "store_2",
        oncooldown = false,
        time = 1620000,
        coords = vector3(26.92000007629394, -1346.5799560546875, 29.5),
		Id = 120,
		Size = 0.5,
		Text = '<font face="font4thai">งัดร้าน</font>',
	},

	Store3 = {
        name = "store_3",
        oncooldown = false,
        time = 1620000,
        coords = vector3(375.7699890136719, 326.3800048828125, 103.56999969482422),
		Id = 120,
		Size = 0.5,
		Text = '<font face="font4thai">งัดร้าน</font>',
	},

	Store4 = {
        name = "store_4",
        oncooldown = false,
        time = 1620000,
        coords = vector3(-1223.6400146484375, -906.6300048828124, 12.32999992370605),
		Id = 120,
		Size = 0.5,
		Text = '<font face="font4thai">งัดร้าน</font>',
	},

	Store5 = {
        name = "store_5",
        oncooldown = false,
        time = 1620000,
        coords = vector3(-1488.5, -381.55999755859375, 40.15999984741211),
		Id = 120,
		Size = 0.5,
		Text = '<font face="font4thai">งัดร้าน</font>',
	},

	Store6 = {
        name = "store_6",
        oncooldown = false,
        time = 1620000,
        coords = vector3(1135.80, -982.28, 46.42),
		Id = 120,
		Size = 0.5,
		Text = '<font face="font4thai">งัดร้าน</font>',
	},

	Store7 = {
        name = "store_7",
        oncooldown = false,
        time = 1620000,
        coords = vector3(1163.47, -324.00, 69.21),
		Id = 120,
		Size = 0.5,
		Text = '<font face="font4thai">งัดร้าน</font>',
	},

	Store8 = {
        name = "store_8",
        oncooldown = false,
        time = 1620000,
        coords = vector3(-707.42, -914.61, 19.22),
		Id = 120,
		Size = 0.5,
		Text = '<font face="font4thai">งัดร้าน</font>',
	},

    Supermarket = {
        name = "super_market",
        oncooldown = false,
        time = 3420000,
        coords = vector3(-244.07000732421875, -229.27999877929688, 36.52000045776367),
		Id = 211,
		Size = 0.8,
		Text = '<font face="font4thai">งัดคลังสินค้า</font>',
	},

    Evidence1 = {
        name = "evidence_1",
        oncooldown = false,
        time = 1020000,
        coords = vector3(-1612.6084, 185.5922, 59.7817),
		Id = 176,
		Size = 0.6,
		Text = '<font face="font4thai">ขโมยของกลาง</font>',
	},
    
    Evidence2 = {
        name = "evidence_2",
        oncooldown = false,
        time = 1020000,
        coords = vector3(-959.6763, -2598.0457, 13.8480),
		Id = 176,
		Size = 0.6,
		Text = '<font face="font4thai">ขโมยของกลาง</font>',
	},

    Evidence3 = {
        name = "evidence_3",
        oncooldown = false,
        time = 1020000,
        coords = vector3(1014.6783, -2328.8157, 30.5095),
		Id = 176,
		Size = 0.6,
		Text = '<font face="font4thai">ขโมยของกลาง</font>',
	},

    Evidence4 = {
        name = "evidence_4",
        oncooldown = false,
        time = 1020000,
        coords = vector3(931.2582, 42.4679, 81.0958),
		Id = 176,
		Size = 0.6,
		Text = '<font face="font4thai">ขโมยของกลาง</font>',
	},

    Evidence5 = {
        name = "evidence_5",
        oncooldown = false,
        time = 1020000,
        coords = vector3(-1024.1832, -490.7098, 36.9643),
		Id = 176,
		Size = 0.6,
		Text = '<font face="font4thai">ขโมยของกลาง</font>',
	},
}

local resetblipInfo = { --ใส่ข้อมูลให้ตรงกับข้อมูลใน local blipInfo
    drugbox1 = {
		name = "drug_box_1",
        time = 720000,
	},

	drugbox2 = {
		name = "drug_box_2",
        time = 720000,
	},

    searchbin1 = {
        name = "search_bin_1",
        time = 420000,
	},

	searchbin2 = {
        name = "search_bin_2",
        time = 420000,
	},

	searchbin3 = {
        name = "search_bin_3",
        time = 420000,
	},

	searchbin4 = {
        name = "search_bin_4",
        time = 420000,
	},

	searchbin5 = {
        name = "search_bin_5",
        time = 420000,
	},

    Store1 = {
        name = "store_1",
        time = 1620000,
	},

	Store2 = {
        name = "store_2",
        time = 1620000,
	},

	Store3 = {
        name = "store_3",
        time = 1620000,
	},

	Store4 = {
        name = "store_4",
        time = 1620000,
	},

	Store5 = {
        name = "store_5",
        time = 1620000,
	},

	Store6 = {
        name = "store_6",
        time = 1620000,
	},

	Store7 = {
        name = "store_7",
        time = 1620000,
	},

	Store8 = {
        name = "store_8",
        time = 1620000,
	},

    Supermarket = {
        name = "super_market",
        time = 3420000,
	},

    Evidence1 = {
        name = "evidence_1",
        time = 1020000,
	},

    Evidence2 = {
        name = "evidence_2",
        time =1020000,
	},

    Evidence3 = {
        name = "evidence_3",
        time = 1020000,
	},

    Evidence4 = {
        name = "evidence_4",
        time = 1020000,
	},

    Evidence5 = {
        name = "evidence_5",
        time = 1020000,
	},
}

AddEventHandler('onResourceStart', function(resource)
    if (GetCurrentResourceName() ~= resource) then
        return
    end
    Wait(5000)
    for _, xPlayer in pairs(ESX.GetExtendedPlayers()) do
        TriggerClientEvent('cc_blip:updateConfigBlip', xPlayer.source, blipInfo)
    end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(player, xPlayer)
    TriggerClientEvent('cc_blip:updateConfigBlip', xPlayer.source, blipInfo)
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
                    if name == "super_market" then
                        local template =
                        [[
                            <div style="padding: 7px; margin-bottom: 8px; background-image: linear-gradient(to right, rgba(0, 155, 0, 0.7), rgba(0, 255, 0, 0.5)); border-radius: 7px; width: 605px; display: flex; align-items: center; font-size: 18px;"/>
                            <img src="https://img5.pic.in.th/file/secure-sv1/box-271d0604b8c315acd.png" style="width: 20px; height: 20px; padding-right: 7px; padding-left: 7px;" />{0}: {1}
                            <br></div>
                        ]]
                        local msg = " คลังสินค้ากำลังจะพร้อมงัดเร็วๆนี้"
                        local fal = ' งัดคลังสินค้า '
                        TriggerClientEvent('chat:addMessage', -1, {
                            template = template,
                            args = { fal, msg }
                        })
                    end
                end
            end
        end
    end
end