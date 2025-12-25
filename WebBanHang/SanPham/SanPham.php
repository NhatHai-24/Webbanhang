<?php
require_once __DIR__ . '/../auth.php';

ini_set('memory_limit', '-1'); 

$current_page = 'sanpham';

$conn = new mysqli("localhost", "root", "", "webbh");
if ($conn->connect_error) die("Kết nối thất bại: " . $conn->connect_error);

// 1. CÂU TRUY VẤN SQL
$sql = "SELECT 
            sp.id_san_pham, 
            sp.ten_san_pham, 
            sp.loai_san_pham, 
            LEFT(sp.mo_ta, 150) AS mo_ta,
            sp.bao_hanh, 
            ha.url_hinh_anh,
            MIN(btsp.gia_ban) AS gia_ban
        FROM san_pham sp
        LEFT JOIN hinh_anh_san_pham ha ON sp.id_san_pham = ha.id_san_pham AND ha.la_anh_dai_dien = TRUE
        LEFT JOIN bien_the_san_pham btsp ON sp.id_san_pham = btsp.id_san_pham
        GROUP BY sp.id_san_pham
        ORDER BY sp.id_san_pham DESC"; 

$result = $conn->query($sql);
$groups = [];

// 2. GOM NHÓM DỮ LIỆU
while ($row = $result->fetch_assoc()) {
    $cat = !empty($row['loai_san_pham']) ? $row['loai_san_pham'] : 'Các sản phẩm nổi bật';
    $groups[$cat][] = $row;
}

// 3. SẮP XẾP NHÓM
$priority = [
    'Điện thoại' => 1,
    'Laptop' => 2,
    'Tivi' => 3,
    'Loa' => 4,
    'Tai nghe' => 5,
    'Máy chơi game' => 6,
    'Máy in' => 7,
    'Phụ kiện' => 8,
    'Linh kiện' => 9,
    'Màn hình' => 10,
    'Máy tính bảng' => 11,
    'Quạt' => 12,
    'Đồng hồ' => 13,
    'Các sản phẩm nổi bật' => 99 
];

uksort($groups, function($a, $b) use ($priority) {
    $posA = $priority[$a] ?? 100;
    $posB = $priority[$b] ?? 100;
    if ($posA == $posB) return strcmp($a, $b);
    return $posA - $posB;
});

// --- XỬ LÝ PHÂN TRANG (SERVER-SIDE) ---

// Cấu hình
$limit = 52; // 50 sản phẩm mỗi trang
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
if ($page < 1) $page = 1;
$start_from = ($page - 1) * $limit;

// Làm phẳng danh sách để cắt trang
$flat_list = [];
foreach ($groups as $cat => $items) {
    foreach ($items as $item) {
        $item['temp_category'] = $cat; 
        $flat_list[] = $item;
    }
}

$total_products = count($flat_list);
$total_pages = ceil($total_products / $limit);

// Cắt dữ liệu cho trang hiện tại
$subset_list = array_slice($flat_list, $start_from, $limit);

