fx_version 'cerulean'

game 'gta5'
lua54 'yes'

ui_page 'html/ui.html'

files {
	'html/**/',
	'html/**'
}

shared_scripts {
	'@es_extended/imports.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config/config-general.lua',
	'config/config-medic.lua',
	'config/config-weapon.lua',
	'config/config-gang.lua',
	'config/config-cooking.lua',
	'config/config-circle.lua',
	'config/config-class.lua',
	'config/config-mystery.lua',
	'config/config.lua',
	'server/main.lua',
	'server/validate.lua',
	'server/giveitem.lua'
}

client_scripts {
	'config/config-general.lua',
	'config/config-medic.lua',
	'config/config-weapon.lua',
	'config/config-gang.lua',
	'config/config-cooking.lua',
	'config/config-circle.lua',
	'config/config-class.lua',
	'config/config-mystery.lua',
	'config/config.lua',
	'client/npc.lua',
	'client/main.lua'
}