from flask import Flask, jsonify, request
from utilities import predict_pipeline
import os

app = Flask(__name__)

@app.route('/')
def index():
    welcome_msg = os.environ.get("WELCOME_MESSAGE")
    with open('data/index_message.txt', 'r') as file:
        content = file.read()
    return f"{welcome_msg}:{content}"

@app.post('/predict')
def predict():
    data = request.json
    try:
        sample = data['text']
    except KeyError:
        return jsonify({'error': 'No text sent'})

    sample = [sample]
    predictions = predict_pipeline(sample)
    try:
        result = jsonify(predictions[0])
    except TypeError as e:
        result = jsonify({'error': str(e)})
    return result

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)