// Gom nhóm lại để hiển thị
$display_groups = [];
foreach ($subset_list as $item) {
    $cat = $item['temp_category'];
    unset($item['temp_category']); 
    $display_groups[$cat][] = $item;
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
        /* --- CSS CHO PHẦN PHÂN TRANG (MỚI) --- */
        .pagination-wrapper {
            display: flex;
            justify-content: center;
            margin: 40px 0;
            gap: 5px;
        }

        .page-link {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            min-width: 40px;
            height: 40px;
            padding: 0 5px;
            background-color: transparent;
            color: #777;
            font-size: 16px;
            text-decoration: none;
            border-radius: 4px;
            transition: all 0.2s ease;
            font-weight: 400;
        }

        .page-link:hover {
            color: #ee4d2d; /* Màu cam khi hover */
            background-color: #f8f8f8;
        }

        /* Trang hiện tại (Màu cam đậm giống hình Shopee) */
        .page-link.active {
            background-color: #ee4d2d; 
            color: #fff;
            font-weight: bold;
        }
        
        .page-dots {
            display: inline-flex;
            align-items: center;
            color: #999;
            margin: 0 5px;
        }

        /* --- CÁC CSS CŨ --- */
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
        /* Filter bar styles */
        #filter-bar {
            background: rgba(26, 35, 50, 0.95);
            backdrop-filter: blur(10px);
            padding: 20px;
            margin: 20px auto 40px;
            width: 90%;
            max-width: 1200px;
            border-radius: 12px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(53, 253, 236, 0.2);
        }
        .filter-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }
        .search-wrapper { position: relative; flex: 1; min-width: 300px; }
        .search-icon {
            position: absolute; left: 15px; top: 50%; transform: translateY(-50%);
            width: 20px; height: 20px; color: #35fdec; pointer-events: none; z-index: 2;
        }
        .search-input {
            width: 100%; padding: 12px 15px 12px 45px;
            border: 2px solid #233547; border-radius: 50px;
            background: #0f1724; color: #fff; font-size: 15px;
            transition: all 0.3s ease; box-sizing: border-box;
        }
        .search-input::placeholder { color: #6c7a89; }
        .search-input:focus {
            outline: none; border-color: #35fdec;
            box-shadow: 0 0 15px rgba(53, 253, 236, 0.15); background: #151f30;
        }
        .filter-actions { display: flex; align-items: center; gap: 15px; }
        .category-wrapper {
            display: flex; align-items: center; background: #0f1724;
            padding: 5px 15px 5px 10px; border-radius: 50px; border: 1px solid #233547;
        }
        .category-wrapper label { color: #aaa; font-size: 13px; margin-right: 8px; white-space: nowrap; }
        .category-select {
            background: transparent; color: #35fdec; border: none;
            font-size: 14px; font-weight: 600; cursor: pointer; outline: none; padding: 5px;
        }
        .category-select option { background: #1a2332; color: #fff; }
        .reset-btn {
            padding: 10px 20px; background: linear-gradient(135deg, #35fdec 0%, #29b6a6 100%);
            color: #000; border: none; border-radius: 50px; font-weight: bold;
            cursor: pointer; transition: transform 0.2s, box-shadow 0.2s;
            white-space: nowrap; display: flex; align-items: center; gap: 5px;
        }
        .reset-btn:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(53, 253, 236, 0.4); }
        .search-result-info { margin-top: 10px; margin-left: 10px; font-size: 14px; color: #35fdec; font-style: italic; }
        @media (max-width: 768px) {
            .filter-container { flex-direction: column; align-items: stretch; gap: 15px; }
            .filter-actions { justify-content: space-between; }
            .category-wrapper { flex: 1; }
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

            <?php if (!current_user()): ?>
                <li><a href="../Login/Login.php">Đăng nhập</a></li>
            <?php else: ?>
                <?php $username = htmlspecialchars(current_user()['username']); ?>
                <?php if (is_admin()): ?>
                    <li><a href="../admin/admin.php">Quản trị</a></li>
                <?php endif; ?>
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

        <?php if (empty($display_groups)): ?>
            <div style="text-align:center; padding: 50px; color: #fff;">Không có sản phẩm nào ở trang này.</div>
        <?php else: ?>
            <?php foreach ($display_groups as $category => $items): ?>
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
        <?php endif; ?>

        <?php if ($total_pages > 1): ?>
        <div class="pagination-wrapper">
            <?php if ($page > 1): ?>
                <a href="?page=<?= $page - 1 ?>" class="page-link">&lt;</a>
            <?php else: ?>
                <span class="page-link" style="opacity: 0.5; cursor: default;">&lt;</span>
            <?php endif; ?>

            <?php
            $range = 2; // Hiển thị 2 trang xung quanh trang hiện tại
            
            // Trang 1
            if ($page > $range + 1) {
                echo '<a href="?page=1" class="page-link">1</a>';
                if ($page > $range + 2) echo '<span class="page-dots">...</span>';
            }

            // Các trang giữa
            for ($i = max(1, $page - $range); $i <= min($total_pages, $page + $range); $i++) {
                if ($i == $page) {
                    echo '<span class="page-link active">' . $i . '</span>';
                } else {
                    echo '<a href="?page=' . $i . '" class="page-link">' . $i . '</a>';
                }
            }

            // Trang cuối
            if ($page < $total_pages - $range) {
                if ($page < $total_pages - $range - 1) echo '<span class="page-dots">...</span>';
                echo '<a href="?page=' . $total_pages . '" class="page-link">' . $total_pages . '</a>';
            }
            ?>

            <?php if ($page < $total_pages): ?>
                <a href="?page=<?= $page + 1 ?>" class="page-link">&gt;</a>
            <?php else: ?>
                <span class="page-link" style="opacity: 0.5; cursor: default;">&gt;</span>
            <?php endif; ?>
        </div>
        <?php endif; ?>
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

<script>
    // JS Dropdown
    document.getElementById('user-toggle').addEventListener('click', function(e) {
        e.preventDefault();
        var d = this.nextElementSibling; d.style.display = (d.style.display === 'block') ? 'none' : 'block';
    });

    $(document).ready(function () {
        const $groups = $('.category-group');
        const $searchInput = $('#search-input');
        const $categorySelect = $('#category-select');
        const $resetBtn = $('#reset-btn');
        const $searchResultInfo = $('#search-result-info');

        // Hiển thị animation cho thẻ sản phẩm
        $('.product-card').each(function (j) {
            $(this).delay(j * 30).queue(function (next) {
                $(this).addClass('show');
                next();
            });
        });

        function normalizeText(str) {
            if (!str) return '';
            try {
                return str.toString().toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '').replace(/[^\w\s\-]/g, '').trim();
            } catch (e) {
                return str.toString().toLowerCase().trim();
            }
        }

        // Tìm kiếm (Client-side: Chỉ tìm trong 50 sản phẩm đang hiển thị)
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
                    let rawName = $card.find('h3').text() || $card.attr('data-product-name') || '';
                    let productName = normalizeText(rawName);

                    let searchMatches = (searchTerm === '') || productName.indexOf(searchTerm) !== -1;
                    let shouldShow = searchMatches && categoryMatches;

                    if (shouldShow) {
                        $card.stop(true, true).removeClass('hidden').fadeIn(150);
                        hasVisibleProducts = true;
                        visibleProducts++;
                    } else {
                        $card.stop(true, true).addClass('hidden').fadeOut(80);
                    }
                });

                if (hasVisibleProducts) {
                    $group.show();
                } else {
                    $group.hide();
                }
            });

            if (searchTerm || selectedCategory !== 'all') {
                $searchResultInfo.text(visibleProducts === 0 ? '❌ Không tìm thấy sản phẩm phù hợp trên trang này' : '✓ Tìm thấy ' + visibleProducts + ' sản phẩm');
            } else {
                $searchResultInfo.text('');
            }
        }

        $searchInput.on('keyup', performSearch);
        $categorySelect.on('change', performSearch);
        $resetBtn.on('click', function (e) {
            e.preventDefault();
            $searchInput.val('');
            $categorySelect.val('all');
            $searchResultInfo.text('');
            $('.product-card').stop(true,true).removeClass('hidden').fadeIn(120);
            $groups.show();
        });
    });
</script>

</body>
</html>