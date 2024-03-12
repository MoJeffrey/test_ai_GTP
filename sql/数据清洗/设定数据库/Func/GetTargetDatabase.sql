DROP FUNCTION IF EXISTS `GetTargetDatabase`;
DELIMITER ;
DELIMITER ;;
CREATE FUNCTION
    GetTargetDatabase()
    RETURNS VARCHAR(200)
    DETERMINISTIC
BEGIN
    DECLARE v_target_database VARCHAR(200);

    SELECT
        value
    INTO
        v_target_database
    FROM clean_setting WHERE `key` = 'target_database';

    IF v_target_database IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '未配置目标数据库';
    END IF;

    RETURN v_target_database;
End;;
DELIMITER ;