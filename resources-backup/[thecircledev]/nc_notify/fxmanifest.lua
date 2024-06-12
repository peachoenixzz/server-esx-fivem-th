fx_version 'cerulean'
game 'gta5'

description 'NC Notify'
version '1.2.0'
author 'NC'

lua54 'yes'

shared_script 'config/config.general.lua'

server_script 'server/main.lua'

client_scripts {
	'config/config.locale.lua',
	'client/main.lua'
}

ui_page 'html/nc.html'

file 'html/**'