<?php
session_start();
?>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Về TECHNOVA</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="Gioithieu.css">
</head>
<body>

    <canvas id="tech-canvas"></canvas>
    
    <div class="cursor-dot" id="cursor-dot"></div>
    <div class="cursor-outline" id="cursor-outline"></div>

    <div id="fox-nav">
    <ul>
        <li><a href="../index/index.php">Trang chủ</a></li>
        <li><a href="../SanPham/SanPham.php">Sản phẩm</a></li>
        <li><a href="../Gioithieu/Gioithieu.php">Giới thiệu</a></li>
        <li><a href="../chinhsachbaomat/chinhsachbaomat.php">Chính sách bảo mật</a></li>
        <li><a href="../LienHe/Lienhe.php">Liên hệ</a></li>

        <?php if (!isset($_SESSION["user"])): ?>
            <!-- Chưa đăng nhập -->
            <li><a href="../Login/Login.php">Đăng nhập</a></li>
        <?php else: ?>
            <!-- Đã đăng nhập -->
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

    <header class="hero-section">
        <div class="hero-content fade-up">
            <span class="badge">2025</span>
            <h1>Kiến tạo <br><span class="text-gradient">Tương Lai Số</span></h1>
            <p>Chúng tôi không chỉ bán sản phẩm công nghệ. Chúng tôi cung cấp chìa khóa để mở ra cánh cửa tương lai của bạn.</p>
            <div class="hero-stats">
                <div class="stat-item">
                    <h3 class="counter" data-target="50000">0</h3>
                    <p>Khách hàng</p>
                </div>
                <div class="stat-item">
                    <h3 class="counter" data-target="5000">0</h3>
                    <p>Sản phẩm</p>
                </div>
                <div class="stat-item">
                    <h3 class="counter" data-target="99"></h3><span>%</span>
                    <p>Hài lòng</p>
                </div>
            </div>
        </div>
        <div class="scroll-indicator">
            <span>Khám phá</span>
            <div class="mouse">
                <div class="wheel"></div>
            </div>
        </div>
    </header>

    <main class="main-content">
        <section class="section story-section">
            <div class="section-header fade-up">
                <h2>Câu chuyện TECHNOVA</h2>
                <div class="line"></div>
            </div>
            <div class="story-grid">
                <div class="story-card glass-card fade-right">
                    <div class="icon">🚀</div>
                    <h3>Sứ Mệnh</h3>
                    <h4>trả lời cho câu hỏi: TechNova sinh ra để làm gì mỗi ngày?<h44>
                    <p>"Trao quyền cho con người thông qua công nghệ, bằng cách cung cấp những sản phẩm đổi mới nhất với tốc độ nhanh nhất và sự an tâm tuyệt đối."</p>
                </div>
                <div class="story-card glass-card fade-left">
                    <div class="icon">👁️</div>
                    <h3>Tầm Nhìn</h3>
                    <p>"Trở thành Hệ sinh thái Thương mại Công nghệ hàng đầu khu vực, nơi định hình phong cách sống số và xóa nhòa mọi rào cản trong trải nghiệm mua sắm thông minh."</p>
                </div>
            </div>
        </section>

        <section class="section history-section">
            <h2 class="section-title fade-up">Hành Trình Phát Triển</h2>
            <div class="timeline">
                <div class="timeline-line"></div>
                
                <div class="timeline-item fade-up">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content glass-card">
                        <span class="year">2025</span>
                        <h3>CÚ HÍCH "ZERO-TOUCH" </h3>
                        <p>Thị trường TMĐT 2025 bão hòa, người dùng chán ngấy việc chờ đợi ship hàng và lo sợ hàng giả.</p> 
                        <P> Chiến lược chủ đạo: Tốc độ là vũ khí - Minh bạch là khiên chắn.</p>
                    </div>
                </div>
                <div class="timeline-item fade-up">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content glass-card">
                        <span class="year">2026</span>
                        <h3>KỶ NGUYÊN "TRUST-CHAIN"</h3>
                        <p>Hàng dựng tràn lan. Niềm tin vào đồ điện tử online bị lung lay. Chiến lược chủ đạo: Số hóa niềm tin.</p>
                    </div>
                </div>
                <div class="timeline-item fade-up">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content glass-card">
                        <span class="year">2027</span>
                        <h3>CUỘC CÁCH MẠNG AI "NOVABRAIN"</h3>
                        <p>Khách hàng bị ngợp bởi quá nhiều lựa chọn. Chiến lược chủ đạo: Đừng để khách hàng tìm, hãy đưa đồ đến trước mặt họ.</p>
                        <p>Sự kiện: Ra mắt trợ lý ảo "Nova AI".</p>
                    </div>
                </div>
                <div class="timeline-item fade-up">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content glass-card">
                        <span class="year">2028</span>
                        <h3>HỆ SINH THÁI PHYGITAL</h3>
                        <p>Online đã mạnh, nhưng khách hàng muốn "sờ" sản phẩm cao cấp (High-end Audio, Setup 100 triệu). Chiến lược chủ đạo: Trải nghiệm không điểm chạm.Sự kiện: Khai trương TechNova Hub tại phố đi bộ Nguyễn Huệ (TP.HCM).</p>
                    </div>
                </div>
                <div class="timeline-item fade-up">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content glass-card">
                        <span class="year">2029</span>
                        <h3>ĐẾ CHẾ IOT</h3>
                        <p>2029: Kho hàng Dark Warehouse (Kho tối).
                        <p>Hệ thống kho vận của TechNova vận hành 100% bằng Robot tự hành (AGV).</p>
                        <p>Con người chỉ đứng giám sát qua màn hình. Tốc độ xử lý đơn hàng tăng 300%, chi phí nhân sự giảm 70%.</p>
                    </div>
                </div>
                <div class="timeline-item fade-up">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content glass-card">
                        <span class="year">2030</span>
                        <h3>The "Smart Living" Subscription</h3>
                        <p>TechNova không chỉ bán sản phẩm nữa. Chúng ta bán gói "NovaLife".</p>
                        <p>Mô hình: Với 2 triệu/tháng, khách hàng được TechNova setup toàn bộ Smarthome, Internet vạn vật trong nhà. Hỏng hóc? Hệ thống tự báo về trung tâm, kỹ thuật viên đến sửa trước khi chủ nhà kịp biết là nó hỏng.</p>
                        <p>Tầm nhìn hoàn tất: TechNova trở thành "Hệ điều hành" cho ngôi nhà của khách hàng, không chỉ là nơi bán cái tivi hay tủ lạnh.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="section financial-section">
    <div class="section-header fade-up">
        <h2 class="section-title fade-up">Lộ Trình Tài Chính (Dự Kiến)</h2>
        <p style="color: var(--text-secondary); max-width: 600px; margin: 0 auto;">
            Chiến lược tăng trưởng J-Curve: Từ đầu tư công nghệ lõi đến IPO toàn cầu.
        </p>
    </div>

    <div class="fin-grid">
        <div class="fin-card glass-card fade-up" style="transition-delay: 0s">
            <div class="fin-header">
                <span class="fin-year">2025</span>
                <div class="fin-icon">📉</div> </div>
            <div class="fin-body">
                <div class="revenue-box">
                    <span class="currency">$</span>
                    <span class="counter" data-target="2">0</span>
                    <span class="unit">M</span>
                </div>
                <h4>Xây Dựng Nền Tảng</h4>
                <p>Tập trung R&D công nghệ lõi. Chấp nhận lỗ ngắn hạn để chiếm lĩnh thị phần.</p>
                <span class="status-badge warning">Đầu tư</span>
            </div>
        </div>

        <div class="fin-card glass-card fade-up" style="transition-delay: 0.2s">
            <div class="fin-header">
                <span class="fin-year">2027</span>
                <div class="fin-icon">⚖️</div>
            </div>
            <div class="fin-body">
                <div class="revenue-box">
                    <span class="currency">$</span>
                    <span class="counter" data-target="15">0</span>
                    <span class="unit">M</span>
                </div>
                <h4>Điểm Hòa Vốn</h4>
                <p>Tối ưu hóa vận hành. Đạt điểm Break-even và bắt đầu sinh lời bền vững.</p>
                <span class="status-badge success">Hòa vốn</span>
            </div>
        </div>

        <div class="fin-card glass-card fade-up" style="transition-delay: 0.4s">
            <div class="fin-header">
                <span class="fin-year">2028</span>
                <div class="fin-icon">🦄</div>
            </div>
            <div class="fin-body">
                <div class="revenue-box">
                    <span class="currency">$</span>
                    <span class="counter" data-target="50">0</span>
                    <span class="unit">M</span>
                </div>
                <h4>Series B - Silicon Valley</h4>
                <p>Định giá 200 triệu USD. Mở rộng quy mô sang thị trường Đông Nam Á.</p>
                <span class="status-badge info">Series B</span>
            </div>
        </div>

        <div class="fin-card glass-card fade-up special-card" style="transition-delay: 0.6s">
            <div class="fin-glow"></div> <div class="fin-header">
                <span class="fin-year">2030</span>
                <div class="fin-icon">🔔</div>
            </div>
            <div class="fin-body">
                <div class="revenue-box">
                    <span class="currency">$</span>
                    <span class="counter" data-target="150">0</span>
                    <span class="unit">M</span>
                </div>
                <h4>IPO - Go Public</h4>
                <p>Niêm yết tại HOSE hoặc Singapore. Khẳng định vị thế Tech Unicorn.</p>
                <span class="status-badge gold">IPO</span>
            </div>
        </div>
    </div>
