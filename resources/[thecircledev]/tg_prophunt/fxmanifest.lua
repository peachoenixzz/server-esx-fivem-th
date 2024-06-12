fx_version 'bodacious'
game 'gta5'

description 'TG Prop Hunt'
version '1.8.7'
author 'TG'

shared_scripts {
    'config/config.functions.lua',
    'config/config.general.lua',
    'config/config.locale.lua',
    'config/config.setting.lua',
    '@es_extended/imports.lua',
}

client_scripts {
	'client/common.lua',
	'client/function.lua',
	'client/main.lua',
    '@es_extended/locale.lua',
}

server_scripts {
	'server/main.lua',
    'server/function.lua',
    'config/config.secure.lua',
    '@es_extended/locale.lua',
}

exports { 
    'IsPropHuntEvent'
}

files {
    'html/index.html',
    'html/assets/css/styles.css',
    'html/assets/js/index.js',
    'html/assets/js/jquery.js',
    'html/assets/img/*.png',
    "html/assets/audio/open.ogg",
    'html/assets/font/Kanit-latin-ext.woff2',
    'html/assets/font/Kanit-latin.woff2',
    'html/assets/font/Kanit-thai.woff2',
    'html/assets/font/Kanit-vietnamese.woff2',
}

ui_page 'html/index.html'