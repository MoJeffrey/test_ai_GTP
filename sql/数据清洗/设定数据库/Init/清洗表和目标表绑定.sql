CREATE TABLE IF NOT EXISTS `standardTableBindTargetTable`(
   `standardTableBindTargetTableId` INT AUTO_INCREMENT PRIMARY KEY,
   `standardTableId` INT NOT NULL,
   `targetTableId` INT NOT NULL
);
