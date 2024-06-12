fx_version 'cerulean'
game 'gta5'

description 'NC Vehicle Storage Converter'
version '1.0.0'
author 'NC'

lua54 'yes'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}