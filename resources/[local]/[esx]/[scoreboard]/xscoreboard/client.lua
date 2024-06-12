-- Created By.xZero

local display = false
local keys = 178
local IsPress = false
local FirstName = {}
local PhoneNumber = {}
local JOB = {}
local JOBB = {}


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    ESX.TriggerServerCallback('xscoreboard:server:getdata', function(data)
        Wait(1500)
        UserProfile(data)
        updatedata()
    end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    Citizen.Wait(3000)
    ESX.TriggerServerCallback('xscoreboard:server:getdata', function(data)
        Wait(1500)
        UserProfile(data)
        updatedata()
    end)
end)


Citizen.CreateThread(function()
    Citizen.Wait(1000)
    ESX.TriggerServerCallback('xscoreboard:server:getdata', function(data)
        Wait(1000)
        UserProfile(data)
        updatedata()
    end)
end)

--Citizen.CreateThread(function()
--    while true do
--        if ( IsControlPressed(0, keys) and not (ESX == nil) and (IsPress == false) ) then
--            IsPress = true
--            display = not display
--            displayShow(display)
--            IsPress = false
--            Citizen.Wait(250)
--            updatedata()
--        end
--        Citizen.Wait(10)
--    end
--end)

ESX.RegisterInput("circle:scoreboard", "Scoreboard Circle Hotkey", "keyboard", "DELETE", function()
    display = not display
    displayShow(display)
    updatedata()
end)

function displayShow(display)
    local tokenAuth = exports.cc_authlogin:tokenCollect()
    SendNUIMessage({
        type = "ui",
        token = tokenAuth,
        display = display
    })
end

function updatedata()
    local tokenAuth = exports.cc_authlogin:tokenCollect()
    SendNUIMessage({
        type = "update",
        my_id = GetPlayerServerId(PlayerId()),
        my_phonenmumber = PhoneNumber,
        my_fullname = FirstName,
        my_job = JOB,
		my_jobb = JOBB,
        my_ping = 0,
        players = exports.Dv_Hunter_Check:Players(),
        police = 0,
        ems = exports.Dv_Hunter_Check:CheckPoliceToScoreboard(),
        mc = 0,
        token = tokenAuth,
    })
end

function UserProfile(data)
    PhoneNumber = data.my_phonenmumber
    FirstName = data.my_fullname
    JOB = data.my_job
	JOBB = data.my_jobb
end
