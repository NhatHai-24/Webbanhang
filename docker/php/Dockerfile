# Base image: PHP 8.2 với Apache
FROM php:8.2-apache

# -----------------------------------------
# CÀI ĐẶT PHP EXTENSIONS
# -----------------------------------------
# mysqli: Kết nối MySQL theo cách truyền thống
# pdo + pdo_mysql: Kết nối MySQL theo chuẩn PDO (an toàn hơn)
RUN docker-php-ext-install mysqli pdo pdo_mysql

# mod_rewrite: Cho phép URL đẹp (pretty URLs)
RUN a2enmod rewrite

# Cấu hình APACHE
# Options Indexes: Cho phép liệt kê file trong thư mục
# FollowSymLinks: Cho phép theo symbolic links
# AllowOverride All: Cho phép dùng .htaccess
# Require all granted: Cho phép tất cả truy cập
# DirectoryIndex: Thứ tự ưu tiên file index
RUN echo '<Directory /var/www/html>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
    DirectoryIndex index.php index.html\n\
    </Directory>' > /etc/apache2/conf-available/custom-directory.conf \
    && a2enconf custom-directory

# Đặt thư mục làm việc mặc định
WORKDIR /var/www/html

# Đặt quyền sở hữu cho user www-data (Apache user)
RUN chown -R www-data:www-data /var/www/html

# Mở cổng 80 cho HTTP
EXPOSE 80
