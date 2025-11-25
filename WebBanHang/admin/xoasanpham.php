<?php
session_start();
// 1. Kiểm tra quyền Admin
if (!isset($_SESSION["user"]) || stripos($_SESSION["user"]["username"], "admin") === false) {
    header("Location: ../Login/Login.php");
    exit();
}

if (!isset($_GET["id"])) {
    header("Location: quanlysanpham.php");
    exit();
}

$conn = new mysqli("localhost", "root", "", "webbh");
if ($conn->connect_error) die("Kết nối thất bại: " . $conn->connect_error);

$id = (int)$_GET["id"];

// 2. KIỂM TRA RÀNG BUỘC ĐƠN HÀNG (Quan trọng)
// Nếu sản phẩm này đã từng được đặt mua, không được xóa để giữ lịch sử đơn hàng.
$checkOrder = $conn->query("SELECT COUNT(*) as total FROM chi_tiet_don_hang WHERE id_san_pham = $id");
$row = $checkOrder->fetch_assoc();

if ($row['total'] > 0) {
    echo "<script>
            alert('❌ KHÔNG THỂ XÓA! Sản phẩm này đang tồn tại trong các đơn hàng cũ. Việc xóa sẽ làm hỏng dữ liệu lịch sử mua hàng.');
            window.location.href = 'quanlysanpham.php';
          </script>";
    exit();
}

// 3. XÓA FILE ẢNH VẬT LÝ TRÊN MÁY CHỦ
// Lấy danh sách các ảnh của sản phẩm để xóa file trong thư mục uploads
$resultImages = $conn->query("SELECT url_hinh_anh FROM hinh_anh_san_pham WHERE id_san_pham = $id");
while ($img = $resultImages->fetch_assoc()) {
    $filePath = $img['url_hinh_anh'];
    
    // Đường dẫn trong DB có thể là: "../admin/uploads/ten_anh.jpg"
    // Nếu file xoasanpham.php nằm trong thư mục admin, ta có thể dùng trực tiếp đường dẫn này
    if (!empty($filePath) && file_exists($filePath)) {
        unlink($filePath); // Hàm xóa file khỏi ổ cứng
    }
}


// Xóa đánh giá (nếu có)
$conn->query("DELETE FROM danh_gia_san_pham WHERE id_san_pham = $id");

// Xóa hình ảnh trong DB
$conn->query("DELETE FROM hinh_anh_san_pham WHERE id_san_pham = $id");

// Xóa các biến thể
$conn->query("DELETE FROM bien_the_san_pham WHERE id_san_pham = $id");

// Cuối cùng: Xóa sản phẩm chính
if ($conn->query("DELETE FROM san_pham WHERE id_san_pham = $id")) {
    echo "<script>
            alert('✅ Đã xóa sản phẩm và hình ảnh thành công!');
            window.location.href = 'quanlysanpham.php';
          </script>";
} else {
    echo "<script>
            alert('Có lỗi xảy ra khi xóa sản phẩm: " . $conn->error . "');
            window.location.href = 'quanlysanpham.php';
          </script>";
}

$conn->close();
?>