fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'um-punchmachine'
author 'uyuyorum store'
version '2.6.0'
license 'FiveM Escrow'
repository 'https://uyuyorumstore.com'
description 'The Punch Machine Script is a custom FiveM resource designed to provide a fun and immersive boxing experience for players on your server.'

shared_scripts {
	'config.lua',
	'bridge/*.lua',
    '@es_extended/imports.lua',
}

client_scripts {
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'client/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua',
}

ui_page "web/index.html"

files {
    'web/index.html',
    'web/dui/dui.html',
    'web/assets/**',
    'web/css/*.css',
    'web/js/*.js',
}

escrow_ignore {
	'config.lua',
	'bridge/*.lua',
}
dependency '/assetpacks'