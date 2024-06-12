fx_version 'adamant'
games { 'gta5' }

server_scripts {
	-- Async, MySQL
	'@async/async.lua',
	'@oxmysql/lib/MySQL.lua',
	-- Version
	'core/version.lua',
	-- Keys
	'keys.lua',
	-- Config
	'core/config_init.lua',
	'config.lua',
	'config_item.lua',
	'config_vehicle.lua',
	'config_discord.lua',
	'config_translate.lua',
	-- Core
	'core/funcs.lua',
	'core/server.lua'
}

client_scripts {
	-- Version
	'core/version.lua',
	-- Keys
	'keys.lua',
	-- Config
	'core/config_init.lua',
	'config.lua',
	'config_item.lua',
	'config_vehicle.lua',
	'config_translate.lua',
	-- Core
	'core/funcs.lua',
	'core/client.lua'
}

files {
	'export/trunk.lua'
}