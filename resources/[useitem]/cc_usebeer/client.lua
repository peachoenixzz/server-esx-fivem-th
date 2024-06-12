beerVector = {}
InZone = false
onEating = false




beerVector[1] = PolyZone:Create({ -- Land Mongkol [TOP]
    vector3(192.25999450683597, -856.25, 32.08000183105469),
    vector3(216.1300048828125, -865.489990234375, 32.06999969482422),
    vector3(201.42999267578128, -899.9000244140625, 31.79000091552734),
    vector3(183.05999755859375, -893.3800048828125, 31.7800006866455),
    vector3(180.27999877929688, -900.8099975585938, 31.70999908447265),
    vector3(172.6300048828125, -897.8900146484375, 31.70000076293945),
    vector3(178.8000030517578, -879.8900146484375, 31.82999992370605),
    vector3(183.25999450683597, -881, 31.82999992370605),
}, {
    name = "beer_zone",
    minZ = 29,
    maxZ = 40,
    debugPoly = false,
})

beerVector[2] = PolyZone:Create({ -- Land Mongkol [BOTTOM]
    vector3(163.66000366210938, -1080.9000244140625, 29.51000022888183),
    vector3(132.7400054931641, -1082.31005859375, 30.64999961853027),
    vector3(131.07000732421875, -1070.3499755859375, 29.51000022888183),
    vector3(142.1999969482422, -1041.3299560546875, 29.60000038146972),
    vector3(165.17999267578125, -1049.06005859375, 29.26000022888183),
}, {
    name = "beer_zone",
    minZ = 29,
    maxZ = 40,
    debugPoly = false,
})

beerVector[3] = PolyZone:Create({ -- Prison
    vector3(1771.9300537109375, 2570.52001953125, 45.00),
    vector3(1772.31005859375, 2599.550048828125, 45.00),
    vector3(1786.969970703125, 2599.659912109375, 45.00),
    vector3(1787.2099609375, 2570.60009765625, 45.00),
}, {
    name="beer_zone",
    minZ=-10,
    maxZ=80,
    debugPoly = false,
})

beerVector[4] = PolyZone:Create({ -- Sandy Shore
    vector3(1996.5699462890625, 3049.22998046875, 47.22000122070312),
    vector3(1992.6199951171875, 3043.090087890625, 47.22000122070312),
    vector3(1980.0999755859375, 3050.989990234375, 47.22000122070312),
    vector3(1984.02001953125, 3057.47998046875, 47.22000122070312),
}, {
    name="beer_zone",
    minZ=-10,
    maxZ=80,
    debugPoly = false,
})

beerVector[5] = PolyZone:Create({ -- Nightclub
    vector3(-1392.6300048828125, -594.6799926757812, 30.31999969482422),
    vector3(-1406.6500244140625, -603.9000244140625, 30.31999969482422),
    vector3(-1387.18994140625, -636.9099731445312, 31.77000045776367),
    vector3(-1371.0899658203125, -626.239990234375, 30.81999969482422),
}, {
    name="beer_zone",
    minZ=29,
    maxZ=40,
    debugPoly = false,
})

beerVector[6] = PolyZone:Create({ -- Los Santos [PD]
    vector3(463.8500061035156, -976.260009765625, 30.95000076293945),
    vector3(463.94000244140625, -983.5700073242188, 30.95000076293945),
    vector3(458.9700012207031, -983.5399780273438, 30.95000076293945),
    vector3(459.1000061035156, -976.22998046875, 30.95000076293945),
}, {
    name="beer_zone",
    minZ=29,
    maxZ=33,
    debugPoly = false,
})

beerVector[7] = PolyZone:Create({ -- Sandy Shore [PD]
    vector3(1852.4130, 3695.4175, 34.2670),
    vector3(1858.2346, 3698.6946, 34.2670),
    vector3(1861.1654, 3692.9949, 34.2670),
    vector3(1856.0996, 3690.0989, 34.2670),
}, {
    name="beer_zone",
    minZ=33,
    maxZ=37,
    debugPoly = false,
})

beerVector[8] = PolyZone:Create({ -- Los Santos [MD]
    vector3(328.6763, -1399.8477, 32.5118),
    vector3(321.2276, -1408.6345, 32.5118),
    vector3(309.7547, -1399.1399, 32.5118),
    vector3(316.7377, -1391.4840, 32.5118),
}, {
    name="beer_zone",
    minZ=31,
    maxZ=36,
    debugPoly = false,
})

beerVector[9] = PolyZone:Create({ -- Sandy Shore [MD]
    vector3(1827.3567, 3668.0120, 34.2924),
    vector3(1822.3322, 3665.1077, 34.2923),
    vector3(1820.7869, 3668.3010, 34.2929),
    vector3(1825.6249, 3671.1848, 34.2942),
}, {
    name="beer_zone",
    minZ=33,
    maxZ=37,
    debugPoly = false,
})



