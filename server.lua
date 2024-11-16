-- Aktualizace seznamu hráčů
function updatePlayerList()
    local players = {}
    for _, playerId in ipairs(GetPlayers()) do
        local player = {}
        player.id = playerId
        player.name = GetPlayerName(playerId)
        player.job = getPlayerJob(playerId) -- Funkce, která získá aktuální job hráče
        table.insert(players, player)
    end

    -- Poslání dat všem připojeným hráčům
    TriggerClientEvent('updatePlayerList', -1, players)
end

-- Funkce pro získání aktuálního jobu hráče
function getPlayerJob(playerId)
    -- Simulovaná logika pro získání jobu hráče
    return "rudaarmada"
end

-- Vyvolání aktualizace seznamu hráčů každých X sekund
Citizen.CreateThread(function()
    while true do
        updatePlayerList()
        Citizen.Wait(5000) -- Aktualizace každých 5 sekund
    end
end)

-- Přijetí zprávy od klienta
RegisterNetEvent('sendPrivateMessage')
AddEventHandler('sendPrivateMessage', function(targetPlayerId, message)
    local sourcePlayerId = source
    local sourcePlayerName = GetPlayerName(sourcePlayerId)

    -- Debug: Zobrazení informací na serveru
    print("Zpráva od hráče "..sourcePlayerName.." (ID: "..sourcePlayerId..") na hráče s ID: "..targetPlayerId.." Zpráva: "..message)

    -- Odeslání zprávy cílovému hráči
    TriggerClientEvent('okokNotify:Alert', targetPlayerId, 'Přišla ti zpráva od hráče', sourcePlayerName .. ': ' .. message, 5000, 'info', true)
end)