--[[ 
    script: Skin System & Clothe Shop
    author: SM Developer
    discord: https://discord.gg/ZbJP9wptwB
    ทางเราขอบคุณเป็นอย่างยิ่งที่ท่านได้สนับสนุนสินค้าของเรา
]]

Config = Config or {}

Config['BlockClothe'] = { -- ใช้ได้กับโหมดการแต่งตัวเท่านั้น
    --[[ 
        -- ตัวอย่าง
        [1] = { -- ส่วนของลำดับ เป็นตัวเลข เรียงกัน ห้ามซ้ำ
            name = 'tshirt', -- ส่วนของเสื้อผ้า ไม่ต้องใส่หลัง _ เช่น tshirt_1 > tshirt, torso_1 > torso
            sex = 'm', -- ใช้ได้คือ  m และ f เป็น String 
            number = 10, -- ตัวเลขของโมเดลเสื้อผ้านั้นๆ
            colors = {0,1,2,3} -- ใส่หรือไม่ก็ได้ หากใส่ จะเป็นการบล็อคสีที่ใส่เอาไว้ทั้งหมด 
        }

    ]]


    --[1] = {name = 'tshirt', sex = 'm', number = 10, item = 'water' },
    --[2] = {name = 'tshirt', sex = 'm', number = 11, colors = {0, 1, 2, 3}},
    --[3] = {name = 'arms', sex = 'm', number = 10, colors = {0, 1, 2, 3}},
}

Config['ClothItems'] = {

    -- ตัวอย่าง
    -- ["water"] = { -- ชื่อ Item ที่กดใช้
    --     ["male"] = { -- ผู้ชาย
    --         tshirt_1 = 15,  tshirt_2 = 0,
    --         torso_1 = 115,   torso_2 = 0,
    --         decals_1 = 0,   decals_2 = 0,
    --         arms = 15,
    --         pants_1 = 21,   pants_2 = 0,
    --         shoes_1 = 34,   shoes_2 = 0,
    --         helmet_1 = -1,  helmet_2 = 0,
    --         chain_1 = 0,    chain_2 = 0,
    --         ears_1 = 0,     ears_2 = 0
    --     },
    --     ["female"] = { -- ผู้หญิง
    --         tshirt_1 = 15,  tshirt_2 = 0,
    --         torso_1 = 15,   torso_2 = 0,
    --         decals_1 = 0,   decals_2 = 0,
    --         arms = 15,
    --         pants_1 = 21,   pants_2 = 0,
    --         shoes_1 = 34,   shoes_2 = 0,
    --         helmet_1 = -1,  helmet_2 = 0,
    --         chain_1 = 0,    chain_2 = 0,
    --         ears_1 = 0,     ears_2 = 0
    --     }
    -- }

    --[[ ----------------------------------------------------- ]]

    --["water"] = { -- ชื่อ Item ที่กดใช้
    --    ["male"] = { -- ผู้ชาย
    --        tshirt_1 = 15,  tshirt_2 = 0,
    --        torso_1 = 115,   torso_2 = 0,
    --        arms = 15,
    --    },
    --    ["female"] = { -- ผู้หญิง
    --        tshirt_1 = 15,  tshirt_2 = 0,
    --        torso_1 = 15,   torso_2 = 0,
    --        arms = 15,
    --    }
    --},
    --["bread"] = { -- ชื่อ Item ที่กดใช้
    --    ["male"] = { -- ผู้ชาย
    --        pants_1 = 21,   pants_2 = 0,
    --        shoes_1 = 34,   shoes_2 = 0,
    --        helmet_1 = -1,  helmet_2 = 0,
    --        chain_1 = 0,    chain_2 = 0,
    --    },
    --    ["female"] = { -- ผู้หญิง
    --        pants_1 = 21,   pants_2 = 0,
    --        shoes_1 = 34,   shoes_2 = 0,
    --        helmet_1 = -1,  helmet_2 = 0,
    --        chain_1 = 0,    chain_2 = 0,
    --    }
    --}
}