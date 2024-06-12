fx_version 'cerulean'
game 'gta5'
author 'DevilHunter HUD'
description 'Custrom JackZee.shop'
version '1.0'

shared_scripts {
    '@es_extended/imports.lua',
}

client_scripts {
	'Source/client.lua'
}

ui_page "nui/ui.html"

files {
	"nui/ui.html",
    "nui/ui.css",
	"nui/ui.js",
	"nui/*",
    "nui/img/*.svg",
	"nui/img/*.png"
}