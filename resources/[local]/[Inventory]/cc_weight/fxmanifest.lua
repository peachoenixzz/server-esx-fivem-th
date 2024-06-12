fx_version 'cerulean'
game 'gta5'

description 'Weight Circle'
version '1.0.0'
author 'Peachoenixz'

shared_scripts {
	'@es_extended/imports.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'client.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config-sv.lua',
	'server.lua'
}

server_exports {
	'playerCalculateWeight',
	'activateWeight'
}