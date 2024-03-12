CREATE TABLE IF NOT EXISTS `standardEnum`(
   `standardEnumId` INT AUTO_INCREMENT PRIMARY KEY,
   `key` VARCHAR(200) NOT NULL,
   `value` VARCHAR(200) NOT NULL,
   `nickName` VARCHAR(200) NOT NULL,
   `standardEnumGroupId` INT NOT NULL
);


INSERT INTO standardEnum (standardEnumId, `key`, value, nickName, standardEnumGroupId) VALUES
(1, '0', '未知的性别', '未知的性别', 1),
(2, '1', '男性', '男性', 1),
(3, '2', '女性', '女性', 1),
(4, '9', '未说明的性别', '未说明的性别', 1);