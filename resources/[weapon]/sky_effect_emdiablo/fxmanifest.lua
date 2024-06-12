fx_version 'adamant'
game 'gta5'

description 'Sky Mod'

version '1.0'

lua54 "yes"

files {
	"stream/*.ydr",
	"stream/*.ytd",
	"stream/*.ycd",
	"stream/*.ypt",
}

server_scripts {
	'config_sv.lua',
	'config_base.lua',
	"core/sv_main.lua"
}

client_scripts {
	'config_base.lua',
	'configs/**/**.lua',
    "core/cl_main.lua"
}

dependency '/assetpacks'