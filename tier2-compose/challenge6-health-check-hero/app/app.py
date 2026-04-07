import os
import base64
from flask import Flask, jsonify
import psycopg2

app = Flask(__name__)

def init_db():
    conn = psycopg2.connect(os.environ['DATABASE_URL'])
    cur = conn.cursor()
    cur.execute("SELECT 1")
    conn.close()
    return True

@app.route('/health')
def health():
    flag = base64.b64decode("RkxBR3tIMzRMVEhZX1NUNFJUVVB9").decode()
    return jsonify({
        "status": "healthy",
        "message": "App started successfully with DB ready!",
        "flag": flag
    })

if __name__ == '__main__':
    print("Connecting to database...")
    init_db()
    print("Database connected!")
    app.run(host='0.0.0.0', port=5000)
