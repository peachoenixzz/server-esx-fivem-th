scriptName = GetCurrentResourceName()

ESX			    		= nil
local ScriptEntity      = {}
local CrateData         = {}
local onGoingPickMiniAirdrop = false
local nearMiniAirDrop = false
local positionObj = {}

Key 					= {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
    ESX.PlayerData = ESX.GetPlayerData()
    ScriptWork()
end)

RegisterNetEvent(scriptName..':LoadCrateData')
AddEventHandler(scriptName..':LoadCrateData', function(data)
    CrateData = data
end)

function ScriptWork()

    AddEventHandler('onResourceStop', function(resource)
        if resource == GetCurrentResourceName() then
            for k,v in pairs(ScriptEntity) do
                DeleteEntity(v)
            end
            for _,v in pairs(positionObj) do
                RemoveBlip(v)
            end
            positionObj = {}
        end
    end)

    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        ESX.PlayerData = xPlayer
    end)

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        ESX.PlayerData.job = job
    end)
    
    Citizen.CreateThread(function()	
        Citizen.Wait(1000)
        RegisterFontFile("font4thai") 
        custom_font = RegisterFontId("font4thai")
    end)
    
    function LoadModel(model)
        while not HasModelLoaded(model) do
              RequestModel(model)
              Citizen.Wait(10)
        end
    end
    
    function LoadAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do
            RequestAnimDict(dict)
            Citizen.Wait(0)
        end
    end
    
    function DrawText3D(x,y,z, text,mul)
        local onScreen,_x,_y=World3dToScreen2d(x,y,z)
        local px,py,pz=table.unpack(GetGameplayCamCoords())
        local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
        local fontId = custom_font
        local scale = (1/dist)*2
        local fov = (1/GetGameplayCamFov())*100
        local scale = scale*fov *mul
        if onScreen then
            SetTextScale(0.0*scale, 0.55*scale)
            SetTextFont(fontId)
            SetTextProportional(1)
            SetTextColour(255, 255, 255, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(2, 0, 0, 0, 150)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x,_y)
        end
    end
    
    function MakeEntityFaceCoord(entity1, Coord)
        local p1 = GetEntityCoords(entity1, true)
        local p2 = Coord
        local dx = p2.x - p1.x
        local dy = p2.y - p1.y
        local heading = GetHeadingFromVector_2d(dx, dy)
        SetEntityHeading( entity1, heading )
    end

    RegisterNetEvent(scriptName..':UpdateCrateData')
    AddEventHandler(scriptName..':UpdateCrateData', function(id,data)
        CrateData[id] = data
        createBlipMiniAirDrop()
    end)

    function createBlipMiniAirDrop()
        Citizen.CreateThread(function()
            for k,v in pairs(CrateData) do 
                if positionObj[k] == nil then
                    local blip = AddBlipForCoord(v.coords)
                    positionObj[k] = blip
                    SetBlipSprite(blip , 94)
                    SetBlipDisplay(blip, 4)
                    SetBlipScale(blip ,1.0)
                    SetBlipAsShortRange(blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString('<font face="font4thai">Halloween Airdrop</font>')
                    EndTextCommandSetBlipName(blip)
                end
            end
        end)
    end

    Citizen.CreateThread(function()
        while true do
            Sleep = 1000
            local Ped = PlayerPedId()
            local PedCoords = GetEntityCoords(Ped)
            for k,v in pairs(CrateData) do
                local Dis = GetDistanceBetweenCoords(PedCoords, v.coords, true)
                if Dis < v.data.showdis then
                    if not v.Entity then
                        LoadModel(v.data.prop)
                        v.Entity = CreateObject(GetHashKey(v.data.prop), v.coords.x,v.coords.y,v.coords.z, false, false, false)
                        PlaceObjectOnGroundProperly(v.Entity)
                        FreezeEntityPosition(v.Entity, true)
                        SetEntityHeading(v.Entity, tonumber(""..math.random(1,360)..".0"))
                        table.insert(ScriptEntity, v.Entity)
                    else
                        if not GetBox then
                            if not v.data["blacklistjob"][ESX.PlayerData.job.name] then
                                if Dis >= v.data.propsize and Dis <= v.data.propsize+4 then
                                    Sleep = 0
                                    DrawText3D(v.coords.x,v.coords.y,v.coords.z, "~m~ กด [E] เพื่อเก็บ", 1.0)
                                end
                                if Dis <= v.data.propsize then
                                    Sleep = 0
                                    DrawText3D(v.coords.x,v.coords.y,v.coords.z, "กด ~b~[E]~w~ เพื่อเก็บ", 1.0)
                                    if IsDisabledControlJustReleased(0, 38) then
                                        onGoingPickMiniAirdrop = true
                                        ColletBox(v.coords, k, v.data)
                                        ongoingColletBox()
                                    end
                                end
                            end
                        end
                    end
                else
                    if v.Entity then
                        DeleteEntity(v.Entity)
                        v.Entity = nil
                    end
                end

            end
            Citizen.Wait(Sleep)
        end
    end)


    function ColletBox(BoxCoord,code,data)
        MakeEntityFaceCoord(PlayerPedId(), BoxCoord)
        TriggerEvent("mythic_progbar:client:progress",{
            name = "MiniAirDrop",
            duration = 120000,
            label = "เก็บแอร์ดรอป",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = data["anime"][1], -- ท่าทางเวลาขุด
                anim = data["anime"][2],		-- ท่าทางเวลาขุด
                flags = 49,
            },
        }, function(status)
            if not status then
                onGoingPickMiniAirdrop = false
                exports.helpnotify:hideHelpNotification()
                TriggerServerEvent(scriptName..':GetCrate', code)
            end
        end)
    end

    function ongoingColletBox()
        exports.helpnotify:showHelpNotification("กด","X","เพื่อยกเลิก")
        Citizen.CreateThread(function()
            while onGoingPickMiniAirdrop do
                Citizen.Wait(0)
                if onGoingPickMiniAirdrop then
                    DisableControlAction(0, Key['G'], true)
                    DisableControlAction(0, Key['T'], true)
                    DisableControlAction(0, Key['H'], true)
                    DisableControlAction(0, Key['F'], true)
                    EnableControlAction(0, Key['E'], true)
                    EnableControlAction(0, Key['DELETE'], true)
                    EnableControlAction(0, Key['F2'], true)
                    EnableControlAction(0, Key['X'], true)
                end
    
                if IsControlJustPressed(0,73) and onGoingPickMiniAirdrop then
                    TriggerEvent("mythic_progbar:client:cancel")
                    exports.helpnotify:hideHelpNotification()
                    onGoingPickMiniAirdrop = false
                end
    
                if IsPedInAnyVehicle(PlayerPedId(), true) then
                    TriggerEvent("mythic_progbar:client:cancel")
                    exports.helpnotify:hideHelpNotification()
                    onGoingPickMiniAirdrop = false
                end
            end
        end)
    end

    RegisterNetEvent(scriptName..':DeleteCrate')
    AddEventHandler(scriptName..':DeleteCrate', function(code)
        if GetBox then
            if GetBox == code then
                GetBox = nil
                ClearPedTasks(PlayerPedId())
                FreezeEntityPosition(PlayerPedId(), false)
            end
        end
        if CrateData[code] then
            RemoveBlip(positionObj[code])
            DeleteEntity(CrateData[code].Entity)
            CrateData[code] = nil
            positionObj[code] = nil
        end
    end)

end

AddEventHandler('esx:onPlayerDeath', function() 
	if onGoingPickMiniAirdrop then
		onGoingPickMiniAirdrop = false
        exports.helpnotify:hideHelpNotification()
		TriggerEvent("mythic_progbar:client:cancel")
	end
end)