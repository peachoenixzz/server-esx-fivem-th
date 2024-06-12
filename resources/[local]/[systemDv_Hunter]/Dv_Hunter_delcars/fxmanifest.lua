--[[
	resource: 	Dv_Hunter_delcars
	edit by :	Devil Hunter developers
    discord	:	https://discord.gg/XthjKBBvwm
	fackbook:	https://www.facebook.com/Boss-Studio-101699331554365
	เว็บไซต์		: 	http://boss-studio.net/
    warning: หากนำไปขายต่อหรือแจกจ่าย จะหยุดการ Support ทันที
]]
-- 'ES Dv_Hunter_delcars Modify By Devil Hunter developers'

fx_version 'cerulean'
game 'gta5'
author 'Devil Hunter'
description 'Devil Henter Delcar'
version '1.0.0'

ui_page 'nui/ui.html'

shared_script '@es_extended/imports.lua'

files {
    'nui/*',
	'nui/sounds/*.mp3',
    'nui/ui.html',
    'nui/img/*.png',
    'nui/style.css',
    'nui/app.js',
}

client_scripts {
    '@es_extended/locale.lua',
    'config.lua',
    'Source/client.lua',
}

server_scripts {
    '@es_extended/locale.lua',
    'config.lua',
	'SECURE.lua',
    'Source/server.lua',
}