-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 21, 2025 lúc 07:05 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `webbh`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bien_the_san_pham`
--

CREATE TABLE `bien_the_san_pham` (
  `id_bien_the` int(11) NOT NULL,
  `id_san_pham` int(11) NOT NULL,
  `mau_sac` varchar(100) DEFAULT NULL,
  `cau_hinh` varchar(255) DEFAULT NULL,
  `gia_ban` decimal(10,2) NOT NULL,
  `so_luong_ton_kho` int(11) DEFAULT 0,
  `ma_sku` varchar(100) DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `bien_the_san_pham`
--

INSERT INTO `bien_the_san_pham` (`id_bien_the`, `id_san_pham`, `mau_sac`, `cau_hinh`, `gia_ban`, `so_luong_ton_kho`, `ma_sku`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(1, 1, 'Đen', NULL, 900000.00, 120, 'TNA1-DEN', '2025-06-21 10:53:44', '2025-06-23 11:41:32'),
(2, 2, 'Trắng', NULL, 1200000.00, 80, 'TNMSB2-TRANG', '2025-06-21 10:53:44', '2025-11-20 11:57:03'),
(3, 3, 'Trắng', NULL, 950000.00, 90, 'TNPC3-TRANG', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(4, 4, 'Đen', NULL, 2800000.00, 40, 'TNROG-PELTA-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(5, 5, 'Đen', NULL, 1500000.00, 60, 'TNTUF-H3-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(6, 6, 'Đen', NULL, 750000.00, 100, 'TNHX-EARBUDS2-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(7, 7, 'Trắng', NULL, 4500000.00, 30, 'TNSO-H9-TRANG', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(8, 7, 'Đen', NULL, 4500000.00, 25, 'TNSO-H9-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(9, 8, 'Đen', NULL, 1800000.00, 70, 'TNLOGI-G435-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(10, 9, 'Đen', NULL, 4000000.00, 50, 'TNLOGI-PROX2-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(11, 10, 'Đen', NULL, 3500000.00, 40, 'TNROG-DELTA2-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(12, 11, 'Đen', NULL, 900000.00, 64, 'LBAW-RIDE-DEN', '2025-06-21 10:53:44', '2025-07-08 11:27:39'),
(13, 12, 'Xanh dương', NULL, 350000.00, 97, 'LBAVA-K09-XANH', '2025-06-21 10:53:44', '2025-11-21 05:08:09'),
(14, 13, 'Xanh dương', NULL, 700000.00, 68, 'LBREZO-K118-XANH', '2025-06-21 10:53:44', '2025-11-21 04:16:34'),
(15, 14, 'Đen', NULL, 1200000.00, 103, 'LBJBL-GO4-DEN', '2025-06-21 10:53:44', '2025-11-21 05:08:09'),
(16, 15, 'Đỏ', NULL, 4000000.00, 43, 'LBJBL-CHARGE6-DO', '2025-06-21 10:53:44', '2025-11-20 11:39:01'),
(17, 16, 'Đen', NULL, 600000.00, 90, 'LBXM-POCKET-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(18, 17, 'Xanh', NULL, 800000.00, 74, 'LBREZO-E21-XANH', '2025-06-21 10:53:44', '2025-11-20 11:07:37'),
(19, 18, 'Đen', NULL, 1500000.00, 64, 'LBJBL-CLIP5-DEN', '2025-06-21 10:53:44', '2025-07-08 11:23:16'),
(20, 19, 'Đen', NULL, 900000.00, 50, 'LVT-ENKOR-E700-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(21, 20, 'Đen', NULL, 3000000.00, 19, 'LBK-NANO-S820-DEN', '2025-06-21 10:53:44', '2025-11-20 11:19:31'),
(22, 21, 'Đen', NULL, 4000000.00, 50, 'TVXM-A32-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(23, 22, 'Đen', NULL, 8000000.00, 40, 'TVSS-CU8000-43-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(24, 23, 'Đen', NULL, 10000000.00, 5, 'TVTCL-55P635-DEN', '2025-06-21 10:53:44', '2025-11-20 05:47:29'),
(25, 24, 'Đen', NULL, 15000000.00, 30, 'TVSS-CU8000-65-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(26, 25, 'Đen', NULL, 35000000.00, 15, 'TVSS-QLED-85-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(27, 26, 'Đen', NULL, 25000000.00, 19, 'TVLG-OLED-55-DEN', '2025-06-21 10:53:44', '2025-11-20 11:19:19'),
(28, 27, 'Đen', NULL, 10000000.00, 40, 'TVLG-NANOCELL-43-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(29, 28, 'Đen', NULL, 13000000.00, 30, 'TVLG-NANOCELL-55-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(30, 29, 'Đen', NULL, 18000000.00, 25, 'TVLG-65UT8050PSB-DEN', '2025-06-21 10:53:44', '2025-11-20 11:54:57'),
(31, 30, 'Đen', NULL, 6000000.00, 43, 'TVAQUA-43-DEN', '2025-06-21 10:53:44', '2025-11-20 11:41:13'),
(32, 31, 'Xanh dương', NULL, 600000.00, 80, 'TCS-TMT-A14D2B1-XANH', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(33, 32, 'Đen', NULL, 550000.00, 90, 'TCS-TMT-A45-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(34, 33, 'Đen', NULL, 400000.00, 70, 'TCS-JINYA-156-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(35, 34, 'Xám', NULL, 350000.00, 100, 'TCS-TOGO-TCSN14-XAM', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(36, 35, 'Nâu', NULL, 500000.00, 75, 'TCS-TMT-A12D3Y1-NAU', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(37, 36, 'Đen', NULL, 1200000.00, 60, 'BLT-TUCANO-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(38, 37, 'Nâu', NULL, 1500000.00, 40, 'BLT-TMT-FLAP-NAU', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(39, 38, 'Đen', NULL, 800000.00, 90, 'BLT-TOGO-TGB05-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(40, 39, 'Xanh dương', NULL, 1300000.00, 50, 'BLT-TMT-ROLL-XANH', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(41, 40, 'Đen', NULL, 900000.00, 70, 'BLT-TARGUS-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(42, 41, 'Xanh dương', NULL, 200000.00, 100, 'QCT-HYD-JF102-XANH', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(43, 42, 'Hồng', NULL, 250000.00, 90, 'QCT-HYD-JF79-HONG', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(44, 43, 'Đen', NULL, 280000.00, 80, 'QCT-HYD-F15-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(45, 44, 'Hồng', NULL, 350000.00, 70, 'QDB-HYD-JF96-HONG', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(46, 45, 'Trắng', NULL, 400000.00, 79, 'DBH-DQLDL06-TRANG', '2025-06-21 10:53:44', '2025-11-21 05:08:09'),
(47, 46, 'Trắng', NULL, 4500000.00, 35, 'MICA-LBP246DW-TRANG', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(48, 47, 'Trắng', NULL, 9000000.00, 25, 'MIHP-M428FDW-TRANG', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(49, 48, 'Đen', NULL, 6000000.00, 30, 'MIBRO-T720DW-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(50, 49, 'Trắng', NULL, 4000000.00, 38, 'MICA-LBP243DW-TRANG', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(51, 50, 'Đen', NULL, 2850000.00, 20, 'MHTL-HP-12CC-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(52, 51, 'Trắng', NULL, 1249000.00, 30, 'MHTL-SILI-800C-TRANG', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(53, 52, 'Đen', NULL, 7270000.00, 15, 'MHTL-SILI-6800C-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(54, 53, 'Trắng', NULL, 8000000.00, 30, 'NSW-OLED-TRANG', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(55, 53, 'Đỏ-Xanh Neon', NULL, 8200000.00, 25, 'NSW-OLED-RGB', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(56, 54, 'Trắng-Đen', NULL, 12000000.00, 20, 'PS5-DIGI-WD', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(57, 55, 'Trắng', NULL, 6500000.00, 25, 'XBOX-SS-TRANG', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(58, 56, 'Trắng', NULL, 1600000.00, 50, 'TCDS-TRANG', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(59, 56, 'Đen', NULL, 1600000.00, 40, 'TCDS-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(60, 56, 'Xanh', NULL, 1600000.00, 30, 'TCDS-XANH', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(61, 56, 'Hồng', NULL, 1600000.00, 20, 'TCDS-HONG', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(62, 57, 'Đen', NULL, 1000000.00, 58, 'CHL-G502-HERO-DEN', '2025-06-21 10:53:44', '2025-11-20 11:39:27'),
(63, 58, 'Đen', NULL, 2500000.00, 39, 'BPR-BWV3-DEN', '2025-06-21 10:53:44', '2025-11-20 11:56:59'),
(64, 58, 'Trắng', NULL, 2500000.00, 30, 'BPR-BWV3-TRANG', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(65, 59, 'Trắng', NULL, 3000000.00, 15, 'MCG-RETPK3P-TRANG', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(66, 59, 'Xanh mint', NULL, 3000000.00, 7, 'MCG-RETPK3P-XANH', '2025-06-21 10:53:44', '2025-11-20 11:20:06'),
(67, 60, 'Xanh Iceblue', '8GB RAM + 128GB ROM', 9000000.00, 70, 'SSA55-XB-128', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(68, 60, 'Tím Lilac', '8GB RAM + 256GB ROM', 9500000.00, 59, 'SSA55-TL-256', '2025-06-21 10:53:44', '2025-07-10 09:05:23'),
(69, 60, 'Vàng Lemon', '12GB RAM + 256GB ROM', 10500000.00, 49, 'SSA55-VL-256', '2025-06-21 10:53:44', '2025-07-11 01:46:25'),
(70, 61, 'Xanh dương', '128GB', 15000000.00, 48, 'IP13-XD-128', '2025-06-21 10:53:44', '2025-07-10 09:03:27'),
(71, 61, 'Hồng', '256GB', 17000000.00, 39, 'IP13-HONG-256', '2025-06-21 10:53:44', '2025-07-11 00:08:06'),
(72, 61, 'Đen', '512GB', 19000000.00, 30, 'IP13-DEN-512', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(73, 62, 'Đen', '6GB RAM + 128GB ROM', 4500000.00, 80, 'OPPO-A58-DEN-128-6G', '2025-06-21 10:53:45', '2025-06-21 10:53:45'),
(74, 62, 'Xanh lá', '8GB RAM + 128GB ROM', 4800000.00, 70, 'OPPO-A58-XANHLA-128-8G', '2025-06-21 10:53:45', '2025-06-21 10:53:45'),
(75, 63, 'Đen', '8GB RAM + 256GB ROM', 9500000.00, 53, 'RMN13PP-DEN-256-8G', '2025-06-21 10:53:45', '2025-06-27 10:27:14'),
(76, 63, 'Trắng', '12GB RAM + 512GB ROM', 10500000.00, 47, 'RMN13PP-TRANG-512-12G', '2025-06-21 10:53:45', '2025-06-26 11:05:48'),
(77, 64, 'Xanh lá', '4GB RAM + 128GB ROM', 3000000.00, 100, 'RM13C-XANHLA-128-4G', '2025-06-21 10:53:45', '2025-06-21 10:53:45'),
(78, 64, 'Đen', '6GB RAM + 128GB ROM', 3300000.00, 90, 'RM13C-DEN-128-6G', '2025-06-21 10:53:45', '2025-06-21 10:53:45'),
(79, 64, 'Xanh dương', '8GB RAM + 256GB ROM', 3800000.00, 70, 'RM13C-XANHDUONG-256-8G', '2025-06-21 10:53:45', '2025-06-21 10:53:45');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chi_tiet_don_hang`
--

