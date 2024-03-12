CREATE TABLE IF NOT EXISTS `standardFieldBindTargetField`(
   `standardFieldBindTargetFieldId` INT AUTO_INCREMENT PRIMARY KEY,
   `standardTableBindTargetTableId` INT NOT NULL,
   `standardFieldName` VARCHAR(200) NOT NULL,
   `targetFieldName` VARCHAR(200) NOT NULL
);
