# Proxy Cloudflare Warp SOCKS5 pour Telegram

**Une solution proxy professionnelle, auto-hébergée, basée sur Cloudflare Warp pour Telegram et d'autres applications — sécurisé, rapide et simple.**

## 🏗️ Vue d'ensemble de l'architecture

Ce projet crée un proxy SOCKS5 local qui fait passer le trafic via le réseau Cloudflare Warp :

- Connexion automatique au serveur Cloudflare le plus proche pour une latence minimale
- Seules les applications choisies (ex : Telegram) passent par le proxy, le reste va directement sur Internet
- Partage du proxy possible sur le réseau local (LAN) — pratique pour mobile et autres PC
- Installation facile : tout est téléchargé et configuré automatiquement

## 🚀 Démarrage rapide

1. Téléchargez le projet :
   ```
   git clone https://github.com/vancedapps/telegram-proxy.git
   cd telegram-proxy
   ```
2. Lancez `start-telegram-proxy.bat` et acceptez les droits administrateur
3. Configurez le proxy SOCKS5 dans Telegram :
   - Serveur : 127.0.0.1
   - Port : 7777
   - Identifiant/mot de passe : laisser vide

## 📱 Utilisation sur mobile et réseau local

- Telegram sur mobile : entrez l'IP du PC et le port 7777
- Autres appareils : idem, vérifiez les réglages du pare-feu

## 🛠️ Problèmes courants

- **Port déjà utilisé** : essayez un autre port ou fermez le programme qui l'utilise
- **Pas de connexion** : vérifiez le pare-feu ou la connexion Internet
- **Échec d'inscription** : essayez un autre réseau ou un VPN

## 🔒 Sécurité

- Toutes les configurations et clés sont stockées localement
- Seul le trafic Telegram passe par le proxy, le reste n'est pas concerné

## 🌐 Liens utiles

- [WireGuard](https://www.wireguard.com/)
- [Cloudflare Warp](https://developers.cloudflare.com/warp-client/)
- [sing-box](https://sing-box.sagernet.org/)

---

Des questions ? Rendez-vous sur [vanced.to](https://vanced.to) ou ouvrez un ticket sur [GitHub](https://github.com/vancedapps/telegram-proxy). 