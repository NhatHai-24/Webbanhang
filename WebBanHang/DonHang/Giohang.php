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

// // --- XỬ LÝ GIỎ HÀNG (Xóa, Update - Giữ nguyên code cũ) ---
// if (isset($_GET['action']) && $_GET['action'] == 'remove' && isset($_GET['id_gio_hang'])) {
//     $cart_id = (int)$_GET['id_gio_hang'];
//     $conn->query("DELETE FROM gio_hang WHERE id_gio_hang = $cart_id AND id_nguoi_dung = $user_id");
//     header("Location: Giohang.php"); exit();
// }
// if (isset($_GET['action']) && $_GET['action'] == 'update' && isset($_GET['id_gio_hang']) && isset($_GET['qty'])) {
//     $cart_id = (int)$_GET['id_gio_hang'];
//     $new_qty = max(1, (int)$_GET['qty']);
//     $conn->query("UPDATE gio_hang SET so_luong = $new_qty WHERE id_gio_hang = $cart_id AND id_nguoi_dung = $user_id");
//     header("Location: Giohang.php"); exit();
// }

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
    <link rel="stylesheet" href="demo.css">
</head>
<body>
<div id="fox">
     <div id="fox-nav">
        <ul>
            <li><a href="../index/index.php">Trang chủ</a></li>
            <li><a href="../SanPham/SanPham.php">Sản phẩm</a></li>
            <li><a href="../Gioithieu/Gioithieu.php">Giới thiệu</a></li>
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
                    $item_subtotal = $item['gia_ban'] * $item['so_luong'];
                    $total_payment += $item_subtotal;
                    
                    // Xử lý hiển thị tên biến thể
                    $variant_text = $item['mau_sac'];
                    if($item['cau_hinh']) $variant_text .= " - " . $item['cau_hinh'];
                ?>
                <div class="product-item" id="cart-item-<?= $item['id_gio_hang'] ?>">
                    <div class="col-select"><input type="checkbox" checked></div>
                    
                    <div class="col-product">
                        <div class="product-thumb">
                            <img src="<?= htmlspecialchars($item['hinh_anh'] ?: '../Hinh/default.png') ?>" alt="<?= htmlspecialchars($item['ten_san_pham']) ?>">
                        </div>
                        <div class="product-details">
                            <div class="name"><?= htmlspecialchars($item['ten_san_pham']) ?></div>
                            <div class="classification">
                                Phân loại: <?= htmlspecialchars($variant_text) ?>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-price">
                        <?= number_format($item['gia_ban'], 0, ',', '.') ?>₫
                    </div>
                    
                    <div class="col-quantity">
                        <div class="quantity-control">
                            <a href="javascript:void(0)" onclick="updateQuantity(<?= $item['id_gio_hang'] ?>, -1)" class="btn-qty minus">-</a>
                            
                            <input type="text" id="qty-<?= $item['id_gio_hang'] ?>" value="<?= $item['so_luong'] ?>" readonly>
                            
                            <a href="javascript:void(0)" onclick="updateQuantity(<?= $item['id_gio_hang'] ?>, 1)" class="btn-qty plus">+</a>
                        </div>
                    </div>
                    
                    <div class="col-total" id="total-<?= $item['id_gio_hang'] ?>">
                        <?= number_format($item_subtotal, 0, ',', '.') ?>₫
                    </div>
                    
                    <div class="col-actions item-actions">
                        <a href="javascript:void(0)" onclick="removeCartItem(<?= $item['id_gio_hang'] ?>)" class="remove">Xóa</a>
                    </div>
                </div>
                <?php endforeach; ?>
            </div>
                <div class="cart-footer">
                    <div>Tổng thanh toán (<?= count($cart_items) ?> sản phẩm): </div>
                    
                    <div class="total-price" id="grand-total">
                        <?= number_format($total_payment, 0, ',', '.') ?>₫
                    </div>
                    
                    <input type="hidden" id="hidden-total-price" value="<?= $total_payment ?>">
                    
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
    <label class="payment-option" style="display: block; margin-bottom: 8px;">
        <input type="radio" name="payment_method" value="COD" checked>
        <span>Thanh toán khi nhận hàng (COD)</span>
    </label>
    <label class="payment-option" style="display: block;">
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
    function openCheckoutModal() { modal.style.display = "flex"; }
    function closeCheckoutModal() { modal.style.display = "none"; }
    window.onclick = function(event) { if (event.target == modal) { modal.style.display = "none"; } }

    // JS Dropdown
    document.getElementById('user-toggle').addEventListener('click', function(e) {
        e.preventDefault();
        var d = this.nextElementSibling; d.style.display = (d.style.display === 'block') ? 'none' : 'block';
    });
</script>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
// 1. HÀM CẬP NHẬT SỐ LƯỢNG
function updateQuantity(cartId, change) {
    let qtyInput = $('#qty-' + cartId);
    let currentQty = parseInt(qtyInput.val());
    let newQty = currentQty + change;

    if (newQty < 1) return; // Không cho giảm dưới 1 (hoặc xử lý xóa nếu muốn)

    $.ajax({
        url: 'api_cart.php', // Gọi đến file xử lý API
        type: 'POST',
        dataType: 'json',
        data: {
            action: 'update',
            id_gio_hang: cartId,
            qty: newQty
        },
        success: function(res) {
            if (res.status === 'success') {
                // Cập nhật số lượng trong ô input
                qtyInput.val(newQty);
                // Cập nhật thành tiền của dòng đó (Server trả về chuỗi định dạng sẵn "xxx.xxx₫")
                $('#total-' + cartId).text(res.item_total);
                // Cập nhật tổng tiền cả giỏ hàng
                $('#grand-total').text(res.grand_total);
                
                // Cập nhật giá trị cho input ẩn của Modal thanh toán (nếu có dùng)
                if($('#hidden-total-price').length){
                     // Loại bỏ ký tự không phải số để lấy giá trị raw
                     let rawPrice = res.grand_total.replace(/\D/g,'');
                     $('#hidden-total-price').val(rawPrice);
                     // Cập nhật hiển thị trong Modal nếu nó đang mở
                     $('.final-price').text(res.grand_total);
                }
            } else {
                alert(res.message);
            }
        },
        error: function() {
            console.log('Lỗi kết nối server');
        }
    });
}

// 2. HÀM XÓA SẢN PHẨM
function removeCartItem(cartId) {
    if (!confirm('Bạn có chắc muốn xóa sản phẩm này?')) return;

    $.ajax({
        url: 'api_cart.php',
        type: 'POST',
        dataType: 'json',
        data: {
            action: 'remove',
            id_gio_hang: cartId
        },
        success: function(res) {
            if (res.status === 'success') {
                // Hiệu ứng mờ dần và xóa dòng HTML
                $('#cart-item-' + cartId).fadeOut(300, function() { 
                    $(this).remove(); 
                    
                    // Cập nhật tổng tiền sau khi xóa
                    $('#grand-total').text(res.grand_total);
                    
                    // Nếu giỏ hàng trống (server trả về flag is_empty)
                    if (res.is_empty) {
                        location.reload(); // Tải lại trang để hiện giao diện giỏ hàng trống
                    }
                });
            } else {
                alert(res.message);
            }
        }
    });
}
</script>
</body>
</html>