from flask import Flask, jsonify
import aws_dynamodb_conn
import os 
import markdown

app = Flask(__name__)

@app.route('/')
def index():
    OSINFO=os.uname()
    TEXT=f"#simple-webapp running on EC2 @ **{OSINFO.nodename}**"
    return markdown.markdown(TEXT)

@app.route('/get-items')
def get_items():
    return jsonify(aws_dynamodb_conn.get_items())


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(9090))
