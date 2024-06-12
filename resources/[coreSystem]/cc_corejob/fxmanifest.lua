fx_version 'cerulean'
game 'gta5'

description 'Core Job Circle'
version '1.0.0'
author 'Joi Taokha'
lua54 'yes'
shared_scripts {
	'@es_extended/imports.lua',
}

client_scripts {
	'@es_extended/locale.lua',
}



server_scripts {
	'@es_extended/locale.lua',
	'configserver.lua',
	'server.lua',
}