CREATE TABLE `chi_tiet_don_hang` (
  `id_chi_tiet` int(11) NOT NULL,
  `id_don_hang` int(11) NOT NULL,
  `id_san_pham` int(11) NOT NULL,
  `id_bien_the` int(11) NOT NULL,
  `so_luong` int(11) NOT NULL,
  `don_gia` decimal(15,2) NOT NULL,
  `ten_san_pham` varchar(255) NOT NULL,
  `phan_loai` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `chi_tiet_don_hang`
--

INSERT INTO `chi_tiet_don_hang` (`id_chi_tiet`, `id_don_hang`, `id_san_pham`, `id_bien_the`, `so_luong`, `don_gia`, `ten_san_pham`, `phan_loai`) VALUES
(1, 1, 14, 15, 1, 1200000.00, 'Loa Bluetooth JBL Go 4', 'Đen'),
(2, 2, 17, 18, 1, 800000.00, 'Loa Bluetooth Rezo Pulse E21', 'Xanh'),
(3, 3, 15, 16, 1, 4000000.00, 'Loa Bluetooth JBL Charge 6', 'Đỏ'),
(4, 4, 26, 27, 1, 25000000.00, 'Smart Tivi OLED LG AI 4K 55 inch 55B4PSA', 'Đen'),
(5, 5, 20, 21, 1, 3000000.00, 'Loa kéo karaoke Nanomax S-820 400W', 'Đen'),
(6, 6, 15, 16, 1, 4000000.00, 'Loa Bluetooth JBL Charge 6', 'Đỏ'),
(7, 7, 15, 16, 1, 4000000.00, 'Loa Bluetooth JBL Charge 6', 'Đỏ'),
(8, 8, 57, 62, 1, 1000000.00, 'Logitech G502 HERO', 'Đen'),
(9, 8, 30, 31, 1, 6000000.00, 'Android Tivi Aqua FHD 43 inch AQT43K800FG', 'Đen'),
(10, 9, 30, 31, 1, 6000000.00, 'Android Tivi Aqua FHD 43 inch AQT43K800FG', 'Đen'),
(15, 13, 12, 13, 1, 350000.00, 'Loa Bluetooth AVA+ Led K09', 'Xanh dương'),
(16, 14, 13, 14, 1, 700000.00, 'Loa Bluetooth Rezo Light Motion K118', 'Xanh dương'),
(17, 15, 45, 46, 1, 400000.00, 'Đèn bàn học Điện Quang ĐQ LDL06', 'Trắng'),
(18, 15, 12, 13, 1, 350000.00, 'Loa Bluetooth AVA+ Led K09', 'Xanh dương'),
(19, 15, 14, 15, 2, 1200000.00, 'Loa Bluetooth JBL Go 4', 'Đen');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danh_gia_san_pham`
--

CREATE TABLE `danh_gia_san_pham` (
  `id_danh_gia` int(11) NOT NULL,
  `id_san_pham` int(11) NOT NULL,
  `ten_nguoi_dung` varchar(100) NOT NULL,
  `diem_danh_gia` int(11) NOT NULL CHECK (`diem_danh_gia` >= 1 and `diem_danh_gia` <= 5),
  `noi_dung_binh_luan` text DEFAULT NULL,
  `ngay_danh_gia` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `danh_gia_san_pham`
--

INSERT INTO `danh_gia_san_pham` (`id_danh_gia`, `id_san_pham`, `ten_nguoi_dung`, `diem_danh_gia`, `noi_dung_binh_luan`, `ngay_danh_gia`) VALUES
(64, 15, 'heo1056', 5, 'Bền Nghe tốt', '2025-06-26 17:00:00'),
(66, 23, 'heo1056', 5, 'Đẹp tốt', '2025-06-28 17:00:00'),
(67, 30, 'heo2910', 4, 'hay bền đẹp tốt', '2025-07-02 17:00:00'),
(68, 14, 'hai', 3, 'loa nghe hay', '2025-11-20 17:00:00');

--
-- Bẫy `danh_gia_san_pham`
--
DELIMITER $$
CREATE TRIGGER `sau_khi_cap_nhat_danh_gia` AFTER UPDATE ON `danh_gia_san_pham` FOR EACH ROW BEGIN
    IF OLD.id_san_pham = NEW.id_san_pham THEN
        -- Trường hợp chỉ cập nhật điểm đánh giá
        UPDATE `san_pham`
        SET
            `tong_so_luot_danh_gia` = (SELECT COUNT(*) FROM `danh_gia_san_pham` WHERE `id_san_pham` = NEW.id_san_pham),
            `diem_danh_gia_trung_binh` = (SELECT AVG(diem_danh_gia) FROM `danh_gia_san_pham` WHERE `id_san_pham` = NEW.id_san_pham)
        WHERE `id_san_pham` = NEW.id_san_pham;
    ELSE
        -- Nếu đánh giá bị chuyển sang sản phẩm khác
        UPDATE `san_pham`
        SET
            `tong_so_luot_danh_gia` = (SELECT COUNT(*) FROM `danh_gia_san_pham` WHERE `id_san_pham` = OLD.id_san_pham),
            `diem_danh_gia_trung_binh` = (SELECT IFNULL(AVG(diem_danh_gia), 0.0) FROM `danh_gia_san_pham` WHERE `id_san_pham` = OLD.id_san_pham)
        WHERE `id_san_pham` = OLD.id_san_pham;

        UPDATE `san_pham`
        SET
            `tong_so_luot_danh_gia` = (SELECT COUNT(*) FROM `danh_gia_san_pham` WHERE `id_san_pham` = NEW.id_san_pham),
            `diem_danh_gia_trung_binh` = (SELECT AVG(diem_danh_gia) FROM `danh_gia_san_pham` WHERE `id_san_pham` = NEW.id_san_pham)
        WHERE `id_san_pham` = NEW.id_san_pham;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sau_khi_them_danh_gia` AFTER INSERT ON `danh_gia_san_pham` FOR EACH ROW BEGIN
    UPDATE `san_pham`
    SET
        `tong_so_luot_danh_gia` = (SELECT COUNT(*) FROM `danh_gia_san_pham` WHERE `id_san_pham` = NEW.id_san_pham),
        `diem_danh_gia_trung_binh` = (SELECT AVG(diem_danh_gia) FROM `danh_gia_san_pham` WHERE `id_san_pham` = NEW.id_san_pham)
    WHERE `id_san_pham` = NEW.id_san_pham;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sau_khi_xoa_danh_gia` AFTER DELETE ON `danh_gia_san_pham` FOR EACH ROW BEGIN
    UPDATE `san_pham`
    SET
        `tong_so_luot_danh_gia` = (SELECT COUNT(*) FROM `danh_gia_san_pham` WHERE `id_san_pham` = OLD.id_san_pham),
        `diem_danh_gia_trung_binh` = (SELECT IFNULL(AVG(diem_danh_gia), 0.0) FROM `danh_gia_san_pham` WHERE `id_san_pham` = OLD.id_san_pham)
    WHERE `id_san_pham` = OLD.id_san_pham;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `don_hang`
--

CREATE TABLE `don_hang` (
  `id_don_hang` int(11) NOT NULL,
  `id_nguoi_dung` int(11) NOT NULL,
  `ngay_dat` datetime NOT NULL DEFAULT current_timestamp(),
  `tong_tien` decimal(15,2) NOT NULL,
  `ho_ten_nguoi_nhan` varchar(100) NOT NULL,
  `sdt_nguoi_nhan` varchar(20) NOT NULL,
  `dia_chi_giao_hang` text NOT NULL,
  `phuong_thuc_thanh_toan` varchar(50) NOT NULL DEFAULT 'COD',
  `trang_thai` varchar(50) NOT NULL DEFAULT 'Cho_xac_nhan'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `don_hang`
--

INSERT INTO `don_hang` (`id_don_hang`, `id_nguoi_dung`, `ngay_dat`, `tong_tien`, `ho_ten_nguoi_nhan`, `sdt_nguoi_nhan`, `dia_chi_giao_hang`, `phuong_thuc_thanh_toan`, `trang_thai`) VALUES
(1, 12, '2025-11-20 18:07:04', 1200000.00, 'hai', '0255115661', 'p25', 'COD', 'Cho_xac_nhan'),
(2, 12, '2025-11-20 18:07:37', 800000.00, 'hai', '0255115661', 'p25', 'COD', 'Cho_xac_nhan'),
(3, 12, '2025-11-20 18:09:15', 4000000.00, 'hai', '0255115661', 'p25', 'COD', 'Cho_xac_nhan'),
(4, 12, '2025-11-20 18:19:19', 25000000.00, 'hai', '0255115661', 'p25', 'COD', 'Cho_xac_nhan'),
(5, 12, '2025-11-20 18:19:31', 3000000.00, 'hai', '0255115661', 'p25', 'COD', 'Cho_xac_nhan'),
(6, 12, '2025-11-20 18:36:00', 4000000.00, 'hai', '0255115661', 'p25', 'COD', 'Cho_xac_nhan'),
(7, 12, '2025-11-20 18:39:01', 4000000.00, 'hai', '0255115661', 'p25', 'COD', 'Cho_xac_nhan'),
(8, 12, '2025-11-20 18:39:27', 7000000.00, 'hai', '0255115661', 'p25', 'COD', 'Cho_xac_nhan'),
(9, 12, '2025-11-20 18:41:13', 6000000.00, 'hai', '0255115661', 'p25', 'COD', 'Da_giao'),
(13, 18, '2025-11-20 19:13:47', 350000.00, 'hai2', '0347389473', 'nguyễn gia trí', 'COD', 'Cho_xac_nhan'),
(14, 12, '2025-11-21 11:16:34', 700000.00, 'hai', '0255115661', 'p25', 'COD', 'Cho_xac_nhan'),
(15, 12, '2025-11-21 12:08:09', 3150000.00, 'hai', '0255115661', 'p25', 'COD', 'Cho_xac_nhan');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `gio_hang`
--

CREATE TABLE `gio_hang` (
  `id_gio_hang` int(11) NOT NULL,
  `id_nguoi_dung` int(11) NOT NULL,
  `id_san_pham` int(11) NOT NULL,
  `id_bien_the` int(11) NOT NULL,
  `so_luong` int(11) NOT NULL DEFAULT 1,
  `ngay_them` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `hinh_anh_san_pham`
--

CREATE TABLE `hinh_anh_san_pham` (
  `id_hinh_anh` int(11) NOT NULL,
  `id_san_pham` int(11) NOT NULL,
  `url_hinh_anh` varchar(255) NOT NULL,
  `la_anh_dai_dien` tinyint(1) DEFAULT 0,
  `thu_tu_hien_thi` int(11) DEFAULT 0,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `hinh_anh_san_pham`
--

INSERT INTO `hinh_anh_san_pham` (`id_hinh_anh`, `id_san_pham`, `url_hinh_anh`, `la_anh_dai_dien`, `thu_tu_hien_thi`, `ngay_tao`) VALUES
(1, 1, 'https://songlongmedia.com/media/product/3544_tai_nghe_sudio_a1_songlongmedia__1_.jpg', 1, 0, '2025-06-21 10:53:44'),
(2, 2, 'https://product.hstatic.net/200000314529/product/tainghe1_f8f5db5dd171475c8b7be8fa23da93ff_master.jpg', 1, 0, '2025-06-21 10:53:44'),
(3, 3, 'https://www.pisenstore.com/storage/products/tai-nghe-loa/bhd-tw10/pisen-c2-7868.jpg', 1, 0, '2025-06-21 10:53:44'),
(4, 4, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/337180/tai-nghe-bluetooth-chup-tai-gaming-asus-rog-pelta-den-1-638811134538673172-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(5, 5, 'https://cdn.tgdd.vn/Products/Images/54/223020/Kit/tai-nghe-chup-tai-gaming-asus-tuf-h3-den-do-note.jpg', 1, 0, '2025-06-21 10:53:44'),
(6, 6, 'https://cdn.tgdd.vn/Products/Images/54/327793/tai-nghe-co-day-hp-hyperx-cloud-earbuds-ii-den-1-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(7, 7, 'https://cdn.tgdd.vn/Products/Images/54/327962/tai-nghe-bluetooth-gaming-sony-inzone-h9-wh-g900n-den-1-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(8, 8, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/337174/tai-nghe-bluetooth-chup-tai-gaming-logitech-g435-den-1-638817819739027082-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(9, 9, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/337176/tai-nghe-bluetooth-chup-tai-gaming-logitech-pro-x-2-den-1-638818024600293203-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(10, 10, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/337183/tai-nghe-bluetooth-chup-tai-gaming-asus-rog-delta-ii-den-1-638817683517417323-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(11, 11, 'https://cdn.tgdd.vn/Products/Images/2162/327367/Kit/loa-bluetooth-alpha-works-aw-ride-note.jpg', 1, 0, '2025-06-21 10:53:44'),
(12, 12, 'https://cdn.tgdd.vn/Products/Images/2162/313887/Kit/loa-bluetooth-ava-plus-led-k09-note.jpg', 1, 0, '2025-06-21 10:53:44'),
(13, 13, 'https://cdn.tgdd.vn/Products/Images/2162/313888/Kit/loa-bluetooth-rezo-light-motion-k118-note.jpg', 1, 0, '2025-06-21 10:53:44'),
(14, 14, 'https://cdn.tgdd.vn/Products/Images/2162/326193/loa-bluetooth-jbl-go-4-den-3-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(15, 15, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/2162/337464/loa-bluetooth-jbl-charge-6-070525-042114-655-600x600.jpg', 1, 0, '2025-06-21 10:53:44'),
(16, 16, 'https://cdn.tgdd.vn/Products/Images/2162/327608/Kit/loa-bluetooth-xiaomi-sound-pocket-den-note.jpg', 1, 0, '2025-06-21 10:53:44'),
(17, 17, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/2162/333081/Kit/loa-bluetooth-rezo-pulse-e21-note-638700489783260977.jpg', 1, 0, '2025-06-21 10:53:44'),
(18, 18, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/2162/327436/Kit/loa-bluetooth-jbl-clip-5-note-638676934773912993.jpg', 1, 0, '2025-06-21 10:53:44'),
(19, 19, 'https://cdn.tgdd.vn/Products/Images/2162/212959/loa-vi-tinh-21-enkor-e700-den-1-1-750x500.jpeg', 1, 0, '2025-06-21 10:53:44'),
(20, 20, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/2162/278796/Kit/keo-karaoke-nanomax-s-820-note-638684771695408725.jpg', 1, 0, '2025-06-21 10:53:44'),
(21, 21, 'https://cdn.tgdd.vn/Products/Images/1942/312858/Kit/note.jpg', 1, 0, '2025-06-21 10:53:44'),
(22, 22, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/303233/Kit/smart-tivi-samsung-4k-43-inch-ua43cu8000-note-638691016437175553.jpg', 1, 0, '2025-06-21 10:53:44'),
(23, 23, 'https://cdn.tgdd.vn/Products/Images/1942/281936/Kit/google-tcl-4k-55-inch-55p635-note.jpg', 1, 0, '2025-06-21 10:53:44'),
(24, 24, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/303230/Kit/smart-tivi-samsung-4k-65-inch-ua65cu8000-note-638692979185748547.jpg', 1, 0, '2025-06-21 10:53:44'),
(25, 25, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/331284/smart-tivi-qled-samsung-4k-85-inch-qa85q60d-1-638654499125982658-700x467.jpg', 1, 0, '2025-06-21 10:53:44'),
(26, 26, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/324912/Kit/tivi-oled-lg-4k-55-inch-55b4psa-note-638688283889000600.jpg', 1, 0, '2025-06-21 10:53:44'),
(27, 27, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/324923/Kit/tivi-nanocell-lg-4k-43-inch-43nano81tsa-note-638689268732094122.jpg', 1, 0, '2025-06-21 10:53:44'),
(28, 28, 'https://cdn.tgdd.vn/Products/Images/1942/278576/Kit/smart-nanocell-lg-4k-55-inch-55nano76sqa-note.jpg', 1, 0, '2025-06-21 10:53:44'),
(29, 29, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/324914/Kit/tivi-led-lg-4k-65-inch-65ut8050psb-note-638689247499399266.jpg', 1, 0, '2025-06-21 10:53:44'),
(30, 30, 'https://cdnv2.tgdd.vn/mwg-static/dmx/Products/Images/1942/327550/Kit/android-tivi-aqua-43-inch-aqt43k800fg-note-638653022401359766.jpg', 1, 0, '2025-06-21 10:53:44'),
(31, 31, 'https://cdn.tgdd.vn/Products/Images/7923/327934/tui-chong-soc-macbook-pro-14-inch-tomtoc-a14d2b1-xanh-1-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(32, 32, 'https://cdn.tgdd.vn/Products/Images/7923/327935/tui-chong-soc-laptop-14-inch-tomtoc-a45-den-3-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(33, 33, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/7923/329077/tui-chong-soc-laptop-15-6-inch-jinya-classic-den-1-638694485526124244-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(34, 34, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/7923/329695/tui-chong-soc-laptop-14-inch-togo-tcsn14-1-638614970643945585-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(35, 35, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/7923/327937/tui-chong-soc-laptop-14-inch-tomtoc-a12d3y1-vang-1-638694466891799074-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(36, 36, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/7923/330356/balo-laptop-15-6-inch-tucano-bravo-ags-eco-den-2-638628540442929559-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(37, 37, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/7923/336523/balo-laptop-16-inch-tomtoc-flap-vang-1-638798780772677254-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(38, 38, 'https://cdn.tgdd.vn/Products/Images/7923/328646/balo-laptop-15-6-inch-togo-tgb05-den-1-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(39, 39, 'https://cdn.tgdd.vn/Products/Images/7923/327235/balo-laptop-tomtoc-roll-top-15-6-inch-t61m1d1-xanh-dam-1-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(40, 40, 'https://cdn.tgdd.vn/Products/Images/7923/326479/balo-laptop-15-6-inch-targus-safire-essential-tbb580gl-den-1-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(41, 41, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/7922/336956/quat-cam-tay-mini-hydrus-jf-102-xanh-duong-5-638808340149931400-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(42, 42, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/7922/336955/quat-cam-tay-mini-hydrus-jf-79-vang-3-638808332387750147-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(43, 43, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/7922/336958/quat-cam-tay-mini-hydrus-f15-3-638808351349441140-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(44, 44, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/7922/336959/quat-de-ban-hydrus-jf-96-1-638808338038425460-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(45, 45, 'https://cdn.tgdd.vn/Products/Images/7075/193086/den-ban-dq-ldl06-5w-2-700x467.jpg', 1, 0, '2025-06-21 10:53:44'),
(46, 46, 'https://phucanhcdn.com/media/product/55209_may_in_laser_den_trang_canon_lbp246dw_2.jpg', 1, 0, '2025-06-21 10:53:44'),
(47, 47, 'https://hanoicomputercdn.com/media/product/50748_hp_laserjet_pro_m428fdw_021.jpg', 1, 0, '2025-06-21 10:53:44'),
(48, 48, 'https://www.brother.com.vn/-/media/ap2/vietnam/products/dcp-t720dw/20240530101910_dcp_t720dw.png?rev=98a53b1e880e4bad80c736e2ca4a113f', 1, 0, '2025-06-21 10:53:44'),
(49, 49, 'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/5693/335935/canon-lbp243dw-wifi-trang-1-638792703818713642-750x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(50, 50, 'https://hanoicomputercdn.com/media/product/85634_may_huy_tai_lieu_hp_oneshred_12cc_1.jpg', 1, 0, '2025-06-21 10:53:44'),
(51, 51, 'https://silicon.com.vn/image/cache/catalog/may-huy-tai-lieu/ps-800c-500x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(52, 52, 'https://silicon.com.vn/image/cache/catalog/may-huy-tai-lieu/silicon-ps-6800c-500x500.jpg', 1, 0, '2025-06-21 10:53:44'),
(53, 53, 'https://haloshop.vn/wp-content/uploads/2025/02/Nintendo-Switch-OLED-model-with-White-Joy-Con-Anima-5-1.jpg', 1, 0, '2025-06-21 10:53:44'),
(54, 54, 'https://hanoicomputercdn.com/media/product/56780_may_choi_game_sony_playstation_5_digital_edition_0003_4.jpg', 1, 0, '2025-06-21 10:53:44'),
(55, 55, 'https://hanoicomputercdn.com/media/product/69260_may_choi_game_microsoft_xbox_one_series_s_0001_2.jpg', 1, 0, '2025-06-21 10:53:44'),
(56, 56, 'https://cdn2.cellphones.com.vn/358x/media/catalog/product/a/a/aaaaaaaaaa.png', 1, 0, '2025-06-21 10:53:44'),
(57, 57, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/3/c/3c42e4219bbaa920c07c54784edd6269.jpg', 1, 0, '2025-06-21 10:53:44'),
(58, 58, 'https://product.hstatic.net/200000722513/product/phim_d33184cef09540f2a0d4201e82e356a0_5dcb7de8880d4d2197c1f726f4db1e23_c59cb96af6554f368d6b11417fe5acb8_grande.png', 1, 0, '2025-06-21 10:53:44'),
(59, 59, 'https://product.hstatic.net/200000272737/product/retroidpocket_3_e4ad58fe055441518d137d3389c4c2ce_master.jpg', 1, 0, '2025-06-21 10:53:44'),
(60, 60, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/s/m/sm-a556_galaxy_a55_awesome_lilac_ui.png', 1, 0, '2025-06-21 10:53:44'),
(61, 61, 'https://cdn2.fptshop.com.vn/unsafe/750x0/filters:format(webp):quality(75)/2021_9_15_637673230236322511_iphone-13-mini-trang-1.jpg', 1, 0, '2025-06-21 10:53:45'),
(62, 62, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/o/p/oppo-a58-den.jpg', 1, 0, '2025-06-21 10:53:45'),
(63, 63, 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-redmi-note-13-pro-4g_6__1.png', 1, 0, '2025-06-21 10:53:45'),
(64, 64, 'https://cdn.tgdd.vn/Products/Images/42/316771/xiaomi-redmi-13c-xanh-1-1-750x500.jpg', 1, 0, '2025-06-21 10:53:45');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `id_bien_the` int(11) DEFAULT NULL,
  `ten_san_pham` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `gia_ban` decimal(10,2) NOT NULL,
  `status` varchar(50) DEFAULT 'Chờ xử lý',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `product_id`, `id_bien_the`, `ten_san_pham`, `quantity`, `gia_ban`, `status`, `created_at`) VALUES
(8, 12, 30, 31, 'Android Tivi Aqua FHD 43 inch AQT43K800FG', 1, 6000000.00, 'Đã giao', '2025-07-10 13:43:56'),
(9, 12, 14, 15, 'Loa Bluetooth JBL Go 4', 2, 2400000.00, 'Đã giao', '2025-07-10 13:45:05'),
(10, 12, 14, 15, 'Loa Bluetooth JBL Go 4', 2, 2400000.00, 'Đã hủy', '2025-07-10 13:45:16'),
(11, 12, 23, 24, 'Google Tivi TCL AI 4K 55 inch 55P635', 1, 10000000.00, 'Đã giao', '2025-07-10 13:45:55'),
(12, 12, 57, 62, 'Logitech G502 HERO', 1, 1000000.00, 'Chờ xử lý', '2025-07-10 14:59:51'),
(13, 12, 30, 31, 'Android Tivi Aqua FHD 43 inch AQT43K800FG', 1, 6000000.00, 'Chờ xử lý', '2025-07-10 16:00:36'),
(14, 12, 30, 31, 'Android Tivi Aqua FHD 43 inch AQT43K800FG', 1, 6000000.00, 'Đã giao', '2025-07-10 16:02:01'),
(15, 12, 61, 70, 'iPhone 13', 1, 15000000.00, 'Đã giao', '2025-07-10 16:02:58'),
(16, 12, 61, 70, 'iPhone 13', 1, 15000000.00, 'Đang giao', '2025-07-10 16:03:27'),
(17, 12, 60, 68, 'Samsung Galaxy A55', 1, 9500000.00, 'Đã hủy', '2025-07-10 16:05:23'),
(18, 12, 61, 71, 'iPhone 13', 1, 17000000.00, 'Đã hủy', '2025-07-11 07:08:06'),
(19, 12, 60, 69, 'Samsung Galaxy A55', 1, 10500000.00, 'Chờ xử lý', '2025-07-11 08:46:25'),
(20, 12, 12, 13, 'Loa Bluetooth AVA+ Led K09', 1, 350000.00, 'Đã hủy', '2025-07-11 22:57:36'),
(21, 12, 30, 31, 'Android Tivi Aqua FHD 43 inch AQT43K800FG', 1, 6000000.00, 'Chờ xử lý', '2025-07-11 22:58:24'),
(22, 12, 15, 16, 'Loa Bluetooth JBL Charge 6', 1, 4000000.00, 'Đã hủy', '2025-07-11 22:58:33'),
(23, 12, 30, 31, 'Android Tivi Aqua FHD 43 inch AQT43K800FG', 1, 6000000.00, 'Chờ xử lý', '2025-11-20 11:57:29'),
(24, 12, 30, 31, 'Android Tivi Aqua FHD 43 inch AQT43K800FG', 1, 6000000.00, 'Chờ xử lý', '2025-11-20 12:34:57'),
(25, 12, 30, 31, 'Android Tivi Aqua FHD 43 inch AQT43K800FG', 1, 6000000.00, 'Đã hủy', '2025-11-20 12:35:02'),
(26, 12, 30, 31, 'Android Tivi Aqua FHD 43 inch AQT43K800FG', 1, 6000000.00, 'Đã hủy', '2025-11-20 12:36:51'),
(27, 12, 30, 31, 'Android Tivi Aqua FHD 43 inch AQT43K800FG', 1, 6000000.00, 'Đã hủy', '2025-11-20 12:38:47'),
(28, 12, 30, 31, 'Android Tivi Aqua FHD 43 inch AQT43K800FG', 1, 6000000.00, 'Đã hủy', '2025-11-20 12:43:10'),
(29, 12, 23, 24, 'Google Tivi TCL AI 4K 55 inch 55P635', 1, 10000000.00, 'Đã hủy', '2025-11-20 12:43:39'),
(30, 12, 23, 24, 'Google Tivi TCL AI 4K 55 inch 55P635', 1, 10000000.00, 'Đã hủy', '2025-11-20 12:46:32'),
(31, 12, 23, 24, 'Google Tivi TCL AI 4K 55 inch 55P635', 1, 10000000.00, 'Đã hủy', '2025-11-20 12:47:29'),
(32, 12, 58, 63, 'Razer BlackWidow V3', 1, 2500000.00, 'Đã hủy', '2025-11-20 18:09:58'),
(33, 12, 59, 66, 'Máy chơi game cầm tay Retroid Pocket 3+', 1, 3000000.00, 'Chờ xử lý', '2025-11-20 18:20:06'),
(34, 12, 30, 31, 'Android Tivi Aqua FHD 43 inch AQT43K800FG', 1, 6000000.00, 'Chờ xử lý', '2025-11-20 18:33:34'),
(35, 12, 15, 16, 'Loa Bluetooth JBL Charge 6', 1, 4000000.00, 'Chờ xử lý', '2025-11-20 18:33:56');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `san_pham`
--

CREATE TABLE `san_pham` (
  `id_san_pham` int(11) NOT NULL,
  `ten_san_pham` varchar(255) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `thong_so_ky_thuat` text DEFAULT NULL,
  `video_gioi_thieu` varchar(255) DEFAULT NULL,
  `chuong_trinh_khuyen_mai` text DEFAULT NULL,
  `bao_hanh` varchar(100) DEFAULT NULL,
  `diem_danh_gia_trung_binh` decimal(2,1) DEFAULT 0.0,
  `tong_so_luot_danh_gia` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `san_pham`
--

INSERT INTO `san_pham` (`id_san_pham`, `ten_san_pham`, `mo_ta`, `thong_so_ky_thuat`, `video_gioi_thieu`, `chuong_trinh_khuyen_mai`, `bao_hanh`, `diem_danh_gia_trung_binh`, `tong_so_luot_danh_gia`) VALUES
(1, 'Tai nghe Bluetooh Sudio A1', 'Sản xuất tại: Trung Quốc', 'Bộ sản phẩm gồm: 01 Đôi tai nghe, 01 Hộp sạc, 01 Dây sạc type-C, Sách HDSD.', 'https://youtu.be/W21SWN5DMT0', NULL, '12 tháng', 0.0, 0),
(2, 'Tai Nghe Bluetooth Chụp Tai cao cấp MS-B2', 'Xuất xứ: Trung Quốc', 'Kích thước: 197x185x76mm, Kết nối: Bluetooth 5.0 & Dây headphone 3,5mm, Dung lượng pin: 400mAh', NULL, NULL, '12 tháng', 0.0, 0),
(3, 'Tai nghe không dây True Wireless PISEN C3', 'Xuất xứ: Trung Quốc', 'Dòng sản phẩm: BHD-TW10, ID FCC 2BCVO-BHD-TW10, Kích thước: 68-46-26 mm, Trọng lượng máy: 31g, Loại pin: Pin lithium polymer có thể sạc lại, Sạc đầu vào: DC 5V-1A, Dung lượng pin của tai nghe 25 mAh, Dung lượng pin của hộp sạc 220 mAh', NULL, 'Giảm 20%', '12 tháng', 0.0, 0),
(4, 'Tai nghe Bluetooth Chụp Tai Gaming Asus ROG PELTA', 'Xuất xứ: Đài Loan', 'Âm thanh nổi, Driver 50 mm, Jack cắm: Type C, Công nghệ kết nối: 2.4 GHz Bluetooth, Kích thước: Dài 16.94 cm - Rộng 9.3 cm - Cao 22.32 cm, Khối lượng: 309 g', 'https://youtu.be/nYknJbqvCK8', NULL, '24 tháng', 0.0, 0),
(5, 'Tai nghe Chụp Tai Gaming Asus TUF H3', 'Sản xuất tại: Trung Quốc', 'Công nghệ âm thanh: Driver 50 mm, Âm thanh vòm 7.1, Tương thích: macOS, Android, Xbox 1, PS4, Máy chơi game Nintendo Switch, Windows, Jack cắm: 3.5 mm, Độ dài dây: 1.3 m, Tiện ích: Có mic thoại, Kết nối cùng lúc: 1 thiết bị, Điều khiển: Bánh xe lăn, Phím điều khiển: Tăng/giảm âm lượng, Kích thước: Dài 10 cm - Rộng 8 cm - Cao 4 cm, Khối lượng: 294 g', 'https://youtu.be/H1FM6WmeR7M', NULL, '24 tháng', 0.0, 0),
(6, 'Tai nghe Có dây Gaming HP HyperX Cloud Earbuds II', 'Thương hiệu của: Mỹ, Sản xuất tại: Trung Quốc', 'Driver 14 mm, Tương thích: macOS, Android, iOS, Windows, Jack cắm: 3.5 mm, Độ dài dây: 1.2 m, Tiện ích: Có mic thoại, Kết nối cùng lúc: 1 thiết bị, Điều khiển: Phím nhấn, Phím điều khiển: Phát/dừng chơi nhạc, Nhận/Ngắt cuộc gọi, Khối lượng: 18 g', NULL, NULL, '12 tháng', 0.0, 0),
(7, 'Tai nghe Bluetooth Chụp Tai Gaming Sony INZONE H9 WH-G900N', 'Thương hiệu của: Nhật Bản, Sản xuất tại: Việt Nam', 'Thời lượng pin tai nghe: Dùng 32 giờ - Sạc 3.5 giờ, Cổng sạc: Type-C, Công nghệ âm thanh: Âm thanh môi trường, Công nghệ ENC, 360 Spatial Sound, Driver 40 mm, Tương thích: macOS, ChromeOS, PS5, Android, iOS, Windows, Ứng dụng kết nối: PC INZONE Hub, Jack cắm: Type C, Tiện ích: Micro Boom, Game Mode, Có mic thoại, Sạc nhanh, Chống ồn, Kết nối cùng lúc: 1 thiết bị, Công nghệ kết nối: Bộ thu phát USB, Bluetooth 5.0, Điều khiển: Phím nhấn, Bánh xe lăn, Phím điều khiển: Tăng/giảm âm lượng, Kết nối Bluetooth, Chuyển chế độ, Bật/tắt nguồn, Kích thước: Dài 29.46 cm - Rộng 28.95 cm - Cao 10.67 cm, Khối lượng: 330g (Trắng); 335g (Đen)', 'https://youtu.be/7l68rPeO_4w', NULL, '12 tháng', 0.0, 0),
(8, 'Tai nghe Bluetooth Chụp Tai Gaming Logitech G435', 'Thương hiệu của: Thụy Sỹ, Sản xuất tại: Trung Quốc', 'Thời lượng pin tai nghe: Dùng 18 giờ - Sạc 2 giờ, Cổng sạc: Type-C, Công nghệ âm thanh: Driver 40 mm, Tương thích: PC, Mac, Các thiết bị có hỗ trợ Bluetooth, PlayStation 4, PlayStation 5, Nintendo Switch, Tiện ích: Có mic thoại, Sạc nhanh, Kết nối cùng lúc: 1 thiết bị, Công nghệ kết nối: LIGHTSPEED USB, Bluetooth, Điều khiển: Phím nhấn, Phím điều khiển: Tăng/giảm âm lượng, Nút tắt tiếng, Kết nối Bluetooth, Bật/tắt nguồn, Khối lượng: 165 g', NULL, NULL, '12 tháng', 0.0, 0),
(9, 'Tai nghe Bluetooth Chụp Tai Gaming Logitech Pro X 2', 'Thương hiệu của: Thụy Sỹ, Sản xuất tại: Trung Quốc', 'Thời lượng pin tai nghe: Dùng 50 giờ - Sạc 4 giờ, Cổng sạc: Type-C, Công nghệ âm thanh: Driver 50 mm, Tương thích: macOS, PlayStation 4, PlayStation 5, Windows, Jack cắm: 3.5 mm, Độ dài dây: 1.8 m, Tiện ích: Có mic thoại, Sạc nhanh, Kết nối cùng lúc: 1 thiết bị, Công nghệ kết nối: LIGHTSPEED USB, Bluetooth, Điều khiển: Phím nhấn, Bánh xe lăn, Phím điều khiển: Tăng/giảm âm lượng, Kết nối Bluetooth, Bật/Tắt Mic, Kích thước: Dài 9.5 cm - Rộng 17.6 cm - Cao 18.9 cm, Khối lượng: 345 g', 'https://youtu.be/DLDXvkzH7tQ', NULL, '12 tháng', 0.0, 0),
(10, 'Tai nghe Bluetooth Chụp Tai Gaming Asus ROG Delta II', 'Thương hiệu của: Đài Loan, Sản xuất tại: Trung Quốc', 'Thời lượng pin tai nghe: Dùng 110 giờ - Sạc 2 giờ, Cổng sạc: Type-C, Công nghệ âm thanh: Âm thanh nổi, Công nghệ không dây ROG SpeedNova, Công nghệ DualFlow Audio, Driver 50 mm, Tương thích: Xbox, PC, macOS, PlayStation 4, PlayStation 5, Nintendo Switch, Android, iOS, iPadOS (iPad), Jack cắm: 3.5 mm, Độ dài dây: 2 m, Tiện ích: Micro Boom, Có đèn RGB, Có mic thoại, Sạc nhanh, Kết nối cùng lúc: 2 thiết bị, Công nghệ kết nối: 2.4 GHz, Bluetooth, Điều khiển: Phím nhấn, Bánh xe lăn, Kích thước: Dài 16.5 cm - Rộng 9.5 cm - Cao 20.9 cm, Khối lượng: 318 g', NULL, NULL, '12 tháng', 0.0, 0),
(11, 'Loa Bluetooth Alpha Works AW-Ride', 'Xuất xứ: Trung Quốc', 'Tổng công suất: 20 W, Nguồn: Pin 1200 mAh, Thời gian sử dụng: Dùng khoảng 18 tiếng (với 50% âm lượng), Thời gian sạc: Sạc khoảng 2.5 tiếng', 'https://youtu.be/AOA_cmNDt0A', NULL, '12 tháng', 0.0, 0),
(12, 'Loa Bluetooth AVA+ Led K09', 'Xuất xứ: Trung Quốc', 'Tổng công suất: 5 W, Nguồn: Pin, Thời gian sử dụng: Dùng khoảng 2.5 - 4 giờ, Thời gian sạc: Sạc khoảng 2 - 3 tiếng', 'https://youtu.be/v-xCAxsHsLI', NULL, '12 tháng', 0.0, 0),
(13, 'Loa Bluetooth Rezo Light Motion K118', 'Xuất xứ Đài Loan', 'Tổng công suất: 10 W, Nguồn: Pin, Thời gian sử dụng: Dùng khoảng 2 - 3 tiếng, Thời gian sạc: Sạc khoảng 1.5 - 2.5 tiếng, Công nghệ âm thanh: Âm thanh Hi-Fi, Âm thanh 360 độ', 'https://youtu.be/MGYg7Z3ZVcc', NULL, '12 tháng', 0.0, 0),
(14, 'Loa Bluetooth JBL Go 4', 'Xuất xứ Trung Quốc', 'Tổng công suất: 4.2 W, Nguồn: Pin, Thời gian sử dụng: Dùng khoảng 7 tiếng, Thời gian sạc: Sạc khoảng 3 tiếng, Công nghệ âm thanh: JBL Pro Sound', 'https://youtu.be/aHUeF9waDvM', NULL, '12 tháng', 3.0, 1),
(15, 'Loa Bluetooth JBL Charge 6', 'Xuất xứ: Hàn Quốc', 'Tổng công suất: 45 W, Nguồn: Pin, Thời gian sử dụng: Dùng khoảng 28 tiếng, Thời gian sạc: Sạc khoảng 3 tiếng, Công nghệ âm thanh: Công nghệ AI Sound Boost, JBL Pro Sound', NULL, NULL, '12 tháng', 5.0, 1),
(16, 'Loa Bluetooth Xiaomi Sound Pocket', 'Xuất xứ Trung Quốc/Malaysia /Đài Loan', 'Tổng công suất: 5 W, Nguồn: Pin 1000 mAh, Thời gian sử dụng: Dùng khoảng 10 tiếng, Thời gian sạc: Sạc khoảng 3 tiếng, Công nghệ âm thanh: True Wireless Stereo', 'https://youtu.be/G6-wSspgdbY', NULL, '60 tháng', 0.0, 0),
(17, 'Loa Bluetooth Rezo Pulse E21', 'Xuất xứ Trung Quốc/Malaysia /Đài Loan', 'Tổng công suất: 10 W, Nguồn: Pin, Thời gian sử dụng: Dùng khoảng 3 - 7 tiếng, Thời gian sạc: Sạc khoảng 4 tiếng', 'https://youtu.be/HI6Gzt-TPZo', NULL, '12 tháng', 0.0, 0),
(18, 'Loa Bluetooth JBL Clip 5', 'Xuất xứ: Hàn Quốc', 'Tổng công suất: 7 W, Nguồn: Pin, Thời gian sử dụng: Dùng khoảng 12 tiếng, Thời gian sạc: Sạc khoảng 3 tiếng, Công nghệ âm thanh: JBL Pro Sound', 'https://youtu.be/UGWmvyTVCj4', NULL, '12 tháng', 0.0, 0),
(19, 'Loa vi tính Bluetooth Enkor E700 Đen', 'Xuất xứ Trung Quốc', 'Số lượng kênh: 2.1 kênh, Tổng công suất: 20 W, Nguồn: Cắm điện dùng', NULL, NULL, '12 tháng', 0.0, 0),
(20, 'Loa kéo karaoke Nanomax S-820 400W', 'Xuất xứ Đài Loan', 'Số đường tiếng của loa: 2 đường tiếng, Tổng công suất: 400 W, Nguồn: Cắm điện hoặc ắc quy, Thời gian sử dụng: Dùng khoảng 3 - 7 tiếng, Thời gian sạc: Sạc khoảng 2 tiếng, Phím điều khiển: Nút bấm và nút vặn cơ học', 'https://youtu.be/rV6uX_vFE9Y', NULL, '12 tháng', 0.0, 0),
(21, 'Google Tivi Xiaomi A 32 inch L32M8-P2SEA', 'Nơi sản xuất: Việt Nam', 'Kích cỡ màn hình: 32 inch, Độ phân giải: HD, Loại màn hình: Đèn nền: LED viền (Edge LED), Tấm nền: IPS LCD, Hệ điều hành: Google TV, Chất liệu chân đế: Mặt trước kim loại - Mặt sau nhựa, Chất liệu viền tivi: Kim loại', 'https://youtu.be/TvBr8g5-YYA', '-13%', '12 tháng', 0.0, 0),
(22, 'Smart Tivi Crystal UHD Samsung 4K 43 inch UA43CU8000', 'Nơi sản xuất: Việt Nam', 'Loại Tivi: Smart Tivi Crystal UHD, Kích cỡ màn hình: 43 inch, Độ phân giải: 4K (Ultra HD), Loại màn hình: Đèn nền: LED viền (Edge LED), Tấm nền: VA LCD, Hệ điều hành: Tizen™, Chất liệu chân đế: Nhựa, Chất liệu viền tivi: Nhựa', 'https://youtu.be/1A3-u29pLiI', NULL, '12 tháng', 0.0, 0),
(23, 'Google Tivi TCL AI 4K 55 inch 55P635', 'Nơi sản xuất: Việt Nam', 'Loại Tivi: Google Tivi, Kích cỡ màn hình: 55 inch, Độ phân giải: 4K (Ultra HD), Loại màn hình: Đèn nền: LED nền (Direct LED), Tấm nền: VA LCD, Hệ điều hành: Google TV, Chất liệu chân đế: Nhựa, Chất liệu viền tivi: Nhựa', NULL, '-23%', '12 tháng', 5.0, 1),
(24, 'Smart Tivi Crystal UHD Samsung 4K 65 inch UA65CU8000', 'Nơi sản xuất: Việt Nam', 'Loại Tivi: Smart Tivi Crystal UHD, Kích cỡ màn hình: 65 inch, Độ phân giải: 4K (Ultra HD), Loại màn hình: Đèn nền: LED viền (Edge LED), Tấm nền: VA LCD, Hệ điều hành: Tizen™, Chất liệu chân đế: Nhựa, Chất liệu viền tivi: Nhựa', 'https://youtu.be/1A3-u29pLiI', NULL, '12 tháng', 0.0, 0),
(25, 'Smart Tivi QLED Samsung 4K 85 inch QA85Q60D', 'Nơi sản xuất: Việt Nam', 'Loại Tivi: Smart Tivi QLED, Kích cỡ màn hình: 85 inch, Độ phân giải: 4K (Ultra HD), Loại màn hình: Đèn nền: LED viền (Edge LED), Tấm nền: Hãng không công bố, Hệ điều hành: Tizen™, Chất liệu chân đế: Nhựa, Chất liệu viền tivi: Nhựa', NULL, NULL, '12 tháng', 0.0, 0),
(26, 'Smart Tivi OLED LG AI 4K 55 inch 55B4PSA', 'Nơi sản xuất: Indonesia', 'Loại Tivi: Smart Tivi OLED, Kích cỡ màn hình: 55 inch, Độ phân giải: 4K (Ultra HD), Loại màn hình: Tấm nền: OLED, Hệ điều hành: webOS 24, Chất liệu chân đế: Vỏ nhựa lõi kim loại, Chất liệu viền tivi: Nhựa', 'https://youtu.be/gfj5tUr-6OY?si=ol9jqS_FqkL-sQJ0', NULL, '60 tháng', 0.0, 0),
(27, 'Smart Tivi NanoCell LG AI 4K 43 inch 43NANO81TSA', 'Nơi sản xuất: Indonesia', 'Loại Tivi: Smart Tivi NanoCell, Kích cỡ màn hình: 43 inch, Độ phân giải: 4K (Ultra HD), Loại màn hình: Đèn nền: LED nền (Direct LED), Tấm nền: Hãng không công bố, Hệ điều hành: webOS 24, Chất liệu chân đế: Vỏ nhựa lõi kim loại, Chất liệu viền tivi: Nhựa', 'https://youtu.be/hMflznpvuYg', NULL, '12 tháng', 0.0, 0),
(28, 'Smart Tivi NanoCell LG AI 4K 55 inch 55NANO76SQA', 'Nơi sản xuất: Indonesia', 'Loại Tivi: Smart Tivi NanoCell, Kích cỡ màn hình: 55 inch, Độ phân giải: 4K (Ultra HD), Loại màn hình: Đèn nền: LED nền (Direct LED), Tấm nền: Hãng không công bố, Hệ điều hành: webOS 22, Chất liệu chân đế: Vỏ nhựa lõi kim loại, Chất liệu viền tivi: Nhựa', 'https://youtu.be/UhH0bnFJJt0', NULL, '12 tháng', 0.0, 0),
(29, 'Smart Tivi LG AI 4K 65 inch 65UT8050PSB', 'Nơi sản xuất: Indonesia', 'Loại Tivi: Smart Tivi, Kích cỡ màn hình: 65 inch, Độ phân giải: 4K (Ultra HD), Loại màn hình: Đèn nền: LED nền (Direct LED), Tấm nền: Hãng không công bố, Hệ điều hành: webOS 24, Chất liệu chân đế: Vỏ nhựa lõi kim loại, Chất liệu viền tivi: Nhựa', 'https://youtu.be/bvUK8HZfljg', NULL, '12 tháng', 0.0, 0),
(30, 'Android Tivi Aqua FHD 43 inch AQT43K800FG', 'Nơi sản xuất: Việt Nam', 'Loại Tivi: Android Tivi, Kích cỡ màn hình: 43 inch, Độ phân giải: Full HD, Loại màn hình: Đèn nền: LED nền (Direct LED), Tấm nền: VA LCD, Hệ điều hành: Android 11.0, Chất liệu chân đế: Nhựa, Chất liệu viền tivi: Nhựa', 'https://youtu.be/AYMiBtNBVbQ', NULL, '12 tháng', 4.0, 1),
(31, 'Túi Chống Sốc Macbook Pro 14 inch Tomtoc A14D2B1', 'Sản xuất tại: Trung Quốc', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(32, 'Túi chống sốc Laptop 14 inch Tomtoc A45', 'Xuất xứ: Trung Quốc', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(33, 'Túi chống sốc Laptop 15.6 inch Jinya Classic', 'Xuất xứ: Trung Quốc', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(34, 'Túi Chống Sốc Laptop 14 inch Togo TCSN14', 'Xuất xứ: Trung Quốc', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(35, 'Túi chống sốc Laptop 14 inch Tomtoc A12D3Y1', 'Sản xuất tại: Trung Quốc', NULL, NULL, NULL, '24 tháng', 0.0, 0),
(36, 'Balo laptop 15.6 inch Tucano Bravo AGS Eco', 'Sản xuất tại: Trung Quốc', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(37, 'Balo Laptop 16 inch Tomtoc Flap', 'Sản xuất tại: Việt Nam', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(38, 'Balo Laptop 15.6 inch Togo TGB05', 'Sản xuất tại: Việt Nam', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(39, 'Balo Laptop 15.6 inch Tomtoc Roll top T61M1D1', 'Sản xuất tại: Trung Quốc', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(40, 'Balo Laptop 15.6 inch Targus Safire Essential TBB580GL', 'Xuất xứ: HongKong', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(41, 'Quạt cầm tay mini Hydrus JF-102', 'Sản xuất tại: Trung Quốc', 'Mức gió: 5 mức độ, Bảng điều khiển: Màn hình led thể hiện số pin, Chiều dài dây điện: 101 cm, Chất liệu: Nhựa ABS + linh kiện điện tử, Cổng sạc: Type C, Thời gian sử dụng điện sau khi sạc: 1.5 - 5.2 giờ (tùy theo tốc độ gió), Dung lượng pin: 3000 mAh, Tiện ích: Có thể gập, Kích thước: Ngang 5.45 cm - Cao 16.4 cm - Sâu 6 cm, Khối lượng: 0.19 kg', 'https://youtu.be/G5Z7CmcT0oc', NULL, 'Không bảo hành. Đổi trả trong vòng 7 ngày nếu sản phẩm lỗi kỹ thuật.', 0.0, 0),
(42, 'Quạt cầm tay mini Hydrus JF-79', 'Xuất xứ: Trung Quốc', 'Mức gió: 5 mức độ, Bảng điều khiển: Màn hình led thể hiện số pin, Chiều dài dây điện: 100 cm, Chất liệu: Nhựa ABS + linh kiện điện tử, Cổng sạc: Type C, Thời gian sử dụng điện sau khi sạc: 3.5 - 11 giờ ( tùy theo tốc độ gió), Dung lượng pin: 4000 mAh, Kích thước: Ngang 5.88 cm - Cao 15.85 cm - Sâu 6.24 cm, Khối lượng: 0.21 kg', 'https://youtu.be/G5Z7CmcT0oc', NULL, 'Không bảo hành. Đổi trả trong vòng 7 ngày nếu sản phẩm lỗi kỹ thuật.', 0.0, 0),
(43, 'Quạt cầm tay mini Hydrus F15', 'Xuất xứ: Trung Quốc', 'Mức gió: 4 mức độ, Bảng điều khiển: Màn hình led thể hiện số pin, Chiều dài dây điện: 100 cm, Chất liệu: Nhựa ABS + linh kiện điện tử, Cổng sạc: Type C, Thời gian sử dụng điện sau khi sạc: 2.67 - 12 giờ (tuỳ theo tốc độ gió), Dung lượng pin: 4000 mAh, Tiện ích: Chế độ lạnh, Có thể gập, Kích thước: Ngang 6.2 cm - Cao 18.3 cm - Sâu 5.77 cm, Khối lượng: 0.24 kg', 'https://youtu.be/G5Z7CmcT0oc', NULL, 'Không bảo hành. Đổi trả trong vòng 7 ngày nếu sản phẩm lỗi kỹ thuật.', 0.0, 0),
(44, 'Quạt để bàn mini Hydrus JF-96', 'Xuất xứ: Trung Quốc', 'Mức gió: 4 mức độ, Chiều dài dây điện: 101 cm, Chất liệu: Nhựa ABS/ PP + linh kiện điện tử, Cổng sạc: Type C, Thời gian sử dụng điện sau khi sạc: 3 - 10.5 giờ (tuỳ theo tốc độ gió), Dung lượng pin: 2000 mAh, Kích thước: Ngang 11.8 cm - Cao 17 cm - Sâu 9.58 cm, Khối lượng: 0.37 kg', NULL, NULL, 'Không bảo hành. Đổi trả trong vòng 7 ngày nếu sản phẩm lỗi kỹ thuật.', 0.0, 0),
(45, 'Đèn bàn học Điện Quang ĐQ LDL06', 'Sản xuất tại: Trung Quốc', 'Công suất: 5W, Điều khiển: Cảm ứng, Số bóng đèn LED: 1 bóng, Tiện ích: Có thể điều chỉnh độ cao, hướng chiếu sáng, Điều chỉnh màu sắc của đèn, Kích thước - Khối lượng: Cao 52 cm - Ngang 14 cm - Sâu 14 cm - Nặng 0.87 kg', 'https://youtu.be/HqDlvFlxTLE', NULL, 'Sản phẩm mới, chính hãng (Không bảo hành, đổi trả)', 0.0, 0),
(46, 'Máy in Canon LBP246dw', 'Máy in laser đơn sắc với tốc độ in nhanh, hỗ trợ in hai mặt tự động', 'Tốc độ in: 40 trang/phút, Độ phân giải: 600 x 600 dpi, Kết nối: USB, LAN, Wi-Fi, Khay giấy: 250 tờ', NULL, 'Giảm giá 10%', '12 tháng', 0.0, 0),
(47, 'Máy in HP LaserJet Pro MFP M428fdw', 'Máy in đa chức năng với khả năng in, scan, copy, fax, phù hợp cho văn phòng hiện đại.', 'Tốc độ in: 38 trang/phút, Độ phân giải: 1200 x 1200 dpi, Kết nối: USB, Ethernet, Wi-Fi, Khay giấy: 250 tờ', NULL, 'Tặng gói bảo trì 6 tháng', '12 tháng', 0.0, 0),
(48, 'Máy in Brother DCP-T720DW', 'Máy in phun màu đa chức năng với khả năng in, scan, copy, kết nối không dây.', 'Độ phân giải: 1200 x 6000 dpi, Tốc độ in: 17 trang/phút (đen trắng), 9.5 trang/phút (màu), Kết nối: USB, Wi-Fi, Khay giấy: 150 tờ', 'https://youtu.be/qYUH3PkLhzg', 'Tặng bộ mực in chính hãng', '12 tháng', 0.0, 0),
(49, 'Máy in Canon LBP243dw', 'Máy in laser đơn sắc với khả năng in hai mặt tự động, kết nối linh hoạt.', 'Tốc độ in: 36 trang/phút, Độ phân giải: 600 x 600 dpi, Kết nối: USB, LAN, Wi-Fi, Khay giấy: 250 tờ', NULL, 'Tặng kèm 1 hộp mực', '12 tháng', 0.0, 0),
(50, 'Máy hủy tài liệu HP OneShred 12CC', 'Máy hủy tài liệu HP OneShred 12CC có thiết kế nhỏ gọn, phù hợp cho văn phòng vừa và nhỏ.', 'Công suất hủy: 12 tờ/lần, Kiểu hủy: Vụn, Dung tích thùng chứa: 20 lít, Khả năng hủy: Giấy, ghim, thẻ tín dụng', NULL, NULL, '12 tháng', 0.0, 0),
(51, 'Máy hủy tài liệu Silicon PS-800C', 'Máy hủy tài liệu Silicon PS-800C có khả năng hủy nhanh chóng, phù hợp cho văn phòng có nhu cầu hủy tài liệu thường xuyên.', 'Công suất hủy: 8 tờ/lần, Kiểu hủy: Vụn, Dung tích thùng chứa: 21 lít, Khả năng hủy: Giấy, ghim, thẻ tín dụng', 'https://youtu.be/1bP3WQ6XDyc', NULL, '12 tháng', 0.0, 0),
(52, 'Máy hủy tài liệu Silicon PS-6800C', 'Máy hủy tài liệu Silicon PS-6800C có khả năng hủy mạnh mẽ, phù hợp cho văn phòng có nhu cầu hủy tài liệu lớn.', 'Công suất hủy: 20 tờ/lần, Kiểu hủy: Vụn, Dung tích thùng chứa: 30 lít, Khả năng hủy: Giấy, ghim, thẻ tín dụng', 'https://youtu.be/Dzw3BrY9V1U', NULL, '12 tháng', 0.0, 0),
(53, 'Nintendo Switch OLED', 'Máy chơi game cầm tay nổi bật với màn hình OLED 7 inch rực rỡ, hỗ trợ chế độ handheld, dock và tabletop – phù hợp cho cả chơi cá nhân lẫn nhóm.', 'Màn hình: OLED 7 inch, cảm ứng, Bộ nhớ trong: 64GB (hỗ trợ thẻ microSD), Kết nối: Wi-Fi, Bluetooth, HDMI (Dock), Thời lượng pin: 4.5 – 9 giờ, Cổng sạc: USB-C', 'https://youtu.be/RWvREo5K0sw', 'Tặng kèm game Mario Kart 8 (phiên bản bundle)', '12 tháng', 0.0, 0),
(54, 'Sony PlayStation 5 Digital Edition', 'Phiên bản PS5 không ổ đĩa, cho phép tải và chơi game kỹ thuật số với hiệu năng cực mạnh và trải nghiệm hình ảnh 4K.', 'CPU: AMD Ryzen Zen 2, 8 nhân, GPU: RDNA 2 (10.28 TFLOPs), RAM: 16GB GDDR6, SSD: 825GB, Hỗ trợ: Ray Tracing, 4K UHD, HDR', 'https://youtu.be/xBAQfdlgtHY', 'Giảm giá 1 triệu, tặng voucher PSN', '12 tháng chính hãng', 0.0, 0),
(55, 'Xbox Series S', 'Máy chơi game nhỏ gọn, giá rẻ hơn Series X, hỗ trợ chơi game thế hệ mới ở độ phân giải 1440p và 120FPS.', 'CPU: AMD Zen 2, 8 nhân, GPU: 4 TFLOPs, RAM: 10GB GDDR6, SSD: 512GB, Hỗ trợ: Ray Tracing, 1440p, 120Hz', 'https://youtu.be/2HnvmVtEqUg', 'Tặng gói Game Pass 3 tháng', '12 tháng', 0.0, 0),
(56, 'Tay cầm DualSense PS5', 'Tay cầm thế hệ mới của Sony với công nghệ Adaptive Trigger và Haptic Feedback mang đến trải nghiệm chân thực.', 'Kết nối: USB-C / Bluetooth, Hỗ trợ: PC, Android, PS5, Pin: 1560mAh (4–8 giờ)', '', 'Mua 2 giảm 10%', '6 tháng', 0.0, 0),
(57, 'Logitech G502 HERO', 'Chuột gaming có dây nổi tiếng với độ chính xác cao, cảm biến HERO lên đến 25.600 DPI, tùy chỉnh nhiều nút.', 'Kết nối: USB, DPI: 100 – 25.600, Nút: 11 nút lập trình, Tùy chỉnh trọng lượng', '', 'Giảm 20%', '24 tháng', 0.0, 0),
(58, 'Razer BlackWidow V3', 'Bàn phím cơ chuyên game với switch Razer Green clicky, đèn RGB sống động.', 'Kết nối: USB, Switch: Razer Green (clicky), Đèn: RGB Razer Chroma, Chất liệu: Nhôm – nhựa cao cấp', '', 'Giảm 15%', '24 tháng', 0.0, 0),
(59, 'Máy chơi game cầm tay Retroid Pocket 3+', 'Máy chơi game retro Android nhỏ gọn, chơi tốt giả lập PS1, PSP, N64 và Android apps.', 'Màn hình: 4.7\" IPS, 750p, Chip: Unisoc T618, RAM: 4GB, ROM: 128GB (mở rộng microSD), HĐH: Android 11', 'https://youtu.be/LoBh9LtUmFE', 'Tặng kèm thẻ nhớ 64GB', '12 tháng', 0.0, 0),
(60, 'Samsung Galaxy A55', 'Samsung Galaxy A55 là mẫu smartphone tầm trung cận cao cấp, kế thừa những điểm mạnh về thiết kế và camera của dòng A. Máy sở hữu thiết kế khung viền kim loại sang trọng, màn hình AMOLED tần số quét cao và khả năng kháng nước, bụi IP67.', 'Màn hình: Super AMOLED, 6.6 inch, Full HD+ (1080 x 2340 Pixels), tần số quét 120Hz. Chip: Exynos 1480. RAM: 8GB / 12GB. Bộ nhớ trong: 128GB / 256GB. Camera sau: Chính 50MP (OIS), Góc siêu rộng 12MP, Macro 5MP. Camera trước: 32MP. Pin: 5000 mAh, sạc nhanh 25W. Hệ điều hành: Android 14 với One UI 6.1. Tính năng khác: Kháng nước, bụi IP67.', 'https://youtu.be/NOMVB8qLRaA', 'Thường có chương trình trả góp 0%, giảm giá trực tiếp, tặng phiếu mua hàng hoặc voucher.', 'Chính hãng 12 tháng.', 0.0, 0),
(61, 'iPhone 13', 'iPhone 13 vẫn là một lựa chọn đáng giá trong phân khúc cận cao cấp, với thiết kế đẹp, chip A15 Bionic mạnh mẽ và hệ thống camera kép chất lượng. Mặc dù đã ra mắt được vài năm, hiệu năng của máy vẫn đáp ứng tốt các nhu cầu sử dụng hàng ngày và chơi game.', 'Màn hình: Super Retina XDR OLED, 6.1 inch, 1170 x 2532 Pixels, tần số quét 60Hz. Chip: Apple A15 Bionic. RAM: 4GB. Bộ nhớ trong: 128GB / 256GB / 512GB. Camera sau: Chính 12MP (OIS), Góc siêu rộng 12MP. Camera trước: 12MP. Pin: Khoảng 3240 mAh, sạc nhanh 20W. Hệ điều hành: iOS (có thể cập nhật lên phiên bản mới nhất). Tính năng khác: Kháng nước, bụi IP68, Face ID.', 'https://youtu.be/A7qIRbLj8bk', 'Thường có giảm giá sâu, trả góp 0%, hoặc tặng kèm phụ kiện cơ bản.', 'Chính hãng 12 tháng.', 0.0, 0),
(62, 'OPPO A58', 'OPPO A58 là mẫu smartphone phổ thông, hướng đến người dùng cơ bản với màn hình lớn, pin trâu và camera ổn định trong tầm giá. Máy có thiết kế trẻ trung, màu sắc đa dạng.', 'Màn hình: IPS LCD, 6.72 inch, Full HD+ (1080 x 2400 Pixels). Chip: MediaTek Helio G85. RAM: 6GB / 8GB. Bộ nhớ trong: 128GB. Camera sau: Chính 50MP, Xóa phông 2MP. Camera trước: 8MP. Pin: 5000 mAh, sạc nhanh SuperVOOC 33W. Hệ điều hành: Android 13 với ColorOS 13.1. Tính năng khác: Loa kép.', 'https://www.youtube.com/watch?v=e_c5faPCMOs', 'Thường có giảm giá tiền mặt, trả góp 0% hoặc tặng kèm sim data.', 'Chính hãng 12 tháng.', 0.0, 0),
(63, 'Xiaomi Redmi Note 13 Pro+ 5G', 'Xiaomi Redmi Note 13 Pro+ 5G là mẫu smartphone tầm trung cao cấp của Xiaomi, nổi bật với màn hình cong AMOLED 1.5K, camera 200MP chống rung OIS và công nghệ sạc siêu nhanh 120W.', 'Màn hình: AMOLED, 6.67 inch, 1.5K (1220 x 2712 Pixels), tần số quét 120Hz, độ sáng tối đa 1800 nits. Chip: MediaTek Dimensity 7200 Ultra. RAM: 8GB / 12GB. Bộ nhớ trong: 256GB / 512GB. Camera sau: Chính 200MP (OIS), Góc siêu rộng 8MP, Macro 2MP. Camera trước: 16MP. Pin: 5000 mAh, sạc nhanh 120W. Hệ điều hành: Android 13 với MIUI 14 (có thể cập nhật lên HyperOS). Tính năng khác: Kháng nước, bụi IP68, cảm biến vân tay dưới màn hình, loa kép.', '', 'Thường có ưu đãi trả góp 0%, giảm giá trực tiếp, tặng kèm tai nghe hoặc phiếu mua hàng.', 'Chính hãng 12 tháng.', 0.0, 0),
(64, 'Xiaomi Redmi 13C', 'Xiaomi Redmi 13C là mẫu điện thoại giá rẻ của Xiaomi, tập trung vào việc mang lại trải nghiệm màn hình lớn, pin \"trâu\" và hiệu năng ổn định cho các tác vụ cơ bản hàng ngày.', 'Màn hình: IPS LCD, 6.74 inch, HD+ (720 x 1600 Pixels), tần số quét 90Hz. Chip: MediaTek Helio G85. RAM: 4GB / 6GB / 8GB. Bộ nhớ trong: 128GB / 256GB. Camera sau: Chính 50MP, Macro 2MP, Xóa phông 2MP. Camera trước: 8MP. Pin: 5000 mAh, sạc nhanh 18W. Hệ điều hành: Android 13 với MIUI 14.', 'https://youtu.be/4ku0sxoJ4oo', 'Thường có giảm giá tiền mặt, tặng kèm sim data hoặc phiếu mua hàng.', 'Chính hãng 12 tháng.', 0.0, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` longtext NOT NULL,
  `balance` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `username`, `user_id`, `password`, `phone`, `address`, `email`, `balance`) VALUES
