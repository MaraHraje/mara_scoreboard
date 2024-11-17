local display = false

-- Otevření/zavření scoreboardu
RegisterCommand("toggleScoreboard", function()
    display = not display
    if display then
        -- Požádej server o aktuální data o hráčích
        TriggerServerEvent('requestPlayerList')
    end
    SetDisplay(display)
end)

RegisterNUICallback("close", function(data, cb)
    SetDisplay(false)
    cb('ok')
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        display = bool
    })
end

-- Mapa DEL klávesy na toggleScoreboard příkaz
RegisterKeyMapping('toggleScoreboard', 'Toggle Scoreboard', 'keyboard', 'DELETE')

-- Přijímání dat o hráčích ze serveru
RegisterNetEvent('updatePlayerList')
AddEventHandler('updatePlayerList', function(players)
    SendNUIMessage({
        type = "updatePlayers",
        players = players,
        playerCount = #players
    })
end)
