fx_version 'cerulean'
game 'gta5'

description 'TG Hunting'
version '1.9.2'
author 'TG'

shared_scripts {
	'config/config.functions.lua',
	'config/config.locale.lua',
	'config/config.setting.lua',
	'config/config.rental.lua',	
	'config/config.general.lua',	
}

client_scripts {
	'config/config.healthbar.lua',
	'client/common.lua',
	'client/function.lua',
	'client/healthbar.lua',
	'client/cayoperico.lua',
	'client/main.lua'
}

server_scripts {
	'config/config.secure.lua',
	'server/main.lua'
}