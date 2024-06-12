--Script Name: esx_vehicleTeleportPads.
--Description: Teleport vehicles with people, or just people without a vehicle from one location to another location.
--Author: Unknown.
--Modified by: BossManNz.
--Credits: ElPumpo, TheStonedTurtle.

Config              = {}

Config.DrawDistance = 1000.0

Config.Marker = {
	Type = 1,
	x = 5.0, y = 5.0, z = 1.0,
	r = 255, g = 55, b = 55
}

Config.Pads = {

	MartinHouseIn = {
		Text = 'Press ~INPUT_CONTEXT~ to enter ~y~house~s~.',
		Marker = { x = 2954.84375, y = 3846.3515625, z = 51.505794525146 },
		TeleportPoint = { x = 230.373046875, y = -836.62066650391, z = 30.211759567261, h = 158.03517150879 }
	},

	MartinHouseOut = {
		Text = 'Press ~INPUT_CONTEXT~ to leave the ~y~house~s~.',
		Marker = { x = 1400.49, y = 1129.61, z = 113.30 },
		TeleportPoint = { x = 1400.25, y = 1123.59, z = 20.84, h = 180.0 }
	}

}