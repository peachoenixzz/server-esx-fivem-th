
Citizen.CreateThread(function()    
    for _,v in pairs(Config.AllBlip) do

        local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)

        SetBlipSprite(blip, v.Id)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, v.Size)
        SetBlipColour (blip, v.Colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.Text)
        EndTextCommandSetBlipName(blip)
    end

    for _,v in pairs(Config.BlipZone) do

        local blipzone = AddBlipForRadius(v.Pos.x, v.Pos.y, v.Pos.z, v.Size) 

        SetBlipHighDetail(blipzone, true)
	    SetBlipColour(blipzone, v.Colour)
	    SetBlipAlpha(blipzone, 128)
    end

    ReplaceHudColourWithRgba( -- waypoint color
		142, -- ID ขอสิ่งที่จะใส่สี 142 คือ Waypoint แนะนำว่าอย่าไปยุ่งกับมัน
		255, -- R
		0, -- G
		0, -- B
		255 -- A
	)

    SetDeepOceanScaler(0.0)
    
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local clientBlipInfo = {}
local advanceBlip = {}

RegisterNetEvent('cc_blip:updateConfigBlip')
AddEventHandler('cc_blip:updateConfigBlip', function(blipInfo)
    --print("here")
    clientBlipInfo = blipInfo
    Wait(1000)
    -- for _,v in pairs(clientBlipInfo) do
    --     if v.oncooldown then
    --         print(v.name..": cooldown : "..v.time)
    --     end
    --     if not v.oncooldown then
    --         print(v.name..": not cooldown : "..v.time)
    --     end
    -- end
    createadvanceBlip()
end)

RegisterNetEvent('cc_blip:checknearblip')
AddEventHandler('cc_blip:checknearblip', function()
    local coords = GetEntityCoords(PlayerPedId())
    for _,v in pairs(clientBlipInfo) do
        if(GetDistanceBetweenCoords(coords, v.coords, false) < 5) then
            print(v.name)
            TriggerServerEvent('cc_blip:addblipcooldown', v.name)
        end
    end
end)

function createadvanceBlip()
    for _, blip in pairs(advanceBlip) do
        RemoveBlip(blip)
    end

    advanceBlip = {}

    for _,v in pairs(clientBlipInfo) do
        if not v.oncooldown then
            local blip = AddBlipForCoord(v.coords)

            SetBlipSprite(blip, v.Id)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, v.Size)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.Text)
            EndTextCommandSetBlipName(blip)
            
            table.insert(advanceBlip, blip)
        end
    end
end

