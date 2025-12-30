<?php
$current_page = 'sanpham';
session_start();
// Hàm kiểm tra user đã đăng nhập chưa
function isUserLoggedIn() {
    return isset($_SESSION["user"]) && !empty($_SESSION["user"]["id"]);
}

require_once __DIR__ . '/../config.php';

$id = (int)($_GET['id_san_pham'] ?? 0);

// Lấy thông tin sản phẩm
$sql = "SELECT sp.*, 
        (SELECT url_hinh_anh FROM hinh_anh_san_pham WHERE id_san_pham = sp.id_san_pham AND la_anh_dai_dien = TRUE LIMIT 1) AS url_hinh_anh, 
        (SELECT MIN(gia_ban) FROM bien_the_san_pham WHERE id_san_pham = sp.id_san_pham) AS gia_thap_nhat
        FROM san_pham sp
        WHERE sp.id_san_pham = $id";
$result = $conn->query($sql);
$product = $result->fetch_assoc();

// Lấy biến thể
$variants = [];
$result_variant = $conn->query("SELECT * FROM bien_the_san_pham WHERE id_san_pham = $id");
while ($row = $result_variant->fetch_assoc()) {
    $variants[] = $row;
}

// Thêm đoạn này sau khi lấy product
$user_info = [
    'username' => $_SESSION['user']['username'] ?? '',
    'phone' => $_SESSION['user']['phone'] ?? '',
    'address' => $_SESSION['user']['address'] ?? ''
];


// Lấy đánh giá
$reviews = [];
$result_reviews = $conn->query("SELECT * FROM danh_gia_san_pham WHERE id_san_pham = $id ORDER BY ngay_danh_gia DESC");
while ($r = $result_reviews->fetch_assoc()) {
    $reviews[] = $r;
}

$conn->close();

// Xử lý video link
$videoLink = $product['video_gioi_thieu'] ?? '';
$embedLink = '';
if (strpos($videoLink, 'watch?v=') !== false) {
    $embedLink = str_replace('watch?v=', 'embed/', $videoLink);
} elseif (strpos($videoLink, 'youtu.be/') !== false) {
    $videoId = substr($videoLink, strrpos($videoLink, '/') + 1);
    $embedLink = 'https://www.youtube.com/embed/' . $videoId;
} elseif (strpos($videoLink, 'embed/') !== false) {
    $embedLink = $videoLink;
}
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><?= htmlspecialchars($product['ten_san_pham'] ?? 'Chi tiết sản phẩm') ?></title>
    <link rel="stylesheet" href="../index/index.css">
    <link rel="stylesheet" href="chiTietSanPham.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
    $(document).ready(function() {
        $(".product-detail-wrapper img").hover(
            function() { $(this).css("transform", "scale(1.02)"); },
            function() { $(this).css("transform", "scale(1)"); }
        );
        $(".product-info-block h3").css("cursor", "pointer").click(function() {
            $(this).siblings("p").slideToggle();
        });
        $(".variant-section h3").css("cursor", "pointer").click(function() {
            $(this).next("ul").slideToggle();
        });
        $(".review-section h3").click(function() {
            $('html, body').animate({ scrollTop: $(".review-section").offset().top - 100 }, 600);
        });
    });
    </script>
</head>
<body>
    <div id="preloader"><div class="loader"></div></div>
