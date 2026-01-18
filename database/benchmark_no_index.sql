-- BENCHMARK: KHÔNG CÓ INDEX
USE webbh;

-- Xóa các index hiện có (trừ PRIMARY KEY)
ALTER TABLE bien_the_san_pham DROP INDEX id_san_pham, DROP INDEX ma_sku;
ALTER TABLE chi_tiet_don_hang DROP INDEX id_don_hang;
ALTER TABLE danh_gia_san_pham DROP INDEX id_san_pham;
ALTER TABLE don_hang DROP INDEX id_nguoi_dung;
ALTER TABLE gio_hang DROP INDEX id_bien_the, DROP INDEX id_nguoi_dung, DROP INDEX id_san_pham;
ALTER TABLE hinh_anh_san_pham DROP INDEX id_san_pham;
ALTER TABLE san_pham DROP INDEX ft_sp_ten;

-- Test queries
SET profiling = 1;

SELECT SQL_NO_CACHE id_san_pham, ten_san_pham FROM san_pham WHERE ten_san_pham LIKE '%iPhone%';
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham FROM san_pham WHERE loai_san_pham = 'Điện thoại';
SELECT SQL_NO_CACHE * FROM don_hang WHERE id_nguoi_dung = 1 ORDER BY ngay_dat DESC;
SELECT SQL_NO_CACHE * FROM don_hang WHERE trang_thai = 'Cho_xac_nhan';
SELECT SQL_NO_CACHE id_san_pham, ten_san_pham, diem_danh_gia_trung_binh FROM san_pham WHERE diem_danh_gia_trung_binh >= 4.0 ORDER BY diem_danh_gia_trung_binh DESC LIMIT 50;
SELECT SQL_NO_CACHE gh.*, sp.ten_san_pham FROM gio_hang gh JOIN san_pham sp ON sp.id_san_pham = gh.id_san_pham WHERE gh.id_nguoi_dung = 1;

SHOW PROFILES;