<?php
$current_page = basename($_SERVER['PHP_SELF']);
session_start();

// Kiểm tra quyền Admin
if (!isset($_SESSION["user"]) || strpos(strtolower($_SESSION["user"]["username"]), "admin") === false) {
    header("Location: ../Login/Login.php");
    exit();
}

$conn = new mysqli("localhost", "root", "", "webbh");
if ($conn->connect_error) {
    die("Kết nối thất bại: " . $conn->connect_error);
}

// --- XỬ LÝ CẬP NHẬT TRẠNG THÁI ---
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST["order_id"], $_POST["new_status"])) {
    $order_id = (int)$_POST["order_id"];
    $new_status = $_POST["new_status"];
    
    // Cập nhật bảng don_hang
    $stmt = $conn->prepare("UPDATE don_hang SET trang_thai = ? WHERE id_don_hang = ?");
    $stmt->bind_param("si", $new_status, $order_id);
    
    if ($stmt->execute()) {
        echo "<script>alert('Cập nhật trạng thái đơn hàng #$order_id thành công!'); window.location.href='quanlydonhang.php';</script>";
    } else {
        echo "<script>alert('Lỗi cập nhật!');</script>";
    }
}

// --- LẤY DỮ LIỆU ĐƠN HÀNG ---
// Sử dụng GROUP_CONCAT để gộp danh sách sản phẩm vào 1 dòng cho mỗi đơn hàng
$sql = "SELECT 
            dh.id_don_hang, 
            dh.ngay_dat, 
            dh.tong_tien, 
            dh.trang_thai, 
            dh.ho_ten_nguoi_nhan, 
            dh.dia_chi_giao_hang, 
            dh.sdt_nguoi_nhan,
            u.username,
            GROUP_CONCAT(CONCAT('• ', ct.ten_san_pham, ' [', ct.phan_loai, '] x', ct.so_luong) SEPARATOR '<br>') as danh_sach_san_pham
        FROM don_hang dh
        JOIN users u ON dh.id_nguoi_dung = u.id
        LEFT JOIN chi_tiet_don_hang ct ON dh.id_don_hang = ct.id_don_hang
        GROUP BY dh.id_don_hang
        ORDER BY dh.ngay_dat DESC";

$result = $conn->query($sql);

// Nhóm đơn hàng theo Username để hiển thị
$orders_by_user = [];
while ($row = $result->fetch_assoc()) {
    $orders_by_user[$row["username"]][] = $row;
}

// Mảng trạng thái để hiển thị tiếng Việt đẹp hơn
$status_map = [
    'Cho_xac_nhan' => 'Chờ xác nhận',
    'Dang_giao'    => 'Đang giao hàng',
    'Da_giao'      => 'Đã giao thành công',
    'Da_huy'       => 'Đã hủy'
];
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng</title>
    <link rel="stylesheet" href="admin.css?v=2">
    <style>
        .admin-container {
            max-width: 1200px;
            margin: 40px auto;
            background: rgba(255, 255, 255, 0.03);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        }
        h3.user-title {
            background: #004a80;
            color: white;
            padding: 10px 15px;
            border-radius: 6px;
            margin-top: 40px;
            margin-bottom: 15px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            margin-bottom: 30px;
        }
        th, td {
            border: 1px solid var(--glass-border);
            padding: 12px;
            text-align: left;
            vertical-align: top;
        }
        th {
            background-color: #007acc;
            color: black;
            text-align: center;
        }
        .product-list {
            font-size: 13px;
            color: #94a3b8;
            line-height: 1.6;
        }
        .price {
            color: #e53935;
            font-weight: bold;
        }
        .action-form {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        .action-form select {
            padding: 6px;
            border-radius: 4px;
            border: 1px solid var(--glass-border);
        }
        .action-form button {
            background-color: #28a745;
            border: none;
            color: white;
            padding: 6px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        .action-form button:hover {
            background-color: #218838;
        }
        .info-cell p { margin: 3px 0; }
    </style>
</head>
<body>
<div id="fox">

    <div id="fox-nav">
        <ul>
            <li><a href="admin.php">Trang Chủ</a></li>
            <li><a href="quanlysanpham.php">Quản Lý Sản Phẩm</a></li>
            <li><a href="quanlydonHang.php" class="<?= ($current_page == 'quanlydonHang.php') ? 'active' : '' ?>">Quản lý Đơn Hàng</a></li>
            <li><a href="quanlynguoidung.php">Quản lý Người Dùng</a></li>
            <li><a href="quanlythongke.php">Thống Kê</a></li>
            <li><a href="quanlydanhgia.php">Quản lý Đánh Giá</a></li>
            <li><a href="../Login/logout.php">Đăng Xuất</a></li>
        </ul>
    </div>

    <div class="admin-container">
        <h2>📦 Danh sách đơn hàng theo người dùng</h2>
        
        <?php if (empty($orders_by_user)): ?>
            <p style="text-align:center; padding: 20px;">Hiện chưa có đơn hàng nào.</p>
        <?php else: ?>
            <?php foreach ($orders_by_user as $username => $orders): ?>
                <h3 class="user-title">👤 Khách hàng: <?= htmlspecialchars($username) ?></h3>
                <table>
                    <tr>
                        <th width="5%">ID</th>
                        <th width="15%">Thông tin đặt</th>
                        <th width="40%">Sản phẩm mua</th>
                        <th width="15%">Tổng tiền</th>
                        <th width="15%">Địa chỉ giao</th>
                        <th width="10%">Trạng thái</th>
                    </tr>
                    <?php foreach ($orders as $order): ?>
                        <tr>
                            <td style="text-align:center; font-weight:bold;">#<?= $order["id_don_hang"] ?></td>
                            
                            <td class="info-cell">
                                <p>📅 <?= date("d/m/Y H:i", strtotime($order["ngay_dat"])) ?></p>
                                <p>🧑 <?= htmlspecialchars($order["ho_ten_nguoi_nhan"]) ?></p>
                                <p>📞 <?= htmlspecialchars($order["sdt_nguoi_nhan"]) ?></p>
                            </td>

                            <td class="product-list">
                                <?= $order["danh_sach_san_pham"] ?>
                            </td>

                            <td class="price" style="text-align:center;">
                                <?= number_format($order["tong_tien"], 0, ',', '.') ?>₫
                            </td>

                            <td><?= htmlspecialchars($order["dia_chi_giao_hang"]) ?></td>

                            <td>
                                <form method="POST" class="action-form">
                                    <input type="hidden" name="order_id" value="<?= $order["id_don_hang"] ?>">
                                    <select name="new_status">
                                        <?php foreach ($status_map as $key => $label): ?>
                                            <option value="<?= $key ?>" <?= ($order["trang_thai"] === $key) ? "selected" : "" ?>>
                                                <?= $label ?>
                                            </option>
                                        <?php endforeach; ?>
                                    </select>
                                    <button type="submit" onclick="return confirm('Cập nhật trạng thái đơn hàng này?')">Lưu</button>
                                </form>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </table>
            <?php endforeach; ?>
        <?php endif; ?>
    </div>

    <div id="fox-footer">
        <p>© 2025 TECHNOVA. All rights reserved.</p>
    </div>
</div>
</body>
</html>