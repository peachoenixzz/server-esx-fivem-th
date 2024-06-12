Config = Config or {}
Config.mechanic = false    -- ถ้าต้องการ ช่าง ให้ตั้ง true
Config.ActionDistance = 4.0
Config.Keys = {
    action = {key = 38, label = 'E', name = 'INPUT_PICKUP'},
	closeui = {key = 202, label = 'BACKSPACE / ESC', name = 'INPUT_FRONTEND_CANCEL'}
}

Config.Positions = {
    {   -- custom_zone_a
        pos = {x = -465.6700134277344, y = 1107.300048828125, z = 327.8699951171875}, -- เพิ่ม poly zone ใน core.lua ด้วย
        whitelistJobName = 'mechanic',
    },
    {   -- custom_zone_b
        pos = {x = -469.2799987792969, y = 1100.0799560546875, z = 328.2300109863281},
        whitelistJobName = 'mechanic',
    },
}