<canvas id="tech-canvas"></canvas>
    <div id="fox-nav">
        <ul>
            <li><a href="../index/index.php">Trang chủ</a></li>
            <li><a href="../SanPham/SanPham.php" class="<?= ($current_page == 'sanpham') ? 'active' : '' ?>">Sản phẩm</a></li>
            <li><a href="../Gioithieu/Gioithieu.php">Giới thiệu</a></li>
            <li><a href="../ChinhSachBaoMat/ChinhSachBaoMat.php">Chính sách bảo mật</a></li>
            <li><a href="../LienHe/LienHe.php">Liên hệ</a></li>
            <?php if (!isset($_SESSION["user"])): ?>
                <li><a href="../Login/Login.php">Đăng nhập</a></li>
            <?php else: ?>
                <?php $username = htmlspecialchars($_SESSION["user"]["username"]); ?>
                <li class="user-dropdown">
                    <a href="#" id="user-toggle"><?= $username ?> ⮟</a>
                    <ul class="dropdown-menu" style="display: none;">
                        <li><a href="../User/ThongTinCaNhan.php">Thông tin cá nhân</a></li>
                        <li><a href="../DonHang/Giohang.php">Giỏ hàng của tôi</a></li>
                        <li><a href="../DonHang/DonHangCuaToi.php">Đơn hàng của tôi</a></li>
                        <li><a href="../Login/logout.php">Đăng xuất</a></li>
                    </ul>
                </li>
            <?php endif; ?>
        </ul>
    </div>

    <?php if ($product): ?>
    <div class="product-detail-wrapper">
        <h1><?= htmlspecialchars($product['ten_san_pham']) ?></h1>
        <div class="product-detail-layout">
            <div class="product-image-block">
                <img src="<?= htmlspecialchars($product['url_hinh_anh'] ?: 'https://placehold.co/600x350') ?>" alt="Ảnh sản phẩm">
            </div>
            <div class="product-info-block">
                <h3>Thông tin sản phẩm</h3>
                <p><strong>Giá từ:</strong> <?= number_format($product['gia_thap_nhat'], 0, ',', '.') ?>₫</p>
                <p><strong>Mô tả:</strong> <?= nl2br(htmlspecialchars($product['mo_ta'])) ?></p>
                <p><strong>Thông số kỹ thuật:</strong><br><?= nl2br(htmlspecialchars($product['thong_so_ky_thuat'])) ?></p>
                <p><strong>Khuyến mãi:</strong> <?= htmlspecialchars($product['chuong_trinh_khuyen_mai'] ?: "Không có") ?></p>
                <p><strong>Bảo hành:</strong> <?= htmlspecialchars($product['bao_hanh']) ?></p>

                <div class="variant-section">
                    <h4>Màu sản phẩm</h4>
                    <ul>
                        <?php foreach ($variants as $v): ?>
                            <li>Màu: <?= htmlspecialchars($v['mau_sac']) ?> | Cấu hình: <?= htmlspecialchars($v['cau_hinh']) ?: "Mặc định" ?> | Giá: <?= number_format($v['gia_ban'], 0, ',', '.') ?>₫ | Kho: <?= $v['so_luong_ton_kho'] ?></li>
                        <?php endforeach; ?>
                    </ul>
                </div>

                <form method="POST" action="../DonHang/DatHang.php" class="order-form">
                    <input type="hidden" name="ten_san_pham" value="<?= htmlspecialchars($product['ten_san_pham']) ?>">
                    <input type="hidden" name="product_id" value="<?= $product['id_san_pham'] ?>">

                    <?php
                     if (count($variants) > 0): ?>
                        <div class="variant-wrapper">
                            <label for="id_bien_the">Chọn màu sản phẩm:</label>
                            <select name="id_bien_the" id="id_bien_the" required>
                                <option value="" disabled selected>-- Chọn màu --</option>
                                <?php foreach ($variants as $v): ?>
                                    <option value="<?= $v['id_bien_the'] ?>" 
                                            data-price="<?= $v['gia_ban'] ?>"
                                            data-name="<?= htmlspecialchars($v['mau_sac']) ?> - <?= htmlspecialchars($v['cau_hinh'] ?: 'Mặc định') ?>"
                                            data-stock="<?= $v['so_luong_ton_kho'] ?>">
                                        <?= htmlspecialchars($v['mau_sac']) ?> - Kho: <?= $v['so_luong_ton_kho'] ?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    <?php else: ?>
                        <input type="hidden" name="id_bien_the" id="id_bien_the" value="0">
                    <?php endif; ?>
                    <div class="quantity-wrapper">
                        <label for="quantity">Số lượng:</label>
                        <input type="number" id="quantity" name="quantity" value="1" min="1" required>
                    </div>

                    <div class="action-buttons">
                        <button type="button" onclick="ajaxAddToCart()" class="add-to-cart-btn" style="padding: 12px 25px; background-color: #35fdecff; color: #333; border: none; border-radius: 4px; font-weight: bold; cursor: pointer;">➕ Thêm vào Giỏ hàng</button>
                        <?php if (!isUserLoggedIn()): ?>
                            <button type="button" class="btn-order" id="btnShowLoginMsg">🛒 Đặt hàng ngay</button>
                        <?php else: ?>
                            <button type="button" onclick="openCheckoutModal()" class="btn-order">🛒 Đặt hàng ngay</button>
                        <?php endif; ?>
                    </div>
                </form>
            </div>
        </div>

        <?php if (!empty($embedLink)): ?>
        <div class="video-section">
            <h3>Video giới thiệu</h3>
            <iframe src="<?= htmlspecialchars($embedLink) ?>" frameborder="0" allowfullscreen></iframe>
        </div>
        <?php endif; ?>

        <div class="review-section">
            <h3>🗣️ Đánh giá & Bình luận</h3>
            <?php if (!empty($reviews)): ?>
                <?php foreach ($reviews as $rv): ?>
                    <div class="review-box">
                        <div class="review-header">
                            <span class="review-user"><?= htmlspecialchars($rv['ten_nguoi_dung']) ?></span>
                            <span class="review-rating-stars"><?php for ($i = 1; $i <= 5; $i++) echo $i <= $rv['diem_danh_gia'] ? '★' : '☆'; ?> (<?= $rv['diem_danh_gia'] ?>/5)</span>
                            <span class="review-date"><?= date("d/m/Y", strtotime($rv['ngay_danh_gia'])) ?></span>
                        </div>
                        <div class="review-content"><?= nl2br(htmlspecialchars($rv['noi_dung_binh_luan'])) ?></div>
                    </div>
                <?php endforeach; ?>
            <?php else: ?>
                <p style="margin: 10px 0; color: #666;">Chưa có đánh giá nào cho sản phẩm này.</p>
            <?php endif; ?>

            <?php if (isset($_SESSION["user"])): ?>
            <div class="review-form">
                <h3>Gửi đánh giá của bạn</h3>
                <form method="POST" action="../DonHang/XuLyDanhGia.php">
                    <input type="hidden" name="id_san_pham" value="<?= $product['id_san_pham'] ?>">
                    <label for="diem_danh_gia">Chọn số sao:</label>
                    <select name="diem_danh_gia" required>
                        <option value="">-- Chọn số sao --</option>
                        <?php for ($i = 5; $i >= 1; $i--): ?><option value="<?= $i ?>"><?= $i ?> sao</option><?php endfor; ?>
                    </select>
                    <label for="noi_dung_binh_luan">Nội dung bình luận:</label>
                    <textarea name="noi_dung_binh_luan" rows="3" placeholder="Nhập đánh giá của bạn..." required></textarea>
                    <button type="submit" class="btn-order">📩 Gửi đánh giá</button>
                </form>
            </div>
            <?php endif; ?>
        </div>
        <button class="btn-back" onclick="window.location.href='SanPham.php'">← Quay lại danh sách sản phẩm</button>
    </div>
    <?php else: ?>
        <p style="text-align:center; margin: 50px 0; font-size: 18px;">Không tìm thấy sản phẩm.</p>
    <?php endif; ?>

    
