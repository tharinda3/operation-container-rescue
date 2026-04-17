import os
import base64
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/health')
def health():
    db_host = os.environ.get('DB_HOST', 'unknown')
    flag = base64.b64decode("RkxBR3tOM1RXMFJLX1dJWkFSOFJZfQ==").decode()
    return jsonify({
        "status": "healthy",
        "db_host": db_host,
        "flag": flag
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000)
