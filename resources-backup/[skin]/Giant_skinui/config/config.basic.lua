-- Giant Dev 
-- https://discord.gg/AgutpzcVzv
-- Custom ui for your Server 
-- 19 - 8 - 65 
-- ▀█▀ █░█ ▄▀█ █▄░█ █▄▀   █▀▀ █▀█ █▀█   █▀ █░█ █▀█ █▀█ █▀█ █▀█ ▀█▀ █▀
-- ░█░ █▀█ █▀█ █░▀█ █░█   █▀░ █▄█ █▀▄   ▄█ █▄█ █▀▀ █▀▀ █▄█ █▀▄ ░█░ ▄█
-- //////////////////////////////////////////////////////////////////////////////////////////////////
Config = {}
Config['base'] = 'esx'
Config['base_skin'] = 'esx_skin_giant'

Config.EventRoute = {
    ['getSharedObject'] = 'esx:getSharedObject', -- Default: 'esx:getSharedObject'
    ['base_skin'] = 'esx_skin', -- Default: 'esx_skin'
    ['playerLoaded'] = 'esx:playerLoaded', -- Default: 'esx:playerLoaded'
    ['playerDropped'] = 'esx:playerDropped', -- Default: 'esx:playerDropped'
    ['onPlayerDeath'] = 'esx:onPlayerDeath', -- Default: 'esx:onPlayerDeath'
    ['onPlayerSpawn'] = 'playerSpawned', -- Default: 'esx:onPlayerSpawn'
    ['setJob'] = 'esx:setJob', -- Default: 'esx:setJob'
    ['setAccountMoney'] = 'esx:setAccountMoney', -- Default: 'esx:setAccountMoney'
    ['removedMoney'] = 'es:removedMoney' -- Default: 'es:removedMoney'
}

Config.KeyOpen = 'E' -- ปุ่มเปิดเมนู
Config.Skinprice = 10000 -- ค่าเพิ่ม skin
Config.wardrobePrice = 500 -- ราคาค่าเก็บเสื้อผ้า
Config.wardrobeslot = 500 -- ค่าเพิ่ม slot เสื้อผ้า

-- โหมดปรับสี UI
Config.debug = false

-- คนที่มีสิทธิ์บันทึกข้อมูล
Config.restricts = {['admin'] = false, ['superadmin'] = false}

-- ขนาดไฟล์โลโก 475 * 180 -  ตัวอย่าง -- https://media.discordapp.net/attachments/1030214760345641000/1045497989008998421/mainUI.png
-- แนะนำให้เอารูปที่ ไปทับใน dist/assets/.png
Config.logo =
    'https://media.discordapp.net/attachments/1065600100618997810/1079063591396843520/head_dex.png' -- ใส่ลิงค์รูปภาพ discord

Config.nameskin = 'Skin Menu'
-- เปิดให้บันทึก true ข้อมูล แว่น หมวก ตุ้มหู ลงกระเป๋าหรือไม่ เชื่อมกับกระเป๋า nc
-- ถ้า false ปิด จะบันทึก แว่น หมวก ตุ้มหู แต่ยังบันทึกหน้ากากอยู่ ในหมวดรีสกิน
Config.accessoriesNcsave = true
Config.AdditemAccessoryNC = true -- nc add item ฝั่ง sv

Config.blockCloth = true
-- เชื่อมตู้เสื้อผ้า บันทึกชุดเข้าตู้
Config.outlet = true
--  limit จำนวนตู้เสื้อผ้า
Config.limitWardrobe = 10
-- TriggerEvent("Giant_skinui:OpenWardrobe") สำหรับเปิดตู้เสื้อผ้า ผ่านไอเทม ต่างๆ ไปเรียกใช้ในสคลิปอื่นๆ

