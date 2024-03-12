CREATE TABLE IF NOT EXISTS `standardField`(
   `standardFieldId` INT AUTO_INCREMENT PRIMARY KEY,
   `fieldName` VARCHAR(200) NOT NULL,
   `fieldType` VARCHAR(30) NOT NULL,
   `fieldLength` INT,
   `standardEnumGroup` INT,
   `nickName` VARCHAR(200) NOT NULL,
   `interpretation` LONGTEXT NOT NULL,
   `standardNumber` VARCHAR(200) NOT NULL COMMENT '标准编号',
   `standardAgreementId` INT NOT NULL COMMENT '标准协议ID'
);

INSERT INTO standardField (standardFieldId, fieldName, fieldType, fieldLength, standardEnumGroup, nickName, interpretation, standardNumber, standardAgreementId) VALUES
(1, 'XM', 'VARCHAR', '36', NULL, '姓名', '例如: 张振华；买买提·阿不都热依木', 'JCTB020101', 1),
(2, 'DH', 'VARCHAR', '30', NULL, '电话', '即电话号码', 'JCTB010103', 1),
(3, 'XBM', 'VARCHAR', '1', 1, '性别码', '性别', 'JCTB020105', 1);