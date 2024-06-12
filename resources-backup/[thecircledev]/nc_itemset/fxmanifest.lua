fx_version 'cerulean'
game 'gta5'

description 'NC Itemset'
version '1.0.0'
author 'NC'

lua54 'yes'

shared_scripts {
	'config/config.general.lua',
	'config/config.vehicles.lua',
	'config/config.itemsets.lua',
	'config/config.gachapon.lua',
	'config/config.locale.lua',
	'config/config.extensions.lua',
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
	'config/config.audios.lua',
	'config/functions/config.functions.client.lua',
	'client/main.lua'
}

ui_page 'html/index.html'

file 'html/**'