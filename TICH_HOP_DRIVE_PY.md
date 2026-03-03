# 📝 TÓM TẮT TÍCH HỢP AI CHATBOT & VOICE CONTROL

## ✅ File đã cập nhật

### 1. `traffic_bus.html`
Giao diện frontend với:
- 🎤 Nút điều khiển giọng nói (góc dưới phải)
- 🔔 Panel cảnh báo AI thời gian thực (góc trên phải)
- 💬 Chatbot widget cải tiến
- 🗺️ Bản đồ Leaflet với vehicle tracking

### 2. `py/Web/all_tong.py`
Backend AI monitoring với:
- ✅ Biến toàn cục `ai_alerts_queue` cho chatbot
- ✅ Hàm `add_ai_alert()` tự động gửi cảnh báo
- ✅ Tích hợp vào `driver_monitor()` cho từng loại cảnh báo
- ✅ 5 API endpoints mới:
  - `/api/get_ai_warnings`
  - `/api/get_ai_alerts_history`
  - `/api/set_monitoring_vehicle`
  - `/api/process_voice_command`
  - `/api/send_chat_message`

### 3. `py/Web/drive.py` ⭐ **MỚI CẬP NHẬT**
Tương tự `all_tong.py` với:
- ✅ Biến `ai_alerts_queue` và `ai_alerts_lock`
- ✅ Hàm `add_ai_alert()`
- ✅ Biến `previous_warnings` để tránh spam
- ✅ Tích hợp cảnh báo vào:
  - Eye detection (nhắm mắt)
  - Yawn detection (ngáp)
  - Head pose (quay đầu)
  - Phone detection (điện thoại)
  - Seatbelt detection (dây an toàn)
  - Hand detection (tay lái)
- ✅ 5 API endpoints (giống all_tong.py)
- ✅ Hàm `generate_bot_response()` cho chatbot

---

## 🔧 Cấu trúc tích hợp

```
┌─────────────────────────────────────────────────────────┐
│              TRAFFIC_BUS.HTML (Frontend)                │
│                                                         │
│  ┌────────────┐  ┌─────────────┐  ┌─────────────────┐ │
│  │   Voice    │  │   Chatbot   │  │  AI Alerts      │ │
│  │   Control  │  │   Widget    │  │  Panel          │ │
│  └────────────┘  └─────────────┘  └─────────────────┘ │
│         │                │                   │         │
│         │ HTTP POST      │ HTTP GET/POST     │ Polling │
│         ▼                ▼                   ▼         │
└─────────────────────────────────────────────────────────┘
                            │
         ┌──────────────────┼──────────────────┐
         │                  │                  │
         ▼                  ▼                  ▼
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│  ALL_TONG.PY    │ │   DRIVE.PY      │ │  Other Modules  │
│  (AI Monitor)   │ │  (AI Monitor)   │ │                 │
│                 │ │                 │ │                 │
│ - Eye tracking  │ │ - Eye tracking  │ │                 │
│ - Yawn detect   │ │ - Yawn detect   │ │                 │
│ - Phone detect  │ │ - Phone detect  │ │                 │
│ - Seatbelt      │ │ - Seatbelt      │ │                 │
│ - Hand wheel    │ │ - Hand wheel    │ │                 │
│                 │ │                 │ │                 │
│ API Endpoints:  │ │ API Endpoints:  │ │                 │
│ /api/get_ai_*   │ │ /api/get_ai_*   │ │                 │
│ /api/process_*  │ │ /api/process_*  │ │                 │
│ /api/send_*     │ │ /api/send_*     │ │                 │
└─────────────────┘ └─────────────────┘ └─────────────────┘
```

---

## 🎯 Các cảnh báo AI được tích hợp

| Loại | Mức độ | Hành động |
|------|--------|-----------|
| Nhắm mắt quá lâu | 🔴 Critical | Sound + Alert + Chatbot |
| Ngáp ngủ | 🟡 Warning | Sound + Alert + Chatbot |
| Mất tập trung | 🟡 Warning | Sound + Alert + Chatbot |
| Dùng điện thoại | 🔴 Critical | Sound + Alert + Chatbot |
| Không dây an toàn | 🔴 Critical | Sound + Alert + Chatbot |
| Không cầm vô lăng | 🟡 Warning | Sound + Alert + Chatbot |
| Va chạm | 🔴 Critical | Sound + Alert + Chatbot |
| Lệch làn | 🟡 Warning | Sound + Alert + Chatbot |

---

## 🚀 Cách chạy

### Terminal 1: Chạy backend
```bash
cd /Users/vinhdv/Documents/Clone/AI-Traffic-Monitoring-System/py/Web
python all_tong.py
# hoặc
python drive.py
```

### Terminal 2: Mở frontend
```bash
open /Users/vinhdv/Documents/Clone/AI-Traffic-Monitoring-System/traffic_bus.html
```

---

## 📖 Lệnh giọng nói hỗ trợ

```
🎤 "Hiển thị xe 29B-222.22"  → Focus vào xe
🎤 "Tìm xe gần nhất"         → Tìm xe gần
🎤 "Mở camera tài xế"        → Xem camera
🎤 "Gọi hỗ trợ"              → Mở chat
🎤 "Xem cảnh báo"            → Mở alerts panel
```

---

## 🔍 Kiểm tra API

```bash
# Lấy cảnh báo hiện tại
curl http://localhost:5001/api/get_ai_warnings

# Lấy lịch sử cảnh báo
curl http://localhost:5001/api/get_ai_alerts_history

# Thiết lập xe giám sát
curl -X POST http://localhost:5001/api/set_monitoring_vehicle \
  -H "Content-Type: application/json" \
  -d '{"vehicle_id": 2}'

# Gửi tin nhắn chatbot
curl -X POST http://localhost:5001/api/send_chat_message \
  -H "Content-Type: application/json" \
  -d '{"message": "Xin chào", "vehicle_id": 2}'
```

---

## 📁 File liên quan

| File | Mục đích |
|------|----------|
| `traffic_bus.html` | Giao diện chính |
| `py/Web/all_tong.py` | Backend AI 1 |
| `py/Web/drive.py` | Backend AI 2 |
| `HUONG_DAN_AI_CHATBOT.md` | Hướng dẫn chi tiết |

---

## ✨ Điểm nổi bật

1. **Real-time Alerts**: Polling mỗi 3 giây
2. **Smart Deduplication**: Tránh spam cảnh báo trùng
3. **Voice Recognition**: Web Speech API tiếng Việt
4. **Auto Bot Response**: Chatbot tự động trả lời
5. **Responsive UI**: Panel, widget, animations

---

**Đã hoàn thành tích hợp! 🎉**
