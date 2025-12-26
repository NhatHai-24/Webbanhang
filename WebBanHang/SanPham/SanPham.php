<?php
require_once __DIR__ . '/../auth.php';

$current_page = 'sanpham';

$conn = new mysqli("localhost", "root", "", "webbh");
if ($conn->connect_error) die("Kết nối thất bại: " . $conn->connect_error);

$conn->set_charset("utf8");

// --- 1. CẤU HÌNH PHÂN TRANG CƠ BẢN ---
$limit = 52; 
$page = isset($_GET['page']) ? max(1, (int)$_GET['page']) : 1;
$offset = ($page - 1) * $limit;

// --- 2. LOGIC SẮP XẾP ƯU TIÊN ---
$sql_sort_priority = "
    CASE 
        WHEN sp.loai_san_pham = 'Điện thoại' THEN 1
        WHEN sp.loai_san_pham = 'Laptop' THEN 2
        WHEN sp.loai_san_pham = 'Tivi' THEN 3
        WHEN sp.loai_san_pham = 'Loa' THEN 4
        WHEN sp.loai_san_pham = 'Tai nghe' THEN 5
        WHEN sp.loai_san_pham = 'Máy chơi game' THEN 6
        WHEN sp.loai_san_pham = 'Máy in' THEN 7
        WHEN sp.loai_san_pham = 'Phụ kiện' THEN 8
        WHEN sp.loai_san_pham = 'Linh kiện' THEN 9
        WHEN sp.loai_san_pham = 'Màn hình' THEN 10
        WHEN sp.loai_san_pham = 'Máy tính bảng' THEN 11
        WHEN sp.loai_san_pham = 'Quạt' THEN 12
        WHEN sp.loai_san_pham = 'Đồng hồ' THEN 13
        ELSE 99 
    END
";

// --- 3. XỬ LÝ TÌM KIẾM & LỌC (Đoạn này bạn đang thiếu) ---
$search_query = isset($_GET['q']) ? trim($_GET['q']) : '';
$search_category = isset($_GET['cat']) ? $_GET['cat'] : 'all';

// Tạo điều kiện WHERE
$where_clauses = [];
if (!empty($search_query)) {
    $safe_search = $conn->real_escape_string($search_query);
    $where_clauses[] = "sp.ten_san_pham LIKE '%$safe_search%'";
}
if ($search_category !== 'all') {
    $safe_cat = $conn->real_escape_string($search_category);
    $where_clauses[] = "sp.loai_san_pham = '$safe_cat'";
}

// Ghép các điều kiện lại thành chuỗi SQL
$where_sql = "";
if (count($where_clauses) > 0) {
    $where_sql = "WHERE " . implode(" AND ", $where_clauses);
}

// --- 4. ĐẾM TỔNG SỐ SẢN PHẨM (Đã cập nhật để đếm theo tìm kiếm) ---
$sql_count = "SELECT COUNT(*) as total FROM san_pham sp $where_sql";
$result_count = $conn->query($sql_count);
$row_count = $result_count->fetch_assoc();
$total_products = $row_count['total'];
$total_pages = ceil($total_products / $limit);

// --- 5. TRUY VẤN LẤY DỮ LIỆU (TỐI ƯU HIỆU SUẤT) ---
$sql = "SELECT 
            sp.id_san_pham, 
            sp.ten_san_pham, 
            sp.loai_san_pham, 
            SUBSTRING(sp.mo_ta, 1, 150) AS mo_ta,
            sp.bao_hanh,
            /* Subquery lấy ảnh đại diện */
            (SELECT url_hinh_anh 
             FROM hinh_anh_san_pham 
             WHERE id_san_pham = sp.id_san_pham AND la_anh_dai_dien = TRUE 
             LIMIT 1) AS url_hinh_anh,
            /* Subquery lấy giá thấp nhất */
            (SELECT MIN(gia_ban) 
             FROM bien_the_san_pham 
             WHERE id_san_pham = sp.id_san_pham) AS gia_ban
        FROM san_pham sp
        $where_sql 
        ORDER BY $sql_sort_priority ASC, sp.ten_san_pham ASC
        LIMIT $limit OFFSET $offset";

// Thực thi câu lệnh (Dòng này bị thiếu trong code của bạn)
$result = $conn->query($sql);
$display_groups = [];

// --- 6. GOM NHÓM DỮ LIỆU ĐỂ HIỂN THỊ ---
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $cat = !empty($row['loai_san_pham']) ? $row['loai_san_pham'] : 'Các sản phẩm nổi bật';
        $display_groups[$cat][] = $row;
    }
}

// --- 7. LẤY DANH SÁCH DANH MỤC CHO DROPDOWN ---
$sql_cat = "SELECT DISTINCT loai_san_pham FROM san_pham ORDER BY loai_san_pham ASC";
$result_cat = $conn->query($sql_cat);
$all_categories = []; 
while ($c = $result_cat->fetch_assoc()) {
    if (!empty($c['loai_san_pham'])) {
        $all_categories[] = $c['loai_san_pham'];
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
                            <?php foreach ($all_categories as $cat): ?> 
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
            <?php
            // Hàm này giúp tạo link mà vẫn giữ nguyên các tham số tìm kiếm (q, cat)
            function get_page_url($page_num) {
                $params = $_GET; // Lấy tất cả tham số hiện tại trên URL
                $params['page'] = $page_num; // Thay đổi số trang
                return '?' . http_build_query($params); // Tạo lại chuỗi URL mới
            }
            ?>

            <?php if ($page > 1): ?>
                <a href="<?= get_page_url($page - 1) ?>" class="page-link">&lt;</a>
            <?php else: ?>
                <span class="page-link" style="opacity: 0.5; cursor: default;">&lt;</span>
            <?php endif; ?>

            <?php
            $range = 2; 
            
            // Trang 1
            if ($page > $range + 1) {
                echo '<a href="' . get_page_url(1) . '" class="page-link">1</a>';
                if ($page > $range + 2) echo '<span class="page-dots">...</span>';
            }

            // Các trang giữa
            for ($i = max(1, $page - $range); $i <= min($total_pages, $page + $range); $i++) {
                if ($i == $page) {
                    echo '<span class="page-link active">' . $i . '</span>';
                } else {
                    echo '<a href="' . get_page_url($i) . '" class="page-link">' . $i . '</a>';
                }
            }

            // Trang cuối
            if ($page < $total_pages - $range) {
                if ($page < $total_pages - $range - 1) echo '<span class="page-dots">...</span>';
                echo '<a href="' . get_page_url($total_pages) . '" class="page-link">' . $total_pages . '</a>';
            }
            ?>

            <?php if ($page < $total_pages): ?>
                <a href="<?= get_page_url($page + 1) ?>" class="page-link">&gt;</a>
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

        
       
    });
</script>

</body>
</html>