# Proxy Cloudflare Warp SOCKS5 para Telegram

**Solución proxy profesional y autohospedada usando Cloudflare Warp para Telegram y otras apps — seguro, rápido y fácil.**

## 🏗️ Resumen de la arquitectura

Este proyecto crea un proxy SOCKS5 local que enruta el tráfico a través de la red Cloudflare Warp:

- Se conecta automáticamente al servidor Cloudflare más cercano para menor latencia
- Solo las apps seleccionadas (por ejemplo, Telegram) usan el proxy, el resto va directo a internet
- Puedes compartir el proxy en tu red local (LAN) — útil para móviles y otros PCs
- Instalación sencilla: todo se descarga y configura automáticamente

## 🚀 Guía rápida

1. Descarga el proyecto:
   ```
   git clone https://github.com/vancedapps/telegram-proxy.git
   cd telegram-proxy
   ```
2. Ejecuta `start-telegram-proxy.bat` y acepta permisos de administrador
3. Configura el proxy SOCKS5 en Telegram:
   - Servidor: 127.0.0.1
   - Puerto: 7777
   - Usuario/contraseña: dejar en blanco

## 📱 Uso en móvil y red local

- Telegram en móvil: pon la IP del PC y puerto 7777
- Otros dispositivos: igual, revisa la configuración del firewall

## 🛠️ Problemas comunes

- **Puerto en uso**: prueba otro puerto o cierra el programa que lo usa
- **Sin conexión**: revisa firewall o internet
- **Fallo de registro**: prueba otra red o VPN

## 🔒 Seguridad

- Todas las configuraciones y claves se guardan solo localmente
- Solo el tráfico de Telegram pasa por el proxy, el resto no se afecta

## 🌐 Enlaces útiles

- [WireGuard](https://www.wireguard.com/)
- [Cloudflare Warp](https://developers.cloudflare.com/warp-client/)
- [sing-box](https://sing-box.sagernet.org/)

---

¿Dudas? Visita [vanced.to](https://vanced.to) o abre un issue en [GitHub](https://github.com/vancedapps/telegram-proxy). 