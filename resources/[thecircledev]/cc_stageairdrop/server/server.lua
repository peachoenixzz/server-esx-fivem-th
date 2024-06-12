ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local breakSpawnAir = false
local airdropState = false
local coordsChooseGang = nil
local coordsChoosePeople = nil
local coordsChooseFamily = nil
local gangStage = 0
local peopleStage = 0
local familyStage = 0
local systemProcessGang = false
local systemProcessPeople = false
local systemProcessFamily = false
local timeStart
local airdropPositionGang = {
    --vector3(-3137.986816, -2410.232910, 717.308350)
    vector3(-3243.059326, -2868.408692, 753.389648)
}

local airdropPositionPeople = {
    --vector3(-2476.694580, -3449.156006, 1106.758300)
    vector3(-561.283508, -5649.217774, 1135.577392)
}

local airdropPositionFamily = {
    vector3(-3747.02001953125, 296.739990234375, 1234.8900146484375)
}

local playerPeopleStage = {
    black = {},
    red = {},
    green = {},
    blue = {},
    white = {},
}

local playerGangStage = {
    a = {
        logo = "atr.png",
        color = "#FFFFFF",
        group = "a",
        slot = {}
    },
    b = {
        logo = "alt.png",
        color = "#3A1078",
        group = "b",
        slot = {}
    },
    c = {
        logo = "itv.png",
        color = "#0000FF",
        group = "c",
        slot = {}
    },
    d = {
        logo = "nk.png",
        color = "#000000",
        group = "d",
        slot = {}
    },
    -- e = {
    --     logo = "ws.png",
    --     color = "#000518",
    --     group = "e",
    --     slot = {}
    -- },
}

local playerFamilyStage = {
    a = {
        logo = "sum.png",
        color = "#00FF00",
        group = "a",
        slot = {}
    },
    b = {
        logo = "bvl.png",
        color = "#290000",
        group = "b",
        slot = {}
    },
    c = {
        logo = "vp.png",
        color = "#84bcd6",
        group = "c",
        slot = {}
    },
    d = {
        logo = "skz.png",
        color = "#01153e",
        group = "d",
        slot = {}
    },
    e = {
        logo = "rm.png",
        color = "#ffffff",
        group = "e",
        slot = {}
    },
    f = {
        logo = "bbc.png",
        color = "#ff6600",
        group = "f",
        slot = {}
    },
    g = {
        logo = "gbt.png",
        color = "#4f4f4f",
        group = "g",
        slot = {}
    },
    h = {
        logo = "pnk.png",
        color = "#191970",
        group = "h",
        slot = {}
    },
    i = {
        logo = "ds.png",
        color = "#e800ff",
        group = "i",
        slot = {}
    },
    j = {
        logo = "trh.png",
        color = "#000000",
        group = "j",
        slot = {}
    },
    k = {
        logo = "hbb.png",
        color = "#da3e2d",
        group = "k",
        slot = {}
    },
}

local inProgress = {}
local playerCanConfirmLoot = {
    gang = 0,
    people = 0,
    family = 0
}
local alreadyRegister = {}

