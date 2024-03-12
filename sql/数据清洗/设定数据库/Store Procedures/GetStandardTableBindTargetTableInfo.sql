DROP procedure IF EXISTS `GetStandardTableBindTargetTableInfo`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `GetStandardTableBindTargetTableInfo`(
    p_standardTableBindTargetTableId INT
)
/**
    code = 0 = OK
 */
label:BEGIN
    SELECT
        TT.name AS targetTable,
        ST.name AS standardTable
    FROM standardTableBindTargetTable AS STBTT
    INNER JOIN targetTable AS TT ON STBTT.targetTableId = TT.targetTableId
    INNER JOIN standardTable AS ST ON STBTT.standardTableId = ST.standardTableId
    WHERE standardTableBindTargetTableId = p_standardTableBindTargetTableId;

    SELECT
        CONCAT(targetFieldName, '->', standardFieldName) AS `Change`
    FROM standardFieldBindTargetField WHERE standardTableBindTargetTableId = p_standardTableBindTargetTableId;
END ;;
DELIMITER ;