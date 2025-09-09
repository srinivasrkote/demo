# from flask import Flask,jsonify

# app = Flask(__name__)

# @app.get('/api/hello')
# def demo():
#     return jsonify(tech="devops",branch="develop",msg="hello from devops team 1")

# if __name__ == '__main__':
#     app.run(host="0.0.0.0", port=5000, debug=True)



# print("hello mysore")


# from flask import Flask
# from PIL import Image

# app = Flask(__name__)

# @app.route('/a')
# def hello():
#     img = Image.new('RGB', (60, 30), color = 'red')
#     return "Image created!"

# if __name__ == '__main__':
#     app.run(host='0.0.0.0')


# app.py
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello Mysore,karnataka,571114!,India,asia"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001)
