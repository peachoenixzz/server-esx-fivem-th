fx_version 'cerulean'

game 'gta5'


ui_page 'html/ui.html'

files {
	'html/**/',
	'html/**'
}


server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'@PolyZone/client.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
	'client.lua'
}