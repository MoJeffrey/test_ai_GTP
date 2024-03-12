# 使用 Flask 框架的簡單範例
import ast
from flask import Flask, request, jsonify
import docker

app = Flask(__name__)

# 创建 Docker 客户端
client = docker.from_env()


@app.route('/server', methods=['POST'])
def server():
    # 在這裡處理從上端API接收到的任務
    data = request.get_json()

    cmd: str = data['cmd']
    if "CMD" not in cmd:
        return jsonify({'error': '错误的指令！'})

    cmd = cmd.replace("CMD ", '')

    o = CMD(cmd)
    return {'status': 'success', "msg": o}


def CMD(cmd):
    container = client.containers.get('9152c483b1bc5f7cd2ded60626d188eeddfb0c38ccf069312ca971117fe25eb1')
    # 要在容器中運行的命令
    command = f"python main.py {cmd}"
    # 使用 exec_run 運行命令
    exec_result = container.exec_run(command)

    # 獲取命令的輸出
    output: str = exec_result.output.decode('utf-8')

    return output


if __name__ == '__main__':
    app.run(debug=True)