(9, 'admin456', 0, '$2y$10$DV6okW3Eyenk.3wX9iubLOMbYLuTr32fpxbzixEB7NRf3veGyzoN6', '0901359647', '432 Mai Chí Thọ', 'ngduckhanh2910@gmail.com', 0),
(11, 'khanh08', 0, '$2y$10$P1YLkQhWPY6gR3Y0VvpQEOsDB8SJvoSCy3Qhk/8frnXR3kbb5uqGK', '102', '412', '09015', 0),
(12, 'hai', 0, '$2y$10$fsObzNvfhPxHwUxtA0o4kOTQDwhGyG72cySjGCVhKRt5BggYPuCQu', '0255115661', 'p25', 'ajsdjw@gmail.com', 0),
(14, 'adminhai', 0, '$2y$10$6EZrlFmIWbiyxwA3lmdrlOR2drY1wwUqa1VDqDB2sl4rbDijbz0hG', '78878979', 'p25', 'qjsdjw@gmail.com', 0),
(16, 'adminhai1', 0, '$2y$10$GIqXCD0XHChW/ZRUchBWOeJluhy1Isc4Emaqsb8XAHMy5GwQEEo/a', '7887897934', 'p25', 'qjsdjw@gmail.com', 0),
(17, 'admin123', 0, '$2y$10$YZmhs0VOVF4F8Jhw3j9O9.0kk/A/PvjH5oqVFR2xeBtyur6D5mCBK', '89745', 'p24', 'ajdjw@gmail.com', 0),
(18, 'hai2', 0, '$2y$10$u0SwD3ZBV8Ogd5W3NMmuHuX2zTbsZtlquLAeMZI0HnP01EwVm5fkS', '0347389473', 'nguyễn gia trí', 'dasdsa23@gmail.com', 0);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `bien_the_san_pham`
--
ALTER TABLE `bien_the_san_pham`
  ADD PRIMARY KEY (`id_bien_the`),
  ADD UNIQUE KEY `ma_sku` (`ma_sku`),
  ADD KEY `id_san_pham` (`id_san_pham`);

