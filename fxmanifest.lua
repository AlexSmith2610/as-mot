fx_version "cerulean"
game "gta5"

author 'decaffeinatedtea'
description 'MOT script made by Alex Smith with help from Jaysee'
version 'v0.1.3'
lua54 'yes'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}
