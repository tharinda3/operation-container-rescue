from flask import Flask, request, jsonify, render_template
import json
import os
from datetime import datetime, timezone

app = Flask(__name__)
DATA_FILE = '/data/progress.json'

def load_data():
    if os.path.exists(DATA_FILE):
        with open(DATA_FILE) as f:
            return json.load(f)
    return {"start_time": None, "challenges": {}}

def save_data(data):
    os.makedirs('/data', exist_ok=True)
    with open(DATA_FILE, 'w') as f:
        json.dump(data, f, indent=2)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/status')
def status():
    return jsonify(load_data())

@app.route('/api/complete', methods=['POST'])
def complete():
    body = request.get_json()
    data = load_data()
    now = datetime.now(timezone.utc).isoformat()

    if not data['start_time']:
        data['start_time'] = now

    challenge_id = str(body.get('challenge'))

    if challenge_id not in data['challenges']:
        data['challenges'][challenge_id] = {
            "completed_at": now,
            "flag": body.get('flag', ''),
            "metrics": body.get('metrics', {})
        }
        save_data(data)

    return jsonify({"status": "ok"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9000)
