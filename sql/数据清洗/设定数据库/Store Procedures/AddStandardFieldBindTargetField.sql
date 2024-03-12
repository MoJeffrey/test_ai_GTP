DROP procedure IF EXISTS `AddStandardFieldBindTargetField`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `AddStandardFieldBindTargetField`(
    p_standardTableBindTargetTableId INT,
    parameters_json JSON
)
/**
    code = 0 = OK
 */
label:BEGIN
    DECLARE v_target_database VARCHAR(200) DEFAULT (SELECT GetTargetDatabase());
    DECLARE v_errorMsg VARCHAR(200);
    DECLARE parameter_value VARCHAR(400);
    DECLARE v_standardField VARCHAR(200);
    DECLARE v_targetField VARCHAR(200);
    DECLARE key_count INT DEFAULT (SELECT json_length(parameters_json));
    DECLARE v_standardTableId INT;
    DECLARE v_targetTableId INT;
    DECLARE v_targetTableName VARCHAR(200);
    DECLARE v_standardFieldId INT;
    DECLARE i INT DEFAULT 0;

    -- 獲取目標表和標準表ID
    SELECT
        standardTableId,
        TT.targetTableId,
        TT.name
    INTO
        v_standardTableId,
        v_targetTableId,
        v_targetTableName
    FROM standardTableBindTargetTable AS STBTT
    INNER JOIN targetTable AS TT ON STBTT.targetTableId = TT.targetTableId
    WHERE standardTableBindTargetTableId = p_standardTableBindTargetTableId;

    -- 獲取目標表中的COLUMN_NAME
    DROP TEMPORARY TABLE IF EXISTS AddStandardFieldBindTargetField_targetTableField;
    CREATE TEMPORARY TABLE AddStandardFieldBindTargetField_targetTableField
    SELECT
        COLUMN_NAME AS COLUMN_COMMENT
    FROM
        INFORMATION_SCHEMA.COLUMNS
    WHERE
        TABLE_SCHEMA = v_target_database
    AND
        TABLE_NAME = v_targetTableName;

    DELETE FROM standardFieldBindTargetField WHERE standardTableBindTargetTableId = p_standardTableBindTargetTableId;

    WHILE i < key_count DO
        SET parameter_value = JSON_UNQUOTE(JSON_EXTRACT(parameters_json, CONCAT('$."', i, '"')));
        SET v_targetField = SUBSTRING_INDEX(parameter_value, '->', 1);
        SET v_standardField = SUBSTRING_INDEX(parameter_value, '->', -1);

        SELECT GetStandardFieldId(v_standardTableId, v_standardField) INTO v_standardFieldId;

        IF v_targetField != 'NULL' THEN
            -- 判斷是否有該Field
            IF EXISTS(SELECT COLUMN_COMMENT FROM AddStandardFieldBindTargetField_targetTableField WHERE COLUMN_COMMENT = v_targetField) IS NULL THEN
                SET v_errorMsg := CONCAT('該目標字段不存在: ', v_targetField);
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = v_errorMsg;
            END IF;
        END IF;

        INSERT INTO standardFieldBindTargetField (standardTableBindTargetTableId, standardFieldName, targetFieldName)
        VALUE (p_standardTableBindTargetTableId, v_standardField, v_targetField);

        -- 增加索引
        SET i = i + 1;
    END WHILE;

    COMMIT ;
    SELECT 0 AS code;
END ;;
DELIMITER ;