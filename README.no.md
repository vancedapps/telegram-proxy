# Cloudflare Warp SOCKS5-proxy for Telegram

**En profesjonell, selvhostet proxy-løsning med Cloudflare Warp for Telegram og andre apper – sikkert, raskt og enkelt.**

## 🏗️ Arkitekturoversikt

Dette prosjektet lager en lokal SOCKS5-proxy som sender trafikken via Cloudflare Warp-nettverket:

- Kobler automatisk til nærmeste Cloudflare-server for lavest mulig forsinkelse
- Bare utvalgte apper (f.eks. Telegram) bruker proxyen, resten går rett ut på nettet
- Kan deles i lokalnett (LAN) – mobil og andre PC-er kan bruke samme proxy
- Enkel installasjon: Alt lastes ned og settes opp automatisk

## 🚀 Kom i gang raskt

1. Last ned prosjektet:
   ```
   git clone https://github.com/vancedapps/telegram-proxy.git
   cd telegram-proxy
   ```
2. Kjør `start-telegram-proxy.bat` og godta admin-rettigheter
3. Sett opp SOCKS5-proxy i Telegram:
   - Server: 127.0.0.1
   - Port: 7777
   - Brukernavn/passord: la stå tomt

## 📱 Bruk på mobil og i nettverk

- Telegram på mobil: Skriv inn PC-ens IP og port 7777
- Andre enheter: Samme oppsett, sjekk brannmurinnstillinger

## 🛠️ Vanlige problemer

- **Porten er opptatt**: Prøv en annen port eller lukk programmet som bruker den
- **Ingen tilkobling**: Sjekk brannmur eller internett
- **Registrering feiler**: Prøv et annet nettverk eller VPN

## 🔒 Sikkerhet

- Alle innstillinger og nøkler lagres kun lokalt
- Bare Telegram-trafikk går gjennom proxyen, resten påvirkes ikke

## 🌐 Nyttige lenker

- [WireGuard](https://www.wireguard.com/)
- [Cloudflare Warp](https://developers.cloudflare.com/warp-client/)
- [sing-box](https://sing-box.sagernet.org/)

---

Spørsmål? Besøk [vanced.to](https://vanced.to) eller opprett en issue på [GitHub](https://github.com/vancedapps/telegram-proxy). 