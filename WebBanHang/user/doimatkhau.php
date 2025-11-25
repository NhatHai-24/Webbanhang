<?php
// ...existing code...
session_start();
if (!isset($_SESSION["user"])) {
    header("Location: ../Login/Login.php");
    exit();
}


$conn = new mysqli("localhost", "root", "", "webbh");
if ($conn->connect_error) die("Kết nối thất bại: " . $conn->connect_error);

$username = $_SESSION["user"]["username"];
$message = "";

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
        // Lấy password hiện tại từ DB bằng prepared statement
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

            // Xác thực mật khẩu cũ:
            // - ưu tiên password_verify (nếu password đã hash bằng password_hash)
            // - fallback nếu DB vẫn lưu plain text (tạm thời)
            $oldMatches = false;
            if (password_verify($old, $currentHash)) {
                $oldMatches = true;
            } elseif ($currentHash === $old) {
                // fallback: DB lưu plain text => vẫn cho phép dùng, sau đó sẽ hash mật khẩu mới
                $oldMatches = true;
            }

            if (!$oldMatches) {
                $message = "❌ Mật khẩu cũ không chính xác.";
            } else {
                if ($old === $new) {
                    $message = "❌ Mật khẩu mới phải khác mật khẩu cũ.";
                } else {
                    // Lưu mật khẩu mới đã hash
                    $newHash = password_hash($new, PASSWORD_DEFAULT);

                    $updateStmt = $conn->prepare("UPDATE users SET password = ? WHERE username = ?");
                    $updateStmt->bind_param("ss", $newHash, $username);
                    if ($updateStmt->execute()) {
                        $message = "<span style='color:green;'>Đổi mật khẩu thành công!</span>";
                        // bạn có thể redirect ngay hoặc chờ 2s
                        header("refresh:2;url=../index/index.php");
                    } else {
                        $message = "❌ Cập nhật mật khẩu thất bại: " . htmlspecialchars($conn->error);
                    }
                    $updateStmt->close();
                }
            }
        }
    }
}
?>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đổi mật khẩu</title>
  <link rel="stylesheet" href="../index/index.css">
  <style>
    .password-change-container {
      max-width: 600px;
      margin: 50px auto;
      padding: 30px;
      background: white;
      border-radius: 10px;
      box-shadow: 0 8px 28px rgba(0,0,0,0.08);
    }
    .password-change-container h2 {
      text-align: center;
      color: #004a80;
      margin-bottom: 20px;
    }
    .password-change-container form label {
      display: block;
      margin-top: 15px;
      font-weight: bold;
      color: #333;
    }
    .password-change-container form input {
      width: 100%;
      padding: 10px;
      margin-top: 6px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 15px;
    }
    .password-change-container .btn-submit {
      margin-top: 25px;
      padding: 10px 25px;
      background-color: #007acc;
      color: white;
      border: none;
      border-radius: 6px;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    .password-change-container .btn-submit:hover {
      background-color: #005fa3;
    }
    .message {
      text-align: center;
      margin-top: 15px;
      font-size: 14px;
      color: red;
    }
  </style>
</head>
<body>
<div id="fox">
 

  <div id="fox-nav">
    <ul>
      <li><a href="../index/index.php">Trang chủ</a></li>
      <li><a href="../SanPham/SanPham.php">Sản phẩm</a></li>
      <li><a href="../User/ThongTinCaNhan.php">Thông tin cá nhân</a></li>
      <li><a href="../DonHang/Giohang.php">Giỏ hàng của tôi</a></li>
      <li><a href="../Login/logout.php">Đăng xuất</a></li>
    </ul>
  </div>

  <div class="password-change-container">
    <h2>🔐 Đổi mật khẩu</h2>
    <?php if ($message): ?>
      <div class="message"><?= $message ?></div>
    <?php endif; ?>

    <form method="POST">
      <label for="old_password">Mật khẩu cũ:</label>
      <input type="password" name="old_password" required>

      <label for="new_password">Mật khẩu mới:</label>
      <input type="password" name="new_password" required>

      <label for="confirm_password">Nhập lại mật khẩu mới:</label>
      <input type="password" name="confirm_password" required>

      <button type="submit" name="change" class="btn-submit">Cập nhật</button>
    </form>
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
</div>
</body>
</html>
