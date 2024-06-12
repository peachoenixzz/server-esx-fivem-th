fx_version 'adamant'
games { 'gta5' }

server_scripts {
	'core/version.lua',
	'config.lua',
	'core/funcs.lua',
	'core/server.lua'
}

client_scripts {
	'core/version.lua',
    'config.lua',
	'core/funcs.lua',
	'core/client.lua'
}

files {
	-- export
	'export/*.lua',
	-- Images Custom
	'images/*.png'
}