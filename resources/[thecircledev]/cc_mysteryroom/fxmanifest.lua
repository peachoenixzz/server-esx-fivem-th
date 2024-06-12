fx_version 'adamant'

game 'gta5'

shared_scripts {
    '@es_extended/imports.lua',
}

ui_page 'html/ui.html'

files {
    'html/**/',
    'html/**'
}

client_script {
    '@es_extended/locale.lua',
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'config.client.lua',
	'client.lua',
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}






