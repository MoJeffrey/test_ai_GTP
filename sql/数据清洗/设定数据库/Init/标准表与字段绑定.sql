CREATE TABLE IF NOT EXISTS `tableBindField`(
   `tableBindFieldId` INT AUTO_INCREMENT PRIMARY KEY,
   `standardTableId` INT NOT NULL,
   `standardFieldId` INT NOT NULL
);

INSERT INTO tableBindField (tableBindFieldId, standardTableId, standardFieldId) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3);