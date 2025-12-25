<?php
// ...existing code...
if (session_status() === PHP_SESSION_NONE) session_start();

function current_user() {
    return $_SESSION['user'] ?? null;
}

function is_admin(): bool {
    $u = current_user();
    return $u && (($u['role'] ?? '') === 'admin');
}

function is_user(): bool {
    $u = current_user();
    return $u && (($u['role'] ?? '') === 'user');
}

function require_login() {
    if (!current_user()) {
        header('Location: ./Login/Login.php'); // điều chỉnh đường dẫn nếu cần
        exit();
    }
}

function require_admin() {
    if (!is_admin()) {
        header('Location: ../Login/Login.php'); // về login hoặc trang lỗi
        exit();
    }
}
// ...existing code...