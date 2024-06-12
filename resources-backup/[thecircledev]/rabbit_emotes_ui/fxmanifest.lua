-- ██████╗  █████╗ ██████╗ ██████╗ ██╗████████╗    ██████╗ ███████╗██╗   ██╗
-- ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║╚══██╔══╝    ██╔══██╗██╔════╝██║   ██║
-- ██████╔╝███████║██████╔╝██████╔╝██║   ██║       ██║  ██║█████╗  ██║   ██║
-- ██╔══██╗██╔══██║██╔══██╗██╔══██╗██║   ██║       ██║  ██║██╔══╝  ╚██╗ ██╔╝
-- ██║  ██║██║  ██║██████╔╝██████╔╝██║   ██║       ██████╔╝███████╗ ╚████╔╝ 
-- ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝   ╚═╝       ╚═════╝ ╚══════╝  ╚═══╝  
-- https://discord.gg/GfvECJ4Z8q

fx_version "cerulean"
description "Rabbit Emotes User Interface"
author "Em Adthasit"
version '1.1.4'

lua54 'yes'

games {"gta5"}

ui_page 'web/build/index.html'

client_scripts {
  '@dpemotes/Client/RabbitEmotes.lua',
  "config.lua",
  "client/cl_main.lua",
  "client/cl_utils.lua",
}

server_scripts {
  "credentials.lua",
  "sv_config.lua",
  "server/sv_main.lua",
}

shared_scripts {
  'shared/locales.lua',
  'shared/event.lua',
  'shared/common.lua',
}

files {
  'icons/**/*',
  'web/build/index.html',
  'web/build/**/*'
}

escrow_ignore {
  "credentials.lua",
  "client/cl_utils.lua",
  "config.lua",
  'shared/locales.lua',
  'shared/event.lua',
  'shared/common.lua',
}