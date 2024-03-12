DROP procedure IF EXISTS `AddStandardTableBindTargetTable`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `AddStandardTableBindTargetTable`(
    p_standardTableId INT,
    p_targetTableId INT
)
/**
    code = 0 = OK
 */
label:BEGIN
    DECLARE v_standardTableBindTargetTableId BIGINT DEFAULT (SELECT MAX(standardTableBindTargetTableId) + 1 FROM standardTableBindTargetTable);
    DECLARE v_target_database VARCHAR(200) DEFAULT (SELECT GetTargetDatabase());
    DECLARE v_target_conlumn_name LONGTEXT;
    DECLARE v_standard_conlumn_name LONGTEXT;

    IF EXISTS(SELECT standardTableBindTargetTableId FROM standardTableBindTargetTable WHERE standardTableId = p_standardTableId AND targetTableId = p_targetTableId) THEN

        SELECT standardTableBindTargetTableId INTO v_standardTableBindTargetTableId FROM standardTableBindTargetTable
        WHERE standardTableId = p_standardTableId AND targetTableId = p_targetTableId;
    ELSE
        INSERT INTO standardTableBindTargetTable (standardTableBindTargetTableId, standardTableId, targetTableId)
        VALUE (v_standardTableBindTargetTableId, p_standardTableId, p_targetTableId);

        COMMIT;
    END IF;

    -- 目标表
    SELECT
        GROUP_CONCAT(COLUMN_NAME SEPARATOR ', ')
    INTO
        v_target_conlumn_name
    FROM
        INFORMATION_SCHEMA.COLUMNS
    WHERE
        TABLE_SCHEMA = v_target_database
    AND
        TABLE_NAME = (SELECT name FROM targetTable WHERE targetTableId = p_targetTableId);

    -- 标准表
    SELECT
        GROUP_CONCAT(SF.fieldName SEPARATOR ',')
    INTO
        v_standard_conlumn_name
    FROM tableBindField AS TBF
    INNER JOIN standardField AS SF ON TBF.standardFieldId = SF.standardFieldId
    WHERE standardTableId = p_standardTableId;

    SELECT 0 AS code, v_standardTableBindTargetTableId AS standardTableBindTargetTableId, v_standard_conlumn_name AS '标准表字段', v_target_conlumn_name AS '目标表字段';

END ;;
DELIMITER ;