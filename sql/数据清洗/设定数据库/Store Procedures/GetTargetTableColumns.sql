DROP procedure IF EXISTS `GetTargetTableColumns`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `GetTargetTableColumns`(
    p_tabelName VARCHAR(50)
)
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

    SELECT
        COLUMN_NAME AS conlumn_name,
        DATA_TYPE AS data_type,
        CHARACTER_MAXIMUM_LENGTH AS character_maximum_length
    FROM
        INFORMATION_SCHEMA.COLUMNS
    WHERE
        TABLE_SCHEMA = v_target_database
    AND
        TABLE_NAME = p_tabelName;

END ;;
DELIMITER ;