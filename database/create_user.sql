-- =====================================================
-- TẠO USER MỚI CHO MYSQL (XAMPP)
-- =====================================================
-- Chạy script này bằng tài khoản root
-- Cách chạy: 
--   1. Mở phpMyAdmin -> Tab SQL -> Paste code -> Thực thi
--   2. Hoặc: mysql -u root < create_user.sql
-- =====================================================

-- Tạo user mới với tên 'technova_user' và password 'TechNova@2026'
-- Bạn có thể thay đổi tên user và password theo ý muốn

CREATE USER IF NOT EXISTS 'technova_user'@'localhost' 
IDENTIFIED BY 'TechNova@2026';

-- Cấp quyền cho user trên database webbh
-- Các quyền cơ bản để chạy website: SELECT, INSERT, UPDATE, DELETE
GRANT SELECT, INSERT, UPDATE, DELETE ON webbh.* TO 'technova_user'@'localhost';

-- Nếu cần thêm quyền tạo/xóa index (cho benchmark):
GRANT CREATE, DROP, INDEX, ALTER ON webbh.* TO 'technova_user'@'localhost';

-- Áp dụng thay đổi
FLUSH PRIVILEGES;

-- Kiểm tra user đã tạo thành công
SELECT User, Host FROM mysql.user WHERE User = 'technova_user';

-- Kiểm tra quyền của user
SHOW GRANTS FOR 'technova_user'@'localhost';


-- =====================================================
-- HƯỚNG DẪN SỬ DỤNG
-- =====================================================
-- 1. Sau khi chạy script này, cập nhật file config.php:
--
--    define('DB_USER', 'technova_user');
--    define('DB_PASSWORD', 'TechNova@2026');
--
-- 2. Hoặc dùng trong code PHP:
--
--    $conn = new mysqli('localhost', 'technova_user', 'TechNova@2026', 'webbh');
--
-- =====================================================


-- =====================================================
-- CÁC LỆNH BỔ SUNG (NẾU CẦN)
-- =====================================================

-- Xóa user (nếu muốn tạo lại):
-- DROP USER IF EXISTS 'technova_user'@'localhost';

-- Đổi password cho user:
-- ALTER USER 'technova_user'@'localhost' IDENTIFIED BY 'NewPassword@2026';

-- Xem tất cả user trong MySQL:
-- SELECT User, Host FROM mysql.user;

-- Xem quyền của một user:
-- SHOW GRANTS FOR 'technova_user'@'localhost';

-- Thu hồi quyền:
-- REVOKE ALL PRIVILEGES ON webbh.* FROM 'technova_user'@'localhost';
