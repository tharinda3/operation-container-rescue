import os
from flask import Flask

app = Flask(__name__)

# App requires DATABASE_URL to be set
DATABASE_URL = os.environ.get('DATABASE_URL')
if not DATABASE_URL:
    raise ValueError("DATABASE_URL environment variable is required!")

@app.route('/')
def hello():
    return f"Connected to: {DATABASE_URL} - FLAG{{ENV_VAR_V1RTUO5O}}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
