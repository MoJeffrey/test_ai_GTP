DROP procedure IF EXISTS `GetPreview`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `GetPreview`(
    p_standardTableBindTargetTableId INT,
    p_LIMIT INT
)
/**

 */
label:BEGIN
    DECLARE v_tempSQL VARCHAR(9000);
    DECLARE v_target_database VARCHAR(200) DEFAULT (SELECT GetTargetDatabase());
    DECLARE v_standardTableId INT;
    DECLARE v_targetTableId INT;
    DECLARE v_targetTableName VARCHAR(200);
    DECLARE v_targetTableCOLUMN_KEY_Name VARCHAR(200);
    DECLARE v_standardTableName VARCHAR(200);
    DECLARE v_standardFieldNameList LONGTEXT;
    DECLARE v_targetFieldNameList LONGTEXT;

    -- 獲取目標表和標準表ID
    SELECT
        ST.standardTableId,
        TT.targetTableId,
        TT.name,
        ST.name
    INTO
        v_standardTableId,
        v_targetTableId,
        v_targetTableName,
        v_standardTableName
    FROM standardTableBindTargetTable AS STBTT
    INNER JOIN targetTable AS TT ON STBTT.targetTableId = TT.targetTableId
    INNER JOIN standardTable AS ST ON STBTT.standardTableId = ST.standardTableId
    WHERE standardTableBindTargetTableId = p_standardTableBindTargetTableId;

    -- 獲取主鍵
    SELECT GetPrimaryFieldName(v_target_database, v_targetTableName) INTO v_targetTableCOLUMN_KEY_Name;

    DROP TEMPORARY TABLE IF EXISTS Table_Preview;

    SET v_tempSQL := CONCAT('CREATE TEMPORARY TABLE Table_Preview SELECT * FROM ', v_standardTableName, ';');
    SET @v_test := v_tempSQL;
    PREPARE stmt FROM @v_test;
	execute stmt;
	DEALLOCATE PREPARE stmt;

    SELECT
        GROUP_CONCAT(CONCAT('`', standardFieldName, '`')),
        GROUP_CONCAT(
            CASE
                WHEN targetFieldName = 'null' THEN 'NULL'
                WHEN targetFieldName = 'TargetTabelName' THEN CONCAT('"', v_targetTableName, '"')
                ELSE CONCAT('`', targetFieldName, '`')
            END
        )
    INTO
        v_standardFieldNameList,
        v_targetFieldNameList
    FROM standardFieldBindTargetField WHERE standardTableBindTargetTableId = p_standardTableBindTargetTableId;

    -- 插入值
    SET v_tempSQL := CONCAT('INSERT INTO Table_Preview (', v_standardFieldNameList, ' )');
    SET v_tempSQL := CONCAT(v_tempSQL, ' SELECT ', v_targetFieldNameList, ' FROM ', v_target_database, '.', v_targetTableName);
    SET v_tempSQL := CONCAT(v_tempSQL, ' WHERE ', v_targetTableCOLUMN_KEY_Name, ' >= (SELECT FLOOR(MAX(', v_targetTableCOLUMN_KEY_Name);
    SET v_tempSQL := CONCAT(v_tempSQL, ' ) * RAND()) FROM ', v_target_database, '.', v_targetTableName, ' )');
    SET v_tempSQL := CONCAT(v_tempSQL, ' ORDER BY ', v_targetTableCOLUMN_KEY_Name, ' LIMIT ', p_LIMIT, ';');
    SET @v_test := v_tempSQL;

    PREPARE stmt FROM @v_test;
	execute stmt;
	DEALLOCATE PREPARE stmt;

    -- 展示值
    SET v_tempSQL := CONCAT(' SELECT ', v_standardFieldNameList, ' FROM Table_Preview;');
    SET @v_test := v_tempSQL;
    PREPARE stmt FROM @v_test;
	execute stmt;
	DEALLOCATE PREPARE stmt;


    DROP TEMPORARY TABLE IF EXISTS Table_Preview;
END ;;
DELIMITER ;
