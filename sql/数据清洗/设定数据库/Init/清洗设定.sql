CREATE TABLE IF NOT EXISTS `clean_setting`(
   `clean_setting_id` INT AUTO_INCREMENT PRIMARY KEY,
   `key` VARCHAR(200) NOT NULL UNIQUE,
   `value` VARCHAR(200) NOT NULL,
   KEY `clean_key` (`key`)
);

INSERT IGNORE INTO clean_setting (clean_setting_id, `key`, value) VALUES
(1, 'target_database', 'zqic_stage'),
(2, 'pre_cleaning_prefix', 'pre_cleaning');