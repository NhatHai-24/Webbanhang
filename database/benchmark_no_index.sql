-- BENCHMARK: KHÔNG CÓ INDEX (CHẬM)
-- Xóa các index để so sánh hiệu suất với benchmark_with_index.sql
-- Dành cho database webbh (1 triệu+ sản phẩm)

-- =====================
-- PHẦN 1: XÓA INDEX
-- =====================

-- Bảng san_pham
ALTER TABLE san_pham DROP INDEX IF EXISTS idx_sp_loai;
ALTER TABLE san_pham DROP INDEX IF EXISTS ft_sp_ten;

-- Bảng bien_the_san_pham
ALTER TABLE bien_the_san_pham DROP INDEX IF EXISTS idx_bt_sp_gia;

-- Bảng hinh_anh_san_pham
ALTER TABLE hinh_anh_san_pham DROP INDEX IF EXISTS idx_ha_sp_daidien;

-- Bảng danh_gia_san_pham
ALTER TABLE danh_gia_san_pham DROP INDEX IF EXISTS idx_dg_sp;

-- Bảng don_hang
ALTER TABLE don_hang DROP INDEX IF EXISTS idx_dh_nguoidung;

-- Cập nhật thống kê
ANALYZE TABLE san_pham, bien_the_san_pham, hinh_anh_san_pham;


-- =====================
-- PHẦN 2: TEST QUERIES
-- =====================
SET profiling = 1;

-- Test 1: Tìm kiếm LIKE (chậm vì full table scan)
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham 
FROM san_pham 
WHERE ten_san_pham LIKE '%iPhone%';

-- Test 2: Lọc theo danh mục (chậm)
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham 
FROM san_pham 
WHERE loai_san_pham = 'Điện thoại';

-- Test 3: Query trang sản phẩm (JOIN 3 bảng - rất chậm)
SELECT SQL_NO_CACHE 
    sp.id_san_pham, sp.ten_san_pham, sp.loai_san_pham,
    ha.url_hinh_anh, bt.gia_ban
FROM san_pham sp
LEFT JOIN hinh_anh_san_pham ha ON ha.id_san_pham = sp.id_san_pham AND ha.la_anh_dai_dien = 1
LEFT JOIN bien_the_san_pham bt ON bt.id_san_pham = sp.id_san_pham
WHERE sp.loai_san_pham = 'Laptop'
ORDER BY sp.id_san_pham DESC
LIMIT 52;

-- Test 4: Tìm kiếm + phân trang (chậm)
SELECT SQL_NO_CACHE 
    sp.id_san_pham, sp.ten_san_pham, sp.loai_san_pham, 
    LEFT(sp.mo_ta, 150) AS mo_ta, sp.bao_hanh,
    ha.url_hinh_anh, bt.gia_ban
FROM san_pham sp
LEFT JOIN hinh_anh_san_pham ha ON ha.id_san_pham = sp.id_san_pham AND ha.la_anh_dai_dien = 1
LEFT JOIN bien_the_san_pham bt ON bt.id_san_pham = sp.id_san_pham
WHERE sp.ten_san_pham LIKE '%Samsung%'
ORDER BY sp.loai_san_pham, sp.id_san_pham
LIMIT 52 OFFSET 0;

-- Test 5: Lấy đơn hàng của user
SELECT SQL_NO_CACHE * FROM don_hang 
WHERE id_nguoi_dung = 12 
ORDER BY ngay_dat DESC;

-- Test 6: Lấy đánh giá sản phẩm
SELECT SQL_NO_CACHE * FROM danh_gia_san_pham 
WHERE id_san_pham = 14
ORDER BY ngay_danh_gia DESC;

-- Xem kết quả
SHOW PROFILES;


-- ===========================================
-- HƯỚNG DẪN BENCHMARK
-- ===========================================
-- Bước 1: Chạy file này -> ghi lại thời gian từ SHOW PROFILES
-- Bước 2: Chạy benchmark_with_index.sql -> ghi lại thời gian
-- Bước 3: So sánh kết quả
--
-- Kỳ vọng (với 1M+ sản phẩm):
-- +---------------------------+--------------+------------+
-- | Query                     | Không Index  | Có Index   |
-- +---------------------------+--------------+------------+
-- | Tìm kiếm LIKE             | 5-15 giây    | 10-50ms    |
-- | Lọc theo danh mục         | 2-5 giây     | 20-80ms    |
-- | JOIN 3 bảng               | 10-30 giây   | 50-200ms   |
-- +---------------------------+--------------+------------+
