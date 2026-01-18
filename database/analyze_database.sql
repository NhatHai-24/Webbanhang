-- PHÂN TÍCH DATABASE
USE webbh;

-- Đếm số dòng
SELECT 'san_pham' AS 'Bảng', COUNT(*) AS 'Số dòng' FROM san_pham
UNION ALL SELECT 'bien_the_san_pham', COUNT(*) FROM bien_the_san_pham
UNION ALL SELECT 'hinh_anh_san_pham', COUNT(*) FROM hinh_anh_san_pham
UNION ALL SELECT 'danh_gia_san_pham', COUNT(*) FROM danh_gia_san_pham
UNION ALL SELECT 'users', COUNT(*) FROM users
UNION ALL SELECT 'don_hang', COUNT(*) FROM don_hang
UNION ALL SELECT 'chi_tiet_don_hang', COUNT(*) FROM chi_tiet_don_hang
UNION ALL SELECT 'gio_hang', COUNT(*) FROM gio_hang;

-- Xem index từng bảng
SHOW INDEX FROM san_pham;
SHOW INDEX FROM bien_the_san_pham;
SHOW INDEX FROM hinh_anh_san_pham;
SHOW INDEX FROM danh_gia_san_pham;
SHOW INDEX FROM users;
SHOW INDEX FROM don_hang;
SHOW INDEX FROM chi_tiet_don_hang;
SHOW INDEX FROM gio_hang;