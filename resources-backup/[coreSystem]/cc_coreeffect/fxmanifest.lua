fx_version 'cerulean'
game 'gta5'

description 'Core Effect Circle'
version '1.0.0'
author 'Peachoenixz'
lua54 'yes'

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
	'server-function.lua',
	'server-items.lua',
}

exports {
	'checkPlayerDizzy'
}