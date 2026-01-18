<?php
// Trang hiển thị sản phẩm - TỐI ƯU HIỆU SUẤT
$start_time = microtime(true);
require_once __DIR__ . '/../auth.php';
require_once __DIR__ . '/../config.php';

$current_page = 'sanpham';
$conn->set_charset("utf8");

// Kiểm tra FULLTEXT index 1 LẦN DUY NHẤT (tái sử dụng cho cả AJAX và tìm kiếm chính)
$has_fulltext = false;
$check_ft = $conn->query("SHOW INDEX FROM san_pham WHERE Index_type = 'FULLTEXT' AND Column_name = 'ten_san_pham'");
if ($check_ft && $check_ft->num_rows > 0) {
    $has_fulltext = true;
}

// Xử lý AJAX gợi ý tìm kiếm
if (isset($_GET['ajax_search']) && !empty($_GET['q'])) {
    $keyword = $conn->real_escape_string($_GET['q']);
    
    // Dùng FULLTEXT nếu có index và từ khóa >= 3 ký tự
    if ($has_fulltext && mb_strlen($keyword) >= 3) {
        $sql = "SELECT ten_san_pham as ten_goi_y 
                FROM san_pham 
                WHERE MATCH(ten_san_pham) AGAINST('$keyword*' IN BOOLEAN MODE) 
                LIMIT 10";
    } else {
        $sql = "SELECT ten_san_pham as ten_goi_y 
                FROM san_pham 
                WHERE ten_san_pham LIKE '%$keyword%' 
                LIMIT 10";
    }
    
    $result = $conn->query($sql);
    $suggestions = [];
    if ($result) {
        while ($row = $result->fetch_assoc()) {
            $name = explode(' - ', $row['ten_goi_y'])[0];
            if (!in_array($name, $suggestions)) {
                $suggestions[] = $name;
            }
            if (count($suggestions) >= 8) break;
        }
    }
    
    echo json_encode($suggestions);
    exit;
}

// Phân trang & lấy tham số từ URL
$limit = 52; 
$page = isset($_GET['page']) ? max(1, (int)$_GET['page']) : 1;
$offset = ($page - 1) * $limit;

$search_query = isset($_GET['q']) ? trim($_GET['q']) : '';
$search_category = isset($_GET['cat']) ? $_GET['cat'] : 'all';

// Xây dựng điều kiện WHERE
$where_clauses = [];

if (!empty($search_query)) {
    $safe_search = $conn->real_escape_string($search_query);
    // Dùng FULLTEXT nếu có index và từ khóa >= 3 ký tự, ngược lại dùng LIKE
    if ($has_fulltext && mb_strlen($search_query) >= 3) {
        $where_clauses[] = "MATCH(sp.ten_san_pham) AGAINST('$safe_search*' IN BOOLEAN MODE)";
    } else {
        $where_clauses[] = "sp.ten_san_pham LIKE '%$safe_search%'";
    }
}

if ($search_category !== 'all') {
    $safe_cat = $conn->real_escape_string($search_category);
    $where_clauses[] = "sp.loai_san_pham = '$safe_cat'";
}

$where_sql = count($where_clauses) > 0 ? "WHERE " . implode(" AND ", $where_clauses) : "";

// Đếm tổng sản phẩm (dùng estimate nếu không có filter để tăng tốc)
if (empty($search_query) && $search_category === 'all') {
    $result_count = $conn->query("SELECT TABLE_ROWS FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'san_pham'");
    $total_products = $result_count ? (int)$result_count->fetch_assoc()['TABLE_ROWS'] : 0;
} else {
    $sql_count = "SELECT COUNT(*) as total FROM san_pham sp $where_sql";
    $result_count = $conn->query($sql_count);
    $total_products = $result_count ? $result_count->fetch_assoc()['total'] : 0;
}

$total_pages = ceil($total_products / $limit);