Config.wardrobe = {
    itemWardrobeUse = true, --เปิดตู้เสื้อผ้าผ่านไอเทม
    itemWardrobe = 'petrol', -- ไอเทมที่ใช้เปิดตู้เสื้อผ้า
    itemdeleteafterUse = true,  -- หลังกดใช้ให้ลบหรือไม่ลบไอเทมนี้
}

Config.hideplayerRadius = 30 -- ระยะในการซ่อนผู้เล่น เวลาเปิดใช้ functions ซ่อน!
-- ///////// เชื่อมปล้น
-- pcall(function()
--     exports["Giant_skinui"]:getThief(true,10)  --  10 คือจำนวนเวลาติด cd ใช้ร้าน 10 นาที กดปล้นใหม่เวลาก็นับใหม่ 
-- end)
-- /////// เชื่อมปล้น 

-- function สำหรับ block พวกโกนหัว หรือถ้าต้องการให้บล็อคอะไรโยน function มาเช็คได้ ต
-- ถ้าไม่อยากให้ ใช้งานร้านค้าได้ให้ return true ไป
Config['blockEvent'] = function()
    pcall(function()
        -- if exports.Headron_GpG:CoolDownWaring() >= 1 then
        --     return true 
        -- end
    end)

    return false  -- ห้ามลบออก false หมายถึงเข้าใช้งานร้านได้ true จะใช้งานไม่ได้
end

Config['alertBlock'] = function()
    -- if exports.Headron_GpG:CoolDownWaring() >= 1 then
    --     exports.pNotify:SendNotification({text = 'คุณพึ่งก่อเหตุมากรุณารอ '..exports.Headron_GpG:CoolDownWaring()..' นาที', timeout = 5000})
    --  end
end


Config['รายการชุดที่จะให้บันทึกเข้าตู้เสื้อผ้า'] = {
    'tshirt_1', 'tshirt_2', 'torso_1', 'torso_2', 'decals_1', 'decals_2',
    'arms', 'arms_2', 'pants_1', 'pants_2', 'shoes_1', 'shoes_2', 'chain_1',
    'chain_2', 'helmet_1', 'helmet_2', 'bproof_1', 'watches_1', 'watches_2',
    'bproof_2', 'bags_1', 'bags_2', 'glasses_1', 'glasses_2'
}
-- 7-3-66 เพิ่ม function เช็คนะครับ ว่า เพศของคนที่กดเรียกใช้งาน ตู้เสื้อผ้า ตรงกับ ปัจจุบันไหม
-- รายการที่จะบันทึกใน ตู้เสื้อผ้า เปิดปิดตามรายการร้านเสื้อผ้าจะเข้ากันกับระบบมากที่สุด
Config.listofSaveCloth = function(skin)
    local itemSkin = {}
    itemSkin['sex'] = skin['sex'] -- ห้ามลบ
    for _, v in pairs(Config['รายการชุดที่จะให้บันทึกเข้าตู้เสื้อผ้า']) do itemSkin[v] = skin[v] end
    return itemSkin
end

-- name addslotwardrobe เพิ่ม slot ตู้ / name = addwardrobe เพิ่มชุดใส่ตู้เสื้อผ้า
-- name อื่น ตาม key ใน config.zones
Config['สำหรับอัพเดทเควส'] = function (zone,name)
    -- print(zone, json.encode(name, {indent = true}))
end
-- กรุณากรอกจำนวน รายการในร้านดังนี้ เพื่อให้ระบบเช็คว่า คำนวณเงินให้ถูกต้อง
-- เช่น ร้าน เสื้อผ้ามี 22 รายการใส่ / ร้านทำผม มี 20
Config.itemreskinUse = true
Config.itemreskin = 'card_reskin' -- ไอเทมรีสกิน
-- หากใช้กระเป๋า nc จะปิดกระเป๋าให้เองนะครับ
-- อย่าลืมไปฝั่งปิดกระเป๋า ตอนใช้ไอเทมนี้ด้วยนะครับ
-- /////////////////////////////// UPDATE 28/11/2022 ////////////////////////////////////////
Config['สีวงเริ่มต้น'] = vector4(0, 204, 204, 100) -- สีวงเริ่มต้น ตอนที่ยังไม่เดินเข้าไปใน marker
Config.Blip = {UseNearblip = true, Range = 300, tricktime = 5000}

