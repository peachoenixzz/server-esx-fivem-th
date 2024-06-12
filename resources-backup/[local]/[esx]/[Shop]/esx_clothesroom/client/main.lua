

local Keys = {
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



function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()	
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		
		local coords = GetEntityCoords(playerPed)
					
			if GetDistanceBetweenCoords(coords, Config.Zones.clothbox.coords, true) < 2 then
					
				
				DisplayHelpText('<font face="ThaiFont">กด E เพื่อเปิดตู้เสื้อผ้า</font>')
			
					
				if IsControlJustReleased(0, 38) then
								Opensend()                  								
				end
				
			end			
	end
end)

function Opensend()
	TriggerEvent('clothes:select')	
end

RegisterNetEvent('clothes:select')
AddEventHandler('clothes:select',function()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'clothesroom',
	{
		title    = '',
		align    = 'center',
		elements = {
			{ label = "ตู้เสื้อผ้า", value = 'player_clothes' }
			
		}
	}, function(data, menu)				

		if data.current.value == 'player_clothes' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rooom_clothes', {
				title    =  '',
				align    = 'left',
				elements = {
					{
						label = "ชุด", value = 'clothes'
					},
					{
						label = "หมวก", value = 'helmet'
					},
					{
						label = "หน้ากาก", value = 'mask'
					},
					{
						label = "แว่น", value = 'glasses'
					},
					{
						label = "ตุ้มหู", value = 'ears'
					}
				},
			}, function(data2, menu2)

				local value = data2.current.value

				if value == "clothes" then
					LoadClothes('player_clothes', 'ชุด')
				elseif value == "helmet" then
					LoadClothes('player_helmet', 'หมวก')
				elseif value == "mask" then
					LoadClothes('player_mask', 'หน้ากาก')
				elseif value == "glasses" then
					LoadClothes('player_glasses', 'แว่นตา')
				elseif value == "ears" then
					LoadClothes('player_ears', 'ตุ้มหู')
				end

			end, function(data2, menu2)
				menu2.close()				
			end)
		end

	end, function(data, menu)
		menu.close()
	end)

end)


function table.empty (self)
    for _, _ in pairs(self) do
        return false
    end
    return true
end

function LoadClothes(type, text)
	ESX.TriggerServerCallback('esx_clothesroom:getPlayerOutfit', function(clothes)
		
		if not table.empty(clothes) then
			local elements = {}

			for k,v in pairs(clothes) do
				table.insert(elements, {
					label = v.label, value = json.decode(v.skin), id = v.id
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room_clothes_open', {
				title    =  text,
				align    = 'top-left',
				elements = elements,
			}, function(data3, menu3)
		
				local value = data3.current.value
		
				if value ~= nil then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room_clothes_open_sub', {
						title    =  'แก้ไข - ' ..data3.current.label,
						align    = 'top-left',
						elements = {
							{
								label = "ส่วมใส่", value = 'pick', skin = value,
							},
							{
								label = "เปลี่ยนชื่อ", value = 'rename', id = data3.current.id
							},
							{
								label = "<strong class='red-text'>ลบออก</strong>", value = 'remove', id = data3.current.id
							}
						},
					}, function(data4, menu4)
				
						local value = data4.current.value
				
						if value == 'pick' then
							ESX.TriggerServerCallback('esx_clothesroom:checkMoney', function(hasEnoughMoney)
								if hasEnoughMoney then
									
									TriggerEvent('skinchanger:getSkin', function(skin)
										TriggerEvent('skinchanger:loadClothes', skin, data4.current.skin)
										TriggerEvent('esx_skin:setLastSkin', skin)
										TriggerServerEvent('esx_skin:save', skin)
									end)
									Wait(100)
									TriggerEvent('skinchanger:getSkin', function(skin)
										TriggerEvent('skinchanger:loadClothes', skin, data4.current.skin)
										TriggerEvent('esx_skin:setLastSkin', skin)
										TriggerServerEvent('esx_skin:save', skin)
									end)
									ESX.UI.Menu.CloseAll()
								else
									TriggerEvent("pNotify:SendNotification", {
											text = '<strong class="green-text">คุณไม่มีเงินเพียงพอ '..Config.Price..'</strong>',
											type = "success",
											timeout = 3000,
											layout = "bottomCenter",
											queue = "global"
									})
								end								
							end, Config.Price)
						elseif value == 'rename' then
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'outfit_name', {
								title = "ใส่ชื่อชุด (2-30 ตัวอักษร)",
								value = data3.current.label
							}, function(data5, menu5)

								if data5.value == nil then
									TriggerEvent("pNotify:SendNotification", {
										text = '<strong class="red-text">กรุณาใส่ชื่อชุดของคุณด้วย</strong>',
										type = "success",
										timeout = 3000,
										layout = "bottomCenter",
										queue = "global"
									})
								else
									if utf8.len(data5.value) >= 30 then
										TriggerEvent("pNotify:SendNotification", {
											text = '<strong class="red-text">ชื่อชุดของคุณยาวเกินไป</strong>',
											type = "success",
											timeout = 3000,
											layout = "bottomCenter",
											queue = "global"
										})
									elseif utf8.len(data5.value) < 2 then
										TriggerEvent("pNotify:SendNotification", {
											text = '<strong class="red-text">ชื่อชุดของคุณสั้นเกินไป</strong>',
											type = "success",
											timeout = 3000,
											layout = "bottomCenter",
											queue = "global"
										})	
									else
										menu5.close()
										TriggerServerEvent('esx_clothesroom:renameOutfit', data5.value, data4.current.id)
										LoadClothes(type,text)
									end
									
								end
		
							end, function(data5, menu5)
								menu5.close()
							end)
						elseif value == 'remove' then
							menu4.close()
							TriggerServerEvent('esx_clothesroom:deleteOutfit', data4.current.id)
							LoadClothes(type,text)
						end
				
					end, function(data4, menu4)
						menu4.close()
					end)
				end
		
			end, function(data3, menu3)
				menu3.close()
			end)
		else
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room_clothes_null', {
				title    =  text,
				align    = 'top-left',
				elements = { label = '<strong class="red-text">ว่างเปล่า</strong>'},
			}, function(data3, menu3)
		
			end, function(data3, menu3)
				menu3.close()
			end)
		end
	end, type)

end

function CreateBlipCircle(coords, text, radius, color, sprite)
	local blip 

	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 1)
	SetBlipAlpha (blip, 128)

	blip = AddBlipForCoord(coords)

	SetBlipHighDetail(blip, true)
	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
	
end



Citizen.CreateThread(function()
	for k,Zones in pairs(Config.Zones) do
		CreateBlipCircle(Zones.coords, Zones.name, Zones.radius, Zones.color, Zones.sprite)
	end
	
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Zones) do
			if GetDistanceBetweenCoords(coords, v.coords, true) < 50 then
				DrawMarker(1, v.coords.x, v.coords.y, v.coords.z, 0, 0, 0, 0, 0, 0, 1.1, 1.0, 1.0,0,255,0, 165, 0,0, 0,0)
			   
			end
		end
	end
end)


