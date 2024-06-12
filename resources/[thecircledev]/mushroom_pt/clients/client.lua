
ScriptName = GetCurrentResourceName()
PropList = {}
PosList = {}
CurrentPartyId = nil
CurrentPartyIdProcess = nil
InZone = false
InZonePro = false
OnCreateParty = false
GetCount = 0
TEXT3D = {}
Zone = {}
ZonePro = {}
local lastCreate
cancreate = true

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

Zone[1] = PolyZone:Create({
    vector3(-719.4861, 5767.273, 17.77699),
    vector3(-685.9171, 5841.583, 17.32975),
    vector3(-657.4886, 5818.716, 17.32539),
    vector3(-684.9733, 5748.236, 17.78975),
    vector3(-720.2365, 5765.089, 17.78975)
}, {
    name="mushroom",
    minZ=15.0,
    maxZ=19.0,
    debugPoly = true,
})

local FarmZone = ComboZone:Create(Zone, {name="mushroom", debugPoly=true})
FarmZone:onPlayerInOut(function(isPointInside, point, zone)
    if zone then
        if isPointInside then
            print("inzone true")
            InZone = true
        else
            print("inzone false")
            InZone = false
        end
    end
end, 500)

ZonePro[1] = PolyZone:Create({
    vector3(-2006.098, 4702.106, 10.45258),
    vector3(1363.9, 4243.188, 34.05257),
    vector3(1681.76, 5229.805, 144.9503),
    vector3(2474.468, 5478.985, 47.55066),
    vector3(1806.33, 6321.872, 52.41258),
    vector3(266.1905, 6430.586, 55.47258),
}, {
    name="mushroompro",
    minZ=-10.0,
    maxZ=1000.0,
    debugPoly = false,
})

local ProZone = ComboZone:Create(ZonePro, {name="mushroompro", debugPoly=true})
ProZone:onPlayerInOut(function(isPointInside, point, zone)
    if zone then
        if isPointInside then
            InZonePro = true
        else
            InZonePro = false
        end
    end
end, 500)



--AddEventHandler("what_core:ClearMemoryCl", function()
--	Citizen.CreateThread(function()
--		local rdm = math.random(100, 2000)
--		Wait(rdm)
--		collectgarbage()
--	end)
--end)
--



function RemovePickup(obj, blip)
    ESX.Game.DeleteObject(obj)
    RemoveBlip(blip)
    if TEXT3D[obj] then
        --exports['what_text3d']:WHAT_HIDETEXT()
        TEXT3D[obj] = false
    end
end

function  AnimateProcess()
    local dict = "anim@amb@business@coc@coc_unpack_cut_left@"
    local anim = "cut_cough_coccutter"
    local flag = 30

    ESX.Streaming.RequestAnimDict(dict, function()
        TaskPlayAnim(GetPlayerPed(-1), dict, anim, 8.0, -8.0, Config.TimeProccess + 100, 0, 0, false, false, false)
    end)
end