</div>
<div id="fox-footer">
        <p>© 2025 TECHNOVA. All rights reserved.</p>
        <p>Địa chỉ: 123 Đường Nguyễn Trãi, TP.HCM | Hotline: 0123 456 789 | Email: support@technova.vn</p>
        <p>
            <a href="../index/index.html">Trang chủ</a> |
            <a href="../SanPham/SanPham.php">Sản phẩm</a> |
            <a href="../Gioithieu/Gioithieu.html">Giới thiệu</a> |
            <a href="../ChinhSachBaoMat/ChinhSachBaoMat.html">Chính sách bảo mật</a> |
            <a href="../LienHe/LienHe.html">Liên hệ</a>
        </p>
    </div>

<div id="checkoutModal" class="modal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 10000; justify-content: center; align-items: center;">
    <form method="POST" action="../DonHang/DatHang.php">
        <div class="modal-content" style="background:#fff; width: 90%; max-width: 800px; max-height: 90vh; overflow-y: auto; border-radius: 8px; display:flex; flex-direction:column; padding: 0;">
            <div class="modal-header" style="padding: 15px; border-bottom: 1px solid #ddd; display: flex; justify-content: space-between; align-items: center; background: #004a80; color: white;">
                <h3 style="margin:0;">XÁC NHẬN ĐẶT HÀNG</h3>
                <span class="close-modal" onclick="closeCheckoutModal()" style="font-size: 28px; cursor: pointer;">&times;</span>
            </div>
            
            <div class="modal-body" style="padding: 20px; display: flex; gap: 20px; flex-wrap: wrap; color: #333;">
                <div class="col-left" style="flex: 1; min-width: 300px;">
                    <h4 style="color:#004a80; border-bottom: 1px solid #ddd; padding-bottom: 10px; margin-bottom: 15px;">📍 Thông tin giao hàng</h4>
                    
                    <input type="hidden" name="product_id" value="<?= $product['id_san_pham'] ?>">
                    <input type="hidden" name="id_bien_the" id="modal_input_variant">
                    <input type="hidden" name="quantity" id="modal_input_quantity">
                    <input type="hidden" name="total_payment" id="modal_input_total">
                    <input type="hidden" name="buy_now" value="1">

                    <div class="form-group" style="margin-bottom: 15px;">
                        <label style="display:block; margin-bottom: 5px; font-weight: bold; color: #333;">Họ và tên người nhận</label>
                        <input type="text" name="fullname" value="<?= htmlspecialchars($user_info['username']) ?>" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; color: #333;">
                    </div>
                    <div class="form-group" style="margin-bottom: 15px;">
                        <label style="display:block; margin-bottom: 5px; font-weight: bold; color: #333;">Số điện thoại</label>
                        <input type="text" name="phone" value="<?= htmlspecialchars($user_info['phone']) ?>" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; color: #333;">
                    </div>
                    <div class="form-group" style="margin-bottom: 15px;">
                        <label style="display:block; margin-bottom: 5px; font-weight: bold; color: #333;">Địa chỉ nhận hàng</label>
                        <input type="text" name="address" value="<?= htmlspecialchars($user_info['address']) ?>" required style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; color: #333;">
                    </div>

                    <h4 style="color:#004a80; border-bottom: 1px solid #ddd; padding-bottom: 10px; margin-bottom: 15px; margin-top: 20px;">💳 Phương thức thanh toán</h4>
                    <div class="payment-methods">
                        <label class="payment-option" style="display: block; margin-bottom: 8px; cursor: pointer; color: #333;">
                            <input type="radio" name="payment_method" value="COD" checked>
                            <span style="color: #333;">Thanh toán khi nhận hàng (COD)</span>
                        </label>
                        <label class="payment-option" style="display: block; cursor: pointer; color: #333;">
                            <input type="radio" name="payment_method" value="BANK">
                            <span style="color: #333;">Chuyển khoản ngân hàng</span>
                        </label>
                    </div>
                </div>

                <div class="col-right" style="flex: 1; min-width: 300px; background: #f9f9f9; padding: 15px; border-radius: 8px;">
                    <h4 style="color:#004a80; border-bottom: 1px solid #ddd; padding-bottom: 10px; margin-bottom: 15px;">🛒 Đơn hàng của bạn</h4>
                    <div class="order-summary-list">
                        <div class="summary-item" style="display: flex; justify-content: space-between; margin-bottom: 15px; padding-bottom: 15px; border-bottom: 1px dashed #ccc;">
                            <div style="flex: 1;">
                                <b id="modal_prod_name" style="font-size: 16px; color: #333;"></b><br>
                                <span id="modal_var_name" style="font-size: 13px; color: #666;"></span>
                            </div>
                            <div style="text-align: right;">
                                <span id="modal_qty_display" style="display: block; font-weight: bold; color: #333;"></span>
                                <span id="modal_price_display" style="color: #d32f2f;"></span>
                            </div>
                        </div>
                    </div>

                    <div class="summary-total">
                        <div class="row-total" style="display: flex; justify-content: space-between; margin-bottom: 10px; color: #333;">
                            <span>Phí vận chuyển:</span>
                            <span style="color: green;">Miễn phí</span>
                        </div>
                        <div class="row-total" style="display: flex; justify-content: space-between; align-items: center; margin-top: 15px; font-size: 18px; color: #d32f2f; font-weight: bold; border-top: 2px solid #ddd; padding-top: 15px;">
                            <span style="color: #d32f2f;">TỔNG CỘNG:</span>
                            <span id="modal_total_payment" class="final-price">0₫</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal-footer" style="padding: 15px; border-top: 1px solid #ddd; text-align: right; background: #f1f1f1;">
                <button type="button" class="btn-cancel" onclick="closeCheckoutModal()" style="padding: 10px 20px; border: 1px solid #ccc; background: white; cursor: pointer; margin-right: 10px; border-radius: 4px; color: #333;">Hủy Bỏ</button>
                <button type="submit" name="btn_confirm_order" class="btn-confirm" style="padding: 10px 20px; border: none; background: #e53935; color: white; font-weight: bold; cursor: pointer; border-radius: 4px;">❤ XÁC NHẬN ĐẶT HÀNG</button>
            </div>
        </div>
    </form>
