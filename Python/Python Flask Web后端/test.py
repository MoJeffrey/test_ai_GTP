from flask import Flask, render_template, request, jsonify
from flask_socketio import SocketIO, send, emit

app = Flask(__name__)
socketio = SocketIO(app)
socketio.init_app(app, cors_allowed_origins='*')

name_space = '/dcenter'


@socketio.on('connect', namespace=name_space)
def connected_msg():
    print('client connected.')


if __name__ == '__main__':
    # 启动应用程序并配置WebSocket
    socketio.run(app, debug=True, log_output=True, allow_unsafe_werkzeug=True, use_reloader=True)