function CreatePickUp(obj, Coords, blip)
    CreateThread(function()
        local selfpickupid = CurrentPartyId
        while true do
            ::start::
            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to ~g~Economy")
            print(TEXT3D[obj])
            Wait(0)

            if not CurrentPartyId  then
                RemovePickup(obj, blip)
                break
            end

            if selfpickupid ~= CurrentPartyId then
                RemovePickup(obj, blip)
                break
            end

            local Ped = PlayerPedId()
            local PlayerCoords = GetEntityCoords(Ped)

            local Checkcoord = GetDistanceBetweenCoords(PlayerCoords, Coords)


            if Checkcoord > 10 then Wait(300) goto start end

            if Checkcoord > 2 then

                if TEXT3D[obj] then
                    --exports['what_text3d']:WHAT_HIDETEXT()
                    TEXT3D[obj] = false
                end

                goto start
            end

            if not IsPedOnFoot(PlayerPedId()) then
                goto start
            end

            if not TEXT3D[obj] then
                --exports['what_text3d']:WHAT_TEXT3D('to get item!', 'E')
                ESX.ShowNotification('~g~No Knife')
                TEXT3D[obj] = true
            end

            if IsControlJustPressed(0, 38) then
                --exports['what_text3d']:WHAT_HIDETEXT()
                --TEXT3D[obj] = false
                success = false
                local dict = "anim@amb@business@coc@coc_unpack_cut_left@"
                local anim = "cut_cough_coccutter"
                local flag = 30

                ESX.Streaming.RequestAnimDict(dict, function()
                    TaskPlayAnim(GetPlayerPed(-1), dict, anim, 8.0, -8.0, Config.TimeGet + 100, 0, 0, false, false, false)
                end)

                TriggerEvent("mythic_progbar:client:progress", {
                    name = "crafting",
                    duration = Config.TimeGet,
                    label = '',
                    useWhileDead = false,
                    canCancel = true,
                    controlDisables = {
                        disableMovement = false,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true
                    }
                }, function(status)
                    if not status then
                        TriggerServerEvent(ScriptName..":GetItem", CurrentPartyId)
                        ESX.Game.DeleteObject(obj)
                        RemoveBlip(blip)
                        GetCount = GetCount +1
                        success = true
                    end
                end)

                Wait(Config.TimeGet + 1000)

                if GetCount >= Config.MaxSpawn then
                    TriggerServerEvent(ScriptName..":LeftParty")
                    break
                end

                if success then
                    break
                end

            end
        end
    end)
end

function  RemoveProcess(obj)
    ESX.Game.DeleteObject(obj)
    if TEXT3D[obj] then
        --exports['what_text3d']:WHAT_HIDETEXT()
        TEXT3D[obj] = false
    end
end

function CreateProcess(obj, Coords, owner)
    CreateThread(function()
        local safeprocessid = CurrentPartyIdProcess
        while true do
            ::start::
            Wait(0)


            if not CurrentPartyIdProcess then
                RemoveProcess(obj)
                break
            end


            if safeprocessid ~= CurrentPartyIdProcess then
                RemoveProcess(obj)
                break
            end

            local Ped = PlayerPedId()
            local PlayerCoords = GetEntityCoords(Ped)

            local Checkcoord = GetDistanceBetweenCoords(PlayerCoords, Coords)

            if Checkcoord > 10 then Wait(300) goto start end

            if GetPlayerServerId(PlayerId()) == owner then
                ESX.Game.Utils.DrawText3D(Coords, "Press F to pickup table", 0.7)

                if IsControlJustPressed(0, 49)  then
                    --exports['what_text3d']:WHAT_HIDETEXT()
                    TEXT3D[obj] = false
                    Wait(1000)
                    AnimateTable()

                    Wait(1000)
                    ESX.Game.DeleteObject(obj)
                    TriggerServerEvent(ScriptName..":pickup:process", CurrentPartyIdProcess)
                    Wait(1000)
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent(ScriptName..":CancelParty:Process:sv", CurrentPartyIdProcess)
                    break;
                end
            end

            if Checkcoord > 3 then

                if TEXT3D[obj] then
                    --exports['what_text3d']:WHAT_HIDETEXT()
                    TEXT3D[obj] = false
                end

                goto start
            end

            print("to process item E")
            --exports['what_text3d']:WHAT_TEXT3D('to process item!', 'E')
            TEXT3D[obj] = true

            if IsControlJustPressed(0, 38) then
                --exports['what_text3d']:WHAT_HIDETEXT()
                TEXT3D[obj] = false


                if not CheckItem(Config.Item[1], Config.Item[2]) then
                    local showAlert = 'Need'
                    showAlert = showAlert.. ' '.. GetLabelItems(Config.Item[1]) ..' '.. Config.Item[2]
					--exports['what_notify']:MsgNotification({
					--	msg = showAlert,
					--	type = 2,
					--	wait = 5,
					--})

                    Wait(1000)
                    goto start
                end

                AnimateProcess()

                local dx =  Coords.x - PlayerCoords.x
                local dy =  Coords.y - PlayerCoords.y
                local heading = GetHeadingFromVector_2d(dx, dy)

                SetEntityHeading(PlayerPedId(), heading)

                TriggerEvent("mythic_progbar:client:progress", {
                    name = "Process",
                    duration = Config.TimeProccess or 3000,
                    useWhileDead = false,
                    canCancel = true,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = false,
                        disableMouse = false,
                        disableCombat = false
                    }
                }, function(status)
                    if not status then
                      TriggerServerEvent(ScriptName..":ProcessItem", CurrentPartyIdProcess)
                    end
                end)

                Wait(Config.TimeProccess)
            end
        end
    end)
