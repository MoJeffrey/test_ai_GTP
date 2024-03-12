import json
import time
import requests
from openAI import AI
from flask import Flask, render_template, request, jsonify
from flask_socketio import SocketIO, send, emit

app = Flask(__name__)
socketio = SocketIO(app)
socketio.init_app(app, cors_allowed_origins='*')

# 存储聊天内容的列表
ai = AI("thread_XF3fGmEtVfE6zy5rNxgvCYUj")

chat_history = ai.get_history_msg()
num = 0
for chat in chat_history:
    if 'CMD' in chat['text']:
        chat['text'] = f"执行： {chat['text']}"
    elif 'server' in chat['text']:
        chat['text'] = f"服务器： {chat['text']}"
    else:
        if num % 2 == 0:
            chat['text'] = f"我： {chat['text']}"
        else:
            chat['text'] = f"助手： {chat['text']}"
    num += 1

# WebSocket接口
@socketio.on('chatHistory')
def handle_connect():
    # 发送聊天历史记录给新连接的客户端
    emit('chatHistory', chat_history)


# 发信息
@socketio.on('sendMessage')
def handle_message(message):
    data = {"text": message, "timestamp": time.time()}
    chat_history.append(data)
    emit('message', {"text": f"我: {message}", "timestamp": time.time()})

    new_message = ai.send_msg(message)
    if "CMD" in new_message:
        CMDStringList = new_message.split("CMD")
        if len(CMDStringList[0]) > 0:
            emit('message', {"text": f"助手: {CMDStringList[0]}", "timestamp": time.time()})

        CMDStringList[1] = "CMD" + CMDStringList[1]
        emit('message', {"text": f"助手: 处理中，请稍后！", "timestamp": time.time()})
        emit('message', {"text": f"执行： {CMDStringList[1]}", "timestamp": time.time()})

        url = "http://127.0.0.1:5000/server"
        response = requests.post(url, json={"cmd": CMDStringList[1]})
        print(response.text)
        data = json.loads(response.text)
        print(data)
        emit('message', {"text": f"服务器： {data['msg']}", "timestamp": time.time()})
        new_message = ai.send_msg(data['msg'])
        emit('message', {"text": f"助手: {new_message}", "timestamp": time.time()})

    else:
        emit('message', {"text": f"助手: {new_message}", "timestamp": time.time()})


@app.route('/test', methods=['POST'])
def server():
    data = request.get_json()

    # 在這裡處理從上端API接收到的任務
    url = "http://127.0.0.1:5000/server"

    response = requests.post(url, json=data)

    return json.loads(response.text)


if __name__ == '__main__':
    # 启动应用程序并配置WebSocket
    socketio.run(app, debug=True, port=15001, log_output=True, allow_unsafe_werkzeug=True, use_reloader=True)

