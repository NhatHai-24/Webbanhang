<?php
session_start();
$current_page = 'sanpham';

$conn = new mysqli("localhost", "root", "", "webbh");
if ($conn->connect_error) die("Kết nối thất bại: " . $conn->connect_error);

$sql = "SELECT 
            sp.id_san_pham, 
            sp.ten_san_pham, 
            sp.mo_ta, 
            sp.bao_hanh, 
            ha.url_hinh_anh,
            MIN(btsp.gia_ban) AS gia_ban
        FROM san_pham sp
        LEFT JOIN hinh_anh_san_pham ha ON sp.id_san_pham = ha.id_san_pham AND ha.la_anh_dai_dien = TRUE
        LEFT JOIN bien_the_san_pham btsp ON sp.id_san_pham = btsp.id_san_pham
        GROUP BY sp.id_san_pham
        ORDER BY sp.ten_san_pham";

$result = $conn->query($sql);
$groups = [];

while ($row = $result->fetch_assoc()) {
    $ten = $row['ten_san_pham'];
    if (stripos($ten, 'Túi') !== false) {
        $groups['Túi chống sốc'][] = $row;
    } elseif (stripos($ten, 'Balo') !== false) {
        $groups['Balo laptop'][] = $row;
    } elseif (stripos($ten, 'Quạt') !== false) {
        $groups['Quạt mini'][] = $row;
    } elseif (stripos($ten, 'Máy in') !== false) {
        $groups['Máy in'][] = $row;
    } elseif (stripos($ten, 'iPhone') !== false || stripos($ten, 'Samsung') !== false || stripos($ten, 'OPPO') !== false || stripos($ten, 'Xiaomi') !== false) {
        $groups['Điện thoại'][] = $row;
    } elseif (stripos($ten, 'Máy hủy') !== false) {
        $groups['Máy hủy tài liệu'][] = $row;
    } elseif (stripos($ten, 'PlayStation') !== false || stripos($ten, 'Nintendo') !== false || stripos($ten, 'Xbox') !== false) {
        $groups['Máy chơi game'][] = $row;
    } else {
        $groups['Các sản phẩm nổi bật'][] = $row;
    }
}
$conn->close();
?>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sản phẩm - TECHNOVA</title>
    <link rel="stylesheet" href="../index/index.css">
    <link rel="stylesheet" href="sanpham.css">
    <script src="../jquery-3.7.1.min.js"></script>
    <style>
        #filter-bar {
            margin: 20px 30px 0;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 15px;
        }
        #category-select {
            padding: 6px 12px;
            font-size: 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        .category-title {
            font-size: 20px;
            font-weight: bold;
            color: #004a80;
            margin: 40px 0 20px 10px;
        }

    </style>
</head>
<body>
    
<div id="fox">
    

    <div id="fox-nav">
    <ul>
        <li><a href="../index/index.php">Trang chủ</a></li>
        <li><a href="../SanPham/SanPham.php" class="<?= ($current_page == 'sanpham') ? 'active' : '' ?>">Sản phẩm</a></li>
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

    <div id="products">
        <h2>Sản phẩm</h2>
          <div id="filter-bar">
    <div class="filter-container">
        <div class="search-wrapper">
            <svg class="search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="11" cy="11" r="8"></circle>
                <path d="m21 21-4.35-4.35"></path>
            </svg>
            <input type="text" id="search-input" placeholder="Bạn muốn tìm sản phẩm gì?..." class="search-input">
        </div>

        <div class="filter-actions">
            <div class="category-wrapper">
                <label for="category-select">📂 Danh mục:</label>
                <select id="category-select" class="category-select">
                    <option value="all">Tất cả sản phẩm</option>
                    <?php foreach (array_keys($groups) as $cat): ?>
                        <option value="<?= htmlspecialchars($cat) ?>"><?= htmlspecialchars($cat) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>

            <button id="reset-btn" class="reset-btn">↺ Làm mới</button>
        </div>
    </div>

    <div id="search-result-info" class="search-result-info"></div>
