local propConfig = {
    --{ position = vector3(-398.2099914550781, 1094.9000244140625, 327.80999755859375), propName = 'prop_vend_snak_01', heading = 256.0},
    --{ position = vector3(178.4499969482422, -1003.739990234375, 29.32999992370605), propName = 'prop_vend_snak_01', heading = 340.0}
    --{ position = vector3(-406.5550, 1090.6233, 327.6006), propName = 'prop_vend_snak_01', heading = 160.0} -- do more prop
}
local propList = {}
Citizen.CreateThread(function()
    while ESX == nil do
        Wait(6)
    end
    for _,v in pairs(propConfig) do
        local obj = nil
        ESX.Game.SpawnLocalObject(v.propName, v.position, function(object)
            table.insert(propList, object)
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        for _, v in pairs(propConfig) do
            local dist = GetDistanceBetweenCoords(pos, v.position)
            if dist <= 50.0 then
                for _,prop in pairs(propList) do
                    FreezeEntityPosition(prop, true)
                    PlaceObjectOnGroundProperly(prop)
                    SetEntityHeading(prop, v.heading)
                end
            end
        end
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() ~= resource then return end
    for _,v in pairs(propList) do
        DeleteEntity(v)
    end
end)
