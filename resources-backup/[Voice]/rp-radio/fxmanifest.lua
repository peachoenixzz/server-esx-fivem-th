fx_version "adamant"
game "gta5"

name "rp-radio"
description "An in-game radio which makes use of the mumble-voip radio API for FiveM"
author "Frazzle (frazzle9999@gmail.com)"
version "2.2"

ui_page "index.html"

shared_scripts {
    '@es_extended/imports.lua',
}

dependencies {
	"pma-voice",
}

files {
	"index.html",
	"on.ogg",
	"off.ogg",
	"img/*.png",
	"/img/*.png"
}

client_scripts {
	"config.lua",
	"client.lua",
}

server_scripts {
	"server.lua",
}