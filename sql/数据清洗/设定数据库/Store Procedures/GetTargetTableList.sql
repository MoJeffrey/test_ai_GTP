DROP procedure IF EXISTS `GetTargetTableList`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `GetTargetTableList`()
/**

 */
label:BEGIN
    SELECT
        targetTableId, name, nickName, interpretation
    FROM targetTable;


END ;;
DELIMITER ;