import os
from flask import Flask, jsonify
import psycopg2

app = Flask(__name__)

# This will fail if DB isn't ready!
def init_db():
    conn = psycopg2.connect(os.environ['DATABASE_URL'])
    cur = conn.cursor()
    cur.execute("SELECT 1")
    conn.close()
    return True

@app.route('/health')
def health():
    return jsonify({
        "status": "healthy",
        "message": "App started successfully with DB ready!",
        "flag": "FLAG{H34LTHY_ST4RTUP}"
    })

if __name__ == '__main__':
    print("Connecting to database...")
    init_db()  # This crashes if DB not ready
    print("Database connected!")
    app.run(host='0.0.0.0', port=5000)