</div>

        <!-- ========== DANH SÁCH SẢN PHẨM ========== -->
        <?php foreach ($groups as $category => $items): ?>
            <div class="category-group" data-category="<?= htmlspecialchars($category) ?>">
                <div class="category-title"><?= htmlspecialchars($category) ?></div>
                <div class="product-list">
                    <?php foreach ($items as $item): ?>
                      <div class="product-card" data-product-name="<?= htmlspecialchars($item['ten_san_pham']) ?>">
                            <a href="ChiTietSanPham.php?id_san_pham=<?= $item['id_san_pham'] ?>" class="product-link">
                                <div class="product-image">
                                    <?php if (!empty($item['url_hinh_anh'])): ?>
                                        <img src="<?= htmlspecialchars($item['url_hinh_anh']) ?>" alt="<?= htmlspecialchars($item['ten_san_pham']) ?>">
                                    <?php else: ?>
                                        <img src="https://placehold.co/250x150?text=No+Image" alt="Không có ảnh">
                                    <?php endif; ?>
                                </div>
                                <div class="product-info">
                                    <h3><?= htmlspecialchars($item['ten_san_pham']) ?></h3>
                                    <p class="desc"><?= htmlspecialchars($item['mo_ta']) ?></p>
                                    <p class="price">Giá từ: <strong><?= number_format($item['gia_ban'], 0, ',', '.') ?>₫</strong></p>
                                    <p class="warranty">Bảo hành: <?= htmlspecialchars($item['bao_hanh']) ?></p>
                                </div>
                            </a>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>
        <?php endforeach; ?>
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

