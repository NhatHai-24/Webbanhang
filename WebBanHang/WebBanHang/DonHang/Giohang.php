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

// Lấy thông tin chi tiết user để điền vào form thanh toán
$sql_user = "SELECT * FROM users WHERE id = $user_id";
$res_user = $conn->query($sql_user);
$user_info = $res_user->fetch_assoc();

// --- XỬ LÝ ĐẶT HÀNG (KHI NHẤN XÁC NHẬN) ---
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['btn_confirm_order'])) {
    // Lấy dữ liệu từ Form Modal
    $fullname = $_POST['fullname'];
    $phone = $_POST['phone'];
    $address = $_POST['address'];
    $payment_method = $_POST['payment_method'];
    $total_order = $_POST['total_order_hidden'];

    // 1. Tạo đơn hàng trong bảng don_hang
    $sql_order = "INSERT INTO don_hang (id_nguoi_dung, tong_tien, ho_ten_nguoi_nhan, sdt_nguoi_nhan, dia_chi_giao_hang, phuong_thuc_thanh_toan) 
                  VALUES (?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql_order);
    $stmt->bind_param("idssss", $user_id, $total_order, $fullname, $phone, $address, $payment_method);
    
    if ($stmt->execute()) {
        $order_id = $stmt->insert_id; // Lấy ID đơn hàng vừa tạo

        // 2. Chuyển sản phẩm từ giỏ hàng sang chi_tiet_don_hang
        // Lấy lại giỏ hàng hiện tại
        $sql_get_cart = "SELECT gh.*, sp.ten_san_pham, bt.gia_ban, bt.mau_sac, bt.cau_hinh 
                         FROM gio_hang gh
                         JOIN san_pham sp ON gh.id_san_pham = sp.id_san_pham
                         JOIN bien_the_san_pham bt ON gh.id_bien_the = bt.id_bien_the
                         WHERE gh.id_nguoi_dung = $user_id";
        $res_cart = $conn->query($sql_get_cart);

        while ($item = $res_cart->fetch_assoc()) {
            $variant_text = $item['mau_sac'] . ($item['cau_hinh'] ? ' - ' . $item['cau_hinh'] : '');
            
            // Insert vào chi tiết đơn hàng
            $sql_detail = "INSERT INTO chi_tiet_don_hang (id_don_hang, id_san_pham, id_bien_the, so_luong, don_gia, ten_san_pham, phan_loai)
                           VALUES (?, ?, ?, ?, ?, ?, ?)";
            $stmt_d = $conn->prepare($sql_detail);
            $stmt_d->bind_param("iiiidss", $order_id, $item['id_san_pham'], $item['id_bien_the'], $item['so_luong'], $item['gia_ban'], $item['ten_san_pham'], $variant_text);
            $stmt_d->execute();

            // Trừ tồn kho (Tùy chọn)
            $conn->query("UPDATE bien_the_san_pham SET so_luong_ton_kho = so_luong_ton_kho - {$item['so_luong']} WHERE id_bien_the = {$item['id_bien_the']}");
        }

        // 3. Xóa giỏ hàng
        $conn->query("DELETE FROM gio_hang WHERE id_nguoi_dung = $user_id");

        // Chuyển hướng thành công
        echo "<script>window.location.href='../DonHang/DonHangCuaToi.php';</script>";
        exit();
    } else {
        echo "<script>alert('Lỗi đặt hàng, vui lòng thử lại!');</script>";
    }
}

// --- XỬ LÝ GIỎ HÀNG (Xóa, Update - Giữ nguyên code cũ) ---
if (isset($_GET['action']) && $_GET['action'] == 'remove' && isset($_GET['id_gio_hang'])) {
    $cart_id = (int)$_GET['id_gio_hang'];
    $conn->query("DELETE FROM gio_hang WHERE id_gio_hang = $cart_id AND id_nguoi_dung = $user_id");
    header("Location: Giohang.php"); exit();
}
if (isset($_GET['action']) && $_GET['action'] == 'update' && isset($_GET['id_gio_hang']) && isset($_GET['qty'])) {
    $cart_id = (int)$_GET['id_gio_hang'];
    $new_qty = max(1, (int)$_GET['qty']);
    $conn->query("UPDATE gio_hang SET so_luong = $new_qty WHERE id_gio_hang = $cart_id AND id_nguoi_dung = $user_id");
    header("Location: Giohang.php"); exit();
}