</div>

<div id="successCartMsg" style="display:none; position:fixed; top:30%; left:50%; transform:translate(-50%,-50%); background:#fff; border:2px solid #4CAF50; padding:30px 40px; border-radius:10px; box-shadow:0 4px 16px rgba(0,0,0,0.2); z-index:9999; text-align:center;">
    <div style="font-size:40px; margin-bottom:10px;">✅</div>
    <p style="font-size:18px; color:#333; margin-bottom:20px; font-weight: bold;">Đã thêm vào giỏ hàng thành công!</p>
    <div style="display:flex; gap:10px; justify-content:center;">
        <button onclick="document.getElementById('successCartMsg').style.display='none'" style="padding:8px 20px; border:1px solid #ccc; background:#f9f9f9; border-radius:5px; cursor:pointer;">Tiếp tục xem</button>
        <a href="../DonHang/Giohang.php" style="padding:8px 20px; border:none; background:#007acc; color:#fff; border-radius:5px; cursor:pointer; text-decoration:none;">Xem Giỏ hàng</a>
    </div>
</div>

<div id="loginMsgBox" style="display:none;position:fixed;top:30%;left:50%;transform:translate(-50%,-50%);background:#fff;border:2px solid #007acc;padding:30px 40px;border-radius:10px;box-shadow:0 4px 16px rgba(0,0,0,0.15);z-index:9999;text-align:center;">
    <p style="font-size:18px;color:#e53935;margin-bottom:20px;">Vui lòng <a href="../Login/Login.php" style="color:#007acc;text-decoration:underline;">đăng nhập</a> để mua hàng.</p>
    <button onclick="document.getElementById('loginMsgBox').style.display='none'" style="padding:8px 20px;border:none;background:#007acc;color:#fff;border-radius:5px;cursor:pointer;">Đóng</button>
