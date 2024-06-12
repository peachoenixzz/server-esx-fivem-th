

fx_version 'adamant'

game 'gta5'

version '1.0.1'

files {
	'html/main.html',
	'html/main.mp3',
}

ui_page {
	'html/main.html',
}

client_scripts {
	'config.lua',
	'client.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server.lua'
}