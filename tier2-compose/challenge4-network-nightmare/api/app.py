import os
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/health')
def health():
    db_host = os.environ.get('DB_HOST', 'unknown')
    return jsonify({
        "status": "healthy",
        "db_host": db_host,
        "flag": "FLAG{N3TW0RK_WIZAR8RY}"
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000)
