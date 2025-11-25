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
$username = htmlspecialchars($_SESSION["user"]["username"]);

// ============================================================
// PHẦN 1: XỬ LÝ DỮ LIỆU (KHI NHẤN NÚT "MUA NGAY" - METHOD POST)
// ============================================================
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    // Lấy thông tin người dùng để làm địa chỉ giao hàng
    $sql_user = "SELECT * FROM users WHERE id = $user_id";
    $res_user = $conn->query($sql_user);
    $user_info = $res_user->fetch_assoc();

    $product_id = (int)($_POST['product_id'] ?? 0);
    $variant_id = (int)($_POST['id_bien_the'] ?? 0);
    $quantity   = (int)($_POST['quantity'] ?? 1);

    if ($product_id > 0 && $quantity > 0) {
        
        // Lấy lại thông tin sản phẩm từ DB (để đảm bảo giá đúng)
        $sql_prod = "SELECT sp.ten_san_pham, bt.gia_ban, bt.mau_sac, bt.cau_hinh, bt.so_luong_ton_kho
                     FROM san_pham sp
                     JOIN bien_the_san_pham bt ON sp.id_san_pham = bt.id_san_pham
                     WHERE sp.id_san_pham = $product_id AND bt.id_bien_the = $variant_id";
        
        $result = $conn->query($sql_prod);
        $product = $result->fetch_assoc();

        if ($product) {
            // Kiểm tra tồn kho
            if ($product['so_luong_ton_kho'] < $quantity) {
                echo "<script>alert('Sản phẩm này không đủ số lượng trong kho!'); window.history.back();</script>";
                exit();
            }

            $price = $product['gia_ban'];
            $total_money = $price * $quantity;
            
            $variant_name = $product['mau_sac'];
            if (!empty($product['cau_hinh'])) {
                $variant_name .= ' - ' . $product['cau_hinh'];
            }

            // --- BẮT ĐẦU GHI VÀO DB ---

            // A. Tạo đơn hàng
            $sql_order = "INSERT INTO don_hang (id_nguoi_dung, tong_tien, ho_ten_nguoi_nhan, sdt_nguoi_nhan, dia_chi_giao_hang, phuong_thuc_thanh_toan, trang_thai) 
                          VALUES (?, ?, ?, ?, ?, 'COD', 'Cho_xac_nhan')";
            
            $stmt = $conn->prepare($sql_order);
            $stmt->bind_param("idsss", $user_id, $total_money, $user_info['username'], $user_info['phone'], $user_info['address']);
            
            if ($stmt->execute()) {
                $order_id = $stmt->insert_id; // Lấy ID vừa tạo

                // B. Lưu chi tiết đơn hàng
                $sql_detail = "INSERT INTO chi_tiet_don_hang (id_don_hang, id_san_pham, id_bien_the, so_luong, don_gia, ten_san_pham, phan_loai)
                               VALUES (?, ?, ?, ?, ?, ?, ?)";
                $stmt_d = $conn->prepare($sql_detail);
                $stmt_d->bind_param("iiiidss", $order_id, $product_id, $variant_id, $quantity, $price, $product['ten_san_pham'], $variant_name);
                $stmt_d->execute();

                // C. Trừ tồn kho
                $conn->query("UPDATE bien_the_san_pham SET so_luong_ton_kho = so_luong_ton_kho - $quantity WHERE id_bien_the = $variant_id");

                // D. CHUYỂN HƯỚNG LẠI CHÍNH TRANG NÀY ĐỂ HIỂN THỊ HÓA ĐƠN (GET)
                header("Location: DatHang.php?id=$order_id");
                exit();
                
            } else {
                echo "<script>alert('Lỗi tạo đơn hàng.'); window.history.back();</script>";
            }
        } else {
            echo "<script>alert('Sản phẩm không tồn tại.'); window.history.back();</script>";
        }
    } else {
        echo "<script>alert('Dữ liệu không hợp lệ.'); window.history.back();</script>";
    }
    exit(); // Kết thúc phần xử lý POST
}

