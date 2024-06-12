fx_version 'cerulean'
lua54 'yes'
game 'gta5'



shared_scripts {
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
}


-- Add a server script
server_script {
	'@es_extended/locale.lua',
	"config.lua",
	'server/main.lua',
	'server/npc.lua',
}

-- Add a client script 
client_script {
	'@es_extended/locale.lua',
	"config.lua",
	'client/main.lua',
	'client/menu.lua',
	'client/npc.lua'
}

