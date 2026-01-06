-- BENCHMARK: CÓ INDEX (NHANH)
-- Tạo các index thiết yếu để tối ưu hiệu suất truy vấn
-- Dành cho database webbh (1 triệu+ sản phẩm)

-- =====================
-- PHẦN 1: TẠO INDEX
-- =====================

-- Bảng san_pham (quan trọng nhất, 1M+ rows)
CREATE INDEX IF NOT EXISTS idx_sp_loai ON san_pham(loai_san_pham);
ALTER TABLE san_pham ADD FULLTEXT INDEX ft_sp_ten (ten_san_pham);

-- Bảng bien_the_san_pham (dùng cho JOIN lấy giá)
CREATE INDEX IF NOT EXISTS idx_bt_sp_gia ON bien_the_san_pham(id_san_pham, gia_ban);

-- Bảng hinh_anh_san_pham (lấy ảnh đại diện)
CREATE INDEX IF NOT EXISTS idx_ha_sp_daidien ON hinh_anh_san_pham(id_san_pham, la_anh_dai_dien);

-- Bảng danh_gia_san_pham
CREATE INDEX IF NOT EXISTS idx_dg_sp ON danh_gia_san_pham(id_san_pham);

-- Bảng don_hang
CREATE INDEX IF NOT EXISTS idx_dh_nguoidung ON don_hang(id_nguoi_dung);

-- Cập nhật thống kê cho MySQL optimizer
ANALYZE TABLE san_pham, bien_the_san_pham, hinh_anh_san_pham;


-- =====================
-- PHẦN 2: TEST QUERIES
-- =====================
SET profiling = 1;

-- Test 1: Tìm kiếm FULLTEXT (thay thế LIKE)
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham 
FROM san_pham 
WHERE MATCH(ten_san_pham) AGAINST('iPhone' IN BOOLEAN MODE);

-- Test 2: Lọc theo danh mục
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham 
FROM san_pham 
WHERE loai_san_pham = 'Điện thoại';

-- Test 3: Query trang sản phẩm (JOIN 3 bảng)
SELECT SQL_NO_CACHE 
    sp.id_san_pham, sp.ten_san_pham, sp.loai_san_pham,
    ha.url_hinh_anh, bt.gia_ban
FROM san_pham sp
LEFT JOIN hinh_anh_san_pham ha ON ha.id_san_pham = sp.id_san_pham AND ha.la_anh_dai_dien = 1
LEFT JOIN bien_the_san_pham bt ON bt.id_san_pham = sp.id_san_pham
WHERE sp.loai_san_pham = 'Laptop'
ORDER BY sp.id_san_pham DESC
LIMIT 52;

-- Test 4: Tìm kiếm + phân trang
SELECT SQL_NO_CACHE 
    sp.id_san_pham, sp.ten_san_pham, sp.loai_san_pham, 
    LEFT(sp.mo_ta, 150) AS mo_ta, sp.bao_hanh,
    ha.url_hinh_anh, bt.gia_ban
FROM san_pham sp
LEFT JOIN hinh_anh_san_pham ha ON ha.id_san_pham = sp.id_san_pham AND ha.la_anh_dai_dien = 1
LEFT JOIN bien_the_san_pham bt ON bt.id_san_pham = sp.id_san_pham
WHERE MATCH(sp.ten_san_pham) AGAINST('Samsung' IN BOOLEAN MODE)
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
-- TÓM TẮT: 6 index thiết yếu
-- ===========================================
-- 1. idx_sp_loai       -> Lọc theo danh mục
-- 2. ft_sp_ten         -> Tìm kiếm fulltext
-- 3. idx_bt_sp_gia     -> JOIN lấy giá
-- 4. idx_ha_sp_daidien -> Lấy ảnh đại diện
-- 5. idx_dg_sp         -> Lấy đánh giá
-- 6. idx_dh_nguoidung  -> Lấy đơn hàng user
