<?php
session_start();
header('Content-Type: application/json');

// Kiểm tra đăng nhập
if (!isset($_SESSION["user"])) {
    echo json_encode(['status' => 'error', 'message' => 'Bạn chưa đăng nhập']);
    exit();
}

require_once __DIR__ . '/../auth.php';
require_login();

header('Content-Type: application/json');
$user = current_user();
$user_id = (int)$user['id'];

$conn = new mysqli("localhost", "root", "", "webbh");
if ($conn->connect_error) {
    echo json_encode(['status' => 'error', 'message' => 'Lỗi kết nối DB']);
    exit();
}

$action = $_POST['action'] ?? '';

// Helper: kiểm tra ownership của item giỏ hàng
function cart_belongs_to_user($conn, $cartId, $user_id) {
    $stmt = $conn->prepare("SELECT id_gio_hang, id_nguoi_dung FROM gio_hang WHERE id_gio_hang = ? LIMIT 1");
    $stmt->bind_param('i', $cartId);
    $stmt->execute();
    $res = $stmt->get_result();
    $row = $res->fetch_assoc();
    return $row && ((int)$row['id_nguoi_dung'] === $user_id);
}

// Hàm tính tổng tiền giỏ hàng (dùng prepared)
function calculateTotalCart($conn, $user_id) {
    $sql = "SELECT SUM(gh.so_luong * bt.gia_ban) as tong 
            FROM gio_hang gh 
            JOIN bien_the_san_pham bt ON gh.id_bien_the = bt.id_bien_the 
            WHERE gh.id_nguoi_dung = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('i', $user_id);
    $stmt->execute();
    $res = $stmt->get_result();
    $row = $res->fetch_assoc();
    return $row['tong'] ?? 0;
}

// --- 1. THÊM VÀO GIỎ (ADD) ---
if ($action === 'add') {
    $product_id = (int)($_POST['product_id'] ?? 0);
    $variant_id = (int)($_POST['variant_id'] ?? 0);
    $quantity   = max(1, (int)$_POST['quantity'] ?? 1);

    // Kiểm tra tồn tại bản ghi trong gio_hang cho người dùng với biến thể (prepared)
    $stmt = $conn->prepare("SELECT id_gio_hang, so_luong FROM gio_hang WHERE id_nguoi_dung = ? AND id_bien_the = ? LIMIT 1");
    $stmt->bind_param('ii', $user_id, $variant_id);
    $stmt->execute();
    $res = $stmt->get_result();

    if ($row = $res->fetch_assoc()) {
        $new_qty = (int)$row['so_luong'] + $quantity;
        $upd = $conn->prepare("UPDATE gio_hang SET so_luong = ? WHERE id_gio_hang = ?");
        $upd->bind_param('ii', $new_qty, $row['id_gio_hang']);
        $upd->execute();
    } else {
        $ins = $conn->prepare("INSERT INTO gio_hang (id_nguoi_dung, id_san_pham, id_bien_the, so_luong) VALUES (?, ?, ?, ?)");
        $ins->bind_param("iiii", $user_id, $product_id, $variant_id, $quantity);
        $ins->execute();
    }

    echo json_encode(['status' => 'success', 'message' => 'Đã thêm vào giỏ hàng!']);
    exit();
}

// --- 2. CẬP NHẬT SỐ LƯỢNG (UPDATE) ---
if ($action === 'update') {
    $cart_id = (int)($_POST['id_gio_hang'] ?? 0);
    $qty     = max(1, (int)($_POST['qty'] ?? 1));

    if (!cart_belongs_to_user($conn, $cart_id, $user_id)) {
        echo json_encode(['status' => 'error', 'message' => 'Không có quyền']);
        exit();
    }

    $stmt = $conn->prepare("UPDATE gio_hang SET so_luong = ? WHERE id_gio_hang = ?");
    $stmt->bind_param('ii', $qty, $cart_id);
    $stmt->execute();

    // Lấy thông tin item để trả về item_total
    $stmt2 = $conn->prepare(
        "SELECT gh.so_luong, bt.gia_ban 
         FROM gio_hang gh 
         JOIN bien_the_san_pham bt ON gh.id_bien_the = bt.id_bien_the 
         WHERE gh.id_gio_hang = ? LIMIT 1"
    );
    $stmt2->bind_param('i', $cart_id);
    $stmt2->execute();
    $res2 = $stmt2->get_result()->fetch_assoc();
    $item_total = (($res2['so_luong'] ?? 0) * ($res2['gia_ban'] ?? 0));

    $total_cart = calculateTotalCart($conn, $user_id);

    echo json_encode([
        'status' => 'success',
        'item_total' => number_format($item_total, 0, ',', '.') . '₫',
        'grand_total' => number_format($total_cart, 0, ',', '.') . '₫'
    ]);
    exit();
}

// --- 3. XÓA SẢN PHẨM (REMOVE) ---
if ($action === 'remove') {
    $cart_id = (int)($_POST['id_gio_hang'] ?? 0);

    if (!cart_belongs_to_user($conn, $cart_id, $user_id)) {
        echo json_encode(['status' => 'error', 'message' => 'Không có quyền']);
        exit();
    }

    $stmt = $conn->prepare("DELETE FROM gio_hang WHERE id_gio_hang = ? AND id_nguoi_dung = ?");
    $stmt->bind_param('ii', $cart_id, $user_id);
    $stmt->execute();

    $total_cart = calculateTotalCart($conn, $user_id);

    $stmtCount = $conn->prepare("SELECT COUNT(*) as cnt FROM gio_hang WHERE id_nguoi_dung = ?");
    $stmtCount->bind_param('i', $user_id);
    $stmtCount->execute();
    $count = $stmtCount->get_result()->fetch_assoc()['cnt'] ?? 0;

    echo json_encode([
        'status' => 'success',
        'grand_total' => number_format($total_cart, 0, ',', '.') . '₫',
        'is_empty' => ($count == 0)
    ]);
    exit();
}

// Action không hợp lệ
echo json_encode(['status' => 'error', 'message' => 'Yêu cầu không hợp lệ']);
exit();
?>