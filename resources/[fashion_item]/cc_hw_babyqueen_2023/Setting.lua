Config = {}

-- เส้นทางกิจกรรมของทรัพยากร ESX Framework
Config["esx_routers"] = {
    ['getSharedObject'] = 'esx:getSharedObject'
}

Config['Items'] = {
	
    --[[["prop_bag1"] = {
		Model = "mamuang_acc_bagcat_christmas", 
		Bone = 24817, 
		xPos = 0.10,
		yPos = -0.24,
		zPos = 0.00,
		xRot = 0.50,
		yRot = -90.00,
        zRot = 180.0,
        Particle = {
            dict = 'proj_indep_firework_v2',
            particleName = 'scr_xmas_firework_burst_fizzle',
            delay = 2.5,
            Index = {
                offsetX = 0.1,
                offsetY = -0.3,
                offsetZ = 0.0,
                rotX = 0.0,
                rotY = 0.0,
                rotZ = 90.0,
                boneIndex = 35731,
                scale = 0.3
            }
        } 
    },]]
	
	["coffin"] = {
		Model = "halloween3",
		Bone = 0x29D2, ---ไหล่ขวา
		xPos = 0.095, 
		yPos = 0.000, 
		zPos = -0.495, 
		xRot = -180.300, 
		yRot = 166.700, 
		zRot = 0.000,
    },
	["blood"] = {
		Model = "halloween1", 
		Bone = 0x796E, ---หัว
		xPos = -0.640, 
		yPos = -0.030, 
		zPos = 0.050, 
		xRot = -181.500, 
		yRot = -86.800, 
		zRot = 6.200,
    },
	["fang"] = {
		Model = "halloween2", 
		Bone = 64729, ---ไหล่ซ้าย
		xPos = 0.145, 
		yPos = 0.000, 
		zPos = 0.505, 
		xRot = -177.700, 
		yRot = 19.300, 
		zRot = 0.000,
    },
	
}
