from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return 'Welcome! Index page!'

@app.route('/hello')
def hello():
    return 'MyApp!'

@app.route('/func')
def func():
    return 'MyFunction!'

# appの実行
if __name__ == "__main__":
    app.run()