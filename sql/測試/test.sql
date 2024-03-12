DELIMITER //
DROP procedure IF EXISTS `PROCEDURE_B`;
CREATE PROCEDURE PROCEDURE_B(IN parameters_json JSON)
BEGIN
    DECLARE parameter_value INT;
    DECLARE parameter_key VARCHAR(255);

    -- 遍历 JSON 对象的键值对
    WHILE JSON_VALID(parameters_json) DO
        SET parameter_key = JSON_UNQUOTE(JSON_KEYS(parameters_json));
        SELECT parameter_key;
#         SET parameter_value = CAST(JSON_UNQUOTE(JSON_EXTRACT(parameters_json, CONCAT('$.', parameter_key))) AS SIGNED);
#
#         -- 在这里处理参数值，例如输出或插入到表中
#         SELECT parameter_key, parameter_value;
#
#         -- 移除处理过的键值对
        SET parameters_json = JSON_REMOVE(parameters_json, CONCAT('$.', parameter_key));
    END WHILE;
END //

DELIMITER ;
