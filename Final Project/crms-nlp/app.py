#!flask/bin/python
from flask import Flask, jsonify
from flask import request
import auto_classification.pmethod as classifier
import auto_tagging.tag as tag
import summarization.summarization as summarizer
app = Flask(__name__)




@app.route('/todo/api/classification/label', methods=['GET'])
def get_label():
    result = [
        {
            'label': 'sport'
        }
    ]
    return jsonify({'tasks': result})

@app.route('/nlp/classify', methods=['POST'])
def classify_document():
    if not request.json or not 'content' in request.json:
        print("there is no content.")
    print(request.json['content'])
    results= classifier.predict(request.json['content'])
    return results


@app.route('/nlp/tag', methods=['POST'])
def tag_document():
    if not request.json or not 'content' in request.json:
        print("there is no content.")
    print(request.json['content'])

    results2 = tag.tagger(request.json['content'])
    return results2


@app.route('/nlp/summarize', methods=['POST'])
def summarize():
    if not request.json or not 'content' in request.json:
        print("there is no content.")
    print(request.json['content'])
    result = summarizer.do_summarize(request.json['content'])
    return result


if __name__ == '__main__':
    app.run(debug=True)
