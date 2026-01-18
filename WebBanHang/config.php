<?php
/**
 * Cấu hình Cơ sở dữ liệu cho môi trường Docker/XAMPP
 * 
 * File này tự động phát hiện ứng dụng đang chạy trên Docker hay XAMPP
 * và cấu hình kết nối database tương ứng.
 * 
 * Cách sử dụng: require_once __DIR__ . '/config.php';
 * Biến $conn sẽ có sẵn để sử dụng toàn cục.
 */

// Kiểm tra nếu file đã được load rồi thì không load lại
if (defined('DB_CONFIG_LOADED')) {
    return;
}
define('DB_CONFIG_LOADED', true);

// Kiểm tra biến môi trường DB_HOST để xác định đang chạy Docker hay không
$isDocker = getenv('DB_HOST') !== false;

if ($isDocker) {
    // Lấy thông tin từ biến môi trường, nếu không có thì dùng giá trị mặc định
    define('DB_HOST', getenv('DB_HOST') ?: 'mysql');           // Tên host database (container MySQL)
    define('DB_NAME', getenv('DB_NAME') ?: 'webbh');           // Tên cơ sở dữ liệu
    define('DB_USER', getenv('DB_USER') ?: 'root');            // Tên người dùng database
    // Xử lý đặc biệt cho password: empty string là giá trị hợp lệ
    $dbPassword = getenv('DB_PASSWORD');
    define('DB_PASSWORD', $dbPassword !== false ? $dbPassword : ''); // Mật khẩu database (có thể rỗng)
} else {
    define('DB_HOST', 'localhost');           // Host mặc định của XAMPP
    define('DB_NAME', 'webbh');               // Tên cơ sở dữ liệu
    define('DB_USER', 'technova_user');       // User mới (không dùng root)
    define('DB_PASSWORD', 'TechNova@2026');   // Password của user mới
}

// Khởi tạo kết nối đến database sử dụng mysqli
$conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

// Kiểm tra kết nối có thành công không
if ($conn->connect_error) {
    // Nếu lỗi, dừng chương trình và hiển thị thông báo
    die("Kết nối thất bại: " . $conn->connect_error);
}

// Thiết lập charset UTF-8 để hỗ trợ tiếng Việt
$conn->set_charset("utf8mb4");

/**
 * Lấy kết nối PDO (thay thế cho mysqli)
 * PDO cung cấp cách thức truy vấn an toàn hơn với prepared statements
 * 
 * @return PDO Đối tượng kết nối PDO
 */
function getPDOConnection() {
    // Sử dụng static để chỉ tạo kết nối một lần (Singleton pattern)
    static $pdo = null;
    
    if ($pdo === null) {
        try {
            // Tạo kết nối PDO mới
            $pdo = new PDO(
                "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4",
                DB_USER,
                DB_PASSWORD,
                [
                    // Bật chế độ báo lỗi bằng Exception
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                    // Kết quả trả về dạng mảng kết hợp (associative array)
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                    // Tắt emulate prepared statements để tăng bảo mật
                    PDO::ATTR_EMULATE_PREPARES => false,
                ]
            );
        } catch (PDOException $e) {
            // Nếu lỗi kết nối, dừng và hiển thị thông báo
            die("Kết nối PDO thất bại: " . $e->getMessage());
        }
    }
    
    return $pdo;
}
?>
