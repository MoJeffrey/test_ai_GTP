import docker

# 创建 Docker 客户端
client = docker.from_env()

# 定义容器的配置
container_config = {
    'image': 'my-python-app',
    'detach': True,  # 在后台运行
    'name': 'my-python-app-jeffrey'  # 指定容器的名称
}

# 使用 create 方法创建容器
new_container = client.containers.create(**container_config)

# 启动容器
new_container.start()

# 打印容器的 ID
print(f"New container ID: {new_container.id}")