# Cloudflare Warp SOCKS5 Proxy for Telegram

**A professional-grade, self-hosted proxy solution that leverages Cloudflare's Warp infrastructure to provide secure, high-performance connectivity for Telegram and other applications.**

[![GitHub](https://img.shields.io/badge/GitHub-vancedapps%2Ftelegram--proxy-blue?logo=github)](https://github.com/vancedapps/telegram-proxy)
[![Powered by](https://img.shields.io/badge/Powered%20by-vanced.to-orange)](https://vanced.to)

## 🏗️ Architecture Overview

This solution creates a **local SOCKS5 proxy server** that routes traffic through **Cloudflare's Warp network**, providing several key advantages over traditional proxy methods:

### 🎯 Core Technology Stack
- **Cloudflare Warp**: Enterprise-grade WireGuard-based VPN infrastructure
- **wgcf**: Official Cloudflare Warp configuration utility
- **sing-box-plus**: High-performance universal proxy platform
- **Embedded Configuration**: Zero-dependency setup with intelligent auto-configuration

### 🚀 Why Warp-Based Proxy Architecture?

#### **Intelligent Server Selection**
Unlike static third-party proxies, our solution automatically connects to the **nearest Cloudflare edge server**, ensuring optimal latency and throughput based on your geographical location.

#### **Selective Application Routing**
Instead of routing all system traffic through Warp (like the official 1.1.1.1 client), this solution provides **application-specific proxy routing**:
- ✅ **Targeted Usage**: Only designated applications (e.g., Telegram) use the proxy
- ✅ **Bandwidth Optimization**: Other applications maintain direct internet access
- ✅ **Performance Isolation**: No impact on system-wide internet performance
- ✅ **Resource Efficiency**: Reduced bandwidth consumption and latency overhead

#### **Network Sharing Capabilities**
The local SOCKS5 server can be **shared across your entire network infrastructure**:
- 📱 **Mobile Devices**: iOS/Android Telegram clients via LAN
- 💻 **Multiple Computers**: Other devices on the same network
- 🌐 **Internet Sharing**: Port forwarding for remote access
- 🔧 **Simple Configuration**: No complex network setup required

## ✨ Advanced Features

### 🛡️ Security & Privacy
- **End-to-End Encryption**: All traffic encrypted through Cloudflare's infrastructure
- **Zero-Log Policy**: Leverages Cloudflare's privacy-focused network
- **Local Processing**: Account credentials and configurations stored locally
- **Firewall Integration**: Automatic Windows Firewall exception management

### ⚡ Performance Optimization
- **Adaptive MTU**: Optimized packet size (1280 bytes) for maximum throughput
- **DNS Optimization**: Cloudflare DNS (1.1.1.1) with intelligent caching
- **Connection Persistence**: Maintains stable connections with automatic reconnection
- **Low Latency**: Direct connection to nearest Cloudflare edge servers

### 🔧 Automation & Usability
- **One-Click Deployment**: Complete setup with single batch file execution
- **Intelligent Downloads**: Automatic component retrieval and version management
- **Auto-Registration**: Seamless Warp account creation and configuration
- **Modern UI**: Beautiful HTML configuration interface with instant setup links
- **Administrative Privileges**: Automatic UAC elevation for system-level operations

## 📋 System Requirements

### Minimum Requirements
- **Operating System**: Windows 10/11 (x86/x64)
- **PowerShell**: Version 5.0 or higher
- **Network**: Active internet connection for initial setup
- **Privileges**: Administrator access (automatically requested)
- **Disk Space**: ~10MB for components and configurations

### Recommended Environment
- **RAM**: 4GB+ available system memory
- **Network**: Broadband connection (10+ Mbps)
- **Firewall**: Windows Defender Firewall enabled
- **Antivirus**: Whitelist for sing-box-plus.exe (if required)

## 🚀 Quick Start Guide

### Initial Deployment

1. **Download Repository**
   ```
   git clone https://github.com/vancedapps/telegram-proxy.git
   cd telegram-proxy
   ```

2. **Execute Setup Script**
   - Double-click `start-telegram-proxy.bat`
   - Approve UAC prompt when requested
   - Wait for automatic component download and configuration

3. **Configure Telegram Client**
   - Click the auto-generated setup link, or
   - Use the modern HTML configuration interface
   - Manual configuration: `127.0.0.1:7777` (SOCKS5)

### Subsequent Usage
- Simply run `start-telegram-proxy.bat` again
- The script intelligently skips downloads and registration
- Provides immediate proxy server startup

## 🔧 Technical Implementation

### Component Architecture

```
📁 Project Structure
├── 🔧 start-telegram-proxy.bat          # Main orchestration script
├── 📄 README.md                         # Documentation (this file)
├── ⚙️ singbox-config-template.json      # Embedded configuration template
├── 🔑 wgcf-account.toml                 # Warp account credentials (auto-generated)
├── 📋 wgcf-profile.conf                 # WireGuard configuration (auto-generated)
├── ⚙️ singbox-config.json               # sing-box runtime configuration (auto-generated)
├── 🌐 telegram_proxy_setup.html         # Modern configuration interface (auto-generated)
├── 📦 wgcf.exe                          # Cloudflare Warp configuration utility (auto-downloaded)
└── 🚀 sing-box-plus.exe                 # Proxy server engine (auto-downloaded)
```

### Setup Workflow

#### Phase 1: Environment Preparation
1. **Working Directory Management**: Automatic path resolution and administrative elevation
2. **Component Acquisition**: Intelligent download of required binaries from official sources
3. **Firewall Configuration**: Automatic Windows Firewall exception creation
4. **Template Generation**: Embedded sing-box configuration template creation

#### Phase 2: Warp Account Management
1. **Account Registration**: New Cloudflare Warp account creation (first run only)
2. **Configuration Update**: Account refresh and profile regeneration
3. **Key Extraction**: Private key extraction from Warp account configuration
4. **Profile Generation**: WireGuard profile creation for network connectivity

#### Phase 3: Proxy Server Deployment
1. **Configuration Assembly**: sing-box configuration generation with extracted credentials
2. **Network Interface Setup**: SOCKS5 server binding to localhost:7777
3. **UI Generation**: Modern HTML configuration interface creation
4. **Service Startup**: Proxy server initialization with monitoring

### Network Configuration

```json
{
  "inbounds": [{
    "type": "socks",
    "listen": "0.0.0.0",
    "listen_port": 7777,
    "users": []
  }],
  "outbounds": [{
    "type": "wireguard",
    "local_address": ["10.0.0.1/32"],
    "private_key": "[AUTO-EXTRACTED]",
    "peers": [{
      "server": "warp_auto",
      "public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
      "allowed_ips": ["0.0.0.0/0"]
    }]
  }]
}
```

## 📱 Client Configuration

### Telegram Desktop
1. **Access Settings**: `Settings` → `Advanced` → `Connection Type`
2. **Enable Proxy**: Select "Use custom proxy"
3. **Configure SOCKS5**:
   - **Type**: SOCKS5
   - **Hostname**: `127.0.0.1`
   - **Port**: `7777`
   - **Credentials**: Leave empty

### Telegram Mobile (iOS/Android)
1. **Access Settings**: `Settings` → `Data and Storage` → `Proxy Settings`
2. **Add Proxy**: Tap "Add Proxy" → "SOCKS5"
3. **Configure Connection**:
   - **Server**: `127.0.0.1`
   - **Port**: `7777`
   - **Authentication**: None required

### LAN Network Sharing
For other devices on your local network:
- Replace `127.0.0.1` with your computer's IP address
- Example: `192.168.1.100:7777`
- Ensure Windows Firewall allows connections

## 🔧 Advanced Configuration

### Custom Port Configuration
Modify the listen port in `singbox-config-template.json`:
```json
"listen_port": 7777  // Change to desired port
```

### Network Interface Binding
Change binding address for external access:
```json
"listen": "0.0.0.0"  // All interfaces
"listen": "127.0.0.1"  // Localhost only
```

### MTU Optimization
Adjust MTU size for specific network conditions:
```json
"mtu": 1280  // Default optimized value
```

## 🛠️ Troubleshooting

### Common Issues & Solutions

#### Administrative Privileges
**Symptom**: "Permission denied" or binding errors
**Solution**: Ensure UAC prompt is approved; manually run as administrator if needed

#### Firewall Blocking
**Symptom**: Proxy starts but connections fail
**Solution**: Script automatically configures firewall; manually add sing-box-plus.exe exception if needed

#### Port Conflicts
**Symptom**: "Address already in use" errors
**Solution**: Check for existing services on port 7777:
```cmd
netstat -an | findstr :7777
```

#### Download Failures
**Symptom**: Component download errors
**Solution**: Verify internet connectivity; manually download from:
- [wgcf releases](https://github.com/ViRb3/wgcf/releases)
- [sing-box-plus releases](https://github.com/kyochikuto/sing-box-plus/releases)

#### Registration Issues
**Symptom**: Warp account registration fails
**Solution**: Check regional restrictions; retry with different network or VPN

### Performance Optimization

#### Network Latency
- **Monitor Connection**: Use Telegram's built-in connection quality indicator
- **Server Selection**: Restart script to potentially connect to different edge server
- **MTU Tuning**: Experiment with values between 1200-1400

#### Bandwidth Management
- **QoS Configuration**: Use router-level QoS for optimal bandwidth allocation
- **Connection Limits**: Monitor concurrent connections if sharing across multiple devices

## 🔒 Security Considerations

### Data Protection
- **Local Storage**: All configurations stored locally; no cloud synchronization
- **Credential Security**: Warp private keys stored securely in local configuration files
- **Network Isolation**: Proxy traffic isolated from system-wide network activity

### Best Practices
- **Regular Updates**: Periodically run script to update account and configuration
- **Network Monitoring**: Monitor unusual traffic patterns if sharing proxy
- **Access Control**: Limit LAN access to trusted devices only

## 🌐 Network Architecture Benefits

### Compared to Traditional VPN
| Feature | Traditional VPN | Warp Proxy Solution |
|---------|----------------|-------------------|
| **Traffic Routing** | All system traffic | Application-specific |
| **Performance Impact** | System-wide overhead | Minimal system impact |
| **Configuration** | Complex setup | One-click deployment |
| **Sharing** | Device-specific | Network-shareable |
| **Server Selection** | Manual selection | Automatic optimization |

### Compared to Third-Party Proxies
| Aspect | Third-Party Proxy | Warp Proxy Solution |
|--------|------------------|-------------------|
| **Reliability** | Variable quality | Enterprise-grade infrastructure |
| **Security** | Unknown encryption | Cloudflare-grade encryption |
| **Performance** | Fixed server locations | Automatic edge server selection |
| **Cost** | Often paid services | Free Cloudflare Warp |
| **Privacy** | Third-party logging | Cloudflare privacy policy |

## 📚 Technical References

### Related Technologies
- **WireGuard Protocol**: [https://www.wireguard.com/](https://www.wireguard.com/)
- **Cloudflare Warp**: [https://developers.cloudflare.com/warp-client/](https://developers.cloudflare.com/warp-client/)
- **sing-box**: [https://sing-box.sagernet.org/](https://sing-box.sagernet.org/)

### Component Sources
- **wgcf**: [https://github.com/ViRb3/wgcf](https://github.com/ViRb3/wgcf)
- **sing-box-plus**: [https://github.com/kyochikuto/sing-box-plus](https://github.com/kyochikuto/sing-box-plus)

## 🤝 Contributing

We welcome contributions to improve this proxy solution:
- **Bug Reports**: Submit issues with detailed reproduction steps
- **Feature Requests**: Propose enhancements with technical justification
- **Code Contributions**: Fork repository and submit pull requests
- **Documentation**: Help improve setup guides and troubleshooting

## 📄 License & Credits

**Developed by**: [vanced.to](https://vanced.to)  
**Repository**: [https://github.com/vancedapps/telegram-proxy](https://github.com/vancedapps/telegram-proxy)

### Open Source Components
- **wgcf**: MIT License - Cloudflare Warp configuration utility
- **sing-box**: Custom License - Universal proxy platform
- **Cloudflare Warp**: Cloudflare Terms of Service

---

**⚠️ Legal Notice**: This tool is designed for legitimate use cases in accordance with local laws and regulations. Users are responsible for compliance with applicable terms of service and legal requirements.

**🔧 Support**: For technical support and updates, visit [vanced.to](https://vanced.to) or submit issues on [GitHub](https://github.com/vancedapps/telegram-proxy).