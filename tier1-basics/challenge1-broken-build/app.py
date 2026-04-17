import base64
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    flag = base64.b64decode("RkxBR3tET0NLM1JfQlUxTERfTTRTVDNSfQ==").decode()
    return f"Container rescued! {flag}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