// Query lấy danh sách sản phẩm (TỐI ƯU: dùng subquery thay vì JOIN gây duplicate)
$sql = "SELECT 
            sp.id_san_pham, 
            sp.ten_san_pham, 
            sp.loai_san_pham, 
            LEFT(sp.mo_ta, 150) AS mo_ta, 
            sp.bao_hanh,
            (SELECT url_hinh_anh FROM hinh_anh_san_pham WHERE id_san_pham = sp.id_san_pham AND la_anh_dai_dien = 1 LIMIT 1) AS url_hinh_anh,
            (SELECT MIN(gia_ban) FROM bien_the_san_pham WHERE id_san_pham = sp.id_san_pham) AS gia_ban
        FROM san_pham sp
        $where_sql
        LIMIT $limit OFFSET $offset";

$result = $conn->query($sql);

// Gom nhóm theo danh mục (sort trong PHP)
$display_groups = [];
$category_order = [
    'Điện thoại' => 1, 'Laptop' => 2, 'Tivi' => 3, 'Loa' => 4,
    'Tai nghe' => 5, 'Máy chơi game' => 6, 'Máy in' => 7,
    'Phụ kiện' => 8, 'Linh kiện' => 9, 'Màn hình' => 10,
    'Máy tính bảng' => 11, 'Quạt' => 12, 'Đồng hồ' => 13
];

if ($result) {
    while ($row = $result->fetch_assoc()) {
        $cat = !empty($row['loai_san_pham']) ? $row['loai_san_pham'] : 'Sản phẩm khác';
        $display_groups[$cat][] = $row;
    }
}

uksort($display_groups, function($a, $b) use ($category_order) {
    return ($category_order[$a] ?? 99) - ($category_order[$b] ?? 99);
});

// Lấy danh sách danh mục
$result_cat = $conn->query("SELECT DISTINCT loai_san_pham FROM san_pham WHERE loai_san_pham IS NOT NULL ORDER BY loai_san_pham ASC LIMIT 20");
$all_categories = []; 
while ($c = $result_cat->fetch_assoc()) {
    $all_categories[] = $c['loai_san_pham'];
}

$conn->close();

