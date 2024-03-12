DROP procedure IF EXISTS `GetTargetTableName`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `GetTargetTableName`()
/**

 */
label:BEGIN
    DECLARE v_target_database VARCHAR(200);


    SELECT
        value
    INTO
        v_target_database
    FROM clean_setting WHERE `key` = 'target_database';

    IF v_target_database IS NULL THEN
        SELECT '未配置目标数据库' AS msg, 500 AS 'code';
        LEAVE label;
    END IF ;

    SELECT table_name AS table_name
    FROM information_schema.tables
    WHERE table_schema = v_target_database;


END ;;
DELIMITER ;