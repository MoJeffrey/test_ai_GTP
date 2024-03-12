DROP procedure IF EXISTS `GetStandardTableInfo`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `GetStandardTableInfo`(
    p_standardTableId INT
)
/**

 */
label:BEGIN
    SELECT
        SF.nickName,
        SF.fieldName,
        SF.fieldType,
        SF.fieldLength,
        IF(SF.standardEnumGroup IS NULL, '無', SEG.name) AS '值枚舉',
        SF.standardNumber,
        SA.name AS standardAgreement,
        SF.interpretation
    FROM tableBindField AS TBF
    INNER JOIN standardField AS SF ON TBF.standardFieldId = SF.standardFieldId
    LEFT JOIN standardEnumGroup AS SEG ON SF.standardEnumGroup = SEG.standardEnumGroupId
    INNER JOIN standardAgreement AS SA ON SF.standardAgreementId = SA.standardAgreementId
    WHERE standardTableId = p_standardTableId;
END ;;
DELIMITER ;