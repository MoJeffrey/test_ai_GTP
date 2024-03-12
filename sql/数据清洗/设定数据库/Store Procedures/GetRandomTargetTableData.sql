DROP procedure IF EXISTS `GetRandomTargetTableData`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `GetRandomTargetTableData`(
    p_tabelName VARCHAR(50),
    p_LIMIT INT
)
/**

 */
label:BEGIN
    DECLARE v_tempSQL VARCHAR(9000);
    DECLARE v_target_database VARCHAR(200) DEFAULT (SELECT GetTargetDatabase());
    DECLARE v_targetTableCOLUMN_KEY_Name VARCHAR(200);

    -- 獲取主鍵
    SELECT GetPrimaryFieldName(v_target_database, p_tabelName) INTO v_targetTableCOLUMN_KEY_Name;

    SET v_tempSQL := CONCAT('SELECT * FROM ', v_target_database, '.', p_tabelName);
    SET v_tempSQL := CONCAT(v_tempSQL, ' WHERE ', v_targetTableCOLUMN_KEY_Name, ' >= (SELECT FLOOR(MAX(', v_targetTableCOLUMN_KEY_Name);
    SET v_tempSQL := CONCAT(v_tempSQL, ' ) * RAND()) FROM ', v_target_database, '.', p_tabelName, ' )');
    SET v_tempSQL := CONCAT(v_tempSQL, ' ORDER BY ', v_targetTableCOLUMN_KEY_Name, ' LIMIT ', p_LIMIT, ';');
    SET @v_test := v_tempSQL;
    PREPARE stmt FROM @v_test;
	execute stmt;
	DEALLOCATE PREPARE stmt;

END ;;
DELIMITER ;