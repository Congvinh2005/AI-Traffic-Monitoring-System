-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th3 13, 2026 lúc 02:51 AM
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
(1, 'Camera Lái xe', 'Cabin tài xế', 'hanoi', '/video_driver', 1),
(2, 'Camera Hành trình', 'Mặt trước xe', 'hanoi', '/video_vacham', 1),
(3, 'Camera Giao thông (Biển báo)', 'Đầu xe', 'hanoi', '/video_traffic', 1),
(4, 'Camera Khu vực Hà Nội', 'Trạm cố định', 'hanoi', '/video_sign?location=hanoi', 1),
(5, 'Camera Khu vực Thanh Xuân', 'Trạm cố định', 'thanhxuan', '/video_sign?location=thanhxuan', 1);

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
(5, 'collision', 'Cảnh báo va chạm phía trước', 'critical', '2026-03-12 16:46:00', 6, 6, 2, 0);

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
(2, 'user', '$2b$12$ncty58BcReEjHCazNB38BuDmhc.MTIrTzheTvzAWd8/IGTS2YxqKa', 'user', 'Điều Hành Viên', 1, '2026-03-12 16:00:56');

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
  `toc_do_hien_tai` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `phuong_tien`
--

INSERT INTO `phuong_tien` (`id`, `bien_so`, `loai_xe`, `hinh_anh_xe`, `id_tai_xe`, `id_tuyen_duong`, `trang_thai_hoat_dong`, `toc_do_hien_tai`) VALUES
(1, '29A-111.11', 'car', 'car-avatar-1.jpg', 1, 'hanoi', 'Đang chạy', 45),
(2, '29B-222.22', 'bus', 'bus-avatar.jpg', 2, 'hadong', 'Đang dừng', 0),
(3, '30E-333.33', 'car', 'car-avatar-2.jpg', 3, 'thanhxuan', 'Đang chạy', 30),
(4, '29H-444.44', 'truck', 'truck-avatar.jpg', 4, 'ngatuso', 'Đang chạy', 50),
(5, '15B-555.55', 'bus', 'bus-avatar-2.jpg', 5, 'hanoi', 'Đang chạy', 40),
(6, '30G-666.66', 'car', 'car-avatar-3.jpg', 6, 'hadong', 'Đang chạy', 40),
(7, '29LD-777.77', 'bus', 'travel-bus.jpg', 7, 'thanhxuan', 'Đang chạy', 60);

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
  `trang_thai_hoat_dong` tinyint(1) DEFAULT 1,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tai_xe`
--

INSERT INTO `tai_xe` (`id`, `ma_tai_xe`, `ho_ten`, `so_dien_thoai`, `so_giay_phep_lai_xe`, `anh_dai_dien`, `diem_danh_gia`, `trang_thai_hoat_dong`, `ngay_tao`) VALUES
(1, 'TX01', 'Nguyễn Văn Đức', '0912111111', 'GPLX-001', 'driver-1.jpg', 98, 1, '2026-03-12 16:00:56'),
(2, 'TX02', 'Trần Văn Hoan', '0912222222', 'GPLX-002', 'driver-2.jpg', 85, 1, '2026-03-12 16:00:56'),
(3, 'TX03', 'Lê Thị Đào', '0912333333', 'GPLX-003', 'driver-3.jpg', 95, 1, '2026-03-12 16:00:56'),
(4, 'TX04', 'Phạm Văn Dũng', '0912444444', 'GPLX-004', 'driver-4.jpg', 90, 1, '2026-03-12 16:00:56'),
(5, 'TX05', 'Hoàng Văn Việt', '0912555555', 'GPLX-005', 'driver-5.jpg', 75, 1, '2026-03-12 16:00:56'),
(6, 'TX06', 'Vũ Thị Hồng', '0912666666', 'GPLX-006', 'driver-6.jpg', 100, 1, '2026-03-12 16:00:56'),
(7, 'TX07', 'Công ty Travel', '19001111', 'BUSINESS-001', 'driver-7.jpg', 100, 1, '2026-03-12 16:00:56');

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
  `trang_thai` enum('active','waiting','offline') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `tuyen_duong`
--

INSERT INTO `tuyen_duong` (`id`, `ten_tuyen`, `mo_ta`, `toa_do_lat`, `toa_do_lng`, `trang_thai`) VALUES
('hadong', 'Khu vực Hà Đông', 'Tuyến đường quanh bến xe Yên Nghĩa', 20.97190000, 105.77660000, 'active'),
('hanoi', 'Tuyến Võ Chí Công - Hà Nội', 'Tuyến đường huyết mạch nối thẳng vào Trung tâm', 21.05060000, 105.80490000, 'active'),
('ngatuso', 'Vòng xuyến Ngã Tư Sở', 'Điểm giao cắt trọng yếu, thường xuyên theo dõi', 21.00390000, 105.81930000, 'waiting'),
('thanhxuan', 'Đường Nguyễn Trãi - Thanh Xuân', 'Tuyến đường có mật độ giao thông cao', 20.99340000, 105.80780000, 'active');

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
  ADD UNIQUE KEY `ma_tai_xe` (`ma_tai_xe`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
-- Các ràng buộc cho bảng `thong_bao_admin`
--
ALTER TABLE `thong_bao_admin`
  ADD CONSTRAINT `thong_bao_admin_ibfk_1` FOREIGN KEY (`id_admin`) REFERENCES `nguoi_dung` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `video_ghi_hinh`
--
ALTER TABLE `video_ghi_hinh`
  ADD CONSTRAINT `video_ghi_hinh_ibfk_1` FOREIGN KEY (`id_camera`) REFERENCES `camera_giam_sat` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
