## 🚀 Cài đặt nhanh

### Cách 1: Docker (Khuyên dùng)

Yêu cầu: [Docker Desktop](https://www.docker.com/products/docker-desktop/) đã cài đặt.

```bash
# Clone hoặc tải dự án về
cd Webbanhang

# Khởi động containers
docker-compose up -d

# Chờ khoảng 2-5 phút để import database
# Kiểm tra logs nếu cần:
docker logs -f webbanhang_mysql
```

**Truy cập:**
| Dịch vụ | URL | Ghi chú |
|---------|-----|---------|
| Website | http://localhost:8080 | Trang chính |
| phpMyAdmin | http://localhost:8081 | Quản lý database |
| MySQL | localhost:3307 | User: `root` / Pass: `root` |

**Lệnh Docker thường dùng:**

```bash
docker-compose up -d      # Khởi động
docker-compose down       # Dừng
docker-compose down -v    # Dừng và xóa data (reset database)
docker-compose logs -f    # Xem logs
```

---

### Cách 2: XAMPP

1. Cài đặt [XAMPP](https://www.apachefriends.org/)
2. Copy thư mục dự án vào `C:\xampp\htdocs\Webbanhang`
3. Giải nén file database:
   ```bash
   # Dùng Git Bash hoặc 7-Zip
   gzip -d database/webbh.sql.gz
   ```
4. **(Tùy chọn)** Tối ưu MySQL: Copy `database/my_optimized.ini` → `C:\xampp\mysql\bin\my.ini`
5. Khởi động **Apache** và **MySQL** trong XAMPP Control Panel
6. Mở http://localhost/phpmyadmin → Tạo database `webbh`
7. Import file `database/webbh.sql` (mất ~5-10 phút)
8. Truy cập: http://localhost/Webbanhang

**Lưu ý:** Nếu import bị timeout, tăng các giá trị sau trong `php.ini`:

```ini
max_execution_time = 3600
upload_max_filesize = 1024M
post_max_size = 1024M
```

---

## 📁 Cấu trúc dự án

```
Webbanhang/
├── docker-compose.yml
├── README.md
│
├── database/
│   ├── webbh.sql.gz              # Database chính (69MB nén)
│   ├── benchmark_with_index.sql  # Tạo index + test queries
│   ├── benchmark_no_index.sql    # Xóa index + test queries
│   ├── my_optimized.ini          # Config MySQL tối ưu cho XAMPP
│   └── my_backup.ini             # Backup config gốc
│
├── docker/
│   ├── mysql/my.cnf
│   └── php/
│       ├── Dockerfile
│       └── php.ini
│
└── WebBanHang/                   # Source code PHP
    ├── config.php
    ├── auth.php
    ├── index/
    ├── SanPham/
    ├── Login/
    ├── DonHang/
    ├── admin/
    └── ...
```

---

## 📊 Benchmark Index

Dự án này demo sự khác biệt hiệu suất giữa **có Index** và **không có Index** trong MySQL.

### Cách thực hiện

**Bước 1:** Mở phpMyAdmin → Chọn database `webbh`

**Bước 2:** Chạy file `benchmark_no_index.sql`

- Copy nội dung file vào tab SQL → Execute
- Ghi lại thời gian từ `SHOW PROFILES`

**Bước 3:** Chạy file `benchmark_with_index.sql`

- Copy nội dung file vào tab SQL → Execute
- Ghi lại thời gian từ `SHOW PROFILES`

**Bước 4:** So sánh kết quả

### Kết quả kỳ vọng (1 triệu+ sản phẩm)

| Query                      | Không Index | Có Index | Cải thiện |
| -------------------------- | ----------- | -------- | --------- |
| Tìm kiếm `LIKE '%iPhone%'` | 5-15 giây   | 10-50ms  | ~100x     |
| Lọc theo danh mục          | 2-5 giây    | 20-80ms  | ~50x      |
| JOIN 3 bảng (trang SP)     | 10-30 giây  | 50-200ms | ~100x     |

### Index được sử dụng

| Index               | Bảng              | Mục đích          |
| ------------------- | ----------------- | ----------------- |
| `idx_sp_loai`       | san_pham          | Lọc theo danh mục |
| `ft_sp_ten`         | san_pham          | Tìm kiếm fulltext |
| `idx_bt_sp_gia`     | bien_the_san_pham | JOIN lấy giá      |
| `idx_ha_sp_daidien` | hinh_anh_san_pham | Lấy ảnh đại diện  |
| `idx_dg_sp`         | danh_gia_san_pham | Lấy đánh giá      |
| `idx_dh_nguoidung`  | don_hang          | Lấy đơn hàng user |

---

## 🛠️ Công nghệ sử dụng

| Thành phần | Công nghệ                     |
| ---------- | ----------------------------- |
| Backend    | PHP 8.2                       |
| Database   | MySQL 8.0                     |
| Frontend   | HTML, CSS, JavaScript, jQuery |
| Container  | Docker, Docker Compose        |
| Server     | Apache                        |

---

## 📝 Tính năng

### Người dùng

- ✅ Đăng ký / Đăng nhập / Đăng xuất
- ✅ Xem danh sách sản phẩm (phân trang, tìm kiếm, lọc)
- ✅ Xem chi tiết sản phẩm
- ✅ Thêm vào giỏ hàng (AJAX)
- ✅ Đặt hàng (COD / Chuyển khoản)
- ✅ Xem lịch sử đơn hàng
- ✅ Đánh giá sản phẩm

### Admin

- ✅ Quản lý sản phẩm (CRUD)
- ✅ Quản lý người dùng
- ✅ Quản lý đơn hàng
- ✅ Thống kê doanh thu
