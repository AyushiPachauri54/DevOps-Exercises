from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/about', methods=['GET'])
def about():
    return jsonify({
        "name": "Simple REST API",
        "version": "1.0",
        "description": "This is a simple REST API built with Flask."
    })

if __name__ == '__main__':
    # host=0.0.0.0 is REQUIRED, otherwise -p 5001:5001 cannot reach the app from the host
    app.run(host='0.0.0.0', debug=False, port=5001)
