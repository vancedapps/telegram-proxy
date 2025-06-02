# Cloudflare Warp SOCKS5 Proxy für Telegram

**Professionelle, selbst gehostete Proxy-Lösung mit Cloudflare Warp für Telegram und andere Apps – sicher, schnell und einfach.**

## 🏗️ Architektur-Überblick

Dieses Projekt erstellt einen lokalen SOCKS5-Proxy, der den Datenverkehr über das Cloudflare Warp-Netzwerk leitet:

- Automatische Verbindung zum nächstgelegenen Cloudflare-Server für beste Geschwindigkeit
- Nur ausgewählte Apps (z.B. Telegram) nutzen den Proxy, alles andere geht direkt ins Internet
- Proxy kann im lokalen Netzwerk (LAN) geteilt werden – praktisch für Handy & andere PCs
- Einfache Installation: Alles wird automatisch heruntergeladen und eingerichtet

## 🚀 Schnellstart

1. Projekt herunterladen:
   ```
   git clone https://github.com/vancedapps/telegram-proxy.git
   cd telegram-proxy
   ```
2. `start-telegram-proxy.bat` ausführen und Admin-Rechte bestätigen
3. In Telegram SOCKS5-Proxy einrichten:
   - Server: 127.0.0.1
   - Port: 7777
   - Benutzername/Passwort: leer lassen

## 📱 Nutzung auf Handy & im Netzwerk

- Telegram auf dem Handy: IP-Adresse des PCs und Port 7777 eintragen
- Andere Geräte: wie oben, Firewall-Einstellungen beachten

## 🛠️ Häufige Probleme

- **Port belegt**: Anderen Port wählen oder störendes Programm schließen
- **Keine Verbindung**: Firewall oder Internet prüfen
- **Registrierung fehlgeschlagen**: Anderes Netzwerk oder VPN probieren

## 🔒 Sicherheit

- Alle Einstellungen & Schlüssel bleiben lokal gespeichert
- Nur Telegram-Verkehr läuft über den Proxy, alles andere bleibt unberührt

## 🌐 Nützliche Links

- [WireGuard](https://www.wireguard.com/)
- [Cloudflare Warp](https://developers.cloudflare.com/warp-client/)
- [sing-box](https://sing-box.sagernet.org/)

---

Fragen? Besuche [vanced.to](https://vanced.to) oder erstelle ein Issue auf [GitHub](https://github.com/vancedapps/telegram-proxy). 