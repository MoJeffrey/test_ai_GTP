CREATE TABLE IF NOT EXISTS `standardEnumGroup`(
   `standardEnumGroupId` INT AUTO_INCREMENT PRIMARY KEY,
   `title` VARCHAR(200) NOT NULL,
   `name` VARCHAR(200) NOT NULL,
   `code` VARCHAR(200) NOT NULL COMMENT '标准代号',
   `standardType` VARCHAR(2) NOT NULL COMMENT '1: 国家标准, 2: 自定义标准'
);


INSERT INTO standardEnumGroup (standardEnumGroupId, title, name, code, standardType) VALUES
(1, '中华人民共和国国家标准', '个人基本信息分类与代码第1部分：人的性别代码', 'GB/T 2261．1-2003', '1');