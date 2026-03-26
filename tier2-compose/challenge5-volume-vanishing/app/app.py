import os
import time
from flask import Flask, jsonify
import psycopg2

app = Flask(__name__)

def get_db():
    return psycopg2.connect(os.environ['DATABASE_URL'])

@app.route('/flag')
def get_flag():
    try:
        conn = get_db()
        cur = conn.cursor()
        cur.execute("SELECT value FROM flags LIMIT 1")
        row = cur.fetchone()
        conn.close()
        if row:
            return jsonify({"flag": row[0]})
        return jsonify({"error": "No flag found! Did data persist?"})
    except Exception as e:
        return jsonify({"error": str(e)})

if __name__ == '__main__':
    time.sleep(5)  # Wait for DB
    app.run(host='0.0.0.0', port=5000)