--
-- Chỉ mục cho bảng `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  ADD PRIMARY KEY (`id_chi_tiet`),
  ADD KEY `id_don_hang` (`id_don_hang`);

--
-- Chỉ mục cho bảng `danh_gia_san_pham`
--
ALTER TABLE `danh_gia_san_pham`
  ADD PRIMARY KEY (`id_danh_gia`),
  ADD KEY `id_san_pham` (`id_san_pham`);

--
-- Chỉ mục cho bảng `don_hang`
--
ALTER TABLE `don_hang`
  ADD PRIMARY KEY (`id_don_hang`),
  ADD KEY `id_nguoi_dung` (`id_nguoi_dung`);

--
-- Chỉ mục cho bảng `gio_hang`
--
ALTER TABLE `gio_hang`
  ADD PRIMARY KEY (`id_gio_hang`),
  ADD KEY `id_nguoi_dung` (`id_nguoi_dung`),
  ADD KEY `id_san_pham` (`id_san_pham`),
  ADD KEY `id_bien_the` (`id_bien_the`);

--
-- Chỉ mục cho bảng `hinh_anh_san_pham`
--
ALTER TABLE `hinh_anh_san_pham`
  ADD PRIMARY KEY (`id_hinh_anh`),
  ADD KEY `id_san_pham` (`id_san_pham`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `san_pham`
--
ALTER TABLE `san_pham`
  ADD PRIMARY KEY (`id_san_pham`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `bien_the_san_pham`
--
ALTER TABLE `bien_the_san_pham`
  MODIFY `id_bien_the` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT cho bảng `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  MODIFY `id_chi_tiet` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT cho bảng `danh_gia_san_pham`