end


function CreateProp(Coords, process, Heading, owner)
    if CurrentPartyId and not process then
        local modelHash = GetHashKey(Config.Prop.PickUp)

        if not HasModelLoaded(modelHash) then
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Citizen.Wait(1)
            end
        end

        --local obj = CreateObject(modelHash, vector3(Coords.x, Coords.y, Coords.z - 0.97), false)

        local obj = CreatePed(8,GetHashKey('ig_orleans'), vector3(Coords.x, Coords.y, Coords.z - 0.97), 0.0, false, false)
        --Citizen.Wait(1000)
        TaskSmartFleePed(Animal, Ped, 12000.0, -1, false, false)
        -- PlaceObjectOnGroundProperly(obj)
        --FreezeEntityPosition(obj, true)
        table.insert(PropList, obj)

        local blip = AddBlipForCoord(Coords.x, Coords.y, Coords.z)

        SetBlipSprite (blip, Config.Blip.Sprite or 0)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, ESX.Math.Round(Config.Blip.Size, 2) or 1.0)
        SetBlipColour (blip, Config.Blip.Color or 0)
        SetBlipAsShortRange(blip, true)
        AddTextEntry("blip", Config.Blip.Text or "None")
        BeginTextCommandSetBlipName("blip")
        EndTextCommandSetBlipName(blip)

        CreatePickUp(obj, Coords, blip)
    end

    if CurrentPartyIdProcess and process then
        local modelHash = GetHashKey(Config.Prop.Process)

        if not HasModelLoaded(modelHash) then
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Citizen.Wait(1)
            end
        end

        local obj = CreateObject(modelHash, vector3(Coords.x, Coords.y, Coords.z), false)

        PlaceObjectOnGroundProperly(obj)
        FreezeEntityPosition(obj, true)
        SetEntityHeading(obj, Heading)
        table.insert(PropList, obj)
        CreateProcess(obj, Coords, owner)
    end
end



