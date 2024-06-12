local playerBusker = {}
local keys = {
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
local buskerID = nil
local fontId
Citizen.CreateThread(function()
    RegisterFontFile('font4thai') -- the name of your .gfx, without .gfx
    fontId = RegisterFontId('font4thai') -- the name from the .xml
end)

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.3, 0.3)
    SetTextFont(fontId)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end


Citizen.CreateThread(function()
    local model = GetHashKey("prop_busker_hat_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end

    while true do
        local waitTime = 500 -- Default wait time when not near a busker
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local playerServerId = GetPlayerServerId(PlayerId())

        for _, v in pairs(playerBusker) do
            local dist = GetDistanceBetweenCoords(pos, v.position)

            if dist <= 100 then
                waitTime = 0 -- No delay when near a busker
                if dist <= 3.0 then
                    local text = dist <= 1.5 and "กด ~y~[E]~w~ " or "~m~ กด [E] "
                    text = text .. (playerServerId == v.id and "เพื่อเก็บหมวก " or "เพื่อให้เงิน ")
                    text = text .. ("(ยอดรวม %s$)"):format(v.money)
                    DrawText3Ds(v.position.x, v.position.y, v.position.z - 0.5, text)
                    buskerID = v.id
                end
                PlaceObjectOnGroundProperly(NetToObj(v.netId))
                FreezeEntityPosition(NetToObj(v.netId), true)
            end
        end
        Citizen.Wait(waitTime)
    end
end)


Citizen.CreateThread(function()
    while true do
        local waitTime = 500 -- Default wait time when not near a busker
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local playerServerId = GetPlayerServerId(PlayerId())

        for _, v in pairs(playerBusker) do
            local dist = GetDistanceBetweenCoords(pos, v.position)

            if dist <= 1.5 then
                waitTime = 0 -- Reduce wait time when close to a busker

                if IsControlJustReleased(0, 38) then
                    if playerServerId == v.id then
                        getBuskerBack()
                        pickAnimation()
                        -- Log: Retrieve Busker
                        pcall(function()
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'RetrieveBusker',
                                content = 'ผู้เล่นได้ทำการกด E เพื่อเก็บหมวกนักร้อง'
                            })
                        end)
                    elseif playerServerId ~= v.id then
                        giveMoneyInput()
                        -- Log: Put Money In Busker
                        pcall(function()
                            exports['azael_dc-serverlogs']:insertData({
                                event = 'PutMoneyInBusker',
                                content = 'ผู้เล่นได้ทำการกด E เพื่อจะใส่เงินในหมวกนักร้อง'
                            })
                        end)
                    end
                end
            end
        end

        Citizen.Wait(waitTime)
    end
end)


function getBuskerBack()
    ESX.TriggerServerCallback('cc_busker:getBuskerBack', function()
        --notify and do action here
    end,buskerID)
end


function giveMoneyInput()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'dialog_busker',
            {
                title = "ใส่เงินที่จะให้นักร้อง",
            }, function(data, menu)
                if data.value == nil then
                    onNoDetailFill()
                end
                if  string.match(data.value, "^%d+$") then
                    ESX.TriggerServerCallback('cc_busker:giveMoney', function(success)
                        if success then
                            -- Surname successfully updated
                            onSuccessGiveMoney()
                        else
                            -- Handle error
                            onFailGiveMoney()
                        end
                        menu.close()
                    end, data.value,buskerID)
                    menu.close()
                else
                    onFailGiveMoney()
                end
            end, function(data, menu)
                menu.close()
                pcall(function() -- Start log
                    exports['azael_dc-serverlogs']:insertData({
                        event = 'CloseBuskerMenu',
                        content = ('ผู้เล่นได้ทำการกด ยกเลิก จากการใส่เงินในหมวกนักร้อง'):format(),
                    })
                end) -- End log
            end)
end


RegisterNetEvent("cc_busker:syncBusker")
AddEventHandler("cc_busker:syncBusker", function(dataPosition)
    playerBusker = dataPosition
    Wait(500)
end)

RegisterNetEvent("cc_busker:animation")
AddEventHandler("cc_busker:animation", function()
    pickAnimation()
end)

function pickAnimation()
    while (not HasAnimDictLoaded("pickup_object")) do
		RequestAnimDict("pickup_object")
		Citizen.Wait(100)
	end
	TaskPlayAnim(PlayerPedId(), "pickup_object", "pickup_low", 8.0, -8.0, -1, 0, 0, false, false, false)
end

function onNoDetailFill()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบเปิดหมวก', -- หัวเรื่อง
        description = 'กรุณาใส่จำนวนเงิน', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'detail', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function onSuccessGiveMoney()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบเปิดหมวก', -- หัวเรื่อง
        description = 'คุณได้ใส่เงินในหมวกของนักร้องเรียบร้อยแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'success', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end

function onFailGiveMoney()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบเปิดหมวก', -- หัวเรื่อง
        description = 'คุณได้ใส่เงินในหมวกของนักร้องไม่สำเร็จ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_money', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end