--
ALTER TABLE `danh_gia_san_pham`
  MODIFY `id_danh_gia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT cho bảng `don_hang`
--
ALTER TABLE `don_hang`
  MODIFY `id_don_hang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `gio_hang`
--
ALTER TABLE `gio_hang`
  MODIFY `id_gio_hang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `hinh_anh_san_pham`
--
ALTER TABLE `hinh_anh_san_pham`
  MODIFY `id_hinh_anh` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT cho bảng `san_pham`
--
ALTER TABLE `san_pham`
  MODIFY `id_san_pham` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `bien_the_san_pham`
--
ALTER TABLE `bien_the_san_pham`
  ADD CONSTRAINT `bien_the_san_pham_ibfk_1` FOREIGN KEY (`id_san_pham`) REFERENCES `san_pham` (`id_san_pham`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_1` FOREIGN KEY (`id_don_hang`) REFERENCES `don_hang` (`id_don_hang`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `danh_gia_san_pham`
--
ALTER TABLE `danh_gia_san_pham`
  ADD CONSTRAINT `danh_gia_san_pham_ibfk_1` FOREIGN KEY (`id_san_pham`) REFERENCES `san_pham` (`id_san_pham`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `don_hang`
--
ALTER TABLE `don_hang`
  ADD CONSTRAINT `don_hang_ibfk_1` FOREIGN KEY (`id_nguoi_dung`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `gio_hang`
--
ALTER TABLE `gio_hang`
  ADD CONSTRAINT `gio_hang_ibfk_1` FOREIGN KEY (`id_nguoi_dung`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `gio_hang_ibfk_2` FOREIGN KEY (`id_san_pham`) REFERENCES `san_pham` (`id_san_pham`) ON DELETE CASCADE,
  ADD CONSTRAINT `gio_hang_ibfk_3` FOREIGN KEY (`id_bien_the`) REFERENCES `bien_the_san_pham` (`id_bien_the`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `hinh_anh_san_pham`
--
ALTER TABLE `hinh_anh_san_pham`
  ADD CONSTRAINT `hinh_anh_san_pham_ibfk_1` FOREIGN KEY (`id_san_pham`) REFERENCES `san_pham` (`id_san_pham`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