// ============================================================
// PHẦN 2: HIỂN THỊ HÓA ĐƠN (KHI CÓ ID TRÊN URL - METHOD GET)
// ============================================================
if (isset($_GET['id'])) {
    $order_id = (int)$_GET['id'];

    // Lấy thông tin đơn hàng (Chỉ lấy nếu đúng là của user này)
    $sql_order = "SELECT * FROM don_hang WHERE id_don_hang = $order_id AND id_nguoi_dung = $user_id";
    $result_order = $conn->query($sql_order);
    $order = $result_order->fetch_assoc();

    if (!$order) {
        echo "<script>alert('Đơn hàng không tồn tại hoặc bạn không có quyền xem!'); window.location.href='../SanPham/SanPham.php';</script>";
        exit();
    }

    // Lấy chi tiết sản phẩm
    $sql_details = "SELECT ct.*, 
                    (SELECT url_hinh_anh FROM hinh_anh_san_pham WHERE id_san_pham = ct.id_san_pham LIMIT 1) as hinh_anh
                    FROM chi_tiet_don_hang ct 
                    WHERE ct.id_don_hang = $order_id";
    $result_details = $conn->query($sql_details);
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công</title>
    <link rel="stylesheet" href="demo.css">
</head>
<body>

<div id="fox">
    <div id="fox-nav">
        <ul>
            <li><a href="../index/index.php">Trang chủ</a></li>
            <li><a href="../SanPham/SanPham.php">Sản phẩm</a></li>
            <li class="user-dropdown">
                <a href="#" id="user-toggle"><?= $username ?> ⮟</a>
                <ul class="dropdown-menu">
                    <li><a href="../User/ThongTinCaNhan.php">Thông tin cá nhân</a></li>
                    <li><a href="../DonHang/Giohang.php">Giỏ hàng của tôi</a></li>
                    <li><a href="../DonHang/DonHangCuaToi.php">Đơn hàng của tôi</a></li>
                    <li><a href="../Login/logout.php">Đăng xuất</a></li>
                </ul>
            </li>
        </ul>
    </div>

    <div class="success-container">
        <div class="success-header">
            <div class="success-icon">✔</div>
            <div class="success-title">ĐẶT HÀNG THÀNH CÔNG</div>
            <p>Cảm ơn bạn đã mua sắm tại Fox Tech!</p>
        </div>

        <div class="order-info">
            <p><strong>Mã đơn hàng:</strong> #<?= $order['id_don_hang'] ?></p>
            <p><strong>Ngày đặt:</strong> <?= date("d/m/Y H:i", strtotime($order['ngay_dat'])) ?></p>
            <p><strong>Người nhận:</strong> <?= htmlspecialchars($order['ho_ten_nguoi_nhan']) ?> - <?= htmlspecialchars($order['sdt_nguoi_nhan']) ?></p>
            <p><strong>Địa chỉ:</strong> <?= htmlspecialchars($order['dia_chi_giao_hang']) ?></p>
            <p><strong>Phương thức:</strong> <?= $order['phuong_thuc_thanh_toan'] == 'COD' ? 'Thanh toán khi nhận hàng' : 'Chuyển khoản ngân hàng' ?></p>
            <p><strong>Trạng thái:</strong> <span style="color:#FF9800; font-weight:bold;"><?= str_replace('_', ' ', $order['trang_thai']) ?></span></p>
        </div>

        <div class="item-list">
            <?php while($detail = $result_details->fetch_assoc()): ?>
            <div class="item">
                <div class="item-img">
                    <img src="<?= htmlspecialchars($detail['hinh_anh'] ?: '../Hinh/default.png') ?>" alt="Img">
                </div>
                <div class="item-info">
                    <div class="item-name"><?= htmlspecialchars($detail['ten_san_pham']) ?></div>
                    <div style="font-size:13px; color:#666;">Phân loại: <?= htmlspecialchars($detail['phan_loai']) ?></div>
                    <div>Số lượng: x<?= $detail['so_luong'] ?></div>
                </div>
                <div class="item-price">
                    <?= number_format($detail['don_gia'] * $detail['so_luong'], 0, ',', '.') ?>₫
                </div>
            </div>
            <?php endwhile; ?>
        </div>

        <div class="total-section">
            Tổng thanh toán: <span style="color: #e53935;"><?= number_format($order['tong_tien'], 0, ',', '.') ?>₫</span>
        </div>

        <div class="btn-group">
            <a href="../SanPham/SanPham.php" class="btn btn-outline">← Tiếp tục mua sắm</a>
            <a href="DonHangCuaToi.php" class="btn btn-primary">Xem lịch sử đơn hàng</a>
        </div>
    </div>

    <div id="fox-footer">
        <p>© 2025 TECHNOVA. All rights reserved.</p>
        <p>Địa chỉ: 123 Đường Nguyễn Trãi, TP.HCM | Hotline: 0123 456 789 | Email: support@technova.vn</p>
    </div>
</div>

<script>
    document.getElementById('user-toggle').addEventListener('click', function(e) {
        e.preventDefault();
        var d = this.nextElementSibling;
        d.style.display = (d.style.display === 'block') ? 'none' : 'block';
    });
    window.onclick = function(event) {
        if (!event.target.matches('#user-toggle')) {
            var dropdowns = document.getElementsByClassName("dropdown-menu");
            for (var i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];
                if (openDropdown.style.display === 'block') {
                    openDropdown.style.display = 'none';
                }
            }
        }
    }
</script>
</body>
</html>
<?php
} else {
    // Nếu không phải POST và cũng không có ID -> Chuyển về trang chủ
    header("Location: ../index/index.php");
    exit();
}
?>