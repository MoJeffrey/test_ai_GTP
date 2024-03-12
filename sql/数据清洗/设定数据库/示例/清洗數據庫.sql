-- 更新目標表
CALL UpdateTargetTable();

-- 展示目標數據庫全部表
CALL GetTargetTableList();

-- 獲取目標數據庫的數據表資料
CALL GetTargetTableInfo('sys_user');
CALL GetStandardTable(1);

-- 绑定目标表和清洗表
CALL AddStandardTableBindTargetTable(1, 1);

-- 綁定清洗字段
CALL AddStandardFieldBindTargetField(1, '{
  "0": "user_name->XM",
  "1": "phonenumber->DH",
  "2": "sex->XBM"
}');

-- 檢查
CALL GetStandardTableBindTargetTableInfo(1);

-- 預覽
CALL GetPreview(1, 50);

-- 查看目標隨機數據
CALL GetRandomTargetTableData('sys_user', 50);


-- 修改綁定
CALL AddStandardFieldBindTargetField(1, '{
  "0": "nick_name->XM",
  "1": "phonenumber->DH",
  "2": "sex->XBM"
}');

-- 預覽
CALL GetPreview(1, 50);

