DROP procedure IF EXISTS `AddTableBindField`;
DELIMITER ;
DELIMITER ;;
CREATE PROCEDURE `AddTableBindField`(
    p_standardTableId INT,
    p_standardFieldId INT
)
/**
    code = 0 = OK
    code = 4 = 該Table不存在
    code = 3 = 該協議不可修改(國家協議)
    code = 5 = 該Tabel已經綁定給該Filed
 */
label:BEGIN
    DECLARE v_tableBindFieldId BIGINT DEFAULT (SELECT MAX(tableBindFieldId) + 1 FROM tableBindField);
    DECLARE v_standardTableId INT;
    DECLARE v_standardType VARCHAR(2);

    SELECT
        standardTableId,
        standardType
    INTO
        v_standardTableId,
        v_standardType
    FROM standardTable WHERE standardTableId = p_standardTableId;

    IF v_standardTableId IS NULL THEN
        SELECT 4 AS code;
        LEAVE label;
    END IF;

    -- 國家協議不可修改
    IF v_standardType = '1' THEN
        SELECT 3 AS code;
        LEAVE label;
    END IF;

    IF EXISTS(SELECT tableBindFieldId FROM `tableBindField` WHERE standardTableId = p_standardTableId AND standardFieldId = p_standardFieldId) THEN
        SELECT 5 AS code;
        LEAVE label;
    END IF ;

    INSERT INTO tableBindField (tableBindFieldId, standardTableId, standardFieldId)
    VALUE (v_tableBindFieldId, p_standardTableId, p_standardFieldId);

    SELECT 0 AS code;

    COMMIT;
END ;;
DELIMITER ;