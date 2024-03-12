DROP procedure IF EXISTS `GetStandardAgreement`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `GetStandardAgreement`()
/**

 */
label:BEGIN
    SELECT standardAgreementId, title, name, code, IF(standardType = 1, '国家标准', '自定义标准') AS standardType FROM standardAgreement;
END ;;
DELIMITER ;