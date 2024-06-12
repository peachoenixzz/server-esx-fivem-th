fx_version 'adamant'

game 'gta5'

description 'xScoreboard'
lua54 'yes'
version '1.0'

shared_scripts {
    '@es_extended/imports.lua',
}


server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}

client_scripts {
	'client.lua'
}

ui_page "html/ui.html"


files {
	'html/**/',
	'html/**'
}