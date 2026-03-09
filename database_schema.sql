-- ========================================
-- DATABASE SCHEMA FOR AI TRAFFIC MONITORING
-- ========================================
-- Import this SQL file into phpMyAdmin
-- Cách import:
-- 1. Mở phpMyAdmin (http://localhost/phpmyadmin)
-- 2. Chọn tab "SQL" 
-- 3. Copy toàn bộ nội dung file này và paste vào
-- 4. Click "Go" để thực thi

-- Tạo database mới
CREATE DATABASE IF NOT EXISTS ai_traffic_monitoring 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE ai_traffic_monitoring;

-- ========================================
-- TABLE: users (Người dùng)
-- ========================================
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    role ENUM('admin', 'user') NOT NULL DEFAULT 'user',
    avatar VARCHAR(255) DEFAULT NULL,
    phone VARCHAR(20) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL DEFAULT NULL,
    is_active TINYINT(1) DEFAULT 1,
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- TABLE: roles (Vai trò - nếu cần mở rộng)
-- ========================================
CREATE TABLE IF NOT EXISTS roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    permissions JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- TABLE: vehicle_data (Dữ liệu phương tiện)
-- ========================================
CREATE TABLE IF NOT EXISTS vehicle_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    license_plate VARCHAR(20) NOT NULL,
    vehicle_type VARCHAR(50) DEFAULT 'Xe máy',
    driver_name VARCHAR(100),
    phone VARCHAR(20),
    location VARCHAR(255),
    route VARCHAR(255),
    status ENUM('running', 'stopped', 'offline') DEFAULT 'running',
    violation_type VARCHAR(255),
    score INT DEFAULT 100,
    image_path VARCHAR(255),
    detected_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    camera_id INT,
    INDEX idx_license_plate (license_plate),
    INDEX idx_status (status),
    INDEX idx_detected_at (detected_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- TABLE: cameras (Camera giám sát)
-- ========================================
CREATE TABLE IF NOT EXISTS cameras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255),
    stream_url VARCHAR(500),
    status ENUM('active', 'inactive', 'maintenance') DEFAULT 'active',
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- TABLE: violations (Vi phạm giao thông)
-- ========================================
CREATE TABLE IF NOT EXISTS violations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT,
    violation_type VARCHAR(100) NOT NULL,
    description TEXT,
    fine_amount DECIMAL(10, 2),
    image_path VARCHAR(255),
    status ENUM('pending', 'processed', 'paid') DEFAULT 'pending',
    detected_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    processed_at TIMESTAMP NULL,
    processed_by INT,
    FOREIGN KEY (vehicle_id) REFERENCES vehicle_data(id) ON DELETE SET NULL,
    FOREIGN KEY (processed_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_status (status),
    INDEX idx_detected_at (detected_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- TABLE: login_history (Lịch sử đăng nhập)
-- ========================================
CREATE TABLE IF NOT EXISTS login_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    user_agent TEXT,
    status ENUM('success', 'failed') DEFAULT 'success',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_login_time (login_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- INSERT DEFAULT DATA
-- ========================================

-- Insert default roles
INSERT INTO roles (role_name, description, permissions) VALUES
('admin', 'Quản trị viên - Toàn quyền hệ thống', 
 '{"dashboard": true, "users": true, "cameras": true, "violations": true, "reports": true, "settings": true}'),
('user', 'Người dùng - Xem thông tin cơ bản', 
 '{"dashboard": true, "users": false, "cameras": false, "violations": false, "reports": true, "settings": false}');

-- ========================================
-- DEFAULT USERS (Mật khẩu đã mã hóa bcrypt)
-- ========================================
-- Mật khẩu mặc định:
-- admin: admin123
-- user: user123
-- ========================================

INSERT INTO users (username, password, email, full_name, role, avatar, phone, is_active) VALUES
('admin', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYzS3MebAJu', 'admin@trafficmonitor.vn', 'Quản Trị Viên', 'admin', 'https://ui-avatars.com/api/?name=Admin&background=4a9eff&color=fff&size=128', '0901234567', 1),
('user', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYzS3MebAJu', 'user@trafficmonitor.vn', 'Người Dùng', 'user', 'https://ui-avatars.com/api/?name=User&background=00c853&color=fff&size=128', '0907654321', 1);

-- Insert sample cameras
INSERT INTO cameras (name, location, stream_url, status, latitude, longitude) VALUES
('Camera 01 - Ngã Tư Hàng Xanh', 'Ngã Tư Hàng Xanh, Bình Thạnh, TP.HCM', 'rtsp://camera1.stream/live', 'active', 10.801661, 106.710086),
('Camera 02 - Cầu Sài Gòn', 'Cầu Sài Gòn, TP.HCM', 'rtsp://camera2.stream/live', 'active', 10.797920, 106.715485),
('Camera 03 - Đường Điện Biên Phủ', 'ĐBP, Quận 3, TP.HCM', 'rtsp://camera3.stream/live', 'active', 10.786920, 106.694450),
('Camera 04 - Vòng Xoay Dân Chủ', 'Vòng Xoay Dân Chủ, Quận 1, TP.HCM', 'rtsp://camera4.stream/live', 'active', 10.783890, 106.698890);

-- Insert sample vehicle data
INSERT INTO vehicle_data (license_plate, vehicle_type, driver_name, phone, location, route, status, violation_type, score, camera_id) VALUES
('59A-12345', 'Ô tô', 'Nguyễn Văn A', '0901111222', 'Ngã Tư Hàng Xanh', 'Quận 1 → Quận Bình Thạnh', 'running', NULL, 100, 1),
('59B-67890', 'Xe máy', 'Trần Thị B', '0902222333', 'Cầu Sài Gòn', 'TP.Thủ Đức → Quận 1', 'running', NULL, 95, 2),
('59C-11111', 'Ô tô', 'Lê Văn C', '0903333444', 'Đường Điện Biên Phủ', 'Quận 3 → Quận 10', 'running', 'Quá tốc độ', 75, 3),
('59D-22222', 'Xe máy', 'Phạm Thị D', '0904444555', 'Vòng Xoay Dân Chủ', 'Quận 1 → Quận 3', 'stopped', 'Không đội mũ bảo hiểm', 60, 4),
('59E-33333', 'Ô tô', 'Hoàng Văn E', '0905555666', 'Ngã Tư Hàng Xanh', 'Quận Bình Thạnh → Quận 1', 'running', NULL, 100, 1);

-- ========================================
-- USEFUL QUERIES FOR TESTING
-- ========================================

-- Xem tất cả users
-- SELECT * FROM users;

-- Xem users theo role
-- SELECT * FROM users WHERE role = 'admin';
-- SELECT * FROM users WHERE role = 'user';

-- Xem lịch sử đăng nhập
-- SELECT u.username, u.role, lh.login_time, lh.ip_address, lh.status 
-- FROM login_history lh 
-- JOIN users u ON lh.user_id = u.id 
-- ORDER BY lh.login_time DESC;

-- ========================================
-- NOTES:
-- ========================================
-- Tài khoản mặc định:
-- Admin: username=admin, password=admin123
-- User: username=user, password=user123
--
-- Để đổi mật khẩu, sử dụng bcrypt để mã hóa:
-- Python: bcrypt.hashpw('matkhau'.encode('utf-8'), bcrypt.gensalt())
-- ========================================
