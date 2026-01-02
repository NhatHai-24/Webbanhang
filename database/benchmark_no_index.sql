-- BENCHMARK: KHÔNG CÓ INDEX (CHẬM)
-- Xóa tất cả index để so sánh hiệu suất

-- ============================================================
-- PHẦN 1: XÓA TẤT CẢ CÁC INDEX BENCHMARK
-- ============================================================

-- 1. BẢNG san_pham
DROP INDEX IF EXISTS idx_sp_loai ON san_pham;
DROP INDEX IF EXISTS idx_sp_ten ON san_pham;
DROP INDEX IF EXISTS idx_sp_loai_ten ON san_pham;
DROP INDEX IF EXISTS idx_sp_diem ON san_pham;
ALTER TABLE san_pham DROP INDEX IF EXISTS ft_sp_ten;

-- 2. BẢNG bien_the_san_pham
DROP INDEX IF EXISTS idx_bt_gia ON bien_the_san_pham;
DROP INDEX IF EXISTS idx_bt_sp_gia ON bien_the_san_pham;
DROP INDEX IF EXISTS idx_bt_mau ON bien_the_san_pham;
DROP INDEX IF EXISTS idx_bt_tonkho ON bien_the_san_pham;
DROP INDEX IF EXISTS idx_bt_sku ON bien_the_san_pham;

-- 3. BẢNG hinh_anh_san_pham    
DROP INDEX IF EXISTS idx_ha_sp_daidien ON hinh_anh_san_pham;
DROP INDEX IF EXISTS idx_ha_sp_thutu ON hinh_anh_san_pham;

-- 4. BẢNG danh_gia_san_pham
DROP INDEX IF EXISTS idx_dg_sp ON danh_gia_san_pham;
DROP INDEX IF EXISTS idx_dg_ngay ON danh_gia_san_pham;
DROP INDEX IF EXISTS idx_dg_sp_diem ON danh_gia_san_pham;

-- 5. BẢNG don_hang
DROP INDEX IF EXISTS idx_dh_nguoidung ON don_hang;
DROP INDEX IF EXISTS idx_dh_trangthai ON don_hang;
DROP INDEX IF EXISTS idx_dh_ngaydat ON don_hang;
DROP INDEX IF EXISTS idx_dh_user_trangthai ON don_hang;

-- 6. BẢNG chi_tiet_don_hang
DROP INDEX IF EXISTS idx_ctdh_sp ON chi_tiet_don_hang;
DROP INDEX IF EXISTS idx_ctdh_bienthe ON chi_tiet_don_hang;
DROP INDEX IF EXISTS idx_ctdh_sp_soluong ON chi_tiet_don_hang;

-- 7. BẢNG gio_hang
DROP INDEX IF EXISTS idx_gh_nguoidung ON gio_hang;
DROP INDEX IF EXISTS idx_gh_sp ON gio_hang;
DROP INDEX IF EXISTS idx_gh_user_sp ON gio_hang;

-- 8. BẢNG users
DROP INDEX IF EXISTS idx_users_role ON users;
DROP INDEX IF EXISTS idx_users_email ON users;
DROP INDEX IF EXISTS idx_users_phone ON users;

-- ============================================================
-- PHẦN 2: CHẠY TEST QUERIES (KHÔNG CÓ INDEX - SẼ CHẬM)
-- ============================================================
SET profiling = 1;
FLUSH STATUS;

-- ----- NHÓM 1: TÌM KIẾM SẢN PHẨM (Full Table Scan) -----

-- Test 1.1: Tìm kiếm LIKE (Full Table Scan - RẤT CHẬM)
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham 
FROM san_pham WHERE ten_san_pham LIKE '%iPhone%';

-- Test 1.2: Lọc theo danh mục (Full Table Scan)
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham 
FROM san_pham WHERE loai_san_pham = 'Điện thoại';

-- Test 1.3: JOIN nhiều bảng (Full Table Scan trên cả 2 bảng)
SELECT SQL_NO_CACHE sp.id_san_pham, sp.ten_san_pham, MIN(bt.gia_ban) AS gia
FROM san_pham sp
JOIN bien_the_san_pham bt ON sp.id_san_pham = bt.id_san_pham
WHERE sp.loai_san_pham = 'Laptop'
GROUP BY sp.id_san_pham;

-- Test 1.4: Lọc theo khoảng giá (Full Table Scan)
SELECT SQL_NO_CACHE sp.id_san_pham, sp.ten_san_pham, bt.gia_ban
FROM san_pham sp
JOIN bien_the_san_pham bt ON sp.id_san_pham = bt.id_san_pham
WHERE bt.gia_ban BETWEEN 5000000 AND 15000000
ORDER BY bt.gia_ban ASC;

-- ----- NHÓM 2: ĐƠN HÀNG (Full Table Scan) -----

-- Test 2.1: Lấy đơn hàng của user
SELECT SQL_NO_CACHE * FROM don_hang 
WHERE id_nguoi_dung = 12 
ORDER BY ngay_dat DESC;

-- Test 2.2: Lọc đơn hàng theo trạng thái
SELECT SQL_NO_CACHE * FROM don_hang 
WHERE trang_thai = 'Cho_xac_nhan';

-- Test 2.3: Thống kê sản phẩm bán chạy
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham, SUM(so_luong) AS tong_ban
FROM chi_tiet_don_hang
GROUP BY id_san_pham, ten_san_pham
ORDER BY tong_ban DESC
LIMIT 10;

-- ----- NHÓM 3: ĐÁNH GIÁ (Full Table Scan) -----

-- Test 3.1: Lấy đánh giá của sản phẩm
SELECT SQL_NO_CACHE * FROM danh_gia_san_pham 
WHERE id_san_pham = 14
ORDER BY ngay_danh_gia DESC;

-- Test 3.2: Sản phẩm được đánh giá cao nhất
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham, diem_danh_gia_trung_binh
FROM san_pham
WHERE diem_danh_gia_trung_binh > 0
ORDER BY diem_danh_gia_trung_binh DESC
LIMIT 10;

-- ============================================================
-- PHẦN 3: XEM KẾT QUẢ PROFILING
-- ============================================================
SHOW PROFILES;
