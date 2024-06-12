fx_version 'cerulean'
game 'gta5'

author 'DiVouz'
description 'mechanic'
version '1.0.0'

shared_scripts {
	'@es_extended/imports.lua',
}

ui_page 'client/ui/index.html'

files {
	'client/ui/index.html',
	'client/ui/js/**/*.js',
	'client/ui/css/**/*.css',
	'client/ui/img/**/*.png',
	'client/ui/sounds/**/*.ogg'
}

client_scripts {	
	'@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'client/core.lua',
	'client/helper.lua',
	'client/job.lua',
	'config/config.lua',
	'config/menus.lua',
	'config/labels.lua',
	'config/vehicles.lua',
}

server_scripts {	
	'server/core.lua',
	'config/config.lua',
	'config/menus.lua',
	'config/labels.lua',
	'config/vehicles.lua',
}
