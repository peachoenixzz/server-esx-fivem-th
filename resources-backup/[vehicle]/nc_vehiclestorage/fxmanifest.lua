fx_version 'cerulean'
game 'gta5'

description 'NC Vehicle Storage'
version '1.0.6'
author 'NC'

lua54 'yes'

shared_scripts {
	'config/config.general.lua',
	'config/config.settings.lua',
	'config/storages/config.storage.global.lua',
	'config/storages/config.storage.default.lua',
	'config/storages/vehicle.classes/*.lua',
	'config/storages/vehicle.models/*.lua',
	'config/storages/vehicle.plates/*.lua',
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
	'config/config.locale.lua',
	'config/functions/config.functions.client.lua',
	'client/main.lua'
}