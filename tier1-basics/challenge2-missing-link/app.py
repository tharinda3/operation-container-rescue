import os
import base64
from flask import Flask

app = Flask(__name__)

DATABASE_URL = os.environ.get('DATABASE_URL')
if not DATABASE_URL:
    raise ValueError("DATABASE_URL environment variable is required!")

@app.route('/')
def hello():
    flag = base64.b64decode("RkxBR3tFTlZfVkFSX1YxUlRVTzVPfQ==").decode()
    return f"Connected to: {DATABASE_URL} - {flag}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
