fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'aymannajim'
description 'AN Kill Feed' -- Join Discord for Support: https://discord.gg/KxdPzC5EeJ
version '1.0.0'

ui_page 'html/index.html'

shared_script {
	'@es_extended/imports.lua',
	'config.lua'
}

client_script {
	'@es_extended/locale.lua',
	'client.lua'
}

server_script {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'server.lua',
}

escrow_ignore {
	'*',
	'*/*',
}

files {
	'html/index.html',
	'html/main.js',
	'html/style.css',
	'html/images/*',
	'html/valo.ttf',
}
dependency '/assetpacks'
dependency '/assetpacks'
dependency '/assetpacks'