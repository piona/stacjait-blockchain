# Działanie i zastosowanie blockchain 

Repozytorium zawiera materiały z warsztatu [Stacja.IT](https://stacja.it/).

**UWAGA** Podczas warsztatu będziemy uruchamiać własną instancję Ethereum. Jeśli
ktoś posiada klucze i środki w publicznych blockchain proszę zachować
ostrożność, aby omyłkowo nie zlecić transakcji poza testowym środowiskiem. Tego
najczęściej nie będzie dało się naprawić 💣!

## Przygotowanie do warsztatu

Środowisko najlepiej przygotować i sprawdzić **przed** warsztatem, nie będzie to
elementem spotkania.

Na dysku należy mieć co najmniej 3GB wolnego miejsca. Potrzebna będzie również
przeglądarka, będę używał [Firefox](https://www.mozilla.org/).

**Użytkownicy Windows**: gotowa paczka z narzędziami i skryptami z tego
repozytorium używanymi podczas warsztatu jest udostępniona
[tutaj](https://drive.google.com/drive/folders/1OSzXl25_szwCRrxgVyeEZxB8psA6pAiL?usp=sharing).
Wystarczy ją pobrać i rozpakować w dowolne miejsce, najlepiej takie, aby
katalogi nie zawierały spacji w nazwie.

Będę pracował
[w systemie Windows](https://www.statista.com/statistics/268237/global-market-share-held-by-operating-systems-since-2009/),
ale narzędzia są dostępne dla Linux i dla macOS.

Jeśli ktoś korzysta z innego systemu lub chce pobrać aplikacje samodzielnie to
podczas warsztatu będziemy używać:

- klient `geth` (będę używał wersji 1.10.25): <https://geth.ethereum.org/downloads/>
- dostęp do Remix (przez przeglądarkę): <https://remix.ethereum.org/>

Najwygodniej zmodyfikować zmienną `PATH`, aby `geth` był dostępny z linii
komend.

### Test

Przed warsztatem można sprawdzić czy aplikacja `geth` się uruchamia (poniższe
polecenie koniecznie z `version`, wywołanie `geth` bez parametru rozpocznie
ściąganie publicznego łańcucha). W środowisku warsztatowym Windows linię komend
można uruchomić skryptem `workspace.cmd` i wywołać

    $ geth version

Warto również sprawdzić dostęp do strony [Remix](https://remix.ethereum.org/).

## Przebieg warsztatu

Podczas warsztatu uruchomimy prywatną instancję blockchain, zlecimy w niej
transakcje, popracujemy z kontraktami i połączymy się z nią poprzez
przeglądarkę.

### Inicjalizacja i uruchomienie prywatnej instancji Ethereum

Inicjalizacja węzła

    $ geth --datadir eth init genesis.json

Uruchomienie węzła

    $ geth --datadir eth --networkid 2553 --nodiscover

Uruchomienie węzła z udostępnionym API przez WebSocket (umożliwienie połączenia
z poziomu przeglądarki), przez HTTP i łącznie

    $ geth --datadir eth --networkid 2553 --nodiscover --ws --ws.api admin,eth,debug,miner,net,txpool,personal,web3 --ws.origins "*"
    $ geth --datadir eth --networkid 2553 --nodiscover --http --http.api admin,eth,debug,miner,net,txpool,personal,web3 --http.corsdomain "*" --allow-insecure-unlock
    $ geth --datadir eth --networkid 2553 --nodiscover --http --http.api admin,eth,debug,miner,net,txpool,personal,web3 --http.corsdomain "*" --allow-insecure-unlock --ws --ws.api admin,eth,debug,miner,net,txpool,personal,web3 --ws.origins "*"

Uruchomienie konsoli JavaScript (w systemach *nix i w Windows)

    $ geth attach eth/geth.ipc
    > geth attach \\.\pipe\geth.ipc

### Praca z kontami

Utworzenie konta (plik z kluczami znajduje się w `eth/keys`)

    > personal.newAccount()

Wykaz kont dostępnych na węźle

    > eth.accounts

Konto do przelewu środków uzyskanych z kopania

    > eth.coinbase

Stan konta

    > eth.getBalance(eth.coinbase)

### Kopanie

Uruchomienie i zatrzymanie procesu kopania

    > miner.start(1)
    > miner.stop()

### Zlecanie transakcji

Aby zlecać transakcje niezbędne jest odblokowanie konta źródłowego na chwilę lub
na czas sesji

    > personal.unlockAccount(eth.coinbase)
    > personal.unlockAccount(eth.coinbase, null, 0)

Wysłanie transakcji o wartości 1 ETH (należy posiadać co najmniej dwa konta
i środki na koncie `from`)

    > eth.sendTransaction({from: eth.accounts[0], to: eth.accounts[1], value: web3.toWei(1, "ether")})

Pobranie danych i informacji o transakcji (należy wstawić odpowiedni identyfikator):

    > eth.getTransaction('0xfc180c57d08f5a3be5f568ff2515e069643a8144faaa2f37dfb48be28d92d18b')
    > eth.getTransactionReceipt('0xfc180c57d08f5a3be5f568ff2515e069643a8144faaa2f37dfb48be28d92d18b')

Wysłanie transakcji z dodatkowym polem danych

    > eth.sendTransaction({from: eth.accounts[0], to: eth.accounts[1], value: web3.toWei(1, "ether"), data:'0xC0FFEE'})

### Kontrakty

W repozytorium znajdują się przykładowe kontrakty:

- [Greeter](./Greeter.sol) - przykład przechowywania i zmiany danych
- [Token](./Token.sol) - implementacja tokenu

### Aplikacje rozproszone

W repozytorium znajdują się przykładowe aplikacje korzystające z [web3.js](https://github.com/web3/web3.js)

- [balance](./balance.html) - sprawdzenie salda konta bazowego
- [transfer](./transfer.html) - przelew środków
- [token-transfer](./token-transfer.html) - przelew tokenów w kontrakcie

### Po warsztacie

Jeśli jest taka potrzeba należy namierzyć katalog `AppData/Local/Ethash` lub
`.ethash` (w katalogu domowym użytkownika) i usunąć pliki o nazwach `full-...`.
Zajmują one 1GB i więcej. Znajdują się w nich dane używane podczas kopania
bloków.

## Warto przeczytać

- Blockchain Technology Overview: <https://doi.org/10.6028/NIST.IR.8202>
- Dokumentacja Solidity: <https://docs.soliditylang.org/>
- Do you need a Blockchain?: <https://eprint.iacr.org/2017/375.pdf>
- I Looked Into 34 Top Real-World Blockchain Projects So You Don’t Have To: <https://weh.wtf/34-blockchain-projects.html>