</div>

<script>
function ajaxAddToCart() {
    <?php if (!isset($_SESSION['user'])) { ?>
        document.getElementById("loginMsgBox").style.display = "block";
        return;
    <?php } ?>

    var product_id = $('input[name="product_id"]').val();
    var variant_id = $('#id_bien_the').val();
    var quantity   = $('#quantity').val();

    if (!variant_id) { alert("Vui lòng chọn màu sắc!"); $('#id_bien_the').focus(); return; }
    if (quantity < 1) { alert("Số lượng phải lớn hơn 0!"); return; }

    $.ajax({
        url: '../DonHang/api_cart.php',
        type: 'POST',
        dataType: 'json',
        data: { action: 'add', product_id: product_id, variant_id: variant_id, quantity: quantity },
        success: function(response) {
            if (response.status === 'success') {
                document.getElementById('successCartMsg').style.display = 'block';
            } else {
                alert(response.message);
            }
        },
        error: function() { alert('Có lỗi xảy ra khi kết nối đến server.'); }
    });
}

document.addEventListener("DOMContentLoaded", function() {
    var btnShowLoginMsg = document.getElementById("btnShowLoginMsg");
    if (btnShowLoginMsg) {
        btnShowLoginMsg.addEventListener("click", function(e) {
            document.getElementById("loginMsgBox").style.display = "block";
        });
    }
    // Dropdown user logic
    const toggleBtn = document.getElementById("user-toggle");
    const dropdownMenu = document.querySelector(".user-dropdown .dropdown-menu");
    if (toggleBtn && dropdownMenu) {
        toggleBtn.addEventListener("click", function (e) {
            e.preventDefault();
            dropdownMenu.style.display = dropdownMenu.style.display === "block" ? "none" : "block";
        });
        document.addEventListener("click", function (e) {
            if (!e.target.closest(".user-dropdown")) dropdownMenu.style.display = "none";
        });
    }
});
</script>
<script src="ChiTietSanPham.js"></script>
<script>
   
    // JS Dropdown
    document.getElementById('user-toggle').addEventListener('click', function(e) {
        e.preventDefault();
        var d = this.nextElementSibling;
        d.style.display = (d.style.display === 'block') ? 'none' : 'block';
    });
