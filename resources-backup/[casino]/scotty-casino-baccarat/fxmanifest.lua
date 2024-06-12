--[[
	resource: scotty-casino-baccarat
	desc: ชุดคาสิโน God of Gambler ของ Scotty ในชุด บาคาร่า
	author: Scotty1944
	contact: https://www.facebook.com/Scotty1944/
	warning: หากนำไปขายต่อหรือแจกจ่าย หรือใช้ร่วมกันเกิน 1 server จะถูกยกเลิก license ทันที
]]

fx_version 'adamant'

game 'gta5'

description 'Scotty Casino: Baccarat'

shared_scripts {
    '@es_extended/imports.lua',
}

files {
	'ui/menu.html',
	'ui/css/style.css',
	'ui/css/scotty.css',
	'ui/js/script.js',
	'ui/js/scotty.js',
	'ui/js/jquery.min.js',
	'ui/images/casino-chip.png',
	'ui/images/card/*',
	'ui/sound/*',
	'stream/sarabun.gfx',
}

ui_page {
	'ui/menu.html'
}

client_scripts {
	"client.lua",
}

server_scripts {
	'config.lua',
	'config_sv.lua',
	'server.lua',
}