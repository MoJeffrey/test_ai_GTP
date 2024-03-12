DROP procedure IF EXISTS `UpdateTargetTable`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `UpdateTargetTable`()
/**
    code = 0 = OK
 */
label:BEGIN
    DECLARE v_target_database VARCHAR(200) DEFAULT (SELECT GetTargetDatabase());

    -- 检查目标表
    INSERT IGNORE INTO targetTable (name, nickName, interpretation)
    SELECT TABLE_NAME, TABLE_NAME, TABLE_COMMENT
    FROM information_schema.tables
    WHERE table_schema = v_target_database;


    SELECT 0 AS code;
END ;;
DELIMITER ;