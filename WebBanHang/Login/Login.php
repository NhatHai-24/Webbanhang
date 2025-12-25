<?php
$current_page = 'login';
session_start();
$loginError = "";

require_once __DIR__ . '/../auth.php'; // thêm if chưa có

if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST["username"], $_POST["password"])) {
    $conn = new mysqli("localhost", "root", "", "webbh");
    if ($conn->connect_error) die("Kết nối thất bại: " . $conn->connect_error);

    $username = $_POST["username"];
    $password = $_POST["password"];

    // Thay SELECT để trả cả role:
    $sql = "SELECT id, username, password, role FROM users WHERE username = ? LIMIT 1";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($user = $result->fetch_assoc()) {
        // Sau khi xác thực password thành công và $user chứa row từ DB
        if (password_verify($password, $user['password'])) {
            // tạo session id mới (bảo mật)
            session_regenerate_id(true);

            // chỉ lưu thông tin cần thiết
            $_SESSION['user'] = [
                'id' => (int)$user['id'],
                'username' => $user['username'],
                'role' => $user['role'] // 'admin' hoặc 'user'
            ];

            header('Location: ../index/index.php');
            exit();
        } else {
            $loginError = "❌ Sai mật khẩu.";
        }
    } else {
        $loginError = "❌ Tài khoản không tồn tại.";
    }
    
    $stmt->close();
    $conn->close();
}
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - TECHNOVA</title>
    <link rel="stylesheet" href="style_common.css">
    <link rel="stylesheet" href="register.css">
    <script src="Login.js" defer></script>
    <style>
        /* =========================================
   1. COPY BIẾN MÀU TỪ INDEX ĐỂ ĐỒNG BỘ
   ========================================= */
:root {
    --bg-dark: #0a0f1c;       /* Nền tối chủ đạo */
    --text-primary: #ffffff;  /* Chữ trắng */
    --text-secondary: #94a3b8;/* Chữ xám xanh */
    --accent: #38bdf8;        /* Màu nhấn (Neon Blue) */
    --accent-glow: rgba(56, 189, 248, 0.5);
    --glass-bg: rgba(255, 255, 255, 0.03);
    --glass-border: rgba(255, 255, 255, 0.1);
    --font-main: 'Inter', sans-serif;
}

/* =========================================
   2. CẤU TRÚC CHUNG (Reset nền trắng thành tối)
   ========================================= */
body {
    background-color: var(--bg-dark); /* Quan trọng: Chuyển nền thành màu tối */
    color: var(--text-primary);
    font-family: var(--font-main);
    margin: 0;
    padding: 0;
}

#fox {
    width: 100%;
    max-width: 100%;
    overflow-x: hidden;
}

/* =========================================
   3. HEADER & NAV (Giống hệt Index)
   ========================================= */
#fox-header {
    text-align: center;
    padding: 30px 0;
    background: radial-gradient(circle at center, #1e293b 0%, var(--bg-dark) 70%);
    border-bottom: 1px solid var(--glass-border);
}

#fox-header img {
    max-width: 150px;
    height: auto;
}

#fox-nav {
    background: rgba(15, 23, 42, 0.8);
    backdrop-filter: blur(12px);
    position: sticky;
    top: 0;
    z-index: 1000;
    border-bottom: 1px solid var(--glass-border);
}

#fox-nav ul {
    display: flex;
    justify-content: center;
    padding: 0;
    margin: 0;
    list-style: none;
    flex-wrap: wrap;
}

#fox-nav ul li a {
    display: block;
    padding: 15px 25px;
    color: var(--text-secondary);
    text-decoration: none;
    font-weight: 600;
    transition: 0.3s;
    border-bottom: 2px solid transparent;
}

#fox-nav ul li a:hover {
    color: var(--accent);
    text-shadow: 0 0 10px var(--accent-glow);
}

#fox-nav ul li a.active {
    color: #38bdf8 !important ; 
    font-weight: 800 !important;
}

/* =========================================
   4. FORM LOGIN (Chuyển từ xám sang kính trong suốt)
   ========================================= */
.auth-container {
    max-width: 1200px;
    margin: 80px auto; /* Tăng khoảng cách cho thoáng */
    padding: 0 20px;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 60px;
    align-items: center;
}

/* Phần text chào mừng bên trái */
.auth-welcome h1 {
    font-size: 3rem;
    color: var(--text-primary);
    margin-bottom: 20px;
}

