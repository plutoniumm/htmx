from flask import Flask, render_template, send_file, request, send_from_directory
from datetime import datetime
from sys import argv

PORT = argv[1] if len(argv) > 1 else 3000

app = Flask(__name__)

@app.route("/")
def index():
  return send_file("index.html")

@app.route("/assets/<path:path>")
def assets(path):
  return send_from_directory("assets", path)

@app.route("/details")
def details():
  data = [
    ['Python', 'https://wiki.python.org/moin/BeginnersGuide', 'https://www.python.org/static/img/python-logo-large.png'],
    ['HTMX', 'https://htmx.org/docs', 'https://htmx.org/img/htmx_logo.2.png'],
    ['Flask', 'https://flask.palletsprojects.com/', 'https://flask.palletsprojects.com/_static/shortcut-icon.png'],
    ["Jinja", "https://jinja.palletsprojects.com/","https://jinja.palletsprojects.com/_static/jinja-logo-sidebar.png"]
  ]

  ua = request.headers.get('User-Agent')
  dt = datetime.now().strftime('%A, %d %B')

  return render_template(
    "details.html",
    data=data,
    datetime=dt,
    browser=ua
  )

if __name__ == '__main__':
  app.run(host='0.0.0.0', port=PORT)