RegisterNetEvent("orcp_postal_map:loadingmap")
AddEventHandler("orcp_postal_map:loadingmap", function()
    Citizen.CreateThread(function()
        SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 1.0, 5.0) -- Level 0
        SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 1.0, 5.0) -- Level 1
        SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 1.0, 5.0) -- Level 2
        SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 1.0, 5.0) -- Level 3
        SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 1.0, 5.0) -- Level 4

        RequestStreamedTextureDict("squaremap", false)
        if not HasStreamedTextureDictLoaded("squaremap") then
            Wait(150)
        end
        SetMinimapClipType(0)
        AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
        AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")

        local defaultAspectRatio = 1920/1080 -- Don't change this.
        local resolutionX, resolutionY = GetActiveScreenResolution()
        local aspectRatio = resolutionX/resolutionY
        local minimapOffset = 0
        if aspectRatio > defaultAspectRatio then
            minimapOffset = ((defaultAspectRatio-aspectRatio)/3.6)-0.008
        end

        SetMinimapComponentPosition("minimap", "L", "B", 0.0 + minimapOffset, -0.047, 0.1638, 0.183)

        -- icons within map
        SetMinimapComponentPosition("minimap_mask", "L", "B", 0.0 + minimapOffset, 0.0, 0.128, 0.20)

        -- -0.01 = map pulled left
        -- 0.025 = map raised up
        -- 0.262 = map stretched
        -- 0.315 = map shorten
        --SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.01 + minimapOffset, 0.025, 0.262, 0.300) default
        SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.040 + minimapOffset, 0.010, 0.310, 0.275)

        SetBlipAlpha(GetNorthRadarBlip(), 0)
        SetRadarBigmapEnabled(true, false)
        SetMinimapClipType(0)
        Citizen.Wait(50)
        SetRadarBigmapEnabled(false, false)
    end)
end)

--Citizen.CreateThread(function()
--    while true do
--		Citizen.Wait(0)
--		if IsPedOnFoot(GetPlayerPed(-1)) then
--			SetRadarZoom(1100)
--		elseif IsPedInAnyVehicle(GetPlayerPed(-1), true) then
--			SetRadarZoom(1100)
--		end
--    end
--end)
