fx_version 'cerulean'
game 'gta5'

description 'Core Effect Circle UI'
version '1.0.0'
author 'Peachoenixz'

ui_page 'html/ui.html'
lua54 'yes'
files {
	'html/**/',
	'html/**'
}


shared_scripts {
	'@es_extended/imports.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'client.lua'
}


server_scripts {
	'@es_extended/locale.lua',
	'server.lua',
}