<?php
session_start();

// 1. Kiểm tra đăng nhập
if (!isset($_SESSION["user"])) {
    header("Location: ../Login/Login.php");
    exit();
}

$conn = new mysqli("localhost", "root", "", "webbh");
if ($conn->connect_error) {
    die("Kết nối thất bại: " . $conn->connect_error);
}

$user_id = (int)$_SESSION["user"]["id"];

// 2. Xử lý khi có yêu cầu POST
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['id_don_hang'])) {
    
    $order_id = (int)$_POST['id_don_hang'];

    // 3. Kiểm tra đơn hàng có tồn tại và thuộc về user này không, đồng thời phải ở trạng thái 'Cho_xac_nhan'
    // (Chỉ cho phép xóa đơn chưa xử lý để an toàn)
    $check_sql = "SELECT id_don_hang FROM don_hang WHERE id_don_hang = ? AND id_nguoi_dung = ? AND trang_thai = 'Cho_xac_nhan'";
    $stmt_check = $conn->prepare($check_sql);
    $stmt_check->bind_param("ii", $order_id, $user_id);
    $stmt_check->execute();
    $result = $stmt_check->get_result();

    if ($result->num_rows > 0) {
        
        // --- BƯỚC PHỤ: HOÀN TRẢ TỒN KHO (QUAN TRỌNG) ---
        // Lấy danh sách sản phẩm trong đơn hàng này để cộng lại vào kho
        $sql_items = "SELECT id_bien_the, so_luong FROM chi_tiet_don_hang WHERE id_don_hang = ?";
        $stmt_items = $conn->prepare($sql_items);
        $stmt_items->bind_param("i", $order_id);
        $stmt_items->execute();
        $res_items = $stmt_items->get_result();

        while ($item = $res_items->fetch_assoc()) {
            $variant_id = $item['id_bien_the'];
            $qty = $item['so_luong'];
            
            // Cộng lại số lượng vào bảng biến thể
            $conn->query("UPDATE bien_the_san_pham SET so_luong_ton_kho = so_luong_ton_kho + $qty WHERE id_bien_the = $variant_id");
        }
        // ------------------------------------------------

        // 4. Xóa đơn hàng (DELETE)
        // Do có ràng buộc khóa ngoại (ON DELETE CASCADE) trong CSDL, 
        // nên khi xóa ở bảng 'don_hang', các dòng trong 'chi_tiet_don_hang' cũng tự động mất theo.
        $del_sql = "DELETE FROM don_hang WHERE id_don_hang = ?";
        $stmt_del = $conn->prepare($del_sql);
        $stmt_del->bind_param("i", $order_id);

        if ($stmt_del->execute()) {
        // Xóa thành công -> Quay về ngay
        header("Location: DonHangCuaToi.php");
        exit();
    } else {
        // Lỗi hệ thống -> Quay về ngay
        header("Location: DonHangCuaToi.php");
        exit();
    }

    } else {
        // Không đủ điều kiện hủy -> Quay về ngay
        header("Location: DonHangCuaToi.php");
        exit();
    }
} else {
    // Nếu truy cập trực tiếp mà không post
    header("Location: DonHangCuaToi.php");
    exit();
}
?>