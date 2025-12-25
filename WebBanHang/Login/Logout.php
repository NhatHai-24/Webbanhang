<?php
session_start();
require_once __DIR__ . '/../auth.php';

if (session_status() === PHP_SESSION_NONE) session_start();
$_SESSION = [];
session_unset();
session_destroy();
setcookie(session_name(), '', time() - 3600, '/');
header('Location: ../index/index.php');
exit();
?>