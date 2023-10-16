from flask import Flask, render_template
from sys import argv

PORT = argv[1] if len(argv) > 1 else 3000

app = Flask(__name__, static_url_path="/assets/")

@app.route("/")
def index():
  return render_template("index.html")

@app.route("/details")
def details():
  data = [
    ['Python', 'https://wiki.python.org/moin/BeginnersGuide', 'https://www.python.org/static/img/python-logo-large.png'],
    ['HTMX', 'https://htmx.org/docs', 'https://htmx.org/img/htmx_logo.2.png'],
    ['Flask', 'https://flask.palletsprojects.com/', 'https://flask.palletsprojects.com/_static/shortcut-icon.png'],
    ["Jinja", "https://jinja.palletsprojects.com/","https://jinja.palletsprojects.com/_static/jinja-logo-sidebar.png"]
  ]

  return render_template("details.html", data=data)

if __name__ == '__main__':
  app.run(host='0.0.0.0', port=PORT)