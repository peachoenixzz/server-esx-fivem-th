
fx_version 'adamant'

game 'gta5'
lua54 'yes' 
description 'ZC-TriRace' 
version '1.0.0'

client_script {
	'config.lua',
	'checkpoint.lua',
	'client.lua'
}

server_script {
	'@mysql-async/lib/MySQL.lua',
	'checkpoint.lua',
	'config.lua',
	'server.lua'
}

ui_page "html/ui.html"

files {
    "html/ui.html",
	"html/*",
    'html/sounds/impact-6291.mp3',
    'html/sounds/Dm_sounds.mp3',
    'html/sounds/5count.mp3',

}

