<?php
session_start();
if (!isset($_SESSION["user"])) {
    header("Location: ../Login/Login.php");
    exit();
}

require_once __DIR__ . '/../auth.php';
require_once __DIR__ . '/../config.php';
require_login();

$username = $_SESSION["user"]["username"];
$user = $conn->query("SELECT * FROM users WHERE username = '$username'")->fetch_assoc();
$message = "";

if (isset($_POST["update"])) {
    $email = $conn->real_escape_string($_POST["email"]);
    $phone = $conn->real_escape_string($_POST["phone"]);
    $address = $conn->real_escape_string($_POST["address"]);

    $conn->query("UPDATE users SET email='$email', phone='$phone', address='$address' WHERE username='$username'");
    $message = "<span style='color: green;'>✔️ Cập nhật thành công. Đang quay lại trang chủ...</span>";
    header("refresh:2;url=../index/index.php");
}
?>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Thông tin cá nhân</title>
  <link rel="stylesheet" href="../index/index.css">
  <style>
    .info-container {
        max-width: 600px;
        margin: 40px auto;
        padding: 30px;
        background: white;
        border-radius: 12px;
        box-shadow: 0 8px 28px rgba(0,0,0,0.08);
    }
    .info-container h2 {
        text-align: center;
        color: #004a80;
        margin-bottom: 25px;
    }
    .info-container label {
        display: block;
        margin-top: 15px;
        font-weight: bold;
        color: #333;
    }
    .info-container input[type="text"],
    .info-container input[type="email"] {
        width: 100%;
        padding: 10px;
        margin-top: 6px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 15px;
    }
    .info-container button {
        margin-top: 25px;
        padding: 10px 25px;
        background: #007acc;
        color: white;
        border: none;
        border-radius: 6px;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    .info-container button:hover {
        background: #005fa3;
    }
    .info-container .change-pass {
        display: block;
        text-align: right;
        margin-top: 12px;
    }
    .info-container .change-pass a {
        color: #004a80;
        text-decoration: none;
        font-size: 14px;
    }
    .info-container .change-pass a:hover {
        text-decoration: underline;
    }
  </style>
</head>
<body>
<div id="fox">
  <!-- Header -->

  <!-- Navigation -->
  <div id="fox-nav">
    <ul>
      <li><a href="../index/index.php">Trang chủ</a></li>
      <li><a href="../SanPham/SanPham.php">Sản phẩm</a></li>
      <li><a href="../Gioithieu/Gioithieu.php">Giới thiệu</a></li>
      <li><a href="../chinhsachbaomat/chinhsachbaomat.php">Chính sách bảo mật</a></li>
      <li><a href="../LienHe/LienHe.php">Liên hệ</a></li>
      <li class="user-dropdown">
        <a href="#" id="user-toggle"><?= htmlspecialchars($user["username"]) ?> ⮟</a>
        <ul class="dropdown-menu">
          <li><a href="../User/ThongTinCaNhan.php">Thông tin cá nhân</a></li>
          <li><a href="../DonHang/Giohang.php">Giỏ hàng của tôi</a></li>
          <li><a href="../DonHang/DonHangCuaToi.php">Đơn hàng của tôi</a></li>
          <li><a href="../Login/logout.php">Đăng xuất</a></li>
        </ul>
      </li>
    </ul>
  </div>

  <div class="info-container">
    <h2>👤 Thông tin cá nhân</h2>
    <?php if ($message) echo "<p style='text-align:center;'>$message</p>"; ?>

    <form method="POST">
      <label>Tên đăng nhập:</label>
      <input type="text" value="<?= htmlspecialchars($user["username"]) ?>" disabled>

      <label>Email:</label>
      <input type="email" name="email" value="<?= htmlspecialchars($user["email"] ?? '') ?>" required>

      <label>Số điện thoại:</label>
      <input type="text" name="phone" value="<?= htmlspecialchars($user["phone"] ?? '') ?>">

      <label>Địa chỉ:</label>
      <input type="text" name="address" value="<?= htmlspecialchars($user["address"] ?? '') ?>">

      <button type="submit" name="update">Cập nhật</button>

      <div class="change-pass">
        🔐 <a href="DoiMatKhau.php">Đổi mật khẩu</a>
      </div>
    </form>
  </div>

  <div id="fox-footer">
    <p>© 2025 TECHNOVA. All rights reserved.</p>
    <p>Địa chỉ: 123 Đường Nguyễn Trãi, TP.HCM | Hotline: 0123 456 789</p>
    <p>
      <a href="../index/index.php">Trang chủ</a> |
      <a href="../SanPham/SanPham.php">Sản phẩm</a> |
      <a href="../Gioithieu/Gioithieu.html">Giới thiệu</a> |
      <a href="../LienHe/LienHe.html">Liên hệ</a>
    </p>
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
            if (dropdowns[i].style.display === 'block') {
                dropdowns[i].style.display = 'none';
            }
        }
    }
}
</script>
</body>
</html>
