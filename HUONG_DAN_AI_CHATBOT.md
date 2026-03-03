# 🚀 HƯỚNG DẪN SỬ DỤNG HỆ THỐNG GIÁM SÁT GIAO THÔNG TÍCH HỢP AI & CHATBOT

## 📋 Tổng quan tính năng mới

Hệ thống `traffic_bus.html` đã được nâng cấp với 2 tính năng chính:

### 1. 🎤 **Điều khiển bằng giọng nói** (Voice Control)
- Nhận diện giọng nói tiếng Việt
- Ra lệnh tìm xe, mở chat, xem cảnh báo
- Hỗ trợ các lệnh thoại thông minh

### 2. 🔔 **Cảnh báo AI thời gian thực** (AI Real-time Alerts)
- Nhận cảnh báo từ backend AI (driver monitoring)
- Hiển thị panel cảnh báo góc phải màn hình
- Tự động gửi cảnh báo vào chatbot

---

## 🎯 **CÁC LỆNH GIỌNG NÓI HỖ TRỢ**

### Tìm kiếm xe
| Lệnh | Tác vụ |
|------|--------|
| "Hiển thị xe 29B-222.22" | Focus vào xe có biển số 29B-222.22 |
| "Tìm xe 29A-111.11" | Tìm và hiển thị xe 29A-111.11 |
| "Tìm xe gần nhất" | Tìm xe gần vị trí hiện tại nhất |
| "Hiển thị xe khách" | Hiển thị xe khách/bus gần nhất |
| "Hiển thị xe con" | Hiển thị xe con/taxi gần nhất |

### Điều khiển hệ thống
| Lệnh | Tác vụ |
|------|--------|
| "Mở camera tài xế" | Xem camera giám sát tài xế |
| "Gọi hỗ trợ" | Mở chatbot hỗ trợ |
| "Nhắn tin cho tài xế" | Mở chat với tài xế |
| "Xem cảnh báo" | Hiển thị panel cảnh báo AI |
| "Xem tất cả cảnh báo" | Xem lịch sử cảnh báo |

---

## 🔔 **CÁC LOẠI CẢNH BÁO AI**

Hệ thống AI sẽ tự động phát hiện và gửi cảnh báo:

### ⚠️ Cảnh báo nguy hiểm (Critical)
- **Nhắm mắt quá lâu** - Tài xế buồn ngủ, mệt mỏi
- **Dùng điện thoại** - Tài xế sử dụng điện thoại khi lái xe
- **Không đeo dây an toàn** - Vi phạm an toàn
- **Va chạm** - Phát hiện va chạm sắp xảy ra

### ⚠️ Cảnh báo lưu ý (Warning)
- **Ngáp ngủ** - Tài xế có dấu hiệu mệt mỏi
- **Mất tập trung** - Quay đầu/ngửa đầu quá mức
- **Không cầm vô lăng** - Tay không đúng vị trí
- **Lệch làn** - Xe đi chệch làn đường

---

## 🛠️ **CÁCH SỬ DỤNG**

### Bước 1: Chạy backend Flask
```bash
cd /Users/vinhdv/Documents/Clone/AI-Traffic-Monitoring-System/py/Web
python all_tong.py
```

Backend sẽ chạy tại: `http://127.0.0.1:5001`

### Bước 2: Mở giao diện traffic_bus.html
```bash
# Mở file trong trình duyệt (Chrome khuyến nghị)
open /Users/vinhdv/Documents/Clone/AI-Traffic-Monitoring-System/traffic_bus.html
```

Hoặc truy cập URL nếu dùng Flask server:
```
http://127.0.0.1:5001/traffic_bus
```

### Bước 3: Sử dụng tính năng

#### 🎤 Dùng giọng nói:
1. Click vào nút **microphone màu đỏ** ở góc dưới bên phải
2. Nói lệnh (ví dụ: "Hiển thị xe 29B-222.22")
3. Hệ thống sẽ tự động thực hiện lệnh

#### 🔔 Xem cảnh báo AI:
1. Click vào nút **cái chuông** hoặc đợi cảnh báo tự động
2. Panel cảnh báo sẽ hiện ở góc phải trên
3. Cảnh báo cũng xuất hiện trong chatbot

#### 💬 Chat với hỗ trợ:
1. Click vào nút **tin nhắn màu xanh** ở góc dưới
2. Nhập câu hỏi hoặc chọn "Bắt đầu trò chuyện"
3. Chatbot sẽ phản hồi tự động

---

