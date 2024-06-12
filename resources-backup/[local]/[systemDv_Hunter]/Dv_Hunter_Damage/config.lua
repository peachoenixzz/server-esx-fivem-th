Config = {}

Config.damageZone		= false     -- เอา ไว้ คุมดาเมท เป็น โซน
Config.damageinzone		= 10.0		--ตัว คูณ ดาเมท อาวุธทั่วๆ ไป เวลาอยู่ในโซนที่กำหนด ปรับ ค่า ตัว คูณ ได้ตามใจชอบเลย  ความแรงจะ คูณจาก Config.Weaponlist ตัวอย่าง weapon_dagger = 5, คูณ 10.0 เวลาปรับ ห้ามใส่ 1-9 ต้องมีลงท้ายด้วย เช่น 1.0 , 2.0 , 3.0  ,4.10
Config.damageoutzone	= 0.0001	--ตัว คูณ ดาเมท อาวุธทั่วๆ ไป นอกโซน ห้าม ปรับ ค่าแนะนำ 0.0001 ถ้าปรับ ต้องปรับดาเมทอาวุธ ทุกชิ้นใหม่
Config.updatedamage		= 30		-- แนะ นำ 10 ถึง 30  ถ้า ปรับเป็น 0 สคริปจะทำงานหนัก ขึ้นในฝั่ง client มีผล ต่อ ความไว ในการอัพเดทดาเมทเข้าตัวผู้เล่น

Config.Zone ={
	{ x = -2118.89, y = 2878.860,  z = 32.81, radius = 50.0},     
	{ x = 431.57, y = -981.46,  z = 30.70, radius = 20.0},   
	{ x = 1138.40, y = -775.65,  z =  57.65, radius = 20.0},     
	{ x = -328.60, y = -937.78,  z =  31.20, radius = 50.0},     
}

Config.Weaponlist = {
	--admin weapon
	weapon_hammer_god = 50,
	weapon_light_saber_red = 50,
	-- Melee
	weapon_dagger = 42,
	weapon_bat = 5,
	weapon_bottle = 32,
	weapon_crowbar = 5,
	weapon_unarmed = 3, -- หมัด
	weapon_flashlight = 5,
	weapon_golfclub = 5,
	weapon_hammer = 5,
	
	weapon_hatchet = 5,
	weapon_knuckle = 9,
	weapon_knife = 42,
	weapon_machete = 33,
	weapon_switchblade = 5,
	weapon_nightstick = 5,
	weapon_wrench = 5,
	weapon_battleaxe = 5,
	
	weapon_poolcue = 5,
	weapon_stone_hatchet = 5,
	
	-- Handguns 
	weapon_pistol = 5,
	weapon_pistol_mk2 = 5,
	weapon_combatpistol = 5,
	weapon_appistol = 5,
	weapon_stungun = 1, -- เทเซอร์
	weapon_pistol50 = 5,
	weapon_snspistol = 5,
	weapon_snspistol_mk2 = 5,
	
	weapon_heavypistol = 5,
	weapon_vintagepistol = 5,
	weapon_flaregun = 5,
	weapon_marksmanpistol = 5,
	weapon_revolver = 5,
	weapon_revolver_mk2 = 5,
	weapon_doubleaction = 5,
	weapon_raypistol = 5,
	
	weapon_ceramicpistol = 5,
	weapon_navyrevolver = 5,
	weapon_gadgetpistol = 5,
	
	-- Submachine Guns
	weapon_microsmg = 7,
	weapon_smg = 7,
	weapon_smg_mk2 = 7,
	weapon_assaultsmg = 7,
	weapon_combatpdw = 7,
	weapon_machinepistol = 7,
	weapon_minismg = 7,
	weapon_raycarbine = 7,
	
	-- Shotguns
	weapon_pumpshotgun = 0,
	weapon_pumpshotgun_mk2 = 0,
	weapon_sawnoffshotgun = 7,
	weapon_assaultshotgun = 7,
	weapon_bullpupshotgun = 7,
	weapon_musket = 7,
	weapon_heavyshotgun = 7,
	weapon_dbshotgun = 7,
	weapon_autoshotgun = 7,
	weapon_combatshotgun = 7,
	
	-- Assault Rifles
	weapon_assaultrifle = 13,
	weapon_assaultrifle_mk2 = 13,
	weapon_carbinerifle = 13,
	weapon_carbinerifle_mk2 = 13,
	weapon_advancedrifle = 13,
	weapon_specialcarbine = 13,
	weapon_specialcarbine_mk2 = 13,
	weapon_bullpuprifle = 13,
	weapon_bullpuprifle_mk2 = 13,
	weapon_compactrifle = 13,
	weapon_militaryrifle = 13,
	
	-- Light Machine Guns
	weapon_mg = 17,
	weapon_combatmg = 17,
	weapon_combatmg_mk2 = 17,
	weapon_gusenberg = 17,
	
	-- Sniper Rifles
	weapon_sniperrifle = 20,
	weapon_heavysniper = 20,
	weapon_heavysniper_mk2 = 20,
	weapon_marksmanrifle = 20,
	weapon_marksmanrifle_mk2 = 20,
	
	-- Heavy Weapons
	weapon_rpg = 30,
	weapon_grenadelauncher = 30,
	weapon_grenadelauncher_smoke = 30,
	weapon_minigun = 30,
	weapon_firework = 30,
	weapon_railgun = 30,
	weapon_hominglauncher = 30,
	weapon_compactlauncher = 30,
	weapon_rayminigun = 30,
	
	-- Throwables
	weapon_grenade = 10,
	weapon_bzgas = 1,
	weapon_molotov = 10,
	weapon_stickybomb = 10,
	weapon_proxmine = 10,
	weapon_snowball = 1,
	weapon_pipebomb = 10,
	weapon_ball = 1,
	weapon_smokegrenade = 1,
	weapon_flare = 10,
	
	-- Miscellaneous
	weapon_petrolcan = 1,
	gadget_parachute = 1,
	weapon_fireextinguisher = 1,
	weapon_hazardcan = 1,
}