</script>

<script>
function ajaxAddToCart() {
    <?php if (!isset($_SESSION['user'])) { ?>
        document.getElementById("loginMsgBox").style.display = "block";
        return;
    <?php } ?>

    var product_id = $('input[name="product_id"]').val();
    var variant_id = $('#id_bien_the').val();
    var quantity   = $('#quantity').val();

    if (!variant_id) { alert("Vui lòng chọn màu sắc!"); $('#id_bien_the').focus(); return; }
    if (quantity < 1) { alert("Số lượng phải lớn hơn 0!"); return; }

    $.ajax({
        url: '../DonHang/api_cart.php',
        type: 'POST',
        dataType: 'json',
        data: { action: 'add', product_id: product_id, variant_id: variant_id, quantity: quantity },
        success: function(response) {
            if (response.status === 'success') {
                document.getElementById('successCartMsg').style.display = 'block';
            } else {
                alert(response.message);
            }
        },
        error: function() { alert('Có lỗi xảy ra khi kết nối đến server.'); }
    });
}

document.addEventListener("DOMContentLoaded", function() {
    var btnShowLoginMsg = document.getElementById("btnShowLoginMsg");
    if (btnShowLoginMsg) {
        btnShowLoginMsg.addEventListener("click", function(e) {
            document.getElementById("loginMsgBox").style.display = "block";
        });
    }
    // Dropdown user logic
    const toggleBtn = document.getElementById("user-toggle");
    const dropdownMenu = document.querySelector(".user-dropdown .dropdown-menu");
    if (toggleBtn && dropdownMenu) {
        toggleBtn.addEventListener("click", function (e) {
            e.preventDefault();
            dropdownMenu.style.display = dropdownMenu.style.display === "block" ? "none" : "block";
        });
        document.addEventListener("click", function (e) {
            if (!e.target.closest(".user-dropdown")) dropdownMenu.style.display = "none";
        });
    }
});
</script>
<script src="ChiTietSanPham.js"></script>
<script>
 
    function openCheckoutModal() {
        // 1. Lấy giá trị từ form
        var variantSelect = document.getElementById('id_bien_the');
        var quantityInput = document.getElementById('quantity');
        
        // 2. Kiểm tra user đã chọn biến thể chưa
        var variantId = variantSelect.value;
        if (!variantId || variantId == 0) {
            alert("Vui lòng chọn màu sắc trước khi đặt hàng!");
            variantSelect.focus();
            return;
        }

        // 3. Lấy dữ liệu từ thẻ Option đã chọn
        var selectedOption = variantSelect.options[variantSelect.selectedIndex];
        var price = parseInt(selectedOption.getAttribute('data-price')) || 0;
        var variantName = selectedOption.getAttribute('data-name') || 'N/A';
        var quantity = parseInt(quantityInput.value) || 1;
        var productName = "<?= htmlspecialchars($product['ten_san_pham']) ?>";
        
        // Kiểm tra giá có hợp lệ không
        if (price === 0 || isNaN(price)) {
            alert("Không thể lấy giá sản phẩm. Vui lòng chọn màu khác!");
            return;
        }
        
        var total = price * quantity;

        // 4. Điền vào Modal HTML
        document.getElementById('modal_prod_name').innerText = productName;
        document.getElementById('modal_var_name').innerText = variantName;
        document.getElementById('modal_qty_display').innerText = 'x' + quantity;
        document.getElementById('modal_price_display').innerText = new Intl.NumberFormat('vi-VN').format(price) + '₫';
        document.getElementById('modal_total_payment').innerText = new Intl.NumberFormat('vi-VN').format(total) + '₫';

        // 5. Điền vào Input ẩn để Submit Form
        document.getElementById('modal_input_variant').value = variantId;
        document.getElementById('modal_input_quantity').value = quantity;
        document.getElementById('modal_input_total').value = total;

        // 6. Hiển thị Modal
        document.getElementById('checkoutModal').style.display = 'flex';
    }

    function closeCheckoutModal() { 
        document.getElementById('checkoutModal').style.display = "none"; 
    }
    
    // Đóng modal khi click ra ngoài
    window.onclick = function(event) { 
        var modal = document.getElementById("checkoutModal");
        if (event.target == modal) { modal.style.display = "none"; } 
    }
</script>

</body>
</html>