</section>

        <section class="section team-section">
            <h2 class="section-title fade-up">Những Người Dẫn Đầu</h2>
            <div class="team-grid">
                <div class="team-card glass-card fade-up">
                    <div class="member-img">NH</div>
                    <div class="member-info">
                        <h3>LÊ NHẬT HẢI</h3>
                        <span class="position">Founder & CEO</span>
                        <p>Stanford MBA. 15 năm kinh nghiệm Tech Lead.</p>
                    </div>
                </div>
                <div class="team-card glass-card fade-up" style="transition-delay: 0.1s">
                    <div class="member-img">VT</div>
                    <div class="member-info">
                        <h3>NGUYỄN VÂN THIÊN</h3>
                        <span class="position">CTO</span>
                        <p>Thạc sĩ Khoa học máy tính. Kiến trúc sư hệ thống.</p>
                    </div>
                </div>
                <div class="team-card glass-card fade-up" style="transition-delay: 0.2s">
                    <div class="member-img">VT</div>
                    <div class="member-info">
                        <h3>NGUYỄN VĂN THI</h3>
                        <span class="position">CMO</span>
                        <p>Chuyên gia Growth Hacking & Digital Marketing.</p>
                    </div>
                </div>
                 <div class="team-card glass-card fade-up" style="transition-delay: 0.3s">
                    <div class="member-img">HN</div>
                    <div class="member-info">
                        <h3>Lê HOÀI NAM</h3>
                        <span class="position">Product Lead</span>
                        <p>Nghiên cứu xu hướng và trải nghiệm người dùng.</p>
                    </div>
                </div>
                
                 <div class="team-card glass-card fade-up" style="transition-delay: 0.3s">
                    <div class="member-img">TT</div>
                    <div class="member-info">
                        <h3>NGUYỄN TRUNG THIỆN</h3>
                        <span class="position">Product Lead</span>
                        <p>Nghiên cứu xu hướng và trải nghiệm người dùng.</p>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <footer id="fox-footer">
        <div class="footer-content">
            <div class="footer-brand">
                <h2>TECH<span>NOVA</span></h2>
                <p>© 2025 All rights reserved.</p>
            </div>
            <div class="footer-links">
                <a href="#">Facebook</a>
                <a href="#">LinkedIn</a>
                <a href="#">Instagram</a>
            </div>
        </div>
    </footer>

    <script src="Gioithieu.js"></script>
    <script>
        // JS Dropdown
    document.getElementById('user-toggle').addEventListener('click', function(e) {
        e.preventDefault();
        var d = this.nextElementSibling;
        d.style.display = (d.style.display === 'block') ? 'none' : 'block';
    });
    </script>
</body>
</html>