local BeerZone = ComboZone:Create(beerVector, {name="beer_zone", debugPoly=false})
BeerZone:onPlayerInOut(function(isPointInside, point, zone)
    if zone then
        if isPointInside then
            InZone = true
        else
            InZone = false    
        end
    end
end)

RegisterNetEvent('useBeer')
AddEventHandler('useBeer', function ()	
	if InZone and not IsPedInAnyVehicle(PlayerPedId(), true) then
        onEating = true
		processIcecream()
        onGoingeat()
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PlayerEatingBeer',
                content = ('ผู้เล่นกำลังกิน เบียร์'):format(),
            })
        end) -- End Log	
    end
    if not InZone then
       print("Out Zone")
       onEatingOutZone()
       pcall(function() -- Start Log
        exports['azael_dc-serverlogs']:insertData({
            event = 'PlayerOutOfBeerZone',
            content = ('ผู้เล่นพยายามจะกิน เบียร์ แต่อยู่นอกโซน'):format(),
        })
    end) -- End Log
	end
end)

function processIcecream()
    TriggerEvent("mythic_progbar:client:progress",{
        name = "useIcecream",
        duration = 30000,
        label = "กำลังกินไอติม",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "amb@world_human_drinking@coffee@male@idle_a",
            anim = "idle_c",
            flags = 49
        },
        prop = {
            model = "prop_beer_blr", --prop_icecream_tcc --prop_knife
            bone = 57005,
            coords = { x = 0.10548215012955, y = -0.11181232726006, z = -0.041101316287113 },
            rotation = { x = -79.205590064226, y = 30.504013845544, z = -7.7640740149895 },
        }
    }, function(status)
        if not status then
            if InZone then
                onEating = false
                exports.helpnotify:hideHelpNotification()
                ESX.TriggerServerCallback('cc_usebeer:checkbeer', function(success)
                    if success then
                        TriggerEvent('esx_status:remove','stress',600000)
                        pcall(function() -- Start Log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'DoneEatingBeerInZone',
                                content = ('ผู้เล่นได้กิน เบียร์ สำเร็จ'):format(),
                            })
                        end) -- End Log
                    else
                        noBeer()
                        pcall(function() -- Start Log
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'PlayerHaveNoBeer',
                                content = ('ผู้เล่นได้ทำการกินเบียร์แต่ไม่มีเบียร์ (พยายามโกงหรือเปล่านะ)'):format(),
                            })
                        end) -- End Log
                    end
                end)
            else
                onEating = false
                onDoneEatingOutZone()
                exports.helpnotify:hideHelpNotification()
                pcall(function() -- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'DoneEatingBeerOutZone',
                        content = ('ผู้เล่นได้กิน เบียร์ สำเร็จ แต่อยู่นอกโซน'):format(),
                    })
                end) -- End Log	
            end
        end
    end)
end

function onGoingeat()
    exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
    Citizen.CreateThread(function()
        while onEating do
            Citizen.Wait(0)
            if onEating then
                DisableControlAction(0,Config.Key['F1'], true)
                DisableControlAction(0,Config.Key['H'], true)
                DisableControlAction(0,Config.Key['E'], true)
                --DisableControlAction(0, 74, true) -- บล็อกสไลด์
                DisableControlAction(0, 101, true) -- บล็อกสไลด์
                DisableControlAction(0, 104, true) -- บล็อกสไลด์
                DisableControlAction(0, 304	, true) -- บล็อกสไลด์
            end
            if IsPedInAnyVehicle(PlayerPedId(), true) then
                exports.helpnotify:hideHelpNotification()
                TriggerEvent("mythic_progbar:client:cancel")
                onEating = false
            end

            if IsControlJustPressed(0,73) and onEating then
                exports.helpnotify:hideHelpNotification()
                TriggerEvent("mythic_progbar:client:cancel")
                onEating = false
                pcall(function() -- Start Log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'CancelEatingBeer',
                        content = ('ผู้เล่นได้ทำการกด X เพื่อ ยกเลิกการกินเบียร์'):format(),
                    })
                end) -- End Log	
            end
        end
    end)
end

AddEventHandler('esx:onPlayerDeath', function() 
	if onEating then
		onEating = false
        TriggerEvent("mythic_progbar:client:cancel")
        pcall(function() -- Start Log
            exports['azael_dc-serverlogs']:insertData({
                event = 'PlayerDeadWhileEatingBeer',
                content = ('ผู้เล่นได้ตาย ระหว่างการกินเบียร์'):format(),
            })
        end) -- End Log	
	end
end)

function onEatingOutZone()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบดื่มเบียร์', -- หัวเรื่อง
        description = 'คุณไม่ได้อยู่ในพื้นที่', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'block', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end


function onDoneEatingOutZone()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบดื่มเบียร์', -- หัวเรื่อง
        description = 'คุณไม่ได้อยู่ในพื้นที่', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'block', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function noBeer()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบดื่มเบียร์', -- หัวเรื่อง
        description = 'คุณไม่มีเบียร์', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end
