DROP FUNCTION IF EXISTS `GetStandardFieldId`;
DELIMITER ;
DELIMITER ;;
CREATE FUNCTION
    GetStandardFieldId(
        p_standardTableId INT,
        p_standardFieldName VARCHAR(200)
    )
    RETURNS VARCHAR(200)
    DETERMINISTIC
BEGIN
    DECLARE v_standardFieldId INT;
    DECLARE v_errorMsg VARCHAR(200);

    SELECT
        SF.standardFieldId
    INTO
        v_standardFieldId
    FROM tableBindField AS TBF
    INNER JOIN standardField AS SF ON TBF.standardFieldId = SF.standardFieldId
    WHERE TBF.standardTableId = p_standardTableId AND SF.fieldName = p_standardFieldName;

    IF v_standardFieldId IS NULL THEN
        SET v_errorMsg := CONCAT('該標準字段不存在: ', p_standardFieldName);
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_errorMsg;
    END IF;

    RETURN v_standardFieldId;
End;;
DELIMITER ;