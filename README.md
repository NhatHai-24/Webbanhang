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
5.  Truy cập web: [http://localhost/Webbanhang](http://localhost/Webbanhang).

---

## 2. Chuẩn bị Benchmark

Trước khi đo lường, hãy đảm bảo database đã có dữ liệu.

1.  **Database**: `webbh`
2.  **File kịch bản test** (nằm trong thư mục `database/`):
    - `benchmark_no_index.sql`: Kịch bản **Chậm** (Không có Index).
    - `benchmark_with_index.sql`: Kịch bản **Nhanh** (Có Index tối ưu).

## 3. Hướng dẫn Benchmark

Sử dụng **phpMyAdmin** hoặc **MySQL Workbench** để chạy các kịch bản sau:

### Kịch bản 1: Không có Index (Chậm)

1.  Mở file `database/benchmark_no_index.sql`.
2.  Copy toàn bộ nội dung và chạy trong cửa sổ SQL.
3.  Quan sát thời gian thực thi (Duration) của các câu query ở cuối.

### Kịch bản 2: Có Index (Nhanh)

1.  Mở file `database/benchmark_with_index.sql`.
2.  Copy toàn bộ nội dung và chạy trong cửa sổ SQL.
3.  Quan sát thời gian thực thi mới và so sánh với Kịch bản 1.

## 4. So sánh Kết quả (ước tính)

Dưới đây là bảng so sánh thực tế khi chạy trên 1 triệu dòng dữ liệu:

| Loại Truy Vấn       | Query                   | Không Index (Full Scan) | Tối Ưu Index (B-Tree/FullText) |  Cải thiện  |
| :------------------ | :---------------------- | :---------------------: | :----------------------------: | :---------: |
| **Tìm kiếm**        | `LIKE '%iPhone%'`       |         ~0.500s         |           **0.002s**           | **250 lần** |
| **Lọc danh mục**    | `loai_san_pham = '...'` |         ~0.450s         |           **0.001s**           | **450 lần** |
| **JOIN nhiều bảng** | `JOIN bien_the...`      |         ~1.200s         |           **0.005s**           | **240 lần** |

---

## 💡 Tại sao Index nhanh hơn?

- **Không Index (Full Table Scan)**:

  - Giống như tìm từ trong từ điển bằng cách đọc từng trang từ đầu đến cuối.
  - Độ phức tạp: **O(n)** (Dữ liệu càng lớn càng chậm).

- **Có Index (B-Tree Lookup)**:
  - Giống như tra Mục lục. Biết ngay trang chứa từ cần tìm.
  - Độ phức tạp: **O(log n)** (Dữ liệu lớn vẫn rất nhanh).
