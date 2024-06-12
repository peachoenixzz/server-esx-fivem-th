fx_version 'cerulean'

game 'gta5'



shared_scripts {
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
}


-- Add a server script
server_script {
	'@es_extended/locale.lua',
	"config.lua",
	'server/npc.lua',
}




-- Add a client script
client_script {
	'@es_extended/locale.lua',
	"client/npc.lua"
}

