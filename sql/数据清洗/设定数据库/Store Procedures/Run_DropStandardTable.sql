DROP procedure IF EXISTS `Run_DropStandardTable`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `Run_DropStandardTable`(
    p_standardTableId INT
)
/**
    code = 0 = OK
 */
label:BEGIN
    DECLARE v_pre_cleaning_prefix VARCHAR(200) DEFAULT (SELECT value FROM clean_setting WHERE `key` = 'pre_cleaning_prefix');
    DECLARE v_tableName VARCHAR(202);
    DECLARE v_preCleaningTableName VARCHAR(402);
    DECLARE v_tempSQL VARCHAR(9000);

    SET v_pre_cleaning_prefix := IF(v_pre_cleaning_prefix IS NULL, '_', CONCAT(v_pre_cleaning_prefix, '_'));

    SELECT
        name
    INTO
        v_tableName
    FROM standardTable
    WHERE standardTableId = p_standardTableId;

    SET v_preCleaningTableName := CONCAT(v_pre_cleaning_prefix, v_tableName);

    DROP TABLE IF EXISTS v_tableName;
    DROP TABLE IF EXISTS v_preCleaningTableName;

    SET v_tempSQL := CONCAT('DROP TABLE IF EXISTS ', v_tableName, ';');
    SET @v_test := v_tempSQL;
    PREPARE stmt FROM @v_test;
	execute stmt;
	DEALLOCATE PREPARE stmt;

    SET v_tempSQL := CONCAT('DROP TABLE IF EXISTS ', v_preCleaningTableName, ';');
    SET @v_test := v_tempSQL;
    PREPARE stmt FROM @v_test;
	execute stmt;
	DEALLOCATE PREPARE stmt;

    SELECT 0 AS code;
END ;;
DELIMITER ;