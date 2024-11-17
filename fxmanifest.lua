fx_version 'cerulean'
game 'gta5'

author 'Mára'
description 'Jednoduchý scoreboard pro FiveM server'
version '1.0.0'


ui_page 'html/scoreboard.html'

files {
    'html/scoreboard.html',
    'html/scoreboard.css',
    'html/scoreboard.js',
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}
