

fx_version 'cerulean'

game 'gta5'
lua54 'yes'
version '1.0.1'

shared_script '@es_extended/imports.lua'

client_scripts {
	'config.lua',
	'client.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server.lua'
}