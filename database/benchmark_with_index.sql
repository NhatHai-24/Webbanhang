-- BENCHMARK: CÓ INDEX
USE webbh;

-- Tạo lại các index (giống như trong database gốc)
CREATE INDEX id_san_pham ON bien_the_san_pham(id_san_pham);
CREATE INDEX ma_sku ON bien_the_san_pham(ma_sku);
CREATE INDEX id_don_hang ON chi_tiet_don_hang(id_don_hang);
CREATE INDEX id_san_pham ON danh_gia_san_pham(id_san_pham);
CREATE INDEX id_nguoi_dung ON don_hang(id_nguoi_dung);
CREATE INDEX id_bien_the ON gio_hang(id_bien_the);
CREATE INDEX id_nguoi_dung ON gio_hang(id_nguoi_dung);
CREATE INDEX id_san_pham ON gio_hang(id_san_pham);
CREATE INDEX id_san_pham ON hinh_anh_san_pham(id_san_pham);
ALTER TABLE san_pham ADD FULLTEXT INDEX ft_sp_ten (ten_san_pham);

ANALYZE TABLE san_pham, bien_the_san_pham, hinh_anh_san_pham, danh_gia_san_pham, don_hang, chi_tiet_don_hang, gio_hang;

-- Test queries
SET profiling = 1;

SELECT SQL_NO_CACHE id_san_pham, ten_san_pham FROM san_pham WHERE ten_san_pham LIKE '%iPhone%' LIMIT 50;
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham FROM san_pham WHERE loai_san_pham = 'Điện thoại' LIMIT 50;
SELECT SQL_NO_CACHE * FROM don_hang WHERE id_nguoi_dung = 1 ORDER BY ngay_dat DESC;
SELECT SQL_NO_CACHE * FROM don_hang WHERE trang_thai = 'Cho_xac_nhan' LIMIT 50;
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham, diem_danh_gia_trung_binh FROM san_pham WHERE diem_danh_gia_trung_binh >= 4.0 ORDER BY diem_danh_gia_trung_binh DESC LIMIT 50;
SELECT SQL_NO_CACHE gh.*, sp.ten_san_pham FROM gio_hang gh JOIN san_pham sp ON sp.id_san_pham = gh.id_san_pham WHERE gh.id_nguoi_dung = 1;

SHOW PROFILES;
