fx_version 'cerulean'
games { 'gta5' }
author 'General'


ui_page "client/html/ui.html"

shared_scripts {
  '@es_extended/imports.lua',
}

files {
  "client/html/app.js",
  "client/html/style.css",
  "client/html/ui.html",
  'client/html/sounds/*.ogg',
  'client/html/sounds/*.mp3'
}

client_scripts {
  '@es_extended/locale.lua',
  "client/main.lua"
}

server_script {
  '@es_extended/locale.lua',
  "server/main.lua",
}

exports {
  'initSound'
}