function handleErrorAndNotify(xPlayer,err)
    if err == "not_done" then
        exports.nc_notify:PushNotification(xPlayer.source,{
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบ Airdrop', -- หัวเรื่อง
            description = 'กำลังกอบกู้สถานะการณ์เลวร้าย', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'error', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'cooldown', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 5000 -- ระยะเวลาการแสดง Notify
        })
    end
    if err == "time_up" then
        exports.nc_notify:PushNotification(xPlayer.source,{
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบ Airdrop', -- หัวเรื่อง
            description = 'ห้ามเข้า เนื่องจากเป็นช่วงของระบบประมวลผล', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'cooldown', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 5000 -- ระยะเวลาการแสดง Notify
        })
    end
    if err == "not_availiable" then
        exports.nc_notify:PushNotification(xPlayer.source,{
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบ Airdrop', -- หัวเรื่อง
            description = 'ไม่ได้อยู่ในช่วงเวลาเข้าร่วม', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'cooldown', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 5000 -- ระยะเวลาการแสดง Notify
        })
    end
    if err == "not_require_item" then
        exports.nc_notify:PushNotification(xPlayer.source,{
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบ Airdrop', -- หัวเรื่อง
            description = 'คุณไม่มีสิ่งของที่กำหนด', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'no_item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 3000 -- ระยะเวลาการแสดง Notify
        })
    end
    if err == "not_yet_loot" then
        exports.nc_notify:PushNotification(xPlayer.source,{
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบ Airdrop', -- หัวเรื่อง
            description = 'กรุณาเคลียศัตรูให้เรียบร้อย', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'group', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 3000 -- ระยะเวลาการแสดง Notify
        })
    end
    if err == "have_card" then
        exports.nc_notify:PushNotification(xPlayer.source,{
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบ Airdrop', -- หัวเรื่อง
            description = 'คุณเป็นแก๊งไม่ใช่ประชาชน', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'no_group', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 3000 -- ระยะเวลาการแสดง Notify
        })
    end
    if err == "team_full" then
        exports.nc_notify:PushNotification(xPlayer.source,{
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบ Airdrop', -- หัวเรื่อง
            description = 'ทีมที่คุณจะเลือกนั้นเต็มแล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'no_gourp', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 3000 -- ระยะเวลาการแสดง Notify
        })
    end
    if err == "done_item" then
        exports.nc_notify:PushNotification(xPlayer.source,{
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบ Airdrop', -- หัวเรื่อง
            description = 'มีผู้ได้รับไอเทมในรอบนี้แล้ว', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 3000 -- ระยะเวลาการแสดง Notify
        })
    end
    if err == "maintain" then
        exports.nc_notify:PushNotification(xPlayer.source,{
            scale = 1.0, -- ปรับขนาดของ Notify
            title = 'ระบบ Airdrop', -- หัวเรื่อง
            description = 'อยู่ในช่วงทดสอบระบบ', -- รายละเอียด หากต้องการให้แสดงปุ่มกดให้ใช้ tag <btn></btn>
            type = 'warning', -- ชนิดของ Notify * หากไม่ใส่จะเป็น 'info'
            position = 'top', -- ตำแหน่งการแสดง ('top': บน | 'bottom': ล่าง) * หากไม่ใส่จะเป็น 'top'
            direction = 'right', -- ตำแหน่งการแสดง ('left': ซ้าย | 'center': กลาง' | 'right': ขวา) * หากไม่ใส่จะเป็น 'right'
            priority = 'medium', -- ความสำคัญของ Notify นั้นๆ high จะอยู่บน และ low จะอยู่ล่าง * หากไม่ใส่จะเป็น 'medium'
            icon = 'item', -- Icon (html/img/icons) ที่ต้องการให้แสดง (ใช้ไม่ได้กับ category = 'item')
            duration = 3000 -- ระยะเวลาการแสดง Notify
        })
    end
end
--เริ่มตรงนี้
ESX.RegisterServerCallback('cc_stageairdrop:requestData', function(source, cb, airdropType)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if type(inProgress[source]) ~= "nil" then
        if inProgress[source] then
            print("request data")
            handleErrorAndNotify(xPlayer,"not_done")
            cb(false,nil)
            return
        end
    end

    inProgress[source] = true
    if airdropType == "gang" then
        local xItemGang = xPlayer.getInventoryItem("card_gang")
        if xItemGang.count == 0 then
            handleErrorAndNotify(xPlayer,"not_require_item")
            cb(false)
            inProgress[source] = nil
            return
        end
        cb(true,playerGangStage)
        inProgress[source] = nil
        return
    end

    if airdropType == "family" then
        local xItemFamily = xPlayer.getInventoryItem("card_family")
        if xItemFamily.count == 0 then
            handleErrorAndNotify(xPlayer,"not_require_item")
            cb(false)
            inProgress[source] = nil
            return
        end
        cb(true,playerFamilyStage)
        inProgress[source] = nil
        return
    end

    if airdropType == "people" then
        local xItemGang = xPlayer.getInventoryItem("card_gang")
        if xItemGang.count > 0 then
            handleErrorAndNotify(xPlayer,"have_card")
            cb(false)
            inProgress[source] = nil
            return
        end
        local xItemFamily = xPlayer.getInventoryItem("card_family")
        if xItemFamily.count > 0 then
            handleErrorAndNotify(xPlayer,"have_card")
            cb(false)
            inProgress[source] = nil
            return
        end
        cb(true,playerPeopleStage)
        inProgress[source] = nil
        return
    end

    if airdropType == "position-p" then
        cb(true,coordsChoosePeople)
        inProgress[source] = nil
        return
    end

    if airdropType == "position-g" then
        cb(true,coordsChooseGang)
        inProgress[source] = nil
        return
    end

    if airdropType == "position-f" then
        cb(true,coordsChooseFamily)
        inProgress[source] = nil
        return
    end
    inProgress[source] = nil
end)
------------------------------------------------------------------------------------------------------------
ESX.RegisterServerCallback('cc_stageairdrop:confirmLoot', function(source, cb, airdropType,lastTeamAlive)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if type(inProgress[source]) ~= "nil" then
        if inProgress[source] then
            handleErrorAndNotify(xPlayer,"not_done")
            cb(false,nil)
            return
        end
    end

    inProgress[source] = true
    if airdropType == "gang" then
        if playerCanConfirmLoot.gang ~= source then
            handleErrorAndNotify(xPlayer,"done_item")
            cb(false,nil)
            inProgress[source] = nil
            return
        end

        local xItemGang = xPlayer.getInventoryItem("card_gang")
        if xItemGang.count == 0 then
            handleErrorAndNotify(xPlayer,"not_require_item")
            cb(false)
            inProgress[source] = nil
            return
        end

        calculateitemStageAirdrop(airdropType, xPlayer)
        calculateitemBonusStageAirdrop(airdropType, xPlayer)
        resetFlow(airdropType,lastTeamAlive)
        local template =
        [[
            <div style="padding: 7px; margin-bottom: 8px; background-image: linear-gradient(to right, rgba(0, 51, 0, 0.7), rgba(0, 153, 0, 0.5)); border-radius: 7px; width: 605px; display: flex; align-items: center; font-size: 18px;"/>
            <img src="https://img2.pic.in.th/pic/airdrop-1.png" style="width: 20px; height: 20px; padding-right: 7px; padding-left: 7px;" />{0}: {1}
            <br></div>
        ]]
        local msg = xPlayer.getName() .. " ได้รับของจากแอร์ดรอปแก๊ง"
        local fal = ' แอร์ดรอป'
        TriggerClientEvent('chat:addMessage', -1, {
            template = template,
            args = { fal, msg }
        })
        cb(true)
        inProgress[source] = nil
        return
    end

    if airdropType == "family" then
        if playerCanConfirmLoot.family ~= source then
            handleErrorAndNotify(xPlayer,"done_item")
            cb(false,nil)
            inProgress[source] = nil
            return
        end

        local xItemFamily = xPlayer.getInventoryItem("card_family")
        if xItemFamily.count == 0 then
            handleErrorAndNotify(xPlayer,"not_require_item")
            cb(false)
            inProgress[source] = nil
            return
        end

        calculateitemStageAirdrop(airdropType, xPlayer)
        calculateitemBonusStageAirdrop(airdropType, xPlayer)
        resetFlow(airdropType,lastTeamAlive)
        local template =
        [[
            <div style="padding: 7px; margin-bottom: 8px; background-image: linear-gradient(to right, rgba(0, 51, 0, 0.7), rgba(0, 153, 0, 0.5)); border-radius: 7px; width: 605px; display: flex; align-items: center; font-size: 18px;"/>
            <img src="https://img2.pic.in.th/pic/airdrop-1.png" style="width: 20px; height: 20px; padding-right: 7px; padding-left: 7px;" />{0}: {1}
            <br></div>
        ]]
        local msg = xPlayer.getName() .. " ได้รับของจากแอร์ดรอปครอบครัว"
        local fal = ' แอร์ดรอป'
        TriggerClientEvent('chat:addMessage', -1, {
            template = template,
            args = { fal, msg }
        })
        cb(true)
        inProgress[source] = nil
        return
    end

    if airdropType == "people" then
        if playerCanConfirmLoot.people ~= source then
            handleErrorAndNotify(xPlayer,"done_item")
            cb(false,nil)
            inProgress[source] = nil
            return
        end

        local xItemGang = xPlayer.getInventoryItem("card_gang")
        if xItemGang.count > 0 then
            handleErrorAndNotify(xPlayer,"have_card")
            cb(false)
            inProgress[source] = nil
            return
        end

        local xItemFamily = xPlayer.getInventoryItem("card_family")
        if xItemFamily.count > 0 then
            handleErrorAndNotify(xPlayer,"have_card")
            cb(false)
            inProgress[source] = nil
            return
        end

        calculateitemStageAirdrop(airdropType, xPlayer)
        calculateitemBonusStageAirdrop(airdropType, xPlayer)
        resetFlow(airdropType,lastTeamAlive)
        local template =
        [[
            <div style="padding: 7px; margin-bottom: 8px; background-image: linear-gradient(to right, rgba(0, 51, 0, 0.7), rgba(0, 153, 0, 0.5)); border-radius: 7px; width: 605px; display: flex; align-items: center; font-size: 18px;"/>
            <img src="https://img2.pic.in.th/pic/airdrop-1.png" style="width: 20px; height: 20px; padding-right: 7px; padding-left: 7px;" />{0}: {1}
            <br></div>
        ]]
        local msg = xPlayer.getName() .. " ได้รับของจากแอร์ดรอปประชาชน"
        local fal = ' แอร์ดรอป'
        TriggerClientEvent('chat:addMessage', -1, {
            template = template,
            args = { fal, msg }
        })
        cb(true)
        inProgress[source] = nil
        return
    end
    inProgress[source] = nil
end)
---------------------------------------------------------------------------
function doneAirdrop(airdropType)
    if airdropType == "gang" then
         playerGangStage = {
            a = {
                logo = "atr.png",
                color = "#FFFFFF",
                group = "a",
                slot = {}
            },
            b = {
                logo = "alt.png",
                color = "#3A1078",
                group = "b",
                slot = {}
            },
            c = {
                logo = "itv.png",
                color = "#0000FF",
                group = "c",
                slot = {}
            },
            d = {
                logo = "nk.png",
                color = "#000000",
                group = "d",
                slot = {}
            },
            -- e = {
            --     logo = "ws.png",
            --     color = "#000518",
            --     group = "e",
            --     slot = {}
            -- },
        }
        gangStage = 0
        coordsChooseGang = nil
        systemProcessGang = false
        collectgarbage("collect")
        TriggerClientEvent('General:getDataAirdrop', -1, airdropType)
    end

    if airdropType == "family" then
        playerfamilyStage = {
            a = {
                logo = "sum.png",
                color = "#00FF00",
                group = "a",
                slot = {}
            },
            b = {
                logo = "bvl.png",
                color = "#290000",
                group = "b",
                slot = {}
            },
            c = {
                logo = "vp.png",
                color = "#84bcd6",
                group = "c",
                slot = {}
            },
            d = {
                logo = "skz.png",
                color = "#01153e",
                group = "d",
                slot = {}
            },
            e = {
                logo = "rm.png",
                color = "#ffffff",
                group = "e",
                slot = {}
            },
            f = {
                logo = "bbc.png",
                color = "#ff6600",
                group = "f",
                slot = {}
            },
            g = {
                logo = "gbt.png",
                color = "#4f4f4f",
                group = "g",
                slot = {}
            },
            h = {
                logo = "pnk.png",
                color = "#191970",
                group = "h",
                slot = {}
            },
            i = {
                logo = "ds.png",
                color = "#e800ff",
                group = "i",
                slot = {}
            },
            j = {
                logo = "trh.png",
                color = "#000000",
                group = "j",
                slot = {}
            },
            k = {
                logo = "hbb.png",
                color = "#da3e2d",
                group = "k",
                slot = {}
            },
       }
       familyStage = 0
       coordsChooseFamily = nil
       systemProcessFamily = false
       collectgarbage("collect")
       TriggerClientEvent('General:getDataAirdrop', -1, airdropType)
   end

    if airdropType == "people" then
        playerPeopleStage = {
            black = {},
            red = {},
            green = {},
            blue = {},
            white = {},
        }
        coordsChoosePeople = nil
        peopleStage = 0
        systemProcessPeople = false
        collectgarbage("collect")
        TriggerClientEvent('General:getDataAirdrop', -1, airdropType)
    end
end
------------------------------------------------------------------------------------------
function resetFlow(airdropType,lastTeamAlive)
    if airdropType == "people" then
        peopleStage = peopleStage + 1
        print("people stage count: ",peopleStage)
        for _, players in pairs(playerPeopleStage) do
            for _, player in ipairs(players) do
                if peopleStage >= 1 then
                    TriggerClientEvent("General:backToHome",player.source,lastTeamAlive)
                    inProgress[player.source] = nil
                    alreadyRegister[player.source] = nil
                    playerCanConfirmLoot.people = 0
                    goto endState
                end
                coordsChoosePeople = airdropPositionPeople[math.random(1,#airdropPositionPeople)]
                TriggerClientEvent("General:spawnAfterLoot",player.source,lastTeamAlive)
                playerCanConfirmLoot.people = 0
                ::endState::
            end
        end
        if peopleStage < 1 then
            SendPrepareStageAirDrop(60, airdropType)
            systemProcessPeople = false
        end

        if peopleStage >= 1 then
            doneAirdrop(airdropType)
            systemProcessPeople = false
        end
    end

    if airdropType == "gang" then
        gangStage = gangStage + 1
        print("gang stage count: ",gangStage)
        for _, players in pairs(playerGangStage) do
            for _, player in ipairs(players.slot) do
                if gangStage >= 1 then
                    TriggerClientEvent("General:backToHome",player.source,lastTeamAlive)
                    inProgress[player.source] = nil
                    alreadyRegister[player.source] = nil
                    playerCanConfirmLoot.gang = 0
                    collectgarbage("collect")
                    goto endState
                end
                coordsChooseGang = airdropPositionGang[math.random(1,#airdropPositionGang)]
                TriggerClientEvent("General:spawnAfterLoot",player.source,lastTeamAlive)
                playerCanConfirmLoot.gang = 0
                ::endState::
            end
        end

        if gangStage < 1 then
            SendPrepareStageAirDrop(60, airdropType)
            systemProcessGang = false
        end

        if gangStage >= 1 then
            doneAirdrop(airdropType)
            systemProcessGang = false
        end
    end

    if airdropType == "family" then
        familyStage = familyStage + 1
        print("family stage count: ",familyStage)
        for _, players in pairs(playerFamilyStage) do
            for _, player in ipairs(players.slot) do
                if familyStage >= 1 then
                    TriggerClientEvent("General:backToHome",player.source,lastTeamAlive)
                    inProgress[player.source] = nil
                    alreadyRegister[player.source] = nil
                    playerCanConfirmLoot.family = 0
                    collectgarbage("collect")
                    goto endState
                end
                coordsChooseFamily = airdropPositionFamily[math.random(1,#airdropPositionFamily)]
                TriggerClientEvent("General:spawnAfterLoot",player.source,lastTeamAlive)
                playerCanConfirmLoot.family = 0
                ::endState::
            end
        end

        if familyStage < 1 then
            SendPrepareStageAirDrop(60, airdropType)
            systemProcessFamily = false
        end

        if familyStage >= 1 then
            doneAirdrop(airdropType)
            systemProcessFamily = false
        end
    end
end

------------------------------------------------------------------------------------------------------
ESX.RegisterServerCallback('cc_stageairdrop:validatePermission', function(source, cb, airdropType)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    --if xPlayer.getJob().name ~= 'police' then
    --    handleErrorAndNotify(xPlayer,"maintain")
    --    cb(false,nil)
    --    return
    --end

    if  timeStart ~= nil then
        if timeStart < 60 then
            handleErrorAndNotify(xPlayer,"time_up")
            cb(false,nil)
            return
        end
    end

    if not airdropState or alreadyRegister[source] then
        print("validate permission data")
        handleErrorAndNotify(xPlayer,"not_availiable")
        cb(false)
        return
    end

    if type(inProgress[source]) ~= "nil" then
        if inProgress[source] then
            print("validate permission data")
            handleErrorAndNotify(xPlayer,"not_done")
            cb(false,nil)
            return
        end
    end

    inProgress[source] = true
    if airdropType == "gang" then
        local xItemGang = xPlayer.getInventoryItem("card_gang")
        if xItemGang.count == 0 then
            handleErrorAndNotify(xPlayer,"not_require_item")
            cb(false)
            inProgress[source] = nil
            return
        end
    end

    if airdropType == "family" then
        local xItemFamily = xPlayer.getInventoryItem("card_family")
        if xItemFamily.count == 0 then
            handleErrorAndNotify(xPlayer,"not_require_item")
            cb(false)
            inProgress[source] = nil
            return
        end
    end

    if airdropType == "people" then
        local xItemGang = xPlayer.getInventoryItem("card_gang")
        local xItemFamily = xPlayer.getInventoryItem("card_family")
        if xItemGang.count > 0 and xItemFamily.count > 0 then
            handleErrorAndNotify(xPlayer,"have_card")
            cb(false)
            inProgress[source] = nil
            return
        end
    end

    Wait(300)
    cb(true,airdropType)
    inProgress[source] = nil
end)
-------------------------------------------------------------------------------------------------------
ESX.RegisterServerCallback('cc_stageairdrop:getPlayerInTeam', function(source, cb, airdropType)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if timeStart < 60 then
        handleErrorAndNotify(xPlayer,"time_up")
        cb(false,nil)
        return
    end

    if alreadyRegister[source] then
        print("getPlayerInTeam data")
        handleErrorAndNotify(xPlayer,"not_done")
        cb(false,nil)
        return
    end

    if type(inProgress[source]) ~= "nil"  then
        if inProgress[source] then
            handleErrorAndNotify(xPlayer,"not_done")
            cb(false,nil)
            return
        end
    end

    inProgress[source] = true
    if airdropType == "gang" then
        cb(true,playerGangStage)
        inProgress[source] = nil
        return
    end

    if airdropType == "family" then
        cb(true,playerFamilyStage)
        inProgress[source] = nil
        return
    end

    if airdropType == "people" then
        cb(true,playerPeopleStage,#playerPeopleStage.black,#playerPeopleStage.red,#playerPeopleStage.green,#playerPeopleStage.white,#playerPeopleStage.blue)
        inProgress[source] = nil
        return
    end
    cb(false,nil,0,0,0,0,0)
    inProgress[source] = nil
end)
-----------------------------------------------------------------------------------------------------
ESX.RegisterServerCallback('cc_stageairdrop:checkGetAirdrop', function(source, cb, requestType)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if type(inProgress[source]) ~= "nil"  then
        if inProgress[source] then
            handleErrorAndNotify(xPlayer,"not_done")
            cb(false,nil)
            return
        end
    end

    inProgress[source] = true
    if requestType == "position-g" then
        if systemProcessGang then
            handleErrorAndNotify(xPlayer,"done_item")
            cb(false,nil)
            inProgress[source] = nil
            return
        end
        systemProcessGang = true
        local teamsAliveCount = 0
        local lastTeamAlive = nil
        if playerCanConfirmLoot.gang == -1 then -- bad validate
            handleErrorAndNotify(xPlayer,"done_item")
            cb(false,nil)
            inProgress[source] = nil
            return
        end
        playerCanConfirmLoot.gang = -1

        for color, players in pairs(playerGangStage) do
            local teamAlive = false
            for _, player in ipairs(players.slot) do
                if not player.isDead then
                    teamAlive = true
                    inProgress[source] = nil
                    break
                end
                if playerCanConfirmLoot.gang == player.source then
                    handleErrorAndNotify(xPlayer,"done_item")
                    cb(teamsAliveCount == 1, lastTeamAlive)
                    inProgress[source] = nil
                    return
                end
            end
            if teamAlive then
                teamsAliveCount = teamsAliveCount + 1
                lastTeamAlive = color
            end
        end

        if teamsAliveCount > 1 then
            systemProcessGang = false
            playerCanConfirmLoot.gang = 0
            handleErrorAndNotify(xPlayer,"not_yet_loot")
        end

        if playerCanConfirmLoot.gang == -1 then
            playerCanConfirmLoot.gang = xPlayer.source
        end

        cb(teamsAliveCount == 1, lastTeamAlive)
        inProgress[source] = nil
        return
    end

    if requestType == "position-f" then
        if systemProcessFamily then
            handleErrorAndNotify(xPlayer,"done_item")
            cb(false,nil)
            inProgress[source] = nil
            return
        end
        systemProcessFamily = true
        local teamsAliveCount = 0
        local lastTeamAlive = nil
        if playerCanConfirmLoot.family == -1 then -- bad validate
            handleErrorAndNotify(xPlayer,"done_item")
            cb(false,nil)
            inProgress[source] = nil
            return
        end
        playerCanConfirmLoot.family = -1

        for color, players in pairs(playerFamilyStage) do
            local teamAlive = false
            for _, player in ipairs(players.slot) do
                if not player.isDead then
                    teamAlive = true
                    inProgress[source] = nil
                    break
                end
                if playerCanConfirmLoot.family == player.source then
                    handleErrorAndNotify(xPlayer,"done_item")
                    cb(teamsAliveCount == 1, lastTeamAlive)
                    inProgress[source] = nil
                    return
                end
            end
            if teamAlive then
                teamsAliveCount = teamsAliveCount + 1
                lastTeamAlive = color
            end
        end

        if teamsAliveCount > 1 then
            systemProcessFamily = false
            playerCanConfirmLoot.family = 0
            handleErrorAndNotify(xPlayer,"not_yet_loot")
        end

        if playerCanConfirmLoot.family == -1 then
            playerCanConfirmLoot.family = xPlayer.source
        end

        cb(teamsAliveCount == 1, lastTeamAlive)
        inProgress[source] = nil
        return
    end

    if requestType == "position-p" then
        local teamsAliveCount = 0
        local lastTeamAlive = nil
        if systemProcessPeople then
            handleErrorAndNotify(xPlayer,"done_item")
            cb(false,nil)
            inProgress[source] = nil
            return
        end
        systemProcessPeople = true
        if playerCanConfirmLoot.people == -1 then -- bad validate
            handleErrorAndNotify(xPlayer,"done_item")
            cb(false,nil)
            inProgress[source] = nil
            return
        end
        playerCanConfirmLoot.people = -1

        for color, players in pairs(playerPeopleStage) do
            local teamAlive = false
            for _, player in ipairs(players) do
                if not player.isDead then
                    teamAlive = true
                    inProgress[source] = nil
                    break
                end
                if playerCanConfirmLoot.people == player.source then
                    handleErrorAndNotify(xPlayer,"done_item")
                    cb(false,nil)
                    inProgress[source] = nil
                    return
                end
            end
            if teamAlive then
                teamsAliveCount = teamsAliveCount + 1
                lastTeamAlive = color
            end
        end
        if teamsAliveCount > 1 then
            systemProcessPeople = false
            playerCanConfirmLoot.people = 0
            handleErrorAndNotify(xPlayer,"not_yet_loot")
        end

        if playerCanConfirmLoot.people == -1 then
            playerCanConfirmLoot.people = xPlayer.source
        end
        cb(teamsAliveCount == 1, lastTeamAlive)
        inProgress[source] = nil
        return
    end
    cb(false,nil)
    inProgress[source] = nil
end)
----------------------------------------------------------------------------------------------
RegisterCommand('sad', function(source, args, user)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local airdropType = "people"
    --if  xPlayer.getJob().name ~= 'police' then
    --    handleErrorAndNotify(xPlayer,"maintain")
    --    xPlayer.triggerEvent("General:openMenu",false,nil)
    --    return
    --end

    if tonumber(timeStart) < 60 then
        handleErrorAndNotify(xPlayer,"time_up")
        xPlayer.triggerEvent("General:openMenu",false,nil)
        return
    end

    if alreadyRegister[source] then
        print("getPlayerInTeam data")
        handleErrorAndNotify(xPlayer,"not_done")
        xPlayer.triggerEvent("General:openMenu",false,nil)
        return
    end

    local xItemGang = xPlayer.getInventoryItem("card_gang")
    if xItemGang.count > 0 then
        airdropType = "gang"
    end

    local xItemFamily = xPlayer.getInventoryItem("card_family")
    if xItemFamily.count > 0 then
        airdropType = "family"
    end

    if type(inProgress[source]) ~= "nil"  then
        if inProgress[source] then
            handleErrorAndNotify(xPlayer,"not_done")
            xPlayer.triggerEvent("General:openMenu",false,nil)
            return
        end
    end

    inProgress[source] = true
    xPlayer.triggerEvent("General:openMenu",true,airdropType)
    inProgress[source] = nil
end)
-------------------------------------------------------------------------------------------------------------------
ESX.RegisterServerCallback('cc_stageairdrop:initPlayerTeam', function(source, cb, airdropType,colorTeam)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    --if  xPlayer.getJob().name ~= 'police' then
    --    handleErrorAndNotify(xPlayer,"maintain")
    --    cb(false,nil)
    --    return
    --end

    if alreadyRegister[source] then
        print("initPlayerTeam data")
        handleErrorAndNotify(xPlayer,"not_done")
        cb(false,nil)
        return
    end

    if type(inProgress[source]) ~= "nil"  then
        if inProgress[source] then
            handleErrorAndNotify(xPlayer,"not_done")
            cb(false,nil)
            return
        end
    end

    inProgress[source] = true
    if airdropType == "gang" then
        print(colorTeam)
        if #playerGangStage[colorTeam].slot >= 30 then
            handleErrorAndNotify(xPlayer,"team_full")
            cb(false,nil)
            inProgress[source] = nil
            return
        end
        local data = { isDead = false, inAirdrop = true, source = source}
        table.insert(playerGangStage[colorTeam].slot, data)
        cb(true,playerGangStage)
        Wait(300)
        TriggerClientEvent('General:getDataAirdrop', -1, airdropType)
        alreadyRegister[source] = true
        inProgress[source] = nil
        return
    end

    if airdropType == "family" then
        print(colorTeam)
        if #playerFamilyStage[colorTeam].slot >= 30 then
            handleErrorAndNotify(xPlayer,"team_full")
            cb(false,nil)
            inProgress[source] = nil
            return
        end
        local data = { isDead = false, inAirdrop = true, source = source}
        table.insert(playerFamilyStage[colorTeam].slot, data)
        cb(true,playerFamilyStage)
        Wait(300)
        TriggerClientEvent('General:getDataAirdrop', -1, airdropType)
        alreadyRegister[source] = true
        inProgress[source] = nil
        return
    end

    if airdropType == "people" then
        local xItemGang = xPlayer.getInventoryItem("card_gang")
        if xItemGang.count > 0 then
            handleErrorAndNotify(xPlayer,"have_card")
            cb(false)
            inProgress[source] = nil
            return
        end

        local xItemFamily = xPlayer.getInventoryItem("card_family")
        if xItemFamily.count > 0 then
            handleErrorAndNotify(xPlayer,"have_card")
            cb(false)
            inProgress[source] = nil
            return
        end

        if #playerPeopleStage[colorTeam] >= 100 then
            handleErrorAndNotify(xPlayer,"team_full")
            cb(false,nil)
            inProgress[source] = nil
            return
        end
        local data = { isDead = false, inAirdrop = true, source = source}
        table.insert(playerPeopleStage[colorTeam], data)
        cb(true,playerPeopleStage)
        Wait(300)
        TriggerClientEvent('General:getDataAirdrop', -1, airdropType)
        alreadyRegister[source] = true
        inProgress[source] = nil
        return
    end
    cb(false,nil)
    inProgress[source] = nil
end)
-----------------------------------------------------------------------------------
RegisterCommand(cfg['command'], function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then
        local time = args[1]
        if time == nil then
            airdropState = true
            TriggerClientEvent('General:spawnAirDrop', -1, cfg['spawntime'])
        end
        if time ~= nil then
            airdropState = true
            TriggerClientEvent('General:spawnAirDrop', -1, time)
        end
    end
end, true)
-----------------------------------------------------------------------------------
RegisterCommand('setairtime', function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'admin' then
        airdropState = true
        SendStartAirDrop(args[1])
    end
end)
-----------------------------------------------------------------------------------
RegisterCommand('stopair', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'admin' then
        breakSpawnAir = true
        TriggerClientEvent("General:stopAirDrop",-1)
    end
end)

------------------------------------------------------------------------------------
function SendPrepareStageAirDrop(timez,airdropType)
    Citizen.CreateThread(function()
        local Timecooldown = timez
        local numsend = 1

        while true do
            Timecooldown = Timecooldown - 1
            if Timecooldown > 30 then
                numsend = numsend + 1
            else
                numsend = 0
            end

            if numsend == 0 then
                TriggerClientEvent('General:prepareAirdrop', -1, Timecooldown,airdropType)
            end

            if numsend > 10 then
                TriggerClientEvent('General:prepareAirdrop', -1, Timecooldown,airdropType)
                numsend = 1
            end

            Wait(1000)
            if Timecooldown <= 0 then
                Citizen.Wait(5000)
                break
            end
        end
    end)
end
--------------------------------------------------------------------------------------------
function SendStartAirDrop(timez)
    timeStart = tonumber(timez)
    local numsend = 1

    while true do
        if breakSpawnAir then
            airdropState = false
            breakSpawnAir = false
            break
        end
        timeStart = timeStart - 1
        if timeStart > 30 then
            numsend = numsend + 1
        else
            numsend = 0
        end

        if numsend == 0 then
            TriggerClientEvent('General:spawnAirDrop', -1, timeStart)
        end

        if numsend > 10 then
            TriggerClientEvent('General:spawnAirDrop', -1, timeStart)
            numsend = 1
        end

        Wait(1000)
        if timeStart <= 0 then
            airdropState = false
            initPositionAirDrop()
            initCheckPlayerCrash()
            Citizen.Wait(5000)
            break
        end
    end
end
----------------------------------------------------------------------------------------------
function initCheckPlayerCrash()
    Citizen.CreateThread(function()
        while not airdropState do
            Citizen.Wait(3000)
            for color, players in pairs(playerPeopleStage) do
                for k, player in ipairs(players) do
                    local xPlayer = ESX.GetPlayerFromId(player.source)
                    if not xPlayer or type(xPlayer) == "nil" then
                        if playerCanConfirmLoot.people == player.source then
                            playerCanConfirmLoot.people = 0
                            systemProcessPeople = false
                        end

                        table.remove(playerPeopleStage[color], k)
                        inProgress[player.source] = nil
                        alreadyRegister[player.source] = nil
                        collectgarbage("collect")
                    end
                end
            end

            for color, players in pairs(playerGangStage) do
                for k, player in ipairs(players.slot) do
                    local xPlayer = ESX.GetPlayerFromId(player.source)
                    if not xPlayer or type(xPlayer) == "nil" then
                        if playerCanConfirmLoot.gang == player.source then
                            playerCanConfirmLoot.gang = 0
                            systemProcessGang = false
                        end

                        table.remove(playerGangStage[color].slot, k)
                        inProgress[player.source] = nil
                        alreadyRegister[player.source] = nil
                        collectgarbage("collect")
                    end
                end
            end

            for color, players in pairs(playerFamilyStage) do
                for k, player in ipairs(players.slot) do
                    local xPlayer = ESX.GetPlayerFromId(player.source)
                    if not xPlayer or type(xPlayer) == "nil" then
                        if playerCanConfirmLoot.family == player.source then
                            playerCanConfirmLoot.family = 0
                            systemProcessFamily = false
                        end

                        table.remove(playerFamilyStage[color].slot, k)
                        inProgress[player.source] = nil
                        alreadyRegister[player.source] = nil
                        collectgarbage("collect")
                    end
                end
            end
        end
    end)
end
---------------------------------------------------------------------------------
function spawnAir()
    SetTimeout(1000, function()
        local date_local = os.date('%H:%M:%S', os.time())
        for i=1, #cfg['timer'], 1 do
            local start_time = cfg['timer'][i]..':00'
            if date_local == start_time then
                airdropState = true
                SendStartAirDrop(cfg['spawntime'])
            end
        end
        spawnAir()
	end)
end
--------------------------------------------------------------------------------------
function initPositionAirDrop()
    coordsChoosePeople = airdropPositionPeople[math.random(1,#airdropPositionPeople)]
    coordsChooseGang = airdropPositionGang[math.random(1,#airdropPositionGang)]
    coordsChooseFamily = airdropPositionFamily[math.random(1,#airdropPositionFamily)]
end
------------------------------------------------------------------------------------------
AddEventHandler('esx:playerDropped', function(playerId)
    playerId = tonumber(playerId)
    if playerId then
        for color, players in pairs(playerGangStage) do
            for k, player in ipairs(players.slot) do
                if playerCanConfirmLoot.gang == playerId then
                    playerCanConfirmLoot.gang = 0
                    systemProcessGang = false       -- Remark เคยใส่ตัวแปรผิด(แก้แล้ว)
                end

                if player.source == playerId then
                    table.remove(playerGangStage[color].slot, k)
                    inProgress[player.source] = nil
                    alreadyRegister[player.source] = nil
                end
            end
        end

        for color, players in pairs(playerFamilyStage) do
            for k, player in ipairs(players.slot) do
                if playerCanConfirmLoot.family == playerId then
                    playerCanConfirmLoot.family = 0
                    systemProcessFamily = false
                end

                if player.source == playerId then
                    table.remove(playerFamilyStage[color].slot, k)
                    inProgress[player.source] = nil
                    alreadyRegister[player.source] = nil
                end
            end
        end

        for color, players in pairs(playerPeopleStage) do
            for k, player in ipairs(players) do
                if playerCanConfirmLoot.people == playerId then
                    playerCanConfirmLoot.people = 0
                    systemProcessPeople = false
                end

                if player.source == playerId then
                    table.remove(playerPeopleStage[color], k)
                    inProgress[player.source] = nil
                    alreadyRegister[player.source] = nil
                end
            end
        end
    end
    collectgarbage("collect")
end)
-------------------------------------------------------------------------------
AddEventHandler('playerDropped', function()
    local playerId = source
    if playerId then
        for color, players in pairs(playerGangStage) do
            for k, player in ipairs(players.slot) do
                if playerCanConfirmLoot.gang == playerId then
                    playerCanConfirmLoot.gang = 0
                    systemProcessGang = false       -- Remark เคยใส่ตัวแปรผิด(แก้แล้ว)
                end

                if player.source == playerId then
                    table.remove(playerGangStage[color].slot, k)
                    inProgress[player.source] = nil
                    alreadyRegister[player.source] = nil
                end
            end
        end

        for color, players in pairs(playerFamilyStage) do
            for k, player in ipairs(players.slot) do
                if playerCanConfirmLoot.family == playerId then
                    playerCanConfirmLoot.family = 0
                    systemProcessFamliy = false 
                end

                if player.source == playerId then
                    table.remove(playerFamilyStage[color].slot, k)
                    inProgress[player.source] = nil
                    alreadyRegister[player.source] = nil
                end
            end
        end

        for color, players in pairs(playerPeopleStage) do
            for k, player in ipairs(players) do
                if playerCanConfirmLoot.people == playerId then
                    playerCanConfirmLoot.people = 0
                    systemProcessPeople = false
                end

                if player.source == playerId then
                    table.remove(playerPeopleStage[color], k)
                    inProgress[player.source] = nil
                    alreadyRegister[player.source] = nil
                end
            end
        end

    end
    collectgarbage("collect")
end)
------------------------------------------------------------------------------------
RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
    local source = source
    local handleDead = false
    if alreadyRegister[source] then
        if playerCanConfirmLoot.gang == source then
            playerCanConfirmLoot.gang = 0
            systemProcessGang = false
        end

        if playerCanConfirmLoot.family == source then
            playerCanConfirmLoot.family = 0
            systemProcessFamily = false
        end

        if playerCanConfirmLoot.people == source then
            playerCanConfirmLoot.people = 0
            systemProcessPeople = false
        end

        for color, players in pairs(playerPeopleStage) do
            if handleDead then break end
            for _, player in ipairs(players) do
                if handleDead then break end
                if player.source == source then
                    player.isDead = true
                    handleDead = true
                end
            end
        end

        for color, players in pairs(playerGangStage) do
            if handleDead then break end
            for _, player in ipairs(players.slot) do
                if handleDead then break end
                if player.source == source then
                    player.isDead = true
                    handleDead = true
                end
            end
        end

        for color, players in pairs(playerFamilyStage) do
            if handleDead then break end
            for _, player in ipairs(players.slot) do
                if handleDead then break end
                if player.source == source then
                    player.isDead = true
                    handleDead = true
                end
            end
        end

        gangCheckPlayerAlive(source)
        FamilyCheckPlayerAlive(source)
        peopleCheckPlayerAlive(source)
    end
end)


function gangCheckPlayerAlive(source)
    local teamsAliveCount = 0
    local havePlayerInArea = false
    for color, players in pairs(playerGangStage) do
        local teamAlive = false
        for _, player in ipairs(players.slot) do
            if player.source == source then
                havePlayerInArea = true
            end
            if not player.isDead then
                teamAlive = true
                break
            end
        end
        if teamAlive then
            teamsAliveCount = teamsAliveCount + 1
        end
    end
    if teamsAliveCount == 0 and havePlayerInArea then
        print(teamsAliveCount)
        playerCanConfirmLoot.gang = 0
        resetFlow("gang","all")
    end
end

function FamilyCheckPlayerAlive(source)
    local teamsAliveCount = 0
    local havePlayerInArea = false
    for color, players in pairs(playerFamilyStage) do
        local teamAlive = false
        for _, player in ipairs(players.slot) do
            if player.source == source then
                havePlayerInArea = true
            end
            if not player.isDead then
                teamAlive = true
                break
            end
        end
        if teamAlive then
            teamsAliveCount = teamsAliveCount + 1
        end
    end
    if teamsAliveCount == 0 and havePlayerInArea then
        print(teamsAliveCount)
        playerCanConfirmLoot.family = 0
        resetFlow("family","all")
    end
end

function peopleCheckPlayerAlive(source)
    local teamsAliveCount = 0
    local havePlayerInArea = false
    for color, players in pairs(playerPeopleStage) do
        local teamAlive = false
        for _, player in ipairs(players) do
            if player.source == source then
                havePlayerInArea = true
            end
            if not player.isDead then
                teamAlive = true
                break
            end
        end
        if teamAlive then
            teamsAliveCount = teamsAliveCount + 1
        end
    end
    if teamsAliveCount == 0 and havePlayerInArea then
        playerCanConfirmLoot.people = 0
        resetFlow("people","all")
    end
end

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
    local source = source
    if alreadyRegister[source] then
        for color, players in pairs(playerPeopleStage) do
            for _, player in ipairs(players) do
                if player.source == source then
                    player.isDead = false
                    return -- If you're certain there's only one such source, you can return immediately after finding it
                end
            end
        end

        for color, players in pairs(playerGangStage) do
            for _, player in ipairs(players.slot) do
                if player.source == source then
                    player.isDead = false
                    return -- If you're certain there's only one such source, you can return immediately after finding it
                end
            end
        end

        for color, players in pairs(playerFamilyStage) do
            for _, player in ipairs(players.slot) do
                if player.source == source then
                    player.isDead = false
                    return -- If you're certain there's only one such source, you can return immediately after finding it
                end
            end
        end
    end
    collectgarbage("collect")
end)

spawnAir()