
fx_version 'cerulean'
lua54 'yes'
game 'gta5'

description 'AFU Optimized Player Utilities'

version '0.5'

shared_script '@es_extended/imports.lua'

client_scripts {
	'@es_extended/locale.lua',
	'Player.Settings.lua',    
    'Player/Global.Variables.lua',
    'Player/WeaponClass.lua',
	'Player/DisableControlInCar.lua',
	'Player/ClassPlayer.lua',
	'Player/Crouch.lua',
}

server_scripts {
	'@es_extended/locale.lua',
	"Server.Settings.lua",
	"Server/Population.lua"
}



disable_lazy_natives 'yes'