.auth-welcome .gradient-text {
    color: var(--accent);
    text-shadow: 0 0 20px var(--accent-glow);
}

.auth-welcome p {
    color: var(--text-secondary);
    font-size: 1.1rem;
    line-height: 1.6;
}

.auth-features li {
    color: var(--text-secondary);
    padding: 10px 0;
    display: flex; align-items: center; gap: 10px;
}
.auth-features li::before {
    content: "✓"; color: var(--accent); font-weight: bold;
}

/* Khung Form Login (Quan trọng nhất) */
.auth-form {
    background: var(--glass-bg); /* Thay màu xám bằng màu kính trong suốt */
    backdrop-filter: blur(16px); /* Làm mờ hậu cảnh */
    border: 1px solid var(--glass-border); /* Viền mỏng tinh tế */
    padding: 40px;
    border-radius: 20px;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5); /* Đổ bóng đen thay vì xám */
}

.auth-form h2 {
    color: var(--text-primary);
    text-align: center;
    margin-bottom: 30px;
    font-size: 2rem;
}

/* Input (Ô nhập liệu) */
.form-group label {
    color: var(--accent);
    font-size: 0.9rem;
    margin-bottom: 8px;
    display: block;
}

.form-group input {
    width: 100%;
    padding: 12px 15px;
    background: rgba(15, 23, 42, 0.6); /* Nền input tối màu */
    border: 1px solid var(--glass-border);
    border-radius: 8px;
    color: var(--text-primary); /* Chữ khi nhập màu trắng */
    font-size: 1rem;
    transition: 0.3s;
}

.form-group input:focus {
    outline: none;
    border-color: var(--accent);
    box-shadow: 0 0 15px var(--accent-glow);
    background: rgba(15, 23, 42, 0.9);
}

.form-group input::placeholder {
    color: rgba(148, 163, 184, 0.4); /* Placeholder mờ đi */
}

/* Nút bấm */
.submit-btn {
    width: 100%;
    padding: 12px;
    background: var(--accent);
    color: #0a0f1c; /* Chữ màu đen trên nền xanh neon */
    font-weight: bold;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 1rem;
    box-shadow: 0 0 20px var(--accent-glow);
    transition: 0.3s;
    margin-top: 15px;
}

.submit-btn:hover {
    background: #ffffff;
    transform: translateY(-2px);
}

.register-link {
    background: transparent;
    border: 1px solid var(--glass-border);
    color: var(--text-secondary);
    width: 100%;
    padding: 12px;
    border-radius: 8px;
    cursor: pointer;
    transition: 0.3s;
}

.register-link:hover {
    border-color: var(--accent);
    color: var(--accent);
}

.form-divider {
    color: var(--text-secondary);
    text-align: center;
    margin: 20px 0;
}

.login-tips {
    background: rgba(56, 189, 248, 0.1);
    border-left: 3px solid var(--accent);
    color: var(--text-secondary);
    padding: 15px;
    margin-top: 20px;
    border-radius: 4px;
    font-size: 0.9rem;
}

/* =========================================
   5. FOOTER (Dùng lại code chuẩn đã sửa trước đó)
   ========================================= */
#fox-footer {
    background: #0f172a;
    border-top: 1px solid var(--glass-border);
    color: var(--text-secondary);
    padding: 40px 20px;
    margin-top: 100px;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
}

#fox-footer p { width: 100%; margin: 5px 0; }
#fox-footer a { color: var(--text-secondary); text-decoration: none; margin: 0 10px; transition: 0.3s; }
#fox-footer a:hover { color: var(--accent); }

/* Responsive Mobile */
@media (max-width: 768px) {
    .auth-container { grid-template-columns: 1fr; }
    #fox-nav ul { flex-direction: column; }
}
    </style>
