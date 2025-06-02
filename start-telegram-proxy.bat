@echo off
setlocal enabledelayedexpansion
title Cloudflare Warp SOCKS5 Proxy Setup
color 0b

REM ================================================================
REM SET WORKING DIRECTORY TO SCRIPT LOCATION
REM ================================================================

REM Change to script directory to ensure all files are in the right place
cd /d "%~dp0"
echo 📁 Working directory: %cd%
echo.

REM ================================================================
REM CHECK ADMIN RIGHTS AND AUTO-ELEVATE IF NEEDED
REM ================================================================

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo ✅ Running with administrator privileges
    goto :start_setup
) else (
    echo ⚠️  Administrator privileges required for proxy binding
    echo 🔄 Attempting to restart with admin rights...
    echo 📁 Current directory: %cd%
    echo.
    
    REM Try to restart as admin with proper working directory
    powershell -Command "Start-Process cmd -ArgumentList '/c cd /d \"%cd%\" && \"%~f0\"' -Verb RunAs"
    exit /b 0
)

:start_setup
echo ================================================================
echo   Cloudflare Warp SOCKS5 Proxy Setup v1.3 (Portable)
echo   Automatically setup Warp + sing-box proxy for Telegram
echo ================================================================
echo.

REM ================================================================
REM EMBEDDED JSON TEMPLATE CREATION FUNCTION
REM ================================================================
goto :skip_create_template_function

:create_template
echo 📝 Creating embedded sing-box template...
(
echo {
echo   "log": {
echo     "level": "info",
echo     "timestamp": true
echo   },
echo   "dns": {
echo     "servers": [
echo       {
echo         "tag": "local",
echo         "address": "local",
echo         "detour": "direct"
echo       },
echo       {
echo         "tag": "cloudflare",
echo         "address": "1.1.1.1",
echo         "detour": "direct"
echo       }
echo     ],
echo     "rules": [
echo       {
echo         "domain_suffix": [
echo           "cloudflareclient.com"
echo         ],
echo         "server": "local"
echo       },
echo       {
echo         "outbound": "any",
echo         "server": "cloudflare"
echo       }
echo     ],
echo     "independent_cache": true
echo   },
echo   "inbounds": [
echo     {
echo       "type": "socks",
echo       "tag": "socks-in",
echo       "listen": "0.0.0.0",
echo       "listen_port": 7777,
echo       "users": []
echo     }
echo   ],
echo   "outbounds": [
echo     {
echo       "type": "wireguard",
echo       "tag": "warp-out",
echo       "local_address": [
echo         "10.0.0.1/32"
echo       ],
echo       "private_key": "[PRIVATE_KEY]",
echo       "peers": [
echo         {
echo           "server": "warp_auto",
echo           "server_port": 0,
echo           "public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
echo           "allowed_ips": [
echo             "0.0.0.0/0"
echo           ]
echo         }
echo       ],
echo       "mtu": 1280
echo     },
echo     {
echo       "type": "direct",
echo       "tag": "direct"
echo     },
echo     {
echo       "type": "block",
echo       "tag": "block"
echo     }
echo   ],
echo   "route": {
echo     "rules": [
echo       {
echo         "inbound": "socks-in",
echo         "outbound": "warp-out"
echo       }
echo     ],
echo     "auto_detect_interface": true
echo   }
echo }
) > "singbox-config-template.json"
echo ✅ Template created successfully
goto :eof

:skip_create_template_function

REM ================================================================
REM PART 1: ENVIRONMENT SETUP
REM ================================================================

echo [PART 1] Setting up environment...
echo.

REM Step 0: Create embedded template if not exists
echo [Step 0] Preparing sing-box template...
if not exist "singbox-config-template.json" (
    call :create_template
) else (
    echo ✅ Template already exists
)
echo.

REM Step 1: Check and download wgcf.exe
echo [Step 1] Checking wgcf.exe...
if exist "wgcf.exe" (
    echo ✅ wgcf.exe already exists
) else (
    echo ⬇️  Downloading wgcf.exe...
    echo Please wait, downloading from GitHub...
    powershell -Command "try { Invoke-WebRequest -Uri 'https://github.com/ViRb3/wgcf/releases/download/v2.2.26/wgcf_2.2.26_windows_386.exe' -OutFile 'wgcf.exe' -UseBasicParsing; Write-Host '✅ wgcf.exe downloaded successfully' } catch { Write-Host '❌ Failed to download wgcf.exe'; Write-Host 'Please download manually from: https://github.com/ViRb3/wgcf/releases'; pause; exit 1 }"
    if not exist "wgcf.exe" (
        echo ❌ Download failed! Please download manually.
        pause
        exit /b 1
    )
)
echo.

