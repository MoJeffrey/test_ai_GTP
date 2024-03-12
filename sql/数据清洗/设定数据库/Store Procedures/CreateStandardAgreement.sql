DROP procedure IF EXISTS `CreateStandardAgreement`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `CreateStandardAgreement`(
    p_title VARCHAR(200),
    p_name VARCHAR(200),
    p_code VARCHAR(200)
)
/**

 */
label:BEGIN
    DECLARE v_standardAgreementId BIGINT DEFAULT (SELECT MAX(standardAgreementId) + 1 FROM standardAgreement);
    INSERT INTO standardAgreement (standardAgreementId, title, name, code, standardType)
    VALUE (v_standardAgreementId, p_title, p_name, IF(p_code IS NULL, v_standardAgreementId, p_code), 2);

    COMMIT ;
    SELECT 0 AS code, v_standardAgreementId AS standardAgreementId;
END ;;
DELIMITER ;