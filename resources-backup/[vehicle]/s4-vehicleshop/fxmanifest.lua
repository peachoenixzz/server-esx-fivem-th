fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
    '@es_extended/imports.lua',
}

client_scripts {  
	'@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'config.lua', 
	'client.lua', 
	'utils.lua'
}

server_scripts {
	'server.lua',
	'@oxmysql/lib/MySQL.lua',
}

ui_page 'ui/ui.html'
files {
	'ui/ui.html',
	'ui/js/*.js',
	'ui/css/*.css',
	'ui/images/*.png',
	'ui/css/fonts/*.ttf',
}

exports {
	'GeneratePlate'
}