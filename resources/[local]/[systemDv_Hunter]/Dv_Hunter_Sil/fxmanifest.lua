fx_version 'adamant'

game 'gta5'
lua54 'yes'

shared_script '@es_extended/imports.lua'

client_scripts{
	'@es_extended/locale.lua',
	'cl-parkour.lua',		-- Agile Player Movements / Parkour Movements
	'Config.lua'			-- Literally the line I forgot to add to make the shit work...
}

server_scripts{
	'sv-parkour.lua', 		-- Agile Player Movements / Parkour Movements
}