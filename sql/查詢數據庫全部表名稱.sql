SELECT GROUP_CONCAT(table_name SEPARATOR ', ') AS table_names
FROM information_schema.tables
WHERE table_schema = 'mysqldemo';
