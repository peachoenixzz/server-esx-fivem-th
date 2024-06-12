ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)


Citizen.CreateThread(function()
    while true do
        local sleep = 1000
		local coords = GetEntityCoords(PlayerPedId())
		for _,v in pairs(Config.silaClothInfo) do
			if(GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, false) < v.drawdistance and ESX.PlayerData.job.name == "circle") then
				DrawMarker(v.markertype, v.coords.x, v.coords.y, v.coords.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0,
						v.markersize.x, v.markersize.y, v.markersize.z, v.markercolour.r, v.markercolour.g, v.markercolour.b, 100,
						false, true, 2, false, false, false, false)
				sleep = 0
			end

			if(GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, false) < v.interactdistance and ESX.PlayerData.job.name == "circle") then
				if IsControlJustPressed(0, 38) and IsPedOnFoot(PlayerPedId()) then
					openMenuSilaCloth()
				end
			end
		end
		Citizen.Wait(sleep)
    end
end)


function openMenuSilaCloth()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'silacloth_zone', {
                title    = 'Sila Clothing',
                align    = 'top-right',
                elements = {
                    {label = "น้องหมาซามูไร 1", value = 'samuraidog1'},
                    {label = "น้องหมาซามูไร 2", value = 'samuraidog2'},
                    {label = "น้องหมาซามูไร 3", value = 'samuraidog3'},
                    {label = "น้องหมาซามูไร 4", value = 'samuraidog4'},
                    {label = "น้องหมาซามูไร 5", value = 'samuraidog5'},
                    {label = "น้องหมาซามูไร 6", value = 'samuraidog6'},
                    {label = "น้องหมาซามูไร 7", value = 'samuraidog7'},
                    {label = "กลับร่างเดิม", value = 'default'},
                }
    },  function(data, menu)
            if data.current.value == 'samuraidog1' then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.male[1])
                end)
                menu.close()
            end
            if data.current.value == 'samuraidog2' then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.male[2])
                end)
                menu.close()
            end
            if data.current.value == 'samuraidog3' then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.male[3])
                end)
                menu.close()
            end
            if data.current.value == 'samuraidog4' then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.male[4])
                end)
                menu.close()
            end
            if data.current.value == 'samuraidog5' then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.male[5])
                end)
                menu.close()
            end
            if data.current.value == 'samuraidog6' then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.male[6])
                end)
                menu.close()
            end
            if data.current.value == 'samuraidog7' then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.male[7])
                end)
                menu.close()
            end
            if data.current.value == 'default' then
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                end)
                menu.close()
            end
        end, function(data, menu)
            menu.close()
   	end)
end











