fx_version 'adamant'

game 'gta5'
lua54 'yes'
description 'ESX Police Job'

version '1.0.0'

shared_script '@es_extended/imports.lua'

server_scripts {
  '@es_extended/locale.lua',
  'translation/sv.lua',
  'translation/en.lua',
  'translation/pl.lua',
  'config.lua',
  'server/main.lua',
}

client_scripts {
  '@es_extended/locale.lua',
  'translation/sv.lua',
  'translation/en.lua',
  'translation/pl.lua',
  'config.lua',
  'client/main.lua',
}