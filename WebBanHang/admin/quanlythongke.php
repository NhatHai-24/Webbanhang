<?php
session_start();

// Kiểm tra quyền Admin
if (!isset($_SESSION["user"]) || stripos($_SESSION["user"]["username"], "admin") === false) {
    header("Location: ../Login/Login.php");
    exit();
}

$conn = new mysqli("localhost", "root", "", "webbh");
if ($conn->connect_error) {
    die("Kết nối thất bại: " . $conn->connect_error);
}

// 1. Tổng sản phẩm (Lấy từ bảng san_pham)
$totalProduct = $conn->query("SELECT COUNT(*) FROM san_pham")->fetch_row()[0];

// 2. Tổng đơn hàng (Lấy từ bảng don_hang)
$totalOrder = $conn->query("SELECT COUNT(*) FROM don_hang")->fetch_row()[0];

// 3. Tổng doanh thu (Chỉ tính các đơn hàng có trạng thái 'Da_giao')
// Lưu ý: Cột tiền là 'tong_tien', trạng thái là 'trang_thai'
$totalRevenue = $conn->query("SELECT SUM(tong_tien) FROM don_hang WHERE trang_thai = 'Da_giao'")->fetch_row()[0] ?? 0;

// 4. Doanh thu theo tháng (12 tháng gần nhất)
// Cột ngày là 'ngay_dat'
$queryRevenue = "
    SELECT DATE_FORMAT(ngay_dat, '%Y-%m') AS month, SUM(tong_tien) AS revenue
    FROM don_hang
    WHERE trang_thai = 'Da_giao'
    GROUP BY month
    ORDER BY month DESC
    LIMIT 12
";
$monthlyRevenue = $conn->query($queryRevenue)->fetch_all(MYSQLI_ASSOC);
$monthlyRevenue = array_reverse($monthlyRevenue); // Đảo ngược để hiển thị từ cũ đến mới trên biểu đồ
?>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Thống kê - Fox Tech</title>
  <link rel="stylesheet" href="../index/index.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    .admin-container {
      max-width: 1000px;
      margin: 40px auto;
      background: white;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
    }
    .stat-box {
      display: flex;
      justify-content: space-between;
      margin-bottom: 40px;
      gap: 20px;
    }
    .stat {
      background: #f8faff;
      padding: 25px;
      border-radius: 10px;
      width: 32%;
      text-align: center;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      border: 1px solid #e1e9f5;
      transition: transform 0.2s;
    }
    .stat:hover {
        transform: translateY(-5px);
        border-color: #007acc;
    }
    .stat h3 {
      margin-bottom: 10px;
      color: #555;
      font-size: 16px;
      text-transform: uppercase;
    }
    .stat p {
        font-size: 24px;
        font-weight: bold;
        color: #004a80;
        margin: 0;
    }
    canvas {
      max-width: 100%;
      height: auto;
    }
    h2, h3 { color: #004a80; }
  </style>
</head>
<body>
<div id="fox">
  <div id="fox-header">
    <img src="../Hinh/Foxbrand.png" alt="Fox Tech Brand">
  </div>

  <div id="fox-nav">
    <ul>
        <li><a href="admin.php">Trang Chủ</a></li>
        <li><a href="quanlysanpham.php">Quản Lý Sản Phẩm</a></li>
        <li><a href="quanlydonHang.php">Quản lý Đơn Hàng</a></li>
        <li><a href="quanlynguoidung.php">Quản lý Người Dùng</a></li>
        <li><a href="quanlythongke.php">Thống Kê</a></li>
        <li><a href="quanlydanhgia.php">Quản lý Đánh Giá</a></li>
        <li><a href="../Login/logout.php">Đăng Xuất</a></li>
    </ul>
  </div>

  <div class="admin-container">
    <h2>📊 Thống kê hệ thống</h2>

    <div class="stat-box">
      <div class="stat">
        <h3>📦 Tổng sản phẩm</h3>
        <p><?= number_format($totalProduct) ?></p>
      </div>
      <div class="stat">
        <h3>🛒 Tổng đơn hàng</h3>
        <p><?= number_format($totalOrder) ?></p>
      </div>
      <div class="stat">
        <h3>💰 Tổng doanh thu</h3>
        <p><?= number_format($totalRevenue, 0, ',', '.') ?>₫</p>
      </div>
    </div>

    <h3 style="text-align:center; margin-bottom:20px;">📈 Biểu đồ doanh thu theo tháng (Đã giao)</h3>
    <canvas id="revenueChart"></canvas>
  </div>

  <div id="fox-footer">
    <p>© 2025 Fox Tech. All rights reserved.</p>
  </div>
</div>

<script>
// Lấy dữ liệu từ PHP xuất sang JS
const labels = <?= json_encode(array_column($monthlyRevenue, 'month')) ?>;
const dataRevenue = <?= json_encode(array_column($monthlyRevenue, 'revenue')) ?>;

const ctx = document.getElementById('revenueChart').getContext('2d');
const chart = new Chart(ctx, {
  type: 'bar', // Loại biểu đồ: cột
  data: {
    labels: labels,
    datasets: [{
      label: 'Doanh thu (VNĐ)',
      data: dataRevenue,
      backgroundColor: 'rgba(0, 122, 204, 0.7)', // Màu xanh Fox Tech
      borderColor: 'rgba(0, 122, 204, 1)',
      borderWidth: 1,
      borderRadius: 5
    }]
  },
  options: {
    responsive: true,
    plugins: {
      legend: {
        position: 'top',
      },
      tooltip: {
        callbacks: {
          label: function(context) {
            let label = context.dataset.label || '';
            if (label) {
              label += ': ';
            }
            if (context.parsed.y !== null) {
              label += new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(context.parsed.y);
            }
            return label;
          }
        }
      }
    },
    scales: {
      y: {
        beginAtZero: true,
        ticks: {
          callback: function(value) {
             return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND', maximumSignificantDigits: 3 }).format(value);
          }
        }
      }
    }
  }
});
</script>
</body>
</html>