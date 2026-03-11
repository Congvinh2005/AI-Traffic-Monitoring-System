-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost
-- Thời gian đã tạo: Th3 11, 2026 lúc 04:01 PM
-- Phiên bản máy phục vụ: 10.4.27-MariaDB
-- Phiên bản PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `ai_traffic_monitoring`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `canh_bao` (alerts)
--

CREATE TABLE `canh_bao` (
  `id` int(11) NOT NULL,
  `xe_id` int(11) DEFAULT NULL,
  `tai_xe_id` int(11) DEFAULT NULL,
  `loai` enum('eye','yawn','head','phone','seatbelt','hand','collision','lane','obstacle') DEFAULT NULL,
  `noi_dung` text DEFAULT NULL,
  `muc_do` enum('critical','warning','info') DEFAULT 'warning',
  `duong_dan_anh` varchar(255) DEFAULT NULL,
  `duong_dan_video` varchar(255) DEFAULT NULL,
  `thoi_gian` datetime DEFAULT current_timestamp(),
  `da_doc` tinyint(4) DEFAULT 0,
  `da_xu_ly` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `canh_bao`
--

INSERT INTO `canh_bao` (`id`, `xe_id`, `tai_xe_id`, `loai`, `noi_dung`, `muc_do`, `duong_dan_anh`, `duong_dan_video`, `thoi_gian`, `da_doc`, `da_xu_ly`) VALUES
(1, 1, 1, 'eye', 'Tài xế đang nhắm mắt quá lâu', 'critical', NULL, NULL, '2026-03-11 09:32:49', 1, 0),
(2, 1, 1, 'phone', 'Tài xế đang dùng điện thoại', 'critical', NULL, NULL, '2026-03-11 08:32:49', 1, 1),
(3, 1, 1, 'seatbelt', 'Tài xế không đeo dây an toàn', 'critical', NULL, NULL, '2026-03-11 07:32:49', 0, 0),
(4, 1, 1, 'yawn', 'Tài xế đang ngáp ngủ', 'warning', NULL, NULL, '2026-03-11 06:32:49', 1, 1),
(5, 1, 1, 'head', 'Tài xế mất tập trung', 'warning', NULL, NULL, '2026-03-11 05:32:49', 1, 1),
(6, 1, 1, 'hand', 'Không cầm vô lăng', 'warning', NULL, NULL, '2026-03-11 04:32:49', 1, 1),
(7, 2, 1, 'collision', '🚨 Cảnh báo va chạm', 'critical', NULL, NULL, '2026-03-10 10:32:49', 1, 1),
(8, 2, 1, 'lane', '⚠️ Xe đang lệch làn', 'warning', NULL, NULL, '2026-03-10 10:32:49', 1, 1),
(9, 3, 1, 'obstacle', '⚠️ Vật cản phía trước', 'warning', NULL, NULL, '2026-03-09 10:32:49', 1, 1),
(10, 1, 1, 'eye', 'Tài xế đang nhắm mắt quá lâu', 'critical', NULL, NULL, '2026-03-09 10:32:49', 1, 1),
(11, 1, 1, 'phone', 'Tài xế đang dùng điện thoại', 'critical', NULL, NULL, '2026-03-08 10:32:49', 1, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tai_xe` (drivers)
--

CREATE TABLE `tai_xe` (
  `id` int(11) NOT NULL,
  `nguoi_dung_id` int(11) DEFAULT NULL,
  `ho_va_ten` varchar(100) DEFAULT NULL,
  `so_dien_thoai` varchar(20) DEFAULT NULL,
  `so_giay_phep` varchar(50) DEFAULT NULL,
  `nam_kinh_nghiem` int(11) DEFAULT NULL,
  `danh_gia` decimal(3,2) DEFAULT 5.00,
  `tong_chuyen` int(11) DEFAULT 0,
  `diem_an_toan` int(11) DEFAULT 100,
  `trang_thai` enum('active','inactive','suspended') DEFAULT 'active',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tai_xe`
--

INSERT INTO `tai_xe` (`id`, `nguoi_dung_id`, `ho_va_ten`, `so_dien_thoai`, `so_giay_phep`, `nam_kinh_nghiem`, `danh_gia`, `tong_chuyen`, `diem_an_toan`, `trang_thai`, `ngay_tao`) VALUES
(1, 2, 'Nguyễn Văn A', '0909123456', 'B2-123456', 5, '5.00', 150, 85, 'active', '2026-03-11 03:32:49'),
(2, 3, 'Nguyen Van A', '0900000001', 'LIC001', 5, '4.50', 120, 90, 'active', '2026-03-11 14:31:58'),
(3, 4, 'Tran Van B', '0900000002', 'LIC002', 4, '4.20', 80, 88, 'active', '2026-03-11 14:31:58'),
(4, 5, 'Le Van C', '0900000003', 'LIC003', 3, '4.00', 60, 85, 'active', '2026-03-11 14:31:58'),
(5, 6, 'Pham Van D', '0900000004', 'LIC004', 6, '4.70', 200, 95, 'active', '2026-03-11 14:31:58'),
(6, 7, 'Hoang Van E', '0900000005', 'LIC005', 2, '3.90', 40, 80, 'inactive', '2026-03-11 14:31:58'),
(7, 8, 'Do Van F', '0900000006', 'LIC006', 7, '4.80', 250, 96, 'active', '2026-03-11 14:31:58'),
(8, 9, 'Bui Van G', '0900000007', 'LIC007', 5, '4.30', 110, 89, 'active', '2026-03-11 14:31:58'),
(9, 10, 'Dang Van H', '0900000008', 'LIC008', 4, '4.10', 95, 87, 'active', '2026-03-11 14:31:58'),
(10, 3, 'Nguyen Van I', '0900000009', 'LIC009', 6, '4.60', 150, 92, 'active', '2026-03-11 14:31:58');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `lich_su_dang_nhap` (login_history)
--

CREATE TABLE `lich_su_dang_nhap` (
  `id` int(11) NOT NULL,
  `nguoi_dung_id` int(11) DEFAULT NULL,
  `dia_chi_ip` varchar(45) DEFAULT NULL,
  `trinh_duyet` text DEFAULT NULL,
  `trang_thai` enum('success','failed') DEFAULT 'success',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `lich_su_dang_nhap`
--

INSERT INTO `lich_su_dang_nhap` (`id`, `nguoi_dung_id`, `dia_chi_ip`, `trinh_duyet`, `trang_thai`, `ngay_tao`) VALUES
(1, 2, '192.168.1.100', 'Mozilla/5.0 Windows Chrome', 'success', '2026-03-11 02:32:49'),
(2, 2, '192.168.1.100', 'Mozilla/5.0 Windows Chrome', 'success', '2026-03-10 03:32:49'),
(3, 1, '192.168.1.50', 'Mozilla/5.0 MacOS Chrome', 'success', '2026-03-11 01:32:49'),
(4, 2, '192.168.1.100', 'Mozilla/5.0 Windows Chrome', 'failed', '2026-03-08 03:32:49'),
(5, 3, '192.168.1.10', 'Chrome', 'success', '2026-03-11 14:31:59'),
(6, 4, '192.168.1.11', 'Chrome', 'success', '2026-03-11 14:31:59'),
(7, 5, '192.168.1.12', 'Firefox', 'success', '2026-03-11 14:31:59'),
(8, 6, '192.168.1.13', 'Safari', 'failed', '2026-03-11 14:31:59'),
(9, 7, '192.168.1.14', 'Chrome', 'success', '2026-03-11 14:31:59'),
(10, 8, '192.168.1.15', 'Chrome', 'success', '2026-03-11 14:31:59');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thong_bao` (notifications)
--

CREATE TABLE `thong_bao` (
  `id` int(11) NOT NULL,
  `nguoi_dung_id` int(11) DEFAULT NULL,
  `loai` enum('alert','warning','system','success') DEFAULT 'system',
  `tieu_de` varchar(255) DEFAULT NULL,
  `noi_dung` text DEFAULT NULL,
  `da_doc` tinyint(4) DEFAULT 0,
  `doc_luc` timestamp NULL DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `thong_bao`
--

INSERT INTO `thong_bao` (`id`, `nguoi_dung_id`, `loai`, `tieu_de`, `noi_dung`, `da_doc`, `doc_luc`, `ngay_tao`) VALUES
(1, 2, 'alert', 'Cảnh báo an toàn', 'Bạn có 3 vi phạm mới trong hôm nay', 0, NULL, '2026-03-11 02:32:49'),
(2, 2, 'warning', 'Nhắc nhở từ Admin', 'Admin vừa gửi cảnh báo', 0, NULL, '2026-03-11 01:32:49'),
(3, 2, 'success', 'Hoàn thành chuyến xe', 'Chuyến xe T001 hoàn thành. Doanh thu: 2,500,000đ', 1, NULL, '2026-03-10 03:32:49'),
(4, 2, 'system', 'Cập nhật hệ thống', 'Hệ thống đã cập nhật tính năng mới', 1, NULL, '2026-03-09 03:32:49');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tuyen_duong` (routes)
--

CREATE TABLE `tuyen_duong` (
  `id` int(11) NOT NULL,
  `ma_tuyen` varchar(20) DEFAULT NULL,
  `ten_tuyen` varchar(255) DEFAULT NULL,
  `diem_dau` varchar(255) DEFAULT NULL,
  `diem_cuoi` varchar(255) DEFAULT NULL,
  `quang_duong_km` decimal(10,2) DEFAULT NULL,
  `thoi_gian_phut` int(11) DEFAULT NULL,
  `xe_moi_ngay` int(11) DEFAULT NULL,
  `trang_thai` enum('active','inactive') DEFAULT 'active',
  `toa_do_duong_dan` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`toa_do_duong_dan`)),
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tuyen_duong`
--

INSERT INTO `tuyen_duong` (`id`, `ma_tuyen`, `ten_tuyen`, `diem_dau`, `diem_cuoi`, `quang_duong_km`, `thoi_gian_phut`, `xe_moi_ngay`, `trang_thai`, `toa_do_duong_dan`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(1, 'T001', 'Mỹ Đình - Hải Phòng', 'Bến xe Mỹ Đình', 'Bến xe Hải Phòng', '102.00', 120, 12, 'active', NULL, '2026-03-11 03:32:49', '2026-03-11 03:32:49'),
(2, 'T002', 'Nội Bài - Trung tâm', 'Sân bay Nội Bài', 'Hồ Hoàn Kiếm', '28.00', 45, 45, 'active', NULL, '2026-03-11 03:32:49', '2026-03-11 03:32:49'),
(3, 'T003', 'Hồ Tây - Lăng Bác', 'Hồ Tây', 'Lăng Chủ tịch', '8.00', 25, 28, 'active', NULL, '2026-03-11 03:32:49', '2026-03-11 03:32:49'),
(4, 'R004', 'Hanoi-Haiphong', 'Hanoi', 'Haiphong', '120.00', 120, 50, 'active', NULL, '2026-03-11 14:31:58', '2026-03-11 14:31:58'),
(5, 'R005', 'Hanoi-NinhBinh', 'Hanoi', 'Ninh Binh', '90.00', 100, 40, 'active', NULL, '2026-03-11 14:31:58', '2026-03-11 14:31:58'),
(6, 'R006', 'Hanoi-BacNinh', 'Hanoi', 'Bac Ninh', '35.00', 40, 30, 'active', NULL, '2026-03-11 14:31:58', '2026-03-11 14:31:58'),
(7, 'R007', 'Hanoi-HungYen', 'Hanoi', 'Hung Yen', '60.00', 70, 25, 'active', NULL, '2026-03-11 14:31:58', '2026-03-11 14:31:58'),
(8, 'R008', 'Hanoi-ThaiBinh', 'Hanoi', 'Thai Binh', '110.00', 130, 20, 'active', NULL, '2026-03-11 14:31:58', '2026-03-11 14:31:58'),
(9, 'R009', 'Hanoi-NamDinh', 'Hanoi', 'Nam Dinh', '100.00', 120, 20, 'active', NULL, '2026-03-11 14:31:58', '2026-03-11 14:31:58'),
(10, 'R010', 'Hanoi-HaNam', 'Hanoi', 'Ha Nam', '70.00', 80, 15, 'active', NULL, '2026-03-11 14:31:58', '2026-03-11 14:31:58');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thong_ke` (statistics)
--

CREATE TABLE `thong_ke` (
  `id` int(11) NOT NULL,
  `ngay` date DEFAULT NULL,
  `tong_xe` int(11) DEFAULT 0,
  `tong_tai_xe` int(11) DEFAULT 0,
  `tong_chuyen` int(11) DEFAULT 0,
  `tong_canh_bao` int(11) DEFAULT 0,
  `tong_lo_lo` int(11) DEFAULT 0,
  `tong_vi_pham` int(11) DEFAULT 0,
  `tong_doanh_thu` decimal(15,2) DEFAULT 0.00,
  `diem_an_toan_tb` decimal(5,2) DEFAULT 100.00,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `thong_ke`
--

INSERT INTO `thong_ke` (`id`, `ngay`, `tong_xe`, `tong_tai_xe`, `tong_chuyen`, `tong_canh_bao`, `tong_lo_lo`, `tong_vi_pham`, `tong_doanh_thu`, `diem_an_toan_tb`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(1, '2026-03-11', 3, 1, 1, 3, 2, 3, '0.00', '85.00', '2026-03-11 03:32:49', '2026-03-11 03:32:49'),
(2, '2026-03-10', 3, 1, 3, 5, 1, 4, '0.00', '84.50', '2026-03-11 03:32:49', '2026-03-11 03:32:49'),
(3, '2026-03-09', 3, 1, 2, 4, 2, 3, '0.00', '86.00', '2026-03-11 03:32:49', '2026-03-11 03:32:49'),
(4, '2026-03-08', 3, 1, 2, 3, 1, 2, '0.00', '87.00', '2026-03-11 03:32:49', '2026-03-11 03:32:49'),
(5, '2026-03-07', 3, 1, 1, 2, 1, 1, '0.00', '88.00', '2026-03-11 03:32:49', '2026-03-11 03:32:49'),
(6, '2026-03-06', 3, 1, 2, 3, 2, 2, '0.00', '86.50', '2026-03-11 03:32:49', '2026-03-11 03:32:49'),
(7, '2026-03-05', 3, 1, 1, 2, 1, 1, '0.00', '87.50', '2026-03-11 03:32:49', '2026-03-11 03:32:49'),
(8, '2026-03-04', 3, 1, 2, 4, 2, 3, '0.00', '85.00', '2026-03-11 03:32:49', '2026-03-11 03:32:49');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chuyen_xe` (trips)
--

CREATE TABLE `chuyen_xe` (
  `id` int(11) NOT NULL,
  `xe_id` int(11) DEFAULT NULL,
  `tai_xe_id` int(11) DEFAULT NULL,
  `ten_tuyen` varchar(255) DEFAULT NULL,
  `vi_tri_dau` varchar(255) DEFAULT NULL,
  `vi_tri_cuoi` varchar(255) DEFAULT NULL,
  `gio_dau` datetime DEFAULT NULL,
  `gio_cuoi` datetime DEFAULT NULL,
  `quang_duong_km` decimal(10,2) DEFAULT NULL,
  `trang_thai` enum('planned','ongoing','completed','cancelled') DEFAULT 'planned',
  `hanh_khach` int(11) DEFAULT 0,
  `doanh_thu` decimal(12,2) DEFAULT 0.00,
  `danh_gia` int(11) DEFAULT 5,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `chuyen_xe`
--

INSERT INTO `chuyen_xe` (`id`, `xe_id`, `tai_xe_id`, `ten_tuyen`, `vi_tri_dau`, `vi_tri_cuoi`, `gio_dau`, `gio_cuoi`, `quang_duong_km`, `trang_thai`, `hanh_khach`, `doanh_thu`, `danh_gia`, `ngay_tao`) VALUES
(1, 1, 1, 'T001 - Mỹ Đình - Hải Phòng', 'Bến xe Mỹ Đình', 'Bến xe Hải Phòng', '2026-03-11 09:32:49', '2026-03-11 10:32:49', '102.00', 'ongoing', 45, '0.00', 5, '2026-03-11 03:32:49'),
(2, 1, 1, 'T001 - Mỹ Đình - Hải Phòng', 'Bến xe Mỹ Đình', 'Bến xe Hải Phòng', '2026-03-10 10:32:49', '2026-03-10 10:32:49', '102.00', 'completed', 42, '2500000.00', 5, '2026-03-11 03:32:49'),
(3, 2, 1, 'T002 - Nội Bài - Trung tâm', 'Sân bay Nội Bài', 'Hồ Hoàn Kiếm', '2026-03-11 08:32:49', '2026-03-11 09:32:49', '28.00', 'completed', 4, '350000.00', 4, '2026-03-11 03:32:49'),
(4, 3, 1, 'T003 - Hồ Tây - Lăng Bác', 'Hồ Tây', 'Lăng Chủ tịch', '2026-03-11 07:32:49', '2026-03-11 08:32:49', '8.00', 'completed', 2, '150000.00', 5, '2026-03-11 03:32:49'),
(5, 1, 1, 'T001 - Mỹ Đình - Hải Phòng', 'Bến xe Mỹ Đình', 'Bến xe Hải Phòng', '2026-03-09 10:32:49', '2026-03-09 10:32:49', '102.00', 'completed', 38, '2300000.00', 4, '2026-03-11 03:32:49'),
(6, 4, 2, 'Hanoi-Haiphong', 'Hanoi', 'Haiphong', '2026-03-11 21:31:58', '2026-03-11 21:31:58', '120.00', 'completed', 40, '2000000.00', 5, '2026-03-11 14:31:58'),
(7, 5, 3, 'Hanoi-NinhBinh', 'Hanoi', 'Ninh Binh', '2026-03-11 21:31:58', '2026-03-11 21:31:58', '90.00', 'completed', 35, '1500000.00', 4, '2026-03-11 14:31:58'),
(8, 6, 4, 'Hanoi-BacNinh', 'Hanoi', 'Bac Ninh', '2026-03-11 21:31:58', '2026-03-11 21:31:58', '35.00', 'completed', 20, '800000.00', 4, '2026-03-11 14:31:58'),
(9, 7, 5, 'Hanoi-HungYen', 'Hanoi', 'Hung Yen', '2026-03-11 21:31:58', '2026-03-11 21:31:58', '60.00', 'completed', 30, '1200000.00', 4, '2026-03-11 14:31:58'),
(10, 8, 6, 'Hanoi-ThaiBinh', 'Hanoi', 'Thai Binh', '2026-03-11 21:31:58', '2026-03-11 21:31:58', '110.00', 'completed', 25, '1800000.00', 4, '2026-03-11 14:31:58');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nguoi_dung` (users)
--

CREATE TABLE `nguoi_dung` (
  `id` int(11) NOT NULL,
  `ten_dang_nhap` varchar(50) DEFAULT NULL,
  `mat_khau` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `ho_va_ten` varchar(100) DEFAULT NULL,
  `vai_tro` enum('admin','user') DEFAULT 'user',
  `anh_dai_dien` varchar(255) DEFAULT NULL,
  `so_dien_thoai` varchar(20) DEFAULT NULL,
  `hoat_dong` tinyint(4) DEFAULT 1,
  `lan_cuoi_dang_nhap` timestamp NULL DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nguoi_dung`
--

INSERT INTO `nguoi_dung` (`id`, `ten_dang_nhap`, `mat_khau`, `email`, `ho_va_ten`, `vai_tro`, `anh_dai_dien`, `so_dien_thoai`, `hoat_dong`, `lan_cuoi_dang_nhap`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(1, 'admin', '$2b$12$JxzHeL2A6QMUj2p1/Vp2iesAX2aq7pim865BU72PgKtVG/zYl9ZCe', 'admin@traffic.com', 'Quản trị viên hệ thống', 'admin', NULL, NULL, 1, NULL, '2026-03-11 03:32:49', '2026-03-11 03:36:35'),
(2, 'user', '$2b$12$ky/.i5fAGkuXM3gE3lFfSu5CLVNmy2kicBamm1oy7KJh4HHDbxRiW', 'user@traffic.com', 'Nguyễn Văn A', 'user', NULL, NULL, 1, NULL, '2026-03-11 03:32:49', '2026-03-11 03:36:35'),
(3, 'user1', '$2b$12$ky/.i5fAGkuXM3gE3lFfSu5CLVNmy2kicBamm1oy7KJh4HHDbxRiW', 'user1@mail.com', 'Nguyen Van A', 'user', NULL, '0900000001', 1, '2026-03-11 14:31:58', '2026-03-11 14:31:58', '2026-03-11 14:37:47'),
(4, 'user2', '$2b$12$ky/.i5fAGkuXM3gE3lFfSu5CLVNmy2kicBamm1oy7KJh4HHDbxRiW', 'user2@mail.com', 'Tran Van B', 'user', NULL, '0900000002', 1, '2026-03-11 14:31:58', '2026-03-11 14:31:58', '2026-03-11 14:38:46'),
(5, 'user3', '123456', 'user3@mail.com', 'Le Van C', 'user', NULL, '0900000003', 1, '2026-03-11 14:31:58', '2026-03-11 14:31:58', '2026-03-11 14:31:58'),
(6, 'user4', '123456', 'user4@mail.com', 'Pham Van D', 'user', NULL, '0900000004', 1, '2026-03-11 14:31:58', '2026-03-11 14:31:58', '2026-03-11 14:31:58'),
(7, 'user5', '123456', 'user5@mail.com', 'Hoang Van E', 'user', NULL, '0900000005', 1, '2026-03-11 14:31:58', '2026-03-11 14:31:58', '2026-03-11 14:31:58'),
(8, 'user6', '123456', 'user6@mail.com', 'Do Van F', 'user', NULL, '0900000006', 1, '2026-03-11 14:31:58', '2026-03-11 14:31:58', '2026-03-11 14:31:58'),
(9, 'user7', '123456', 'user7@mail.com', 'Bui Van G', 'user', NULL, '0900000007', 1, '2026-03-11 14:31:58', '2026-03-11 14:31:58', '2026-03-11 14:31:58'),
(10, 'user8', '123456', 'user8@mail.com', 'Dang Van H', 'user', NULL, '0900000008', 1, '2026-03-11 14:31:58', '2026-03-11 14:31:58', '2026-03-11 14:31:58');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `phuong_tien` (vehicles)
--

CREATE TABLE `phuong_tien` (
  `id` int(11) NOT NULL,
  `bien_so` varchar(20) DEFAULT NULL,
  `loai_xe` enum('car','bus','truck','taxi','motorbike') DEFAULT NULL,
  `tai_xe_id` int(11) DEFAULT NULL,
  `ten_chu_xe` varchar(100) DEFAULT NULL,
  `so_dien_thoai_chu_xe` varchar(20) DEFAULT NULL,
  `trang_thai` enum('active','maintenance','inactive') DEFAULT 'active',
  `nam_san_xuat` int(11) DEFAULT NULL,
  `so_km_da_chay` decimal(10,2) DEFAULT 0.00,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `phuong_tien`
--

INSERT INTO `phuong_tien` (`id`, `bien_so`, `loai_xe`, `tai_xe_id`, `ten_chu_xe`, `so_dien_thoai_chu_xe`, `trang_thai`, `nam_san_xuat`, `so_km_da_chay`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(1, '29B-222.22', 'bus', 1, 'Công ty Vận tải ABC', '0909123456', 'active', 2022, '45000.00', '2026-03-11 03:32:49', '2026-03-11 03:32:49'),
(2, '30G-666.66', 'taxi', 1, 'Taxi Hà Nội', '0912345678', 'active', 2021, '78000.00', '2026-03-11 03:32:49', '2026-03-11 03:32:49'),
(3, '29A-111.11', 'car', 1, 'Nguyễn Văn A', '0909123456', 'active', 2023, '12000.00', '2026-03-11 03:32:49', '2026-03-11 03:32:49'),
(4, '30A-12345', 'bus', 2, 'Nguyen Van A', '0900000001', 'active', 2020, '120000.00', '2026-03-11 14:31:58', '2026-03-11 14:31:58'),
(5, '30A-12346', 'truck', 3, 'Tran Van B', '0900000002', 'active', 2019, '98000.00', '2026-03-11 14:31:58', '2026-03-11 14:31:58'),
(6, '30A-12347', 'bus', 4, 'Le Van C', '0900000003', 'active', 2021, '54000.00', '2026-03-11 14:31:58', '2026-03-11 14:31:58'),
(7, '30A-12348', 'car', 5, 'Pham Van D', '0900000004', 'active', 2022, '30000.00', '2026-03-11 14:31:58', '2026-03-11 14:31:58'),
(8, '30A-12349', 'bus', 6, 'Hoang Van E', '0900000005', 'inactive', 2018, '150000.00', '2026-03-11 14:31:58', '2026-03-11 14:31:58'),
(9, '30A-12350', 'truck', 7, 'Do Van F', '0900000006', 'active', 2020, '87000.00', '2026-03-11 14:31:58', '2026-03-11 14:31:58'),
(10, '30A-12351', 'car', 8, 'Bui Van G', '0900000007', 'active', 2023, '10000.00', '2026-03-11 14:31:58', '2026-03-11 14:31:58');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `lo_lo` (warnings)
--

CREATE TABLE `lo_lo` (
  `id` int(11) NOT NULL,
  `bien_so_xe` varchar(20) DEFAULT NULL,
  `tai_xe_id` int(11) DEFAULT NULL,
  `noi_dung` text DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `do_uu_tien` enum('low','medium','high') DEFAULT 'medium',
  `da_doc` tinyint(4) DEFAULT 0,
  `doc_luc` timestamp NULL DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `lo_lo`
--

INSERT INTO `lo_lo` (`id`, `bien_so_xe`, `tai_xe_id`, `noi_dung`, `admin_id`, `do_uu_tien`, `da_doc`, `doc_luc`, `ngay_tao`) VALUES
(1, '29B-222.22', 1, 'Tài xế cần cải thiện thái độ lái xe', 1, 'high', 0, NULL, '2026-03-11 02:32:49'),
(2, '29B-222.22', 1, 'Không tuân thủ quy định tốc độ', 1, 'high', 0, NULL, '2026-03-11 01:32:49'),
(3, '30G-666.66', 1, 'Kiểm tra và bảo dưỡng phương tiện', 1, 'medium', 1, NULL, '2026-03-10 03:32:49'),
(4, '29A-111.11', 1, 'Đeo dây an toàn khi lái xe', 1, 'medium', 1, NULL, '2026-03-09 03:32:49'),
(5, '29B-222.22', 1, 'Nghỉ ngơi đầy đủ trước khi lái xe', 1, 'low', 1, NULL, '2026-03-08 03:32:49'),
(6, '30G-666.66', 1, 'Không sử dụng điện thoại khi lái xe', 1, 'high', 1, NULL, '2026-03-07 03:32:49');

-- --------------------------------------------------------

--
-- Cấu trúc cho view `thong_ke_tong_hop` (dashboard_stats)
--
DROP TABLE IF EXISTS `thong_ke_tong_hop`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `thong_ke_tong_hop`  AS SELECT 
  (select count(0) from `phuong_tien` where `phuong_tien`.`trang_thai` = 'active') AS `xe_dang_hoat_dong`, 
  (select count(0) from `tai_xe` where `tai_xe`.`trang_thai` = 'active') AS `tai_xe_dang_hoat_dong`, 
  (select count(0) from `canh_bao` where cast(`canh_bao`.`thoi_gian` as date) = curdate()) AS `canh_bao_hom_nay`, 
  (select count(0) from `lo_lo` where cast(`lo_lo`.`ngay_tao` as date) = curdate()) AS `lo_lo_hom_nay`, 
  (select count(0) from `chuyen_xe` where cast(`chuyen_xe`.`gio_dau` as date) = curdate()) AS `chuyen_xe_hom_nay`, 
  (select avg(`tai_xe`.`diem_an_toan`) from `tai_xe`) AS `diem_an_toan_trung_binh`;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `canh_bao`
--
ALTER TABLE `canh_bao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tai_xe_id` (`tai_xe_id`),
  ADD KEY `idx_xe` (`xe_id`),
  ADD KEY `idx_loai` (`loai`),
  ADD KEY `idx_thoi_gian` (`thoi_gian`),
  ADD KEY `idx_muc_do` (`muc_do`);

--
-- Chỉ mục cho bảng `tai_xe`
--
ALTER TABLE `tai_xe`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nguoi_dung_id` (`nguoi_dung_id`),
  ADD KEY `idx_so_dien_thoai` (`so_dien_thoai`),
  ADD KEY `idx_trang_thai` (`trang_thai`);

--
-- Chỉ mục cho bảng `lich_su_dang_nhap`
--
ALTER TABLE `lich_su_dang_nhap`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_nguoi_dung` (`nguoi_dung_id`),
  ADD KEY `idx_ngay_tao` (`ngay_tao`);

--
-- Chỉ mục cho bảng `thong_bao`
--
ALTER TABLE `thong_bao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_nguoi_dung` (`nguoi_dung_id`),
  ADD KEY `idx_loai` (`loai`),
  ADD KEY `idx_ngay_tao` (`ngay_tao`);

--
-- Chỉ mục cho bảng `tuyen_duong`
--
ALTER TABLE `tuyen_duong`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ma_tuyen` (`ma_tuyen`),
  ADD KEY `idx_ma_tuyen` (`ma_tuyen`),
  ADD KEY `idx_trang_thai` (`trang_thai`);

--
-- Chỉ mục cho bảng `thong_ke`
--
ALTER TABLE `thong_ke`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ngay` (`ngay`),
  ADD KEY `idx_ngay` (`ngay`);

--
-- Chỉ mục cho bảng `chuyen_xe`
--
ALTER TABLE `chuyen_xe`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_xe` (`xe_id`),
  ADD KEY `idx_tai_xe` (`tai_xe_id`),
  ADD KEY `idx_trang_thai` (`trang_thai`),
  ADD KEY `idx_gio_dau` (`gio_dau`);

--
-- Chỉ mục cho bảng `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ten_dang_nhap` (`ten_dang_nhap`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_ten_dang_nhap` (`ten_dang_nhap`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_vai_tro` (`vai_tro`);

--
-- Chỉ mục cho bảng `phuong_tien`
--
ALTER TABLE `phuong_tien`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bien_so` (`bien_so`),
  ADD KEY `tai_xe_id` (`tai_xe_id`),
  ADD KEY `idx_bien_so` (`bien_so`),
  ADD KEY `idx_trang_thai` (`trang_thai`),
  ADD KEY `idx_loai_xe` (`loai_xe`);

--
-- Chỉ mục cho bảng `lo_lo`
--
ALTER TABLE `lo_lo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`),
  ADD KEY `idx_xe` (`bien_so_xe`),
  ADD KEY `idx_tai_xe` (`tai_xe_id`),
  ADD KEY `idx_ngay_tao` (`ngay_tao`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `canh_bao`
--
ALTER TABLE `canh_bao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `tai_xe`
--
ALTER TABLE `tai_xe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `lich_su_dang_nhap`
--
ALTER TABLE `lich_su_dang_nhap`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `thong_bao`
--
ALTER TABLE `thong_bao`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `tuyen_duong`
--
ALTER TABLE `tuyen_duong`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `thong_ke`
--
ALTER TABLE `thong_ke`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `chuyen_xe`
--
ALTER TABLE `chuyen_xe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `phuong_tien`
--
ALTER TABLE `phuong_tien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `lo_lo`
--
ALTER TABLE `lo_lo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `canh_bao`
--
ALTER TABLE `canh_bao`
  ADD CONSTRAINT `canh_bao_ibfk_1` FOREIGN KEY (`xe_id`) REFERENCES `phuong_tien` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `canh_bao_ibfk_2` FOREIGN KEY (`tai_xe_id`) REFERENCES `tai_xe` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `tai_xe`
--
ALTER TABLE `tai_xe`
  ADD CONSTRAINT `tai_xe_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `lich_su_dang_nhap`
--
ALTER TABLE `lich_su_dang_nhap`
  ADD CONSTRAINT `lich_su_dang_nhap_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `thong_bao`
--
ALTER TABLE `thong_bao`
  ADD CONSTRAINT `thong_bao_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `chuyen_xe`
--
ALTER TABLE `chuyen_xe`
  ADD CONSTRAINT `chuyen_xe_ibfk_1` FOREIGN KEY (`xe_id`) REFERENCES `phuong_tien` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chuyen_xe_ibfk_2` FOREIGN KEY (`tai_xe_id`) REFERENCES `tai_xe` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `phuong_tien`
--
ALTER TABLE `phuong_tien`
  ADD CONSTRAINT `phuong_tien_ibfk_1` FOREIGN KEY (`tai_xe_id`) REFERENCES `tai_xe` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `lo_lo`
--
ALTER TABLE `lo_lo`
  ADD CONSTRAINT `lo_lo_ibfk_1` FOREIGN KEY (`tai_xe_id`) REFERENCES `tai_xe` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `lo_lo_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
