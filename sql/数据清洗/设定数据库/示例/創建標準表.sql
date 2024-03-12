-- 獲取 關於info 的標準表
CALL GetStandardTableList('人,info,设备');


-- 獲取標準表 person_info
CALL GetStandardTable(1);


-- 創建標準表
CALL Run_CreateStandardTable(1);


-- 添加標準協議
CALL CreateStandardAgreement('智建公司内部標準', '表數據來源標準', 'ZJ_1');

-- 添加標準字段
CALL CreateStandardField('age', 'INT', NULL, NULL, '年齡', '人年齡', NULL, '3');

-- 綁定該Field
CALL AddTableBindField(1, 5);

-- 清除建立的標準表
CALL Run_DropStandardTable(1);

-- 再次建立
CALL Run_CreateStandardTable(1);