## 🔧 **CẤU HÌNH & TÙY CHỈNH**

### Thay đổi API endpoint
Trong `traffic_bus.html`, tìm dòng:
```javascript
fetch('/api/get_ai_warnings')
```
Thay đổi thành URL backend của bạn nếu cần.

### Thay đổi thời gian poll cảnh báo
```javascript
// Mặc định 3 giây
alertsPollingInterval = setInterval(() => {
    fetchAICurrentWarnings();
}, 3000);  // Thay đổi số này
```

### Thêm lệnh giọng nói mới
Trong hàm `processVoiceCommand()`:
```javascript
else if (cmd.includes('từ khóa mới')) {
    // Xử lý lệnh mới
    addSystemMsg('Phản hồi cho lệnh mới');
}
```

---

## 📊 **KIẾN TRÚC HỆ THỐNG**

```
┌─────────────────────────────────────────────────────┐
│                  TRAFFIC_BUS.HTML                    │
│  ┌──────────┐  ┌──────────┐  ┌──────────────────┐  │
│  │  Voice   │  │  Chatbot │  │  AI Alerts Panel │  │
│  │  Control │  │  Widget  │  │                  │  │
│  └──────────┘  └──────────┘  └──────────────────┘  │
└─────────────────────────────────────────────────────┘
           │                    │
           │ HTTP Requests      │ Polling (3s)
           ▼                    ▼
┌─────────────────────────────────────────────────────┐
│                   ALL_TONG.PY                        │
│  ┌──────────────────┐  ┌──────────────────────────┐│
│  │  AI Detection    │  │  Chatbot API Endpoints  ││
│  │  - Eye tracking  │  │  - /api/get_ai_warnings ││
│  │  - Yawn detect   │  │  - /api/process_voice   ││
│  │  - Phone detect  │  │  - /api/send_message    ││
│  │  - Seatbelt      │  │  - /api/alerts_history  ││
│  │  - Hand wheel    │  │                         ││
│  └──────────────────┘  └──────────────────────────┘│
└─────────────────────────────────────────────────────┘
```

---

## 🐛 **XỬ LÝ SỰ CỐ**

### Không nhận diện được giọng nói
- ✅ Sử dụng Google Chrome (khuyến nghị)
- ✅ Kiểm tra permission microphone
- ✅ Đảm bảo kết nối internet (cho Google Speech API)

### Không thấy cảnh báo AI
- ✅ Kiểm tra backend Flask đang chạy
- ✅ Kiểm tra console log (F12)
- ✅ Đảm bảo API endpoint đúng

### Chatbot không phản hồi
- ✅ Kiểm tra kết nối mạng
- ✅ Xóa cache trình duyệt
- ✅ Reload trang (F5)

---

## 📱 **TƯƠNG THÍCH TRÌNH DUYỆT**

| Trình duyệt | Voice Control | Chatbot | Alerts Panel |
|-------------|---------------|---------|--------------|
| Chrome ✅   | ✅ Full       | ✅      | ✅           |
| Edge ✅     | ✅ Full       | ✅      | ✅           |
| Safari ⚠️   | ⚠️ Hạn chế    | ✅      | ✅           |
| Firefox ⚠️  | ⚠️ Hạn chế    | ✅      | ✅           |

---

## 🎓 **VÍ DỤ KỊCH BẢN SỬ DỤNG**

### Kịch bản 1: Giám sát hành trình
```
1. Mở traffic_bus.html
2. Click vào xe cần giám sát
3. Click nút microphone: "Xem cảnh báo"
4. Panel AI hiện ra với các cảnh báo thời gian thực
5. Khi có cảnh báo "Ngáp ngủ", chatbot tự động thông báo
```

### Kịch bản 2: Tìm xe nhanh
```
1. Click nút microphone
2. Nói: "Hiển thị xe 29B-222.22"
3. Bản đồ tự động focus vào xe
4. Popup thông tin xe hiện ra
```

### Kịch bản 3: Hỗ trợ khẩn cấp
```
1. Khi có cảnh báo va chạm
2. Click vào chatbot
3. Nói/Nhập: "Xe đang gặp sự cố"
4. Chatbot: "Đã ghi nhận, đang liên hệ hỗ trợ..."
```

---

## 📞 **HỖ TRỢ**

Nếu gặp vấn đề, kiểm tra:
1. Console log (F12 → Console)
2. Network tab (F12 → Network)
3. Backend log (terminal chạy Flask)

---

**Chúc bạn sử dụng vui vẻ! 🚀**
