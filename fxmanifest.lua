fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'vib_lumberjack'
author 'Vibrant Resources'
version '1.0.0'
repository 'https://github.com/VibrantResources/vib_lumberjack'
description 'A lumberjack job designed for civilians providing tress will individual cooldowns, vehicle spawning and placeable objects for plan creation'

client_scripts {
    'client/*.lua',
    'menus/*.lua',
}

server_scripts {
    'server/*.lua',
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
}

lua54 'yes'