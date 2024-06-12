local selectedPlayers = {}
local onMarker = false
local isPlayerAdd = false
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

Citizen.CreateThread(function()
    while not ESX do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
end)

RegisterNetEvent("cc_blessingbell:initGetAroundPlayer")
AddEventHandler("cc_blessingbell:initGetAroundPlayer", function()
    initAroundPlayer()
end)

function initAroundPlayer()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local playersInArea = ESX.Game.GetPlayersInArea(coords, 5.0)
    table.insert(selectedPlayers,PlayerId())
    for i = 1, #playersInArea, 1 do
        local player = playersInArea[i]
        if #selectedPlayers == 10 then
            break
        end
        table.insert(selectedPlayers,GetPlayerServerId(player))
        ::endState::
    end
    inMenuInit()
end

function inMenuInit()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'circle_menu',
            {
                title    = 'Blessing Menu',
                align    = 'top-right',
                elements = {
                    { label = 'เช็คผู้ได้รับพรจากระฆัง',	value = 'validate_player'},
                }
            },
            function(data, menu)
                local selectedAction = data.current.value
                if selectedAction == "validate_player" then
                    submitMenu()
                    handleMarker()
                end
            end,
            function(data, menu)
                menu.close()
            end
    )
end

function submitMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'circle_menu',
            {
                title    = 'Blessing Menu',
                align    = 'top-right',
                elements = {
                    { label = 'ตกลงใช้งาน',	value = 'submit'},
                    { label = 'ยกเลิก',	value = 'cancel'},
                }
            },
            function(data, menu)
                local selectedAction = data.current.value
                if selectedAction == "submit" then
                    ESX.TriggerServerCallback('cc_blessingbell:validatePlayer', function(status)
                        onMarker = false
                        selectedPlayers = {}
                        menu.close()
                    end,selectedPlayers)
                end
                if selectedAction == "cancel" then
                    onMarker = false
                    selectedPlayers = {}
                    menu.close()
                end
            end,
            function(data, menu)
                onMarker = false
                selectedPlayers = {}
                menu.close()
            end
    )
end


function handleMarker()
    onMarker = true
    Citizen.CreateThread(function()
        local colors = {
            black = {0, 0, 0, 100},
            red = {224, 50, 50, 50},
            green = {146, 200, 62, 50},
            white = {255, 255, 255, 100},
            blue = {0, 0, 255, 100},
            avr = {0,0,255,100},
            xx = {255,0,0,100},
            bvl = {102,0,0,100},
            dzt = {0,0,200,100},
            gbt = {153,76,0,100},
            rv = {0,0,150,100},
            smk = {0,255,0,100},
            bg = {0,0,0,100},
        }

        local function drawPlayerMarker(playerID, color)
            local idx = GetPlayerPed(GetPlayerFromServerId(playerID))
            if not IsEntityDead(idx) then
                local coords = GetOffsetFromEntityInWorldCoords(idx, 0.0, 0.0, 1.0)
                local markerColor = colors[color]
                DrawMarker(20, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.3, 0.3, 0.3, markerColor[1], markerColor[2], markerColor[3], markerColor[4], 0, 1, 2, 0, 0)
            end
        end

        while onMarker do
            Wait(0)
            for _, v in pairs(selectedPlayers) do
                drawPlayerMarker(v, "white")
            end
        end
    end)
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