RegisterNetEvent(ScriptName..":CreateParty")
AddEventHandler(ScriptName..":CreateParty", function()

    if lastCreate and lastCreate > GetGameTimer() then
        return
    end
    lastCreate = GetGameTimer() + 5000

    if OnCreateParty  then
        return
    end


    if not InZone then
        --TODO Add noti not in zone
        print("you not in starting zone")
        --exports['what_notify']:MsgNotification({msg = "You not in starting zone", type = 2,wait = 3})
        return
    end
    OnCreateParty = true
    PartyList = {}


    Citizen.CreateThread(function()
        local confirm = false
        local showNoti = false
        while not confirm and OnCreateParty do
            Wait(0)
            local PlayerCoords = GetEntityCoords(PlayerPedId())
            local Players =  ESX.Game.GetPlayersInArea(PlayerCoords, Config.Radius)
            print(Players)
            if not InZone then
                print("you not in starting zone")
                --exports['what_notify']:MsgNotification({msg = "You not in starting zone", type = 2,wait = 3})
                OnCreateParty = false
                confirm = true
                --exports['what_text3d']:WHAT_HIDETEXT()
                showNoti = false
                cancreate = true
                break
            end

            local PlayersList = {}
            for k, v in pairs(Players) do
                local tergetped = GetPlayerPed(v)
                local pedCoords = GetEntityCoords(tergetped)
                local ServerId = GetPlayerServerId(v)
                table.insert(PlayersList, {GetDistanceBetweenCoords(PlayerCoords, pedCoords, true), ServerId, tergetped})
            end

            table.sort(PlayersList, function (a,b)
                return a[1] < b[1]
            end)

            for i = 1, #PlayersList do
                local ped = PlayersList[i][3]
                local pedCoords = GetEntityCoords(ped)

                DrawMarker(2, pedCoords.x, pedCoords.y, pedCoords.z +1.7, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 0.5, 0.5, 0, 150, 255, 100, true, true, 2, nil, nil, false)

                if i >= (Config.MaxPlayers or 5) then
                    break
                end
            end


            if not showNoti then
                --exports['what_text3d']:WHAT_TEXT3D('to create party', 'E')
                print("create party E")
                -- --exports['what_text3d']:WHAT_TEXT3D('to leave party', 'E')
                showNoti = true
            end


            if not confirm and IsControlJustPressed(0, 38) and cancreate then
                cancreate = false
                for i = 1, #PlayersList do
                    table.insert(PartyList, PlayersList[i][2])
                    if i >= (Config.MaxPlayers or 5) then
                        break
                    end
                end

                local PostTaked = {}
                local Pos = {}

                while #Pos < Config.MaxSpawn do
                    Citizen.Wait(0)
                    local pos, index = Randompositon()
                    if not PostTaked[tostring(index)] then
                        PostTaked[tostring(index)] = true
                        table.insert(Pos, index)
                    end
                end

                TriggerEvent("mythic_progbar:client:progress", {
                    name = "unique_action_name",
                    duration = 3000,
                    label = "Delay..",
                    useWhileDead = false,
                    canCancel = true,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },
                }, function(status)
                end)
                Citizen.Wait(3000)


                TriggerServerEvent(ScriptName..":CreateParty:s", PartyList, Pos)
                OnCreateParty = false
                confirm = true
                --exports['what_text3d']:WHAT_HIDETEXT()
                showNoti = false
                cancreate = true
            end
        end
    end)

end)



RegisterNetEvent(ScriptName..":JoinParty")
AddEventHandler(ScriptName..":JoinParty", function(partyid, pos)
    CurrentPartyId = nil
    GetCount = 0
    --exports['what_notify']:MsgNotification({msg = "You can finding Mushroom now!!", type = 1,wait = 3})
    CurrentPartyId = partyid
    PosList = pos
    for i = 1, #pos do
        CreateProp(Config.Location[pos[i]])
    end
end)


