local oldDistance = 4
local onClose = false
local oldVehEnt = nil
Config = {}
Config.weaponList = {
    --thief
    weapon_crowbar = {
        name = "WEAPON_CROWBAR",
        damage = 1,
        hash = nil,
        block_instant_kill = true,
        block_hit = true,
        headshot_dead = false,
        critical_hit = false
    },
}

Config.weaponHash = {}


Citizen.CreateThread(function()
    for _,v in pairs(Config.weaponList) do
        local weaponHash = GetHashKey(v.name)
        --print(v.name)
        --print(weaponHash)
        v.hash = weaponHash
        Config.weaponHash[weaponHash] = {
            damage = v.damage,
            block_instant_kill = v.block_instant_kill,
            headshot_dead = v.headshot_dead,
            hasEffect = v.hasEffect,
            name = v.name
        }
        SetWeaponDamageModifier(weaponHash,0.0001)
        ::continue::
    end
end)

Citizen.CreateThread(function()
    local lastWeapon = nil
    while true do
        local sleep = 1500
        if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            for _,v in pairs(Config.weaponList) do
                if GetSelectedPedWeapon(GetPlayerPed(-1)) == v.hash and v.block_hit then
                    if IsControlJustPressed(0, 47) then
                        local closestVehicle, closestVehicleDistance = ESX.Game.GetClosestVehicle()
                        if closestVehicleDistance < 4.0 and closestVehicle ~= -1 then
                            oldVehEnt = closestVehicle
                            if exports.Dv_Hunter_Check:CheckPolice(4) then
                                local vehiclePlate = GetVehicleNumberPlateText(closestVehicle)
                                local vehNet = VehToNet(closestVehicle)
                                SetVehicleAlarmTimeLeft(closestVehicle, 1000 * 60 * 5)
                                TriggerEvent("Porpy_policealert:alertNet", "robvehicle")
                                local result =  exports.storerobbery:miniGameLockPick(false)
                                if result then
                                    TriggerEvent("mythic_progbar:client:progress",{
                                        name = "ongoingopen",
                                        duration = 4000,
                                        label = "กำลังเปิดร้านค้า",
                                        useWhileDead = false,
                                        canCancel = true,
                                        controlDisables = {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                        },
                                        animation = {
                                            dict = 'veh@break_in@0h@p_m_one@',
                                            anim = 'low_force_entry_ds',
                                            flag = 49
                                        },
                                    }, function(status)
                                        if not status then
                                            ESX.TriggerServerCallback("cc_damage:vehicleRob", function()
                                                onClose = true
                                            end,vehNet,vehiclePlate)
                                        end
                                    end)
                                end
                                if not result then
                                    TriggerEvent("Porpy_policealert:alertNet", "robvehicle")
                                end
                            end
                            if not exports.Dv_Hunter_Check:CheckPolice(4) then
                                exports.nc_notify:PushNotification({
                                    scale = 1.0, -- ปรับขนาดของ Notify
                                    title = 'ระบบงัดรถ', -- หัวเรื่อง
                                    description = 'ตำรวจไม่เพียงพอ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
                                    type = 'error',
                                    position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
                                    direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
                                    priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
                                    icon = 'jail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
                                    duration = 3000 -- ระยะเวลาการแสดง Notify
                                })
                            end
                        end
                    end
                    if oldVehEnt ~= nil and oldDistance <= 4 and onClose then
                        local coords = GetEntityCoords(PlayerPedId())
                        local vehiclecoords = GetEntityCoords(oldVehEnt)
                        local vehDistance = GetDistanceBetweenCoords(coords, vehiclecoords, true)
                        --print(vehDistance)
                        if vehDistance > oldDistance then
                            exports.nc_inventory:CloseInventory()
                            onClose = false
                            oldVehEnt = nil
                        end
                    end
                    sleep = 0
                end
            end
        end
        lastWeapon = GetSelectedPedWeapon(GetPlayerPed(-1))
        Citizen.Wait(sleep)
    end
end)