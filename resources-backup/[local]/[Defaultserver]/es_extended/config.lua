Config = {}
Config.Locale = GetConvar('esx:locale', 'en')

Config.Accounts = {
	bank = {
		label = TranslateCap('account_bank'),
		round = true
	},
	black_money = {
		label = 'เงินผิดกฎหมาย',
		round = true
	},
	money = {
		label = 'เงิน',
		round = true
	}
}

Config.StartingAccountMoney 	= {money = 0}

Config.DefaultSpawn 			=    {
										{x = 187.52999877929688, y = -941.72998046875, z = 30.38999938964843, heading = 140.6},
										{x = 192.52999877929688, y = -945.6500244140624, z = 30.38999938964843, heading = 141.95},
										{x = 195.1300048828125, y = -951.969970703125, z = 30.38999938964843, heading = 112.79},
										{x = 199.2299957275391, y = -959.8300170898438, z = 30.22999954223632, heading = 118.56},
										{x = 202.1300048828125, y = -967.6199951171876, z = 30.38999938964843, heading = 84.94},
										{x = 201.13999938964844, y = -975.5499877929688, z = 30.38999938964843, heading = 66.17},
										{x = 198.41000366210935, y = -982.8900146484376, z = 30.38999938964843, heading = 48.62},
										{x = 194.0800018310547, y = -987.97998046875, z = 30.34000015258789, heading = 55.1},
										{x = 184.3300018310547, y = -992.6199951171876, z = 30.34000015258789, heading = 192.46},
										{x = 172.35000610351565, y = -989.4299926757812, z = 30.54999923706054, heading = 190.22},
										{x = 157.61000061035156, y = -986.7999877929688, z = 30.31999969482422, heading = 154.95},
										{x = 149.0399932861328, y = -981.6099853515624, z = 30.38999938964843, heading = 177.29},
										{x = 153.5800018310547, y = -1008.72998046875, z = 29.65999984741211, heading = 330.02},
										{x = 164.42999267578125, y = -1012.719970703125, z = 29.67000007629394, heading = 346.49},
										{x = 174.1300048828125, y = -1017.5599975585938, z = 29.67000007629394, heading = 345.05},
										{x = 184.25, y = -1018.9600219726564, z = 29.67000007629394, heading = 351.52},
										{x = 198.41000366210935, y = -1029.18994140625, z = 29.65999984741211, heading = 65.9},
										{x = 188.52000427246097, y = -1028.989990234375, z = 29.65999984741211, heading = 230.81},
										{x = 181.66000366210935, y = -1034.1099853515625, z = 29.67000007629394, heading = 207.99},
										{x = 166.39999389648438, y = -1030.8299560546875, z = 29.67000007629394, heading = 158.44},
										{x = 143.9499969482422, y = -1025.469970703125, z = 29.65999984741211, heading = 160.55},
										{x = 135.77999877929688, y = -1021.8200073242188, z = 29.65999984741211, heading = 133.08},
										{x = 132.7400054931641, y = -1009.1300048828124, z = 29.65999984741211, heading = 246.99},
										{x = 136.44000244140625, y = -1004.6199951171876, z = 29.65999984741211, heading = 210.32},
}

Config.EnablePaycheck			= true -- enable paycheck
Config.EnableSocietyPayouts 	= false -- pay from the society account that the player is employed at? Requirement: esx_society
Config.MaxWeight            	= 30   -- the max inventory weight without backpack
Config.PaycheckInterval         = 30 * 60000 -- how often to recieve pay checks in milliseconds
Config.EnableDebug              = false -- Use Debug options?
Config.EnableDefaultInventory   = false -- Display the default Inventory ( F2 )
Config.EnableWantedLevel    	= false -- Use Normal GTA wanted Level?
Config.EnablePVP                = true -- Allow Player to player combat

Config.Multichar                = GetResourceState("esx_multicharacter") ~= "missing"
Config.Identity                 = false -- Select a characters identity data before they have loaded in (this happens by default with multichar)
Config.DistanceGive 			= 4.0 -- Max distance when giving items, weapons etc.

Config.DisableHealthRegeneration  = true -- Player will no longer regenerate health
Config.DisableVehicleRewards      = true -- Disables Player Recieving weapons from vehicles
Config.DisableNPCDrops            = true -- stops NPCs from dropping weapons on death
Config.DisableDispatchServices	  = true -- Disable Dispatch services
Config.DisableScenarios			  = true -- Disable Scenarios
Config.DisableWeaponWheel         = true -- Disables default weapon wheel
Config.DisableAimAssist           = true -- disables AIM assist (mainly on controllers)
Config.DisableVehicleSeatShuff	  = true -- Disables vehicle seat shuff
Config.RemoveHudCommonents = {
	[1] = true, --WANTED_STARS,
	[2] = true, --WEAPON_ICON
	[3] = true, --CASH
	[4] = true,  --MP_CASH
	[5] = true, --MP_MESSAGE
	[6] = true, --VEHICLE_NAME
	[7] = true,-- AREA_NAME
	[8] = true,-- VEHICLE_CLASS
	[9] = true, --STREET_NAME
	[10] = true, --HELP_TEXT
	[11] = true, --FLOATING_HELP_TEXT_1
	[12] = true, --FLOATING_HELP_TEXT_2
	[13] = true, --CASH_CHANGE
	[14] = true, --RETICLE
	[15] = true, --SUBTITLE_TEXT
	[16] = true, --RADIO_STATIONS
	[17] = true, --SAVING_GAME,
	[18] = true, --GAME_STREAM
	[19] = true, --WEAPON_WHEEL
	[20] = true, --WEAPON_WHEEL_STATS
	[21] = true, --HUD_COMPONENTS
	[22] = true, --HUD_WEAPONS
}

Config.SpawnVehMaxUpgrades = true -- admin vehicles spawn with max vehcle settings
Config.CustomAIPlates = 'ESX.A111' -- Custom plates for AI vehicles
-- Pattern string format
--1 will lead to a random number from 0-9.
--A will lead to a random letter from A-Z.
-- . will lead to a random letter or number, with 50% probability of being either.
--^1 will lead to a literal 1 being emitted.
--^A will lead to a literal A being emitted.
--Any other character will lead to said character being emitted.
-- A string shorter than 8 characters will be padded on the right.
