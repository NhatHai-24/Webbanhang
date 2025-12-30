<?php

$current_page = 'quanlynguoidung';
session_start();
require_once __DIR__ . '/../auth.php';
require_admin();
if (!isset($_SESSION["user"]) || strpos(strtolower($_SESSION["user"]["username"]), "admin") === false) {
    header("Location: ../Login/Login.php");
    exit();
}
$currentAdmin = $_SESSION["user"]["username"];
require_once __DIR__ . '/../config.php';

// Thêm người dùng
if (isset($_POST["add_user"])) {
    $username = $conn->real_escape_string($_POST["username"]);
    $phone = $conn->real_escape_string($_POST["phone"]);
    $address = $conn->real_escape_string($_POST["address"]);

    // 🔒 Mã hóa mật khẩu mặc định "123456"
    $raw_password = "123456";
    $hashed_password = password_hash($raw_password, PASSWORD_DEFAULT);

    // ✅ Thêm vào CSDL với mật khẩu đã mã hóa
    $conn->query("INSERT INTO users (username, phone, address, password) 
                  VALUES ('$username', '$phone', '$address', '$hashed_password')");

    header("Location: quanlynguoidung.php");
    exit();
}

// Cập nhật người dùng
if (isset($_POST["update_user"])) {
    $id = (int)$_POST["id"];
    $username = $conn->query("SELECT username FROM users WHERE id = $id")->fetch_assoc()["username"];
    if (stripos($username, "admin") === false || strtolower($username) === strtolower($currentAdmin)) {
        $phone = $conn->real_escape_string($_POST["phone"]);
        $address = $conn->real_escape_string($_POST["address"]);
        $conn->query("UPDATE users SET phone='$phone', address='$address' WHERE id = $id");
    }
    header("Location: quanlynguoidung.php");
    exit();
}

// Xoá người dùng
if (isset($_POST["delete_user"])) {
    $id = (int)$_POST["id"];
    $username = $conn->query("SELECT username FROM users WHERE id = $id")->fetch_assoc()["username"];
    if (stripos($username, "admin") === false || strtolower($username) === strtolower($currentAdmin)) {
        $conn->query("DELETE FROM users WHERE id = $id");
    }
    header("Location: quanlynguoidung.php");
    exit();
}

// Danh sách người dùng
$users = $conn->query("SELECT * FROM users");
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý người dùng</title>
    <link rel="stylesheet" href="admin.css?v=2">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
    $(document).ready(function () {
        $(".edit-toggle").click(function () {
            const row = $(this).closest("tr");
            row.find(".display-field").hide();
            row.find(".edit-field").show();
            $(this).hide();
            row.find(".btn-save, .btn-cancel").show();
        });

        $(".btn-cancel").click(function () {
            const row = $(this).closest("tr");
            row.find(".edit-field").hide();
            row.find(".display-field").show();
            row.find(".btn-save, .btn-cancel").hide();
            row.find(".edit-toggle").show();
        });
    });
    </script>
</head>
<body>
<div id="fox">
   
    <!-- Navigation -->
    <div id="fox-nav">
        <ul>
            <li><a href="admin.php">Trang Chủ</a></li>
            <li><a href="quanlysanpham.php">Quản Lý Sản Phẩm</a></li>
            <li><a href="quanlydonHang.php">Quản lý Đơn Hàng</a></li>
            <li><a href="quanlynguoidung.php" class="<?= ($current_page == 'quanlynguoidung') ? 'active' : '' ?>">Quản lý Người Dùng</a></li>
            <li><a href="quanlythongke.php">Thống Kê</a></li>
            <li><a href="quanlydanhgia.php">Quản lý Đánh Giá</a></li>
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

    <!-- Nội dung -->
    <div class="admin-container">
        <h2>👤 Quản lý người dùng</h2>

        <!-- Form thêm -->
        <div class="form-section">
            <h3>➕ Thêm người dùng mới</h3>
            <form method="POST">
                <label>Tên đăng nhập</label>
                <input type="text" name="username" required>
                <label>Số điện thoại</label>
                <input type="text" name="phone" required>
                <label>Địa chỉ</label>
                <input type="text" name="address" required>
                <button type="submit" name="add_user">Thêm người dùng</button>
            </form>
            <p style="margin-top: 10px;"><em>* Mật khẩu mặc định: 123456</em></p>
        </div>

        <!-- Danh sách -->
        <h3 style="margin-top: 40px;">📋 Danh sách người dùng</h3>
        <table class="admin-table">
            <thead>
                <tr>
                    <th>ID</th><th>Tên đăng nhập</th><th>Điện thoại</th><th>Địa chỉ</th><th>Hành động</th>
                </tr>
            </thead>
            <tbody>
            <?php while ($row = $users->fetch_assoc()): ?>
                <?php
                $isAdmin = stripos($row["username"], "admin") !== false;
                $isCurrent = strtolower($row["username"]) === strtolower($currentAdmin);
                ?>
                <tr>
                    <form method="POST">
                        <input type="hidden" name="id" value="<?= $row["id"] ?>">
                        <td><?= $row["id"] ?></td>
                        <td><?= htmlspecialchars($row["username"]) ?></td>
                        <td>
                            <span class="display-field"><?= htmlspecialchars($row["phone"]) ?></span>
                            <input type="text" name="phone" value="<?= htmlspecialchars($row["phone"]) ?>" class="edit-field" style="display:none;" required>
                        </td>
                        <td>
                            <span class="display-field"><?= htmlspecialchars($row["address"]) ?></span>
                            <input type="text" name="address" value="<?= htmlspecialchars($row["address"]) ?>" class="edit-field" style="display:none;" required>
                        </td>
                        <td class="action-buttons">
                            <?php if (!$isAdmin || $isCurrent): ?>
                                <button type="button" class="btn-edit edit-toggle">Sửa</button>
                                <button type="submit" name="update_user" class="btn-edit btn-save" style="display:none;">Lưu</button>
                                <button type="button" class="btn-edit btn-cancel" style="display:none;">Hủy</button>
                                <?php if (!$isCurrent): ?>
                                    <button type="submit" name="delete_user" class="btn-delete">Xóa</button>
                                <?php endif; ?>
                            <?php else: ?>
                                <span style="color: gray;">Không thể thao tác</span>
                            <?php endif; ?>
                        </td>
                    </form>
                </tr>
            <?php endwhile; ?>
            </tbody>
        </table>

        <div style="margin-top: 30px;">
            <a href="admin.php" class="btn">← Quay lại trang Admin</a>
        </div>
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
