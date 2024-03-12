CREATE TABLE IF NOT EXISTS `standardTable`(
   `standardTableId` INT AUTO_INCREMENT PRIMARY KEY,
   `name` VARCHAR(200) NOT NULL,
   `nickName` VARCHAR(200) NOT NULL,
   `interpretation` LONGTEXT NOT NULL,
   `standardType` VARCHAR(2) NOT NULL COMMENT '1: 国家标准, 2: 自定义标准'
);

INSERT INTO standardTable (standardTableId, name, nickName, interpretation, standardType) VALUES
(1, 'person_info', '人员表', '主要用于统计系统的人员。', '2'),
(2, 'device_info', '设备表', '主要用于统计系统的设备。', '2');