import docker

# 從環境中創建 Docker 客戶端
client = docker.from_env()

# 列出所有運行中的容器
running_containers = client.containers.list()

# 輸出容器列表
for container in running_containers:
    print(f"Container ID: {container.id}, Name: {container.name}")

container = client.containers.get('7b78927a86701b92c5db48c793e22fbd677ff06dfdf1ad1bf598c05cf9d05c9c')

# 要在容器中運行的命令
command = "python runMysql.py 172.17.0.1 root 123456 sys"
# 使用 exec_run 運行命令
exec_result = container.exec_run(command)

# 獲取命令的輸出
output = exec_result.output.decode('utf-8')

print(f"Command output: {output}")