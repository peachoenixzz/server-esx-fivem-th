scriptName = GetCurrentResourceName()
Config = {

    ["Command"] = {
        ["AdminClass"] = {
            ["admin"] = true,
            ["superadmin"] = true,
        },
        -- ["Whitelist"] = {
        --     ["steam:110000103baa85c"] = true, -- identifier คนที่สามารถพิมพ์คำสั่งได้
        -- },
        ["Create"] = "createbox", -- สร้าง ตามด้วยชื่อ index Config["Crate"]
        ["Delete"] = "deletebox", -- ลบ ต้องไปยืนบนกล่องกดพิมพ์คำสั่ง
    },

    ["Crate"] = {
        ["crate1"] = {
            ["prop"] = "halloweenpose_prop2023_2", -- prop 
            ["propsize"] = 2.5, -- ขนาดวงเมื่อเข้าใกล้แล้วจะกดเก็บได้
            ["showdis"] = 50.0, -- ระยะเมื่อเข้าใกล้จะแสดงกล่อง เมื่อออกห่างจะหายไป
            ["anime"] = {
                "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
			    "machinic_loop_mechandplayer",
            },
            ["blacklistjob"] = { -- blacklist job ที่ไม่สามารถเก็บกล่องนี้ได้
                --["ambulance"] = true,
            },
            ["items"] = nil,
            ["itemsBonus"] = nil,
        },

        -- ["crate2"] = {
        --     ["prop"] = "halloweenpose_prop2023_1", -- prop 
        --     ["propsize"] = 2.0, -- ขนาดวงเมื่อเข้าใกล้แล้วจะกดเก็บได้
        --     ["showdis"] = 50.0, -- ระยะเมื่อเข้าใกล้จะแสดงกล่อง เมื่อออกห่างจะหายไป
        --     ["anime"] = {
        --         "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
		-- 	    "machinic_loop_mechandplayer",
        --     },
        --     ["blacklistjob"] = { -- blacklist job ที่ไม่สามารถเก็บกล่องนี้ได้
        --         --["ambulance"] = true,
        --     },
        --     ["items"] = {
        --         {itemName = 'meal_mre', quantity = {5, 10},},
        --     },
        --     ["itemsBonus"] = {
        --         { itemName = 'gov_skeleton', percent = 0.50, quantity = {1, 5}}, 
        --     },
        -- },
    },
}


