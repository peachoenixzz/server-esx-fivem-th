fx_version 'bodacious'
game 'gta5'

description 'TG Airdrop'
version '1.8.0'
author 'TG'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/script.js',
    'html/img/*.png',
    'html/sound/*.ogg'
}

client_scripts {
    'config/config.general.lua',
    'config/config.setting.lua',
    'config/config.functions.lua',
    'config/config.locale.lua',
    'client/common.lua',
    'client/function.lua',
    'client/main.lua'
}

server_scripts {
    'config/config.general.lua',
    'config/config.setting.lua',
    'config/config.functions.lua',
    'config/config.locale.lua',
    'config/config.secure.lua',
	'server/main.lua'
}

exports {
	'CheckAirdropZone',
}