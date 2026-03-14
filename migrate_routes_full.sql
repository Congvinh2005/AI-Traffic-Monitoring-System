-- Migration script để hỗ trợ lưu trữ tuyến đường với nhiều điểm tọa độ
-- Chạy: mysql -u root -p giam_sat < migrate_routes_full.sql

USE giam_sat;

-- Bước 1: Cập nhật bảng tuyen_duong với các cột mới
ALTER TABLE tuyen_duong 
ADD COLUMN IF NOT EXISTS distance DECIMAL(10,2) DEFAULT 0 COMMENT 'Khoảng cách (km)' AFTER toa_do_lng,
ADD COLUMN IF NOT EXISTS duration INT DEFAULT 0 COMMENT 'Thời gian (phút)' AFTER distance,
ADD COLUMN IF NOT EXISTS vehicles VARCHAR(50) DEFAULT NULL COMMENT 'Số lượng xe' AFTER duration,
ADD COLUMN IF NOT EXISTS route_color VARCHAR(20) DEFAULT '#4a9eff' COMMENT 'Màu sắc tuyến đường' AFTER vehicles;

-- Bước 2: Tạo bảng mới để lưu các điểm tọa độ của tuyến đường
CREATE TABLE IF NOT EXISTS tuyen_duong_path (
  id INT(11) AUTO_INCREMENT PRIMARY KEY,
  id_tuyen_duong VARCHAR(50) NOT NULL,
  point_order INT(11) NOT NULL COMMENT 'Thứ tự điểm trong tuyến',
  latitude DECIMAL(10,8) NOT NULL,
  longitude DECIMAL(11,8) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_tuyen_duong) REFERENCES tuyen_duong(id) ON DELETE CASCADE,
  INDEX idx_tuyen_duong (id_tuyen_duong),
  INDEX idx_point_order (id_tuyen_duong, point_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bước 3: Dữ liệu mẫu cho các tuyến đường
-- Xóa dữ liệu cũ (nếu cần)
DELETE FROM tuyen_duong_path;
DELETE FROM tuyen_duong;

-- Insert các tuyến đường chính
INSERT INTO tuyen_duong (id, ten_tuyen, mo_ta, distance, duration, vehicles, route_color, trang_thai) VALUES
('T001', 'Mỹ Đình - Hải Phòng', 'Tuyến đường từ bến xe Mỹ Đình đến bến xe Hải Phòng', 102, 120, '12 xe/ngày', '#4a9eff', 'active'),
('T002', 'Nội Bài - Trung tâm Hà Nội', 'Tuyến đường từ sân bay Nội Bài vào trung tâm Hà Nội', 28, 45, '45 xe/ngày', '#00c853', 'active'),
('T003', 'Hồ Tây - Lăng Bác', 'Tuyến đường du lịch từ Hồ Tây đến Lăng Bác', 8, 25, '28 xe/ngày', '#ffc107', 'active'),
('T004', 'Cầu Giấy - Long Biên', 'Tuyến đường nối quận Cầu Giấy và Long Biên', 15, 40, '20 xe/ngày', '#ff5252', 'active'),
('T005', 'Hà Đông - Hoàn Kiếm', 'Tuyến đường từ Hà Đông vào hồ Hoàn Kiếm', 12, 35, '35 xe/ngày', '#9c27b0', 'active');

-- Insert các điểm path cho T001 - Mỹ Đình - Hải Phòng
INSERT INTO tuyen_duong_path (id_tuyen_duong, point_order, latitude, longitude) VALUES
('T001', 1, 21.0300, 105.7800),  -- Bến xe Mỹ Đình (điểm đầu)
('T001', 2, 21.0250, 105.8200),  -- Điểm trung gian 1
('T001', 3, 21.0200, 105.8600),  -- Điểm trung gian 2
('T001', 4, 20.9500, 106.1000);  -- Bến xe Hải Phòng (điểm cuối)

-- Insert các điểm path cho T002 - Nội Bài - Trung tâm Hà Nội
INSERT INTO tuyen_duong_path (id_tuyen_duong, point_order, latitude, longitude) VALUES
('T002', 1, 21.2200, 105.8000),  -- Sân bay Nội Bài (điểm đầu)
('T002', 2, 21.1500, 105.8200),  -- Điểm trung gian 1
('T002', 3, 21.0800, 105.8400),  -- Điểm trung gian 2
('T002', 4, 21.0285, 105.8542);  -- Hồ Hoàn Kiếm (điểm cuối)

-- Insert các điểm path cho T003 - Hồ Tây - Lăng Bác
INSERT INTO tuyen_duong_path (id_tuyen_duong, point_order, latitude, longitude) VALUES
('T003', 1, 21.0450, 105.8150),  -- Hồ Tây (điểm đầu)
('T003', 2, 21.0400, 105.8250),  -- Điểm trung gian
('T003', 3, 21.0350, 105.8350);  -- Lăng Bác (điểm cuối)

-- Insert các điểm path cho T004 - Cầu Giấy - Long Biên
INSERT INTO tuyen_duong_path (id_tuyen_duong, point_order, latitude, longitude) VALUES
('T004', 1, 21.0350, 105.7900),  -- Cầu Giấy (điểm đầu)
('T004', 2, 21.0300, 105.8100),  -- Điểm trung gian 1
('T004', 3, 21.0250, 105.8300),  -- Điểm trung gian 2
('T004', 4, 21.0200, 105.8500);  -- Long Biên (điểm cuối)

-- Insert các điểm path cho T005 - Hà Đông - Hoàn Kiếm
INSERT INTO tuyen_duong_path (id_tuyen_duong, point_order, latitude, longitude) VALUES
('T005', 1, 20.9800, 105.7800),  -- Hà Đông (điểm đầu)
('T005', 2, 21.0000, 105.8000),  -- Điểm trung gian 1
('T005', 3, 21.0150, 105.8200),  -- Điểm trung gian 2
('T005', 4, 21.0285, 105.8542);  -- Hồ Gươm (điểm cuối)

-- Cập nhật thông tin start/end cho bảng tuyen_duong (lấy từ điểm đầu/cuối của path)
UPDATE tuyen_duong td
SET 
  start_lat = (SELECT latitude FROM tuyen_duong_path WHERE id_tuyen_duong = td.id AND point_order = 1),
  start_lng = (SELECT longitude FROM tuyen_duong_path WHERE id_tuyen_duong = td.id AND point_order = 1),
  end_lat = (SELECT latitude FROM tuyen_duong_path WHERE id_tuyen_duong = td.id ORDER BY point_order DESC LIMIT 1),
  end_lng = (SELECT longitude FROM tuyen_duong_path WHERE id_tuyen_duong = td.id ORDER BY point_order DESC LIMIT 1);

-- Xem kết quả
SELECT '=== TUYẾN ĐƯỜNG ===' as '';
SELECT id, ten_tuyen, distance, duration, vehicles, route_color, trang_thai FROM tuyen_duong;

SELECT '=== CÁC ĐIỂM PATH ===' as '';
SELECT p.id_tuyen_duong, t.ten_tuyen, p.point_order, p.latitude, p.longitude 
FROM tuyen_duong_path p 
JOIN tuyen_duong t ON p.id_tuyen_duong = t.id 
ORDER BY p.id_tuyen_duong, p.point_order;

SELECT '=== KIỂM TRA TỌA ĐỘ ĐẦU CUỐI ===' as '';
SELECT 
  id,
  ten_tuyen,
  start_lat,
  start_lng,
  end_lat,
  end_lng
FROM tuyen_duong;

-- Migration complete!
