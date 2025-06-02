# Cloudflare Warp SOCKS5 代理用于 Telegram

**一个专业级的自托管代理解决方案，利用 Cloudflare Warp 基础设施为 Telegram 和其他应用提供安全、高性能的连接。**

## 🏗️ 架构概览

本方案创建了一个本地 SOCKS5 代理服务器，通过 Cloudflare 的 Warp 网络转发流量，带来以下优势：

- 自动连接最近的 Cloudflare 边缘节点，延迟低、速度快
- 只为指定应用（如 Telegram）代理流量，其他应用直连互联网
- 支持局域网共享，手机/其他电脑也能用
- 一键部署，自动下载和配置所有组件

## 🚀 快速开始

1. 下载本项目：
   ```
   git clone https://github.com/vancedapps/telegram-proxy.git
   cd telegram-proxy
   ```
2. 运行 `start-telegram-proxy.bat`，同意权限提示，等待自动配置完成
3. Telegram 客户端设置 SOCKS5 代理：
   - 地址：127.0.0.1
   - 端口：7777
   - 用户名/密码留空

## 📱 手机/局域网使用

- 手机 Telegram：设置 SOCKS5 代理，服务器填电脑 IP，端口 7777
- 其他设备：同上，确保防火墙允许连接

## 🛠️ 常见问题

- **端口被占用**：换个端口或关闭占用程序
- **无法连接**：检查防火墙或网络
- **注册失败**：尝试更换网络或使用 VPN

## 🔒 安全说明

- 所有配置和密钥仅保存在本地
- 仅代理 Telegram 流量，其他应用不受影响

## 🌐 相关链接

- [WireGuard 官网](https://www.wireguard.com/)
- [Cloudflare Warp 文档](https://developers.cloudflare.com/warp-client/)
- [sing-box 项目](https://sing-box.sagernet.org/)

---

如需帮助，请访问 [vanced.to](https://vanced.to) 或在 [GitHub](https://github.com/vancedapps/telegram-proxy) 提交 issue。 