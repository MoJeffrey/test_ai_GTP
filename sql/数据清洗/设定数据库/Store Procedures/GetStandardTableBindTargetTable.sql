DROP procedure IF EXISTS `GetStandardTableBindTargetTable`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `GetStandardTableBindTargetTable`(
    p_standardTableBindTargetTableId INT
)
/**
    code = 0 = OK
    code = 9 = 目标表不存在
 */
label:BEGIN
    DECLARE v_standardTableId INT;
    DECLARE v_targetTableId INT;

    SELECT
        standardTableId,
        targetTableId
    INTO
        v_standardTableId,
        v_targetTableId
    FROM standardTableBindTargetTable WHERE standardTableBindTargetTableId = p_standardTableBindTargetTableId;
    CALL GetStandardTable(v_standardTableId);

    SELECT 0 AS code;
END ;;
DELIMITER ;