# Proxy Cloudflare Warp SOCKS5 cho Telegram

**Giải pháp proxy chuyên nghiệp, tự host, sử dụng hạ tầng Cloudflare Warp cho Telegram và các ứng dụng khác — an toàn, nhanh chóng, dễ dùng.**

## 🏗️ Tổng quan kiến trúc

Dự án này tạo một proxy SOCKS5 cục bộ, chuyển hướng lưu lượng qua mạng Cloudflare Warp:

- Tự động kết nối đến máy chủ Cloudflare gần nhất, giảm ping, tăng tốc độ
- Chỉ các ứng dụng được chọn (ví dụ Telegram) mới đi qua proxy, các app khác truy cập internet trực tiếp
- Có thể chia sẻ proxy trong mạng LAN — điện thoại, máy tính khác đều dùng được
- Cài đặt cực dễ: mọi thứ tự động tải về và cấu hình

## 🚀 Hướng dẫn nhanh

1. Tải về dự án:
   ```
   git clone https://github.com/vancedapps/telegram-proxy.git
   cd telegram-proxy
   ```
2. Chạy `start-telegram-proxy.bat`, cấp quyền admin khi được hỏi, chờ cấu hình tự động
3. Cài đặt proxy SOCKS5 trong Telegram:
   - Server: 127.0.0.1
   - Port: 7777
   - Username/Password: để trống

## 📱 Dùng trên điện thoại/mạng LAN

- Telegram trên điện thoại: nhập IP máy tính và port 7777
- Thiết bị khác: làm tương tự, nhớ mở firewall cho phép kết nối

## 🛠️ Lỗi thường gặp

- **Cổng bị chiếm**: đổi cổng khác hoặc tắt ứng dụng đang dùng cổng đó
- **Không kết nối được**: kiểm tra firewall hoặc mạng
- **Đăng ký thất bại**: thử mạng khác hoặc dùng VPN

## 🔒 Bảo mật

- Mọi cấu hình và khóa chỉ lưu trên máy bạn
- Proxy chỉ áp dụng cho Telegram, các ứng dụng khác không bị ảnh hưởng

## 🌐 Liên kết hữu ích

- [WireGuard](https://www.wireguard.com/)
- [Cloudflare Warp](https://developers.cloudflare.com/warp-client/)
- [sing-box](https://sing-box.sagernet.org/)

---

Cần hỗ trợ? Truy cập [vanced.to](https://vanced.to) hoặc tạo issue trên [GitHub](https://github.com/vancedapps/telegram-proxy). 