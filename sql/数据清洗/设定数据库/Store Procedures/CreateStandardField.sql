DROP procedure IF EXISTS `CreateStandardField`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `CreateStandardField`(
    p_fieldName VARCHAR(200),
    p_fieldType VARCHAR(30),
    p_fieldLength INT,
    p_standardEnumGroup INT,
    p_nickName VARCHAR(200),
    p_interpretation LONGTEXT,
    p_standardNumber VARCHAR(200),
    p_standardAgreementId INT
)
label:BEGIN
    DECLARE v_standardFieldId BIGINT DEFAULT (SELECT MAX(standardFieldId) + 1 FROM standardField);
    DECLARE v_standardAgreementId INT;
    DECLARE v_standardType VARCHAR(2);

    SELECT
        standardAgreementId,
        standardType
    INTO
        v_standardAgreementId,
        v_standardType
    FROM standardAgreement WHERE standardAgreementId = p_standardAgreementId;

    IF v_standardAgreementId IS NULL THEN
        SELECT 2 AS code;
        LEAVE label;
    END IF;

    -- 國家協議不可修改
    IF v_standardType = '1' THEN
        SELECT 3 AS code;
        LEAVE label;
    END IF;

    INSERT INTO standardField (
        standardFieldId, fieldName, fieldType, fieldLength,
        standardEnumGroup, nickName, interpretation,
        standardNumber, standardAgreementId
    ) VALUE (
        v_standardFieldId, p_fieldName, p_fieldType, p_fieldLength,
        p_standardEnumGroup, p_nickName, p_interpretation,
        IF(p_standardNumber IS NULL, v_standardFieldId, p_standardNumber), v_standardAgreementId
    );

    SELECT 0 AS code, v_standardFieldId AS standardFieldId;
    COMMIT ;
END