REM Step 2: Check and download sing-box-plus.exe
echo [Step 2] Checking sing-box-plus.exe...
if exist "sing-box-plus.exe" (
    echo ✅ sing-box-plus.exe already exists
) else (
    echo ⬇️  Downloading sing-box-plus.exe...
    echo Please wait, downloading and extracting from GitHub...
    
    REM Download zip file
    powershell -Command "try { Invoke-WebRequest -Uri 'https://github.com/kyochikuto/sing-box-plus/releases/download/v1.10.81/sing-box-1.10.81-windows-386.zip' -OutFile 'sing-box-temp.zip' -UseBasicParsing; Write-Host 'Downloaded zip file' } catch { Write-Host '❌ Failed to download sing-box zip'; pause; exit 1 }"
    
    REM Extract and rename
    powershell -Command "try { Expand-Archive -Path 'sing-box-temp.zip' -DestinationPath 'temp-extract' -Force; Move-Item 'temp-extract/sing-box.exe' 'sing-box-plus.exe'; Remove-Item 'temp-extract' -Recurse -Force; Remove-Item 'sing-box-temp.zip' -Force; Write-Host '✅ sing-box-plus.exe extracted successfully' } catch { Write-Host '❌ Failed to extract sing-box'; pause; exit 1 }"
    
    if not exist "sing-box-plus.exe" (
        echo ❌ Extraction failed! Please download manually.
        pause
        exit /b 1
    )
)
echo.

REM Step 2.5: Setup Windows Firewall exception
echo [Step 2.5] Configuring Windows Firewall...
echo 🔥 Adding firewall exception for sing-box-plus.exe...

REM Remove existing rules (if any)
netsh advfirewall firewall delete rule name="sing-box-plus" >nul 2>&1

REM Add new firewall rules with full path
netsh advfirewall firewall add rule name="sing-box-plus-in" dir=in action=allow program="%cd%\sing-box-plus.exe" enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="sing-box-plus-out" dir=out action=allow program="%cd%\sing-box-plus.exe" enable=yes >nul 2>&1

if %errorLevel% == 0 (
    echo ✅ Firewall exception added successfully
) else (
    echo ⚠️  Warning: Could not add firewall exception
    echo    This might cause connection issues
)
echo.

REM ================================================================
REM PART 2: REGISTRATION (Skip if already registered)
REM ================================================================

echo [PART 2] Warp registration...
echo.

REM Step 3: Register warp account (only if not exists)
echo [Step 3] Checking Warp account...
if exist "wgcf-account.toml" (
    echo ✅ Warp account already exists, skipping registration
    goto :update_account
) else (
    echo 📝 Registering new Warp account...
    echo Please wait, this may take a moment...
    
    wgcf register --accept-tos
    if errorlevel 1 (
        echo ❌ Registration failed! Please check your internet connection.
        pause
        exit /b 1
    )
    echo ✅ Account registered successfully
    
    echo 🔄 Updating account...
    wgcf update
    if errorlevel 1 (
        echo ❌ Account update failed!
        pause
        exit /b 1
    )
    echo ✅ Account updated successfully
)

:update_account
REM Step 4: Update and generate latest config
echo.
echo [Step 4] Updating account and generating config...
echo 🔄 Updating Warp account...
wgcf update
if errorlevel 1 (
    echo ❌ Account update failed!
    pause
    exit /b 1
)

echo 📄 Generating WireGuard profile...
wgcf generate
if errorlevel 1 (
    echo ❌ Profile generation failed!
    pause
    exit /b 1
)
echo ✅ Profile generated successfully
echo.

REM ================================================================
REM PART 3: CONFIG GENERATION AND STARTUP
REM ================================================================

echo [PART 3] Creating sing-box config and starting proxy...
echo.

REM Step 5: Extract private key and create sing-box config
echo [Step 5] Creating sing-box configuration...

REM Extract private key from wgcf-account.toml
for /f "tokens=3 delims=' " %%a in ('findstr "private_key" wgcf-account.toml') do set PRIVATE_KEY=%%a
set PRIVATE_KEY=!PRIVATE_KEY:'=!

if "!PRIVATE_KEY!"=="" (
    echo ❌ Failed to extract private key from wgcf-account.toml
    pause
    exit /b 1
)

echo ✅ Private key extracted: !PRIVATE_KEY:~0,20!...

REM Create sing-box config from embedded template
echo 📝 Creating sing-box configuration file...
powershell -Command "(Get-Content 'singbox-config-template.json') -replace '\[PRIVATE_KEY\]', '!PRIVATE_KEY!' | Set-Content 'singbox-config.json'"

