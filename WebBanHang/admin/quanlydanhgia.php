<?php

$current_page = basename($_SERVER['PHP_SELF']);
session_start();
require_once __DIR__ . '/../auth.php';
require_admin();
if (!isset($_SESSION["user"]) || stripos($_SESSION["user"]["username"], "admin") === false) {
    header("Location: ../Login/Login.php");
    exit();
}

$conn = new mysqli("localhost", "root", "", "webbh");
if ($conn->connect_error) die("Kết nối thất bại: " . $conn->connect_error);

// Lấy danh sách đánh giá
$sql = "SELECT 
            dg.id_danh_gia, 
            dg.id_san_pham, 
            dg.ten_nguoi_dung, 
            dg.diem_danh_gia, 
            dg.noi_dung_binh_luan, 
            dg.ngay_danh_gia, 
            sp.ten_san_pham 
        FROM danh_gia_san_pham dg
        JOIN san_pham sp ON dg.id_san_pham = sp.id_san_pham
        ORDER BY dg.ngay_danh_gia DESC";
$result = $conn->query($sql);
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý đánh giá</title>
    <link rel="stylesheet" href="admin.css?v=2">
    <style>
        .admin-container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 30px;
            background: rgba(255, 255, 255, 0.03);
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
        }

        h2 {
            color: #004a80;
            text-align: center;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 15px;
        }

        th, td {
            padding: 12px;
            border: 1px solid var(--glass-border);
            vertical-align: top;
            text-align: center;
            color: #94a3b8;
        }


        th {
            background: #004a80;
            color: white;
        }

        .btn-delete {
            background: #e53935;
            color: white;
            border: none;
            padding: 6px 14px;
            font-size: 14px;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .btn-delete:hover {
            background: #c62828;
        }

        td form {
            margin: 0;
        }
    </style>
</head>
<body>
<div id="fox">
    
    <!-- Navigation -->
    <div id="fox-nav">
        <ul>
            <li><a href="admin.php" >Trang Chủ</a></li>
            <li><a href="quanlysanpham.php" >Quản Lý Sản Phẩm</a></li>
            <li><a href="quanlydonHang.php">Quản lý Đơn Hàng</a></li>
            <li><a href="quanlynguoidung.php">Quản lý Người Dùng</a></li>
            <li><a href="quanlythongke.php">Thống Kê</a></li>
            <li><a href="quanlydanhgia.php" class="<?= ($current_page == 'quanlydanhgia.php') ? 'active' : '' ?>" >Quản lý Đánh Giá</a></li>
            <?php if (!isset($_SESSION["user"])): ?>
            <!-- Chưa đăng nhập -->
            <li><a href="../Login/Login.php">Đăng nhập</a></li>
        <?php else: ?>
            <!-- Đã đăng nhập -->
            <?php $username = htmlspecialchars($_SESSION["user"]["username"]); ?>
            <li class="user-dropdown">
                <a href="#" id="user-toggle"><?= $username ?> ⮟</a>
                <ul class="dropdown-menu" style="display: none;"> 
                    <li><a href="DoiMatKhauAdmin.php">Đổi Mật Khẩu</a></li> 
                  <li><a href="../Login/logout.php">Đăng xuất</a></li>
                  
                </ul>
            </li>
        <?php endif; ?>

        </ul>
    </div>

    <!-- Nội dung chính -->
    <div class="admin-container">
        <h2>📝 Danh sách đánh giá sản phẩm</h2>
        <table>
            <tr>
                <th>Người dùng</th>
                <th>Sản phẩm</th>
                <th>Đánh giá</th>
                <th>Nội dung</th>
                <th>Ngày đánh giá</th>
                <th>Hành động</th>
            </tr>
            <?php while ($row = $result->fetch_assoc()): ?>
                <tr>
                    <td><?= htmlspecialchars($row['ten_nguoi_dung']) ?></td>
                    <td><?= htmlspecialchars($row['ten_san_pham']) ?></td>
                    <td><?= str_repeat("⭐", $row['diem_danh_gia']) ?> (<?= $row['diem_danh_gia'] ?>/5)</td>
                    <td style="text-align: left;"><?= nl2br(htmlspecialchars($row['noi_dung_binh_luan'])) ?></td>
                    <td><?= date("d/m/Y", strtotime($row['ngay_danh_gia'])) ?></td>
                    <td>
                        <form method="POST" action="xoadanhgia.php" onsubmit="return confirm('Bạn có chắc muốn xóa đánh giá này?');">
                            <input type="hidden" name="id_danh_gia" value="<?= $row['id_danh_gia'] ?>">
                            <button type="submit" class="btn-delete">Xóa</button>
                        </form>
                    </td>
                </tr>
            <?php endwhile; ?>
        </table>
    </div>

    <!-- Footer -->
    <div id="fox-footer">
        <p>© 2025 TECHNOVA. All rights reserved.</p>
        <p>Địa chỉ: 123 Đường Nguyễn Trãi, TP.HCM | Hotline: 0123 456 789 | Email: support@technova.vn</p>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
    const toggleBtn = document.getElementById("user-toggle");
    const dropdownMenu = document.querySelector(".user-dropdown .dropdown-menu");

    if (toggleBtn && dropdownMenu) {
        toggleBtn.addEventListener("click", function (e) {
            e.preventDefault();
            dropdownMenu.style.display = dropdownMenu.style.display === "block" ? "none" : "block";
        });

        document.addEventListener("click", function (e) {
            if (!e.target.closest(".user-dropdown")) {
                dropdownMenu.style.display = "none";
            }
        });
    }
});
</script>
<script src="index.js"></script>
</body>
</html>
