
fx_version 'cerulean'

game 'gta5'
lua54 'yes'
-- dependency 'essentialmode'

ui_page 'html/ui.html'

files {
	'html/**/'
}

shared_scripts {
	'@es_extended/imports.lua',
}

-- Add a server script
server_script {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	"config.lua",
	'server/main.lua',
}




-- Add a client script 
client_script {
	'@es_extended/locale.lua',
	"config.lua",
	'client/main.lua',
	'client/npc.lua'
}