if not exist "singbox-config.json" (
    echo ❌ Failed to create sing-box config!
    pause
    exit /b 1
)
echo ✅ sing-box configuration created successfully
echo.

REM Step 6: Start sing-box proxy server
echo [Step 6] Starting SOCKS5 proxy server and configuring Telegram...
echo.
echo ================================================================
echo   🚀 PROXY SERVER STARTING
echo ================================================================
echo.
echo 📡 SOCKS5 Proxy will be available at: 127.0.0.1:7777
echo.

REM Step 6.1: Generate and open automatic Telegram proxy configuration
echo [Step 6.1] Setting up automatic Telegram proxy configuration...
echo.

REM Create a modern HTML file with Tailwind CSS and Lucide icons
echo ^<!DOCTYPE html^> > telegram_proxy_setup.html
echo ^<html lang="en"^> >> telegram_proxy_setup.html
echo ^<head^> >> telegram_proxy_setup.html
echo ^<meta charset="UTF-8"^> >> telegram_proxy_setup.html
echo ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^> >> telegram_proxy_setup.html
echo ^<title^>Telegram SOCKS5 Proxy Setup^</title^> >> telegram_proxy_setup.html
echo ^<script src="https://cdn.tailwindcss.com"^>^</script^> >> telegram_proxy_setup.html
echo ^<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"^>^</script^> >> telegram_proxy_setup.html
echo ^<script^> >> telegram_proxy_setup.html
echo tailwind.config = { >> telegram_proxy_setup.html
echo   theme: { >> telegram_proxy_setup.html
echo     extend: { >> telegram_proxy_setup.html
echo       animation: { >> telegram_proxy_setup.html
echo         'pulse-slow': 'pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite', >> telegram_proxy_setup.html
echo       } >> telegram_proxy_setup.html
echo     } >> telegram_proxy_setup.html
echo   } >> telegram_proxy_setup.html
echo } >> telegram_proxy_setup.html
echo ^</script^> >> telegram_proxy_setup.html
echo ^</head^> >> telegram_proxy_setup.html
echo ^<body class="bg-gradient-to-br from-blue-50 to-indigo-100 min-h-screen"^> >> telegram_proxy_setup.html
echo ^<div class="container mx-auto px-4 py-8"^> >> telegram_proxy_setup.html
echo ^<div class="text-center mb-8"^> >> telegram_proxy_setup.html
echo ^<div class="flex justify-center items-center gap-3 mb-4"^> >> telegram_proxy_setup.html
echo ^<div class="p-3 bg-blue-500 rounded-full"^> >> telegram_proxy_setup.html
echo ^<i data-lucide="wifi" class="w-8 h-8 text-white"^>^</i^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<h1 class="text-4xl font-bold text-gray-800"^>Telegram SOCKS5 Proxy^</h1^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<p class="text-lg text-gray-600 max-w-2xl mx-auto"^>Your secure Cloudflare Warp SOCKS5 proxy is ready to use. Click the button below to automatically configure Telegram or set it up manually.^</p^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<div class="max-w-4xl mx-auto mb-8"^> >> telegram_proxy_setup.html
echo ^<div class="bg-white rounded-xl shadow-lg border border-gray-200 overflow-hidden"^> >> telegram_proxy_setup.html
echo ^<div class="bg-gradient-to-r from-green-500 to-emerald-500 px-6 py-4"^> >> telegram_proxy_setup.html
echo ^<div class="flex items-center gap-3"^> >> telegram_proxy_setup.html
echo ^<div class="p-2 bg-white/20 rounded-lg"^> >> telegram_proxy_setup.html
echo ^<i data-lucide="activity" class="w-5 h-5 text-white"^>^</i^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<div^> >> telegram_proxy_setup.html
echo ^<h3 class="text-white font-semibold text-lg"^>Proxy Status^</h3^> >> telegram_proxy_setup.html
echo ^<p class="text-green-100 text-sm"^>Server running on 127.0.0.1:7777^</p^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<div class="ml-auto"^> >> telegram_proxy_setup.html
echo ^<span class="inline-flex items-center gap-2 px-3 py-1 bg-white/20 rounded-full text-white text-sm"^> >> telegram_proxy_setup.html
echo ^<div class="w-2 h-2 bg-white rounded-full animate-pulse-slow"^>^</div^> >> telegram_proxy_setup.html
echo Online >> telegram_proxy_setup.html
echo ^</span^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<div class="max-w-2xl mx-auto mb-8"^> >> telegram_proxy_setup.html
echo ^<div class="bg-white rounded-xl shadow-lg border border-gray-200 p-6"^> >> telegram_proxy_setup.html
echo ^<div class="text-center"^> >> telegram_proxy_setup.html
echo ^<div class="mb-4"^> >> telegram_proxy_setup.html
echo ^<div class="inline-flex p-3 bg-telegram-blue bg-blue-500 rounded-full mb-3"^> >> telegram_proxy_setup.html
echo ^<i data-lucide="zap" class="w-6 h-6 text-white"^>^</i^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<h3 class="text-xl font-semibold text-gray-800 mb-2"^>Quick Setup^</h3^> >> telegram_proxy_setup.html
echo ^<p class="text-gray-600 mb-4"^>Click the button below to automatically configure Telegram proxy^</p^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<a href="tg://socks?server=127.0.0.1&port=7777" class="inline-flex items-center justify-center gap-3 w-full bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 text-white font-semibold py-4 px-6 rounded-xl transition-all duration-200 transform hover:scale-105 hover:shadow-lg"^> >> telegram_proxy_setup.html
echo ^<i data-lucide="smartphone" class="w-5 h-5"^>^</i^> >> telegram_proxy_setup.html
echo Setup Telegram Proxy >> telegram_proxy_setup.html
echo ^</a^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<div class="max-w-4xl mx-auto mb-8"^> >> telegram_proxy_setup.html
echo ^<div class="bg-amber-50 border border-amber-200 rounded-xl p-6"^> >> telegram_proxy_setup.html
echo ^<div class="flex items-start gap-4"^> >> telegram_proxy_setup.html
echo ^<div class="p-2 bg-amber-100 rounded-lg flex-shrink-0"^> >> telegram_proxy_setup.html
echo ^<i data-lucide="info" class="w-5 h-5 text-amber-600"^>^</i^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<div^> >> telegram_proxy_setup.html
echo ^<h4 class="font-semibold text-amber-800 mb-2"^>Important Information^</h4^> >> telegram_proxy_setup.html
echo ^<ul class="text-amber-700 space-y-1 text-sm"^> >> telegram_proxy_setup.html
echo ^<li class="flex items-center gap-2"^>^<i data-lucide="clock" class="w-4 h-4"^>^</i^> If the proxy isn't working immediately, please wait about 30 seconds for the script to initialize the connection^</li^> >> telegram_proxy_setup.html
echo ^<li class="flex items-center gap-2"^>^<i data-lucide="network" class="w-4 h-4"^>^</i^> Other computers in your LAN can also use this proxy by connecting to your computer's IP address on port 7777^</li^> >> telegram_proxy_setup.html
echo ^</ul^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<div class="max-w-4xl mx-auto"^> >> telegram_proxy_setup.html
echo ^<div class="bg-white rounded-xl shadow-lg border border-gray-200 overflow-hidden"^> >> telegram_proxy_setup.html
echo ^<div class="bg-gray-50 px-6 py-4 border-b border-gray-200"^> >> telegram_proxy_setup.html
echo ^<div class="flex items-center gap-3"^> >> telegram_proxy_setup.html
echo ^<div class="p-2 bg-gray-200 rounded-lg"^> >> telegram_proxy_setup.html
echo ^<i data-lucide="settings" class="w-5 h-5 text-gray-600"^>^</i^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<h3 class="text-lg font-semibold text-gray-800"^>Manual Configuration^</h3^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<div class="p-6"^> >> telegram_proxy_setup.html
echo ^<p class="text-gray-600 mb-6"^>If auto-setup doesn't work, configure the proxy manually in Telegram settings:^</p^> >> telegram_proxy_setup.html
echo ^<div class="grid md:grid-cols-2 gap-6"^> >> telegram_proxy_setup.html
echo ^<div class="space-y-4"^> >> telegram_proxy_setup.html
echo ^<div class="flex items-center gap-3 p-3 bg-gray-50 rounded-lg"^> >> telegram_proxy_setup.html
echo ^<i data-lucide="server" class="w-5 h-5 text-blue-500"^>^</i^> >> telegram_proxy_setup.html
echo ^<div^> >> telegram_proxy_setup.html
echo ^<span class="text-sm font-medium text-gray-700"^>Type:^</span^> >> telegram_proxy_setup.html
echo ^<span class="ml-2 text-gray-900 font-mono"^>SOCKS5^</span^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<div class="flex items-center gap-3 p-3 bg-gray-50 rounded-lg"^> >> telegram_proxy_setup.html
echo ^<i data-lucide="globe" class="w-5 h-5 text-blue-500"^>^</i^> >> telegram_proxy_setup.html
echo ^<div^> >> telegram_proxy_setup.html
echo ^<span class="text-sm font-medium text-gray-700"^>Server:^</span^> >> telegram_proxy_setup.html
echo ^<span class="ml-2 text-gray-900 font-mono"^>127.0.0.1^</span^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<div class="flex items-center gap-3 p-3 bg-gray-50 rounded-lg"^> >> telegram_proxy_setup.html
echo ^<i data-lucide="hash" class="w-5 h-5 text-blue-500"^>^</i^> >> telegram_proxy_setup.html
echo ^<div^> >> telegram_proxy_setup.html
echo ^<span class="text-sm font-medium text-gray-700"^>Port:^</span^> >> telegram_proxy_setup.html
echo ^<span class="ml-2 text-gray-900 font-mono"^>7777^</span^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<div class="space-y-4"^> >> telegram_proxy_setup.html
echo ^<div class="flex items-center gap-3 p-3 bg-gray-50 rounded-lg"^> >> telegram_proxy_setup.html
echo ^<i data-lucide="user" class="w-5 h-5 text-blue-500"^>^</i^> >> telegram_proxy_setup.html
echo ^<div^> >> telegram_proxy_setup.html
echo ^<span class="text-sm font-medium text-gray-700"^>Username:^</span^> >> telegram_proxy_setup.html
echo ^<span class="ml-2 text-gray-900 italic"^>(empty)^</span^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<div class="flex items-center gap-3 p-3 bg-gray-50 rounded-lg"^> >> telegram_proxy_setup.html
echo ^<i data-lucide="key" class="w-5 h-5 text-blue-500"^>^</i^> >> telegram_proxy_setup.html
echo ^<div^> >> telegram_proxy_setup.html
echo ^<span class="text-sm font-medium text-gray-700"^>Password:^</span^> >> telegram_proxy_setup.html
echo ^<span class="ml-2 text-gray-900 italic"^>(empty)^</span^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<div class="mt-6 p-4 bg-blue-50 border border-blue-200 rounded-lg"^> >> telegram_proxy_setup.html
echo ^<div class="flex items-start gap-3"^> >> telegram_proxy_setup.html
echo ^<i data-lucide="wifi" class="w-5 h-5 text-blue-500 mt-0.5"^>^</i^> >> telegram_proxy_setup.html
echo ^<div^> >> telegram_proxy_setup.html
echo ^<h5 class="font-medium text-blue-800 mb-1"^>LAN Network Usage^</h5^> >> telegram_proxy_setup.html
echo ^<p class="text-blue-700 text-sm"^>Other devices on your local network can use this proxy by replacing ^<code class="bg-blue-100 px-1 rounded text-xs"^>127.0.0.1^</code^> with your computer's IP address (e.g., ^<code class="bg-blue-100 px-1 rounded text-xs"^>192.168.1.100:7777^</code^>)^</p^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<div class="text-center mt-12 pb-8"^> >> telegram_proxy_setup.html
echo ^<div class="inline-flex items-center gap-2 text-gray-500 text-sm"^> >> telegram_proxy_setup.html
echo ^<i data-lucide="shield" class="w-4 h-4"^>^</i^> >> telegram_proxy_setup.html
echo Powered by Cloudflare Warp + sing-box >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^</div^> >> telegram_proxy_setup.html
echo ^<script^> >> telegram_proxy_setup.html
echo lucide.createIcons(); >> telegram_proxy_setup.html
echo ^</script^> >> telegram_proxy_setup.html
echo ^</body^> >> telegram_proxy_setup.html
echo ^</html^> >> telegram_proxy_setup.html

echo ✅ Created proxy setup page: telegram_proxy_setup.html
echo.

REM Try to open the proxy configuration directly
echo 🔄 Attempting to auto-configure Telegram proxy...
start tg://socks?server=127.0.0.1^&port=7777 >nul 2>&1

REM Also open the HTML file for manual access
start telegram_proxy_setup.html >nul 2>&1

echo.
echo ✅ Telegram proxy configuration initiated!
echo.
echo 📋 Available options:
echo    1. Auto-setup: tg://socks?server=127.0.0.1^&port=7777
echo    2. HTML page: telegram_proxy_setup.html (opened automatically)
echo    3. Manual setup in Telegram settings
echo.
echo 💡 Press Ctrl+C to stop the proxy server
echo 🔄 Starting proxy server in 5 seconds...
timeout /t 5 /nobreak >nul

REM Start sing-box with config
echo ⚡ Starting sing-box proxy server...
sing-box-plus.exe run -c singbox-config.json

echo.
echo 🛑 Proxy server stopped.
echo Press any key to exit...
pause >nul 