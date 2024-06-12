if Config.SettingSystem.WeatherandBlackOut then
    CurrentWeather = Config.StartWeather
    local lastWeather, baseTime, timeOffset, timer, freezeTime, blackout = CurrentWeather, Config.BaseTime, 0, 0, false, false


    RegisterNetEvent('admin:updateWeather')
    AddEventHandler('admin:updateWeather', function(NewWeather, newblackout)
        CurrentWeather = NewWeather
        blackout = newblackout
    end)

    Citizen.CreateThread(function()
        local loaded = false
        while true do
            if lastWeather ~= CurrentWeather then
                lastWeather = CurrentWeather
                SetWeatherTypeOverTime(CurrentWeather, 15.0)
                Citizen.Wait(15000)
            end
            Citizen.Wait(500) -- Wait 0 seconds to prevent crashing.
            SetBlackout(blackout)
            ClearOverrideWeather()
            ClearWeatherTypePersist()
            SetWeatherTypePersist(lastWeather)
            SetWeatherTypeNow(lastWeather)
            SetWeatherTypeNowPersist(lastWeather)
            if lastWeather == 'XMAS' then
                SetForceVehicleTrails(false)
                SetForcePedFootstepsTracks(false)
                N_0xc54a08c85ae4d410(3.0)
                if not loaded then
                    RequestScriptAudioBank("ICE_FOOTSTEPS", false)
                    RequestScriptAudioBank("SNOW_FOOTSTEPS", false)
                    RequestNamedPtfxAsset("core_snow")
                    while not HasNamedPtfxAssetLoaded("core_snow") do
                        Citizen.Wait(0)
                    end
                    UseParticleFxAssetNextCall("core_snow")
                    loaded = true
                end
            else
                if loaded then N_0xc54a08c85ae4d410(0.0) end
                loaded = false
                RemoveNamedPtfxAsset("core_snow")
                ReleaseNamedScriptAudioBank("ICE_FOOTSTEPS")
                ReleaseNamedScriptAudioBank("SNOW_FOOTSTEPS")
            end
        end
    end)

    RegisterNetEvent('admin:updateTime')
    AddEventHandler('admin:updateTime', function(base, offset, freeze)
        freezeTime = freeze
        timeOffset = offset
        baseTime = base
    end)

    Citizen.CreateThread(function()
        local hour = 0
        local minute = 0
        while true do
            Citizen.Wait(0)
            local newBaseTime = baseTime
            if GetGameTimer() - 500  > timer then
                newBaseTime = newBaseTime + 0.25
                timer = GetGameTimer()
            end
            if freezeTime then
                timeOffset = timeOffset + baseTime - newBaseTime			
            end
            baseTime = newBaseTime
            hour = math.floor(((baseTime+timeOffset)/60)%24)
            minute = math.floor((baseTime+timeOffset)%60)
            NetworkOverrideClockTime(hour, minute, 0)
        end
    end)

    -- AddEventHandler('playerSpawned', function()
    --     TriggerServerEvent('admin:requestSync')
    -- end)
end