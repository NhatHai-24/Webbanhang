-- ============================================================
-- BENCHMARK: KỊCH BẢN 2 - CÓ INDEX (NHANH)
-- ============================================================

-- 1. Tạo các Index tối ưu
-- Index cho san_pham
CREATE INDEX idx_sp_loai ON san_pham(loai_san_pham);
CREATE INDEX idx_sp_ten ON san_pham(ten_san_pham(100));
-- Composite index (loại + tên) phục vụ query vừa lọc vừa tìm
CREATE INDEX idx_sp_loai_ten ON san_pham(loai_san_pham, ten_san_pham(50));
-- Fulltext index cho tìm kiếm văn bản
ALTER TABLE san_pham ADD FULLTEXT INDEX ft_sp_ten (ten_san_pham);

-- 2. Index cho bien_the_san_pham
CREATE INDEX idx_bt_gia ON bien_the_san_pham(gia_ban);
-- Composite index (id_sp + gia) tối ưu cho việc JOIN và lấy giá min/max
CREATE INDEX idx_bt_sp_gia ON bien_the_san_pham(id_san_pham, gia_ban);
CREATE INDEX idx_bt_mau ON bien_the_san_pham(mau_sac);
CREATE INDEX idx_bt_tonkho ON bien_the_san_pham(so_luong_ton_kho);

-- 3. Index cho hinh_anh_san_pham
-- Tối ưu lấy ảnh đại diện của sản phẩm
CREATE INDEX idx_ha_sp_daidien ON hinh_anh_san_pham(id_san_pham, la_anh_dai_dien);

-- 4. Index cho danh_gia_san_pham
CREATE INDEX idx_dg_ngay ON danh_gia_san_pham(ngay_danh_gia);

-- Cập nhật thống kê cho MySQL Optimizer
ANALYZE TABLE san_pham, bien_the_san_pham, hinh_anh_san_pham, danh_gia_san_pham;

-- ============================================================
-- TEST QUERIES (CHẠY SAU KHI CÓ INDEX - SẼ NHANH)
-- ============================================================
SET profiling = 1;
FLUSH STATUS;

-- Test 1: Tìm kiếm FULLTEXT (Thay thế LIKE)
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham 
FROM san_pham WHERE MATCH(ten_san_pham) AGAINST('iPhone' IN BOOLEAN MODE);

-- Test 2: Lọc theo danh mục (Sử dụng idx_sp_loai)
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham 
FROM san_pham WHERE loai_san_pham = 'Điện thoại';

-- Test 3: JOIN tối ưu (Sử dụng idx_sp_loai và idx_bt_sp_gia)
SELECT SQL_NO_CACHE sp.id_san_pham, sp.ten_san_pham, MIN(bt.gia_ban) AS gia
FROM san_pham sp
JOIN bien_the_san_pham bt ON sp.id_san_pham = bt.id_san_pham
WHERE sp.loai_san_pham = 'Laptop'
GROUP BY sp.id_san_pham;

SHOW PROFILES;

-- ============================================================
--  KIỂM TRA INDEX
-- ============================================================
SELECT TABLE_NAME, INDEX_NAME, COLUMN_NAME 
FROM information_schema.STATISTICS 
WHERE TABLE_SCHEMA = 'webbh' 
AND INDEX_NAME NOT IN ('PRIMARY', 'ma_sku', 'id_san_pham', 'id_don_hang', 'id_nguoi_dung', 'id_bien_the', 'username')
ORDER BY TABLE_NAME, INDEX_NAME;
