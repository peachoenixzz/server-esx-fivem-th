fx_version 'adamant'
game 'gta5'
author 'https://github.com/Delarmuss'
version '1.1'
description 'Car hud by delarmuss'
client_scripts {
	'client.lua',
	'config.lua'
}
ui_page 'html/index.html'
files {
	'html/index.html',
	"html/*",
	"html/sounds/*",
	"html/font/*.ttf",
	"html/img/*.svg",
	"html/img/*.png",
	"html/*.png",
}

exports {
	'setCloseUI',
	'setCloseVehicleShop'
}
