ESX            = nil
TradeCarVector = {}
reSkinVector = {}
t1weaponVector = {}
local InZoneTrade = false
local InZoneReSkin = false
local InZoneGiveT1Weapon = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
end)

TradeCarVector[1] = PolyZone:Create({
    vector3(-566.3900, -891.5700, 24.9400),
    vector3(-541.4199, -891.3300, 24.7700),
    vector3(-541.0964, -910.2899, 23.8616),
    vector3(-566.3699, -910.5, 23.8799),
}, {
    name="trade_car_zone",
    minZ = 20,
    maxZ = 30,
    debugPoly = false,
})

TradeCarVector[2] = PolyZone:Create({
    vector3(-474.1799926757813, 1116.0799560546875, 327.80999755859375),
    vector3(-458.3900146484375, 1111.81005859375, 327.80999755859375),
    vector3(-463.3500061035156, 1093.300048828125, 327.80999755859375),
    vector3(-479.2799987792969, 1097.52001953125, 327.80999755859375),
}, {
    name="trade_car_zone2",
    minZ = 326,
    maxZ = 330,
    debugPoly = false,
})


local tradeZone = ComboZone:Create(TradeCarVector, {name="trade_car_zone", debugPoly=false})
tradeZone:onPlayerInOut(function(isPointInside, point, zone)
    if zone then
        if isPointInside then
            InZoneTrade = true
        else
            InZoneTrade = false
        end
    end
end, 1500)

function checkZoneTradeCar()
    return InZoneTrade
end

function checkZoneReSkin()
    return InZoneReSkin
end

function checkZoneGiveT1Weapon()
    return InZoneGiveT1Weapon
end

----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

reSkinVector[1] = PolyZone:Create({
    vector3(379.989990234375, -1398.4599609375, 32.5099983215332),
    vector3(377.5899963378906, -1401.4100341796875, 32.5099983215332),
    vector3(379.1099853515625, -1402.9300537109375, 32.5099983215332),
    vector3(381.8200073242188, -1400.3199462890625, 32.5099983215332),
}, {
    name="reskin_zone",
    minZ = 20,
    maxZ = 36,
    debugPoly = false,
})

-- reSkinVector[2] = PolyZone:Create({
--     vector3(-474.7099914550781, 1083.1199951171875, 327.2699890136719),
--     vector3(-474.0700073242188, 1085.52001953125, 327.2699890136719),
--     vector3(-475.6300048828125, 1085.949951171875, 327.2699890136719),
--     vector3(-476.3800048828125, 1083.5699462890625, 327.2699890136719),
-- }, {
--     name="reskin_zone",
--     minZ = 327,
--     maxZ = 331,
--     debugPoly = false,
-- })


local skinZone = ComboZone:Create(reSkinVector, {name="reskin_zone", debugPoly=false})
skinZone:onPlayerInOut(function(isPointInside, point, zone)
    if zone then
        if isPointInside then
            InZoneReSkin = true
        else
            InZoneReSkin = false
        end
    end
end, 1500)

----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

t1weaponVector[1] = PolyZone:Create({
    vector3(-424.8900146484375, 1042.719970703125, 327.2200012207031),
    vector3(-431.80999755859375, 1033.93994140625, 327.1700134277344),
    vector3(-441.7999877929688, 1029.300048828125, 327.6300048828125),
    vector3(-453.3399963378906, 1032.3199462890625, 327.6300048828125),
    vector3(-460.2300109863281, 1041.780029296875, 327.3900146484375),
    vector3(-461.3299865722656, 1052.47998046875, 327.239990234375),
}, {
    name="givet1weapon_zone",
    minZ = 326,
    maxZ = 330,
    debugPoly = false,
})




local givet1weaponZone = ComboZone:Create(t1weaponVector, {name="givet1weapon_zone", debugPoly=false})
givet1weaponZone:onPlayerInOut(function(isPointInside, point, zone)
    if zone then
        if isPointInside then
            InZoneGiveT1Weapon = true
            --print(InZoneGiveT1Weapon)
        else
            InZoneGiveT1Weapon = false
            --print(InZoneGiveT1Weapon)
        end
    end
end, 1500)