</head>
<body>
<div id="fox">
      
    <!-- Navigation -->
    <div id="fox-nav">
        <ul>
            <li><a href="../index/index.php">Trang chủ</a></li>
            <li><a href="../SanPham/SanPham.php">Sản phẩm</a></li>
            <li><a href="../Gioithieu/Gioithieu.php">Giới thiệu</a></li>
            <li><a href="../chinhsachbaomat/chinhsachbaomat.php">Chính sách bảo mật</a></li>
            <li><a href="../LienHe/Lienhe.php">Liên hệ</a></li>
            <li><a href="../Login/Login.php" class="<?= (isset($current_page) && $current_page == 'login') ? 'active' : '' ?>">Đăng nhập</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="auth-container">
        <!-- Welcome Section -->
        <div class="auth-welcome">
            <h1>Chào mừng đến với <span class="gradient-text">TECHNOVA</span></h1>
            <p>Khám phá thế giới công nghệ hiện đại. Đăng nhập để truy cập tài khoản cá nhân, quản lý đơn hàng và tận hưởng những ưu đãi đặc biệt.</p>
            
            <ul class="auth-features">
                <li>Quản lý đơn hàng dễ dàng</li>
                <li>Thông tin cá nhân an toàn</li>
                <li>Lịch sử mua hàng chi tiết</li>
                <li>Nhận thông báo khuyến mãi</li>
            </ul>
        </div>

        <!-- Form Section -->
        <div class="auth-form-wrapper">
            <!-- Login Form -->
            <form class="auth-form" method="POST" action="">
                <h2>Đăng Nhập</h2>
                
                <?php if ($loginError): ?>
                    <div class="error-message"><?= $loginError ?></div>
                <?php endif; ?>

                <div class="form-group">
                    <label for="username">👤 Tên đăng nhập</label>
                    <input 
                        type="text" 
                        id="username" 
                        name="username" 
                        placeholder="Nhập tên đăng nhập" 
                        required 
                        autocomplete="username"
                    />
                </div>

                <div class="form-group">
                    <label for="password">🔐 Mật khẩu</label>
                    <input 
                        type="password" 
                        id="password" 
                        name="password" 
                        placeholder="Nhập mật khẩu" 
                        required 
                        autocomplete="current-password"
                    />
                </div>

                <button type="submit" class="submit-btn">Đăng Nhập</button>

                <div class="form-divider">— hoặc —</div>

                <button type="button" class="register-link" id="registerLink">
                    📝 Tạo tài khoản mới
                </button>


                
            </form>

            <!-- Register Modal -->
            <div id="registerModal" class="modal">
                <div class="modal-content">
                    <span class="close" id="registerClose">&times;</span>
                    <h2>Đăng Ký Tài Khoản</h2>
                    <form method="POST" action="register.php">
                        <div class="form-group">
                            <label for="registerUsername">Tên đăng nhập</label>
                            <input type="text" id="registerUsername" name="username" placeholder="Tối thiểu 5 ký tự" required />
                        </div>
                        <div class="form-group">
                            <label for="registerPassword">Mật khẩu</label>
                            <input type="password" id="registerPassword" name="password" placeholder="Tối thiểu 6 ký tự" required />
                            <small style="color: var(--accent); font-size: 0.85rem; margin-top: 5px; display: block; font-style: italic;">
                                * Lưu ý: Tạo mật khẩu với ít nhất 6 ký tự
                            </small>
                                                  
                        </div>
                        <div class="form-group">
                            <label for="registerConfirm">Xác nhận mật khẩu</label>
                            <input type="password" name="confirm_password" placeholder="Nhập lại mật khẩu" required />
                        </div>
                        <div class="form-group">
                            <label for="registerEmail">Email</label>
                            <input type="email" id="registerEmail" name="email" placeholder="example@mail.com" required />
                        </div>
                        <div class="form-group">
                            <label for="registerPhone">Số điện thoại</label>
                            <input type="text" id="registerPhone" name="phone" placeholder="0xx xxx xxxx" required />
                        </div>
                        <div class="form-group">
                            <label for="registerAddress">Địa chỉ</label>
                            <input type="text" id="registerAddress" name="address" placeholder="Nhập địa chỉ của bạn" required />
                        </div>
                        <button type="submit" class="submit-btn" id="registerSubmit">Tạo Tài Khoản</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div id="fox-footer">
        <p><strong>© 2025 TECHNOVA. All rights reserved.</strong></p>
        <p>Địa chỉ: 123 Đường Nguyễn Trãi, TP.HCM | Hotline: 0123 456 789 | Email: support@technova.vn</p>
        <p>
            <a href="../index/index.php">Trang chủ</a> | 
            <a href="../SanPham/SanPham.php">Sản phẩm</a> | 
            <a href="../Gioithieu/Gioithieu.php">Giới thiệu</a> | 
            <a href="../chinhsachbaomat/chinhsachbaomat.php">Chính sách bảo mật</a> |
            <a href="../LienHe/Lienhe.php">Liên hệ</a>
        </p>
       
    </div>
</div>

<script src="Login.js" defer></script>
</body>
</html>