// Lấy danh sách giỏ hàng để hiển thị
$sql_cart = "SELECT gh.id_gio_hang, gh.so_luong, sp.ten_san_pham, bt.gia_ban, bt.mau_sac, bt.cau_hinh,
            (SELECT url_hinh_anh FROM hinh_anh_san_pham WHERE id_san_pham = sp.id_san_pham LIMIT 1) as hinh_anh
            FROM gio_hang gh
            JOIN san_pham sp ON gh.id_san_pham = sp.id_san_pham
            JOIN bien_the_san_pham bt ON gh.id_bien_the = bt.id_bien_the
            WHERE gh.id_nguoi_dung = $user_id ORDER BY gh.ngay_them DESC";
$result = $conn->query($sql_cart);
$cart_items = [];
while ($row = $result->fetch_assoc()) { $cart_items[] = $row; }
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng của tôi</title>
    <link rel="stylesheet" href="../index/index.css">
    <style>
        /* CSS Gốc của Giỏ hàng */
        .cart-container { max-width: 1140px; margin: 40px auto; padding: 20px; background: #f7f7f7; border-radius: 8px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); }
        .cart-container h2 { color: #004a80; text-align: center; margin-bottom: 25px; }
        .cart-header { display: flex; align-items: center; padding: 15px 0; border-bottom: 1px solid #ddd; margin-bottom: 15px; font-weight: bold; color: #555; background: #fff; }
        .col-select { width: 5%; text-align: center; }
        .col-product { width: 45%; text-align: left; padding-left: 10px; }
        .col-price { width: 15%; text-align: center; }
        .col-quantity { width: 15%; text-align: center; }
        .col-total { width: 15%; text-align: center; color: #e53935; }
        .col-actions { width: 5%; text-align: center; }
        .store-item { background-color: #fff; border-radius: 8px; margin-bottom: 15px; padding: 20px; }
        .product-item { display: flex; align-items: center; padding: 15px 0; border-bottom: 1px solid #f0f0f0; }
        .product-thumb img { width: 80px; height: 80px; object-fit: cover; border-radius: 4px; margin-right: 15px; }
        .product-details .name { font-weight: 600; color: #333; margin-bottom: 5px; }
        .quantity-control { display: flex; align-items: center; justify-content: center; }
        .btn-qty { display: flex; align-items: center; justify-content: center; width: 30px; height: 30px; border: 1px solid #ccc; background: #fff; color: #333; text-decoration: none !important; }
        .quantity-control input { width: 40px; height: 30px; text-align: center; border: 1px solid #ccc; margin: 0; outline: none; }
        .cart-footer { background: #fff; padding: 20px; margin-top: 20px; display: flex; justify-content: flex-end; align-items: center; position: sticky; bottom: 0; box-shadow: 0 -2px 10px rgba(0,0,0,0.05); }
        .total-price { font-size: 20px; color: #e53935; font-weight: bold; margin: 0 20px 0 10px; }
        .btn-checkout { padding: 12px 30px; background: #e53935; color: white; border: none; border-radius: 4px; font-size: 16px; cursor: pointer; font-weight: bold; }
        
        /* === CSS CHO CHECKOUT MODAL (MỚI) === */
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.5); }
        .modal-content { background-color: #fefefe; margin: 5% auto; border-radius: 8px; width: 90%; max-width: 900px; box-shadow: 0 5px 15px rgba(0,0,0,0.3); animation: slideDown 0.3s ease-out; }
        @keyframes slideDown { from {top: -50px; opacity: 0;} to {top: 0; opacity: 1;} }
        
        .modal-header { padding: 15px 20px; border-bottom: 1px solid #eee; background: #004a80; color: white; border-radius: 8px 8px 0 0; display: flex; justify-content: space-between; align-items: center; }
        .modal-header h3 { margin: 0; font-size: 18px; }
        .close-modal { color: white; font-size: 28px; font-weight: bold; cursor: pointer; }
        
        .modal-body { display: flex; flex-wrap: wrap; padding: 20px; gap: 30px; }
        .col-left { flex: 1; min-width: 300px; border-right: 1px solid #eee; padding-right: 20px; }
        .col-right { flex: 0.8; min-width: 250px; }

        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: 600; color: #333; }
        .form-group input, .form-group select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; box-sizing: border-box; }
        
        .payment-methods { margin-top: 10px; }
        .payment-option { display: flex; align-items: center; padding: 10px; border: 1px solid #ddd; border-radius: 5px; margin-bottom: 8px; cursor: pointer; transition: 0.2s; }
        .payment-option:hover { background: #f9f9f9; border-color: #004a80; }
        .payment-option input { width: auto; margin-right: 10px; }

        .order-summary-list { max-height: 300px; overflow-y: auto; margin-bottom: 15px; border: 1px solid #eee; padding: 10px; border-radius: 4px; }
        .summary-item { display: flex; justify-content: space-between; margin-bottom: 10px; font-size: 14px; border-bottom: 1px dashed #eee; padding-bottom: 5px; }
        .summary-total { border-top: 2px solid #ddd; padding-top: 15px; margin-top: 10px; }
        .row-total { display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 15px; }
        .final-price { color: #e53935; font-size: 22px; font-weight: bold; }

        .modal-footer { padding: 15px 20px; border-top: 1px solid #eee; text-align: right; background: #f9f9f9; border-radius: 0 0 8px 8px; }
        .btn-cancel { padding: 10px 20px; background: #ccc; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; margin-right: 10px; color: #333; }
        .btn-confirm { padding: 10px 25px; background: #e53935; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; color: white; }
        
        /* Dropdown User (Giữ nguyên) */
        .user-dropdown { position: relative; }
        .user-dropdown .dropdown-menu { display: none; position: absolute; top: 100%; right: 0; background-color: #004a80; border: 1px solid #007acc; min-width: 180px; z-index: 999; }
        .user-dropdown .dropdown-menu li a { display: block; padding: 10px 15px; color: white; text-decoration: none; }
    </style>
</head>
<body>
<div id="fox">
    <div id="fox-header"><img src="../Hinh/Foxbrand.png" alt="Fox Tech Brand"></div>
     <div id="fox-nav">
        <ul>
            <li><a href="../index/index.php">Trang chủ</a></li>
            <li><a href="../SanPham/SanPham.php">Sản phẩm</a></li>
            <li><a href="../Gioithieu/Gioithieu.html">Giới thiệu</a></li>
            <li><a href="../chinhsachbaomat/chinhsachbaomat.php">Chính sách bảo mật</a></li>
            <li><a href="../LienHe/LienHe.php">Liên hệ</a></li>
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

    <div class="cart-container">
        <h2>Giỏ hàng của bạn</h2>
        <div class="cart-header">
            <div class="col-product">Sản Phẩm</div> <div class="col-price">Đơn giá</div>
            <div class="col-quantity">Số Lượng</div> <div class="col-total">Số Tiền</div>
            <div class="col-actions">Thao Tác</div>
        </div>

        <?php $total_payment = 0; if (empty($cart_items)): ?>
            <div class="empty-cart"><p>Giỏ hàng trống.</p><a href="../SanPham/SanPham.php" class="btn-continue">Mua sắm ngay</a></div>
        <?php else: ?>
            <div class="store-item">
                <?php foreach ($cart_items as $item): 
                    $subtotal = $item['gia_ban'] * $item['so_luong'];
                    $total_payment += $subtotal;
                    $variant_text = $item['mau_sac'] . ($item['cau_hinh'] ? " - " . $item['cau_hinh'] : "");
                ?>
                <div class="product-item">
                    <div class="col-product">
                        <div class="product-thumb"><img src="<?= htmlspecialchars($item['hinh_anh'] ?: '../Hinh/default.png') ?>"></div>
                        <div class="product-details">
                            <div class="name"><?= htmlspecialchars($item['ten_san_pham']) ?></div>
                            <div class="classification">Phân loại: <?= htmlspecialchars($variant_text) ?></div>
                        </div>
                    </div>
                    <div class="col-price"><?= number_format($item['gia_ban'], 0, ',', '.') ?>₫</div>
                    <div class="col-quantity">
                        <div class="quantity-control">
                            <a href="Giohang.php?action=update&id_gio_hang=<?= $item['id_gio_hang'] ?>&qty=<?= $item['so_luong'] - 1 ?>" class="btn-qty minus">-</a>
                            <input type="text" value="<?= $item['so_luong'] ?>" readonly>
                            <a href="Giohang.php?action=update&id_gio_hang=<?= $item['id_gio_hang'] ?>&qty=<?= $item['so_luong'] + 1 ?>" class="btn-qty plus">+</a>
                        </div>
                    </div>
                    <div class="col-total"><?= number_format($subtotal, 0, ',', '.') ?>₫</div>
                    <div class="col-actions"><a href="Giohang.php?action=remove&id_gio_hang=<?= $item['id_gio_hang'] ?>" onclick="return confirm('Xóa?')">Xóa</a></div>
                </div>
                <?php endforeach; ?>
            </div>
            <div class="cart-footer">
                <div>Tổng thanh toán: </div>
                <div class="total-price"><?= number_format($total_payment, 0, ',', '.') ?>₫</div>
                <button class="btn-checkout" onclick="openCheckoutModal()">Mua Hàng</button>
            </div>
        <?php endif; ?>
    </div>
</div>

<div id="checkoutModal" class="modal">
    <form method="POST" action="Giohang.php">
        <div class="modal-content">
            <div class="modal-header">
                <h3>XÁC NHẬN ĐẶT HÀNG</h3>
                <span class="close-modal" onclick="closeCheckoutModal()">&times;</span>
            </div>
            
            <div class="modal-body">
                <div class="col-left">
                    <h4 style="color:#004a80; border-bottom: 1px solid #ddd; padding-bottom: 10px; margin-bottom: 15px;">📍 Thông tin giao hàng</h4>
                    <div class="form-group">
                        <label>Họ và tên người nhận</label>
                        <input type="text" name="fullname" value="<?= htmlspecialchars($user_info['username']) ?>" required>
                    </div>
                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <input type="text" name="phone" value="<?= htmlspecialchars($user_info['phone']) ?>" required>
                    </div>
                    <div class="form-group">
                        <label>Địa chỉ nhận hàng</label>
                        <input type="text" name="address" value="<?= htmlspecialchars($user_info['address']) ?>" required>
                    </div>

                    <h4 style="color:#004a80; border-bottom: 1px solid #ddd; padding-bottom: 10px; margin-bottom: 15px; margin-top: 20px;">💳 Phương thức thanh toán</h4>
                    <div class="payment-methods">
                        <label class="payment-option">
                            <input type="radio" name="payment_method" value="COD" checked>
                            <span>Thanh toán khi nhận hàng (COD)</span>
                        </label>
                        <label class="payment-option">
                            <input type="radio" name="payment_method" value="BANK">
                            <span>Chuyển khoản ngân hàng</span>
                        </label>
                    </div>
                </div>

                <div class="col-right">
                    <h4 style="color:#004a80; border-bottom: 1px solid #ddd; padding-bottom: 10px; margin-bottom: 15px;">🛒 Đơn hàng của bạn</h4>
                    <div class="order-summary-list">
                        <?php foreach ($cart_items as $item): ?>
                        <div class="summary-item">
                            <div style="flex: 1;">
                                <b><?= htmlspecialchars($item['ten_san_pham']) ?></b><br>
                                <span style="font-size: 12px; color: #777;"><?= htmlspecialchars($item['mau_sac']) ?></span>
                            </div>
                            <div style="text-align: right;">
                                <span>x<?= $item['so_luong'] ?></span><br>
                                <span><?= number_format($item['gia_ban'] * $item['so_luong'], 0, ',', '.') ?>₫</span>
                            </div>
                        </div>
                        <?php endforeach; ?>
                    </div>

                    <div class="summary-total">
                        <div class="row-total">
                            <span>Tạm tính:</span>
                            <span><?= number_format($total_payment, 0, ',', '.') ?>₫</span>
                        </div>
                        <div class="row-total">
                            <span>Phí vận chuyển:</span>
                            <span style="color: green;">Miễn phí</span>
                        </div>
                        <div class="row-total" style="margin-top: 15px; align-items: center;">
                            <span style="font-weight: bold;">TỔNG CỘNG:</span>
                            <span class="final-price"><?= number_format($total_payment, 0, ',', '.') ?>₫</span>
                            <input type="hidden" name="total_order_hidden" value="<?= $total_payment ?>">
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn-cancel" onclick="closeCheckoutModal()">Hủy Bỏ</button>
                <button type="submit" name="btn_confirm_order" class="btn-confirm">❤ XÁC NHẬN ĐẶT HÀNG</button>
            </div>
        </div>
    </form>
</div>

<script>
    // JS Modal
    var modal = document.getElementById("checkoutModal");
    function openCheckoutModal() { modal.style.display = "block"; }
    function closeCheckoutModal() { modal.style.display = "none"; }
    window.onclick = function(event) { if (event.target == modal) { modal.style.display = "none"; } }

    // JS Dropdown
    document.getElementById('user-toggle').addEventListener('click', function(e) {
        e.preventDefault();
        var d = this.nextElementSibling; d.style.display = (d.style.display === 'block') ? 'none' : 'block';
    });
</script>
</body>
</html>