RegisterNetEvent(ScriptName..":CreateParty:Process")
AddEventHandler(ScriptName..":CreateParty:Process", function()
    if lastCreate and lastCreate > GetGameTimer() then
        return
    end

    lastCreate = GetGameTimer() + 3000

    if not InZonePro then
        --exports['what_notify']:MsgNotification({msg = "You not in Process zone", type = 2,wait = 3})
        return
    end
    PartyList = {}
    OnCreateParty = true
    Citizen.CreateThread(function()
        local confirm = false
        local showNoti = false
        while not confirm and OnCreateParty do
            Wait(0)
            local PlayerCoords = GetEntityCoords(PlayerPedId())
            local Players =  ESX.Game.GetPlayersInArea(PlayerCoords, Config.Radius)

            if CurrentPartyIdProcess then
                --exports['what_notify']:MsgNotification({msg = "You are in process party", type = 2,wait = 3})
                break
            end

            if not InZonePro then
                --exports['what_notify']:MsgNotification({msg = "You not in Process zone", type = 2,wait = 3})
                confirm = true
                --exports['what_text3d']:WHAT_HIDETEXT()
                showNoti = false
                OnCreateParty = false
                cancreate = true
                break
            end

            local PlayersList = {}
            for k, v in pairs(Players) do
                local tergetped = GetPlayerPed(v)
                local pedCoords = GetEntityCoords(tergetped)
                local ServerId = GetPlayerServerId(v)
                table.insert(PlayersList, {GetDistanceBetweenCoords(PlayerCoords, pedCoords, true), ServerId, tergetped})
            end

            table.sort(PlayersList, function (a,b)
                return a[1] < b[1]
            end)

            for i = 1, #PlayersList do
                local ped = PlayersList[i][3]
                local pedCoords = GetEntityCoords(ped)

                DrawMarker(2, pedCoords.x, pedCoords.y, pedCoords.z +1.7, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 0.5, 0.5, 0, 150, 255, 100, true, true, 2, nil, nil, false)

                if i >= (Config.MaxPlayers or 5) then
                    break
                end
            end


            if not showNoti then
                --exports['what_text3d']:WHAT_TEXT3D('to create process party', 'E')
                -- --exports['what_text3d']:WHAT_TEXT3D('to leave party', 'E')
                showNoti = true
            end


            if not confirm and IsControlJustPressed(0, 38) and cancreate then
                cancreate = false
                for i = 1, #PlayersList do
                    table.insert(PartyList, PlayersList[i][2])
                    if i >= (Config.MaxPlayers or 5) then
                        break
                    end
                end

                local PostTaked = {}
                local Pos = {}

                while #Pos < Config.MaxSpawn do
                    Citizen.Wait(0)
                    local pos, index = Randompositon()
                    if not PostTaked[tostring(index)] then
                        PostTaked[tostring(index)] = true
                        table.insert(Pos, index)
                    end
                end

                confirm = true
                --exports['what_text3d']:WHAT_HIDETEXT()
                showNoti = false

                TriggerEvent("mythic_progbar:client:progress", {
                    name = "unique_action_name",
                    duration = 3000,
                    label = "Delay..",
                    useWhileDead = false,
                    canCancel = true,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },
                }, function(status)
                end)
                Citizen.Wait(3000)

                TriggerServerEvent(ScriptName..":CreateParty:Process:sv", PartyList, GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0), GetEntityHeading(PlayerPedId()))

                OnCreateParty = false
                cancreate = true
            end
        end
    end)

end)


function AnimateTable()
    ESX.Streaming.RequestAnimDict("anim@heists@money_grab@briefcase", function()
        TaskPlayAnim(PlayerPedId(), "anim@heists@money_grab@briefcase", "put_down_case", 8.0, -8.0, -1, 1, 0, false, false, false)
    end)
end




RegisterNetEvent(ScriptName..":CancelParty")
AddEventHandler(ScriptName..":CancelParty", function()
    OnCreateParty = false
    cancreate = true
    CurrentPartyId = nil
end)

RegisterNetEvent(ScriptName..":CancelParty:Process")
AddEventHandler(ScriptName..":CancelParty:Process", function()
    OnCreateParty = false
    cancreate = true
    CurrentPartyIdProcess = nil
end)


RegisterNetEvent(ScriptName..":JoinParty:Process")
AddEventHandler(ScriptName..":JoinParty:Process", function(partyid, pos, owner, h)

    CurrentPartyIdProcess = nil

    if GetPlayerServerId(PlayerId()) == owner then
        AnimateTable()
    end

    Citizen.Wait(1000)

    if GetPlayerServerId(PlayerId()) == owner then
        ClearPedTasks(PlayerPedId())
    end

    CurrentPartyIdProcess = partyid
    CreateProp(pos, true, h, owner)
end)



