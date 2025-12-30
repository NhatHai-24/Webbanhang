-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 25, 2025 lúc 11:25 AM
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
(4, 4, 'Đen', NULL, 2800000.00, 40, 'TNROG-PELTA-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(5, 5, 'Đen', NULL, 1500000.00, 50, 'TNTUF-H3-DEN', '2025-06-21 10:53:44', '2025-11-24 15:39:48'),
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
(16, 15, 'Đỏ', NULL, 4000000.00, 43, 'LBJBL-CHARGE6-DO', '2025-06-21 10:53:44', '2025-11-23 11:48:49'),
(17, 16, 'Đen', NULL, 600000.00, 90, 'LBXM-POCKET-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(18, 17, 'Xanh', NULL, 800000.00, 74, 'LBREZO-E21-XANH', '2025-06-21 10:53:44', '2025-11-20 11:07:37'),
(19, 18, 'Đen', NULL, 1500000.00, 64, 'LBJBL-CLIP5-DEN', '2025-06-21 10:53:44', '2025-07-08 11:23:16'),
(20, 19, 'Đen', NULL, 900000.00, 49, 'LVT-ENKOR-E700-DEN', '2025-06-21 10:53:44', '2025-11-21 11:51:14'),
(21, 20, 'Đen', NULL, 3000000.00, 19, 'LBK-NANO-S820-DEN', '2025-06-21 10:53:44', '2025-11-20 11:19:31'),
(22, 21, 'Đen', NULL, 4000000.00, 50, 'TVXM-A32-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(23, 22, 'Đen', NULL, 8000000.00, 40, 'TVSS-CU8000-43-DEN', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(24, 23, 'Đen', NULL, 10000000.00, 5, 'TVTCL-55P635-DEN', '2025-06-21 10:53:44', '2025-11-23 11:48:52'),
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
(46, 45, 'Trắng', NULL, 400000.00, 78, 'DBH-DQLDL06-TRANG', '2025-06-21 10:53:44', '2025-11-21 11:51:14'),
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
(62, 57, 'Đen', NULL, 1000000.00, 58, 'CHL-G502-HERO-DEN', '2025-06-21 10:53:44', '2025-11-23 11:48:49'),
(63, 58, 'Đen', NULL, 2500000.00, 39, 'BPR-BWV3-DEN', '2025-06-21 10:53:44', '2025-11-20 11:56:59'),
(64, 58, 'Trắng', NULL, 2500000.00, 30, 'BPR-BWV3-TRANG', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(65, 59, 'Trắng', NULL, 3000000.00, 15, 'MCG-RETPK3P-TRANG', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(66, 59, 'Xanh mint', NULL, 3000000.00, 7, 'MCG-RETPK3P-XANH', '2025-06-21 10:53:44', '2025-11-20 11:20:06'),
(67, 60, 'Xanh Iceblue', '8GB RAM + 128GB ROM', 9000000.00, 70, 'SSA55-XB-128', '2025-06-21 10:53:44', '2025-11-30 10:03:01'),
(68, 60, 'Tím Lilac', '8GB RAM + 256GB ROM', 9500000.00, 59, 'SSA55-TL-256', '2025-06-21 10:53:44', '2025-07-10 09:05:23'),
(69, 60, 'Vàng Lemon', '12GB RAM + 256GB ROM', 10500000.00, 49, 'SSA55-VL-256', '2025-06-21 10:53:44', '2025-07-11 01:46:25'),
(70, 61, 'Xanh dương', '128GB', 15000000.00, 47, 'IP13-XD-128', '2025-06-21 10:53:44', '2025-11-27 07:03:08'),
(71, 61, 'Hồng', '256GB', 17000000.00, 39, 'IP13-HONG-256', '2025-06-21 10:53:44', '2025-07-11 00:08:06'),
(72, 61, 'Đen', '512GB', 19000000.00, 30, 'IP13-DEN-512', '2025-06-21 10:53:44', '2025-06-21 10:53:44'),
(73, 62, 'Đen', '6GB RAM + 128GB ROM', 4500000.00, 80, 'OPPO-A58-DEN-128-6G', '2025-06-21 10:53:45', '2025-06-21 10:53:45'),
(74, 62, 'Xanh lá', '8GB RAM + 128GB ROM', 4800000.00, 70, 'OPPO-A58-XANHLA-128-8G', '2025-06-21 10:53:45', '2025-06-21 10:53:45'),
(75, 63, 'Đen', '8GB RAM + 256GB ROM', 9500000.00, 53, 'RMN13PP-DEN-256-8G', '2025-06-21 10:53:45', '2025-06-27 10:27:14'),
(76, 63, 'Trắng', '12GB RAM + 512GB ROM', 10500000.00, 47, 'RMN13PP-TRANG-512-12G', '2025-06-21 10:53:45', '2025-06-26 11:05:48'),
(77, 64, 'Xanh lá', '4GB RAM + 128GB ROM', 3000000.00, 99, 'RM13C-XANHLA-128-4G', '2025-06-21 10:53:45', '2025-11-25 08:34:29'),
(78, 64, 'Đen', '6GB RAM + 128GB ROM', 3300000.00, 90, 'RM13C-DEN-128-6G', '2025-06-21 10:53:45', '2025-06-21 10:53:45'),
(79, 64, 'Xanh dương', '8GB RAM + 256GB ROM', 3800000.00, 70, 'RM13C-XANHDUONG-256-8G', '2025-06-21 10:53:45', '2025-06-21 10:53:45'),
(86, 71, 'Đen', NULL, 5000000.00, 47, NULL, '2025-11-25 07:32:50', '2025-11-27 07:03:08'),
(87, 75, 'Đen', '64GB', 8990000.00, 50, 'IP11-64-BLK', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(88, 76, 'Xanh dương', '128GB', 11990000.00, 40, 'IP12-128-BLU', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(89, 77, 'Tím', '128GB', 16990000.00, 30, 'IP14P-128-PUR', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(90, 78, 'Xanh Mint', '8GB/128GB', 10990000.00, 25, 'S23FE-GRN', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(91, 79, 'Kem', '256GB', 18990000.00, 20, 'ZFLIP5-CRM', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(92, 80, 'Xanh Icy', '256GB', 29990000.00, 10, 'ZFOLD5-BLU', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(93, 81, 'Đen', '8GB/256GB', 6490000.00, 100, 'RMN13P-BLK', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(94, 82, 'Xanh Tuyết', '12GB/256GB', 10990000.00, 40, 'MI13T-BLU', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(95, 83, 'Bạc', '8GB/256GB', 9490000.00, 50, 'RENO10-SLV', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(96, 84, 'Vàng', '256GB', 22990000.00, 15, 'FINDN3F-GLD', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(97, 85, 'Trắng Huy Hiệu', '12GB/256GB', 8990000.00, 30, 'R11PRO-WHT', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(98, 86, 'Xanh Sông Băng', '8GB/256GB', 7990000.00, 20, 'VIVOV29E-BLU', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(99, 87, 'Đen', '16GB/512GB', 24990000.00, 10, 'ROG7-BLK', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(100, 88, 'Trắng', '128GB', 12990000.00, 15, 'PIXEL7P-WHT', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(101, 89, 'Hồng', '128GB', 15990000.00, 10, 'PIXEL8-PNK', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(102, 90, 'Bạc', '8GB/128GB', 6990000.00, 80, 'A34-SLV', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(103, 91, 'Xanh Lime', '8GB/128GB', 7990000.00, 70, 'A54-LIM', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(104, 92, 'Hồng', '128GB', 19990000.00, 40, 'IP15-PNK', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(105, 93, 'Vàng', '128GB', 22990000.00, 35, 'IP15P-YEL', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(106, 94, 'Vàng', '8GB/256GB', 8490000.00, 60, 'POCOX6P-YEL', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(107, 95, 'Vàng', '8GB/256GB', 18490000.00, 100, 'MBA-M1-GLD', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(108, 96, 'Space Black', 'M3/8GB/512GB', 39990000.00, 20, 'MBP14-M3-BLK', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(109, 97, 'Xanh', 'Ultra 5/16GB', 23990000.00, 15, 'ZEN14-OLED', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(110, 98, 'Đen', 'i5/8GB', 12990000.00, 50, 'INS3520-BLK', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(111, 99, 'Bạc', 'i5/16GB', 16490000.00, 30, 'PAV15-SLV', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(112, 100, 'Đen', 'i5/RTX3050', 19990000.00, 40, 'NITRO5-TIGER', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(113, 101, 'Đen', 'i7/RTX4050', 26990000.00, 25, 'KATANA15', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(114, 102, 'Xám', 'R7/3050Ti', 21990000.00, 30, 'LEGION5-GRY', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(115, 103, 'Xám', 'R5/8GB', 13490000.00, 40, 'TB14-GRY', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(116, 104, 'Trắng', 'i7/16GB', 29990000.00, 10, 'GRAM14-WHT', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(117, 105, 'Sapphire', 'i5/8GB', 24990000.00, 15, 'SFPRO9-BLU', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(118, 106, 'Platinum', 'i5/8GB', 23990000.00, 12, 'SFLAP5-SLV', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(119, 107, 'Đen', 'i5/RTX4050', 20990000.00, 45, 'G5-MF', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(120, 108, 'Xám', 'i3/8GB', 9990000.00, 60, 'VOS3520', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(121, 109, 'Xanh Đậm', 'R5/3050', 17990000.00, 35, 'VICTUS16-BLU', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(122, 110, 'Bạc', 'i5/8GB', 14990000.00, 40, 'SWIFT3-SLV', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(123, 111, 'Đen', 'R5/OLED', 13990000.00, 50, 'VIVO15-BLK', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(124, 112, 'Đen', 'i3/8GB', 8990000.00, 80, 'MODERN14-BLK', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(125, 113, 'Midnight', 'M2/8GB', 27990000.00, 20, 'MBA15-MID', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(126, 114, 'Đen', 'i7/RTX4060', 35990000.00, 15, 'HELIOS-NEO', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(127, 115, 'Xám', '64GB WiFi', 6990000.00, 150, 'IPAD9-GRY', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(128, 116, 'Xanh', '64GB WiFi', 9990000.00, 80, 'IPAD10-BLU', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(129, 117, 'Xám', '128GB WiFi', 19990000.00, 30, 'IPADPRO11-M2', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(130, 118, 'Beige', '128GB WiFi', 16990000.00, 25, 'TABS9-BGE', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(131, 119, 'Xanh Mint', '128GB WiFi', 8990000.00, 40, 'TABS9FE-GRN', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(132, 120, 'Vàng', '8GB/128GB', 7990000.00, 60, 'PAD6-GLD', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(133, 121, 'Xám', '4GB/64GB', 3990000.00, 50, 'TABM10-GRY', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(134, 122, 'Tím', '4GB/64GB', 4990000.00, 35, 'PADAIR-PUR', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(135, 123, 'Starlight', '40mm GPS', 5990000.00, 70, 'AWSE-STAR', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(136, 124, 'Titan', 'Dây Alpine', 19990000.00, 15, 'AWU2-ALP', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(137, 125, 'Đen', '43mm BT', 6490000.00, 30, 'GW6CL-BLK', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(138, 126, 'Vàng', '40mm BT', 4990000.00, 40, 'GW6-GLD', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(139, 127, 'Đen', '46mm', 10990000.00, 15, 'FR265-BLK', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(140, 128, 'Trắng', '45mm', 10490000.00, 20, 'VENU3-WHT', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(141, 129, 'Đen', 'Bluetooth', 3990000.00, 35, 'MIWATCH2', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(142, 130, 'Xanh', '46mm', 5490000.00, 45, 'GT4-GRN', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(143, 131, 'Nâu', 'Da', 4290000.00, 40, 'GTR4-BRN', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(144, 132, 'Đen', 'Dây từ', 1290000.00, 60, 'KRPRO-BLK', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(145, 133, 'Đen', 'Silicone', 890000.00, 200, 'MIBAND8', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(146, 134, 'Hồng', 'Silicone', 890000.00, 100, 'HUAWEIB9-PNK', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(147, 135, 'Trắng', 'Lightning', 2690000.00, 500, 'AP2', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(148, 136, 'Trắng', 'Lightning', 3990000.00, 200, 'AP3', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(149, 137, 'Trắng', 'USB-C', 5990000.00, 250, 'APPRO2-C', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(150, 138, 'Tím', 'Bora Purple', 2990000.00, 80, 'BUDS2P-PUR', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(151, 139, 'Đen', 'ANC', 6490000.00, 40, 'WF1000XM5', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(152, 140, 'Xanh', 'Không dây', 1190000.00, 60, 'CH520-BLU', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(153, 141, 'Vàng', 'Gold', 5990000.00, 20, 'TOURPRO2', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(154, 142, 'Đỏ', 'Bluetooth', 2590000.00, 100, 'FLIP6-RED', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(155, 143, 'Rằn ri', 'Camo', 3690000.00, 80, 'CHARGE5-CAMO', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(156, 144, 'Đen', 'Kèm Mic', 7990000.00, 30, 'ENCORE', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(157, 145, 'Đen', 'Vàng đồng', 3990000.00, 50, 'EMBER2-BLK', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(158, 146, 'Kem', 'Cream', 2690000.00, 70, 'WILLEN-CRM', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(159, 147, 'Nâu', 'Bluetooth', 6990000.00, 60, 'ACTON3-BRN', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(160, 148, 'Xám', 'Bluetooth', 4990000.00, 40, 'ONYX7-GRY', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(161, 149, 'Đen', 'Bluetooth', 7490000.00, 25, 'GOPLAY3-BLK', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(162, 150, 'Cam', 'Bluetooth', 1290000.00, 50, 'XB100-ORG', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(163, 151, 'Đen', 'Soundbar', 2990000.00, 30, 'HWC450', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(164, 152, 'Đỏ Đen', 'Có dây', 1890000.00, 100, 'CLOUD2-RED', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(165, 153, 'Đen', 'Wireless', 5490000.00, 20, 'GPROX2', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(166, 154, 'Xanh', 'Có dây', 1290000.00, 60, 'BLACKSHARKV2X', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(167, 155, 'Đen', 'USB', 399000.00, 500, 'G102-BLK', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(168, 156, 'Trắng', 'Wireless', 799000.00, 250, 'G304-WHT', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(169, 157, 'Đen', 'USB', 599000.00, 150, 'VIPERMINI', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(170, 158, 'Hồng', 'Akko Switch', 1690000.00, 50, '3098B-PNK', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(171, 159, 'Nhôm', 'Red Switch', 2490000.00, 40, 'K2PRO-RED', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(172, 160, 'Xanh', 'Bluetooth', 599000.00, 200, 'K380-BLU', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(173, 161, 'Trắng', '20W', 250000.00, 300, 'ANKER20W', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(174, 162, 'Đen', '65W', 690000.00, 100, 'UGREEN65W', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(175, 163, 'Trắng', '20000mAh', 450000.00, 150, 'MI20K', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(176, 164, 'Đen', 'MagSafe', 1190000.00, 50, 'ANKERMAG10K', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(177, 165, 'Đen', '720p', 550000.00, 100, 'C270', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(178, 166, 'Trắng', 'PS5', 1690000.00, 80, 'DUALSENSE', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(179, 167, 'Đen', '27 inch', 5490000.00, 40, 'ODYSSEYG5', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(180, 168, 'Đen', '24 inch', 4990000.00, 30, 'PA248QV', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(181, 169, 'Bạc', '24 inch', 5290000.00, 50, 'U2422H', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(182, 170, 'Đen', '16GB', 1290000.00, 100, 'VENGRS16', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(183, 171, 'Đen', '500GB', 990000.00, 150, 'NV2-500', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(184, 172, 'Xanh', 'CPU', 2990000.00, 100, 'I5-12400F', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(185, 173, 'Đen', 'VGA', 7490000.00, 50, '3060DUAL', '2025-12-25 10:21:39', '2025-12-25 10:21:39'),
(186, 174, 'Trắng', 'TV Box', 1190000.00, 40, 'CHROMECAST4K', '2025-12-25 10:21:39', '2025-12-25 10:21:39');

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
(19, 15, 14, 15, 2, 1200000.00, 'Loa Bluetooth JBL Go 4', 'Đen'),
(20, 16, 19, 20, 1, 900000.00, 'Loa vi tính Bluetooth Enkor E700 Đen', 'Đen'),
(21, 16, 45, 46, 1, 400000.00, 'Đèn bàn học Điện Quang ĐQ LDL06', 'Trắng'),
(25, 19, 64, 77, 1, 3000000.00, 'Xiaomi Redmi 13C', 'Xanh lá - 4GB RAM + 128GB ROM'),
(26, 20, 71, 86, 1, 5000000.00, 'Máy Chơi Game PS4', 'Đen'),
(27, 21, 71, 86, 1, 5000000.00, 'Máy Chơi Game PS4', 'Đen'),
(28, 22, 71, 86, 1, 5000000.00, 'Máy Chơi Game PS4', 'Đen'),
(29, 22, 61, 70, 1, 15000000.00, 'iPhone 13', 'Xanh dương - 128GB');

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
(15, 12, '2025-11-21 12:08:09', 3150000.00, 'hai', '0255115661', 'p25', 'COD', 'Cho_xac_nhan'),
(16, 12, '2025-11-21 18:51:14', 1300000.00, 'hai', '0255115661', 'nguyễn gia trí', 'COD', 'Da_giao'),
(19, 12, '2025-11-25 15:34:29', 3000000.00, 'hai', '0255115661', 'p25', 'BANK', 'Da_giao'),
(20, 12, '2025-11-25 18:08:28', 5000000.00, 'hai', '0255115661', 'p25', 'COD', 'Cho_xac_nhan'),
(21, 12, '2025-11-27 13:27:56', 5000000.00, 'Lê Nhật Hải', '0347389473', 'nguyễn gia trí, p25, Bình Thạnh', 'COD', 'Cho_xac_nhan'),
(22, 12, '2025-11-27 14:03:08', 29000000.00, 'Lê Nhật Hải', '0347389473', 'nguyễn gia trí, p25, Bình Thạnh', 'COD', 'Dang_giao');

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
(64, 64, 'https://cdn.tgdd.vn/Products/Images/42/316771/xiaomi-redmi-13c-xanh-1-1-750x500.jpg', 1, 0, '2025-06-21 10:53:45'),
(71, 71, '../admin/uploads/img_69255ba22672d.jpg', 1, 0, '2025-11-25 07:32:50'),
(72, 75, 'https://cdn.tgdd.vn/Products/Images/42/153856/iphone-11-trang-1-1-1-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(73, 76, 'https://cdn.tgdd.vn/Products/Images/42/213031/iphone-12-xanh-duong-new-2-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(74, 77, 'https://cdn.tgdd.vn/Products/Images/42/289691/iphone-14-plus-tim-thumbnew-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(75, 78, 'https://cdn.tgdd.vn/Products/Images/42/306994/samsung-galaxy-s23-fe-xanh-mint-thumbnew-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(76, 79, 'https://cdn.tgdd.vn/Products/Images/42/299250/samsung-galaxy-z-flip5-kem-thumbnew-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(77, 80, 'https://cdn.tgdd.vn/Products/Images/42/299253/samsung-galaxy-z-fold5-xanh-icy-thumbnew-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(78, 81, 'https://cdn.tgdd.vn/Products/Images/42/319665/xiaomi-redmi-note-13-pro-den-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(79, 82, 'https://cdn.tgdd.vn/Products/Images/42/309816/xiaomi-13t-xanh-duong-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(80, 83, 'https://cdn.tgdd.vn/Products/Images/42/306997/oppo-reno10-bac-thumbnew-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(81, 84, 'https://cdn.tgdd.vn/Products/Images/42/313084/oppo-find-n3-flip-vang-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(82, 85, 'https://cdn.tgdd.vn/Products/Images/42/306991/realme-11-pro-plus-trang-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(83, 86, 'https://cdn.tgdd.vn/Products/Images/42/313437/vivo-v29e-xanh-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(84, 87, 'https://cdn.tgdd.vn/Products/Images/42/306899/asus-rog-phone-7-den-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(85, 88, 'https://cdn.tgdd.vn/Products/Images/42/294697/google-pixel-7-pro-trang-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(86, 89, 'https://cdn.tgdd.vn/Products/Images/42/316937/google-pixel-8-hong-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(87, 90, 'https://cdn.tgdd.vn/Products/Images/42/298377/samsung-galaxy-a34-bac-thumbnew-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(88, 91, 'https://cdn.tgdd.vn/Products/Images/42/251856/samsung-galaxy-a54-5g-xanh-thumb-1-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(89, 92, 'https://cdn.tgdd.vn/Products/Images/42/281570/iphone-15-hong-thumb-1-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(90, 93, 'https://cdn.tgdd.vn/Products/Images/42/303891/iphone-15-plus-vang-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(91, 94, 'https://cdn.tgdd.vn/Products/Images/42/320857/xiaomi-poco-x6-pro-vang-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(92, 95, 'https://cdn.tgdd.vn/Products/Images/44/231244/macbook-air-m1-2020-gold-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(93, 96, 'https://cdn.tgdd.vn/Products/Images/44/318225/macbook-pro-14-inch-m3-2023-den-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(94, 97, 'https://cdn.tgdd.vn/Products/Images/44/321453/asus-zenbook-14-oled-ux3405ma-ultra-5-pp151w-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(95, 98, 'https://cdn.tgdd.vn/Products/Images/44/291617/dell-inspiron-15-3520-i5-n5i5122w1-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(96, 99, 'https://cdn.tgdd.vn/Products/Images/44/287768/hp-pavilion-15-eg2035tx-i5-6k781pa-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(97, 100, 'https://cdn.tgdd.vn/Products/Images/44/278559/acer-nitro-5-tiger-an515-58-52sp-i5-nhqfhsv001-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(98, 101, 'https://cdn.tgdd.vn/Products/Images/44/303498/msi-katana-15-b13vfk-i7-672vn-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(99, 102, 'https://cdn.tgdd.vn/Products/Images/44/268345/lenovo-legion-5-15ach6-r7-82jw00klvn-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(100, 103, 'https://cdn.tgdd.vn/Products/Images/44/298410/lenovo-thinkbook-14-g3-acl-r5-21a200r0vn-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(101, 104, 'https://cdn.tgdd.vn/Products/Images/44/305562/lg-gram-2023-14z90r-gah53a5-i5-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(102, 105, 'https://cdn.tgdd.vn/Products/Images/44/297298/surface-pro-9-i5-16gb-256gb-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(103, 106, 'https://cdn.tgdd.vn/Products/Images/44/303423/surface-laptop-5-i5-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(104, 107, 'https://cdn.tgdd.vn/Products/Images/44/303445/gigabyte-gaming-g5-mf-i5-f2vn333sh-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(105, 108, 'https://cdn.tgdd.vn/Products/Images/44/299645/dell-vostro-3520-i3-v5i3614w1-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(106, 109, 'https://cdn.tgdd.vn/Products/Images/44/282245/hp-victus-16-e1106ax-r5-7c0t3pa-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(107, 110, 'https://cdn.tgdd.vn/Products/Images/44/289895/acer-swift-3-sf314-512-56qn-i5-nxk0fsv002-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(108, 111, 'https://cdn.tgdd.vn/Products/Images/44/304724/asus-vivobook-15-oled-a1505va-i5-l1052w-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(109, 112, 'https://cdn.tgdd.vn/Products/Images/44/305370/msi-modern-14-c11m-i3-011vn-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(110, 113, 'https://cdn.tgdd.vn/Products/Images/44/307409/macbook-air-15-inch-m2-2023-midnight-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(111, 114, 'https://cdn.tgdd.vn/Products/Images/44/304470/acer-predator-helios-neo-phn16-71-7460-i7-nhqlusv004-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(112, 115, 'https://cdn.tgdd.vn/Products/Images/522/247517/ipad-gen-9-wifi-grey-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(113, 116, 'https://cdn.tgdd.vn/Products/Images/522/294103/ipad-gen-10-wifi-xanh-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(114, 117, 'https://cdn.tgdd.vn/Products/Images/522/295252/ipad-pro-m2-11-inch-wifi-xam-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(115, 118, 'https://cdn.tgdd.vn/Products/Images/522/308479/samsung-galaxy-tab-s9-wifi-kem-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(116, 119, 'https://cdn.tgdd.vn/Products/Images/522/315998/samsung-galaxy-tab-s9-fe-wifi-xanh-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(117, 120, 'https://cdn.tgdd.vn/Products/Images/522/305597/xiaomi-pad-6-vang-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(118, 121, 'https://cdn.tgdd.vn/Products/Images/522/285226/lenovo-tab-m10-gen-3-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(119, 122, 'https://cdn.tgdd.vn/Products/Images/522/286071/oppo-pad-air-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(120, 123, 'https://cdn.tgdd.vn/Products/Images/7077/314766/apple-watch-se-2023-gps-40mm-vien-nhom-day-silicone-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(121, 124, 'https://cdn.tgdd.vn/Products/Images/7077/314789/apple-watch-ultra-2-gps-cellular-49mm-vien-titanium-day-alpine-loop-co-vua-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(122, 125, 'https://cdn.tgdd.vn/Products/Images/7077/308412/samsung-galaxy-watch6-classic-43mm-den-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(123, 126, 'https://cdn.tgdd.vn/Products/Images/7077/308405/samsung-galaxy-watch6-40mm-vang-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(124, 127, 'https://cdn.tgdd.vn/Products/Images/7077/303960/garmin-forerunner-265-music-day-silicone-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(125, 128, 'https://cdn.tgdd.vn/Products/Images/7077/313838/garmin-venu-3-day-silicone-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(126, 129, 'https://cdn.tgdd.vn/Products/Images/7077/322883/xiaomi-watch-2-den-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(127, 130, 'https://cdn.tgdd.vn/Products/Images/7077/315183/huawei-watch-gt-4-46mm-day-cao-su-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(128, 131, 'https://cdn.tgdd.vn/Products/Images/7077/290356/amazfit-gtr-4-46mm-thumb-1-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(129, 132, 'https://cdn.tgdd.vn/Products/Images/7077/304381/kieslect-kr-pro-day-tu-tinh-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(130, 133, 'https://cdn.tgdd.vn/Products/Images/7077/316008/mi-band-8-den-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(131, 134, 'https://cdn.tgdd.vn/Products/Images/7077/323869/huawei-band-9-hong-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(132, 135, 'https://cdn.tgdd.vn/Products/Images/54/236016/bluetooth-airpods-2-apple-mv7n2-imei-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(133, 136, 'https://cdn.tgdd.vn/Products/Images/54/250701/airpods-3-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(134, 137, 'https://cdn.tgdd.vn/Products/Images/54/314811/airpods-pro-2-usb-c-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(135, 138, 'https://cdn.tgdd.vn/Products/Images/54/286236/tai-nghe-bluetooth-true-wireless-samsung-galaxy-buds-2-pro-r510n-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(136, 139, 'https://cdn.tgdd.vn/Products/Images/54/309664/sony-wf-1000xm5-den-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(137, 140, 'https://cdn.tgdd.vn/Products/Images/54/304494/tai-nghe-chup-tai-bluetooth-sony-wh-ch520-xanh-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(138, 141, 'https://cdn.tgdd.vn/Products/Images/54/312521/tai-nghe-bluetooth-true-wireless-jbl-tour-pro-2-vang-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(139, 142, 'https://cdn.tgdd.vn/Products/Images/2162/255677/loa-bluetooth-jbl-flip-6-do-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(140, 143, 'https://cdn.tgdd.vn/Products/Images/2162/249911/loa-bluetooth-jbl-charge-5-ran-ri-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(141, 144, 'https://cdn.tgdd.vn/Products/Images/2162/285854/loa-bluetooth-jbl-partybox-encore-2-mic-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(142, 145, 'https://cdn.tgdd.vn/Products/Images/2162/288543/loa-bluetooth-marshall-emberton-ii-den-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(143, 146, 'https://cdn.tgdd.vn/Products/Images/2162/288540/loa-bluetooth-marshall-willen-kem-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(144, 147, 'https://cdn.tgdd.vn/Products/Images/2162/288541/loa-bluetooth-marshall-acton-iii-nau-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(145, 148, 'https://cdn.tgdd.vn/Products/Images/2162/236056/loa-bluetooth-harman-kardon-onyx-studio-7-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(146, 149, 'https://cdn.tgdd.vn/Products/Images/2162/313426/loa-bluetooth-harman-kardon-go-play-3-den-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(147, 150, 'https://cdn.tgdd.vn/Products/Images/2162/309653/loa-bluetooth-sony-srs-xb100-cam-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(148, 151, 'https://cdn.tgdd.vn/Products/Images/7264/305214/loa-thanh-samsung-hw-c450-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(149, 152, 'https://cdn.tgdd.vn/Products/Images/54/293290/tai-nghe-co-day-gaming-hyperx-cloud-ii-do-den-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(150, 153, 'https://cdn.tgdd.vn/Products/Images/54/309252/tai-nghe-chup-tai-gaming-logitech-pro-x-2-lightspeed-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(151, 154, 'https://cdn.tgdd.vn/Products/Images/54/285514/tai-nghe-chup-tai-gaming-razer-blackshark-v2-x-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(152, 155, 'https://cdn.tgdd.vn/Products/Images/86/160100/chuot-gaming-logitech-g102-den-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(153, 156, 'https://cdn.tgdd.vn/Products/Images/86/186596/chuot-khong-day-gaming-logitech-g304-trang-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(154, 157, 'https://cdn.tgdd.vn/Products/Images/86/226164/chuot-gaming-razer-viper-mini-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(155, 158, 'https://cdn.tgdd.vn/Products/Images/4547/313171/ban-phim-co-khong-day-akko-3098b-multi-mode-black-pink-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(156, 159, 'https://cdn.tgdd.vn/Products/Images/4547/308197/ban-phim-co-khong-day-keychron-k2-pro-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(157, 160, 'https://cdn.tgdd.vn/Products/Images/4547/166016/ban-phim-bluetooth-logitech-k380-xanh-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(158, 161, 'https://cdn.tgdd.vn/Products/Images/58/314486/adapter-sac-type-c-20w-anker-nano-3-a2147-trang-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(159, 162, 'https://cdn.tgdd.vn/Products/Images/58/308272/adapter-sac-3-cong-gan-65w-ugreen-nexode-10335-den-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(160, 163, 'https://cdn.tgdd.vn/Products/Images/57/237699/pin-sac-du-phong-20000mah-type-c-pd-qc30-xiaomi-3-pro-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(161, 164, 'https://cdn.tgdd.vn/Products/Images/57/314227/pin-sac-du-phong-khong-day-tich-hop-chan-de-10000mah-magnetic-anker-maggo-a1652-den-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(162, 165, 'https://cdn.tgdd.vn/Products/Images/4729/236025/webcam-720p-logitech-c270-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(163, 166, 'https://cdn.tgdd.vn/Products/Images/200010/256950/tay-cam-choi-game-khong-day-dualsense-ps5-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(164, 167, 'https://cdn.tgdd.vn/Products/Images/5697/233044/samsung-lc27g55tq-27-inch-2k-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(165, 168, 'https://cdn.tgdd.vn/Products/Images/5697/233036/asus-proart-pa248qv-24-1-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(166, 169, 'https://cdn.tgdd.vn/Products/Images/5697/244304/dell-ultrasharp-u2422h-238-inch-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(167, 170, 'https://cdn.tgdd.vn/Products/Images/8686/260742/ram-desktop-corsair-vengeance-rgb-rs-16gb-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(168, 171, 'https://cdn.tgdd.vn/Products/Images/8687/294285/o-cung-ssd-500gb-nvme-pcie-gen-40-x4-kingston-nv2-snv2s500g-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(169, 172, 'https://cdn.tgdd.vn/Products/Images/8689/265330/cpu-intel-core-i5-12400f-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(170, 173, 'https://cdn.tgdd.vn/Products/Images/8692/236081/vga-asus-dual-geforce-rtx-3060-v2-oc-edition-12gb-gddr6-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39'),
(171, 174, 'https://cdn.tgdd.vn/Products/Images/9344/228795/google-chromecast-with-google-tv-trang-thumb-600x600.jpg', 1, 0, '2025-12-25 10:21:39');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `san_pham`
--

CREATE TABLE `san_pham` (
  `id_san_pham` int(11) NOT NULL,
  `ten_san_pham` varchar(255) NOT NULL,
  `loai_san_pham` varchar(100) DEFAULT NULL,
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

INSERT INTO `san_pham` (`id_san_pham`, `ten_san_pham`, `loai_san_pham`, `mo_ta`, `thong_so_ky_thuat`, `video_gioi_thieu`, `chuong_trinh_khuyen_mai`, `bao_hanh`, `diem_danh_gia_trung_binh`, `tong_so_luot_danh_gia`) VALUES
(1, 'Tai nghe Bluetooh Sudio A1', 'Tai nghe', 'Sản xuất tại: Trung Quốc', 'Bộ sản phẩm gồm: 01 Đôi tai nghe, 01 Hộp sạc, 01 Dây sạc type-C, Sách HDSD.', 'https://youtu.be/W21SWN5DMT0', NULL, '12 tháng', 0.0, 0),
(2, 'Tai Nghe Bluetooth Chụp Tai cao cấp MS-B2', 'Tai nghe', 'Xuất xứ: Trung Quốc', 'Kích thước: 197x185x76mm, Kết nối: Bluetooth 5.0 & Dây headphone 3,5mm, Dung lượng pin: 400mAh', NULL, NULL, '12 tháng', 0.0, 0),
(4, 'Tai nghe Bluetooth Chụp Tai Gaming Asus ROG PELTA', 'Tai nghe', 'Xuất xứ: Đài Loan', 'Âm thanh nổi, Driver 50 mm, Jack cắm: Type C, Công nghệ kết nối: 2.4 GHz Bluetooth, Kích thước: Dài 16.94 cm - Rộng 9.3 cm - Cao 22.32 cm, Khối lượng: 309 g', 'https://youtu.be/nYknJbqvCK8', NULL, '24 tháng', 0.0, 0),
(5, 'Tai nghe Chụp Tai Gaming Asus TUF H3', 'Tai nghe', 'Sản xuất tại: Trung Quốc', 'Công nghệ âm thanh: Driver 50 mm, Âm thanh vòm 7.1, Tương thích: macOS, Android, Xbox 1, PS4, Máy chơi game Nintendo Switch, Windows, Jack cắm: 3.5 mm, Độ dài dây: 1.3 m, Tiện ích: Có mic thoại, Kết nối cùng lúc: 1 thiết bị, Điều khiển: Bánh xe lăn, Phím điều khiển: Tăng/giảm âm lượng, Kích thước: Dài 10 cm - Rộng 8 cm - Cao 4 cm, Khối lượng: 294 g', 'https://youtu.be/H1FM6WmeR7M', NULL, '24 tháng', 0.0, 0),
(6, 'Tai nghe Có dây Gaming HP HyperX Cloud Earbuds II', 'Tai nghe', 'Thương hiệu của: Mỹ, Sản xuất tại: Trung Quốc', 'Driver 14 mm, Tương thích: macOS, Android, iOS, Windows, Jack cắm: 3.5 mm, Độ dài dây: 1.2 m, Tiện ích: Có mic thoại, Kết nối cùng lúc: 1 thiết bị, Điều khiển: Phím nhấn, Phím điều khiển: Phát/dừng chơi nhạc, Nhận/Ngắt cuộc gọi, Khối lượng: 18 g', NULL, NULL, '12 tháng', 0.0, 0),
(7, 'Tai nghe Bluetooth Chụp Tai Gaming Sony INZONE H9 WH-G900N', 'Tai nghe', 'Thương hiệu của: Nhật Bản, Sản xuất tại: Việt Nam', 'Thời lượng pin tai nghe: Dùng 32 giờ - Sạc 3.5 giờ, Cổng sạc: Type-C, Công nghệ âm thanh: Âm thanh môi trường, Công nghệ ENC, 360 Spatial Sound, Driver 40 mm, Tương thích: macOS, ChromeOS, PS5, Android, iOS, Windows, Ứng dụng kết nối: PC INZONE Hub, Jack cắm: Type C, Tiện ích: Micro Boom, Game Mode, Có mic thoại, Sạc nhanh, Chống ồn, Kết nối cùng lúc: 1 thiết bị, Công nghệ kết nối: Bộ thu phát USB, Bluetooth 5.0, Điều khiển: Phím nhấn, Bánh xe lăn, Phím điều khiển: Tăng/giảm âm lượng, Kết nối Bluetooth, Chuyển chế độ, Bật/tắt nguồn, Kích thước: Dài 29.46 cm - Rộng 28.95 cm - Cao 10.67 cm, Khối lượng: 330g (Trắng); 335g (Đen)', 'https://youtu.be/7l68rPeO_4w', NULL, '12 tháng', 0.0, 0),
(8, 'Tai nghe Bluetooth Chụp Tai Gaming Logitech G435', 'Tai nghe', 'Thương hiệu của: Thụy Sỹ, Sản xuất tại: Trung Quốc', 'Thời lượng pin tai nghe: Dùng 18 giờ - Sạc 2 giờ, Cổng sạc: Type-C, Công nghệ âm thanh: Driver 40 mm, Tương thích: PC, Mac, Các thiết bị có hỗ trợ Bluetooth, PlayStation 4, PlayStation 5, Nintendo Switch, Tiện ích: Có mic thoại, Sạc nhanh, Kết nối cùng lúc: 1 thiết bị, Công nghệ kết nối: LIGHTSPEED USB, Bluetooth, Điều khiển: Phím nhấn, Phím điều khiển: Tăng/giảm âm lượng, Nút tắt tiếng, Kết nối Bluetooth, Bật/tắt nguồn, Khối lượng: 165 g', NULL, NULL, '12 tháng', 0.0, 0),
(9, 'Tai nghe Bluetooth Chụp Tai Gaming Logitech Pro X 2', 'Tai nghe', 'Thương hiệu của: Thụy Sỹ, Sản xuất tại: Trung Quốc', 'Thời lượng pin tai nghe: Dùng 50 giờ - Sạc 4 giờ, Cổng sạc: Type-C, Công nghệ âm thanh: Driver 50 mm, Tương thích: macOS, PlayStation 4, PlayStation 5, Windows, Jack cắm: 3.5 mm, Độ dài dây: 1.8 m, Tiện ích: Có mic thoại, Sạc nhanh, Kết nối cùng lúc: 1 thiết bị, Công nghệ kết nối: LIGHTSPEED USB, Bluetooth, Điều khiển: Phím nhấn, Bánh xe lăn, Phím điều khiển: Tăng/giảm âm lượng, Kết nối Bluetooth, Bật/Tắt Mic, Kích thước: Dài 9.5 cm - Rộng 17.6 cm - Cao 18.9 cm, Khối lượng: 345 g', 'https://youtu.be/DLDXvkzH7tQ', NULL, '12 tháng', 0.0, 0),
(10, 'Tai nghe Bluetooth Chụp Tai Gaming Asus ROG Delta II', 'Tai nghe', 'Thương hiệu của: Đài Loan, Sản xuất tại: Trung Quốc', 'Thời lượng pin tai nghe: Dùng 110 giờ - Sạc 2 giờ, Cổng sạc: Type-C, Công nghệ âm thanh: Âm thanh nổi, Công nghệ không dây ROG SpeedNova, Công nghệ DualFlow Audio, Driver 50 mm, Tương thích: Xbox, PC, macOS, PlayStation 4, PlayStation 5, Nintendo Switch, Android, iOS, iPadOS (iPad), Jack cắm: 3.5 mm, Độ dài dây: 2 m, Tiện ích: Micro Boom, Có đèn RGB, Có mic thoại, Sạc nhanh, Kết nối cùng lúc: 2 thiết bị, Công nghệ kết nối: 2.4 GHz, Bluetooth, Điều khiển: Phím nhấn, Bánh xe lăn, Kích thước: Dài 16.5 cm - Rộng 9.5 cm - Cao 20.9 cm, Khối lượng: 318 g', NULL, NULL, '12 tháng', 0.0, 0),
(11, 'Loa Bluetooth Alpha Works AW-Ride', 'Loa', 'Xuất xứ: Trung Quốc', 'Tổng công suất: 20 W, Nguồn: Pin 1200 mAh, Thời gian sử dụng: Dùng khoảng 18 tiếng (với 50% âm lượng), Thời gian sạc: Sạc khoảng 2.5 tiếng', 'https://youtu.be/AOA_cmNDt0A', NULL, '12 tháng', 0.0, 0),
(12, 'Loa Bluetooth AVA+ Led K09', 'Loa', 'Xuất xứ: Trung Quốc', 'Tổng công suất: 5 W, Nguồn: Pin, Thời gian sử dụng: Dùng khoảng 2.5 - 4 giờ, Thời gian sạc: Sạc khoảng 2 - 3 tiếng', 'https://youtu.be/v-xCAxsHsLI', NULL, '12 tháng', 0.0, 0),
(13, 'Loa Bluetooth Rezo Light Motion K118', 'Loa', 'Xuất xứ Đài Loan', 'Tổng công suất: 10 W, Nguồn: Pin, Thời gian sử dụng: Dùng khoảng 2 - 3 tiếng, Thời gian sạc: Sạc khoảng 1.5 - 2.5 tiếng, Công nghệ âm thanh: Âm thanh Hi-Fi, Âm thanh 360 độ', 'https://youtu.be/MGYg7Z3ZVcc', NULL, '12 tháng', 0.0, 0),
(14, 'Loa Bluetooth JBL Go 4', 'Loa', 'Xuất xứ Trung Quốc', 'Tổng công suất: 4.2 W, Nguồn: Pin, Thời gian sử dụng: Dùng khoảng 7 tiếng, Thời gian sạc: Sạc khoảng 3 tiếng, Công nghệ âm thanh: JBL Pro Sound', 'https://youtu.be/aHUeF9waDvM', NULL, '12 tháng', 3.0, 1),
(15, 'Loa Bluetooth JBL Charge 6', 'Loa', 'Xuất xứ: Hàn Quốc', 'Tổng công suất: 45 W, Nguồn: Pin, Thời gian sử dụng: Dùng khoảng 28 tiếng, Thời gian sạc: Sạc khoảng 3 tiếng, Công nghệ âm thanh: Công nghệ AI Sound Boost, JBL Pro Sound', NULL, NULL, '12 tháng', 0.0, 0),
(16, 'Loa Bluetooth Xiaomi Sound Pocket', 'Loa', 'Xuất xứ Trung Quốc/Malaysia /Đài Loan', 'Tổng công suất: 5 W, Nguồn: Pin 1000 mAh, Thời gian sử dụng: Dùng khoảng 10 tiếng, Thời gian sạc: Sạc khoảng 3 tiếng, Công nghệ âm thanh: True Wireless Stereo', 'https://youtu.be/G6-wSspgdbY', NULL, '60 tháng', 0.0, 0),
(17, 'Loa Bluetooth Rezo Pulse E21', 'Loa', 'Xuất xứ Trung Quốc/Malaysia /Đài Loan', 'Tổng công suất: 10 W, Nguồn: Pin, Thời gian sử dụng: Dùng khoảng 3 - 7 tiếng, Thời gian sạc: Sạc khoảng 4 tiếng', 'https://youtu.be/HI6Gzt-TPZo', NULL, '12 tháng', 0.0, 0),
(18, 'Loa Bluetooth JBL Clip 5', 'Loa', 'Xuất xứ: Hàn Quốc', 'Tổng công suất: 7 W, Nguồn: Pin, Thời gian sử dụng: Dùng khoảng 12 tiếng, Thời gian sạc: Sạc khoảng 3 tiếng, Công nghệ âm thanh: JBL Pro Sound', 'https://youtu.be/UGWmvyTVCj4', NULL, '12 tháng', 0.0, 0),
(19, 'Loa vi tính Bluetooth Enkor E700 Đen', 'Loa', 'Xuất xứ Trung Quốc', 'Số lượng kênh: 2.1 kênh, Tổng công suất: 20 W, Nguồn: Cắm điện dùng', NULL, NULL, '12 tháng', 0.0, 0),
(20, 'Loa kéo karaoke Nanomax S-820 400W', 'Loa', 'Xuất xứ Đài Loan', 'Số đường tiếng của loa: 2 đường tiếng, Tổng công suất: 400 W, Nguồn: Cắm điện hoặc ắc quy, Thời gian sử dụng: Dùng khoảng 3 - 7 tiếng, Thời gian sạc: Sạc khoảng 2 tiếng, Phím điều khiển: Nút bấm và nút vặn cơ học', 'https://youtu.be/rV6uX_vFE9Y', NULL, '12 tháng', 0.0, 0),
(21, 'Google Tivi Xiaomi A 32 inch L32M8-P2SEA', 'Tivi', 'Nơi sản xuất: Việt Nam', 'Kích cỡ màn hình: 32 inch, Độ phân giải: HD, Loại màn hình: Đèn nền: LED viền (Edge LED), Tấm nền: IPS LCD, Hệ điều hành: Google TV, Chất liệu chân đế: Mặt trước kim loại - Mặt sau nhựa, Chất liệu viền tivi: Kim loại', 'https://youtu.be/TvBr8g5-YYA', '-13%', '12 tháng', 0.0, 0),
(22, 'Smart Tivi Crystal UHD Samsung 4K 43 inch UA43CU8000', 'Tivi', 'Nơi sản xuất: Việt Nam', 'Loại Tivi: Smart Tivi Crystal UHD, Kích cỡ màn hình: 43 inch, Độ phân giải: 4K (Ultra HD), Loại màn hình: Đèn nền: LED viền (Edge LED), Tấm nền: VA LCD, Hệ điều hành: Tizen™, Chất liệu chân đế: Nhựa, Chất liệu viền tivi: Nhựa', 'https://youtu.be/1A3-u29pLiI', NULL, '12 tháng', 0.0, 0),
(23, 'Google Tivi TCL AI 4K 55 inch 55P635', 'Tivi', 'Nơi sản xuất: Việt Nam', 'Loại Tivi: Google Tivi, Kích cỡ màn hình: 55 inch, Độ phân giải: 4K (Ultra HD), Loại màn hình: Đèn nền: LED nền (Direct LED), Tấm nền: VA LCD, Hệ điều hành: Google TV, Chất liệu chân đế: Nhựa, Chất liệu viền tivi: Nhựa', NULL, '-23%', '12 tháng', 0.0, 0),
(24, 'Smart Tivi Crystal UHD Samsung 4K 65 inch UA65CU8000', 'Tivi', 'Nơi sản xuất: Việt Nam', 'Loại Tivi: Smart Tivi Crystal UHD, Kích cỡ màn hình: 65 inch, Độ phân giải: 4K (Ultra HD), Loại màn hình: Đèn nền: LED viền (Edge LED), Tấm nền: VA LCD, Hệ điều hành: Tizen™, Chất liệu chân đế: Nhựa, Chất liệu viền tivi: Nhựa', 'https://youtu.be/1A3-u29pLiI', NULL, '12 tháng', 0.0, 0),
(25, 'Smart Tivi QLED Samsung 4K 85 inch QA85Q60D', 'Tivi', 'Nơi sản xuất: Việt Nam', 'Loại Tivi: Smart Tivi QLED, Kích cỡ màn hình: 85 inch, Độ phân giải: 4K (Ultra HD), Loại màn hình: Đèn nền: LED viền (Edge LED), Tấm nền: Hãng không công bố, Hệ điều hành: Tizen™, Chất liệu chân đế: Nhựa, Chất liệu viền tivi: Nhựa', NULL, NULL, '12 tháng', 0.0, 0),
(26, 'Smart Tivi OLED LG AI 4K 55 inch 55B4PSA', 'Tivi', 'Nơi sản xuất: Indonesia', 'Loại Tivi: Smart Tivi OLED, Kích cỡ màn hình: 55 inch, Độ phân giải: 4K (Ultra HD), Loại màn hình: Tấm nền: OLED, Hệ điều hành: webOS 24, Chất liệu chân đế: Vỏ nhựa lõi kim loại, Chất liệu viền tivi: Nhựa', 'https://youtu.be/gfj5tUr-6OY?si=ol9jqS_FqkL-sQJ0', NULL, '60 tháng', 0.0, 0),
(27, 'Smart Tivi NanoCell LG AI 4K 43 inch 43NANO81TSA', 'Tivi', 'Nơi sản xuất: Indonesia', 'Loại Tivi: Smart Tivi NanoCell, Kích cỡ màn hình: 43 inch, Độ phân giải: 4K (Ultra HD), Loại màn hình: Đèn nền: LED nền (Direct LED), Tấm nền: Hãng không công bố, Hệ điều hành: webOS 24, Chất liệu chân đế: Vỏ nhựa lõi kim loại, Chất liệu viền tivi: Nhựa', 'https://youtu.be/hMflznpvuYg', NULL, '12 tháng', 0.0, 0),
(28, 'Smart Tivi NanoCell LG AI 4K 55 inch 55NANO76SQA', 'Tivi', 'Nơi sản xuất: Indonesia', 'Loại Tivi: Smart Tivi NanoCell, Kích cỡ màn hình: 55 inch, Độ phân giải: 4K (Ultra HD), Loại màn hình: Đèn nền: LED nền (Direct LED), Tấm nền: Hãng không công bố, Hệ điều hành: webOS 22, Chất liệu chân đế: Vỏ nhựa lõi kim loại, Chất liệu viền tivi: Nhựa', 'https://youtu.be/UhH0bnFJJt0', NULL, '12 tháng', 0.0, 0),
(29, 'Smart Tivi LG AI 4K 65 inch 65UT8050PSB', 'Tivi', 'Nơi sản xuất: Indonesia', 'Loại Tivi: Smart Tivi, Kích cỡ màn hình: 65 inch, Độ phân giải: 4K (Ultra HD), Loại màn hình: Đèn nền: LED nền (Direct LED), Tấm nền: Hãng không công bố, Hệ điều hành: webOS 24, Chất liệu chân đế: Vỏ nhựa lõi kim loại, Chất liệu viền tivi: Nhựa', 'https://youtu.be/bvUK8HZfljg', NULL, '12 tháng', 0.0, 0),
(30, 'Android Tivi Aqua FHD 43 inch AQT43K800FG', 'Tivi', 'Nơi sản xuất: Việt Nam', 'Loại Tivi: Android Tivi, Kích cỡ màn hình: 43 inch, Độ phân giải: Full HD, Loại màn hình: Đèn nền: LED nền (Direct LED), Tấm nền: VA LCD, Hệ điều hành: Android 11.0, Chất liệu chân đế: Nhựa, Chất liệu viền tivi: Nhựa', 'https://youtu.be/AYMiBtNBVbQ', NULL, '12 tháng', 0.0, 0),
(31, 'Túi Chống Sốc Macbook Pro 14 inch Tomtoc A14D2B1', 'Phụ kiện', 'Sản xuất tại: Trung Quốc', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(32, 'Túi chống sốc Laptop 14 inch Tomtoc A45', 'Phụ kiện', 'Xuất xứ: Trung Quốc', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(33, 'Túi chống sốc Laptop 15.6 inch Jinya Classic', 'Phụ kiện', 'Xuất xứ: Trung Quốc', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(34, 'Túi Chống Sốc Laptop 14 inch Togo TCSN14', 'Phụ kiện', 'Xuất xứ: Trung Quốc', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(35, 'Túi chống sốc Laptop 14 inch Tomtoc A12D3Y1', 'Phụ kiện', 'Sản xuất tại: Trung Quốc', NULL, NULL, NULL, '24 tháng', 0.0, 0),
(36, 'Balo laptop 15.6 inch Tucano Bravo AGS Eco', 'Phụ kiện', 'Sản xuất tại: Trung Quốc', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(37, 'Balo Laptop 16 inch Tomtoc Flap', 'Phụ kiện', 'Sản xuất tại: Việt Nam', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(38, 'Balo Laptop 15.6 inch Togo TGB05', 'Phụ kiện', 'Sản xuất tại: Việt Nam', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(39, 'Balo Laptop 15.6 inch Tomtoc Roll top T61M1D1', 'Phụ kiện', 'Sản xuất tại: Trung Quốc', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(40, 'Balo Laptop 15.6 inch Targus Safire Essential TBB580GL', 'Phụ kiện', 'Xuất xứ: HongKong', NULL, NULL, NULL, '12 tháng', 0.0, 0),
(41, 'Quạt cầm tay mini Hydrus JF-102', 'Quạt', 'Sản xuất tại: Trung Quốc', 'Mức gió: 5 mức độ, Bảng điều khiển: Màn hình led thể hiện số pin, Chiều dài dây điện: 101 cm, Chất liệu: Nhựa ABS + linh kiện điện tử, Cổng sạc: Type C, Thời gian sử dụng điện sau khi sạc: 1.5 - 5.2 giờ (tùy theo tốc độ gió), Dung lượng pin: 3000 mAh, Tiện ích: Có thể gập, Kích thước: Ngang 5.45 cm - Cao 16.4 cm - Sâu 6 cm, Khối lượng: 0.19 kg', 'https://youtu.be/G5Z7CmcT0oc', NULL, 'Không bảo hành. Đổi trả trong vòng 7 ngày nếu sản phẩm lỗi kỹ thuật.', 0.0, 0),
(42, 'Quạt cầm tay mini Hydrus JF-79', 'Quạt', 'Xuất xứ: Trung Quốc', 'Mức gió: 5 mức độ, Bảng điều khiển: Màn hình led thể hiện số pin, Chiều dài dây điện: 100 cm, Chất liệu: Nhựa ABS + linh kiện điện tử, Cổng sạc: Type C, Thời gian sử dụng điện sau khi sạc: 3.5 - 11 giờ ( tùy theo tốc độ gió), Dung lượng pin: 4000 mAh, Kích thước: Ngang 5.88 cm - Cao 15.85 cm - Sâu 6.24 cm, Khối lượng: 0.21 kg', 'https://youtu.be/G5Z7CmcT0oc', NULL, 'Không bảo hành. Đổi trả trong vòng 7 ngày nếu sản phẩm lỗi kỹ thuật.', 0.0, 0),
(43, 'Quạt cầm tay mini Hydrus F15', 'Quạt', 'Xuất xứ: Trung Quốc', 'Mức gió: 4 mức độ, Bảng điều khiển: Màn hình led thể hiện số pin, Chiều dài dây điện: 100 cm, Chất liệu: Nhựa ABS + linh kiện điện tử, Cổng sạc: Type C, Thời gian sử dụng điện sau khi sạc: 2.67 - 12 giờ (tuỳ theo tốc độ gió), Dung lượng pin: 4000 mAh, Tiện ích: Chế độ lạnh, Có thể gập, Kích thước: Ngang 6.2 cm - Cao 18.3 cm - Sâu 5.77 cm, Khối lượng: 0.24 kg', 'https://youtu.be/G5Z7CmcT0oc', NULL, 'Không bảo hành. Đổi trả trong vòng 7 ngày nếu sản phẩm lỗi kỹ thuật.', 0.0, 0),
(44, 'Quạt để bàn mini Hydrus JF-96', 'Quạt', 'Xuất xứ: Trung Quốc', 'Mức gió: 4 mức độ, Chiều dài dây điện: 101 cm, Chất liệu: Nhựa ABS/ PP + linh kiện điện tử, Cổng sạc: Type C, Thời gian sử dụng điện sau khi sạc: 3 - 10.5 giờ (tuỳ theo tốc độ gió), Dung lượng pin: 2000 mAh, Kích thước: Ngang 11.8 cm - Cao 17 cm - Sâu 9.58 cm, Khối lượng: 0.37 kg', NULL, NULL, 'Không bảo hành. Đổi trả trong vòng 7 ngày nếu sản phẩm lỗi kỹ thuật.', 0.0, 0),
(45, 'Đèn bàn học Điện Quang ĐQ LDL06', NULL, 'Sản xuất tại: Trung Quốc', 'Công suất: 5W, Điều khiển: Cảm ứng, Số bóng đèn LED: 1 bóng, Tiện ích: Có thể điều chỉnh độ cao, hướng chiếu sáng, Điều chỉnh màu sắc của đèn, Kích thước - Khối lượng: Cao 52 cm - Ngang 14 cm - Sâu 14 cm - Nặng 0.87 kg', 'https://youtu.be/HqDlvFlxTLE', NULL, 'Sản phẩm mới, chính hãng (Không bảo hành, đổi trả)', 0.0, 0),
(46, 'Máy in Canon LBP246dw', 'Máy in', 'Máy in laser đơn sắc với tốc độ in nhanh, hỗ trợ in hai mặt tự động', 'Tốc độ in: 40 trang/phút, Độ phân giải: 600 x 600 dpi, Kết nối: USB, LAN, Wi-Fi, Khay giấy: 250 tờ', NULL, 'Giảm giá 10%', '12 tháng', 0.0, 0),
(47, 'Máy in HP LaserJet Pro MFP M428fdw', 'Máy in', 'Máy in đa chức năng với khả năng in, scan, copy, fax, phù hợp cho văn phòng hiện đại.', 'Tốc độ in: 38 trang/phút, Độ phân giải: 1200 x 1200 dpi, Kết nối: USB, Ethernet, Wi-Fi, Khay giấy: 250 tờ', NULL, 'Tặng gói bảo trì 6 tháng', '12 tháng', 0.0, 0),
(48, 'Máy in Brother DCP-T720DW', 'Máy in', 'Máy in phun màu đa chức năng với khả năng in, scan, copy, kết nối không dây.', 'Độ phân giải: 1200 x 6000 dpi, Tốc độ in: 17 trang/phút (đen trắng), 9.5 trang/phút (màu), Kết nối: USB, Wi-Fi, Khay giấy: 150 tờ', 'https://youtu.be/qYUH3PkLhzg', 'Tặng bộ mực in chính hãng', '12 tháng', 0.0, 0),
(49, 'Máy in Canon LBP243dw', 'Máy in', 'Máy in laser đơn sắc với khả năng in hai mặt tự động, kết nối linh hoạt.', 'Tốc độ in: 36 trang/phút, Độ phân giải: 600 x 600 dpi, Kết nối: USB, LAN, Wi-Fi, Khay giấy: 250 tờ', NULL, 'Tặng kèm 1 hộp mực', '12 tháng', 0.0, 0),
(50, 'Máy hủy tài liệu HP OneShred 12CC', NULL, 'Máy hủy tài liệu HP OneShred 12CC có thiết kế nhỏ gọn, phù hợp cho văn phòng vừa và nhỏ.', 'Công suất hủy: 12 tờ/lần, Kiểu hủy: Vụn, Dung tích thùng chứa: 20 lít, Khả năng hủy: Giấy, ghim, thẻ tín dụng', NULL, NULL, '12 tháng', 0.0, 0),
(51, 'Máy hủy tài liệu Silicon PS-800C', NULL, 'Máy hủy tài liệu Silicon PS-800C có khả năng hủy nhanh chóng, phù hợp cho văn phòng có nhu cầu hủy tài liệu thường xuyên.', 'Công suất hủy: 8 tờ/lần, Kiểu hủy: Vụn, Dung tích thùng chứa: 21 lít, Khả năng hủy: Giấy, ghim, thẻ tín dụng', 'https://youtu.be/1bP3WQ6XDyc', NULL, '12 tháng', 0.0, 0),
(52, 'Máy hủy tài liệu Silicon PS-6800C', NULL, 'Máy hủy tài liệu Silicon PS-6800C có khả năng hủy mạnh mẽ, phù hợp cho văn phòng có nhu cầu hủy tài liệu lớn.', 'Công suất hủy: 20 tờ/lần, Kiểu hủy: Vụn, Dung tích thùng chứa: 30 lít, Khả năng hủy: Giấy, ghim, thẻ tín dụng', 'https://youtu.be/Dzw3BrY9V1U', NULL, '12 tháng', 0.0, 0),
(53, 'Nintendo Switch OLED', 'Máy chơi game', 'Máy chơi game cầm tay nổi bật với màn hình OLED 7 inch rực rỡ, hỗ trợ chế độ handheld, dock và tabletop – phù hợp cho cả chơi cá nhân lẫn nhóm.', 'Màn hình: OLED 7 inch, cảm ứng, Bộ nhớ trong: 64GB (hỗ trợ thẻ microSD), Kết nối: Wi-Fi, Bluetooth, HDMI (Dock), Thời lượng pin: 4.5 – 9 giờ, Cổng sạc: USB-C', 'https://youtu.be/RWvREo5K0sw', 'Tặng kèm game Mario Kart 8 (phiên bản bundle)', '12 tháng', 0.0, 0),
(54, 'Sony PlayStation 5 Digital Edition', 'Máy chơi game', 'Phiên bản PS5 không ổ đĩa, cho phép tải và chơi game kỹ thuật số với hiệu năng cực mạnh và trải nghiệm hình ảnh 4K.', 'CPU: AMD Ryzen Zen 2, 8 nhân, GPU: RDNA 2 (10.28 TFLOPs), RAM: 16GB GDDR6, SSD: 825GB, Hỗ trợ: Ray Tracing, 4K UHD, HDR', 'https://youtu.be/xBAQfdlgtHY', 'Giảm giá 1 triệu, tặng voucher PSN', '12 tháng chính hãng', 0.0, 0),
(55, 'Xbox Series S', 'Máy chơi game', 'Máy chơi game nhỏ gọn, giá rẻ hơn Series X, hỗ trợ chơi game thế hệ mới ở độ phân giải 1440p và 120FPS.', 'CPU: AMD Zen 2, 8 nhân, GPU: 4 TFLOPs, RAM: 10GB GDDR6, SSD: 512GB, Hỗ trợ: Ray Tracing, 1440p, 120Hz', 'https://youtu.be/2HnvmVtEqUg', 'Tặng gói Game Pass 3 tháng', '12 tháng', 0.0, 0),
(56, 'Tay cầm DualSense PS5', NULL, 'Tay cầm thế hệ mới của Sony với công nghệ Adaptive Trigger và Haptic Feedback mang đến trải nghiệm chân thực.', 'Kết nối: USB-C / Bluetooth, Hỗ trợ: PC, Android, PS5, Pin: 1560mAh (4–8 giờ)', '', 'Mua 2 giảm 10%', '6 tháng', 0.0, 0),
(57, 'Logitech G502 HERO', NULL, 'Chuột gaming có dây nổi tiếng với độ chính xác cao, cảm biến HERO lên đến 25.600 DPI, tùy chỉnh nhiều nút.', 'Kết nối: USB, DPI: 100 – 25.600, Nút: 11 nút lập trình, Tùy chỉnh trọng lượng', '', 'Giảm 20%', '24 tháng', 0.0, 0),
(58, 'Razer BlackWidow V3', NULL, 'Bàn phím cơ chuyên game với switch Razer Green clicky, đèn RGB sống động.', 'Kết nối: USB, Switch: Razer Green (clicky), Đèn: RGB Razer Chroma, Chất liệu: Nhôm – nhựa cao cấp', '', 'Giảm 15%', '24 tháng', 0.0, 0),
(59, 'Máy chơi game cầm tay Retroid Pocket 3+', 'Máy chơi game', 'Máy chơi game retro Android nhỏ gọn, chơi tốt giả lập PS1, PSP, N64 và Android apps.', 'Màn hình: 4.7\" IPS, 750p, Chip: Unisoc T618, RAM: 4GB, ROM: 128GB (mở rộng microSD), HĐH: Android 11', 'https://youtu.be/LoBh9LtUmFE', 'Tặng kèm thẻ nhớ 64GB', '12 tháng', 0.0, 0),
(60, 'Samsung Galaxy A55', 'Điện thoại', 'Samsung Galaxy A55 là mẫu smartphone tầm trung cận cao cấp, kế thừa những điểm mạnh về thiết kế và camera của dòng A. Máy sở hữu thiết kế khung viền kim loại sang trọng, màn hình AMOLED tần số quét cao và khả năng kháng nước, bụi IP67.', 'Màn hình: Super AMOLED, 6.6 inch, Full HD+ (1080 x 2340 Pixels), tần số quét 120Hz. Chip: Exynos 1480. RAM: 8GB / 12GB. Bộ nhớ trong: 128GB / 256GB. Camera sau: Chính 50MP (OIS), Góc siêu rộng 12MP, Macro 5MP. Camera trước: 32MP. Pin: 5000 mAh, sạc nhanh 25W. Hệ điều hành: Android 14 với One UI 6.1. Tính năng khác: Kháng nước, bụi IP67.', 'https://youtu.be/NOMVB8qLRaA', 'Thường có chương trình trả góp 0%, giảm giá trực tiếp, tặng phiếu mua hàng hoặc voucher.', 'Chính hãng 12 tháng.', 0.0, 0),
(61, 'iPhone 13', 'Điện thoại', 'iPhone 13 vẫn là một lựa chọn đáng giá trong phân khúc cận cao cấp, với thiết kế đẹp, chip A15 Bionic mạnh mẽ và hệ thống camera kép chất lượng. Mặc dù đã ra mắt được vài năm, hiệu năng của máy vẫn đáp ứng tốt các nhu cầu sử dụng hàng ngày và chơi game.', 'Màn hình: Super Retina XDR OLED, 6.1 inch, 1170 x 2532 Pixels, tần số quét 60Hz. Chip: Apple A15 Bionic. RAM: 4GB. Bộ nhớ trong: 128GB / 256GB / 512GB. Camera sau: Chính 12MP (OIS), Góc siêu rộng 12MP. Camera trước: 12MP. Pin: Khoảng 3240 mAh, sạc nhanh 20W. Hệ điều hành: iOS (có thể cập nhật lên phiên bản mới nhất). Tính năng khác: Kháng nước, bụi IP68, Face ID.', 'https://youtu.be/A7qIRbLj8bk', 'Thường có giảm giá sâu, trả góp 0%, hoặc tặng kèm phụ kiện cơ bản.', 'Chính hãng 12 tháng.', 0.0, 0),
(62, 'OPPO A58', 'Điện thoại', 'OPPO A58 là mẫu smartphone phổ thông, hướng đến người dùng cơ bản với màn hình lớn, pin trâu và camera ổn định trong tầm giá. Máy có thiết kế trẻ trung, màu sắc đa dạng.', 'Màn hình: IPS LCD, 6.72 inch, Full HD+ (1080 x 2400 Pixels). Chip: MediaTek Helio G85. RAM: 6GB / 8GB. Bộ nhớ trong: 128GB. Camera sau: Chính 50MP, Xóa phông 2MP. Camera trước: 8MP. Pin: 5000 mAh, sạc nhanh SuperVOOC 33W. Hệ điều hành: Android 13 với ColorOS 13.1. Tính năng khác: Loa kép.', 'https://www.youtube.com/watch?v=e_c5faPCMOs', 'Thường có giảm giá tiền mặt, trả góp 0% hoặc tặng kèm sim data.', 'Chính hãng 12 tháng.', 0.0, 0),
(63, 'Xiaomi Redmi Note 13 Pro+ 5G', 'Điện thoại', 'Xiaomi Redmi Note 13 Pro+ 5G là mẫu smartphone tầm trung cao cấp của Xiaomi, nổi bật với màn hình cong AMOLED 1.5K, camera 200MP chống rung OIS và công nghệ sạc siêu nhanh 120W.', 'Màn hình: AMOLED, 6.67 inch, 1.5K (1220 x 2712 Pixels), tần số quét 120Hz, độ sáng tối đa 1800 nits. Chip: MediaTek Dimensity 7200 Ultra. RAM: 8GB / 12GB. Bộ nhớ trong: 256GB / 512GB. Camera sau: Chính 200MP (OIS), Góc siêu rộng 8MP, Macro 2MP. Camera trước: 16MP. Pin: 5000 mAh, sạc nhanh 120W. Hệ điều hành: Android 13 với MIUI 14 (có thể cập nhật lên HyperOS). Tính năng khác: Kháng nước, bụi IP68, cảm biến vân tay dưới màn hình, loa kép.', '', 'Thường có ưu đãi trả góp 0%, giảm giá trực tiếp, tặng kèm tai nghe hoặc phiếu mua hàng.', 'Chính hãng 12 tháng.', 0.0, 0),
(64, 'Xiaomi Redmi 13C', 'Điện thoại', 'Xiaomi Redmi 13C là mẫu điện thoại giá rẻ của Xiaomi, tập trung vào việc mang lại trải nghiệm màn hình lớn, pin \"trâu\" và hiệu năng ổn định cho các tác vụ cơ bản hàng ngày.', 'Màn hình: IPS LCD, 6.74 inch, HD+ (720 x 1600 Pixels), tần số quét 90Hz. Chip: MediaTek Helio G85. RAM: 4GB / 6GB / 8GB. Bộ nhớ trong: 128GB / 256GB. Camera sau: Chính 50MP, Macro 2MP, Xóa phông 2MP. Camera trước: 8MP. Pin: 5000 mAh, sạc nhanh 18W. Hệ điều hành: Android 13 với MIUI 14.', 'https://youtu.be/4ku0sxoJ4oo', 'Thường có giảm giá tiền mặt, tặng kèm sim data hoặc phiếu mua hàng.', 'Chính hãng 12 tháng.', 0.0, 0),
(71, 'Máy Chơi Game PS4', 'Máy chơi game', 'Đến từ nhà Sony', 'Tên sản phẩm	PlayStation 4 Pro\r\nModel	CUH‑7000 series\r\nCPU	AMD x86-64 \"Jaguar\" 8 lõi, tốc độ ~2.1 GHz—nhanh hơn ~31% so với PS4 gốc\r\nGPU	AMD Radeon (GCN, Polaris) với 36 Compute Units @ 911 MHz (~4.2 TFLOPS)—gấp hơn 2.2 lần so với PS4 gốc\r\nRAM hệ thống	8 GB GDDR5 (băng thông 218 GB/s) + 1 GB DDR3 dành cho hệ điều hành\r\nLưu trữ (HDD)	HDD 1 TB 2.5\" SATA, có thể thay thế/tăng cấp\r\nĐầu ra hình ảnh	HDMI 2.0a hỗ trợ xuất 4K (checkerboard upscale hoặc native 4K), HDR\r\nỔ đĩa quang	Blu-ray & DVD (chỉ đọc)\r\nCổng kết nối	3 × USB 3.1 Gen1, 1 × AUX, HDMI, Optical Audio Out, Gigabit Ethernet\r\nKết nối không dây	Wi-Fi 802.11ac (dual-band), Bluetooth 4.0 (LE)\r\nKích thước (WxHxD)	295 × 55 × 327 mm (~11.6″ × 2.2″ × 12.9″)\r\nTrọng lượng	Khoảng 3.3 kg (7.3 lb)\r\nCông suất tiêu thụ tối đa	Khoảng 310 W\r\nTính năng nổi bật	4K HDR gaming, VR cải thiện, hình ảnh chi tiết hơn, tốc độ khung hình ổn định hơn\r\n', '', NULL, '6 tháng', 0.0, 0),
(75, 'iPhone 11 64GB', 'Điện thoại', 'Thiết kế vẫn rất thời thượng, hiệu năng ổn định.', 'Chip A13 Bionic, Màn hình 6.1 Liquid Retina', NULL, NULL, '12 tháng', 4.5, 100),
(76, 'iPhone 12 128GB', 'Điện thoại', 'Thiết kế vuông vức, màn hình OLED sắc nét.', 'Chip A14 Bionic, Màn hình Super Retina XDR', NULL, NULL, '12 tháng', 4.6, 80),
(77, 'iPhone 14 Plus 128GB', 'Điện thoại', 'Màn hình lớn, pin trâu.', 'Chip A15 Bionic, Màn hình 6.7 inch', NULL, NULL, '12 tháng', 4.7, 50),
(78, 'Samsung Galaxy S23 FE', 'Điện thoại', 'Phiên bản Fan Edition đáng giá.', 'Exynos 2200, Màn hình 120Hz', NULL, NULL, '12 tháng', 4.2, 30),
(79, 'Samsung Galaxy Z Flip5', 'Điện thoại', 'Màn hình phụ Flex Window đột phá.', 'Snapdragon 8 Gen 2 for Galaxy', NULL, NULL, '12 tháng', 4.8, 45),
(80, 'Samsung Galaxy Z Fold5', 'Điện thoại', 'Quyền năng PC trong túi quần.', 'Snapdragon 8 Gen 2, Đa nhiệm cực đỉnh', NULL, NULL, '12 tháng', 4.9, 20),
(81, 'Xiaomi Redmi Note 13 Pro', 'Điện thoại', 'Camera 200MP, sạc nhanh 67W.', 'Helio G99-Ultra, Màn hình AMOLED', NULL, NULL, '18 tháng', 4.5, 120),
(82, 'Xiaomi 13T 5G', 'Điện thoại', 'Camera Leica chuyên nghiệp.', 'Dimensity 8200-Ultra, Màn hình 144Hz', NULL, NULL, '24 tháng', 4.6, 60),
(83, 'OPPO Reno10 5G', 'Điện thoại', 'Chuyên gia chân dung tele.', 'Dimensity 7050 5G, Camera 64MP', NULL, NULL, '12 tháng', 4.4, 90),
(84, 'OPPO Find N3 Flip', 'Điện thoại', 'Camera Hasselblad đẳng cấp.', 'Dimensity 9200, Màn hình gập không nếp gấp', NULL, NULL, '12 tháng', 4.7, 15),
(85, 'Realme 11 Pro+', 'Điện thoại', 'Thiết kế da sinh học sang trọng.', 'Camera 200MP, Sạc 100W', NULL, NULL, '12 tháng', 4.3, 40),
(86, 'Vivo V29e 5G', 'Điện thoại', 'Vòng sáng Aura độc đáo.', 'Snapdragon 695, Camera selfie 50MP', NULL, NULL, '12 tháng', 4.2, 25),
(87, 'Asus ROG Phone 7', 'Điện thoại', 'Ông vua Gaming Phone.', 'Snapdragon 8 Gen 2, Pin 6000mAh, AirTrigger', NULL, NULL, '12 tháng', 5.0, 35),
(88, 'Google Pixel 7 Pro', 'Điện thoại', 'Android thuần, Camera AI đỉnh cao.', 'Google Tensor G2, Màn hình LTPO', NULL, NULL, '12 tháng', 4.5, 10),
(89, 'Google Pixel 8', 'Điện thoại', 'Nhỏ gọn, mạnh mẽ, AI tích hợp sâu.', 'Google Tensor G3, Màn hình Actua', NULL, NULL, '12 tháng', 4.6, 5),
(90, 'Samsung Galaxy A34 5G', 'Điện thoại', 'Chiến thần tầm trung.', 'Dimensity 1080, Kháng nước IP67', NULL, NULL, '12 tháng', 4.4, 200),
(91, 'Samsung Galaxy A54 5G', 'Điện thoại', 'Chụp đêm siêu đỉnh.', 'Exynos 1380, Lưng kính sang trọng', NULL, NULL, '12 tháng', 4.5, 150),
(92, 'iPhone 15 128GB', 'Điện thoại', 'Dynamic Island, Camera 48MP.', 'Chip A16 Bionic, Cổng USB-C', NULL, NULL, '12 tháng', 4.8, 70),
(93, 'iPhone 15 Plus 128GB', 'Điện thoại', 'Pin khủng nhất dòng iPhone 15.', 'Chip A16 Bionic, Màn hình 6.7 inch', NULL, NULL, '12 tháng', 4.7, 65),
(94, 'Xiaomi Poco X6 Pro', 'Điện thoại', 'Hiệu năng vô đối trong tầm giá.', 'Dimensity 8300 Ultra, Màn hình 1.5K', NULL, NULL, '18 tháng', 4.6, 88),
(95, 'MacBook Air M1 2020', 'Laptop', 'Laptop văn phòng quốc dân.', 'Apple M1, 8GB RAM, 256GB SSD', NULL, NULL, '12 tháng', 4.9, 500),
(96, 'MacBook Pro 14 M3', 'Laptop', 'Sức mạnh Pro, màu Space Black.', 'Apple M3, 8GB RAM, 512GB SSD', NULL, NULL, '12 tháng', 4.8, 20),
(97, 'Asus Zenbook 14 OLED', 'Laptop', 'Mỏng nhẹ, màn hình đẹp tuyệt mỹ.', 'Core Ultra 5, Màn hình 3K OLED', NULL, NULL, '24 tháng', 4.5, 30),
(98, 'Dell Inspiron 15 3520', 'Laptop', 'Bền bỉ, phục vụ học tập tốt.', 'Core i5 1235U, 8GB, 512GB', NULL, NULL, '12 tháng', 4.3, 100),
(99, 'HP Pavilion 15', 'Laptop', 'Thời trang, âm thanh B&O.', 'Core i5 1240P, 16GB RAM', NULL, NULL, '12 tháng', 4.2, 50),
(100, 'Acer Nitro 5 Tiger', 'Laptop', 'Laptop Gaming quốc dân.', 'i5 12500H, RTX 3050, 144Hz', NULL, NULL, '12 tháng', 4.4, 150),
(101, 'MSI Katana 15', 'Laptop', 'Sắc bén như thanh kiếm Nhật.', 'i7 13620H, RTX 4050, 144Hz', NULL, NULL, '24 tháng', 4.3, 40),
(102, 'Lenovo Legion 5', 'Laptop', 'Build chắc chắn, tản nhiệt tốt.', 'Ryzen 7 5800H, RTX 3050Ti', NULL, NULL, '24 tháng', 4.7, 80),
(103, 'Lenovo ThinkBook 14 G3', 'Laptop', 'Thiết kế doanh nhân, bảo mật cao.', 'Ryzen 5 5500U, Vỏ nhôm', NULL, NULL, '12 tháng', 4.4, 60),
(104, 'LG Gram 2023 14 inch', 'Laptop', 'Siêu nhẹ chỉ 999g.', 'Core i7 1340P, 16GB, 512GB', NULL, NULL, '12 tháng', 4.8, 15),
(105, 'Surface Pro 9', 'Laptop', 'Máy tính bảng lai Laptop đỉnh cao.', 'Core i5 1235U, Màn hình 120Hz', NULL, NULL, '12 tháng', 4.6, 25),
(106, 'Surface Laptop 5 13.5', 'Laptop', 'Sang trọng, mượt mà.', 'Core i5 1235U, Cảm ứng', NULL, NULL, '12 tháng', 4.5, 20),
(107, 'Gigabyte G5 MF', 'Laptop', 'Hiệu năng cao giá rẻ.', 'i5 12500H, RTX 4050', NULL, NULL, '24 tháng', 4.1, 70),
(108, 'Dell Vostro 3520', 'Laptop', 'Nồi đồng cối đá.', 'Core i3 1215U, 8GB, SSD 256GB', NULL, NULL, '12 tháng', 4.0, 90),
(109, 'HP Victus 16', 'Laptop', 'Thiết kế đơn giản, cấu hình mạnh.', 'Ryzen 5 6600H, RTX 3050', NULL, NULL, '12 tháng', 4.3, 60),
(110, 'Acer Swift 3', 'Laptop', 'Mỏng nhẹ di động.', 'Core i5 1135G7, Vỏ nhôm', NULL, NULL, '12 tháng', 4.2, 55),
(111, 'Asus Vivobook 15 OLED', 'Laptop', 'Màn hình OLED giá rẻ.', 'Ryzen 5 7530U, Màn OLED', NULL, NULL, '24 tháng', 4.4, 75),
(112, 'MSI Modern 14', 'Laptop', 'Giá rẻ cho sinh viên.', 'Core i3 1115G4, Nhỏ gọn', NULL, NULL, '24 tháng', 4.1, 200),
(113, 'MacBook Air M2 15 inch', 'Laptop', 'Màn hình lớn, siêu mỏng.', 'Apple M2, 8GB, 256GB', NULL, NULL, '12 tháng', 4.8, 30),
(114, 'Acer Predator Helios Neo', 'Laptop', 'Vũ khí tối thượng.', 'i7 13700HX, RTX 4060', NULL, NULL, '12 tháng', 4.7, 25),
(115, 'iPad Gen 9 10.2 inch', 'Máy tính bảng', 'iPad giá rẻ tốt nhất.', 'A13 Bionic, 64GB', NULL, NULL, '12 tháng', 4.8, 300),
(116, 'iPad Gen 10 10.9 inch', 'Máy tính bảng', 'Thiết kế mới, nhiều màu sắc.', 'A14 Bionic, USB-C', NULL, NULL, '12 tháng', 4.5, 100),
(117, 'iPad Pro 11 M2', 'Máy tính bảng', 'Hiệu năng không đối thủ.', 'Apple M2, Màn hình 120Hz', NULL, NULL, '12 tháng', 4.9, 40),
(118, 'Samsung Galaxy Tab S9 WiFi', 'Máy tính bảng', 'Chống nước, kèm bút S-Pen.', 'Snapdragon 8 Gen 2, Màn 11 inch', NULL, NULL, '12 tháng', 4.7, 35),
(119, 'Samsung Galaxy Tab S9 FE', 'Máy tính bảng', 'Phiên bản rút gọn vừa túi tiền.', 'Exynos 1380, 90Hz', NULL, NULL, '12 tháng', 4.4, 50),
(120, 'Xiaomi Pad 6', 'Máy tính bảng', 'Màn hình 144Hz siêu mượt.', 'Snapdragon 870, Pin 8840mAh', NULL, NULL, '18 tháng', 4.6, 90),
(121, 'Lenovo Tab M10 Gen 3', 'Máy tính bảng', 'Máy tính bảng giá rẻ cho trẻ em.', 'Màn hình 10.1 inch, Loa kép', NULL, NULL, '12 tháng', 4.0, 60),
(122, 'OPPO Pad Air', 'Máy tính bảng', 'Mỏng nhẹ, thiết kế đẹp.', 'Snapdragon 680, 4 loa', NULL, NULL, '12 tháng', 4.3, 40),
(123, 'Apple Watch SE 2023', 'Đồng hồ', 'Smartwatch Apple giá tốt.', 'Chip S8, Chống nước 50m', NULL, NULL, '12 tháng', 4.7, 120),
(124, 'Apple Watch Ultra 2', 'Đồng hồ', 'Dành cho dân thể thao chuyên nghiệp.', 'Vỏ Titan, Pin 36h', NULL, NULL, '12 tháng', 4.9, 30),
(125, 'Samsung Galaxy Watch6 Classic', 'Đồng hồ', 'Vòng xoay bezel vật lý trở lại.', 'Đo thành phần cơ thể, Sleep Coaching', NULL, NULL, '12 tháng', 4.6, 50),
(126, 'Samsung Galaxy Watch6', 'Đồng hồ', 'Viền mỏng hơn, màn hình lớn hơn.', 'Sapphire Crystal', NULL, NULL, '12 tháng', 4.5, 60),
(127, 'Garmin Forerunner 265', 'Đồng hồ', 'Chuyên chạy bộ, màn AMOLED.', 'GPS đa băng tần, Pin 13 ngày', NULL, NULL, '12 tháng', 4.8, 20),
(128, 'Garmin Venu 3', 'Đồng hồ', 'Theo dõi sức khỏe toàn diện.', 'Nghe gọi trên đồng hồ, Pin 14 ngày', NULL, NULL, '12 tháng', 4.7, 25),
(129, 'Xiaomi Watch 2', 'Đồng hồ', 'Chạy WearOS mượt mà.', 'Snapdragon W5+ Gen 1', NULL, NULL, '12 tháng', 4.3, 40),
(130, 'Huawei Watch GT 4', 'Đồng hồ', 'Thiết kế thời trang bát giác.', 'Pin 2 tuần, Theo dõi calo', NULL, NULL, '12 tháng', 4.6, 70),
(131, 'Amazfit GTR 4', 'Đồng hồ', 'GPS chính xác, pin trâu.', 'Cảm biến BioTracker 4.0', NULL, NULL, '12 tháng', 4.4, 55),
(132, 'Kieslect Kr Pro', 'Đồng hồ', 'Màn hình Always On giá rẻ.', 'Nghe gọi Bluetooth ổn định', NULL, NULL, '12 tháng', 4.2, 80),
(133, 'Vòng đeo tay Xiaomi Band 8', 'Đồng hồ', 'Vòng đeo tay quốc dân mới.', 'Màn hình 60Hz, Pin 16 ngày', NULL, NULL, '12 tháng', 4.5, 300),
(134, 'Huawei Band 9', 'Đồng hồ', 'Mỏng nhẹ, đeo như không đeo.', 'Theo dõi giấc ngủ chuyên sâu', NULL, NULL, '12 tháng', 4.4, 150),
(135, 'AirPods 2', 'Tai nghe', 'Tai nghe True Wireless phổ biến nhất.', 'Chip H1, Hey Siri', NULL, NULL, '12 tháng', 4.8, 1000),
(136, 'AirPods 3 Lightning', 'Tai nghe', 'Âm thanh vòm Spatial Audio.', 'Thiết kế mới, Pin 6h', NULL, NULL, '12 tháng', 4.6, 300),
(137, 'AirPods Pro 2 USB-C', 'Tai nghe', 'Chống ồn gấp 2 lần.', 'Chip H2, Hộp sạc tìm kiếm chính xác', NULL, NULL, '12 tháng', 4.9, 400),
(138, 'Samsung Galaxy Buds2 Pro', 'Tai nghe', 'Âm thanh Hi-Fi 24bit.', 'Chống ồn ANC thông minh', NULL, NULL, '12 tháng', 4.5, 150),
(139, 'Sony WF-1000XM5', 'Tai nghe', 'Đỉnh cao chống ồn TWS.', 'Màng loa Dynamic X, Hi-Res Audio', NULL, NULL, '12 tháng', 4.7, 50),
(140, 'Sony WH-CH520', 'Tai nghe', 'Tai nghe chụp tai giá rẻ pin trâu.', 'Pin 50 giờ, Nhẹ nhàng', NULL, NULL, '12 tháng', 4.4, 100),
(141, 'JBL Tour Pro 2', 'Tai nghe', 'Hộp sạc có màn hình cảm ứng.', 'Chống ồn True Adaptive', NULL, NULL, '12 tháng', 4.3, 30),
(142, 'JBL Flip 6', 'Loa', 'Loa di động kháng nước bụi.', 'Âm bass mạnh mẽ, IP67', NULL, NULL, '12 tháng', 4.6, 200),
(143, 'JBL Charge 5', 'Loa', 'Vừa nghe nhạc vừa sạc điện thoại.', 'Công suất 40W, Pin 20h', NULL, NULL, '12 tháng', 4.7, 180),
(144, 'JBL PartyBox Encore', 'Loa', 'Khuấy động mọi bữa tiệc.', 'Kèm 2 micro không dây, Đèn LED', NULL, NULL, '12 tháng', 4.8, 60),
(145, 'Marshall Emberton II', 'Loa', 'Nhỏ gọn, âm thanh 360 độ.', 'Thiết kế Iconic, Pin 30h', NULL, NULL, '12 tháng', 4.6, 90),
(146, 'Marshall Willen', 'Loa', 'Loa Marshall nhỏ nhất.', 'Có quai đeo, IP67', NULL, NULL, '12 tháng', 4.5, 120),
(147, 'Marshall Acton III', 'Loa', 'Loa để bàn bán chạy nhất.', 'Âm trường rộng hơn bản cũ', NULL, NULL, '12 tháng', 4.8, 150),
(148, 'Harman Kardon Onyx Studio 7', 'Loa', 'Thiết kế hành tinh độc lạ.', 'Bass sâu, Pin 8h', NULL, NULL, '12 tháng', 4.7, 100),
(149, 'Harman Kardon Go + Play 3', 'Loa', 'Sang trọng, công suất lớn.', 'Công suất 160W, Bluetooth 5.2', NULL, NULL, '12 tháng', 4.8, 40),
(150, 'Sony SRS-XB100', 'Loa', 'Nhỏ nhưng có võ.', 'Nhỏ gọn, chống nước IP67', NULL, NULL, '12 tháng', 4.4, 80),
(151, 'Loa thanh Samsung HW-C450', 'Loa', 'Nâng cấp âm thanh Tivi.', 'Loa siêu trầm không dây', NULL, NULL, '12 tháng', 4.3, 50),
(152, 'Tai nghe Gaming HyperX Cloud II', 'Tai nghe', 'Huyền thoại tai nghe FPS.', 'Giả lập 7.1, Khung nhôm', NULL, NULL, '24 tháng', 4.8, 200),
(153, 'Tai nghe Logitech G Pro X 2', 'Tai nghe', 'Tai nghe cho game thủ chuyên nghiệp.', 'Màng loa Graphene, Lightspeed', NULL, NULL, '24 tháng', 4.7, 30),
(154, 'Tai nghe Razer BlackShark V2 X', 'Tai nghe', 'Âm thanh Esport giá rẻ.', 'Driver TriForce 50mm', NULL, NULL, '24 tháng', 4.4, 90),
(155, 'Chuột Logitech G102 Lightsync', 'Phụ kiện', 'Chuột gaming quốc dân.', 'LED RGB, 8000 DPI', NULL, NULL, '24 tháng', 4.8, 2000),
(156, 'Chuột Logitech G304 Wireless', 'Phụ kiện', 'Không dây, độ trễ thấp.', 'Pin AA 250 giờ', NULL, NULL, '24 tháng', 4.7, 500),
(157, 'Chuột Razer Viper Mini', 'Phụ kiện', 'Siêu nhẹ, dành cho tay nhỏ.', 'Switch quang học, 61g', NULL, NULL, '24 tháng', 4.6, 300),
(158, 'Bàn phím cơ Akko 3098B Multi-Mode', 'Phụ kiện', 'Bàn phím màu sắc đẹp, gõ sướng.', 'Switch Akko V3, PBT Keycap', NULL, NULL, '12 tháng', 4.7, 100),
(159, 'Bàn phím cơ Keychron K2 Pro', 'Phụ kiện', 'Custom phím cơ dễ dàng.', 'QMK/VIA, Hotswap', NULL, NULL, '12 tháng', 4.8, 80),
(160, 'Bàn phím Logitech K380', 'Phụ kiện', 'Phím Bluetooth mỏng nhẹ.', 'Kết nối 3 thiết bị', NULL, NULL, '12 tháng', 4.5, 400),
(161, 'Sạc Anker 20W Nano', 'Phụ kiện', 'Sạc nhanh siêu nhỏ cho iPhone.', 'Công nghệ IQ3, Bảo vệ máy', NULL, NULL, '18 tháng', 4.9, 600),
(162, 'Sạc Ugreen Nexode 65W GaN', 'Phụ kiện', 'Sạc được cho Laptop và ĐT.', '3 cổng sạc, Công nghệ GaN', NULL, NULL, '18 tháng', 4.8, 200),
(163, 'Pin dự phòng Xiaomi Gen 3 20000mAh', 'Phụ kiện', 'Dung lượng khủng giá rẻ.', 'Sạc nhanh 18W', NULL, NULL, '12 tháng', 4.6, 300),
(164, 'Pin dự phòng Anker MagGo 10000mAh', 'Phụ kiện', 'Sạc không dây nam châm.', 'Hít lưng iPhone tiện lợi', NULL, NULL, '18 tháng', 4.7, 100),
(165, 'Webcam Logitech C270', 'Phụ kiện', 'Webcam học online giá rẻ.', 'HD 720p, Mic lọc ồn', NULL, NULL, '24 tháng', 4.4, 250),
(166, 'Tay cầm PS5 DualSense', 'Phụ kiện', 'Cảm giác game chân thực.', 'Haptic Feedback, Adaptive Trigger', NULL, NULL, '12 tháng', 4.9, 150),
(167, 'Màn hình Samsung Odyssey G5 27 inch', 'Màn hình', 'Màn hình cong chiến game.', '2K, 165Hz, 1ms', NULL, NULL, '24 tháng', 4.5, 80),
(168, 'Màn hình Asus ProArt PA248QV', 'Màn hình', 'Chuyên đồ họa chuẩn màu.', 'Delta E < 2, 100% sRGB', NULL, NULL, '36 tháng', 4.7, 60),
(169, 'Màn hình Dell UltraSharp U2422H', 'Màn hình', 'Ông vua màn hình văn phòng.', 'Thiết kế tràn viền, Cổng kết nối đa dạng', NULL, NULL, '36 tháng', 4.8, 100),
(170, 'RAM PC Corsair Vengeance RGB RS 16GB', 'Linh kiện', 'RAM đẹp, hiệu năng cao.', 'DDR4 3200MHz', NULL, NULL, '36 tháng', 4.9, 200),
(171, 'SSD Kingston NV2 500GB', 'Linh kiện', 'SSD Gen 4 giá rẻ.', 'Tốc độ 3500MB/s', NULL, NULL, '36 tháng', 4.6, 300),
(172, 'CPU Intel Core i5 12400F', 'Linh kiện', 'CPU quốc dân cho Gaming.', '6 nhân 12 luồng', NULL, NULL, '36 tháng', 4.9, 400),
(173, 'Card màn hình ASUS Dual RTX 3060', 'Linh kiện', 'Card đồ họa tầm trung tốt nhất.', 'VRAM 12GB, 2 Fan', NULL, NULL, '36 tháng', 4.8, 150),
(174, 'Google Chromecast with Google TV 4K', 'Phụ kiện', 'Biến Tivi thường thành Smart TV.', 'Remote giọng nói tiếng Việt', NULL, NULL, '12 tháng', 4.7, 90);

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
  `role` varchar(20) NOT NULL DEFAULT 'user',
  `balance` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `username`, `user_id`, `password`, `phone`, `address`, `email`, `role`, `balance`) VALUES
(12, 'hai', 0, '$2y$10$JnaJZvl9KE9J/1aMTLJ/m.V6PuwJkofZjROwojycZB1mJj/kVoHyK', '0255115661', 'p25', 'ajsdjw@gmail.com', 'user', 0),
(14, 'adminhai', 0, '$2y$10$6EZrlFmIWbiyxwA3lmdrlOR2drY1wwUqa1VDqDB2sl4rbDijbz0hG', '78878979', 'p25', 'qjsdjw@gmail.com', 'admin', 0),
(16, 'adminhai1', 0, '$2y$10$GIqXCD0XHChW/ZRUchBWOeJluhy1Isc4Emaqsb8XAHMy5GwQEEo/a', '7887897934', 'p25', 'qjsdjw@gmail.com', 'admin', 0),
(17, 'admin123', 0, '$2y$10$YZmhs0VOVF4F8Jhw3j9O9.0kk/A/PvjH5oqVFR2xeBtyur6D5mCBK', '89745', 'p24', 'ajdjw@gmail.com', 'admin', 0),
(18, 'hai2', 0, '$2y$10$u0SwD3ZBV8Ogd5W3NMmuHuX2zTbsZtlquLAeMZI0HnP01EwVm5fkS', '0347389473', 'nguyễn gia trí', 'dasdsa23@gmail.com', 'user', 0),
(19, 'admin1648', 0, '$2y$10$YhTXCS4dxul1R8uzDTv9KuAo8yKDk3reXVMaQ2i5/3MuHwvGeSWZ6', '0347389473', 'nguyễn gia trí', 'nhathai24082005@gmail.com', 'admin', 0),
(20, 'hairole1', 0, '$2y$10$QMR.jcBXN.3EsGHTE72f4OhPBHvGZkBRuQec96co6L0PK73ULjR6q', '0347389473', 'nguyễn gia trí', 'nhathai24082005@gmail.com', 'user', 0),
(21, 'haiadmin', 0, '$2y$10$HT4hgjv9/ZaFSP214ulcxemPlM0JocpMPKncGkTA41t9rbwOs9sY6', '0347389473', 'nguyễn gia trí', 'nhathai24082005@gmail.com', 'user', 0),
(22, 'admin hai', 0, '$2y$10$PMUop57VVnpkG.3GogXjduqti3sHBy222u08CxrxT5p0FHodgQG22', '0347389473', 'nguyễn gia trí', 'nhathai24082005@gmail.com', 'user', 0),
(23, 'adminhai123', 0, '$2y$10$SnN4ZpiXDCL8jngrFvwGxutq24hc.p88blnjR4nMAfSwGVH6Rsr/.', '0347389473', 'nguyễn gia trí', 'nhathai24082005@gmail.com', 'user', 0),
(24, 'hai12', 0, '$2y$10$KjlQCizWcQfZsMz.AFC1Z.ZIu7DSCELmNk13xJeREjdutyV5fx9Ju', '0347389473', 'nguyễn gia trí, p25, Bình Thạnh', 'dasdsa23@gmail.com', 'user', 0);

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
  MODIFY `id_bien_the` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=187;

--
-- AUTO_INCREMENT cho bảng `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  MODIFY `id_chi_tiet` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT cho bảng `danh_gia_san_pham`
--
ALTER TABLE `danh_gia_san_pham`
  MODIFY `id_danh_gia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT cho bảng `don_hang`
--
ALTER TABLE `don_hang`
  MODIFY `id_don_hang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT cho bảng `gio_hang`
--
ALTER TABLE `gio_hang`
  MODIFY `id_gio_hang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT cho bảng `hinh_anh_san_pham`
--
ALTER TABLE `hinh_anh_san_pham`
  MODIFY `id_hinh_anh` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=172;

--
-- AUTO_INCREMENT cho bảng `san_pham`
--
ALTER TABLE `san_pham`
  MODIFY `id_san_pham` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=175;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

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
