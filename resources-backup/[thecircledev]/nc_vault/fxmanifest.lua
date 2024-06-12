fx_version 'cerulean'
game 'gta5'

description 'NC Vault'
version '1.1.5'
author 'NC'

lua54 'yes'

shared_scripts {
	'@es_extended/imports.lua',
}

shared_scripts {
	'config/config.general.lua',
	'config/VAULT/config.group.lua',
	'config/VAULT/config.society.lua',
	'config/config.extensions.lua'
}

server_scripts {
	-- MySQL
	'@oxmysql/lib/MySQL.lua',
	'config/config.database.lua',

	-- MongoDB
	-- '@mongodb/lib/MongoDB.lua',
	-- 'config/config.database.mongodb.lua',

	'config/functions/config.functions.server.lua',
	'server/main.lua'
}

client_scripts {
	'config/functions/config.functions.client.lua',
	'config/config.locale.lua',
	'client/main.lua'
}

ui_page 'html/index.html'

file 'html/**'