fx_version 'cerulean'
game 'gta5'

description 'PROTECT+ by NC Developer'
version '1.0.8'
author 'NC'

use_fxv2_oal 'yes'
lua54 'yes'

shared_script 'config/config.general.lua'

server_scripts {
	'config/config.main.lua',
	'config/config.resources.lua',
	'config/config.events.lua',
	'config/config.weapons.lua',
	'config/config.locale.lua',
	'config/PUNISHING/*.lua',
	'server/main.lua'
}

client_script 'client/main.lua'

ui_page 'html/ui.html'

files {
	'html/**',
	'exports/**'
}