<style>
    /* --- FILTER BAR CONTAINER --- */
    #filter-bar {
        background: rgba(26, 35, 50, 0.95); /* Màu nền tối trong suốt nhẹ */
        backdrop-filter: blur(10px); /* Hiệu ứng mờ đục hiện đại */
        padding: 20px;
        margin: 20px auto 40px; /* Căn giữa bar và tạo khoảng cách */
        width: 90%; /* Chiều rộng 90% màn hình */
        max-width: 1200px; /* Không quá rộng trên màn hình to */
        border-radius: 12px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3); /* Đổ bóng sâu hơn */
        border: 1px solid rgba(53, 253, 236, 0.2); /* Viền neon nhẹ */
    }

    /* Bố cục Flexbox thay vì Grid để linh hoạt hơn */
    .filter-container {
        display: flex;
        justify-content: space-between; /* Đẩy 2 bên ra xa nhau */
        align-items: center;
        gap: 20px;
        flex-wrap: wrap; /* Tự xuống dòng trên mobile */
    }

    /* --- SEARCH INPUT (BÊN TRÁI) --- */
    .search-wrapper {
        position: relative;
        flex: 1; /* Chiếm hết khoảng trống còn lại */
        min-width: 300px; /* Chiều rộng tối thiểu */
    }

    .search-icon {
        position: absolute;
        left: 15px;
        top: 50%;
        transform: translateY(-50%);
        width: 20px;
        height: 20px;
        color: #35fdec; /* Màu icon neon */
        pointer-events: none;
        z-index: 2;
    }

    .search-input {
        width: 100%;
        padding: 12px 15px 12px 45px; /* Padding trái lớn để né icon */
        border: 2px solid #233547;
        border-radius: 50px; /* Bo tròn hoàn toàn */
        background: #0f1724;
        color: #fff;
        font-size: 15px;
        transition: all 0.3s ease;
        box-sizing: border-box; /* Quan trọng để không vỡ khung */
    }

    .search-input::placeholder {
        color: #6c7a89;
    }

    .search-input:focus {
        outline: none;
        border-color: #35fdec; /* Viền sáng khi click vào */
        box-shadow: 0 0 15px rgba(53, 253, 236, 0.15);
        background: #151f30;
    }

    /* --- GROUP BÊN PHẢI (DANH MỤC + NÚT) --- */
    .filter-actions {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    /* Danh mục */
    .category-wrapper {
        display: flex;
        align-items: center;
        background: #0f1724;
        padding: 5px 15px 5px 10px;
        border-radius: 50px;
        border: 1px solid #233547;
    }

    .category-wrapper label {
        color: #aaa;
        font-size: 13px;
        margin-right: 8px;
        white-space: nowrap;
    }

    .category-select {
        background: transparent;
        color: #35fdec;
        border: none;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        outline: none;
        padding: 5px;
    }

    .category-select option {
        background: #1a2332;
        color: #fff;
    }

    /* Nút Reset */
    .reset-btn {
        padding: 10px 20px;
        background: linear-gradient(135deg, #35fdec 0%, #29b6a6 100%);
        color: #000;
        border: none;
        border-radius: 50px;
        font-weight: bold;
        cursor: pointer;
        transition: transform 0.2s, box-shadow 0.2s;
        white-space: nowrap;
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .reset-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(53, 253, 236, 0.4);
    }

    /* Kết quả tìm kiếm text */
    .search-result-info {
        margin-top: 10px;
        margin-left: 10px;
        font-size: 14px;
        color: #35fdec;
        font-style: italic;
    }

    /* --- RESPONSIVE MOBILE --- */
    @media (max-width: 768px) {
        .filter-container {
            flex-direction: column;
            align-items: stretch; /* Kéo giãn full chiều ngang */
            gap: 15px;
        }

        .filter-actions {
            justify-content: space-between;
        }

        .category-wrapper {
            flex: 1;
        }
    }
</style>



<script>

    // JS Dropdown
document.getElementById('user-toggle').addEventListener('click', function(e) {
    e.preventDefault();
    var d = this.nextElementSibling; d.style.display = (d.style.display === 'block') ? 'none' : 'block';
});

    $(document).ready(function () {
        const $groups = $('.category-group');
        const $products = $('.product-card');
        const $searchInput = $('#search-input');
        const $categorySelect = $('#category-select');
        const $resetBtn = $('#reset-btn');
        const $searchResultInfo = $('#search-result-info');

        // Hiển thị tất cả sản phẩm lúc đầu
        $groups.show();
        $('.product-card').each(function (j) {
            $(this).delay(j * 50).queue(function (next) {
                $(this).addClass('show');
                next();
            });
        });

        // normalize: lowercase + remove diacritics
        function normalizeText(str) {
            if (!str) return '';
            try {
                return str.toString()
                        .toLowerCase()
                        .normalize('NFD')
                        .replace(/[\u0300-\u036f]/g, '')   // remove diacritics
                        .replace(/[^\w\s\-]/g, '')         // remove special chars
                        .trim();
            } catch (e) {
                return str.toString().toLowerCase().trim();
            }
        }

        function performSearch() {
            let rawSearch = $searchInput.val() || '';
            let searchTerm = normalizeText(rawSearch);
            let selectedCategory = $categorySelect.val();
            let visibleProducts = 0;

            $groups.each(function () {
                let $group = $(this);
                let categoryName = $group.data('category');
                let categoryMatches = selectedCategory === 'all' || categoryName === selectedCategory;
                let hasVisibleProducts = false;

                $group.find('.product-card').each(function () {
                    let $card = $(this);
                    // Lấy tên sản phẩm trực tiếp từ thẻ h3 (an toàn hơn attribute)
                    let rawName = $card.find('h3').text() || $card.attr('data-product-name') || '';
                    let productName = normalizeText(rawName);

                    let searchMatches = (searchTerm === '') || productName.indexOf(searchTerm) !== -1;
                    let shouldShow = searchMatches && categoryMatches;

                    if (shouldShow) {
                        // dùng jQuery show/fade để đảm bảo display được bật
                        $card.stop(true, true).removeClass('hidden').addClass('show').fadeIn(150);
                        hasVisibleProducts = true;
                        visibleProducts++;
                    } else {
                        $card.stop(true, true).removeClass('show').addClass('hidden').fadeOut(80);
                    }
                });

                if (hasVisibleProducts) {
                    $group.show();
                } else {
                    $group.hide();
                }
            });

            if (searchTerm || selectedCategory !== 'all') {
                if (visibleProducts === 0) {
                    $searchResultInfo.text('❌ Không tìm thấy sản phẩm phù hợp');
                } else {
                    $searchResultInfo.text('✓ Tìm thấy ' + visibleProducts + ' sản phẩm');
                }
            } else {
                $searchResultInfo.text('');
            }
        }

        $searchInput.on('keyup', function () { performSearch(); });
        $categorySelect.on('change', function () { performSearch(); });
        $resetBtn.on('click', function (e) {
            e.preventDefault();
            $searchInput.val('');
            $categorySelect.val('all');
            $searchResultInfo.text('');
            $groups.show();
            $products.stop(true,true).removeClass('hidden').addClass('show').fadeIn(120);
        });
    });
</script>


    
</body>
</html>
