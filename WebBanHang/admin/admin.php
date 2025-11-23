<?php
session_start();
$current_page = basename($_SERVER['PHP_SELF']);

// Nếu chưa đăng nhập hoặc không phải là admin thì quay về trang đăng nhập
if (!isset($_SESSION["user"]) || strpos(strtolower($_SESSION["user"]["username"]), "admin") === false) {
    header("Location: ../Login/Login.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Fox Tech - Trang Quản Trị</title>
  <link rel="stylesheet" href="admin.css?v=2">
</head>
<body>
  <div id="fox">
  
    <!-- Navigation -->
    <div id="fox-nav">
      <ul>
        <li><a href="admin.php" class="<?= ($current_page == 'admin.php') ? 'active' : '' ?>">Trang chủ</a></li>
        <li><a href="quanlysanpham.php" class="<?= ($current_page == 'quanlysanpham.php') ? 'active' : '' ?>">Sản phẩm</a></li>
        <li><a href="../Login/Logout.php" class="<?= ($current_page == '../Login/Logout.php') ? 'active' : '' ?>">Đăng xuất</a></li>
      </ul>
    </div>

    <!-- Admin Dashboard -->
    <div class="admin-container">
      <h2>Bảng điều khiển quản trị</h2>
      <div class="admin-section">
        <div class="admin-card">
          <h3>Quản lý người dùng</h3>
          <p>Thêm, sửa, xóa thông tin tài khoản người dùng.</p>
          <a href="quanlynguoidung.php">Xem chi tiết</a>
        </div>
        <div class="admin-card">
          <h3>Quản lý sản phẩm</h3>
          <p>Thêm, chỉnh sửa hoặc xóa các mặt hàng đang bán.</p>
          <a href="quanlysanpham.php">Xem chi tiết</a>
        </div>
        <div class="admin-card">
          <h3>Quản lý đơn hàng</h3>
          <p>Theo dõi và cập nhật tình trạng các đơn hàng.</p>
          <a href="quanlydonhang.php">Xem chi tiết</a>
        </div>
        <div class="admin-card">
          <h3>Thống kê doanh thu</h3>
          <p>Xem báo cáo doanh thu theo ngày, tháng, năm.</p>
          <a href="quanlythongke.php">Xem chi tiết</a>
        </div>
      </div>
    </div>

    <!-- Footer -->
    <div id="fox-footer">
      <p>© 2025 Team 7. All rights reserved.</p>
      <p>Địa chỉ: 123 Đường Công Nghệ, TP.HCM | Hotline: 0123 456 789</p>
      <p>
        <a href="../index/index.php">Trang chủ</a> | 
        <a href="quanlysanpham.php">Sản phẩm</a> | 
        <a href="../Login/Logout.php">Đăng xuất</a>
      </p>
    </div>
  </div>
</body>
</html>
