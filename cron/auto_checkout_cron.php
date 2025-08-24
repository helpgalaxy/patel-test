<?php
/**
 * Auto Checkout Cron Job
 * This file should be executed by cron every minute or every 5 minutes
 * Cron command: * * * * * /usr/bin/php /path/to/your/project/cron/auto_checkout_cron.php
 * Or for every 5 minutes: */5 * * * * /usr/bin/php /path/to/your/project/cron/auto_checkout_cron.php
 */

// Prevent direct browser access
if (php_sapi_name() !== 'cli' && !isset($_GET['manual_run'])) {
    http_response_code(403);
    die('Access denied. This script should only be run via cron job.');
}

require_once dirname(__DIR__) . '/config/database.php';
require_once dirname(__DIR__) . '/includes/auto_checkout.php';

try {
    $autoCheckout = new AutoCheckout($pdo);
    $result = $autoCheckout->executeDailyCheckout();
    
    // Log the result
    $logMessage = date('Y-m-d H:i:s') . " - Auto Checkout Result: " . json_encode($result) . "\n";
    file_put_contents(dirname(__DIR__) . '/logs/auto_checkout.log', $logMessage, FILE_APPEND | LOCK_EX);
    
    if (isset($_GET['manual_run'])) {
        header('Content-Type: application/json');
        echo json_encode($result);
    } else {
        echo "Auto checkout executed: " . $result['status'] . "\n";
    }
    
} catch (Exception $e) {
    $errorMessage = date('Y-m-d H:i:s') . " - Auto Checkout Error: " . $e->getMessage() . "\n";
    file_put_contents(dirname(__DIR__) . '/logs/auto_checkout.log', $errorMessage, FILE_APPEND | LOCK_EX);
    
    if (isset($_GET['manual_run'])) {
        http_response_code(500);
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    } else {
        echo "Error: " . $e->getMessage() . "\n";
    }
}
?>