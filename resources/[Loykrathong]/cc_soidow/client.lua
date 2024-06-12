ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local fontId
Citizen.CreateThread(function()
    RegisterFontFile('font4thai')
    fontId = RegisterFontId('font4thai') 
end)

function DrawText3DSoiDow(x,y,z, text,mul)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
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

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
		local coords = GetEntityCoords(PlayerPedId())
		for _,v in pairs(Config.SoidowZone) do
                if(GetDistanceBetweenCoords(coords, v.coords, false) < 10) then
                    DrawText3DSoiDow(v.coords.x, v.coords.y, v.coords.z+0.5, "กด ~b~[E]~w~ เพื่อส่อยดาว", 2.0)
                    DrawMarker(1, v.coords.x, v.coords.y, v.coords.z-1, 0.0, 0.0,
                    0.0, 0, 0.0, 0.0, 7.0, 7.0, 1.00, 0,204, 204, 100, false, true, 2, false, false, false, false)
                    sleep = 0
                end

                if(GetDistanceBetweenCoords(coords, v.coords, false) < 3.5) then
                    if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) then
                        ongoingSoidow()
                    end
                end
		end
		Citizen.Wait(sleep)
    end
end)

function ongoingSoidow()
    ESX.TriggerServerCallback('cc_soidow:checkItem', function(haveItem)
        if haveItem then
            TriggerEvent("mythic_progbar:client:progress",{
                name = "soidow",
                duration = 5000,
                label = "กำลังส่อยดาว",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "amb@prop_human_movie_bulb@base",
                    anim = "base",
                    flags = 9,
                },
            }, function(status)
                if not status then
                    ESX.TriggerServerCallback('cc_soidow:doneSoidow', function(have)
                        if have then

                        else
                            onNoItemtoSoidow()
                        end
                    end)
                end
            end)
        else
            onNoItemtoSoidow()
        end
    end)
end

function onNoItemtoSoidow()
    exports.nc_notify:PushNotification({
        scale = 1.0, -- ปรับขนาดของ Notify
        title = 'ระบบส่อยดาว', -- หัวเรื่อง
        description = 'คุณไม่มีไอเทมที่กำหนด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
        type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
        position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
        direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
        priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
        icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
        duration = 3000 -- ระยะเวลาการแสดง Notify
    })
end