Config.Zones = {
    --Ears = {
    --    name = 'Ears',
    --    price = 500,
    --    lists = {'ears_1','ears_2'},
    --    Textui = 'เปิดร้านตุ้มหู',
    --    zoomOffset = 0.6,
    --    camOffset = 0.65,
    --    Pos = {
    --        {coord = vector3(80.374, -1389.493, 28.406), blip = true},
    --        {coord = vector3(-709.426, -153.829, 36.535), blip = true},
    --        {coord = vector3(-163.093, -302.038, 38.853), blip = true},
    --        {coord = vector3(420.787, -809.654, 28.611), blip = true},
    --        {coord = vector3(-817.070, -1075.96, 10.448), blip = true},
    --        {coord = vector3(-1451.300, -238.254, 48.929), blip = true},
    --        {coord = vector3(-0.756, 6513.685, 30.997), blip = true},
    --        {coord = vector3(123.431, -208.060, 53.677), blip = true},
    --        {coord = vector3(1687.318, 4827.685, 41.183), blip = true},
    --        {coord = vector3(622.806, 2749.221, 41.208), blip = true},
    --        {coord = vector3(1200.085, 2705.428, 37.342), blip = true},
    --        {coord = vector3(-1199.959, -782.534, 16.452), blip = true},
    --        {coord = vector3(-3171.867, 1059.632, 19.983), blip = true},
    --        {coord = vector3(-1095.670, 2709.245, 18.227), blip = true}
    --    },
    --    Marker = {
    --        Type = 27,
    --        r = 102,
    --        g = 102,
    --        b = 204,
    --        Size = {x = 1.5, y = 1.5, z = 1.0}
    --    }
    --},

    --Helmet = {
    --    name = 'Helmet',
    --    price = 750,
    --    lists = {'helmet_1', 'helmet_2'},
    --    Textui = 'เปิดร้านหมวก',
    --    zoomOffset = 0.6,
    --    camOffset = 0.65,
    --    Pos = {
    --
    --        {coord = vector3(81.576, -1400.602, 28.406), blip = true},
    --        {coord = vector3(-705.845, -159.015, 36.535), blip = true},
    --        {coord = vector3(-161.349, -295.774, 38.853), blip = true},
    --        {coord = vector3(419.319, -800.647, 28.611), blip = true},
    --        {coord = vector3(-824.362, -1081.741, 10.448), blip = true},
    --        {coord = vector3(-1454.888, -242.911, 48.931), blip = true},
    --        {coord = vector3(4.770, 6520.935, 30.997), blip = true},
    --        {coord = vector3(121.071, -223.266, 53.377), blip = true},
    --        {coord = vector3(1689.648, 4818.805, 41.183), blip = true},
    --        {coord = vector3(613.971, 2749.978, 41.208), blip = true},
    --        {coord = vector3(1189.513, 2703.947, 37.342), blip = true},
    --        {coord = vector3(-1204.025, -774.439, 16.452), blip = true},
    --        {coord = vector3(-3164.280, 1054.705, 19.983), blip = true},
    --        {coord = vector3(-1103.125, 2700.599, 18.227), blip = true}
    --
    --    },
    --    Marker = {
    --        Type = 27,
    --        r = 102,
    --        g = 102,
    --        b = 204,
    --        Size = {x = 1.5, y = 1.5, z = 1.0}
    --    }
    --},

    --Glasses = {
    --    name = 'Glasses',
    --    price = 1200,
    --    lists = {'glasses_1', 'glasses_2'},
    --    Textui = 'เปิดร้านแว่น',
    --    zoomOffset = 0.6,
    --    camOffset = 0.65,
    --    Pos = {
    --
    --        {coord = vector3(75.287, -1391.131, 28.406), blip = true},
    --        {coord = vector3(-713.102, -160.116, 36.535), blip = true},
    --        {coord = vector3(-156.171, -300.547, 38.853), blip = true},
    --        {coord = vector3(425.478, -807.866, 28.611), blip = true},
    --        {coord = vector3(-820.853, -1072.940, 10.448), blip = true},
    --        {coord = vector3(-1458.052, -236.783, 48.918), blip = true},
    --        {coord = vector3(3.587, 6511.585, 30.997), blip = true},
    --        {coord = vector3(131.335, -212.336, 53.677), blip = true},
    --        {coord = vector3(1694.936, 4820.837, 41.183), blip = true},
    --        {coord = vector3(613.972, 2768.814, 41.208), blip = true},
    --        {coord = vector3(1198.678, 2711.011, 37.342), blip = true},
    --        {coord = vector3(-1188.227, -764.594, 16.452), blip = true},
    --        {coord = vector3(-3173.192, 1038.228, 19.983), blip = true},
    --        {coord = vector3(-1100.494, 2712.481, 18.227), blip = true}
    --
    --    },
    --    Marker = {
    --        Type = 27,
    --        r = 102,
    --        g = 102,
    --        b = 204,
    --        Size = {x = 1.5, y = 1.5, z = 1.0}
    --    }
    --},

    --Mask = {
    --    name = 'Mask',
    --    price = 1100,
    --    lists= {'mask_1', 'mask_2'},
    --    Textui = 'ร้านหน้ากาก',
    --    zoomOffset = 0.6,
    --    camOffset = 0.65,
    --    Pos = {{coord = vector3(-1338.129, -1278.200, 3.872), blip = false}},
    --    Marker = {
    --        Type = 27,
    --        r = 102,
    --        g = 102,
    --        b = 204,
    --        Size = {x = 3.0, y = 3.0, z = 1.0}
    --    },
    --    Blip = {
    --        Text = '<font face="font4thai">ร้านหน้ากาก</font>',
    --        Scale = 0.5,
    --        Colour = 51,
    --        Sprite = 362,
    --        Display = 4
    --    }
    --},
    -- Skin = {
    --     name = 'Skin',
    --     price = 50000,
    --     lists= nil,  -- nil แสดงรายการทุกอย่างในร้านค้า
    --     Textui = 'Skin',
    --     zoomOffset = 0.6,
    --     camOffset = 0.65,

    --     Pos = {{coord = vector3(161.72000122070312, -157.3000030517578, 55.25), blip = true}},
    --     Marker = {
    --         Type = 27,
    --         r = 102,
    --         g = 102,
    --         b = 204,
    --         Size = {x = 1.5, y = 1.5, z = 1.0}
    --     },
    --     Blip = {
    --         Text = '<font face="font4thai">ร้านสกิน</font>',
    --         Scale = 0.5,
    --         Colour = 51,
    --         Sprite = 362,
    --         Display = 4
    --     }
    -- },
    Clothes = {
        name = 'Clothes',
        price = 500,
        lists = { 'helmet_1', 'helmet_2','ears_1','ears_2','tshirt_1', 'tshirt_2', 'torso_1', 'torso_2', 'decals_1', 'decals_2',
        'arms', 'arms_2', 'pants_1', 'pants_2', 'shoes_1', 'shoes_2', 'chain_1',
        'chain_2', 'helmet_1', 'helmet_2', 'bproof_1', 'watches_1', 'watches_2','bracelets_1','bracelets_2',
        'bproof_2', 'bags_1', 'bags_2', 'glasses_1', 'glasses_2'},
        -- รายการที่อยู่ของร้านเสื้อ
        Textui = 'เพื่อแต่งตัว',
        zoomOffset = 1.25,
        camOffset = 0.35,
        Pos = {
            {coord = vector3(72.254, -1399.102, 28.376), blip = false},
            {coord = vector3(-703.776, -152.258, 36.415), blip = false},
            {coord = vector3(-167.863, -298.969, 38.733), blip = false},
            {coord = vector3(428.694, -800.106, 28.491), blip = false},
            {coord = vector3(-829.413, -1073.710, 10.328), blip = false},
            {coord = vector3(-1447.797, -242.461, 48.820), blip = false},
            {coord = vector3(123.646, -219.440, 53.557), blip = false},
            {coord = vector3(-1193.429, -772.262, 16.324), blip = false},
            --{coord = vector3(-3172.496, 1048.133, 19.863), blip = false},
            --{coord = vector3(-1108.441, 2708.923, 18.107), blip = false}

        },
        Marker = {
            Type = 1,
            r = 0,
            g = 204,
            b = 204,
            Size = {x = 3.5, y = 3.5, z = 1.0}
        },
        Blip = {
            Text = '<font face="font4thai">ร้านเสื้อผ้า</font>',
            Scale = 0.5,
            Colour = 51,
            Sprite = 73,
            Display = 4
        }
    },

    -- ร้าน ตู้เสื้อผ้า / สำหรับบ้านแก๊งหรือหน่วยงาน หรือเป็นวง ตู้เสื้อผ้า
    --Wardrobe = {
    --    Textui = 'ตู้เสื้อผ้า',
    --    Pos = {
    --
    --        {
    --            coord = vector3(130.80999755859375, -203.11000061035156, 53.8),
    --            blip = true
    --        }
    --
    --    },
    --    Marker = {
    --        Type = 27,
    --        r = 102,
    --        g = 102,
    --        b = 204,
    --        Size = {x = 1.5, y = 1.5, z = 1.0}
    --    }
    --},
    Barber = {
        name = 'Barber',
        price = 250,
        lists = {
            'beard_1', 'beard_2', 'beard_3', 'beard_4', 'hair_1', 'hair_2',
            'hair_color_1', 'hair_color_2', 'eyebrows_1', 'eyebrows_2', 'eyebrows_3',
            'eyebrows_4', 'makeup_1', 'makeup_2', 'makeup_3', 'makeup_4', 'lipstick_1',
            'lipstick_2', 'lipstick_3', 'lipstick_4', 'ears_1', 'ears_2','blush_1','blush_2','blush_3'
        },
        -- รายการที่อยู่ของร้านทำผม
        Textui = 'เพื่อทำผม',
        zoomOffset = 0.6,
        camOffset = 0.65,
        Pos = {

            {coord = vector3(-814.308, -183.823, 36.568), blip = false},
            {coord = vector3(136.826, -1708.373, 28.291), blip = false},
            {coord = vector3(-1282.604, -1116.757, 5.990), blip = false},
            {coord = vector3(1931.513, 3729.671, 31.844), blip = false},
            {coord = vector3(1212.840, -472.921, 65.208), blip = false},
            {coord = vector3(-32.885, -152.319, 56.076), blip = false},
            {coord = vector3(-278.077, 6228.463, 30.695), blip = false}

        },
        Blip = {
            Text = '<font face="font4thai">ร้านตัดผม</font>',
            Scale = 0.5,
            Colour = 51,
            Sprite = 71,
            Display = 4
        },
        Marker = {
            Type = 1,
            r = 0,
            g = 204,
            b = 204,
            Size = {x = 1.5, y = 1.5, z = 1.0}
        }
    }
}


