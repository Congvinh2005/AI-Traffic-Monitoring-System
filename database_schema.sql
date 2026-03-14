-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th3 14, 2026 lúc 10:09 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `giam_sat`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `camera_giam_sat`
--

CREATE TABLE `camera_giam_sat` (
  `id` int(11) NOT NULL,
  `ten_camera` varchar(100) NOT NULL,
  `vi_tri_lap_dat` varchar(100) DEFAULT NULL,
  `id_tuyen_duong` varchar(50) DEFAULT NULL,
  `url_luong_video` varchar(255) NOT NULL,
  `trang_thai_hoat_dong` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `camera_giam_sat`
--

INSERT INTO `camera_giam_sat` (`id`, `ten_camera`, `vi_tri_lap_dat`, `id_tuyen_duong`, `url_luong_video`, `trang_thai_hoat_dong`) VALUES
(1, 'Camera Lái xe', 'Cabin tài xế', NULL, '/video_driver', 1),
(2, 'Camera Hành trình', 'Mặt trước xe', NULL, '/video_vacham', 1),
(3, 'Camera Giao thông (Biển báo)', 'Đầu xe', NULL, '/video_traffic', 1),
(4, 'Camera Khu vực Hà Nội', 'Trạm cố định', NULL, '/video_sign?location=hanoi', 1),
(5, 'Camera Khu vực Thanh Xuân', 'Trạm cố định', NULL, '/video_sign?location=thanhxuan', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `canh_bao_vi_pham`
--

CREATE TABLE `canh_bao_vi_pham` (
  `id` int(11) NOT NULL,
  `loai_vi_pham` varchar(50) NOT NULL,
  `noi_dung_vi_pham` varchar(255) NOT NULL,
  `muc_do` varchar(20) NOT NULL,
  `thoi_gian_vi_pham` datetime NOT NULL,
  `id_phuong_tien` int(11) DEFAULT NULL,
  `id_tai_xe` int(11) DEFAULT NULL,
  `id_video_ghi_hinh` int(11) DEFAULT NULL,
  `da_doc` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `canh_bao_vi_pham`
--

INSERT INTO `canh_bao_vi_pham` (`id`, `loai_vi_pham`, `noi_dung_vi_pham`, `muc_do`, `thoi_gian_vi_pham`, `id_phuong_tien`, `id_tai_xe`, `id_video_ghi_hinh`, `da_doc`) VALUES
(1, 'eye', 'Tài xế nhắm mắt quá lâu', 'critical', '2026-03-12 10:15:00', 1, 1, 1, 0),
(2, 'phone', 'Phát hiện dùng điện thoại', 'critical', '2026-03-12 11:20:30', 2, 2, 3, 1),
(3, 'yawn', 'Tài xế đang ngáp ngủ', 'warning', '2026-03-12 12:05:15', 3, 3, NULL, 0),
(4, 'seatbelt', 'Không đeo dây an toàn', 'critical', '2026-03-12 14:10:00', 4, 4, NULL, 1),
(5, 'collision', 'Cảnh báo va chạm phía trước', 'critical', '2026-03-12 16:46:00', 6, 6, 2, 0),
(6, 'seatbelt', 'Tài xế không đeo dây an toàn!', 'critical', '2026-03-13 13:26:07', NULL, NULL, NULL, 0),
(7, 'hand', 'CẢNH BÁO: KHÔNG CẦM VÔ LĂNG!', 'warning', '2026-03-13 13:26:11', NULL, NULL, NULL, 0),
(8, 'eye', 'Tài xế đang nhắm mắt quá lâu!', 'critical', '2026-03-13 13:26:16', NULL, NULL, NULL, 0),
(9, 'yawn', 'Tài xế đang ngáp ngủ!', 'warning', '2026-03-13 13:29:27', NULL, NULL, NULL, 0),
(33, 'eye', 'Tài xế đang nhắm mắt quá lâu!', 'critical', '2026-03-14 15:57:00', 3, 3, NULL, 0),
(34, 'eye', 'Tài xế đang nhắm mắt quá lâu!', 'critical', '2026-03-14 15:57:06', 3, 3, NULL, 0),
(42, 'eye', 'Tài xế đang nhắm mắt quá lâu!', 'critical', '2026-03-14 16:04:40', 3, 3, NULL, 0),
(43, 'phone', 'Tài xế đang dùng điện thoại!', 'critical', '2026-03-14 16:05:13', NULL, NULL, NULL, 0),
(44, 'phone', 'Tài xế đang dùng điện thoại!', 'critical', '2026-03-14 16:05:14', NULL, NULL, NULL, 0),
(45, 'phone', 'Tài xế đang dùng điện thoại!', 'critical', '2026-03-14 16:05:14', NULL, NULL, NULL, 0),
(46, 'seatbelt', 'Tài xế không đeo dây an toàn!', 'critical', '2026-03-14 16:08:48', NULL, NULL, NULL, 0),
(47, 'head', 'Tài xế mất tập trung (quay đầu/ngửa đầu)!', 'warning', '2026-03-14 16:08:51', NULL, NULL, NULL, 0),
(48, 'head', 'Tài xế mất tập trung (quay đầu/ngửa đầu)!', 'warning', '2026-03-14 16:08:51', NULL, NULL, NULL, 0),
(49, 'head', 'Tài xế mất tập trung (quay đầu/ngửa đầu)!', 'warning', '2026-03-14 16:08:51', NULL, NULL, NULL, 0),
(50, 'head', 'Tài xế mất tập trung (quay đầu/ngửa đầu)!', 'warning', '2026-03-14 16:08:53', NULL, NULL, NULL, 0),
(51, 'head', 'Tài xế mất tập trung (quay đầu/ngửa đầu)!', 'warning', '2026-03-14 16:08:55', NULL, NULL, NULL, 0),
(52, 'head', 'Tài xế mất tập trung (quay đầu/ngửa đầu)!', 'warning', '2026-03-14 16:08:57', NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nguoi_dung`
--

CREATE TABLE `nguoi_dung` (
  `id` int(11) NOT NULL,
  `ten_dang_nhap` varchar(50) NOT NULL,
  `mat_khau` varchar(255) NOT NULL,
  `vai_tro` enum('admin','user') NOT NULL DEFAULT 'user',
  `ho_ten` varchar(100) NOT NULL,
  `trang_thai_hoat_dong` tinyint(1) DEFAULT 1,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nguoi_dung`
--

INSERT INTO `nguoi_dung` (`id`, `ten_dang_nhap`, `mat_khau`, `vai_tro`, `ho_ten`, `trang_thai_hoat_dong`, `ngay_tao`) VALUES
(1, 'admin', '$2b$12$yWE4PiFx/Ng8DEyRqL56oelwuyeq7ScmFW84R3iaWmwkU1XQGeMKW', 'admin', 'Quản Trị Viên Hệ Thống', 1, '2026-03-12 16:00:56'),
(2, 'user', '$2b$12$ncty58BcReEjHCazNB38BuDmhc.MTIrTzheTvzAWd8/IGTS2YxqKa', 'user', 'Điều Hành Viên', 1, '2026-03-12 16:00:56'),
(3, 'driver1', '$2b$12$ncty58BcReEjHCazNB38BuDmhc.MTIrTzheTvzAWd8/IGTS2YxqKa', 'user', 'Tài xế Đức', 1, '2026-03-14 15:15:00'),
(4, 'driver2', '$2b$12$ncty58BcReEjHCazNB38BuDmhc.MTIrTzheTvzAWd8/IGTS2YxqKa', 'user', 'Tài xế Hoan', 1, '2026-03-14 15:15:00'),
(5, 'driver3', '$2b$12$ncty58BcReEjHCazNB38BuDmhc.MTIrTzheTvzAWd8/IGTS2YxqKa', 'user', 'Tài xế Đào', 1, '2026-03-14 15:15:00'),
(6, 'driver4', '$2b$12$ncty58BcReEjHCazNB38BuDmhc.MTIrTzheTvzAWd8/IGTS2YxqKa', 'user', 'Tài xế Dũng', 1, '2026-03-14 15:15:00'),
(7, 'driver5', '$2b$12$ncty58BcReEjHCazNB38BuDmhc.MTIrTzheTvzAWd8/IGTS2YxqKa', 'user', 'Tài xế Việt', 1, '2026-03-14 15:15:00'),
(8, 'driver6', '$2b$12$ncty58BcReEjHCazNB38BuDmhc.MTIrTzheTvzAWd8/IGTS2YxqKa', 'user', 'Tài xế Hồng', 1, '2026-03-14 15:15:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `phuong_tien`
--

CREATE TABLE `phuong_tien` (
  `id` int(11) NOT NULL,
  `bien_so` varchar(20) NOT NULL,
  `loai_xe` varchar(50) DEFAULT 'car',
  `hinh_anh_xe` varchar(255) DEFAULT NULL,
  `id_tai_xe` int(11) DEFAULT NULL,
  `id_tuyen_duong` varchar(50) DEFAULT NULL,
  `trang_thai_hoat_dong` varchar(50) DEFAULT 'Đang dừng',
  `toc_do_hien_tai` int(11) DEFAULT 0,
  `lat` double DEFAULT 21.0285,
  `lng` double DEFAULT 105.8542
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `phuong_tien`
--

INSERT INTO `phuong_tien` (`id`, `bien_so`, `loai_xe`, `hinh_anh_xe`, `id_tai_xe`, `id_tuyen_duong`, `trang_thai_hoat_dong`, `toc_do_hien_tai`, `lat`, `lng`) VALUES
(1, '29A-111.11', 'car', 'car1.jpg', 1, 'T001', 'Đang chạy', 45, 21.045, 105.81),
(2, '29B-222.22', 'bus', 'bus1.jpg', 2, 'T002', 'Đang dừng', 0, 21.03, 105.78),
(3, '30E-333.33', 'car', 'car2.jpg', 3, 'T003', 'Đang chạy', 30, 21.04, 105.835),
(4, '29H-444.44', 'truck', 'truck1.jpg', 4, 'T004', 'Đang chạy', 50, 21.025, 105.86),
(5, '15B-555.55', 'bus', 'bus2.jpg', 5, 'T005', 'Đang chạy', 40, 21.035, 105.82),
(6, '30G-666.66', 'car', 'car3.jpg', 6, 'T003', 'Đang chạy', 40, 21.015, 105.83),
(7, '29LD-777.77', 'bus', 'bus3.jpg', 7, 'T002', 'Đang chạy', 60, 21.0285, 105.8542);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tai_xe`
--

CREATE TABLE `tai_xe` (
  `id` int(11) NOT NULL,
  `ma_tai_xe` varchar(20) DEFAULT NULL,
  `ho_ten` varchar(100) NOT NULL,
  `so_dien_thoai` varchar(20) DEFAULT NULL,
  `so_giay_phep_lai_xe` varchar(50) DEFAULT NULL,
  `anh_dai_dien` varchar(255) DEFAULT NULL,
  `diem_danh_gia` int(11) DEFAULT 100,
  `id_nguoi_dung` int(11) DEFAULT NULL,
  `trang_thai_hoat_dong` tinyint(1) DEFAULT 1,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tai_xe`
--

INSERT INTO `tai_xe` (`id`, `ma_tai_xe`, `ho_ten`, `so_dien_thoai`, `so_giay_phep_lai_xe`, `anh_dai_dien`, `diem_danh_gia`, `id_nguoi_dung`, `trang_thai_hoat_dong`, `ngay_tao`) VALUES
(1, 'TX01', 'Nguyễn Văn Đức', '0912111111', 'GPLX-001', 'vinh.png', 98, 3, 1, '2026-03-12 16:00:56'),
(2, 'TX02', 'Trần Văn Hoan', '0912222222', 'GPLX-002', 'dan2.jpg', 85, 4, 1, '2026-03-12 16:00:56'),
(3, 'TX03', 'Lê Thị Đào', '0912333333', 'GPLX-003', 'dan.jpg', 95, 5, 1, '2026-03-12 16:00:56'),
(4, 'TX04', 'Phạm Văn Dũng', '0912444444', 'GPLX-004', 'xuan.png', 90, 6, 1, '2026-03-12 16:00:56'),
(5, 'TX05', 'Hoàng Văn Việt', '0912555555', 'GPLX-005', 'qanh.png', 75, 7, 1, '2026-03-12 16:00:56'),
(6, 'TX06', 'Vũ Thị Hồng', '0912666666', 'GPLX-006', 'thanh.png', 100, 8, 1, '2026-03-12 16:00:56'),
(7, 'TX07', 'Công ty Travel', '19001111', 'BUSINESS-001', 'xuan2.jpg', 100, 2, 1, '2026-03-12 16:00:56');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thong_bao_admin`
--

CREATE TABLE `thong_bao_admin` (
  `id` int(11) NOT NULL,
  `id_admin` int(11) NOT NULL,
  `bien_so_xe` varchar(20) NOT NULL,
  `noi_dung_thong_bao` text NOT NULL,
  `muc_do_uu_tien` enum('low','medium','high') DEFAULT 'low',
  `da_doc` tinyint(1) DEFAULT 0,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_doc` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `thong_bao_admin`
--

INSERT INTO `thong_bao_admin` (`id`, `id_admin`, `bien_so_xe`, `noi_dung_thong_bao`, `muc_do_uu_tien`, `da_doc`, `ngay_tao`, `ngay_doc`) VALUES
(1, 1, '29A-111.11', 'Đề nghị tài xế Đức dừng xe ở trạm nghỉ tiếp theo, phát hiện mệt mỏi.', 'high', 0, '2026-03-12 03:20:00', NULL),
(2, 1, '29B-222.22', 'Cảnh cáo: Không được sử dụng điện thoại lúc đang lái xe.', 'high', 1, '2026-03-12 04:25:00', NULL),
(3, 1, '15B-555.55', 'Lưu ý giữ khoảng cách an toàn với xe phía trước.', 'medium', 0, '2026-03-12 08:00:00', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tuyen_duong`
--

CREATE TABLE `tuyen_duong` (
  `id` varchar(50) NOT NULL,
  `ten_tuyen` varchar(100) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `start_lat` decimal(10,8) DEFAULT NULL,
  `start_lng` decimal(11,8) DEFAULT NULL,
  `end_lat` decimal(10,8) DEFAULT NULL,
  `end_lng` decimal(11,8) DEFAULT NULL,
  `toa_do_lat` decimal(10,8) DEFAULT NULL,
  `toa_do_lng` decimal(11,8) DEFAULT NULL,
  `distance` decimal(10,2) DEFAULT 0.00 COMMENT 'Khoảng cách (km)',
  `duration` int(11) DEFAULT 0 COMMENT 'Thời gian (phút)',
  `vehicles` varchar(50) DEFAULT NULL COMMENT 'Số lượng xe',
  `route_color` varchar(20) DEFAULT '#4a9eff' COMMENT 'Màu sắc tuyến đường',
  `trang_thai` enum('active','waiting','offline') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tuyen_duong`
--

INSERT INTO `tuyen_duong` (`id`, `ten_tuyen`, `mo_ta`, `start_lat`, `start_lng`, `end_lat`, `end_lng`, `toa_do_lat`, `toa_do_lng`, `distance`, `duration`, `vehicles`, `route_color`, `trang_thai`) VALUES
('T001', 'Mỹ Đình - Hải Phòng', 'Tuyến đường từ bến xe Mỹ Đình đến bến xe Hải Phòng', 21.03000000, 105.78000000, 20.95000000, 106.10000000, NULL, NULL, 102.00, 120, '12 xe/ngày', '#4a9eff', 'active'),
('T002', 'Nội Bài - Trung tâm Hà Nội', 'Tuyến đường từ sân bay Nội Bài vào trung tâm Hà Nội', 21.22000000, 105.80000000, 21.02850000, 105.85420000, NULL, NULL, 28.00, 45, '45 xe/ngày', '#00c853', 'active'),
('T003', 'Hồ Tây - Lăng Bác', 'Tuyến đường du lịch từ Hồ Tây đến Lăng Bác', 21.04500000, 105.81500000, 21.03500000, 105.83500000, NULL, NULL, 8.00, 25, '28 xe/ngày', '#ffc107', 'active'),
('T004', 'Cầu Giấy - Long Biên', 'Tuyến đường nối quận Cầu Giấy và Long Biên', 21.03500000, 105.79000000, 21.02000000, 105.85000000, NULL, NULL, 15.00, 40, '20 xe/ngày', '#ff5252', 'active'),
('T005', 'Hà Đông  - Hoàn Kiếm', 'Tuyến đường từ Hà Đông vào hồ Hoàn Kiếm', 20.98000000, 105.78000000, 21.02850000, 105.85420000, NULL, NULL, 12.00, 35, '35 xe/ngày', '#9c27b0', 'active');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tuyen_duong_path`
--

CREATE TABLE `tuyen_duong_path` (
  `id` int(11) NOT NULL,
  `id_tuyen_duong` varchar(50) NOT NULL,
  `point_order` int(11) NOT NULL COMMENT 'Thứ tự điểm trong tuyến',
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tuyen_duong_path`
--

INSERT INTO `tuyen_duong_path` (`id`, `id_tuyen_duong`, `point_order`, `latitude`, `longitude`, `created_at`) VALUES
(1, 'T001', 1, 21.03000000, 105.78000000, '2026-03-14 03:11:19'),
(2, 'T001', 2, 21.02500000, 105.82000000, '2026-03-14 03:11:19'),
(3, 'T001', 3, 21.02000000, 105.86000000, '2026-03-14 03:11:19'),
(4, 'T001', 4, 20.95000000, 106.10000000, '2026-03-14 03:11:19'),
(5, 'T002', 1, 21.22000000, 105.80000000, '2026-03-14 03:11:19'),
(6, 'T002', 2, 21.15000000, 105.82000000, '2026-03-14 03:11:19'),
(7, 'T002', 3, 21.08000000, 105.84000000, '2026-03-14 03:11:19'),
(8, 'T002', 4, 21.02850000, 105.85420000, '2026-03-14 03:11:19'),
(9, 'T003', 1, 21.04500000, 105.81500000, '2026-03-14 03:11:19'),
(10, 'T003', 2, 21.04000000, 105.82500000, '2026-03-14 03:11:19'),
(11, 'T003', 3, 21.03500000, 105.83500000, '2026-03-14 03:11:19'),
(12, 'T004', 1, 21.03500000, 105.79000000, '2026-03-14 03:11:19'),
(13, 'T004', 2, 21.03000000, 105.81000000, '2026-03-14 03:11:19'),
(14, 'T004', 3, 21.02500000, 105.83000000, '2026-03-14 03:11:19'),
(15, 'T004', 4, 21.02000000, 105.85000000, '2026-03-14 03:11:19'),
(16, 'T005', 1, 20.98000000, 105.78000000, '2026-03-14 03:11:19'),
(17, 'T005', 2, 21.00000000, 105.80000000, '2026-03-14 03:11:19'),
(18, 'T005', 3, 21.01500000, 105.82000000, '2026-03-14 03:11:19'),
(19, 'T005', 4, 21.02850000, 105.85420000, '2026-03-14 03:11:19');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `video_ghi_hinh`
--

CREATE TABLE `video_ghi_hinh` (
  `id` int(11) NOT NULL,
  `id_camera` int(11) DEFAULT NULL,
  `ten_file_video` varchar(100) NOT NULL,
  `duong_dan_file` varchar(255) NOT NULL,
  `thoi_gian_bat_dau` datetime NOT NULL,
  `thoi_gian_ket_thuc` datetime DEFAULT NULL,
  `kich_thuoc_file` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `video_ghi_hinh`
--

INSERT INTO `video_ghi_hinh` (`id`, `id_camera`, `ten_file_video`, `duong_dan_file`, `thoi_gian_bat_dau`, `thoi_gian_ket_thuc`, `kich_thuoc_file`) VALUES
(1, 1, 'output_20260312_101500.mp4', 'recordings/output_20260312_101500.mp4', '2026-03-12 10:15:00', '2026-03-12 10:17:00', 15400030),
(2, 2, 'output_20260312_164500.mp4', 'recordings/output_20260312_164500.mp4', '2026-03-12 16:45:00', '2026-03-12 16:48:30', 25611090),
(3, 1, 'output_20260312_112030.mp4', 'recordings/output_20260312_112030.mp4', '2026-03-12 11:20:30', '2026-03-12 11:21:00', 5800045);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `camera_giam_sat`
--
ALTER TABLE `camera_giam_sat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tuyen_duong` (`id_tuyen_duong`);

--
-- Chỉ mục cho bảng `canh_bao_vi_pham`
--
ALTER TABLE `canh_bao_vi_pham`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_phuong_tien` (`id_phuong_tien`),
  ADD KEY `id_tai_xe` (`id_tai_xe`),
  ADD KEY `id_video_ghi_hinh` (`id_video_ghi_hinh`);

--
-- Chỉ mục cho bảng `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ten_dang_nhap` (`ten_dang_nhap`);

--
-- Chỉ mục cho bảng `phuong_tien`
--
ALTER TABLE `phuong_tien`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bien_so` (`bien_so`),
  ADD KEY `id_tai_xe` (`id_tai_xe`),
  ADD KEY `id_tuyen_duong` (`id_tuyen_duong`);

--
-- Chỉ mục cho bảng `tai_xe`
--
ALTER TABLE `tai_xe`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ma_tai_xe` (`ma_tai_xe`),
  ADD KEY `tai_xe_ibfk_1` (`id_nguoi_dung`);

--
-- Chỉ mục cho bảng `thong_bao_admin`
--
ALTER TABLE `thong_bao_admin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_admin` (`id_admin`);

--
-- Chỉ mục cho bảng `tuyen_duong`
--
ALTER TABLE `tuyen_duong`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tuyen_duong_path`
--
ALTER TABLE `tuyen_duong_path`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_tuyen_duong` (`id_tuyen_duong`),
  ADD KEY `idx_point_order` (`id_tuyen_duong`,`point_order`);

--
-- Chỉ mục cho bảng `video_ghi_hinh`
--
ALTER TABLE `video_ghi_hinh`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_camera` (`id_camera`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `camera_giam_sat`
--
ALTER TABLE `camera_giam_sat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `canh_bao_vi_pham`
--
ALTER TABLE `canh_bao_vi_pham`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT cho bảng `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `phuong_tien`
--
ALTER TABLE `phuong_tien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `tai_xe`
--
ALTER TABLE `tai_xe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `thong_bao_admin`
--
ALTER TABLE `thong_bao_admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `tuyen_duong_path`
--
ALTER TABLE `tuyen_duong_path`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT cho bảng `video_ghi_hinh`
--
ALTER TABLE `video_ghi_hinh`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `camera_giam_sat`
--
ALTER TABLE `camera_giam_sat`
  ADD CONSTRAINT `camera_giam_sat_ibfk_1` FOREIGN KEY (`id_tuyen_duong`) REFERENCES `tuyen_duong` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `canh_bao_vi_pham`
--
ALTER TABLE `canh_bao_vi_pham`
  ADD CONSTRAINT `canh_bao_vi_pham_ibfk_1` FOREIGN KEY (`id_phuong_tien`) REFERENCES `phuong_tien` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `canh_bao_vi_pham_ibfk_2` FOREIGN KEY (`id_tai_xe`) REFERENCES `tai_xe` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `canh_bao_vi_pham_ibfk_3` FOREIGN KEY (`id_video_ghi_hinh`) REFERENCES `video_ghi_hinh` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `phuong_tien`
--
ALTER TABLE `phuong_tien`
  ADD CONSTRAINT `phuong_tien_ibfk_1` FOREIGN KEY (`id_tai_xe`) REFERENCES `tai_xe` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `phuong_tien_ibfk_2` FOREIGN KEY (`id_tuyen_duong`) REFERENCES `tuyen_duong` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `tai_xe`
--
ALTER TABLE `tai_xe`
  ADD CONSTRAINT `tai_xe_ibfk_1` FOREIGN KEY (`id_nguoi_dung`) REFERENCES `nguoi_dung` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `thong_bao_admin`
--
ALTER TABLE `thong_bao_admin`
  ADD CONSTRAINT `thong_bao_admin_ibfk_1` FOREIGN KEY (`id_admin`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `tuyen_duong_path`
--
ALTER TABLE `tuyen_duong_path`
  ADD CONSTRAINT `tuyen_duong_path_ibfk_1` FOREIGN KEY (`id_tuyen_duong`) REFERENCES `tuyen_duong` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `video_ghi_hinh`
--
ALTER TABLE `video_ghi_hinh`
  ADD CONSTRAINT `video_ghi_hinh_ibfk_1` FOREIGN KEY (`id_camera`) REFERENCES `camera_giam_sat` (`id`) ON DELETE SET NULL;

-- --------------------------------------------------------
--
-- Cấu trúc bảng `camera_xe` - Camera gắn trên từng phương tiện
--
CREATE TABLE IF NOT EXISTS `camera_xe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_phuong_tien` int(11) NOT NULL,
  `ten_camera` varchar(100) NOT NULL,
  `vi_tri` enum('tai_xe','truoc','hanh_khach','lui') NOT NULL,
  `video_file` varchar(255) NOT NULL COMMENT 'Tên file video trong thư mục video_input',
  `trang_thai` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `id_phuong_tien` (`id_phuong_tien`),
  CONSTRAINT `camera_xe_ibfk_1` FOREIGN KEY (`id_phuong_tien`) REFERENCES `phuong_tien` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dữ liệu cho bảng `camera_xe`
-- Xe 1: 29A-111.11
INSERT INTO `camera_xe` (`id_phuong_tien`, `ten_camera`, `vi_tri`, `video_file`) VALUES
(1, 'Camera Tài Xế',    'tai_xe',        'truoc1.mp4'),
(1, 'Camera Trước',     'truoc',         'truoc2.mp4'),
(1, 'Camera Hành Khách','hanh_khach',    'trongxe1.mp4'),
(1, 'Camera Lùi',       'lui',           'sau1.mp4'),
-- Xe 2: 29B-222.22
(2, 'Camera Tài Xế',    'tai_xe',        'truoc2.mp4'),
(2, 'Camera Trước',     'truoc',         'truoc3.mp4'),
(2, 'Camera Hành Khách','hanh_khach',    'trongxe2.mp4'),
(2, 'Camera Lùi',       'lui',           'sau2.mp4'),
-- Xe 3: 30E-333.33
(3, 'Camera Tài Xế',    'tai_xe',        'truoc3.mp4'),
(3, 'Camera Trước',     'truoc',         'truoc4.mp4'),
(3, 'Camera Hành Khách','hanh_khach',    'trongxe3.mp4'),
(3, 'Camera Lùi',       'lui',           'sau2.mp4'),
-- Xe 4: 29H-444.44
(4, 'Camera Tài Xế',    'tai_xe',        'truoc4.mp4'),
(4, 'Camera Trước',     'truoc',         'truoc1.mp4'),
(4, 'Camera Hành Khách','hanh_khach',    'trongxe4.mp4'),
(4, 'Camera Lùi',       'lui',           'sau1.mp4'),
-- Xe 5: 15B-555.55
(5, 'Camera Tài Xế',    'tai_xe',        'truoc3.mp4'),
(5, 'Camera Trước',     'truoc',         'truoc2.mp4'),
(5, 'Camera Hành Khách','hanh_khach',    'trongxe5.mp4'),
(5, 'Camera Lùi',       'lui',           'sau2.mp4'),
-- Xe 6: 30G-666.66
(6, 'Camera Tài Xế',    'tai_xe',        'truoc2.mp4'),
(6, 'Camera Trước',     'truoc',         'truoc3.mp4'),
(6, 'Camera Hành Khách','hanh_khach',    'trongxe1.mp4'),
(6, 'Camera Lùi',       'lui',           'sau1.mp4'),
-- Xe 7: 29LD-777.77
(7, 'Camera Tài Xế',    'tai_xe',        'truoc1.mp4'),
(7, 'Camera Trước',     'truoc',         'truoc4.mp4'),
(7, 'Camera Hành Khách','hanh_khach',    'trongxe3.mp4'),
(7, 'Camera Lùi',       'lui',           'sau2.mp4');

COMMIT;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
