fx_version 'adamant'

game 'gta5'

description "Ghost"

version '1.0.0'


client_scripts {
    'config.lua',
    'client/keys.lua',
  	'client/main.lua'
}

server_scripts {
 	'config.lua',
  	'server/main.lua'
}

ui_page {
	'html/main.html',
}


files({
	'html/main.html',
	'html/*.mp3',
})
