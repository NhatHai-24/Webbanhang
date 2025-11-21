<?php
session_start();
header('Content-Type: application/json');

// Kiểm tra đăng nhập
if (!isset($_SESSION["user"])) {
    echo json_encode(['status' => 'error', 'message' => 'Bạn chưa đăng nhập']);
    exit();
}

$conn = new mysqli("localhost", "root", "", "webbh");
if ($conn->connect_error) {
    echo json_encode(['status' => 'error', 'message' => 'Lỗi kết nối DB']);
    exit();
}

$user_id = (int)$_SESSION["user"]["id"];
$action = $_POST['action'] ?? '';

// --- 1. THÊM VÀO GIỎ (ADD) ---
if ($action == 'add') {
    $product_id = (int)$_POST['product_id'];
    $variant_id = (int)$_POST['variant_id'];
    $quantity   = (int)$_POST['quantity'];

    // Kiểm tra tồn tại
    $check = $conn->query("SELECT id_gio_hang, so_luong FROM gio_hang WHERE id_nguoi_dung=$user_id AND id_bien_the=$variant_id");
    
    if ($check->num_rows > 0) {
        $row = $check->fetch_assoc();
        $new_qty = $row['so_luong'] + $quantity;
        $conn->query("UPDATE gio_hang SET so_luong=$new_qty WHERE id_gio_hang={$row['id_gio_hang']}");
    } else {
        $stmt = $conn->prepare("INSERT INTO gio_hang (id_nguoi_dung, id_san_pham, id_bien_the, so_luong) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("iiii", $user_id, $product_id, $variant_id, $quantity);
        $stmt->execute();
    }
    echo json_encode(['status' => 'success', 'message' => 'Đã thêm vào giỏ hàng!']);
    exit();
}

// --- 2. CẬP NHẬT SỐ LƯỢNG (UPDATE) ---
if ($action == 'update') {
    $cart_id = (int)$_POST['id_gio_hang'];
    $qty     = (int)$_POST['qty'];

    if ($qty > 0) {
        $conn->query("UPDATE gio_hang SET so_luong=$qty WHERE id_gio_hang=$cart_id AND id_nguoi_dung=$user_id");
    } else {
        // Nếu số lượng = 0 hoặc âm thì xóa luôn (hoặc giữ là 1 tùy logic)
        $qty = 1; 
        $conn->query("UPDATE gio_hang SET so_luong=1 WHERE id_gio_hang=$cart_id AND id_nguoi_dung=$user_id");
    }

    // Tính toán lại giá để trả về
    $sql = "SELECT gh.so_luong, bt.gia_ban FROM gio_hang gh 
            JOIN bien_the_san_pham bt ON gh.id_bien_the = bt.id_bien_the 
            WHERE gh.id_gio_hang=$cart_id";
    $res = $conn->query($sql)->fetch_assoc();
    $item_total = $res['so_luong'] * $res['gia_ban'];

    // Tính tổng giỏ hàng
    $total_cart = calculateTotalCart($conn, $user_id);

    echo json_encode([
        'status' => 'success', 
        'item_total' => number_format($item_total, 0, ',', '.') . '₫',
        'grand_total' => number_format($total_cart, 0, ',', '.') . '₫'
    ]);
    exit();
}

// --- 3. XÓA SẢN PHẨM (REMOVE) ---
if ($action == 'remove') {
    $cart_id = (int)$_POST['id_gio_hang'];
    $conn->query("DELETE FROM gio_hang WHERE id_gio_hang=$cart_id AND id_nguoi_dung=$user_id");
    
    $total_cart = calculateTotalCart($conn, $user_id);
    
    // Kiểm tra xem giỏ còn trống không
    $count = $conn->query("SELECT COUNT(*) FROM gio_hang WHERE id_nguoi_dung=$user_id")->fetch_row()[0];

    echo json_encode([
        'status' => 'success',
        'grand_total' => number_format($total_cart, 0, ',', '.') . '₫',
        'is_empty' => ($count == 0)
    ]);
    exit();
}

// Hàm tính tổng tiền giỏ hàng
function calculateTotalCart($conn, $user_id) {
    $sql = "SELECT SUM(gh.so_luong * bt.gia_ban) as tong 
            FROM gio_hang gh 
            JOIN bien_the_san_pham bt ON gh.id_bien_the = bt.id_bien_the 
            WHERE gh.id_nguoi_dung = $user_id";
    $result = $conn->query($sql);
    $row = $result->fetch_assoc();
    return $row['tong'] ?? 0;
}
?>