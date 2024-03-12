CREATE TABLE IF NOT EXISTS `standardAgreement`(
   `standardAgreementId` INT AUTO_INCREMENT PRIMARY KEY,
   `title` VARCHAR(200) NOT NULL,
   `name` VARCHAR(200) NOT NULL,
   `code` VARCHAR(200) NOT NULL COMMENT '标准代号',
   `standardType` VARCHAR(2) NOT NULL COMMENT '1: 国家标准, 2: 自定义标准'
);


INSERT INTO standardAgreement (standardAgreementId, title, name, code, standardType) VALUES
(1, '中华人民共和国教育行业标准', '教育管理信息 高等学校管理信息', 'JY/T 1006—201', '1'),
(2, '中华人民共和国教育行业标准', '教育管理信息 教育管理基础信息', 'JY/T 1002—201', '1');
