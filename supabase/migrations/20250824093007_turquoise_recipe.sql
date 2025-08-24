-- Hotel Management Database Setup
-- Compatible with Hostinger and other hosting providers

CREATE DATABASE IF NOT EXISTS hotel_management;
USE hotel_management;

-- Rooms table
CREATE TABLE IF NOT EXISTS rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type VARCHAR(50) NOT NULL,
    status ENUM('available', 'occupied', 'maintenance', 'cleaning') DEFAULT 'available',
    guest_name VARCHAR(100) DEFAULT NULL,
    guest_phone VARCHAR(20) DEFAULT NULL,
    guest_email VARCHAR(100) DEFAULT NULL,
    check_in_date DATE DEFAULT NULL,
    check_in_time TIME DEFAULT NULL,
    check_out_date DATE DEFAULT NULL,
    check_out_time TIME DEFAULT NULL,
    auto_checkout_enabled BOOLEAN DEFAULT TRUE,
    last_auto_checkout DATETIME DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Auto checkout logs table
CREATE TABLE IF NOT EXISTS auto_checkout_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_id INT NOT NULL,
    room_number VARCHAR(10) NOT NULL,
    guest_name VARCHAR(100),
    checkout_date DATE NOT NULL,
    checkout_time TIME NOT NULL,
    status ENUM('success', 'failed') DEFAULT 'success',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE
);

-- System settings table
CREATE TABLE IF NOT EXISTS system_settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    setting_key VARCHAR(100) NOT NULL UNIQUE,
    setting_value TEXT NOT NULL,
    description TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert default settings
INSERT INTO system_settings (setting_key, setting_value, description) VALUES
('auto_checkout_time', '10:00', 'Daily automatic checkout time (24-hour format)'),
('auto_checkout_enabled', '1', 'Enable/disable automatic checkout system'),
('timezone', 'Asia/Kolkata', 'System timezone for auto checkout'),
('last_auto_checkout_run', '', 'Last time auto checkout was executed')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);

-- Sample rooms data
INSERT INTO rooms (room_number, room_type, status) VALUES
('101', 'Standard', 'available'),
('102', 'Standard', 'available'),
('103', 'Deluxe', 'available'),
('104', 'Deluxe', 'available'),
('105', 'Suite', 'available'),
('201', 'Standard', 'available'),
('202', 'Standard', 'available'),
('203', 'Deluxe', 'available'),
('204', 'Deluxe', 'available'),
('205', 'Suite', 'available')
ON DUPLICATE KEY UPDATE room_type = VALUES(room_type);