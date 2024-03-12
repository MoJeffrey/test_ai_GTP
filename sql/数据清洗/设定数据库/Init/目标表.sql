CREATE TABLE IF NOT EXISTS `targetTable`(
   `targetTableId` INT AUTO_INCREMENT PRIMARY KEY,
   `name` VARCHAR(200) NOT NULL UNIQUE,
   `nickName` VARCHAR(200),
   `interpretation` LONGTEXT
);