function Randompositon()
    for k, v in pairs(Config.Location) do
        if math.random(1, #Config.Location) == k then
            return v, k
        end
    end
end

function CheckItem(name, count)
    local inven = ESX.GetPlayerData().inventory
    for  i=1, #inven do
        if inven[i].name == name then
            if inven[i].count >= count then
                return  true
            else
                return  false
            end
        end
    end
    return  false
end


function GetLabelItems(item_name)
    local inventory = ESX.GetPlayerData().inventory
    for i=1, #inventory do
        local item = inventory[i]
        if item_name == item.name then
            return item.label
        end
    end
    return false
end


CreateThread(function()
    LafePartyNoti = false
    while true do
        ::start::
        Wait(0)

        local PlayerCoords = GetEntityCoords(PlayerPedId())
        local Checkcoord = GetDistanceBetweenCoords(PlayerCoords, Config.LeftPatyCoords, true)

        if Checkcoord > 10  then  Wait(300) goto start  end

        if not CurrentPartyId then   goto start  end

        DrawMarker(1, Config.LeftPatyCoords.x, Config.LeftPatyCoords.y, Config.LeftPatyCoords.z -1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 0.5, 255, 0, 0, 100, false, true, 2, nil, nil, false)

        if OnCreateParty then   goto start  end

        if Checkcoord < 2  then
            if not LafePartyNoti then
                --exports['what_text3d']:WHAT_TEXT3D('to leave pickup party', 'E')
                LafePartyNoti = true
            end


            if IsControlJustPressed(0, 38) then
                --exports['what_text3d']:WHAT_HIDETEXT()
                LafePartyNoti = false

                TriggerServerEvent(ScriptName..":LeftParty")
                CurrentPartyId = nil

                --TriggerEvent('what_notify:message',{
                --    msg = "You are out of party!",
                --    type = 1,
                --    wait = 3,
                --})
            end
        else
            if LafePartyNoti then
                --exports['what_text3d']:WHAT_HIDETEXT()
                LafePartyNoti = false
            end
        end
    end
end)


CreateThread(function()
    LafePartyNoti = false
    while true do
        ::start::
        Wait(0)

        local PlayerCoords = GetEntityCoords(PlayerPedId())
        local Checkcoord = GetDistanceBetweenCoords(PlayerCoords, Config.LeftPatyProcessCoords, true)

        if Checkcoord > 10  then  Wait(300) goto start  end


        if not CurrentPartyIdProcess then   goto start  end

        DrawMarker(1, Config.LeftPatyProcessCoords.x, Config.LeftPatyProcessCoords.y, Config.LeftPatyProcessCoords.z -1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 0.5, 255, 0, 0, 100, false, true, 2, nil, nil, false)

        if OnCreateParty then   goto start  end

        if Checkcoord < 2  then
            if not LafePartyNoti then
                --exports['what_text3d']:WHAT_TEXT3D('to leave process party', 'E')
                LafePartyNoti = true
            end


            if IsControlJustPressed(0, 38) then
                --exports['what_text3d']:WHAT_HIDETEXT()
                LafePartyNoti = false

                TriggerServerEvent(ScriptName..":LeftParty:Process")
                CurrentPartyIdProcess = nil

                --TriggerEvent('what_notify:message',{
                --    msg = "You are out of process party!",
                --    type = 1,
                --    wait = 3,
                --})
            end
        else
            if LafePartyNoti then
                --exports['what_text3d']:WHAT_HIDETEXT()
                LafePartyNoti = false
            end
        end
    end
end)


RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count)
	if OnCreateParty then
        if item.name == Config.ItemUse.Create  then
            if item.count == 0 then
                OnCreateParty = false
                --exports['what_text3d']:WHAT_HIDETEXT()
            end
        elseif item.name == Config.ItemUse.Process then
            if item.count == 0 then
                OnCreateParty = false
                --exports['what_text3d']:WHAT_HIDETEXT()
            end
        end
	end
end)


AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(PropList) do
            DeleteEntity(v)
        end

        for k ,v in pairs(TEXT3D) do
            if v then
                --exports['what_text3d']:WHAT_HIDETEXT()
            end
        end
    end
end)

