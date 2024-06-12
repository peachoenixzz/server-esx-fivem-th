--[[
	resource: 	Dv_Hunter_Check
	edit by :	Devil Hunter developers
    discord	:	https://discord.gg/XthjKBBvwm
	fackbook:	https://www.facebook.com/Boss-Studio-101699331554365
	เว็บไซต์		: 	http://boss-studio.net/
    warning: หากนำไปขายต่อหรือแจกจ่าย จะหยุดการ Support ทันที
]]

fx_version 'cerulean'
game 'gta5'

description 'Dv_Hunter_Check'
version '1.0.0'

lua54 'yes'

author 'Dv_Hunter'

server_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'SECURE.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client/main.lua'
}

server_export 'Check'

--ToScoreboard ต้องเป็นตัวใหญ่
--Police & Ambulance & Foodpanda & Continenta  นำหน้าต้องเป็นตัวใหญ่
export {
	'Players',						--เช็คจำนวน ขึ้น scoreboard  ผู้เล่น  player
	'CheckPoliceToScoreboard',		--เช็คจำนวน ขึ้น scoreboard  Police
	'CheckAmbulanceToScoreboard',	--เช็คจำนวน ขึ้น scoreboard  ambulance
	'CheckMechanicToScoreboard',	--เช็คจำนวน ขึ้น scoreboard  mechanic
	'CheckFoodpandaToScoreboard',	--เช็คจำนวน ขึ้น scoreboard  foodpanda
	'CheckContinentalToScoreboard',	--เช็คจำนวน ขึ้น scoreboard  continental
	'CheckSosToScoreboard',	--เช็คจำนวน ขึ้น scoreboard  continental

	'CheckPolice',					--เช็คจำนวน Police ที่อยู่ ในเซิฟเวอร์
	'CheckAmbulance',				--เช็คจำนวน  Ambulance ที่อยู่ ในเซิฟเวอร์
	'CheckMechanic',				--เช็คจำนวน Mechanic ที่อยู่ ในเซิฟเวอร์
	'CheckFoodpanda',				--เช็คจำนวน Foodpanda ที่อยู่ ในเซิฟเวอร์
	'Continental',				--เช็คจำนวน Foodpanda ที่อยู่ ในเซิฟเวอร์
}