
fx_version 'cerulean'
game 'gta5'

description 'Giant Skinui topchart'
version '2.5'
author 'GIANT'
lua54 'yes'

shared_scripts {
	'config/config.basic.lua',
	'addon/lib/GiantLib.lua',
	'config/config.cl-notification.lua',
	'config/config.sv-notification.lua',
	'config/config.blockcloth.lua',
	 '@es_extended/imports.lua'
}

client_scripts {
	'@es_extended/imports.lua',
	'addon/lib/cbClient.lua',
	'client/main.lua',
}

server_scripts {
	'@es_extended/imports.lua',
	'@oxmysql/lib/MySQL.lua',
	'addon/lib/cbServer.lua',
	'server/main.lua',
	'server/callback.lua'
}


ui_page 'dist/index.html'




files {
  'dist/index.html',
  'dist/assets/index.*.css',
  'dist/assets/index.*.js',
  'dist/assets/app.js',
  'dist/assets/*.*.png',
  'dist/assets/*.*.ogg',
  'dist/sounds/*.ogg',
}