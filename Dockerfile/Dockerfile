# 使用官方 Python 3.8 镜像作为基础镜像
FROM python:3.8

# 设置工作目录
WORKDIR /app

# 将本地文件夹内容复制到容器中的 /app 目录
COPY . /app

# 安装所需的依赖
RUN pip install --upgrade pip
RUN pip install mysql-connector-python
RUN pip install pymysql
RUN pip install loguru
# RUN pip install -r requirements.txt  # 如果有 requirements.txt 文件的话

# 设置环境变量
ENV PATH="/app:${PATH}"

# 设置容器启动时执行的命令
CMD ["tail", "-f", "/dev/null"]