Config.textui = {
    on = false, -- true เปิดใช้งาน textui ของร้านหรือไม่
    runningHighLoop = true, -- อธิบายคือ true สำหรับใส่กับ textui loop 0 / false คือ ไม่ใช้ -- ต้องปรับ on เป็น false
    -- ถ้าจะใช้ textui ของตัวระบบ on = true และ  runningHighLoop = false เท่านั้น
    -- false เพื่อ เปิดใช้ function ด้านล่าง
    -- รองรับเฉพาะ text toggle open or clock 
    -- ไม่ได้ให้ textui วิ่งใน looptime 0
    -- textui เปิดในขณะเดินเข้าโซน
    EnterzoneTextui = function(namezone)
        if namezone then
            exports.helpnotify:showHelpNotification("กด","E",namezone)
        end
    end,
    -- textui ปิดในขณะเดินออกโซน
    ExitzoneTextui = function() -- ถ้า runningHighLoop = true ไม่ต้องใส่อะไร
        exports.helpnotify:hideHelpNotification()
    end
}

Config.textuiNewPlayerSkin = {
    on = false, -- true เปิดใช้งาน textui ของร้านหรือไม่
    runningHighLoop = true, -- อธิบายคือ สำหรับใส่กับ textui loop 0 / false คือ ไม่ใช้ -- ต้องปรับ on เป็น false
    -- ถ้าจะใช้ textui ของตัวระบบ on = true และ  runningHighLoop = false เท่านั้น
    -- false เพื่อ เปิดใช้ function ด้านล่าง
    -- รองรับเฉพาะ text toggle open or clock 
    -- ไม่ได้ให้ textui วิ่งใน looptime 0
    -- textui เปิดในขณะเดินเข้าโซน
    EnterzoneTextui = function(namezone)
        if namezone then
            exports.helpnotify:showHelpNotification("กด","E",namezone)
        end
    end,
    -- textui ปิดในขณะเดินออกโซน
    ExitzoneTextui = function() -- ถ้า runningHighLoop = true ไม่ต้องใส่อะไร
        exports.helpnotify:hideHelpNotification()
    end
}

