DROP procedure IF EXISTS `GetTargetTableInfo`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `GetTargetTableInfo`(
    p_tabelName VARCHAR(50)
)
/**

 */
label:BEGIN
    DECLARE v_target_database VARCHAR(200) DEFAULT (SELECT GetTargetDatabase());


    SELECT
        COLUMN_NAME AS conlumn_name,
        DATA_TYPE AS data_type,
        CHARACTER_MAXIMUM_LENGTH AS character_maximum_length,
        COLUMN_COMMENT AS COLUMN_COMMENT
    FROM
        INFORMATION_SCHEMA.COLUMNS
    WHERE
        TABLE_SCHEMA = v_target_database
    AND
        TABLE_NAME = p_tabelName;

END ;;
DELIMITER ;