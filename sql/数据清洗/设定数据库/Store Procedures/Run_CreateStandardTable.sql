DROP procedure IF EXISTS `Run_CreateStandardTable`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `Run_CreateStandardTable`(
    p_standardTableId INT
)
/**
    code = 0 = OK
    code = 1 = 該Table已存在
 */
label:BEGIN
    DECLARE v_pre_cleaning_prefix VARCHAR(200) DEFAULT (SELECT value FROM clean_setting WHERE `key` = 'pre_cleaning_prefix');
    DECLARE v_tempSQL VARCHAR(9000);
    DECLARE v_tableName VARCHAR(202);
    DECLARE v_preCleaningTableName VARCHAR(402);
    DECLARE v_tableComment LONGTEXT;
    DECLARE v_fieldSQL VARCHAR(9000);

    DECLARE table_already_exists CONDITION FOR SQLSTATE '42S01'; -- 错误码 1050
    DECLARE EXIT HANDLER FOR table_already_exists
    BEGIN
        SELECT 1 AS code;
    END;

    SET v_pre_cleaning_prefix := IF(v_pre_cleaning_prefix IS NULL, '_', CONCAT(v_pre_cleaning_prefix, '_'));

    SELECT
        name,
        interpretation
    INTO
        v_tableName,
        v_tableComment
    FROM standardTable
    WHERE standardTableId = p_standardTableId;

    SET v_preCleaningTableName := CONCAT('`', v_pre_cleaning_prefix, v_tableName, '`');
    SET v_tableName := CONCAT('`', v_tableName, '`');

    -- Field 處理
    CREATE TEMPORARY TABLE CreateStandardTable_field
    SELECT
        CONCAT('`', SF.fieldName, '`') AS fieldName,
        CONCAT(fieldType, IF(fieldLength IS NULL, '', CONCAT('(', SF.fieldLength, ')'))) AS fieldType,
        CONCAT(SF.nickName, ' [', SA.title, ' ', SA.name, ']', '(', SF.standardNumber, '): ', SF.interpretation) AS COMMENT
    FROM tableBindField AS TBF
    INNER JOIN standardField AS SF ON TBF.standardFieldId = SF.standardFieldId
    INNER JOIN standardAgreement AS SA ON SF.standardAgreementId = SA.standardAgreementId
    WHERE standardTableId = p_standardTableId;

    SELECT
        GROUP_CONCAT(CONCAT(fieldName, ' ', fieldType, ' COMMENT \'', COMMENT, '\'') SEPARATOR ', ')
    INTO
        v_fieldSQL
    FROM CreateStandardTable_field;
    DROP TEMPORARY TABLE CreateStandardTable_field;

    SET v_tempSQL := CONCAT('CREATE TABLE ', v_tableName, ' (', v_fieldSQL, ') COMMENT \'', v_tableComment, '\';');
    SET @v_test := v_tempSQL;
    PREPARE stmt FROM @v_test;
	execute stmt;
	DEALLOCATE PREPARE stmt;

    SET v_tempSQL := CONCAT('CREATE TABLE ', v_preCleaningTableName, ' (', v_fieldSQL, ') COMMENT \'', v_tableComment, '\';');
    SET @v_test := v_tempSQL;
    PREPARE stmt FROM @v_test;
	execute stmt;
	DEALLOCATE PREPARE stmt;

    SELECT 0 AS code;
END ;;
DELIMITER ;