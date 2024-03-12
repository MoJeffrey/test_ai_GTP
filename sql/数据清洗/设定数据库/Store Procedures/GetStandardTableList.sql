DROP procedure IF EXISTS `GetStandardTableList`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `GetStandardTableList`(
    p_KeyList LONGTEXT
)
/**

 */
label:BEGIN
    DECLARE v_KeyListNum INT(10);
    DECLARE v_NowKeyListNum INT(10) DEFAULT 0;
    DECLARE v_Key VARCHAR(200) DEFAULT NULL;
    SET v_KeyListNum = LENGTH(p_KeyList)-LENGTH(REPLACE(p_KeyList,',',''));

    CREATE TEMPORARY TABLE GetStandardTables_Keys (
        `key` VARCHAR(200) PRIMARY KEY
    );

    REPEAT
        SET v_Key = SUBSTRING_INDEX(SUBSTRING_INDEX(p_KeyList, ',', v_NowKeyListNum + 1), ',', -1);
        SET v_NowKeyListNum = v_NowKeyListNum + 1;

        INSERT IGNORE INTO GetStandardTables_Keys (`key`)
        VALUE (v_Key);

    UNTIL v_NowKeyListNum>v_KeyListNum END REPEAT;

    SELECT
        standardTableId,
        name,
        nickName,
        interpretation,
        IF(standardType = 1, '国家标准', '自定义标准') AS source
    FROM standardTable AS ST
    INNER JOIN GetStandardTables_Keys AS GSTK ON ST.name LIKE CONCAT('%', GSTK.`key`, '%') OR ST.interpretation LIKE CONCAT('%', GSTK.`key`, '%');
    DROP TEMPORARY TABLE GetStandardTables_Keys;
END ;;
DELIMITER ;