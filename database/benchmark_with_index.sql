-- BENCHMARK: CÓ INDEX (NHANH)
-- Tối ưu cho tất cả 8 bảng trong database webbh

-- ============================================================
-- PHẦN 1: TẠO CÁC INDEX TỐI ƯU
-- ============================================================

-- -----------------------------------------------
-- 1. BẢNG san_pham (Sản phẩm - 1 triệu+ dòng)
-- -----------------------------------------------
-- Index đơn cho lọc theo danh mục
CREATE INDEX idx_sp_loai ON san_pham(loai_san_pham);

-- Index cho tìm kiếm theo tên (prefix index để tiết kiệm dung lượng)
CREATE INDEX idx_sp_ten ON san_pham(ten_san_pham(100));

-- Composite index (loại + tên) phục vụ query vừa lọc vừa tìm
CREATE INDEX idx_sp_loai_ten ON san_pham(loai_san_pham, ten_san_pham(50));

-- Fulltext index cho tìm kiếm văn bản nhanh
ALTER TABLE san_pham ADD FULLTEXT INDEX ft_sp_ten (ten_san_pham);

-- Index cho điểm đánh giá (sắp xếp sản phẩm theo rating)
CREATE INDEX idx_sp_diem ON san_pham(diem_danh_gia_trung_binh);

-- -----------------------------------------------
-- 2. BẢNG bien_the_san_pham (Biến thể - 1 triệu+ dòng)
-- -----------------------------------------------
-- Index cho lọc theo giá
CREATE INDEX idx_bt_gia ON bien_the_san_pham(gia_ban);

-- Composite index (id_sp + gia) tối ưu cho việc JOIN và lấy giá min/max
CREATE INDEX idx_bt_sp_gia ON bien_the_san_pham(id_san_pham, gia_ban);

-- Index cho lọc theo màu sắc
CREATE INDEX idx_bt_mau ON bien_the_san_pham(mau_sac);

-- Index cho kiểm tra tồn kho
CREATE INDEX idx_bt_tonkho ON bien_the_san_pham(so_luong_ton_kho);

-- Index cho SKU (tìm kiếm nhanh theo mã)
CREATE INDEX idx_bt_sku ON bien_the_san_pham(ma_sku);

-- -----------------------------------------------
-- 3. BẢNG hinh_anh_san_pham (Hình ảnh - 1 triệu+ dòng)
-- -----------------------------------------------
-- Tối ưu lấy ảnh đại diện của sản phẩm
CREATE INDEX idx_ha_sp_daidien ON hinh_anh_san_pham(id_san_pham, la_anh_dai_dien);

-- Index cho sắp xếp thứ tự hiển thị
CREATE INDEX idx_ha_sp_thutu ON hinh_anh_san_pham(id_san_pham, thu_tu_hien_thi);

-- -----------------------------------------------
-- 4. BẢNG danh_gia_san_pham (Đánh giá)
-- -----------------------------------------------
-- Index cho lấy đánh giá theo sản phẩm
CREATE INDEX idx_dg_sp ON danh_gia_san_pham(id_san_pham);

-- Index cho sắp xếp theo ngày đánh giá
CREATE INDEX idx_dg_ngay ON danh_gia_san_pham(ngay_danh_gia);

-- Composite index để tính điểm trung bình theo sản phẩm
CREATE INDEX idx_dg_sp_diem ON danh_gia_san_pham(id_san_pham, diem_danh_gia);

-- -----------------------------------------------
-- 5. BẢNG don_hang (Đơn hàng)
-- -----------------------------------------------
-- Index cho lấy đơn hàng của người dùng
CREATE INDEX idx_dh_nguoidung ON don_hang(id_nguoi_dung);

-- Index cho lọc theo trạng thái đơn hàng
CREATE INDEX idx_dh_trangthai ON don_hang(trang_thai);

-- Index cho sắp xếp/lọc theo ngày đặt
CREATE INDEX idx_dh_ngaydat ON don_hang(ngay_dat);

-- Composite index cho dashboard admin (user + trạng thái)
CREATE INDEX idx_dh_user_trangthai ON don_hang(id_nguoi_dung, trang_thai);

-- -----------------------------------------------
-- 6. BẢNG chi_tiet_don_hang (Chi tiết đơn hàng)
-- -----------------------------------------------
-- Index cho thống kê sản phẩm bán chạy
CREATE INDEX idx_ctdh_sp ON chi_tiet_don_hang(id_san_pham);

-- Index cho thống kê biến thể bán
CREATE INDEX idx_ctdh_bienthe ON chi_tiet_don_hang(id_bien_the);

-- Composite index cho báo cáo doanh thu theo sản phẩm
CREATE INDEX idx_ctdh_sp_soluong ON chi_tiet_don_hang(id_san_pham, so_luong, don_gia);

