Config = {}

Config.Setting = {
	["ระบบ"] = 'weight'   -- weight To limit
}

Config.PosSound = {
    Sound = {
        {x = 566.86, y = 6671.34, z = 9.94},
        {x = 526.05, y = 6698.85, z = 7.11,},
    }
}

Config.SoundSetup = {
    TimeSound = 20000,
    Place1 = "ghost", 
    Place2 = "playsound",
    Fountghost = "ghosts",
	-- FountHome = "Home"
}

Config.GhostSetup = {
    Model = "2BS",
	-- Model = "u_f_m_drowned_01",
	-- Model = "u_f_m_drowned_01",
	-- Model = "u_f_m_drowned_01",
	-- Model = "u_f_m_drowned_01",
    TimeFound = 5000,
}

Config.ItemSetup = {
    Itemname = "bread",
    Amount = 1,
    Pos = {
        {x = 575.99, y = 6689.5, z =7.24},
		-- {x = 575.99, y = 6689.5, z =7.24},
		-- {x = 575.99, y = 6689.5, z =7.24},
		-- {x = 575.99, y = 6689.5, z =7.24},
		-- {x = 575.99, y = 6689.5, z =7.24},
		-- {x = 575.99, y = 6689.5, z =7.24},
		-- {x = 575.99, y = 6689.5, z =7.24},
		-- {x = 575.99, y = 6689.5, z =7.24},
		-- {x = 575.99, y = 6689.5, z =7.24},
    }

}

Config.ItemBonus = {
	-- {
    --     ItemName = "egg_golden",
    --     ItemCount = 1,
    --     Percent = 3
	-- },
}

-------------------------------------------
----- function Notification limit----------
-------------------------------------------

function Inventoryfull()
	TriggerClientEvent("pNotify:SendNotification", source, {
		text = '<span class="red-text">กระเป๋าเต็ม</span> ',
		type = "success",
		timeout = 3000,
		layout = "bottomCenter",
		queue = "global"
	}) 
end

function Inventoryfull2()
	TriggerClientEvent("pNotify:SendNotification", source, {
		text = '<span class="red-text">กระเป๋าเต็มเก็บไอเทมโบนัทไม่ได้</span> ',
		type = "success",
		timeout = 3000,
		layout = "bottomCenter",
		queue = "global"
	}) 
end
--------------------------------------------
----- function Notification weight----------
--------------------------------------------
function Inventoryfullweight()
	TriggerClientEvent("pNotify:SendNotification", source, {
		text = '<span class="red-text">น้ำหนักในกระเป๋าคุณเต็ม</span> ',
		type = "success",
		timeout = 3000,
		layout = "bottomCenter",
		queue = "global"
	}) 
end

function InventoryfullBonusweight()
	TriggerClientEvent("pNotify:SendNotification", source, {
		text = '<span class="red-text">น้ำหนักไอเทมโบนัสคุณเต็ม</span> ',
		type = "success",
		timeout = 3000,
		layout = "bottomCenter",
		queue = "global"
	}) 
end