fx_version 'adamant'
game 'gta5'

description 'TG Songkran'
version '1.2.1'
author 'TG'

shared_scripts { 
	'config/config.general.lua',
	'config/config.functions.lua',
	'config/config.locale.lua',
	'config/config.setting.lua'
}

client_scripts {
	'client/common.lua',
	'client/main.lua',
	'client/thread.lua'
}

server_scripts {
	'server/main.lua'
}

files {
    'html/**',
   
}

ui_page 'html/index.html'