fx_version 'cerulean'

game 'gta5'

shared_script '@es_extended/imports.lua'

client_scripts {
	'@async/async.lua',
	'config.lua',
	'client.lua',
	'@es_extended/locale.lua',
	'locales/sv.lua',
	'locales/en.lua',
}

server_scripts {
	'config.lua',
	'@es_extended/locale.lua',
	'locales/sv.lua',
	'locales/en.lua',
	'masvin.lua',
}
