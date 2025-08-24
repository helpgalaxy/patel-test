# Hotel Management System with Auto Checkout

A comprehensive hotel room management system with automatic daily checkout functionality.

## Features

- **Daily 10AM Auto Checkout**: Automatically checks out all occupied rooms at 10:00 AM
- **Room Management**: Check-in, manual checkout, room status tracking
- **Guest Information**: Store guest details, contact information
- **Auto Checkout Logs**: Complete logging of all automatic checkout operations
- **Manual Override**: Admin can manually trigger checkout process
- **Responsive Design**: Works on desktop and mobile devices

## Auto Checkout System

### How it Works
1. **Automatic Execution**: System automatically checks out all occupied rooms at 10:00 AM daily
2. **Room Status Update**: Changes room status from 'occupied' to 'cleaning'
3. **Guest Data Cleanup**: Removes guest information after checkout
4. **Comprehensive Logging**: Records all checkout operations with timestamps
5. **Error Handling**: Logs failed checkouts and continues with other rooms

### Setup Instructions

#### 1. Database Setup
```sql
-- Import the database schema
mysql -u username -p database_name < sql/database_setup.sql
```

#### 2. Environment Configuration
```bash
# Copy and configure environment file
cp .env.example .env
# Edit .env with your database credentials
```

#### 3. Cron Job Setup (Required for Auto Checkout)

**For Hostinger or cPanel hosting:**
1. Go to cPanel → Cron Jobs
2. Add new cron job with this command:
```bash
*/5 * * * * /usr/bin/php /path/to/your/project/cron/auto_checkout_cron.php
```

**For VPS/Dedicated servers:**
```bash
# Edit crontab
crontab -e

# Add this line for every 5 minutes check
*/5 * * * * /usr/bin/php /path/to/your/project/cron/auto_checkout_cron.php

# Or for every minute (more precise)
* * * * * /usr/bin/php /path/to/your/project/cron/auto_checkout_cron.php
```

#### 4. File Permissions
```bash
# Make sure logs directory is writable
chmod 755 logs/
chmod 644 logs/.gitkeep
```

## Database Compatibility

This system is designed to work with any MySQL hosting provider:

- **Hostinger**: Fully compatible
- **cPanel hosting**: Fully compatible  
- **AWS RDS**: Compatible
- **Google Cloud SQL**: Compatible
- **Any MySQL 5.7+ server**: Compatible

### Database Configuration
The system uses environment variables for database connection, making it easy to deploy on any hosting provider:

```php
$host = $_ENV['DB_HOST'] ?? 'localhost';
$dbname = $_ENV['DB_NAME'] ?? 'hotel_management';  
$username = $_ENV['DB_USERNAME'] ?? 'root';
$password = $_ENV['DB_PASSWORD'] ?? '';
```

## File Structure

```
hotel-management/
├── config/
│   └── database.php          # Database connection
├── includes/
│   └── auto_checkout.php     # Auto checkout logic
├── admin/
│   ├── rooms.php            # Room management interface
│   └── auto_checkout_logs.php # Checkout logs viewer
├── cron/
│   └── auto_checkout_cron.php # Cron job script
├── sql/
│   └── database_setup.sql    # Database schema
├── logs/
│   └── .gitkeep             # Log files directory
├── .env.example             # Environment template
└── README.md               # This file
```

## Usage

### Admin Interface
1. Access `admin/rooms.php` for room management
2. View all rooms with their current status
3. Check-in guests with their information
4. Manual checkout if needed
5. View auto checkout logs

### Auto Checkout Features
- **Visual Notices**: Clear indication that auto checkout is active
- **Manual Trigger**: Admin can manually run checkout process
- **Comprehensive Logging**: All operations are logged with details
- **Error Recovery**: System continues even if some rooms fail to checkout

### Room Status Flow
1. **Available** → Guest checks in → **Occupied**
2. **Occupied** → Auto checkout at 10AM → **Cleaning**  
3. **Cleaning** → Admin marks clean → **Available**

## Customization

### Change Auto Checkout Time
Update the system settings in database:
```sql
UPDATE system_settings 
SET setting_value = '11:00' 
WHERE setting_key = 'auto_checkout_time';
```

### Disable Auto Checkout for Specific Rooms
```sql
UPDATE rooms 
SET auto_checkout_enabled = 0 
WHERE room_number = '101';
```

### Change Timezone
```sql
UPDATE system_settings 
SET setting_value = 'America/New_York' 
WHERE setting_key = 'timezone';
```

## Troubleshooting

### Auto Checkout Not Working
1. Check if cron job is properly configured
2. Verify file permissions on cron script
3. Check logs in `logs/auto_checkout.log`
4. Ensure database connection is working

### Manual Testing
You can manually test the auto checkout system:
```bash
# Run from command line
php cron/auto_checkout_cron.php

# Or via browser (for testing only)
http://yoursite.com/cron/auto_checkout_cron.php?manual_run=1
```

## Security Notes

- Cron script prevents direct browser access (except with manual_run parameter)
- All database operations use prepared statements
- Input validation on all forms
- Error logging without exposing sensitive information

## Support

For issues or questions:
1. Check the auto checkout logs
2. Verify cron job configuration  
3. Test database connectivity
4. Review file permissions

The system is designed to be robust and continue operating even if individual components fail.