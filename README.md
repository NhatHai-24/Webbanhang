# Index vs No-Index

Dự án này minh họa sự khác biệt **khổng lồ** về hiệu suất truy vấn giữa việc **Có Index** và **Không Index** trong MySQL.

## 1. Cài đặt & Chạy dự án

Bạn có thể chạy dự án bằng **XAMPP** hoặc **Docker**.

### Cách 1: Sử dụng Docker (Khuyên dùng)

Nếu máy bạn đã cài Docker, chỉ cần chạy lệnh sau:

```bash
docker-compose up -d
```

- **Website**: [http://localhost:8080](http://localhost:8080)
- **phpMyAdmin**: [http://localhost:8081](http://localhost:8081)
- **Database**: Tự động import `webbh` (Port 3307).

### Cách 2: Sử dụng XAMPP

1.  Copy thư mục dự án vào `C:\xampp\htdocs\Webbanhang`.
2.  Khởi động **Apache** và **MySQL** trong XAMPP Control Panel.
3.  Vào [http://localhost/phpmyadmin](http://localhost/phpmyadmin), tạo database tên `webbh`.
4.  Import file `database/webbh.sql` vào database vừa tạo.
5.  **(Tùy chọn)** Xem phần **Tối ưu MySQL** bên dưới để tăng tốc độ truy vấn.
6.  Truy cập web: [http://localhost/Webbanhang](http://localhost/Webbanhang).

---

## 2. Tối ưu MySQL (Tùy chọn)

Để đạt tốc độ truy vấn tối đa (vài trăm ms):

- **Docker**: Đã được tối ưu sẵn trong `docker/mysql/my.cnf`, không cần thao tác gì thêm.
- **XAMPP**: Áp dụng thủ công theo hướng dẫn bên dưới.

### Hướng dẫn cho XAMPP

1. Dừng MySQL trong XAMPP Control Panel.
2. Mở file `C:\xampp\mysql\bin\my.ini`.
3. Copy nội dung từ `database/my_optimized_config.ini` vào thay thế.
4. Khởi động lại MySQL.

---

## 3. Chuẩn bị Benchmark

Trước khi đo lường, hãy đảm bảo database đã có dữ liệu.

1.  **Database**: `webbh`
2.  **File kịch bản test** (nằm trong thư mục `database/`):
    - `benchmark_no_index.sql`: Kịch bản **Chậm** (Không có Index).
    - `benchmark_with_index.sql`: Kịch bản **Nhanh** (Có Index tối ưu).

## 4. Hướng dẫn Benchmark

Sử dụng **phpMyAdmin** hoặc **MySQL Workbench** để chạy các kịch bản sau:

### Kịch bản 1: Không có Index (Chậm)

1.  Mở file `database/benchmark_no_index.sql`.
2.  Copy toàn bộ nội dung và chạy trong cửa sổ SQL.
3.  Quan sát thời gian thực thi (Duration) của các câu query ở cuối.

### Kịch bản 2: Có Index (Nhanh)

1.  Mở file `database/benchmark_with_index.sql`.
2.  Copy toàn bộ nội dung và chạy trong cửa sổ SQL.
3.  Quan sát thời gian thực thi mới và so sánh với Kịch bản 1.
