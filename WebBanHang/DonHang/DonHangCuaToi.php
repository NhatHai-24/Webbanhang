<?php
session_start();
if (!isset($_SESSION["user"])) {
    header("Location: ../Login/Login.php");
    exit();
}

$conn = new mysqli("localhost", "root", "", "webbh");
if ($conn->connect_error) die("Kết nối thất bại: " . $conn->connect_error);

$user_id = (int)$_SESSION["user"]["id"];
$username = htmlspecialchars($_SESSION["user"]["username"]);

// --- SỬA ĐỔI: Lấy dữ liệu từ bảng 'don_hang' thay vì 'orders' ---
$sql = "SELECT * FROM don_hang WHERE id_nguoi_dung = ? ORDER BY ngay_dat DESC";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đơn hàng của tôi</title>
    <link rel="stylesheet" href="../index/index.css">
    <style>
        .order-container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 30px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
        }
        .order-container h2 {
            color: #004a80;
            text-align: center;
            margin-bottom: 25px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ccc;
            text-align: center;
            font-size: 14px;
        }
        th {
            background-color: #004a80; /* Màu xanh Fox Tech */
            color: white;
        }
        
        /* Trạng thái đơn hàng */
        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
        }
        .st-cho-xac-nhan { background: #fff3cd; color: #856404; }
        .st-da-giao { background: #d4edda; color: #155724; }
        .st-dang-giao { background: #cce5ff; color: #004085; }
        .st-da-huy { background: #f8d7da; color: #721c24; }

        /* Các nút bấm */
        .btn-action {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin: 2px;
            font-size: 13px;
            font-weight: bold;
        }
        .btn-view { background-color: #17a2b8; color: white; } /* Màu xanh xem chi tiết */
        .btn-cancel { background-color: #e53935; color: white; } /* Màu đỏ hủy */
        
        /* Dropdown User */
        .user-dropdown { position: relative; }
        .user-dropdown .dropdown-menu { display: none; position: absolute; top: 100%; right: 0; background-color: #004a80; border: 1px solid #007acc; min-width: 180px; border-radius: 0 0 6px 6px; box-shadow: 0 4px 10px rgba(0,0,0,0.15); z-index: 999; }
        .user-dropdown .dropdown-menu li a { display: block; padding: 10px 15px; color: white; text-decoration: none; border-bottom: 1px solid #005fa3; font-size: 14px; }
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
                    <li><a href="../User/ThongTinCaNhan.php">Thông tin cá nhân</a></li>s
                    <li><a href="../DonHang/Giohang.php">Giỏ hàng của tôi</a></li>
                    <li><a href="../DonHang/DonHangCuaToi.php">Đơn hàng của tôi</a></li>
                    <li><a href="../Login/logout.php">Đăng xuất</a></li>
                </ul>
            </li>
        </ul>
    </div>

    <div class="order-container">
        <h2>Lịch sử mua hàng</h2>
        <?php if ($result && $result->num_rows > 0): ?>
            <table>
                <thead>
                    <tr>
                        <th>Mã đơn</th>
                        <th>Ngày đặt</th>
                        <th>Người nhận</th>
                        <th>Tổng tiền</th>
                        <th>Thanh toán</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                <?php while ($row = $result->fetch_assoc()): ?>
                    <tr>
                        <td>#<?= $row["id_don_hang"] ?></td>
                        
                        <td><?= date("d/m/Y H:i", strtotime($row["ngay_dat"])) ?></td>
                        
                        <td style="text-align: left; padding-left: 15px;">
                            <?= htmlspecialchars($row["ho_ten_nguoi_nhan"]) ?><br>
                            <small style="color: #666;"><?= htmlspecialchars($row["sdt_nguoi_nhan"]) ?></small>
                        </td>
                        
                        <td style="color: #e53935; font-weight: bold;">
                            <?= number_format($row["tong_tien"], 0, ',', '.') ?>₫
                        </td>
                        
                        <td><?= $row["phuong_thuc_thanh_toan"] ?></td>

                        <td>
                            <?php 
                                $statusText = "Chờ xác nhận";
                                $statusClass = "st-cho-xac-nhan";
                                
                                if ($row["trang_thai"] == "Da_giao") {
                                    $statusText = "Đã giao"; $statusClass = "st-da-giao";
                                } elseif ($row["trang_thai"] == "Dang_giao") {
                                    $statusText = "Đang giao"; $statusClass = "st-dang-giao";
                                } elseif ($row["trang_thai"] == "Da_huy") {
                                    $statusText = "Đã hủy"; $statusClass = "st-da-huy";
                                }
                            ?>
                            <span class="status-badge <?= $statusClass ?>"><?= $statusText ?></span>
                        </td>

                        <td>
                            <a href="Dathang.php?id=<?= $row["id_don_hang"] ?>" class="btn-action btn-view">👁 Chi tiết</a>

                            <?php if ($row["trang_thai"] === "Cho_xac_nhan"): ?>
                                <form method="POST" action="HuyDonHang.php" style="display:inline;">
                                    <input type="hidden" name="id_don_hang" value="<?= $row["id_don_hang"] ?>">
                                    <button class="btn-action btn-cancel" onclick="return confirm('Bạn có chắc muốn hủy đơn hàng này không?')">❌ Hủy</button>
                                </form>
                            <?php endif; ?>
                        </td>
                    </tr>
                <?php endwhile; ?>
                </tbody>
            </table>
        <?php else: ?>
            <p style="text-align: center; padding: 20px; color: #666;">Bạn chưa có đơn hàng nào.</p>
            <div style="text-align:center;">
                <a href="../SanPham/SanPham.php" class="btn-action btn-view" style="padding: 10px 20px;">Mua sắm ngay</a>
            </div>
        <?php endif; ?>
    </div>

    <div id="fox-footer">
        <p>© 2025 Fox Tech. All rights reserved.</p>
    </div>
</div>

<script>
    // JS Dropdown
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