fx_version 'cerulean'
game 'gta5'

description 'NC Inventory'
version '1.8.2'
author 'NC'

lua54 'yes'

shared_scripts {
	'config/config.general.lua',
	'config/config.accounts.lua',
	'config/config.items.lua',
	'config/config.weapons.lua',
	'config/config.keys.lua',
	'config/config.accessories.lua',
	'config/config.filters.lua',
	'config/config.extensions.lua',
	'config/config.audios.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config/config.database.lua',
	'config/functions/config.framework.server.lua',
	'config/functions/config.functions.server.lua',
	'server/main.lua'
}

client_scripts {
	'config/config.locale.lua',
	'config/config.rarity.lua',
	'config/config.descriptions.lua',
	'config/functions/config.functions.client.lua',
	'client/main.lua',
}

ui_page 'html/ui.html'

files {
	'html/fonts/*.*',
	'html/sounds/*.*',
	'html/img/assets/*.*',
	'html/img/items_bg/*.*',
	'html/img/items/*.*',
	'html/css/*.css',
	'html/js/*.js',
	'html/ui.html'
}