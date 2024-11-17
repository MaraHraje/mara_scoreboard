let allPlayers = []; // Proměnná pro uložení všech hráčů

// Funkce pro aktualizaci seznamu hráčů
function updatePlayerList(players) {
    var playerList = document.querySelector('.player-list');
    playerList.innerHTML = ''; // Vymazat seznam hráčů

    if (players.length === 0) {
        var noPlayer = document.createElement('div');
        noPlayer.classList.add('no-player');
        noPlayer.innerText = 'Tento hráč zde nyní nehraje';
        playerList.appendChild(noPlayer);
    } else {
        players.forEach(function(player) {
            var playerDiv = document.createElement('div');
            playerDiv.classList.add('player');

            // Přidání třídy 'owner' pro hráče s rolí "owner"
            if (player.group === 'owner') {
                playerDiv.classList.add('owner');
            }

            var jobImageUrl = 'https://cdn-icons-png.flaticon.com/512/9391/9391082.png'; // Nahraďte URL adresou obrázku

            var img = document.createElement('img');
            img.src = jobImageUrl;
            playerDiv.appendChild(img);

            var name = document.createElement('div');
            name.classList.add('name');
            name.innerText = player.name;
            playerDiv.appendChild(name);

            var id = document.createElement('div');
            id.classList.add('id');
            id.innerText = player.id;
            playerDiv.appendChild(id);

            playerList.appendChild(playerDiv);
        });
    }
}

// Event listener pro vyhledávání
document.getElementById('searchInput').addEventListener('input', function(e) {
    const searchText = e.target.value.toLowerCase(); // Získání textu z vyhledávacího pole
    
    // Pokud je vyhledávací pole prázdné, zobrazí se všichni hráči
    if (searchText === '') {
        updatePlayerList(allPlayers); // Zobrazení všech hráčů
    } else {
        // Filtrování hráčů podle zadaného textu
        const filteredPlayers = allPlayers.filter(player => player.name.toLowerCase().includes(searchText));
        updatePlayerList(filteredPlayers); // Aktualizace seznamu hráčů dle vyhledávání
    }
});

window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.type === 'ui') {
        if (item.display) {
            document.getElementById('scoreboard').classList.add('open');
        } else {
            document.getElementById('scoreboard').classList.remove('open');
        }
    }

    if (item.type === 'updatePlayers') {
        allPlayers = item.players; // Uložení všech hráčů
        const searchText = document.getElementById('searchInput').value.toLowerCase();
        if (searchText === '') {
            updatePlayerList(allPlayers); // Zobrazení všech hráčů pokud není ve vyhledávání text
        } else {
            const filteredPlayers = allPlayers.filter(player => player.name.toLowerCase().includes(searchText));
            updatePlayerList(filteredPlayers); // Aktualizace seznamu hráčů dle vyhledávání
        }

        // Aktualizace počtu hráčů
        var playerCountElement = document.getElementById('playerCount');
        if (playerCountElement) {
            playerCountElement.innerText = item.playerCount + '/120';
        }
    }
});

// Zavření scoreboardu při kliknutí na křížek
document.querySelector('.close-btn').addEventListener('click', function() {
    // Odeslání zprávy klientské části FiveM pro zavření scoreboardu
    fetch(`https://${GetParentResourceName()}/close`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8'
        },
        body: JSON.stringify({})
    }).catch(error => console.error('Error:', error));

    // Skrytí scoreboardu na straně klienta
    document.getElementById('scoreboard').classList.remove('open');
});