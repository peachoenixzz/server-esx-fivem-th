Config = {}

Config.EnableDebug = true
Config.Command = false  --ปิดไม่ให้ผู้เล่น พิมคำส่ง Check  false = ปิด  true = เปิด
Config.SyncClientToServer = 30 * 60	-- Sync ไป Client กรณีค่า Server กับ  Client ไม่ตรงกัน  1 = (เป็นนาที)  *  60 = (เป็นวินาที)  แนำนำ 10-15นาที  ไม่แนำนำให้ตั้ง ทุกๆ 1 นาที

Config.EventClientServer = {
	['getSharedObject'] = 'esx:getSharedObject',
	['playerLoaded'] = 'esx:playerLoaded',
	['playerDropped'] = 'esx:playerDropped',
	['setJob'] = 'esx:setJob'
}

Config.Exports = {	-- ตัวอักษรพิมพ์เล็กทั้งหมด เพิ่มอาชีพ ได้ตามใจ ห้ามใส่ พิมพ์ ใหญ่ 
	['police'] = true,
	['ambulance'] = true,
	['mechanic'] = true,
	-- ['foodpanda'] = true,
	-- ['continental'] = true,
}

--[[	 รูปแบบที่ 1
      ฟังชั่นเสริม  วิธีทำให้ แอดมินพิม Check ได้คนเดียว

จากนั้นเพิ่มโค๊ดชุดนี้เข้าไป ที่สคริปไหนก็ได้
ฝั่ง Server
RegisterCommand('Check', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin' then
        TriggerClientEvent('admin:CheckJob', source)
    end
end)
---------------------------------------------------------------------------------------
ฝั่ง client
RegisterNetEvent('admin:CheckJob')
AddEventHandler('admin:CheckJob', function()
    local players = exports.Dv_Hunter_Check:Players()
    local police = exports.Dv_Hunter_Check:CheckPoliceToScoreboard()
    local ems = exports.Dv_Hunter_Check:CheckAmbulanceToScoreboard()
    local mc = exports.Dv_Hunter_Check:CheckMechanicToScoreboard()
    print('players '..players)
    print('police '..police)
    print('Ambulance '..ems)
    print('Mechanic '..mc)
end)

------------------------------------------------------------------------

####################################################################################################################
มีวิธีแก้ 1 แบบ ให้แก้ที่ Dv_Hunter_processing/client/client.lua ให้แก้แบบที่ 1 
	if exports.Dv_Hunter_Check:CheckPolice(Config.PoliceCount) or Config.PoliceCount == 0 then
	end
หรือ
	if exports.Dv_Hunter_Check:CheckPolice(Config.PoliceCount) or Config.PoliceCount == 0 then
	end
####################################################################################################################
หรือแบบที่ 2 

local policecheck = exports.Dv_Hunter_Check:CheckPolice(Config.PoliceCount) or Config.PoliceCount == 0
	if policecheck then
	end
	
หรือแบบที่ 3  ดึงจาก Config.PoliceCount ใน Config ใช้ตัวแปรไหนก็ดึงมาใช้

local policecheck = exports.Dv_Hunter_Check:CheckPolice(Config.PoliceCount) or Config.PoliceCount == 0
	if policecheck then
	end
####################################################################################################################

รูปแบบที่ 2
การนำไปใช้งาน ในสคริปต่างๆ ถ้าใช้แล้ว สคริปนั้นอ่านค่าไม่ได้ให้ไปใช้ รูปแบบที่ 1 ข้างบน
	if exports.Dv_Hunter_Check:CheckAmbulance(1) then
	end
	หรือ อยากให้ เช็ค 2 อาขีพ ในการทำงาน หรืองานดำ  หมอ และ ตำรวจอย่าง ละ 1 
	if exports.Dv_Hunter_Check:CheckAmbulance(1) or exports.Dv_Hunter_Check:CheckPolice(1) then
	end
	
	การนำไปใช้งาน  Scoreboard
       players = exports.Dv_Hunter_Check:Players(),
       police = exports.Dv_Hunter_Check:CheckPoliceToScoreboard(),
       ems = exports.Dv_Hunter_Check:CheckAmbulanceToScoreboard(),
       mc = exports.Dv_Hunter_Check:CheckMechanicToScoreboard()

		--ToScoreboard ต้องเป็นตัวใหญ่  เพิ่ม export อาชีพใน ด้วย fxmanifest.lua
		--Police & Ambulance & Foodpanda & Continenta  นำหน้าต้องเป็นตัวใหญ่
export {
	'Players',						--เช็คจำนวน ขึ้น scoreboard  ผู้เล่น  player
	'CheckPoliceToScoreboard',		--เช็คจำนวน ขึ้น scoreboard  Police
	'CheckAmbulanceToScoreboard',	--เช็คจำนวน ขึ้น scoreboard  ambulance
	'CheckMechanicToScoreboard',	--เช็คจำนวน ขึ้น scoreboard  mechanic
	'CheckFoodpandaToScoreboard',	--เช็คจำนวน ขึ้น scoreboard  foodpanda
	'CheckContinentalToScoreboard',	--เช็คจำนวน ขึ้น scoreboard  continental
	
	'CheckPolice',					--เช็คจำนวน Police ที่อยู่ ในเซิฟเวอร์ 
	'CheckAmbulance',				--เช็คจำนวน  Ambulance ที่อยู่ ในเซิฟเวอร์ 
	'CheckMechanic',				--เช็คจำนวน Mechanic ที่อยู่ ในเซิฟเวอร์ 
	'CheckFoodpanda',				--เช็คจำนวน Foodpanda ที่อยู่ ในเซิฟเวอร์ 
}
]]--
