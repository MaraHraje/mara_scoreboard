local display = false

-- Otevření/zavření scoreboardu
RegisterCommand("toggleScoreboard", function()
    display = not display
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

-- Funkce pro zobrazení rozhraní pro odeslání zprávy
function showSendMessage(player)
    local sendMessage = document.getElementById('send-message')
    sendMessage.classList.remove('hidden')

    -- Uložení ID hráče, kterému se bude posílat zpráva
    sendMessage.setAttribute('data-target-player-id', player.id)

    -- Přidání event listeneru na tlačítko odeslat
    document.getElementById('send-button').onclick = function()
        local message = sendMessage.querySelector('textarea').value
        local targetPlayerId = sendMessage.getAttribute('data-target-player-id')

        -- Odeslání zprávy na server
        TriggerServerEvent('sendPrivateMessage', targetPlayerId, message)

        -- Debug: Výpis do konzole klienta
        print("Odesílání zprávy hráči s ID: "..targetPlayerId.." Zpráva: "..message)

        -- Skrytí rozhraní pro odeslání zprávy
        hideSendMessage()
    end
end