$execution_time = (microtime(true) - $start_time) * 1000;
$memory_used = memory_get_peak_usage(true) / 1024 / 1024;
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
        .performance-info { text-align: center; padding: 10px; font-size: 13px; color: #888; border-top: 1px dashed #333; margin-top: 10px; }
        .performance-info strong { color: #35fdec; }
        .pagination-wrapper { display: flex; justify-content: center; margin: 40px 0; gap: 5px; }
        .page-link { display: inline-flex; justify-content: center; align-items: center; min-width: 40px; height: 40px; background-color: transparent; color: #777; font-size: 16px; text-decoration: none; border-radius: 4px; }
        .page-link:hover { color: #ee4d2d; background-color: #f8f8f8; }
        .page-link.active { background-color: #ee4d2d; color: #fff; font-weight: bold; }
        .page-dots { color: #999; margin: 0 5px; display: flex; align-items: center; }
        #filter-bar { background: rgba(26, 35, 50, 0.95); padding: 20px; margin: 20px auto 40px; width: 90%; max-width: 1200px; border-radius: 12px; box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3); border: 1px solid rgba(53, 253, 236, 0.2); }
        .filter-container { display: flex; justify-content: space-between; align-items: center; gap: 20px; flex-wrap: wrap; }
        .search-wrapper { position: relative; flex: 1; min-width: 300px; }
        .search-icon { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); width: 20px; height: 20px; color: #35fdec; }
        .search-input { width: 100%; padding: 12px 15px 12px 45px; border: 2px solid #233547; border-radius: 50px; background: #0f1724; color: #fff; font-size: 15px; box-sizing: border-box; }
        .search-input:focus { outline: none; border-color: #35fdec; }
        .filter-actions { display: flex; align-items: center; gap: 15px; }
        .category-wrapper { display: flex; align-items: center; background: #0f1724; padding: 5px 15px 5px 10px; border-radius: 50px; border: 1px solid #233547; }
        .category-wrapper label { color: #aaa; font-size: 13px; margin-right: 8px; }
        .category-select { background: transparent; color: #35fdec; border: none; font-size: 14px; font-weight: 600; cursor: pointer; }
        .category-select option { background: #1a2332; color: #fff; }
        .reset-btn { padding: 10px 20px; background: linear-gradient(135deg, #35fdec, #29b6a6); color: #000; border: none; border-radius: 50px; font-weight: bold; cursor: pointer; text-decoration: none; }
        .search-result-info { margin-top: 10px; font-size: 14px; color: #35fdec; }
        .search-suggestions { position: absolute; top: 100%; left: 0; width: 100%; background: #0f1724; border: 1px solid #35fdec; border-top: none; border-radius: 0 0 12px 12px; z-index: 1000; max-height: 300px; overflow-y: auto; display: none; }
        .suggestion-item { padding: 12px 15px; color: #cbd5e0; cursor: pointer; border-bottom: 1px solid #1a2332; }
        .suggestion-item:hover { background-color: #1a2332; color: #35fdec; }
        .suggestion-item strong { color: #fff; }
        .category-title { font-size: 1.4rem; font-weight: 700; text-transform: uppercase; margin: 50px 0 25px 20px; padding-left: 15px; border-left: 4px solid #35fdec; color: #38bdf8; }
        .category-group { max-width: 1200px; margin: 0 auto; padding: 0 20px; }
    </style>
</head>
<body>
    
<div id="fox">
    <div id="fox-nav">
        <ul>
            <li><a href="../index/index.php">Trang chủ</a></li>
            <li><a href="../SanPham/SanPham.php" class="active">Sản phẩm</a></li>
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
            <form action="SanPham.php" method="GET" class="filter-container">
                <div class="search-wrapper">
                    <svg class="search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="11" cy="11" r="8"></circle>
                        <path d="m21 21-4.35-4.35"></path>
                    </svg>
                    <input type="text" name="q" id="search-input" value="<?= htmlspecialchars($search_query) ?>" placeholder="Tìm sản phẩm..." class="search-input" autocomplete="off">
                    <div id="suggestion-box" class="search-suggestions"></div>
                </div>

                <div class="filter-actions">
                    <div class="category-wrapper">
                        <label>Danh mục:</label>
                        <select name="cat" class="category-select" onchange="this.form.submit()">
                            <option value="all" <?= $search_category == 'all' ? 'selected' : '' ?>>Tất cả</option>
                            <?php foreach ($all_categories as $cat): ?> 
                                <option value="<?= htmlspecialchars($cat) ?>" <?= $search_category == $cat ? 'selected' : '' ?>><?= htmlspecialchars($cat) ?></option>
                            <?php endforeach; ?>
                        </select>   
                    </div>
                    <a href="SanPham.php" class="reset-btn">↺ Làm mới</a>
                </div>
                
            </form>
            
            <?php if(!empty($search_query) || $search_category !== 'all'): ?>
                <div class="search-result-info">
                    Tìm thấy <strong><?= number_format($total_products, 0, ',', '.') ?></strong> sản phẩm
                    <span style="color: #888; margin-left: 10px;">⏱ <?= number_format($execution_time, 2) ?>ms</span>
                </div>
            <?php endif; ?>
        </div>

        <?php if (empty($display_groups)): ?>
            <div style="text-align:center; padding: 50px; color: #fff;">Không tìm thấy sản phẩm nào.</div>
        <?php else: ?>
            <?php foreach ($display_groups as $category => $items): ?>
                <div class="category-group">
                    <div class="category-title"><?= htmlspecialchars($category) ?></div>
                    <div class="product-list">
                        <?php foreach ($items as $item): ?>
                            <div class="product-card">
                                <a href="ChiTietSanPham.php?id_san_pham=<?= $item['id_san_pham'] ?>" class="product-link">
                                    <div class="product-image">
                                        <?php if (!empty($item['url_hinh_anh'])): ?>
                                            <img src="<?= htmlspecialchars($item['url_hinh_anh']) ?>" alt="" loading="lazy">
                                        <?php else: ?>
                                            <img src="https://placehold.co/250x150?text=No+Image" alt="" loading="lazy">
                                        <?php endif; ?>
                                    </div>
                                    <div class="product-info">
                                        <h3><?= htmlspecialchars($item['ten_san_pham']) ?></h3>
                                        <p class="desc"><?= htmlspecialchars($item['mo_ta']) ?></p>
                                        <p class="price">Giá: <strong><?= number_format($item['gia_ban'], 0, ',', '.') ?>₫</strong></p>
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
            <?php
            function get_page_url($p) { $params = $_GET; $params['page'] = $p; return '?' . http_build_query($params); }
            if ($page > 1) echo '<a href="' . get_page_url($page - 1) . '" class="page-link">&lt;</a>';
            $range = 2;
            if ($page > $range + 1) { echo '<a href="' . get_page_url(1) . '" class="page-link">1</a>'; if ($page > $range + 2) echo '<span class="page-dots">...</span>'; }
            for ($i = max(1, $page - $range); $i <= min($total_pages, $page + $range); $i++) {
                echo '<a href="' . get_page_url($i) . '" class="page-link ' . ($i == $page ? 'active' : '') . '">' . $i . '</a>';
            }
            if ($page < $total_pages - $range) { if ($page < $total_pages - $range - 1) echo '<span class="page-dots">...</span>'; echo '<a href="' . get_page_url($total_pages) . '" class="page-link">' . $total_pages . '</a>'; }
            if ($page < $total_pages) echo '<a href="' . get_page_url($page + 1) . '" class="page-link">&gt;</a>';
            ?>
        </div>
        <div style="text-align: center; color: #aaa; margin-bottom: 20px;">Trang <?= $page ?> / <?= number_format($total_pages, 0, ',', '.') ?></div>
        <?php endif; ?>
    </div>

    <div id="fox-footer">
        <p>© 2025 TECHNOVA</p>
        <p><a href="../index/index.php">Trang chủ</a> | <a href="../SanPham/SanPham.php">Sản phẩm</a> | <a href="../Gioithieu/Gioithieu.php">Giới thiệu</a> | <a href="../LienHe/Lienhe.php">Liên hệ</a></p>
    </div>
</div>

<script>
document.getElementById('user-toggle')?.addEventListener('click', function(e) {
    e.preventDefault();
    var menu = this.nextElementSibling;
    menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
});

$(document).ready(function() {
    var $input = $('#search-input'), $box = $('#suggestion-box'), timeout = null;
    
    $input.on('keyup', function() {
        var query = $(this).val();
        clearTimeout(timeout);
        if (query.length < 2) { $box.hide(); return; }
        
        timeout = setTimeout(function() {
            $.ajax({
                url: 'SanPham.php', data: { ajax_search: 1, q: query }, dataType: 'json',
                success: function(data) {
                    if (data.length > 0) {
                        var html = '';
                        data.forEach(function(item) {
                            html += '<div class="suggestion-item">' + item.replace(new RegExp('(' + query + ')', 'gi'), '<strong>$1</strong>') + '</div>';
                        });
                        $box.html(html).show();
                    } else { $box.hide(); }
                }
            });
        }, 300);
    });
    
    $(document).on('click', '.suggestion-item', function() { $input.val($(this).text()); $box.hide(); $input.closest('form').submit(); });
    $(document).on('click', function(e) { if (!$(e.target).closest('.search-wrapper').length) $box.hide(); });
});
</script>

</body>
</html>
