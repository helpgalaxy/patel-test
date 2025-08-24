<?php
// Database configuration - Compatible with Hostinger and other hosting providers
$host = $_ENV['DB_HOST'] ?? 'localhost';
$dbname = $_ENV['DB_NAME'] ?? 'u261459251_software';
$username = $_ENV['DB_USERNAME'] ?? 'u261459251_hotel';
$password = $_ENV['DB_PASSWORD'] ?? 'Vishraj@9884';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
} catch(PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}
?>