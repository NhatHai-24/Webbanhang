<?php

session_start();
$current_page = basename($_SERVER['PHP_SELF']);
require_once __DIR__ . '/../auth.php';
require_admin();

// 1. Kiểm tra quyền Admin
// Nếu không phải admin thì đá về trang login
if (!isset($_SESSION["user"]) || stripos($_SESSION["user"]["username"], "admin") === false) {
    header("Location: ../Login/Login.php");
    exit();
}

$message = "";
$conn = new mysqli("localhost", "root", "", "webbh");
if ($conn->connect_error) die("Kết nối thất bại: " . $conn->connect_error);

$username = $_SESSION["user"]["username"];

// 2. Xử lý khi nhấn nút "Cập nhật" (Logic dựa trên doimatkhau.php)
if (isset($_POST["change"])) {
    $old = trim($_POST["old_password"] ?? "");
    $new = trim($_POST["new_password"] ?? "");
    $confirm = trim($_POST["confirm_password"] ?? "");

    if ($old === "" || $new === "" || $confirm === "") {
        $message = "❌ Vui lòng điền đầy đủ thông tin.";
    } elseif ($new !== $confirm) {
        $message = "❌ Mật khẩu mới không khớp.";
    } elseif (strlen($new) < 6) {
        $message = "❌ Mật khẩu mới phải có ít nhất 6 ký tự.";
    } else {
        // Lấy password hiện tại từ DB
        $stmt = $conn->prepare("SELECT password FROM users WHERE username = ?");
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $result = $stmt->get_result();
        $userRow = $result->fetch_assoc();
        $stmt->close();

        if (!$userRow) {
            $message = "❌ Tài khoản không tồn tại.";
        } else {
            $currentHash = $userRow["password"];
            $oldMatches = false;

            // Kiểm tra mật khẩu cũ (Hỗ trợ cả Hash và Plain text như file gốc)
            if (password_verify($old, $currentHash)) {
                $oldMatches = true;
            } elseif ($currentHash === $old) {
                $oldMatches = true;
            }

            if (!$oldMatches) {
                $message = "❌ Mật khẩu cũ không chính xác.";
            } else {
                if ($old === $new) {
                    $message = "❌ Mật khẩu mới phải khác mật khẩu cũ.";
                } else {
                    // Mã hóa mật khẩu mới và cập nhật
                    $newHash = password_hash($new, PASSWORD_DEFAULT);
                    $updateStmt = $conn->prepare("UPDATE users SET password = ? WHERE username = ?");
                    $updateStmt->bind_param("ss", $newHash, $username);
                    
                    if ($updateStmt->execute()) {
                        $message = "<span style='color:#35fdec;'>✅ Đổi mật khẩu thành công!</span>";
                    } else {
                        $message = "❌ Cập nhật thất bại: " . htmlspecialchars($conn->error);
                    }
                    $updateStmt->close();
                }
            }
        }
    }
}
$conn->close();
?>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Đổi Mật Khẩu Admin</title>
  <link rel="stylesheet" href="admin.css?v=2">
  <style>
      /* Style riêng cho form đổi mật khẩu Admin */
      .password-container {
          max-width: 500px;
          margin: 40px auto;
          background: #1e293b; /* Nền tối đồng bộ admin */
          padding: 40px;
          border-radius: 12px;
          box-shadow: 0 4px 20px rgba(0,0,0,0.5);
          border: 1px solid #334155;
          color: white;
      }
      .form-group { margin-bottom: 20px; }
      .form-group label { 
          display: block; 
          margin-bottom: 8px; 
          color: #38bdf8; /* Màu xanh neon */
          font-weight: bold; 
      }
      .form-group input { 
          width: 100%; 
          padding: 12px; 
          background: #0f172a; 
          border: 1px solid #334155; 
          color: white; 
          border-radius: 6px; 
          box-sizing: border-box;
      }
      .form-group input:focus { 
          border-color: #38bdf8; 
          outline: none; 
          box-shadow: 0 0 8px rgba(56, 189, 248, 0.3);
      }
      .btn-submit {
          width: 100%; 
          padding: 12px;
          background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
          color: white; 
          border: none; 
          border-radius: 6px;
          font-weight: bold; 
          cursor: pointer; 
          font-size: 16px;
          transition: 0.3s;
          margin-top: 10px;
      }
      .btn-submit:hover { 
          transform: translateY(-2px); 
          box-shadow: 0 4px 12px rgba(56, 189, 248, 0.4); 
      }
      .alert { 
          padding: 12px; 
          margin-bottom: 20px; 
          border-radius: 6px; 
          text-align: center; 
          font-weight: 500;
          color: #f87171; /* Màu đỏ lỗi mặc định */
          background: rgba(239, 68, 68, 0.1);
          border: 1px solid #ef4444;
      }
  </style>
</head>
<body>
  <div id="fox">
  
    <!-- Navigation (Giữ nguyên menu admin) -->
    <div id="fox-nav">
      <ul>
        <li><a href="admin.php">Trang chủ</a></li>
        <li><a href="quanlysanpham.php">Chi tiết các mục</a></li>
        
        <?php if (isset($_SESSION["user"])): ?>
            <?php $username = htmlspecialchars($_SESSION["user"]["username"]); ?>
            <li class="user-dropdown">
                <a href="#" id="user-toggle"><?= $username ?> ⮟</a>
                <ul class="dropdown-menu" style="display: none;">  
                  <li><a href="DoiMatKhauAdmin.php" class="active"> Đổi mật khẩu</a></li>
                  <li><a href="../Login/logout.php"> Đăng xuất</a></li>
                </ul>
            </li>
        <?php endif; ?>
      </ul>
    </div>

    <!-- Main Content -->
    <div class="admin-container">
      <h2 style="text-align: center; margin-top: 20px; color: #35fdec;">🔐 Đổi Mật Khẩu Quản Trị</h2>
      <a href="admin.php" style="display: block; text-align: center; color: #94a3b8; text-decoration: none; margin-bottom: 20px;">← Quay lại Bảng điều khiển</a>
      
      <div class="password-container">
          <?php if ($message): ?>
              <!-- Hiển thị thông báo, nếu có thẻ span bên trong thì là thành công -->
              <div class="alert" style="<?= strpos($message, 'thành công') !== false ? 'border-color: #35fdec; background: rgba(53, 253, 236, 0.1); color: #35fdec;' : '' ?>">
                  <?= $message ?>
              </div>
          <?php endif; ?>

          <form method="POST">
              <div class="form-group">
                  <label for="old_password">Mật khẩu cũ</label>
                  <input type="password" name="old_password" id="old_password" required placeholder="Nhập mật khẩu hiện tại...">
              </div>

              <div class="form-group">
                  <label for="new_password">Mật khẩu mới</label>
                  <input type="password" name="new_password" id="new_password" required placeholder="Nhập mật khẩu mới (min 6 ký tự)...">
              </div>

              <div class="form-group">
                  <label for="confirm_password">Nhập lại mật khẩu mới</label>
                  <input type="password" name="confirm_password" id="confirm_password" required placeholder="Xác nhận mật khẩu mới...">
              </div>

              <button type="submit" name="change" class="btn-submit">Lưu Thay Đổi</button>
          </form>
      </div>
    </div>

    <!-- Footer -->
    <div id="fox-footer">
      <p>© 2025 TECHNOVA. All rights reserved.</p>
      <p>Địa chỉ: 123 Đường Nguyễn Trãi, TP.HCM | Hotline: 0123 456 789 | Email: support@technova.vn</p>
    </div>
  </div>

<script>
    // JS cho Dropdown menu user
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
</body>
</html>