-- -----------------------------------------------
-- 7. BẢNG gio_hang (Giỏ hàng)
-- -----------------------------------------------
-- Index cho lấy giỏ hàng của người dùng
CREATE INDEX idx_gh_nguoidung ON gio_hang(id_nguoi_dung);

-- Index cho kiểm tra sản phẩm trong giỏ
CREATE INDEX idx_gh_sp ON gio_hang(id_san_pham);

-- Composite index cho lấy toàn bộ giỏ hàng của user
CREATE INDEX idx_gh_user_sp ON gio_hang(id_nguoi_dung, id_san_pham, id_bien_the);

-- -----------------------------------------------
-- 8. BẢNG users (Người dùng)
-- -----------------------------------------------
-- Index cho lọc theo role (admin/user)
CREATE INDEX idx_users_role ON users(role);

-- Index cho tìm kiếm theo email (prefix index)
CREATE INDEX idx_users_email ON users(email(100));

-- Index cho tìm kiếm theo số điện thoại
CREATE INDEX idx_users_phone ON users(phone);

-- ============================================================
-- PHẦN 2: CẬP NHẬT THỐNG KÊ CHO MYSQL OPTIMIZER
-- ============================================================
ANALYZE TABLE san_pham, bien_the_san_pham, hinh_anh_san_pham, 
             danh_gia_san_pham, don_hang, chi_tiet_don_hang, 
             gio_hang, users;

-- ============================================================
-- PHẦN 3: TEST QUERIES (CHẠY SAU KHI CÓ INDEX - SẼ NHANH)
-- ============================================================
SET profiling = 1;
FLUSH STATUS;

-- ----- NHÓM 1: TÌM KIẾM SẢN PHẨM -----

-- Test 1.1: Tìm kiếm FULLTEXT (Thay thế LIKE)
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham 
FROM san_pham WHERE MATCH(ten_san_pham) AGAINST('iPhone' IN BOOLEAN MODE);

-- Test 1.2: Lọc theo danh mục (Sử dụng idx_sp_loai)
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham 
FROM san_pham WHERE loai_san_pham = 'Điện thoại';

-- Test 1.3: JOIN tối ưu (Sử dụng idx_sp_loai và idx_bt_sp_gia)
SELECT SQL_NO_CACHE sp.id_san_pham, sp.ten_san_pham, MIN(bt.gia_ban) AS gia
FROM san_pham sp
JOIN bien_the_san_pham bt ON sp.id_san_pham = bt.id_san_pham
WHERE sp.loai_san_pham = 'Laptop'
GROUP BY sp.id_san_pham;

-- Test 1.4: Lọc theo khoảng giá (Sử dụng idx_bt_gia)
SELECT SQL_NO_CACHE sp.id_san_pham, sp.ten_san_pham, bt.gia_ban
FROM san_pham sp
JOIN bien_the_san_pham bt ON sp.id_san_pham = bt.id_san_pham
WHERE bt.gia_ban BETWEEN 5000000 AND 15000000
ORDER BY bt.gia_ban ASC;

-- ----- NHÓM 2: ĐƠN HÀNG -----

-- Test 2.1: Lấy đơn hàng của user (Sử dụng idx_dh_nguoidung)
SELECT SQL_NO_CACHE * FROM don_hang 
WHERE id_nguoi_dung = 12 
ORDER BY ngay_dat DESC;

-- Test 2.2: Lọc đơn hàng theo trạng thái (Sử dụng idx_dh_trangthai)
SELECT SQL_NO_CACHE * FROM don_hang 
WHERE trang_thai = 'Cho_xac_nhan';

-- Test 2.3: Thống kê sản phẩm bán chạy (Sử dụng idx_ctdh_sp)
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham, SUM(so_luong) AS tong_ban
FROM chi_tiet_don_hang
GROUP BY id_san_pham, ten_san_pham
ORDER BY tong_ban DESC
LIMIT 10;

-- ----- NHÓM 3: ĐÁNH GIÁ -----

-- Test 3.1: Lấy đánh giá của sản phẩm (Sử dụng idx_dg_sp)
SELECT SQL_NO_CACHE * FROM danh_gia_san_pham 
WHERE id_san_pham = 14
ORDER BY ngay_danh_gia DESC;

-- Test 3.2: Sản phẩm được đánh giá cao nhất (Sử dụng idx_sp_diem)
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham, diem_danh_gia_trung_binh
FROM san_pham
WHERE diem_danh_gia_trung_binh > 0
ORDER BY diem_danh_gia_trung_binh DESC
LIMIT 10;

-- ============================================================
-- PHẦN 4: XEM KẾT QUẢ PROFILING
-- ============================================================
SHOW PROFILES;
