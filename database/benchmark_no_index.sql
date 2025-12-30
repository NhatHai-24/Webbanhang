-- ============================================================
-- BENCHMARK: KỊCH BẢN 1 - KHÔNG CÓ INDEX (CHẬM)
-- ============================================================

-- 1. Xóa sạch các index benchmark (để đảm bảo đo lường chính xác)
DROP INDEX IF EXISTS idx_sp_loai ON san_pham;
DROP INDEX IF EXISTS idx_sp_ten ON san_pham;
DROP INDEX IF EXISTS idx_sp_loai_ten ON san_pham;
ALTER TABLE san_pham DROP INDEX IF EXISTS ft_sp_ten;

DROP INDEX IF EXISTS idx_bt_gia ON bien_the_san_pham;
DROP INDEX IF EXISTS idx_bt_sp_gia ON bien_the_san_pham;
DROP INDEX IF EXISTS idx_bt_mau ON bien_the_san_pham;
DROP INDEX IF EXISTS idx_bt_tonkho ON bien_the_san_pham;

DROP INDEX IF EXISTS idx_ha_sp_daidien ON hinh_anh_san_pham;

DROP INDEX IF EXISTS idx_dg_ngay ON danh_gia_san_pham;

-- 2. Chạy Test Queries
SET profiling = 1;
FLUSH STATUS;

-- Test 1: Tìm kiếm LIKE (Full Table Scan)
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham 
FROM san_pham WHERE ten_san_pham LIKE '%iPhone%';

-- Test 2: Lọc theo danh mục
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham 
FROM san_pham WHERE loai_san_pham = 'Điện thoại';

-- Test 3: JOIN nhiều bảng và tính toán
SELECT SQL_NO_CACHE sp.id_san_pham, sp.ten_san_pham, MIN(bt.gia_ban) AS gia
FROM san_pham sp
JOIN bien_the_san_pham bt ON sp.id_san_pham = bt.id_san_pham
WHERE sp.loai_san_pham = 'Laptop'
GROUP BY sp.id_san_pham;

SHOW PROFILES;
