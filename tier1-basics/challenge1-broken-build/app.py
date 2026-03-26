from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return "Container rescued! FLAG{DOCK3R_BU1LD_M4ST3R}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