-- วงแต่งตัวสำหรับผู้เล่นใหม่ 
Config.keyopenNewplayerSkin = "E" -- ปุ่มเปิดเมนู
Config['วงแต่งตัวผู้เล่นใหม่'] = false
Config.DistanceMarker = 30 -- ระยะการมองเห็น Marker

Config.Zone = {
    --{
    --    name = 'แปลงร่าง',
    --    item = "card_reskin",
    --    Type = 1, -- ลักษณะวง
    --    sizex = 15.0, -- ไซส์วง X  ขนาดของวง
    --    sizey = 15.0, -- ไซส์วง Y ขนาดของวง
    --    sizez = 10.0, -- ไซส์วง Z ขนาดของวง
    --    r = 237, -- สีแดง
    --    g = 123, -- สีเขียว
    --    b = 153, -- สีน้ำเงิน
    --    coords = vector3(378.26, -1402.61, 32.51),
    --},
    --{
    --    name = 'จุดแต่งตัวผู้เล่นใหม่',
    --    item = 'water',
    --    Type = 1, -- ลักษณะวง
    --    sizex = 5.0, -- ไซส์วง X  ขนาดของวง
    --    sizey = 5.0, -- ไซส์วง Y ขนาดของวง
    --    sizez = 3.0, -- ไซส์วง Z ขนาดของวง
    --    r = 237, -- สีแดง
    --    g = 123, -- สีเขียว
    --    b = 153, -- สีน้ำเงิน
    --    coords = vector3(161.4199981689453, -202.35000610351565, 54.31000137329101),
    --},

}

---------------Database----------------

Config.checkClothDB =
    'SELECT * FROM meeta_accessory_inventory where owner = @owner and type = @type'

Config.deleteDB = 'DELETE FROM meeta_accessory_inventory WHERE `id` = @id'

Config.checkCountDB =
    'SELECT count(id) as c FROM meeta_accessory_inventory where owner = @user and type = "player_clothes"'

Config.addwardrobeDB =
    'INSERT INTO meeta_accessory_inventory (owner, label, skin, type) VALUES (@owner, @label, @skin, @type)'

Config.addAccessoryDB =
    'INSERT INTO meeta_accessory_inventory (owner, label, skin, type) VALUES (@owner, @label, @skin, @type)'
