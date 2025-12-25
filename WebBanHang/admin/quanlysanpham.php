<?php
$current_page = basename($_SERVER['PHP_SELF']);
session_start();
require_once __DIR__ . '/../auth.php';
require_admin();
if (!isset($_SESSION["user"]) || stripos($_SESSION["user"]["username"], "admin") === false) {
    header("Location: ../Login/Login.php");
    exit();
}

$conn = new mysqli("localhost", "root", "", "webbh");
if ($conn->connect_error) die("Kết nối thất bại: " . $conn->connect_error);

// ===== Thêm sản phẩm =====
if (isset($_POST["add"])) {
  $ten = $conn->real_escape_string($_POST["ten_san_pham"]);
  $loai = $conn->real_escape_string($_POST["loai_san_pham"]);
  $mo_ta = $conn->real_escape_string($_POST["mo_ta"]);
  $thong_so = $conn->real_escape_string($_POST["thong_so_ky_thuat"]);
  $bao_hanh = $conn->real_escape_string($_POST["bao_hanh"]);
  $video = $conn->real_escape_string($_POST["video_gioi_thieu"]);

  // Xử lý upload file (nếu có). Nếu upload thành công sẽ dùng file, ngược lại dùng URL từ input.
  $hinh = '';
  if (isset($_FILES['hinh_file']) && $_FILES['hinh_file']['error'] === UPLOAD_ERR_OK) {
      $uploadDir = __DIR__ . '/uploads/';
      if (!is_dir($uploadDir)) mkdir($uploadDir, 0755, true);
      $tmp = $_FILES['hinh_file']['tmp_name'];
      $orig = basename($_FILES['hinh_file']['name']);
      $ext = pathinfo($orig, PATHINFO_EXTENSION);
      $safeName = uniqid('img_') . ($ext ? '.' . $ext : '');
      if (move_uploaded_file($tmp, $uploadDir . $safeName)) {
    // Thêm ../ để khi hiển thị ở trang Sản phẩm (bên ngoài thư mục admin) vẫn đọc được
    $hinh = '../admin/uploads/' . $safeName;
}
  }

  // Nếu không upload file thì dùng URL từ input (nếu có)
  if (empty($hinh) && !empty($_POST['hinh_anh'])) {
      $hinh = $conn->real_escape_string($_POST['hinh_anh']);
  } else {
      $hinh = $conn->real_escape_string($hinh);
  }

  // Thêm sản phẩm chính
  $conn->query("INSERT INTO san_pham (ten_san_pham, loai_san_pham, mo_ta, bao_hanh, video_gioi_thieu, thong_so_ky_thuat)
                VALUES ('$ten', '$loai', '$mo_ta', '$bao_hanh', '$video', '$thong_so')");
  $idMoi = $conn->insert_id;

  // Thêm ảnh đại diện
  $conn->query("INSERT INTO hinh_anh_san_pham (id_san_pham, url_hinh_anh, la_anh_dai_dien)
                VALUES ($idMoi, '$hinh', 1)");

  // Thêm biến thể
  $mau_sacs = $_POST["mau_sac"];
  $so_luongs = $_POST["so_luong_ton_kho"];
  $gia_bans = $_POST["gia_ban"];

  for ($i = 0; $i < count($mau_sacs); $i++) {
      $mau = $conn->real_escape_string($mau_sacs[$i]);
      $sl = (int)$so_luongs[$i];
      $gia = (float)$gia_bans[$i];

      $conn->query("INSERT INTO bien_the_san_pham (id_san_pham, mau_sac, so_luong_ton_kho, gia_ban)
                    VALUES ($idMoi, '$mau', $sl, $gia)");
  }

  header("Location: quanlysanpham.php");
  exit();
}

// ===== Cập nhật sản phẩm  =====
if (isset($_POST["update"])) {
    $id = (int)$_POST["id_sua"];
    $ten = $conn->real_escape_string($_POST["ten_san_pham"]);
    $loai = $conn->real_escape_string($_POST["loai_san_pham"]);
    $mo_ta = $conn->real_escape_string($_POST["mo_ta"]);
    $thong_so = $conn->real_escape_string($_POST["thong_so_ky_thuat"]);

    $conn->query("UPDATE san_pham SET ten_san_pham='$ten', loai_san_pham='$loai', mo_ta='$mo_ta', thong_so_ky_thuat='$thong_so' WHERE id_san_pham = $id");

    // Cập nhật từng biến thể
    $ids = $_POST["id_bien_the"];
    $maus = $_POST["mau_sac"];
    $soluongs = $_POST["so_luong_ton_kho"];
    $gias = $_POST["gia_ban"];

    for ($i = 0; $i < count($ids); $i++) {
        $id_bien_the = (int)$ids[$i];
        $mau = $conn->real_escape_string($maus[$i]);
        $sl = (int)$soluongs[$i];
        $gia = (float)$gias[$i];
        $conn->query("UPDATE bien_the_san_pham SET mau_sac='$mau', so_luong_ton_kho=$sl, gia_ban=$gia 
                      WHERE id_bien_the=$id_bien_the");
    }

    header("Location: quanlysanpham.php");
    exit();
}

// ===== Dữ liệu cho form sửa sản phẩm =====
$productEdit = null;
$variantsEdit = [];
if (isset($_GET["id_sua"])) {
    $idSua = (int)$_GET["id_sua"];
    $productEdit = $conn->query("SELECT * FROM san_pham WHERE id_san_pham = $idSua")->fetch_assoc();
    $variantsEdit = $conn->query("SELECT * FROM bien_the_san_pham WHERE id_san_pham = $idSua")->fetch_all(MYSQLI_ASSOC);
}

// ===== Danh sách sản phẩm + biến thể =====
$products = $conn->query("
    SELECT sp.id_san_pham AS id, sp.ten_san_pham AS name, sp.mo_ta AS description,
           bt.id_bien_the, bt.mau_sac, bt.so_luong_ton_kho, bt.gia_ban
    FROM san_pham sp
    LEFT JOIN bien_the_san_pham bt ON sp.id_san_pham = bt.id_san_pham
    ORDER BY sp.id_san_pham, bt.id_bien_the
");
?>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Quản lý sản phẩm Admin</title>
  <link rel="stylesheet" href="admin.css?v=2">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <style>
      /* Chỉnh màu cho ô Select */
      select {
          background-color: #1a2332; /* Màu nền tối (Xanh đen) */
          color: #ffffff;            /* Chữ màu trắng */
          border: 1px solid #4a5568; /* Viền xám */
          padding: 8px;
          border-radius: 4px;
          width: 100%;               /* Đảm bảo rộng bằng ô input */
          outline: none;
      }

      /* Chỉnh màu cho các dòng Option khi xổ xuống */
      select option {
          background-color: #1a2332; /* Nền tối */
          color: #ffffff;            /* Chữ trắng */
          padding: 10px;
      }
      
      /* Hiệu ứng khi focus vào */
      select:focus {
          border-color: #35fdec;     /* Viền sáng màu xanh neon khi bấm vào */
      }
  </style>
  <script>
    $(function () {
      $(".toggle-form").click(() => $(".form-section").slideToggle());
      $(".btn-edit-trigger").click(() => {
        $('html, body').animate({ scrollTop: $("#form-update").offset().top - 80 }, 600);
      });
    });
  </script>
</head>
<body>
<div id="fox">

  <div id="fox-nav">
    <ul>
            <li><a href="admin.php">Trang Chủ</a></li>
            <li><a href="quanlysanpham.php" class="<?= ($current_page == 'quanlysanpham.php') ? 'active' : '' ?>">Quản Lý Sản Phẩm</a></li>
            <li><a href="quanlydonHang.php">Quản lý Đơn Hàng</a></li>
            <li><a href="quanlynguoidung.php">Quản lý Người Dùng</a></li>
            <li><a href="quanlythongke.php">Thống Kê</a></li>
            <li><a href="quanlydanhgia.php">Quản lý Đánh Giá</a></li>
           <?php if (!isset($_SESSION["user"])): ?>
            <!-- Chưa đăng nhập -->
            <li><a href="../Login/Login.php">Đăng nhập</a></li>
        <?php else: ?>
            <!-- Đã đăng nhập -->
            <?php $username = htmlspecialchars($_SESSION["user"]["username"]); ?>
            <li class="user-dropdown">
                <a href="#" id="user-toggle"><?= $username ?> ⮟</a>
                <ul class="dropdown-menu" style="display: none;">
                  <li><a href="DoiMatKhauAdmin.php">Đổi Mật Khẩu</a></li>  
                  <li><a href="../Login/logout.php">Đăng xuất</a></li>
                </ul>
            </li>
        <?php endif; ?>
    </ul>
  </div>

  <div class="admin-container">
    <h2>🌐 Quản lý sản phẩm</h2>
    <a href="admin.php" class="btn" style="margin-bottom: 20px; display: inline-block;">← Quay lại trang Admin</a></br>
    
    <button class="toggle-form" style="margin-bottom: 20px;">➕ Thêm sản phẩm mới</button>

    <!-- Form Thêm -->
<div class="form-section" style="display: none;">
  <form method="POST" class="product-form" enctype="multipart/form-data">
    <label>Tên sản phẩm</label>
<input type="text" name="ten_san_pham" id="input_ten_sp" onkeyup="autoClassify(this.value)" required>

<label>Loại sản phẩm (Tự động gợi ý)</label>
<select name="loai_san_pham" id="select_loai_sp" required>
    <option value="">-- Chọn loại sản phẩm --</option>
    <option value="Điện thoại">Điện thoại</option>
    <option value="Laptop">Laptop</option>
    <option value="Tai nghe">Tai nghe</option>
    <option value="Loa">Loa</option>
    <option value="Tivi">Tivi</option>
    <option value="Máy chơi game">Máy chơi game</option>
    <option value="Phụ kiện">Phụ kiện</option>
    <option value="Máy in">Máy in</option>
</select>
    

    <label>Mô tả</label>
    <textarea name="mo_ta" rows="3" required></textarea>

    <label>Thông số kỹ thuật</label>
    <textarea name="thong_so_ky_thuat" rows="5"><?= htmlspecialchars($productEdit["thong_so_ky_thuat"] ?? '') ?></textarea>

    <label>Hình ảnh (URL hoặc upload)</label>
    <div style="display:flex; gap:10px; align-items:center;">
      <input type="url" name="hinh_anh" id="hinh_anh_url" placeholder="https://..." style="flex:1;">
      <input type="file" name="hinh_file" id="hinh_file" accept="image/*">
    </div>
    <img id="preview" src="" alt="" style="max-width:200px; display:none; margin-top:10px;">
    <small>Chọn file để upload hoặc dán URL — ít nhấ

    <label>Bảo hành</label>
    <input type="text" name="bao_hanh">

    <label>Video giới thiệu (YouTube)</label>
    <input type="url" name="video_gioi_thieu">

    <h4>Màu Sản Phẩm</h4>
    <div id="variant-container">
      <div class="variant-row">
        <input type="text" name="mau_sac[]" placeholder="Màu sắc" required>
        <input type="number" name="so_luong_ton_kho[]" placeholder="Số lượng" required>
        <input type="number" name="gia_ban[]" placeholder="Giá bán" required>
        <button type="button" onclick="removeVariant(this)" class="remove-btn">❌</button>
      </div>
    </div>
    <button type="button" onclick="addVariant()">➕ Các màu của sản phẩm</button>

    <br><br>
    <button type="submit" name="add">Thêm sản phẩm</button>
  </form>
</div>

<script>
function addVariant() {
  const container = document.getElementById("variant-container");
  const div = document.createElement("div");
  div.className = "variant-row";
  div.innerHTML = `
    <input type="text" name="mau_sac[]" placeholder="Màu sắc" required>
    <input type="number" name="so_luong_ton_kho[]" placeholder="Số lượng" required>
    <input type="number" name="gia_ban[]" placeholder="Giá bán" required>
    <button type="button" onclick="removeVariant(this)" class="remove-btn">❌</button>
  `;
  container.appendChild(div);
}

function removeVariant(btn) {
  btn.parentElement.remove();
}
</script>

    <?php if ($productEdit): ?>
<div id="form-update" style="margin-top: 40px;">
  <h3>✏️ Cập nhật sản phẩm</h3>
  <form method="POST">
    <input type="hidden" name="id_sua" value="<?= $productEdit["id_san_pham"] ?>">
    <label>Tên sản phẩm</label>
    <input type="text" name="ten_san_pham" value="<?= htmlspecialchars($productEdit["ten_san_pham"]) ?>" required>
    <label>Loại sản phẩm (Tự động gợi ý)</label>
<select name="loai_san_pham" id="select_loai_sp" required>
    <option value="">-- Chọn loại sản phẩm --</option>
    <option value="Điện thoại">Điện thoại</option>
    <option value="Laptop">Laptop</option>
    <option value="Tai nghe">Tai nghe</option>
    <option value="Loa">Loa</option>
    <option value="Tivi">Tivi</option>
    <option value="Máy chơi game">Máy chơi game</option>
    <option value="Phụ kiện">Phụ kiện</option>
    <option value="Máy in">Máy in</option>
</select>
    

    <label>Mô tả</label>
    <textarea name="mo_ta" rows="3" required><?= htmlspecialchars($productEdit["mo_ta"]) ?></textarea>
    <label>Thông số kỹ thuật</label>
    <textarea name="thong_so_ky_thuat" rows="5"><?= htmlspecialchars($productEdit["thong_so_ky_thuat"] ?? '') ?></textarea>

    <h4>Màu sản phẩm:</h4>
    <?php foreach ($variantsEdit as $v): ?>
      <div class="variant-block" style="margin-bottom:10px; border:1px solid #ccc; padding:10px; border-radius:6px;">
        <input type="hidden" name="id_bien_the[]" value="<?= $v['id_bien_the'] ?>">
        <label>Màu sắc:</label>
        <input type="text" name="mau_sac[]" value="<?= htmlspecialchars($v['mau_sac']) ?>" required>
        <label>Số lượng:</label>
        <input type="number" name="so_luong_ton_kho[]" value="<?= $v['so_luong_ton_kho'] ?>" required>
        <label>Giá bán:</label>
        <input type="number" name="gia_ban[]" value="<?= $v['gia_ban'] ?>" required>
      </div>
    <?php endforeach; ?>

    <button type="submit" name="update">Lưu cập nhật</button>
  </form>
</div>
<?php endif; ?>


    <h3 style="margin-top: 40px;">📦 Danh sách sản phẩm</h3>
    <table class="admin-table">
  <thead>
    <tr>
      <th>ID</th>
      <th>Tên sản phẩm</th>
      <th>Mô tả</th>
      <th>Màu sản phẩm</th>
      <th>Hành động</th>
    </tr>
  </thead>
  <tbody>
    <?php 
    $lastId = null;
    $variantRows = [];

    while ($row = $products->fetch_assoc()):
        if ($lastId !== $row["id"]) {
            // In sản phẩm trước đó nếu có
            if ($lastId !== null) {
                echo "<td><table class='inner-table' style='width:100%; border:none;'>";
                echo "<thead><tr><th style='border:none;'>Màu</th><th style='border:none;'>Số lượng</th><th style='border:none;'>Giá</th></tr></thead><tbody>";
                foreach ($variantRows as $v) {
                    echo "<tr>
                            <td style='border:none;'>".htmlspecialchars($v["mau_sac"] ?: "-")."</td>
                            <td style='border:none;'>".$v["so_luong_ton_kho"]."</td>
                            <td style='border:none;'>".number_format($v["gia_ban"], 0, ',', '.')."₫</td>
                          </tr>";
                }
                echo "</tbody></table></td>
                      <td class='action-col'>
                          <a href='quanlysanpham.php?id_sua=$lastId' class='btn-edit'>Sửa SP</a>
                          <a href='xoasanpham.php?id=$lastId' class='btn-delete' onclick='return confirm(\"Xóa sản phẩm này?\")'>Xóa SP</a>
                      </td>
                    </tr>";
            }

            // Bắt đầu dòng sản phẩm mới
            echo "<tr>
                    <td>{$row["id"]}</td>
                    <td>".htmlspecialchars($row["name"])."</td>
                    <td>".nl2br(htmlspecialchars(substr($row["description"], 0, 100)))."</td>";
            $variantRows = [];
            $lastId = $row["id"];
        }

        // Thu thập biến thể cho sản phẩm hiện tại
        $variantRows[] = $row;
    endwhile;

    // In dòng cuối cùng
    if ($lastId !== null) {
        echo "<td><table class='inner-table' style='width:100%; border:none;'>";
        echo "<thead><tr><th style='border:none;'>Màu</th><th style='border:none;'>Số lượng</th><th style='border:none;'>Giá</th></tr></thead><tbody>";
        foreach ($variantRows as $v) {
            echo "<tr>
                    <td style='border:none;'>".htmlspecialchars($v["mau_sac"] ?: "-")."</td>
                    <td style='border:none;'>".$v["so_luong_ton_kho"]."</td>
                    <td style='border:none;'>".number_format($v["gia_ban"], 0, ',', '.')."₫</td>
                  </tr>";
        }
        echo "</tbody></table></td>
              <td class='action-col'>
                  <a href='quanlysanpham.php?id_sua=$lastId' class='btn-edit'>Sửa SP</a>
                  <a href='xoasanpham.php?id=$lastId' class='btn-delete' onclick='return confirm(\"Xóa sản phẩm này?\")'>Xóa SP</a>
              </td>
            </tr>";
    }
    ?>
  </tbody>
</table>
  </div>

  <div id="fox-footer">
    <p>© 2025 TECHNOVA. All rights reserved.</p>
    <p>Địa chỉ: 123 Đường Nguyễn Trãi, TP.HCM | Hotline: 0123 456 789 | Email: support@technova.vn</p>
    
  </div>
</div>
<script>
// Trước submit kiểm tra ít nhất có file hoặc URL.
document.getElementById('hinh_file').addEventListener('change', function(e){
  const f = this.files[0];
  const p = document.getElementById('preview');
  if (f) {
    p.src = URL.createObjectURL(f);
    p.style.display = 'block';
    // xóa URL input (tùy chọn)
    
  } else {
    p.src = '';
    p.style.display = 'none';
  }
});

document.getElementById('hinh_anh_url').addEventListener('input', function(e){
  const url = this.value.trim();
  const p = document.getElementById('preview');
  if (url) {
    p.src = url;
    p.style.display = 'block';
  } else if (!document.getElementById('hinh_file').files.length) {
    p.src = '';
    p.style.display = 'none';
  }
});

document.getElementById('form-add').addEventListener('submit', function(e){
  const url = document.getElementById('hinh_anh_url').value.trim();
  const hasFile = document.getElementById('hinh_file').files.length > 0;
  if (!url && !hasFile) {
    e.preventDefault();
    alert('Vui lòng chọn ảnh (upload) hoặc dán URL ảnh.');
  }
});
</script>
<script>
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
<script src="index.js"></script>

<script>
function autoClassify(name) {
    // Chuyển tên về chữ thường để dễ so sánh
    let lowerName = name.toLowerCase();
    let categorySelect = document.getElementById('select_loai_sp');
    
    // Định nghĩa các từ khóa cho từng danh mục
    // Ví dụ: Nếu tên có chữ "iphone" hoặc "samsung" -> Chọn "Điện thoại"
    const rules = {
        'Điện thoại': ['điện thoại', 'iphone', 'samsung galaxy', 'oppo', 'xiaomi redmi', 'vivo', 'realme'],
        'Laptop': ['laptop', 'macbook', 'dell', 'hp', 'asus', 'acer', 'lenovo', 'msi'],
        'Tai nghe': ['tai nghe', 'headphone', 'airpod', 'earbud', 'galaxy buds'],
        'Loa': ['loa', 'speaker', 'jbl', 'kéo', 'soundbar'],
        'Tivi': ['tivi', 'tv', 'lg', 'sony bravia', 'samsung ua', 'casper'],
        'Máy chơi game': ['playstation', 'ps5', 'xbox', 'nintendo', 'game', 'console'],
        'Máy in': ['máy in', 'canon', 'brother', 'inkjet'],
        'Phụ kiện': ['chuột', 'bàn phím', 'cáp', 'sạc', 'bao da', 'ốp', 'túi']
    };

    let found = false;

    // Duyệt qua từng danh mục trong luật (rules)
    for (let category in rules) {
        let keywords = rules[category];
        
        // Kiểm tra xem tên sản phẩm có chứa từ khóa nào không
        for (let i = 0; i < keywords.length; i++) {
            if (lowerName.includes(keywords[i])) {
                categorySelect.value = category; // Tự động chọn danh mục
                found = true;
                break;
            }
        }
        if (found) break; // Nếu tìm thấy rồi thì dừng lại
    }
}
</script>
</body>
</html>
