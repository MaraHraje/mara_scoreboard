RegisterNetEvent('requestPlayerList')
AddEventHandler('requestPlayerList', function()
    local src = source
    local players = {} -- Zde vložte logiku pro získání seznamu hráčů
    for _, playerId in ipairs(GetPlayers()) do
        table.insert(players, {
            id = playerId,
            name = GetPlayerName(playerId),
            -- Přidejte další data dle potřeby
        })
    end
    TriggerClientEvent('updatePlayerList', src, players)
end)