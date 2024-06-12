fx_version 'adamant'

game 'gta5'

client_script {
	'@es_extended/locale.lua',
	"client.lua"
}

server_script {
	'@es_extended/locale.lua',
	'@oxmysql/lib/MySQL.lua',
	"server.lua"
}