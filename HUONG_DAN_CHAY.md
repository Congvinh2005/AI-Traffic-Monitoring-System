# 🚀 HƯỚNG DẪN CHẠY HỆ THỐNG

## ⚠️ QUAN TRỌNG: Port và CORS

### Vấn đề gặp phải:
- ❌ Chạy `traffic_bus.html` từ Live Server (port 5504) → Không gọi được API
- ❌ Backend Flask chạy port 5001
- ❌ CORS policy chặn request khác port

### ✅ Giải pháp:

---

## **CÁCH 1: Cài flask-cors và chạy từ Live Server**

### Bước 1: Cài đặt flask-cors
```bash
pip install flask-cors
```

### Bước 2: Chạy backend Flask
```bash
cd /Users/vinhdv/Documents/Clone/AI-Traffic-Monitoring-System/py/Web
python drive.py
```

Backend chạy tại: `http://localhost:5001`

### Bước 3: Mở traffic_bus.html từ Live Server
```
http://localhost:5504/traffic_bus.html
```

→ ✅ Đã có CORS, API sẽ hoạt động!

---

## **CÁCH 2: Serve traffic_bus.html TỪ Flask (khuyến nghị)**

### Bước 1: Chạy backend Flask
```bash
cd /Users/vinhdv/Documents/Clone/AI-Traffic-Monitoring-System/py/Web
python drive.py
```

### Bước 2: Truy cập URL
```
http://localhost:5001/traffic_bus
```

→ ✅ File HTML được serve từ cùng port → Không cần CORS!

---

## **CÁCH 3: Mở file trực tiếp từ filesystem**

### Bước 1: Chạy backend Flask
```bash
cd /Users/vinhdv/Documents/Clone/AI-Traffic-Monitoring-System/py/Web
python drive.py
```

### Bước 2: Mở file bằng browser
```bash
open /Users/vinhdv/Documents/Clone/AI-Traffic-Monitoring-System/traffic_bus.html
```

→ ✅ File:// protocol + CORS → API hoạt động!

---

## 🧪 KIỂM TRA HOẠT ĐỘNG

### 1. Kiểm tra backend
```bash
# Terminal chạy Flask
python drive.py

# Output mong đợi:
# Starting server on port 5001...
# * Running on all addresses (0.0.0.0)
# * Running on http://127.0.0.1:5001
```

### 2. Kiểm tra API
```bash
# Mở terminal mới, test API:
curl http://localhost:5001/api/get_ai_warnings

# Kết quả mong đợi:
# {"eye":"","yawn":"","head":"","phone":"","seatbelt":"","hand":"","collision":"","lane":""}
```

### 3. Kiểm tra frontend
1. Mở browser tại `http://localhost:5504/traffic_bus.html`
2. Mở Console (F12)
3. Click nút "🔔" hoặc "🎤"
4. Không có lỗi CORS trong Console ✅

---

## 🔍 XỬ LÝ SỰ CỐ

### Lỗi: "Failed to fetch"
**Nguyên nhân:** Backend chưa chạy hoặc sai port

**Giải pháp:**
```bash
# Kiểm tra port 5001 có đang dùng không
lsof -i :5001

# Nếu không có, chạy lại Flask
python drive.py
```

### Lỗi: "CORS policy blocked"
**Nguyên nhân:** Chưa cài flask-cors

**Giải pháp:**
```bash
pip install flask-cors
# Restart Flask
```

### Cảnh báo không hiển thị
**Nguyên nhân:** 
- Backend không gửi cảnh báo
- Frontend không poll đúng API

**Kiểm tra:**
1. Backend log có `[AI ALERT]` không?
2. Console log có `Lỗi khi lấy cảnh báo AI` không?
3. Network tab (F12) có request đến `localhost:5001/api/get_ai_warnings` không?

---

## 📊 PORT MẶC ĐỊNH

| Service | Port | URL |
|---------|------|-----|
| Flask backend | 5001 | http://localhost:5001 |
| Live Server | 5504 | http://localhost:5504 |
| traffic_bus route | 5001 | http://localhost:5001/traffic_bus |

---

## 🎯 KHUYẾN NGHỊ

**Dùng CÁCH 2** (serve từ Flask) vì:
- ✅ Không cần CORS config
- ✅ Cùng port → Đơn giản
- ✅ Dễ deploy production

**Chỉ dùng Live Server** khi:
- ✅ Cần hot reload khi dev frontend
- ✅ Đã config CORS đúng

---

**Chúc thành công! 🚀**
